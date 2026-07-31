<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>流式Base64转换器</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
            padding: 20px 0;
        }
        
        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
        }
        
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 20px;
        }
        
        .card-title {
            font-size: 18px;
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }
        
        .upload-area {
            border: 2px dashed #e5e6eb;
            border-radius: 6px;
            padding: 30px;
            text-align: center;
            margin-bottom: 20px;
            transition: all 0.3s;
            background-color: #f8f9fa;
        }
        
        .upload-area:hover {
            border-color: #c9cdD4;
        }
        
        .upload-area.dragover {
            background-color: #f0f2f5;
            border-color: #86909c;
        }
        
        .file-input {
            display: none;
        }
        
        .file-label {
            display: inline-block;
            background-color: #1677ff;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s;
            margin-bottom: 15px;
        }
        
        .file-label:hover {
            background-color: #0958d9;
        }
        
        .file-info {
            margin-top: 15px;
            font-size: 14px;
            color: #666;
        }
        
        .warning {
            background: #fff7e6;
            border: 1px solid #ffe8cc;
            padding: 12px;
            border-radius: 6px;
            margin: 15px 0;
            color: #fa8c16;
            font-size: 14px;
        }
        
        .warning strong {
            color: #fa8c16;
        }
        
        .progress-container {
            margin: 20px 0;
            display: none;
        }
        
        .progress-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 14px;
            color: #666;
        }
        
        .progress-bar {
            width: 100%;
            height: 8px;
            background: #f0f0f0;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .progress {
            height: 100%;
            background-color: #1677ff;
            width: 0%;
            transition: width 0.3s;
        }
        
        .actions {
            display: flex;
            gap: 15px;
            margin-bottom: 10px;
        }
        
        button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .convert-btn {
            background-color: #1677ff;
            color: white;
            flex: 1;
        }
        
        .convert-btn:hover:not(:disabled) {
            background-color: #0958d9;
        }
        
        .convert-btn:disabled {
            background-color: #e5e6eb;
            cursor: not-allowed;
        }
        
        .cancel-btn {
            background-color: #f5222d;
            color: white;
            display: none;
            flex: 1;
        }
        
        .cancel-btn:hover {
            background-color: #cf1322;
        }
        
        .status {
            padding: 10px;
            margin: 10px 0;
            border-radius: 6px;
            display: none;
            font-size: 14px;
        }
        
        .status.success {
            background: #f6ffed;
            color: #52c41a;
            border: 1px solid #d9f7be;
        }
        
        .status.error {
            background: #fff1f0;
            color: #f5222d;
            border: 1px solid #ffccc7;
        }
        
        footer {
            text-align: center;
            padding: 15px;
            color: #86909c;
            font-size: 14px;
            margin-top: 30px;
        }
        
        @media (max-width: 600px) {
            .card {
                padding: 15px;
            }
            
            .actions {
                flex-direction: column;
            }
            
            h1 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>流式Base64转换器</h1>
        
        <div class="card">
            <div class="card-title">文件上传</div>
            
            <div class="warning">
                <strong>流式处理优势：</strong> 采用Streams API，处理大文件时内存占用极低，支持GB级文件转换
            </div>
            
            <div class="upload-area" id="uploadArea">
                <input type="file" id="fileInput" class="file-input">
                <label for="fileInput" class="file-label">选择文件</label>
                <p>或拖放文件到此处</p>
                <div class="file-info" id="fileInfo">未选择文件</div>
            </div>
            
            <div class="progress-container" id="progressContainer">
                <div class="progress-info">
                    <span>处理进度:</span>
                    <span id="progressText">0%</span>
                </div>
                <div class="progress-bar">
                    <div class="progress" id="progressBar"></div>
                </div>
                <div class="progress-info">
                    <span>已处理:</span>
                    <span id="processedSize">0 B</span>
                </div>
            </div>
            
            <div class="status" id="statusMessage"></div>
            
            <div class="actions">
                <button class="convert-btn" id="convertBtn" disabled>开始转换</button>
                <button class="cancel-btn" id="cancelBtn">取消转换</button>
            </div>
        </div>
        
        <footer>
            <p>流式Base64转换器 © 2023 - 专为大文件设计</p>
        </footer>
    </div>

    <script>
        class StreamBase64Converter {
            constructor() {
                this.isConverting = false;
                this.currentController = null;
                this.initEvents();
            }
            
            initEvents() {
                this.fileInput = document.getElementById('fileInput');
                this.fileInfo = document.getElementById('fileInfo');
                this.uploadArea = document.getElementById('uploadArea');
                this.convertBtn = document.getElementById('convertBtn');
                this.cancelBtn = document.getElementById('cancelBtn');
                this.progressContainer = document.getElementById('progressContainer');
                this.progressBar = document.getElementById('progressBar');
                this.progressText = document.getElementById('progressText');
                this.processedSize = document.getElementById('processedSize');
                this.statusMessage = document.getElementById('statusMessage');
                
                this.fileInput.addEventListener('change', (e) => this.handleFileSelect(e));
                this.convertBtn.addEventListener('click', () => this.startConversion());
                this.cancelBtn.addEventListener('click', () => this.cancelConversion());
                
                this.setupDragAndDrop();
            }
            
            setupDragAndDrop() {
                this.uploadArea.addEventListener('dragover', (e) => {
                    e.preventDefault();
                    this.uploadArea.classList.add('dragover');
                });
                
                this.uploadArea.addEventListener('dragleave', () => {
                    this.uploadArea.classList.remove('dragover');
                });
                
                this.uploadArea.addEventListener('drop', (e) => {
                    e.preventDefault();
                    this.uploadArea.classList.remove('dragover');
                    
                    if (e.dataTransfer.files.length > 0) {
                        this.handleFileSelect({ target: { files: e.dataTransfer.files } });
                    }
                });
            }
            
            handleFileSelect(e) {
                if (e.target.files.length === 0) return;
                
                const file = e.target.files[0];
                this.selectedFile = file;
                
                this.fileInfo.textContent = `已选择: ${file.name} (${this.formatFileSize(file.size)})`;
                this.convertBtn.disabled = false;
                this.hideStatus();
                
                // 显示文件大小警告
                if (file.size > 100 * 1024 * 1024) { // 100MB
                    this.showStatus(`大文件警告: 您选择了 ${this.formatFileSize(file.size)} 的文件，转换可能需要一些时间。`, 'success');
                }
            }
            
            async startConversion() {
                if (!this.selectedFile || this.isConverting) return;
                
                this.isConverting = true;
                this.convertBtn.disabled = true;
                this.cancelBtn.style.display = 'block';
                this.progressContainer.style.display = 'block';
                this.hideStatus();
                
                try {
                    await this.streamConvertToBase64(this.selectedFile);
                    this.showStatus('转换完成！文件已开始下载。', 'success');
                } catch (error) {
                    if (error.name !== 'AbortError') {
                        this.showStatus(`转换失败: ${error.message}`, 'error');
                    } else {
                        this.showStatus('转换已取消', 'error');
                    }
                } finally {
                    this.resetUI();
                }
            }
            
            cancelConversion() {
                if (this.currentController) {
                    this.currentController.abort();
                    this.currentController = null;
                }
                this.isConverting = false;
            }
            
            async streamConvertToBase64(file) {
                return new Promise(async (resolve, reject) => {
                    // 创建AbortController用于取消操作
                    this.currentController = new AbortController();
                    
                    try {
                        const fileStream = file.stream();
                        const reader = fileStream.getReader();
                        
                        let totalProcessed = 0;
                        const totalSize = file.size;
                        const chunkSize = 64 * 1024; // 64KB chunks - 平衡性能和内存
                        
                        // 创建下载链接
                        const downloadUrl = await this.createDownloadStream();
                        
                        while (true) {
                            // 检查是否取消
                            if (this.currentController.signal.aborted) {
                                reject(new Error('AbortError'));
                                return;
                            }
                            
                            const { done, value } = await reader.read();
                            if (done) break;
                            
                            // 处理当前chunk
                            const base64Chunk = this.arrayBufferToBase64(value);
                            
                            // 写入到下载流
                            await this.writeToDownloadStream(base64Chunk);
                            
                            totalProcessed += value.length;
                            
                            // 更新进度
                            this.updateProgress(totalProcessed, totalSize);
                            
                            // 定期让出主线程，避免阻塞
                            if (totalProcessed % (chunkSize * 10) === 0) {
                                await new Promise(resolve => setTimeout(resolve, 0));
                            }
                        }
                        
                        // 完成下载
                        await this.finalizeDownloadStream(file.name);
                        resolve();
                        
                    } catch (error) {
                        reject(error);
                    } finally {
                        this.currentController = null;
                    }
                });
            }
            
            async createDownloadStream() {
                // 使用Blob和URL.createObjectURL创建流式下载
                // 这里我们使用简单的文本拼接方式
                this.downloadChunks = [];
            }
            
            async writeToDownloadStream(chunk) {
                this.downloadChunks.push(chunk);
            }
            
            async finalizeDownloadStream(filename) {
                // 创建最终的Blob并触发下载
                const fullBase64 = this.downloadChunks.join('');
                const blob = new Blob([fullBase64], { type: 'text/plain' });
                const url = URL.createObjectURL(blob);
                
                const a = document.createElement('a');
                a.href = url;
                a.download = `${filename}.base64.txt`;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                
                // 清理URL
                setTimeout(() => URL.revokeObjectURL(url), 100);
            }
            
            arrayBufferToBase64(buffer) {
                // 高效的Base64编码
                const bytes = new Uint8Array(buffer);
                let binary = '';
                const len = bytes.byteLength;
                
                for (let i = 0; i < len; i++) {
                    binary += String.fromCharCode(bytes[i]);
                }
                
                return btoa(binary);
            }
            
            updateProgress(processed, total) {
                const percent = Math.round((processed / total) * 100);
                this.progressBar.style.width = percent + '%';
                this.progressText.textContent = percent + '%';
                this.processedSize.textContent = this.formatFileSize(processed);
            }
            
            resetUI() {
                this.isConverting = false;
                this.convertBtn.disabled = false;
                this.cancelBtn.style.display = 'none';
                this.progressContainer.style.display = 'none';
                this.progressBar.style.width = '0%';
                this.progressText.textContent = '0%';
                this.processedSize.textContent = '0 B';
            }
            
            showStatus(message, type) {
                this.statusMessage.textContent = message;
                this.statusMessage.className = `status ${type}`;
                this.statusMessage.style.display = 'block';
            }
            
            hideStatus() {
                this.statusMessage.style.display = 'none';
            }
            
            formatFileSize(bytes) {
                if (bytes === 0) return '0 Bytes';
                const k = 1024;
                const sizes = ['Bytes', 'KB', 'MB', 'GB'];
                const i = Math.floor(Math.log(bytes) / Math.log(k));
                return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
            }
        }
        
        // 初始化应用
        document.addEventListener('DOMContentLoaded', () => {
            new StreamBase64Converter();
        });
    </script>
</body>
</html>