> HTML 页面: [[page/wiki/data/工具/html工具页/HTML在线运行.html|打开 HTML 页面]]

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML在线运行</title>
    <style>
        :root {
            --bg: #f8faff;
            --card-bg: #ffffff;
            --text-main: #2c5e80;
            --btn-default: #e6f2f8;
            --btn-active: #ff4d4f;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "PingFang SC", "Microsoft YaHei", sans-serif;
        }
        body {
            background-color: var(--bg);
            color: var(--text-main);
            line-height: 1.6;
            padding: 20px;
        }
        .container {
            display: flex;
            gap: 20px;
            width: 100%;
            height: calc(100vh - 40px);
        }
        .editor-panel, .preview-panel {
            flex: 1;
            background-color: var(--card-bg);
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.05);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        .panel-header {
            padding: 12px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .panel-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            background-color: var(--btn-default);
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s;
        }
        .panel-btn:hover {
            background-color: #d5e8f3;
        }
        .panel-btn.active {
            background-color: var(--btn-active);
            color: white;
        }
        .code-editor {
            flex: 1;
            width: 100%;
            border: none;
            padding: 20px;
            font-family: "Consolas", "Monaco", monospace;
            font-size: 14px;
            resize: none;
            outline: none;
        }
        .preview-iframe {
            flex: 1;
            width: 100%;
            border: none;
            padding: 20px;
            background-color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 左侧代码编辑区 -->
        <div class="editor-panel">
            <div class="panel-header">
                <button class="panel-btn" onclick="loadSampleCode()">示例代码</button>
                <button class="panel-btn" onclick="formatCode()">格式化</button>
                <button class="panel-btn" onclick="clearCode()">清空</button>
            </div>
            <textarea class="code-editor" id="codeInput" placeholder="请输入HTML代码...">
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>示例页面</title>
    <style>
        body {
            background: linear-gradient(135deg, #1a2a6c, #2468b2);
            color: white;
            text-align: center;
            padding: 40px;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        p {
            font-size: 14px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <h1>添可-派恩天津市售后服务商引入与布点管理评估报告</h1>
    <p>评估周期：2024年8月1日 - 2024年8月10日 | 版本：V1.0 服务商网络规划版</p>
</body>
</html>
            </textarea>
        </div>

        <!-- 右侧预览区 -->
        <div class="preview-panel">
            <div class="panel-header">
                <span>运行结果</span>
            </div>
            <iframe class="preview-iframe" id="previewFrame"></iframe>
        </div>
    </div>

    <script>
        const codeInput = document.getElementById('codeInput');
        const previewFrame = document.getElementById('previewFrame');

        // 实时同步代码到预览框
        codeInput.addEventListener('input', updatePreview);
        // 初始加载预览
        updatePreview();

        // 更新预览
        function updatePreview() {
            const code = codeInput.value;
            const frameDoc = previewFrame.contentDocument || previewFrame.contentWindow.document;
            frameDoc.open();
            frameDoc.write(code);
            frameDoc.close();
        }

        // 加载示例代码
        function loadSampleCode() {
            codeInput.value = `<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>示例页面</title>
    <style>
        body {
            background: linear-gradient(135deg, #1a2a6c, #2468b2);
            color: white;
            text-align: center;
            padding: 40px;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        p {
            font-size: 14px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <h1>添可-派恩天津市售后服务商引入与布点管理评估报告</h1>
    <p>评估周期：2024年8月1日 - 2024年8月10日 | 版本：V1.0 服务商网络规划版</p>
</body>
</html>`;
            updatePreview();
        }

        // 清空代码
        function clearCode() {
            codeInput.value = '';
            updatePreview();
        }

        // 格式化代码（简易版，复杂场景建议用第三方库如prettier）
        function formatCode() {
            try {
                const code = codeInput.value;
                // 简易格式化（仅处理缩进，复杂场景需优化）
                let formatted = '';
                let indentLevel = 0;
                const indent = '    ';
                for (let i = 0; i < code.length; i++) {
                    const char = code[i];
                    if (char === '<' && code[i+1] === '/') {
                        indentLevel--;
                        formatted += '\n' + indent.repeat(indentLevel);
                    } else if (char === '>' && i < code.length - 1 && code[i+1] !== '<') {
                        formatted += char + '\n' + indent.repeat(indentLevel);
                    } else if (char === '<' && code[i+1] !== '!' && code[i+1] !== '/') {
                        formatted += '\n' + indent.repeat(indentLevel);
                        indentLevel++;
                    }
                    formatted += char;
                }
                codeInput.value = formatted.trim();
            } catch (e) {
                alert('代码格式有误，无法格式化');
            }
        }
    </script>
</body>
</html>