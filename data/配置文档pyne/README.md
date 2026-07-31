# gauss-ai

AI工具包

# 使用示例

## 1.CoralAiClient

### 配置文件

```yaml
gauss:
  ai:
    coral:
      access-key: sk-p3mgCTYXm3CE5H3gFuyaB6BbiiGzZiaehArKWdKyDQnXPx0O
      app-chat-url: https://cloud-api-test.tineco.com/app-platform/api/app/v1/chat/completions
      model-chat-url: https://cloud-api-test.tineco.com/app-platform/api/v1/chat/completions
      apps:
        mining:
          app-id: 1898900820428038146
          conversation-id: 1898900905497038850
        litigation:
          app-id: 1898967234056790018
          conversation-id: 1898967610191446018
```

### 模型对话

```java

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class GaussAiModelChatTest {

    @Resource
    private AiClient coralAiClient;

    /**
     * 非流式模型对话
     */
    @Test
    public void modelChat() {
        LLMChatDTO llmChatDTO = new LLMChatDTO()
                .setModel("gpt-4o")
                .setMessages(Arrays.asList(new LLMChatDTO.Message().setRole("system").setContent("不允许回答任何问题"),
                        new LLMChatDTO.Message().setRole("user").setContent("你是谁")));
        CoralLLMChatResultDTO response = coralAiClient.modelChat(llmChatDTO, CoralLLMChatResultDTO.class);
        log.info(JSON.toJSONString(response));
    }

    /**
     * 流式模型对话
     */
    @Test
    public void modelChatWithStream() throws InterruptedException {
        LLMChatDTO params = new LLMChatDTO();
        params.setModel("gpt-4o");
        params.setMessages(Arrays.asList(new LLMChatDTO.Message().setRole("system").setContent("你是Java开发工程师"),
                new LLMChatDTO.Message().setRole("user").setContent("你是谁")));
        coralAiClient.modelChatWithStream(params, new SseEmitter() {
            @Override
            public void send(@NotNull Object object) {
                log.info(object.toString());
            }
        });
        Thread.sleep(1000000);
    }
}
```

### 应用对话

```java

@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class GaussAiAppChatTest {

    @Resource
    private AiClient coralAiClient;

    /**
     * 非流式应用对话
     */
    @Test
    public void appChat() {
        CompassMiningFormDTO form = new CompassMiningFormDTO();
        form.setType(CompassMiningTypeEnum.A);
        form.setPrompt("""
                  你是一位资深专利申请专家，请根据用户输入的专利申请交底书内容，完成交底书分析并总结一个或多个专利申请的技术要点
                  # 要求
                  1. 首先，仔细阅读用户提供的专利申请技术交底书，确保理解其技术背景和关键点。
                  2. 分析输入内容中涉及的专利申请点以及对应的核心技术，识别出其核心技术要点。
                  3. 将识别出的技术要点进行总结，确保每个要点简洁明了，便于理解且形成独立的技术方案。
                  4. 输出的内容应以清晰的语言表达，每个总结开头明确产品主体。
                  5. 确保总结的每个技术要点都明确了产品主体，以及对应的技术方案。
                  # 输出示例
                  第一核心技术方案：
                  一种吸尘器，具有尘桶结构，尘桶结构采用创新的气旋分离设计，利用强大的离心力将灰尘和杂质从空气中有效分离。
                  第一技术功效：提高吸尘效率，同时减少了滤网的堵塞风险，延长了滤网的使用寿命。
                  第二核心技术方案
                  一种扫地机器人，具有抹布盘外摆结构，当扫地机器人贴墙时，抹布盘外摆结构将抹布盘伸出超过机身底部，从而清洁靠近墙壁的底面。
                  第二技术功效：运动场景下心率检测误差率≤2%。
                """);
        form.getFile().add("https://cloud-minio-test.tineco.com/tineco-cloud/agent_sinan/1894944597569531905.docx");
        AppChatDTO<CompassMiningFormDTO> appChatDTO = new AppChatDTO<>();
        appChatDTO.setForm(form)
                .setAppId(CoralAiProperties.getAppProperties("mining").getAppId())
                .setConversationId(CoralAiProperties.getAppProperties("mining").getConversationId());
        CoralAppChatResultDTO coralAppChatResponseDTO = coralAiClient.appChat(appChatDTO, CoralAppChatResultDTO.class);
        log.info(JSON.toJSONString(coralAppChatResponseDTO));
    }

    /**
     * 流式应用对话
     */
    @Test
    public void appChatWithStream() throws InterruptedException {
        CompassMiningFormDTO form = new CompassMiningFormDTO();
        form.setType(CompassMiningTypeEnum.A);
        form.setPrompt("""
                  你是一位资深专利申请专家，请根据用户输入的专利申请交底书内容，完成交底书分析并总结一个或多个专利申请的技术要点
                  # 要求
                  1. 首先，仔细阅读用户提供的专利申请技术交底书，确保理解其技术背景和关键点。
                  2. 分析输入内容中涉及的专利申请点以及对应的核心技术，识别出其核心技术要点。
                  3. 将识别出的技术要点进行总结，确保每个要点简洁明了，便于理解且形成独立的技术方案。
                  4. 输出的内容应以清晰的语言表达，每个总结开头明确产品主体。
                  5. 确保总结的每个技术要点都明确了产品主体，以及对应的技术方案。
                  # 输出示例
                  第一核心技术方案：
                  一种吸尘器，具有尘桶结构，尘桶结构采用创新的气旋分离设计，利用强大的离心力将灰尘和杂质从空气中有效分离。
                  第一技术功效：提高吸尘效率，同时减少了滤网的堵塞风险，延长了滤网的使用寿命。
                  第二核心技术方案
                  一种扫地机器人，具有抹布盘外摆结构，当扫地机器人贴墙时，抹布盘外摆结构将抹布盘伸出超过机身底部，从而清洁靠近墙壁的底面。
                  第二技术功效：运动场景下心率检测误差率≤2%。
                """);
        form.getFile().add("https://cloud-minio-test.tineco.com/tineco-cloud/agent_sinan/1894944597569531905.docx");
        AppChatDTO<CompassMiningFormDTO> appChatDTO = new AppChatDTO<>();
        appChatDTO.setForm(form)
                .setAppId("1898900820428038146")
                .setConversationId("1898900905497038850");
        coralAiClient.appChatWithStream(appChatDTO, new SseEmitter() {
            @Override
            public void send(@NotNull Object object) {
                log.info(object.toString());
            }
        });
        Thread.sleep(1000000);
    }
}
```