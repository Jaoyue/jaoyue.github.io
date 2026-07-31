> HTML 页面: [[page/wiki/data/Linux/redis监控(Prometheus + Grafana).html|打开 HTML 页面]]

# 使用Prometheus + Grafana监控Redis内存
下面详细介绍如何使用Prometheus和Grafana搭建Redis内存监控系统，并在内存超过4.5GB时发送邮件告警。

## 1. 安装和配置组件
### 1.1 安装Prometheus
```bash
# 下载Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
cd prometheus-*

# 创建配置文件
cat <<EOF > prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'redis'
    static_configs:
      - targets: ['localhost:9121']
EOF

# 启动Prometheus
./prometheus --config.file=prometheus.yml &
```

### 1.2 安装Redis Exporter
```bash
# 下载并运行Redis Exporter
wget https://github.com/oliver006/redis_exporter/releases/download/v1.55.0/redis_exporter-v1.55.0.linux-amd64.tar.gz
tar xvfz redis_exporter-*.tar.gz
cd redis_exporter-*

# 启动Redis Exporter（连接到本地Redis）
./redis_exporter -redis.addr redis://localhost:6379 &
```

### 1.3 安装Grafana
```bash
# 在Ubuntu/Debian上
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install grafana

# 启动Grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
```

## 2. 配置Grafana
1. 访问Grafana: `http://your-server-ip:3000` (默认用户名/密码: admin/admin)
2. 添加数据源:
    - 选择"Prometheus"
    - URL: `http://localhost:9090`
    - 点击"Save & Test"
3. 导入Redis仪表板:
    - 点击"+" > "Import"
    - 输入仪表板ID `763` (官方Redis仪表板)
    - 选择Prometheus数据源
    - 点击"Import"

## 3. 设置告警规则
### 3.1 在Prometheus中配置告警规则
编辑`prometheus.yml`添加告警规则:

```yaml
rule_files:
  - 'alert.rules'

# 重启Prometheus后生效
```

创建`alert.rules`文件:

```yaml
groups:
- name: redis-alerts
  rules:
  - alert: RedisMemoryHigh
    expr: redis_memory_used_bytes > 4500000000
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Redis memory usage is high (instance {{ $labels.instance }})"
      description: "Redis memory usage is {{ $value }} bytes (over 4.5GB)"
```

### 3.2 配置Alertmanager发送邮件
1. 下载并安装Alertmanager:

```bash
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
tar xvfz alertmanager-*.tar.gz
cd alertmanager-*
```

2. 创建`alertmanager.yml`配置文件:

```yaml
route:
  receiver: 'email-notifications'

receivers:
- name: 'email-notifications'
  email_configs:
  - to: 'your-email@example.com'
    from: 'alertmanager@yourdomain.com'
    smarthost: 'smtp.your-email-provider.com:587'
    auth_username: 'your-email@example.com'
    auth_password: 'your-email-password'
    send_resolved: true
```

3. 启动Alertmanager:

```bash
./alertmanager --config.file=alertmanager.yml &
```

4. 修改Prometheus配置指向Alertmanager:

```yaml
alerting:
  alertmanagers:
  - static_configs:
    - targets: ['localhost:9093']
```

## 4. 验证和测试
1. 在Prometheus界面(`http://localhost:9090/alerts`)查看告警规则状态
2. 在Grafana仪表板查看Redis内存使用情况
3. 可以手动触发高内存使用(如使用`redis-cli debug populate 5000000`生成测试数据)来测试告警

## 5. 高级配置(可选)
### 5.1 使用Grafana告警替代
如果你更喜欢使用Grafana的告警功能:

1. 在Grafana仪表板中:
    - 点击任何内存图表标题 > Edit
    - 切换到"Alert"标签
    - 设置条件: "IS ABOVE 4500000000"
    - 配置通知渠道
2. 配置Grafana通知渠道:
    - 左侧菜单 > Alerting > Notification channels
    - 添加Email通知渠道

### 5.2 使用Docker部署
如果你熟悉Docker，可以使用以下docker-compose.yml:

```yaml
version: '3'
services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - ./alert.rules:/etc/prometheus/alert.rules
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--web.enable-lifecycle'
  
  alertmanager:
    image: prom/alertmanager
    ports:
      - "9093:9093"
    volumes:
      - ./alertmanager.yml:/etc/alertmanager/alertmanager.yml
    command:
      - '--config.file=/etc/alertmanager/alertmanager.yml'
  
  redis_exporter:
    image: oliver006/redis_exporter
    ports:
      - "9121:9121"
    command:
      - '--redis.addr=redis://your-redis-host:6379'
  
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    volumes:
      - grafana-storage:/var/lib/grafana
    depends_on:
      - prometheus

volumes:
  grafana-storage:
```

## 常见问题解决
1. **无法连接Redis Exporter**:
    - 检查Redis Exporter日志
    - 确保Redis允许远程连接(如果需要)
    - 检查防火墙设置
2. **邮件未发送**:
    - 检查Alertmanager日志
    - 验证SMTP设置
    - 测试SMTP服务器是否正常工作
3. **数据不显示**:
    - 检查Prometheus目标页面(`http://localhost:9090/targets`)
    - 确保Redis Exporter状态为UP

**这套监控方案不仅解决了你的内存告警需求，还提供了完整的Redis性能监控仪表板，可以帮助你全面了解Redis的运行状况。**

