> HTML 页面: [[page/wiki/data/后端应用/Java实现负载均衡.html|打开 HTML 页面]]

```java
package com.tineco.pyne.application.util;

import java.util.Comparator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @date: 2025/6/4 16:43
 */
public class LLMLoadBalancer {
    // 记录每个LLM的当前请求数和平均响应时间
    private static final Map<String, LLMNode> llmNodes = new ConcurrentHashMap<>();
    private static final String[] llmIds = {"deepseek_r1", "doubao_thinking", "o4_mini"};

    static {
        // 初始化节点
        for (String id : llmIds) {
            llmNodes.put(id, new LLMNode(id));
        }
    }

    // 内部类记录节点状态
    private static class LLMNode {
        String id;
        AtomicInteger activeRequests = new AtomicInteger(0);
        long totalResponseTime;
        int requestCount;

        public LLMNode(String id) {
            this.id = id;
        }

        public double getAvgResponseTime() {
            return requestCount == 0 ? 0 : (double) totalResponseTime / requestCount;
        }
    }

    // 选择最空闲的LLM（接收请求数 * 平均响应时间 = 总响应时间）
    public static String selectIdleLLM() {
        return llmNodes.values().stream()
                .min(Comparator.comparingDouble(node ->
                        node.totalResponseTime
                ))
                .map(node -> node.id)
                .orElse("deepseek_r1"); // 兜底
    }


    // 记录请求开始
    public static void startRequest(String llmId) {
        LLMNode node = llmNodes.get(llmId);
        if (node != null) {
            node.activeRequests.incrementAndGet();
        }
    }

    // 记录请求完成
    public static void endRequest(String llmId, long responseTime) {
        LLMNode node = llmNodes.get(llmId);
        if (node != null) {
            node.activeRequests.decrementAndGet();
            node.totalResponseTime += responseTime;
            node.requestCount++;
        }
    }
}


```

### 调用示例
```java
public static String chatOBM(String productName, String contentType, String content,
                            String company, String user, String channel, String sn) {
    String result = "";
    String url = ConfigCacheManager.getConfigValue(ConfigConstants.agent_function_chatMessageUrl);
    
    // 动态选择最空闲的LLM
    String selectedLLM = LLMLoadBalancer.selectIdleLLM();
    long startTime = System.currentTimeMillis();

    try {
        Map<String, Object> params = new HashMap<>();
        Map<String, Object> query = new HashMap<>();
        query.put("fault_class", contentType);
        query.put("fault_description", content);
        params.put("query", query);
        params.put("response_mode", "blocking");
        params.put("user", user);
        params.put("llm", selectedLLM); // 添加LLM参数

        Map<String, Object> inputs = new HashMap<>();
        inputs.put("type", "排障");
        inputs.put("product_id", productName);
        inputs.put("organization", company);
        inputs.put("channel", channel);
        inputs.put("sn", sn);
        params.put("inputs", inputs);

        // 记录请求开始
        LLMLoadBalancer.startRequest(selectedLLM);

        HttpHeaders headers = new HttpHeaders();
        MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
        headers.setContentType(type);
        headers.add("Accept", MediaType.APPLICATION_JSON.toString());
        headers.add("Authorization", "Bearer " + ConfigCacheManager.getConfigValue(ConfigConstants.agent_function_obmMroApikey));
        
        HttpEntity<Object> formEntity = new HttpEntity<>(params, headers);
        log.info("调用LLM: {}, 参数: {}", selectedLLM, JSONObject.toJSONString(params));

        ResponseEntity<PineAgentVO> response = restTemplate.postForEntity(url, formEntity, PineAgentVO.class);
        
        if (response != null && response.getBody() != null) {
            result = response.getBody().getAnswer();
        }
    } catch (Exception e) {
        log.error("LLM调用失败: {}", selectedLLM, e);
        throw new BusinessException(e);
    } finally {
        // 记录请求结束和响应时间
        long responseTime = System.currentTimeMillis() - startTime;
        LLMLoadBalancer.endRequest(selectedLLM, responseTime);
    }

    if (result.isEmpty()) {
        throw new BusinessException("LLM调用失败: " + selectedLLM);
    }
    return result;
}

```

