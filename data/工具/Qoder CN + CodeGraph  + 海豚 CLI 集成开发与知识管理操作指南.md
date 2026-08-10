> HTML 页面: [[page/wiki/data/工具/Qoder CN + CodeGraph  + 海豚 CLI 集成开发与知识管理操作指南.html|打开 HTML 页面]]

# CodeGraph
## 一、CodeGraph 简介及环境准备

### 安装 CodeGraph

CodeGraph 是一款**代码图谱构建工具**，通过静态分析技术对项目源码进行解析，生成结构化的代码索引（包括文件、模块、类、函数、变量及其依赖关系），并以图数据库或JSON格式存储。它主要解决以下问题：

- **快速检索**：在大型代码库中快速定位符号定义、引用关系。
    
- **依赖分析**：清晰展示模块间耦合度，辅助架构决策。
    
- **安装命令**：npm install -g @colbymchenry/codegraph
    

### 项目结构约定

整体项目根目录下，包含两个独立子项目：

- `frontend/` —— 前端项目
    
- `backend/` —— 后端项目
    

### 优先使用 codegraph 的场景

- **理解一个类/方法的上下游关系** — 比如查 `RevSystemFeature` 时，能一次性看到谁引用了它、它调用了谁、继承链是什么
    
- **修改前的影响分析** — 新增/修改字段后，快速确认哪些 Service、Controller、Mapper 需要同步改动
    
- **探索不熟悉的代码区域** — 用自然语言描述问题，一次调用就能拿到相关符号的源码和调用关系，比多次 `Grep` + `Read` 更高效
    

### 典型工作流

先用 `codegraph_explore` 了解目标模块的整体结构和关联 如果需要精确匹配某个字符串模式，再用 `Grep` 补充 如果需要看 codegraph 未覆盖的内容（如 XML 配置、SQL 脚本），再用 `Read`/`Glob`

### 与 Grep/Read 的分工

---

## 二、CodeGraph 初始化（分三次执行）及 Qoder CN MCP 服务配置

1. 为建立完整的代码索引，需在三个不同层级分别执行初始化：
    

> ⚠️ **注意**：三次初始化需等待每次完成后再执行下一次，确保索引文件正确生成。

2. Qoder CN MCP 服务增加 codegraph，Qoder 设置 -> MCP 服务 -> 添加
    

{"mcpServers":{"codegraph":{"command":"codegraph","args":["serve","--mcp"],"env":{}}}}

![[data/工具/md-img/image 7.png]]

3. 测试是否配置成功，点击小铃铛快速体验
    
![[image 7 1.png]]


---

## 三、Qoder CN 知识体系生成（自动生成）

### Repo Wiki（项目结构化文档）

- **触发方式**：在 CodeGraph 索引完成后，在 Qoder 点击自动生成 Repo Wiki。
    
- **功能**：为项目生成层级清晰的技术文档（架构、模块说明、接口概览等），并持续跟踪代码变更，自动更新文档。
    
- **价值**：在后续开发提问（如“解释某模块逻辑”、“新增功能时如何影响现有结构”）时，Qoder 可结合 Wiki 与实时上下文，提供精准、可溯源的回答。
    

![[data/工具/md-img/image 2.png]]

⚠️ **注意**：团队协作，同一项目可采用 Git 同步的方式管理 Repo Wiki，避免重复生成，节省 tocken。

### 知识卡片（高密度知识单元）

- **同步生成**：与 Repo Wiki 同时产出，以 Agent 友好格式（如 JSON/YAML）存储。
    
- **内容**：提炼架构决策、代码规约（Spec）、技术栈清单、关键接口定义等。
    
- **持续更新**：每次 commit 后自动追踪变更，保持知识卡片与实际代码一致，确保智能体快速消费最新信息。
    
![[data/工具/md-img/image 9.png]]


### 记忆功能（长期协作增强）

- Qoder 会逐步构建个人、项目及问题域的记忆库。
    
- 随着交互次数增加，记忆自动整理、去重、关联，使 Qoder 更理解开发者的编码习惯、项目演进历史及常见问题场景。
    
- 长期使用后，回答更贴合实际需求，减少重复解释，提升协作效率。
    

![[image 9 1.png]]

---

## 四、CLI 命令行 获取海豚【系统功能方案】Coding

本流程用于将海豚系统功能方案通过命令行工具引入，并结合 Qoder 记忆与 AI Coding 能力实现高效开发。

1. 安装 scsd 命令行工具 ，在本地终端执行：npm install -g scsd@1.0.1 --registry [http://10.108.248.15:4873/](http://10.108.248.15:4873/)
    

![[data/工具/md-img/image 5.png]]

2. 训练 Qoder 识别 scsd 命令行，利用 Qoder 的**记忆功能**，通过对话告知 Qoder 关于 `scsd` 的用途、参数格式和常见用法，经过 1~2 次交互，Qoder 会将此知识写入长期记忆，后续可直接引用。以下是训练过程，仅供参考。
    

![[data/工具/md-img/image 1.png]]

![[data/工具/md-img/image 6.png]]

3. 使用 scsd 命令行获取【系统功能方案】
    

![[data/工具/md-img/image 3.png]]

![[data/工具/md-img/image 4.png]]

5. 人工纠偏守门（关键步骤），获取方案后，由开发人工审核，确认业务逻辑、数据模型、接口定义等无误，必要时调整方案文件中的字段或补充说明，确保其准确反映真实需求。
    
6. 用于 AI Coding，Qoder 会结合已有代码索引、Repo Wiki、知识卡片以及记忆中的知识，自动生成符合规范的代码，开发者对生成代码进行 review 和微调后，即可提交。
    

---

## 五、重要注意事项

![[data/工具/md-img/image 8.png]]

---

## 六、推荐工作流（快速上手）

1. 安装 CodeGraph
    
2. 按顺序三次初始化（前端 → 后端 → 根目录）
    
3. 等待代码库索引构建完成
    
4. 自动生成 Wiki & 知识卡片
    
5. 安装 scsd 并训练 Qoder CN 记忆
    
6. 获取并人工审核系统功能方案
    
7. 日常开发中结合 Qoder CN 提问与 AI Coding，记忆自动积累
    
8. 定期检查 Wiki 更新状态，确保文档与代码同步
    

⚠️ **注意**：第一次使用需要按以上流程操作，第二次及以后只需在 Qoder CN 上重复 6、7、8 即可。

---

*本指南适用于使用 Qoder CN 的团队，可根据实际项目结构调整，如有疑问，以 Qoder 官方文档解释为准，链接：[https://docs.qoder.com/zh/user-guide/knowledge-engine/overview](https://docs.qoder.com/zh/user-guide/knowledge-engine/overview)