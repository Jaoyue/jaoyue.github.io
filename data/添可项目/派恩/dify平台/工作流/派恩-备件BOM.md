> HTML 页面: [[page/wiki/data/添可项目/派恩/dify平台/工作流/派恩-备件BOM.html|打开 HTML 页面]]

```yaml
app:
  description: 售后维修智能体搭建备件BOM业务
  icon: 🤖
  icon_background: '#FFEAD5'
  mode: advanced-chat
  name: 派恩-备件BOM
  use_icon_as_answer_icon: true
kind: app
version: 0.1.5
workflow:
  conversation_variables:
  - description: 存储bom
    id: 208b2be0-eb90-407f-b8d7-c82ae74d5aac
    name: bom_text
    selector:
    - conversation
    - bom_text
    value: ''
    value_type: string
  - description: 备件名称内容
    id: 63e7a407-c7e8-4746-afb9-b19dc9106011
    name: spare_doc_content
    selector:
    - conversation
    - spare_doc_content
    value: []
    value_type: array[object]
  - description: '备件名称文档id

      '
    id: baf8be00-fe29-4b26-9794-a16a1c7a6e94
    name: spare_doc_id
    selector:
    - conversation
    - spare_doc_id
    value: ''
    value_type: string
  - description: 备件名称
    id: f221860e-1198-4e08-a59f-847f75a18f56
    name: spare_parts_name
    selector:
    - conversation
    - spare_parts_name
    value: ''
    value_type: string
  environment_variables:
  - description: ''
    id: bfff4584-5b5f-42cb-a18e-1347f6827046
    name: dify_url
    selector:
    - env
    - dify_url
    value: http://10.108.128.149/v1
    value_type: secret
  - description: ''
    id: bb7cd5d3-9983-4423-b7d3-020b971f37a5
    name: zsk_api_key
    selector:
    - env
    - zsk_api_key
    value: dataset-xPTsphrCBO0LHBf0DQwWDBO2
    value_type: secret
  features:
    file_upload:
      allowed_file_extensions: []
      allowed_file_types:
      - image
      allowed_file_upload_methods:
      - remote_url
      - local_file
      enabled: true
      fileUploadConfig:
        audio_file_size_limit: 50
        batch_count_limit: 5
        file_size_limit: 15
        image_file_size_limit: 10
        video_file_size_limit: 100
        workflow_file_upload_limit: 10
      image:
        enabled: false
        number_limits: 3
        transfer_methods:
        - local_file
        - remote_url
      number_limits: 1
    opening_statement: ''
    retriever_resource:
      enabled: true
    sensitive_word_avoidance:
      enabled: false
    speech_to_text:
      enabled: false
    suggested_questions: []
    suggested_questions_after_answer:
      enabled: false
    text_to_speech:
      enabled: false
      language: ''
      voice: ''
  graph:
    edges:
    - data:
        isInIteration: false
        sourceType: llm
        targetType: answer
      id: 1742355270513-source-1742371588232-target
      selected: false
      source: '1742355270513'
      sourceHandle: source
      target: '1742371588232'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: llm
        targetType: answer
      id: 17425515144900-source-1742348617008-target
      selected: false
      source: '17425515144900'
      sourceHandle: source
      target: '1742348617008'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: http-request
        targetType: code
      id: 1743405164690-source-1743406224507-target
      source: '1743405164690'
      sourceHandle: source
      target: '1743406224507'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: http-request
        targetType: code
      id: 1743468388933-source-1743469149899-target
      source: '1743468388933'
      sourceHandle: source
      target: '1743469149899'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: if-else
        targetType: llm
      id: 17434713154690-d51d441c-ffc1-49f2-af62-b70fd6d1e77a-1742355270513-target
      source: '17434713154690'
      sourceHandle: d51d441c-ffc1-49f2-af62-b70fd6d1e77a
      target: '1742355270513'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: if-else
        targetType: llm
      id: 17434713154690-true-17425515144900-target
      source: '17434713154690'
      sourceHandle: 'true'
      target: '17425515144900'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: assigner
      id: 1743469149899-source-1743472155405-target
      source: '1743469149899'
      sourceHandle: source
      target: '1743472155405'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: assigner
        targetType: if-else
      id: 1743472155405-source-17434713154690-target
      source: '1743472155405'
      sourceHandle: source
      target: '17434713154690'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: start
        targetType: document-extractor
      id: 1740030778508-source-1742280495560-target
      source: '1740030778508'
      sourceHandle: source
      target: '1742280495560'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: document-extractor
        targetType: http-request
      id: 1742280495560-source-1744883112675-target
      source: '1742280495560'
      sourceHandle: source
      target: '1744883112675'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: http-request
        targetType: code
      id: 1744883112675-source-1744883238803-target
      source: '1744883112675'
      sourceHandle: source
      target: '1744883238803'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: http-request
      id: 1744883238803-source-1743405164690-target
      source: '1744883238803'
      sourceHandle: source
      target: '1743405164690'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: http-request
      id: 1743406224507-source-1743468388933-target
      source: '1743406224507'
      sourceHandle: source
      target: '1743468388933'
      targetHandle: target
      type: custom
      zIndex: 0
    nodes:
    - data:
        desc: ''
        selected: false
        title: 开始
        type: start
        variables:
        - allowed_file_extensions: []
          allowed_file_types:
          - document
          allowed_file_upload_methods:
          - local_file
          label: 处理后的研发bom
          max_length: 48
          options: []
          required: true
          type: file
          variable: bom
        - label: organization
          max_length: 48
          options:
          - ecovacs
          - tineco
          required: true
          type: select
          variable: organization
      height: 115
      id: '1740030778508'
      position:
        x: 30
        y: 309
      positionAbsolute:
        x: 30
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        desc: ''
        is_array_file: false
        selected: false
        title: 提取bom
        type: document-extractor
        variable_selector:
        - '1740030778508'
        - bom
      height: 91
      id: '1742280495560'
      position:
        x: 334
        y: 309
      positionAbsolute:
        x: 334
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        answer: '{{#17425515144900.text#}}'
        desc: ''
        selected: false
        title: 直接回复
        type: answer
        variables: []
      height: 102
      id: '1742348617008'
      position:
        x: 3374
        y: 450
      positionAbsolute:
        x: 3374
        y: 450
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        context:
          enabled: true
          variable_selector:
          - conversation
          - spare_doc_content
        desc: ''
        memory:
          query_prompt_template: '{{#sys.query#}}'
          role_prefix:
            assistant: ''
            user: ''
          window:
            enabled: true
            size: 50
        model:
          completion_params:
            temperature: 0.1
          mode: chat
          name: claude-3-7-sonnet
          provider: openai_api_compatible
        prompt_template:
        - id: 41c85a0c-c745-4694-8fc6-c7fa338e9104
          role: system
          text: '你是一个资深数据分析大师，需要对研发输出的BOM{{#conversation.bom_text#}}进行分析，挑选出满足要求的行


            上下文中的每一行是存在父子结构关系的，

            某一行的子级定义：从该行开始逐行向下查找，找到”结构层级“和当前行的“结构层级”相同的为止，这两行之间的所有行都是该行的子级

            某一行的父级定义：从该行开始逐行向上找，找到比当前行的”结构层级“小1级的那一行，就是当前行的父级

            '
        - id: 237ec5c8-e538-46c3-9dea-d067665da51f
          role: user
          text: "挑选要求  \n1. 如果当前行的名称在 {{#context#}}中能找出相似的，相似度达到80%，就将该行挑出来\n2. 如果挑选出了“名称”是\
            \ “机身组件”，“地刷组件”， 要判断“结构层级”是否是2，如果是2，要删除该条，要从其子级中挑选\n3. 易损件与耗材 要挑出来，不需要挑选其子级\n\
            4. 结构层级是2和3的，分类除了螺丝、原材料，名称在{{#context#}}中能找出相似度达到50%的都挑出来\n5. 对上下文逐行进行挑选，不能有遗漏，满足上面4个条件中任一一条都需要挑出来\n\
            6. 挑选出的结果不少于100行\n7. 转接头、电池包、电机、主控板、电源板只取一个组件，不要拆到子级\n\n输出要求\n1. 挑选出来的每一行仅保持原表的结构层级，编号，名称属性，增加英文描述属性，对名称进行翻译\n\
            2. 挑出来的数据组成完整的json数组\n3. 输出的内容中除了挑出来的数据之外，不要有其他废话\n4. 重复编号的仅保留一个\n5. 每一行增加一列备件属性，取值\
            \ A,B,C\n A 核心件（主控板、电池包、显示屏、主电机、滚刷电机、适配器）\n B 除A和C外全部为B\n C 塑料件、橡胶件、五金件、包材（外壳类、支架、线束、管道、螺丝、螺母、包材、铭牌、耗材）"
        selected: false
        title: LLM 2
        type: llm
        variables: []
        vision:
          enabled: false
      height: 97
      id: '1742355270513'
      position:
        x: 3070
        y: 309
      positionAbsolute:
        x: 3070
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        answer: '{{#1742355270513.text#}}'
        desc: ''
        selected: false
        title: 直接回复
        type: answer
        variables: []
      height: 102
      id: '1742371588232'
      position:
        x: 3374
        y: 309
      positionAbsolute:
        x: 3374
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        context:
          enabled: true
          variable_selector:
          - conversation
          - spare_doc_content
        desc: ''
        memory:
          query_prompt_template: '{{#sys.query#}}'
          role_prefix:
            assistant: ''
            user: ''
          window:
            enabled: true
            size: 50
        model:
          completion_params:
            temperature: 0.7
          mode: chat
          name: claude-3-7-sonnet
          provider: openai_api_compatible
        prompt_template:
        - id: 41c85a0c-c745-4694-8fc6-c7fa338e9104
          role: system
          text: '你是一个资深数据分析大师，需要对研发输出的BOM{{#conversation.bom_text#}}进行分析，挑选出满足要求的行


            上下文中的每一行是存在父子结构关系的，

            某一行的子级定义：从该行开始逐行向下查找，找到”结构级别“和当前行的“结构级别”相同的为止，这两行之间的所有行都是该行的子级

            某一行的父级定义：从该行开始逐行向上找，找到比当前行的”结构级别“小1级的那一行，就是当前行的父级


            '
        - id: f9ffb5eb-10de-4b84-8466-92fcaaad57c6
          role: user
          text: "挑选要求  \n1. 当前行的采购类型是E的挑出来\n2. 当前行的采购类型是F并且对象指示符是组件的挑出来\n3. 易损件与耗材\
            \ 要挑出来，如：边刷，边刷植毛组件，滚刷，HEPA，滚筒，滤芯，抹布，清洁液，尘袋\n4. 如果当前行的名称在 {{#context#}}中能找出相似的，相似度达到80%，就将该行挑出来，名称一样的一定要挑出来\n\
            5. 当前行的分类字段中包含“线束”，\"主板\",\"锂电池\"的挑出来\n6. 对上下文逐行进行挑选，不能有遗漏，满足上面5个条件中任一一条都需要挑出来\n\
            7. 不少于120行\n\n\n输出要求\n1. 挑选出来的每一行仅保持原表的结构级别，编号，名称属性\n2. 挑出来的数据组成完整的json数组\n\
            3. 输出的内容中除了挑出来的数据之外，不要有其他废话\n4. 重复编号的仅保留一个\n5. 每一行增加一列维修等级，取值 L1~L3\n\
            \ L1，不涉及主机内部拆解维修，如更换充电座、DTOF盖、底座盖等\n L2，拆机维修内部件，如更换边刷电机、驱动轮电机、电池等\n L3，涉及拆机维修，更换内部核心部件，如更换底座、主板、核心板等\n\
            6. 每一行增加一列备件属性，取值 A,B1,B2,C1,C2,D\n A 主板类、DTOF、LDS、核心板、电池\n B1 电机类、小板子类\n\
            \ B2 线束类\n C1 易损件、耗材类\n C2 外部、内部易损注塑件、软管\n D 按需类包材、内部不易损注塑件、配重块、其他辅料"
        selected: false
        title: LLM 1
        type: llm
        variables: []
        vision:
          enabled: false
      height: 97
      id: '17425515144900'
      position:
        x: 3070
        y: 450
      positionAbsolute:
        x: 3070
        y: 450
      selected: true
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        authorization:
          config:
            api_key: '{{#env.zsk_api_key#}}'
            type: bearer
          type: api-key
        body:
          data: []
          type: none
        desc: 获取配件名称知识库中所有文件
        headers: ''
        method: get
        params: ''
        retry_config:
          max_retries: 3
          retry_enabled: true
          retry_interval: 100
        selected: false
        timeout:
          max_connect_timeout: 0
          max_read_timeout: 0
          max_write_timeout: 0
        title: HTTP 请求
        type: http-request
        url: '{{#env.dify_url#}}/datasets/{{#1744883238803.result#}}/documents'
        variables: []
      height: 184
      id: '1743405164690'
      position:
        x: 1246
        y: 309
      positionAbsolute:
        x: 1246
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "\nimport json\n\ndef main(arg1: str, arg2: str) -> dict:\n    arg1\
          \ = json.loads(arg1)\n    document_id = None\n    for doc in arg1[\"data\"\
          ]:\n        if arg2 == 'ecovacs' and '科沃斯备件名称' in doc[\"name\"]:\n     \
          \       document_id = doc[\"id\"]\n            break\n        if arg2 ==\
          \ 'tineco' and '添可备件名称' in doc[\"name\"]:\n            document_id = doc[\"\
          id\"]\n            break\n    \n    return {\n        \"result\": document_id\n\
          \    }\n"
        code_language: python3
        desc: 获取备件文档id
        outputs:
          result:
            children: null
            type: string
        selected: false
        title: 代码执行-获取备件文档id
        type: code
        variables:
        - value_selector:
          - '1743405164690'
          - body
          variable: arg1
        - value_selector:
          - '1740030778508'
          - organization
          variable: arg2
      height: 81
      id: '1743406224507'
      position:
        x: 1550
        y: 309
      positionAbsolute:
        x: 1550
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        authorization:
          config:
            api_key: '{{#env.zsk_api_key#}}'
            type: bearer
          type: api-key
        body:
          data: []
          type: none
        desc: 获取备件名称文档内容
        headers: Content-Type:application/json
        method: get
        params: ''
        retry_config:
          max_retries: 3
          retry_enabled: true
          retry_interval: 100
        selected: false
        timeout:
          max_connect_timeout: 0
          max_read_timeout: 0
          max_write_timeout: 0
        title: HTTP 请求 2
        type: http-request
        url: '{{#env.dify_url#}}/datasets/{{#1744883238803.result#}}/documents/{{#1743406224507.result#}}/segments'
        variables: []
      height: 219
      id: '1743468388933'
      position:
        x: 1854
        y: 309
      positionAbsolute:
        x: 1854
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "import json\n\ndef main(arg1: str) -> dict:\n    arg1 = json.loads(arg1)\n\
          \    return {\n        \"result\": arg1[\"data\"],\n    }\n"
        code_language: python3
        desc: 获取备件名称内容
        outputs:
          result:
            children: null
            type: array[object]
        selected: false
        title: 代码执行-获取备件名称内容
        type: code
        variables:
        - value_selector:
          - '1743468388933'
          - body
          variable: arg1
      height: 81
      id: '1743469149899'
      position:
        x: 2158
        y: 309
      positionAbsolute:
        x: 2158
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        cases:
        - case_id: 'true'
          conditions:
          - comparison_operator: is
            id: 08220d5b-4584-4c19-a0e7-5a16fb88cf86
            value: ecovacs
            varType: string
            variable_selector:
            - '1740030778508'
            - organization
          id: 'true'
          logical_operator: and
        - case_id: d51d441c-ffc1-49f2-af62-b70fd6d1e77a
          conditions:
          - comparison_operator: is
            id: d46e5592-f36a-434e-820e-f3b729e36fdb
            value: tineco
            varType: string
            variable_selector:
            - '1740030778508'
            - organization
          id: d51d441c-ffc1-49f2-af62-b70fd6d1e77a
          logical_operator: and
        desc: ''
        selected: false
        title: 判断公司名称 (1)
        type: if-else
      height: 173
      id: '17434713154690'
      position:
        x: 2766
        y: 309
      positionAbsolute:
        x: 2766
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        desc: ''
        items:
        - input_type: variable
          operation: over-write
          value:
          - '1743469149899'
          - result
          variable_selector:
          - conversation
          - spare_doc_content
          write_mode: over-write
        - input_type: variable
          operation: over-write
          value:
          - '1742280495560'
          - text
          variable_selector:
          - conversation
          - bom_text
          write_mode: over-write
        selected: false
        title: 变量赋值-备件名称内容+bom
        type: assigner
        version: '2'
      height: 115
      id: '1743472155405'
      position:
        x: 2462
        y: 309
      positionAbsolute:
        x: 2462
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        authorization:
          config:
            api_key: '{{#env.zsk_api_key#}}'
            type: bearer
          type: api-key
        body:
          data: []
          type: none
        desc: ''
        headers: ''
        method: get
        params: 'page:1

          limit:1000'
        retry_config:
          max_retries: 3
          retry_enabled: true
          retry_interval: 100
        selected: false
        timeout:
          max_connect_timeout: 0
          max_read_timeout: 0
          max_write_timeout: 0
        title: 获取知识库列表
        type: http-request
        url: '{{#env.dify_url#}}/datasets?page=1&limit=1000'
        variables: []
      height: 138
      id: '1744883112675'
      position:
        x: 638
        y: 309
      positionAbsolute:
        x: 638
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "\nimport json\n\ndef main(arg1: str) -> dict:\n    arg1 = json.loads(arg1)\n\
          \n    spare_name_datasets_id = None\n    spare_name_datasets_name = '配件名称'\n\
          \    for sets in arg1[\"data\"]:\n        if spare_name_datasets_name ==\
          \ sets[\"name\"]:\n            spare_name_datasets_id = sets[\"id\"]\n \
          \           break\n\n    return {\n        \"result\": spare_name_datasets_id\n\
          \    }\n"
        code_language: python3
        desc: ''
        outputs:
          result:
            children: null
            type: string
        selected: false
        title: 获取配件名称知识库ID
        type: code
        variables:
        - value_selector:
          - '1744883112675'
          - body
          variable: arg1
      height: 53
      id: '1744883238803'
      position:
        x: 942
        y: 309
      positionAbsolute:
        x: 942
        y: 309
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    viewport:
      x: -326.7081974582429
      y: 8.190499312919428
      zoom: 0.659753955386447

```

