# MCP



## 一、MCP 概述



MCP (Model Context Protocol)是一种开放标准协议，旨在为大语言模型（LLM）提供标准化的外部工具和上下文集成方式。借助 MCP 标准化接口的支持，通义灵码能够灵活扩展与不同数据源或外部系统的连接，使其智能体的能力和场景得到拓展，有效满足用户对于个性化扩展的诉求。

您可以选择连接现有的MCP服务或自行开发专属的 MCP 服务，例如魔搭社区 MCP 市场、Higress MCP 市场等热门市场，已经提供了丰富的 MCP 服务，您可以自行探索发现更多符合您需求的解决方案，加速项目开发与创新。

| **热门 MCP 市场**                                            | **热门场景**                                                 |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [魔搭社区 MCP 市场](https://www.modelscope.cn/mcp)：魔搭社区上架千余款热门的MCP服务，包括支付宝、MiniMax等全新 MCP服务，为AI开发者提供丰富的 MCP 服务及调试工具。[Higress MCP 市场](https://mcp.higress.ai/)：Higress MCP 市场目前已上架多款热门 MCP 服务。 | **数据库：**自动获取数据库中 schemas，生成DAO代码或完成数据查询等。**在线文档：**基于在线文档内容，完成代码生成、优化或智能问答。**设计系统：**根据设计系统中的设计稿，生成前端代码，还原前端交互设计。 |

通义灵码支持两种 MCP 服务器通信模式：

- **STDIO 模式(标准输入输出)**：主要用在本地服务上，操作你本地的软件或者本地的文件。
- **SSE 模式**：主要用在远程通信服务上，这个服务本身就有在线的API，比如访问你的谷歌邮件，天气情况等。



场景描述：调用CRM系统API获取客户数据、财务系统API获取本月财务数据报表、SMS系统API发送短信或邮件等



## 二、MCP 调用



### 本地调用



```
{
  "mcpServers": {
    "mcp-demo": {
      "command": "java",
      "args": [
        "-jar",
        "E:\\ai-project\\mcp-demo\\target\\mcp-demo-0.0.1-SNAPSHOT.jar"
      ]
    }
  }
}
```



### 远程调用



```
{
  "mcpServers": {
    "howtocook-mcp": {
      "type": "streamable_http",
      "url": "https://mcp.api-inference.modelscope.net/cddb132cb30d4d/mcp"
    }
  }
}
```



https://docs.spring.io/spring-ai/reference/api/mcp/mcp-annotations-server.html