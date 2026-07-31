**Rocky Linux 8.10**（RHEL/CentOS 兼容发行版），以下是针对该系统的 Docker 安装方法：

---

### **1. 卸载旧版本（如有）**
```bash
sudo yum remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine
```

---

### **2. 安装必要依赖**
```bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

---

### **3. 添加 Docker CE 仓库**
```bash
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

---

### **4. 安装 Docker 引擎**
```bash
sudo yum install -y docker-ce docker-ce-cli containerd.io
```

---

### **5. 启动并设置开机自启**
```bash
sudo systemctl enable --now docker
```

---

### **6. 验证安装**
```bash
sudo docker run hello-world
```

正常输出示例：

```plain
Hello from Docker!
This message shows your installation is working correctly.
```

---

### **7. 配置用户权限（可选）**
```bash
# 将当前用户加入docker组
sudo usermod -aG docker $USER
newgrp docker  # 立即生效

# 验证非sudo执行
docker ps
```

---

### **常见问题解决**
#### **1. 如果遇到依赖冲突**
```bash
# 先安装基础依赖
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y --allowerasing docker-ce
```

#### **2. 防火墙设置**
```bash
# 开放Docker端口
sudo firewall-cmd --permanent --add-port=2375-2377/tcp
sudo firewall-cmd --permanent --add-port=7946/tcp
sudo firewall-cmd --permanent --add-port=7946/udp
sudo firewall-cmd --permanent --add-port=4789/udp
sudo firewall-cmd --reload
```

#### **3. 镜像加速（国内服务器）**
```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": [
    "https://registry.cn-hangzhou.aliyuncs.com",
    "https://docker.mirrors.ustc.edu.cn"
  ]
}
EOF
sudo systemctl restart docker
```

---

### **安装 Piston 执行引擎**
```bash
# 方法一：官方脚本（需先安装curl）
sudo yum install -y curl
curl -fsSL https://piston.rs/install.sh | sudo bash

# 方法二：手动安装
sudo docker run -d \
  -p 2000:2000 \
  -v piston_data:/piston \
  --name piston \
  ghcr.io/engineer-man/piston:latest
```

---

### **验证 Piston**
```bash
curl -X POST http://localhost:2000/api/v2/execute \
  -H "Content-Type: application/json" \
  -d '{"language":"python","source":"print(1+1)"}'
```

预期返回：

```json
{"language":"python","version":"3.9","run":{"stdout":"2\n","stderr":""}}
```

curl -X POST [https://emkc.org/api/v2/piston/execute](https://emkc.org/api/v2/piston/execute) \  -H "Content-Type: application/json" \  -d '{    "language": "python",    "version": "3.10",    "files": [{      "content": "print(1+1)"    }]  }'



```python
import time
print(time.strftime("%Y%m%d%H%M%S", time.localtime()))
```

