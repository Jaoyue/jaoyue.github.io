<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSON转Excel导出工具</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f5f5f5;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        textarea {
            width: 100%;
            height: 300px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            resize: vertical;
            margin-bottom: 20px;
        }
        button {
            display: block;
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #0056b3;
        }
        .tip {
            color: #666;
            font-size: 12px;
            margin-top: 10px;
            text-align: center;
        }
        .error {
            color: #dc3545;
            text-align: center;
            margin-bottom: 10px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>JSON数组转Excel导出</h1>
        <div class="error" id="errorTip">请输入合法的JSON数组！</div>
        <textarea id="jsonInput" placeholder='请输入JSON数组，例如：
[
    {"姓名":"张三","年龄":25,"城市":"北京"},
    {"姓名":"李四","年龄":30,"城市":"上海"}
]'></textarea>
        <button id="exportBtn">导出为Excel文件</button>
        <div class="tip">提示：请确保输入的是标准的JSON数组格式</div>
    </div>

    <!-- 引入SheetJS库 -->
    <script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>
    <script>
        // 获取页面元素
        const jsonInput = document.getElementById('jsonInput');
        const exportBtn = document.getElementById('exportBtn');
        const errorTip = document.getElementById('errorTip');

        // 导出按钮点击事件
        exportBtn.addEventListener('click', function() {
            // 清空错误提示
            errorTip.style.display = 'none';
            
            try {
                // 获取并清理输入的JSON文本（去除多余空格和换行）
                const jsonText = jsonInput.value.trim();
                if (!jsonText) {
                    errorTip.textContent = '请输入JSON数组内容！';
                    errorTip.style.display = 'block';
                    return;
                }

                // 解析JSON字符串为数组
                const jsonData = JSON.parse(jsonText);
                
                // 校验是否为数组
                if (!Array.isArray(jsonData)) {
                    errorTip.textContent = '输入的内容必须是JSON数组！';
                    errorTip.style.display = 'block';
                    return;
                }

                // 校验数组是否为空
                if (jsonData.length === 0) {
                    errorTip.textContent = 'JSON数组不能为空！';
                    errorTip.style.display = 'block';
                    return;
                }

                // 1. 创建工作簿
                const workbook = XLSX.utils.book_new();
                
                // 2. 将JSON数据转换为工作表
                const worksheet = XLSX.utils.json_to_sheet(jsonData);
                
                // 3. 将工作表添加到工作簿，命名为"数据"
                XLSX.utils.book_append_sheet(workbook, worksheet, "数据");
                
                // 4. 导出并下载Excel文件
                XLSX.writeFile(workbook, "JSON导出数据.xlsx");

            } catch (e) {
                // 捕获解析错误
                errorTip.textContent = 'JSON格式错误：' + e.message;
                errorTip.style.display = 'block';
                console.error('解析JSON失败：', e);
            }
        });
    </script>
</body>
</html>