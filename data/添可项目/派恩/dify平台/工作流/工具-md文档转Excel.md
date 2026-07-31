> HTML 页面: [[page/wiki/data/添可项目/派恩/dify平台/工作流/工具-md文档转Excel.html|打开 HTML 页面]]

```yaml
app:
  description: ''
  icon: 🤖
  icon_background: '#FFEAD5'
  mode: workflow
  name: 工具——提取md文档表格
  use_icon_as_answer_icon: false
kind: app
version: 0.1.5
workflow:
  conversation_variables: []
  environment_variables: []
  features:
    file_upload:
      allowed_file_extensions:
      - .JPG
      - .JPEG
      - .PNG
      - .GIF
      - .WEBP
      - .SVG
      allowed_file_types:
      - image
      allowed_file_upload_methods:
      - local_file
      - remote_url
      enabled: false
      fileUploadConfig:
        audio_file_size_limit: 50
        batch_count_limit: 10
        file_size_limit: 150
        image_file_size_limit: 20
        video_file_size_limit: 100
        workflow_file_upload_limit: 10
      image:
        enabled: false
        number_limits: 3
        transfer_methods:
        - local_file
        - remote_url
      number_limits: 3
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
        sourceType: code
        targetType: if-else
      id: 1743582198116-source-1744870130254-target
      source: '1743582198116'
      sourceHandle: source
      target: '1744870130254'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: start
        targetType: code
      id: 1741831629740-source-17448731884770-target
      source: '1741831629740'
      sourceHandle: source
      target: '17448731884770'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: if-else
      id: 17448731884770-source-1744870130254-target
      source: '17448731884770'
      sourceHandle: source
      target: '1744870130254'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: code
      id: 17448731884770-fail-branch-1743582198116-target
      source: '17448731884770'
      sourceHandle: fail-branch
      target: '1743582198116'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: if-else
        targetType: code
      id: 1744870130254-true-1744880775218-target
      source: '1744870130254'
      sourceHandle: 'true'
      target: '1744880775218'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: end
      id: 1744880775218-source-1743404483287-target
      source: '1744880775218'
      sourceHandle: source
      target: '1743404483287'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: if-else
        targetType: code
      id: 1744870130254-false-1744880784497-target
      source: '1744870130254'
      sourceHandle: 'false'
      target: '1744880784497'
      targetHandle: target
      type: custom
      zIndex: 0
    - data:
        isInIteration: false
        sourceType: code
        targetType: end
      id: 1744880784497-source-17448701669180-target
      source: '1744880784497'
      sourceHandle: source
      target: '17448701669180'
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
        - label: md_file
          max_length: 1000000
          options: []
          required: true
          type: paragraph
          variable: md_file
        - label: 序号（从0开始）
          max_length: 48
          options: []
          required: true
          type: number
          variable: index
        - label: output_type
          max_length: 48
          options:
          - 纯md表格
          - json数组
          required: true
          type: select
          variable: output_type
      height: 142
      id: '1741831629740'
      position:
        x: 30
        y: 271
      positionAbsolute:
        x: 30
        y: 271
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        desc: ''
        outputs:
        - value_selector:
          - '1744880775218'
          - result
          variable: result
        selected: false
        title: 结束
        type: end
      height: 90
      id: '1743404483287'
      position:
        x: 1550
        y: 271
      positionAbsolute:
        x: 1550
        y: 271
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "import re\nimport html\nimport json\n\ndef main(arg1: str, index: int\
          \ = 1) -> dict:\n    \"\"\"\n    从Markdown文本中提取表格，可提取所有表格或指定索引的表格\n    \n\
          \    Args:\n        arg1: Markdown文本\n        table_index: 要提取的表格索引（从0开始），None表示提取所有表格\n\
          \        \n    Returns:\n        包含表格Markdown和JSON数据的字典\n    \"\"\"\n\n\
          \    table_index = index - 1\n    # 使用正则表达式查找所有表格\n    table_pattern = r\"\
          (\\|[^\\n]+\\|\\n\\|[-:\\|\\s]+\\|\\n(?:\\|[^\\n]+\\|\\n)+)\"\n    tables\
          \ = re.findall(table_pattern, arg1)\n    \n    if not tables:\n        return\
          \ {'result': \"\", \"json_table\": []}\n    \n    # 如果指定了table_index，只处理该索引的表格\n\
          \    if table_index is not None:\n        if 0 <= table_index < len(tables):\n\
          \            table_md = tables[table_index]\n            json_data = markdown_table_to_json(table_md)\n\
          \            return {\n                'result': table_md.strip(),\n   \
          \             \"json_table\": json_data\n            }\n        else:\n\
          \            return {'result': f\"错误：表格索引 {table_index} 超出范围，共有 {len(tables)}\
          \ 个表格\", \"json_table\": []}\n    \n    # 提取所有表格\n    all_tables_md = []\n\
          \    all_tables_json = []\n    \n    for table in tables:\n        json_data\
          \ = markdown_table_to_json(table)\n        all_tables_md.append(table.strip())\n\
          \        all_tables_json.append(json_data)\n    \n    return {\n       \
          \ 'result': \"\\n\\n\".join(all_tables_md),\n        \"json_table\": all_tables_json\n\
          \    }\n\ndef markdown_table_to_json(table_md: str) -> list:\n    \"\"\"\
          将Markdown表格转换为JSON数据\"\"\"\n    lines = table_md.strip().split('\\n')\n\
          \    \n    # 提取表头\n    header_line = lines[0]\n    headers = [cell.strip()\
          \ for cell in header_line.split('|')[1:-1]]\n    \n    # 跳过分隔行 (|---|---|)\n\
          \    rows = []\n    for line in lines[2:]:\n        if not line.strip():\n\
          \            continue\n            \n        cells = [cell.strip() for cell\
          \ in line.split('|')[1:-1]]\n        # 确保单元格数与表头数一致\n        while len(cells)\
          \ < len(headers):\n            cells.append('')\n            \n        row_dict\
          \ = dict(zip(headers, cells))\n        rows.append(row_dict)\n    \n   \
          \ return rows\n\ndef extract_nested_tables(text: str) -> str:\n    \"\"\"\
          处理可能的嵌套表格（本实现暂不支持复杂嵌套表格解析）\"\"\"\n    # 由于直接处理Markdown，嵌套表格处理较复杂\n    #\
          \ 这个简化实现仅提取顶层表格\n    return text\n\ndef parse_alignment(separator_line:\
          \ str) -> list:\n    \"\"\"解析表格对齐方式\"\"\"\n    cells = separator_line.split('|')[1:-1]\n\
          \    alignments = []\n    \n    for cell in cells:\n        cell = cell.strip()\n\
          \        if cell.startswith(':') and cell.endswith(':'):\n            alignments.append('center')\n\
          \        elif cell.startswith(':'):\n            alignments.append('left')\n\
          \        elif cell.endswith(':'):\n            alignments.append('right')\n\
          \        else:\n            alignments.append('default')\n            \n\
          \    return alignments"
        code_language: python3
        desc: ''
        outputs:
          json_table:
            children: null
            type: array[object]
          result:
            children: null
            type: string
        selected: false
        title: 使用python自带方法
        type: code
        variables:
        - value_selector:
          - '1741831629740'
          - md_file
          variable: arg1
        - value_selector:
          - '1741831629740'
          - index
          variable: index
      height: 54
      id: '1743582198116'
      position:
        x: 613.839587644311
        y: 437.24061853353305
      positionAbsolute:
        x: 613.839587644311
        y: 437.24061853353305
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
            id: 8c4cbd19-20e9-41f1-aa18-4abbc51047fa
            value: 纯md表格
            varType: string
            variable_selector:
            - '1741831629740'
            - output_type
          id: 'true'
          logical_operator: and
        desc: ''
        selected: false
        title: 条件分支
        type: if-else
      height: 126
      id: '1744870130254'
      position:
        x: 942
        y: 271
      positionAbsolute:
        x: 942
        y: 271
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        desc: ''
        outputs:
        - value_selector:
          - '1744880784497'
          - result
          variable: result
        selected: false
        title: 结束 (1)
        type: end
      height: 90
      id: '17448701669180'
      position:
        x: 1550
        y: 401
      positionAbsolute:
        x: 1550
        y: 401
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "from bs4 import BeautifulSoup, element\nimport markdown\nimport json\n\
          \ndef main(arg1: str, index: int = 0) -> dict:\n    table_index = index\n\
          \    md = markdown.Markdown(extensions=['tables'])\n    html = md.convert(arg1)\n\
          \    \n    soup = BeautifulSoup(html, 'html.parser')\n    tables = soup.find_all('table')\n\
          \    \n    if not tables:\n        return {'result': \"\", \"json_table\"\
          : []}\n    \n    # 如果指定了table_index，只处理该索引的表格\n    if table_index is not\
          \ None:\n        if 0 <= table_index < len(tables):\n            table_md,\
          \ json_data = html_table_to_markdown_with_json(tables[table_index])\n  \
          \          return {\n                'result': table_md,\n             \
          \   \"json_table\": json_data\n            }\n        else:\n          \
          \  return {'result': f\"错误：表格索引 {table_index} 超出范围，共有 {len(tables)} 个表格\"\
          , \"json_table\": []}\n    \n    # 提取所有表格\n    all_tables_md = []\n    all_tables_json\
          \ = []\n    \n    for table in tables:\n        table_md, json_data = html_table_to_markdown_with_json(table)\n\
          \        all_tables_md.append(table_md)\n        all_tables_json.append(json_data)\n\
          \    \n    return {\n        'result': \"\\n\\n\".join(all_tables_md),\n\
          \        \"json_table\": all_tables_json\n    }\n\ndef html_table_to_markdown_with_json(table:\
          \ element.Tag) -> tuple:\n    \"\"\"同时生成增强版Markdown和JSON数据\"\"\"\n    headers\
          \ = []\n    rows = []\n    \n    # 提取表头\n    header_row = table.find('tr')\n\
          \    if header_row:\n        headers = [get_cell_text(th) for th in header_row.find_all(['th',\
          \ 'td'])]\n    \n    # 提取数据行\n    for row in table.find_all('tr')[1:]:\n\
          \        cells = [get_cell_text(cell) for cell in row.find_all(['td', 'th'])]\n\
          \        if cells:\n            rows.append(dict(zip(headers, cells)))\n\
          \    \n    # 生成Markdown表格\n    markdown_table = generate_markdown_table(table,\
          \ headers)\n    \n    # 处理嵌套表格（递归处理）\n    process_nested_tables(table)\n\
          \    \n    return markdown_table, rows\n\ndef get_cell_text(cell: element.Tag)\
          \ -> str:\n    \"\"\"优化后的单元格内容提取\"\"\"\n    # 处理嵌套表格\n    for child in cell.find_all('table',\
          \ recursive=False):\n        child_html = str(child)\n        child_markdown\
          \ = html_table_to_markdown_with_json(child)[0]\n        cell.clear()\n \
          \       cell.append(BeautifulSoup(child_markdown, 'html.parser'))\n    \n\
          \    # 保留原始换行符并处理多余空格\n    content = ''.join(cell.stripped_strings)\n  \
          \  return content.replace('\\n', '\\\n')  # 保留换行符的JSON兼容格式\n\ndef generate_markdown_table(table:\
          \ element.Tag, headers: list) -> str:\n    \"\"\"优化后的Markdown表格生成\"\"\"\n\
          \    separator = []\n    for cell in table.find('tr').find_all(['th', 'td']):\n\
          \        align = '---'\n        style = cell.get('style', '')\n        if\
          \ 'text-align:left' in style:\n            align = ':---'\n        elif\
          \ 'text-align:right' in style:\n            align = '---:'\n        separator.append(align)\n\
          \    \n    markdown = [\n        \"| \" + \" | \".join(headers) + \" |\"\
          ,\n        \"| \" + \" | \".join(separator) + \" |\"\n    ]\n    \n    for\
          \ row in table.find_all('tr')[1:]:\n        cells = [get_cell_text(cell)\
          \ for cell in row.find_all(['td', 'th'])]\n        markdown.append(\"| \"\
          \ + \" | \".join(cells) + \" |\")\n    \n    return \"\\n\".join(markdown)\n\
          \ndef process_nested_tables(table: element.Tag):\n    \"\"\"递归处理嵌套表格结构\"\
          \"\"\n    for child in table.find_all('table', recursive=False):\n     \
          \   child_html = str(child)\n        _, _ = html_table_to_markdown_with_json(child)\n\
          \        child.replace_with(BeautifulSoup(child_html, 'html.parser'))"
        code_language: python3
        desc: ''
        error_strategy: fail-branch
        outputs:
          json_table:
            children: null
            type: array[object]
          result:
            children: null
            type: string
        selected: true
        title: 提取markdown表格和jsondata (1)
        type: code
        variables:
        - value_selector:
          - '1741831629740'
          - md_file
          variable: arg1
        - value_selector:
          - '1741831629740'
          - index
          variable: index
      height: 90
      id: '17448731884770'
      position:
        x: 334
        y: 271
      positionAbsolute:
        x: 334
        y: 271
      selected: true
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "def main(arg1: str = \"\", arg2: str = \"\") -> dict:\n    result =\
          \ arg1 if arg1 else arg2\n    return {\"result\": result}"
        code_language: python3
        desc: ''
        outputs:
          result:
            children: null
            type: string
        selected: false
        title: 代码执行 3
        type: code
        variables:
        - value_selector:
          - '17448731884770'
          - result
          variable: arg1
        - value_selector:
          - '1743582198116'
          - result
          variable: arg2
      height: 54
      id: '1744880775218'
      position:
        x: 1246
        y: 271
      positionAbsolute:
        x: 1246
        y: 271
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    - data:
        code: "def main(arg1: str = \"\", arg2: str = \"\") -> dict:\n    result =\
          \ arg1 if arg1 else arg2\n    return {\"result\": result}"
        code_language: python3
        desc: ''
        outputs:
          result:
            children: null
            type: array[object]
        selected: false
        title: 代码执行 4
        type: code
        variables:
        - value_selector:
          - '17448731884770'
          - json_table
          variable: arg1
        - value_selector:
          - '1743582198116'
          - json_table
          variable: arg2
      height: 54
      id: '1744880784497'
      position:
        x: 1246
        y: 401
      positionAbsolute:
        x: 1246
        y: 401
      selected: false
      sourcePosition: right
      targetPosition: left
      type: custom
      width: 244
    viewport:
      x: -230.91018658681742
      y: 30.562228045534653
      zoom: 1.153027424174604

```

