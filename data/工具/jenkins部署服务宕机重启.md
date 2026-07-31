> HTML 页面: [[page/wiki/data/工具/jenkins部署服务宕机重启.html|打开 HTML 页面]]

## 0.需要修改的地方：
### 1. **Post Steps 保持不变**
你的 Jenkins Post Steps **完全不需要修改**：

```bash
# 你的 Post Steps（保持不变）
/bin/sh /opt/scripts/deploy_app_test.sh store-api 10.108.128.16
```

### 2. **修改的是部署脚本本身**
需要修改的是 `/opt/scripts/deploy_app_test.sh` 这个脚本文件：

**原来的部署脚本可能类似这样：**

```bash
#!/bin/bash
APP_NAME=$1
SERVER_IP=$2

echo "部署 $APP_NAME 到 $SERVER_IP"

# 拷贝文件
scp /path/to/jar root@$SERVER_IP:/opt/apps/store-api/store-api.jar

# 原来的启动方式（需要修改的部分）
ssh root@$SERVER_IP "cd /opt/apps/store-api && nohup java -jar store-api.jar > /dev/null 2>&1 &"
```

**修改后的部署脚本：**

```bash
#!/bin/bash
APP_NAME=$1
SERVER_IP=$2

echo "部署 $APP_NAME 到 $SERVER_IP"

# 拷贝文件（保持不变）
scp /root/.jenkins/workspace/ecovacs-store-api/target/*.jar root@$SERVER_IP:/opt/apps/store-api/store-api.jar

# 修改这里：使用 systemctl 重启（唯一修改的地方）
ssh root@$SERVER_IP "systemctl restart store-api"

echo "部署完成，服务已重启"
```

## 总结修改位置：
| 需要修改的地方 | 状态 | 说明 |
| --- | --- | --- |
| **Jenkins Post Steps** | ❌ **不修改** | 保持原样 |
| **部署脚本文件** `/opt/scripts/deploy_app_test.sh` | ✅ **需要修改** | 改启动命令 |
| **目标服务器** 服务文件 | ✅ **需要创建** | 一次性设置 |


## 具体操作步骤：
### 第1步：在目标服务器创建服务文件（一次性）
```bash
ssh root@10.108.128.16 "cat > /etc/systemd/system/store-api.service" << 'EOF'
[Unit]
Description=Store API Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/apps/store-api
ExecStart=/usr/bin/java -jar store-api.jar
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

ssh root@10.108.128.16 "systemctl daemon-reload"
```

### 第2步：修改部署脚本文件
```bash
# 编辑部署脚本
vi /opt/scripts/deploy_app_test.sh

# 找到原来的启动命令，改为：
ssh root@$SERVER_IP "systemctl restart store-api"
```

### 第3步：你的 Jenkins 配置完全不变
```bash
# Pre Steps（不变）
deploy=/opt/deploy
platform=/root/.jenkins/workspace
/bin/cp -rf $deploy/store-api/src/main/resources/* $platform/ecovacs-store-api/src/main/resources
/bin/cp -rf $deploy/store-api/src/main/webapp/WEB-INF/* $platform/ecovacs-store-api/src/main/webapp/WEB-INF

# Post Steps（不变）
/bin/sh /opt/scripts/deploy_app_test.sh store-api 10.108.128.16
```

**所以答案是：Post Steps 保持不变，只修改部署脚本文件！**

****

服务文件需要在**目标服务器（10.108.128.16）**上创建。

## **文件位置总结：**
| **文件** | **位置** | **说明** |
| --- | --- | --- |
| **部署脚本**** **`**/opt/scripts/deploy_app_test.sh**` | **Jenkins 服务器** | **负责执行部署流程** |
| **服务文件**** **`**/etc/systemd/system/store-api.service**` | **目标服务器 10.108.128.16** | **管理应用服务的 systemd 配置** |


## **具体操作步骤：**
### **第1步：在目标服务器(10.108.128.16)创建服务文件**
```bash
# 登录到 10.108.128.16
ssh root@10.108.128.16

# 创建服务文件
cat > /etc/systemd/system/store-api.service << 'EOF'
[Unit]
Description=Store API Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/apps/store-api
ExecStart=/usr/bin/java -jar store-api.jar
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# 重新加载 systemd 配置
systemctl daemon-reload

# 启用服务（可选，让服务开机自启）
systemctl enable store-api
```

### **第2步：在Jenkins服务器修改部署脚本**
```bash
# 登录到 Jenkins 服务器
# 编辑部署脚本
vi /opt/scripts/deploy_app_test.sh

# 将原来的启动命令改为：
ssh root@$SERVER_IP "systemctl restart store-api"
```

### 添加错误逻辑处理
```bash
# 在Jenkins脚本中添加检查
if ssh root@$SERVER_IP "systemctl status store-api 2>&1 | grep -q 'not found'"; then
    echo "服务文件不存在，使用传统方式启动"
    ssh root@$SERVER_IP "cd /opt/apps/store-api && nohup java -jar store-api.jar > /dev/null 2>&1 &"
else
    echo "使用systemd重启服务"
    ssh root@$SERVER_IP "systemctl restart store-api"
fi

```

### 只对store-api生效
```bash
#!/bin/bash
# 原有的部署逻辑...
SERVER_IP="10.108.128.16"
APP_NAME="store-api"  # 或者其他方式获取当前部署的应用名

# 部署应用jar包等原有逻辑...

# 条件判断：只有store-api使用systemd，其他服务保持原样
if [ "$APP_NAME" = "store-api" ]; then
    echo "检测到store-api服务，使用systemd重启"
    ssh root@$SERVER_IP "systemctl restart store-api"
else
    echo "其他服务，使用原有启动方式"
    ssh root@$SERVER_IP "cd /opt/apps/$APP_NAME && nohup java -jar *.jar > /dev/null 2>&1 &"
fi

```

## **验证服务文件是否创建成功：**
```bash
# 在目标服务器 10.108.128.16 上检查
ssh root@10.108.128.16 "ls -la /etc/systemd/system/store-api.service"

# 检查服务状态
ssh root@10.108.128.16 "systemctl status store-api"

# 测试重启命令
ssh root@10.108.128.16 "systemctl restart store-api"
```

## **完整的文件流向：**
```plain
Jenkins服务器 (执行部署) → 目标服务器 10.108.128.16 (运行服务)
    ↓                              ↓
/opt/scripts/deploy_app_test.sh   /etc/systemd/system/store-api.service
    (部署脚本)                         (服务管理配置)
```

**总结：服务文件在目标服务器 10.108.128.16 上创建，这是一次性设置！**

