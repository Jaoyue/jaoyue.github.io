> HTML 页面: [[page/wiki/data/工具/html工具页/base64转excel.html|打开 HTML 页面]]

<!DOCTYPE html>
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Base64转Excel下载工具</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.6;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .container {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        textarea {
            width: 100%;
            height: 200px;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        .filename-input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <h1>Base64转Excel下载工具</h1>
    <div class="container">
        <p>1. 请在下方输入Base64编码的Excel文件数据</p>
        <textarea id="base64Input" placeholder="在此粘贴Base64字符串..."></textarea>
        
        <p>2. 输入文件名（可选，不带扩展名）</p>
        <input type="text" id="fileName" class="filename-input" placeholder="例如: 我的Excel文件">
        
        <p>3. 点击按钮下载Excel文件</p>
        <button onclick="downloadExcel()">下载Excel文件</button>
    </div>

    <script>
        function downloadExcel() {
            const base64Data = document.getElementById('base64Input').value.trim();
            if (!base64Data) {
                alert('请输入Base64字符串！');
                return;
            }

            // 获取文件名，如果没有输入则使用默认名
            let fileName = document.getElementById('fileName').value.trim();
            if (!fileName) {
                fileName = '下载的Excel文件';
            }
            
            // 确保文件名有.xlsx扩展名
            if (!fileName.endsWith('.xlsx')) {
                fileName += '.xlsx';
            }

            try {
                // 将Base64字符串转换为字节数组
                const byteCharacters = atob(base64Data);
                const byteNumbers = new Array(byteCharacters.length);
                for (let i = 0; i < byteCharacters.length; i++) {
                    byteNumbers[i] = byteCharacters.charCodeAt(i);
                }
                const byteArray = new Uint8Array(byteNumbers);
                
                // 创建Blob对象
                const blob = new Blob([byteArray], {type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'});
                
                // 创建下载链接
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = fileName;
                document.body.appendChild(a);
                a.click();
                
                // 清理
                setTimeout(() => {
                    document.body.removeChild(a);
                    URL.revokeObjectURL(url);
                }, 100);
            } catch (error) {
                alert('转换失败，请检查Base64字符串是否正确！\n错误信息: ' + error.message);
                console.error(error);
            }
        }
    </script>


</body></html>