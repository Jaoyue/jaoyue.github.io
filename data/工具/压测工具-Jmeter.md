### 1.Jmeter安装
1>安装jdk

2>下载Jmeter [Apache JMeter - Apache JMeter™](https://jmeter.apache.org/)

3>解压安装包, 配置环境变量

<font style="color:rgb(77, 77, 77);">JMETER_HOME: Jmeter安装路径</font>

4>运行: bin><font style="color:rgb(77, 77, 77);">jmeter.bat</font>

### 2.测试脚本
| <font style="color:rgb(23, 43, 77);">测试用例</font> | <font style="color:rgb(23, 43, 77);">1、单接口压测 《库存事务》，每次操作1个库存</font><br/><font style="color:rgb(23, 43, 77);">1）sapId 跑5个，10个并发，每次操作1个</font><br/><font style="color:rgb(23, 43, 77);">2、单接口压测 《库存事务》，每次操作5个库存</font><br/><font style="color:rgb(23, 43, 77);">3、多个接口混合场景压测</font> |
| --- | --- |
| <font style="color:rgb(23, 43, 77);">测试脚本</font> | [<font style="color:rgb(23, 43, 77);">卡券性能测试结果0928.rar</font>](http://10.108.128.23:8090/download/attachments/4784743/%E5%8D%A1%E5%88%B8%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95%E7%BB%93%E6%9E%9C0928.rar?version=1&modificationDate=1713862260000&api=v2) |
| <font style="color:rgb(23, 43, 77);">测试工具</font> | <font style="color:rgb(23, 43, 77);">\\10.108.128.20\share\软件\apache-jmeter-5.6.3</font> |
| <font style="color:rgb(23, 43, 77);">测试报告</font> | [<font style="color:rgb(23, 43, 77);">查询可领取卡券列表_60t_300s.rar</font>](http://10.108.128.23:8090/download/attachments/4784743/%E6%9F%A5%E8%AF%A2%E5%8F%AF%E9%A2%86%E5%8F%96%E5%8D%A1%E5%88%B8%E5%88%97%E8%A1%A8_60t_300s.rar?version=1&modificationDate=1713862593000&api=v2) |
| <font style="color:rgb(23, 43, 77);">性能分析工具</font> | <font style="color:rgb(23, 43, 77);">Arthas - 开源 Java 诊断工具</font> |


### 3.测试流程
| <font style="color:rgb(23, 43, 77);">定义线程组</font>     | <font style="color:rgb(23, 43, 77);">1、定义线程数</font><br/><font style="color:rgb(23, 43, 77);">2、定义持续时间</font> | ![](md-img/压测工具-Jmeter/1731052477538-b532ff5e-14bc-4b14-8da1-f1b8bb8e87a0.png) |
| ---------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| <font style="color:rgb(23, 43, 77);">定义http请求</font>   | <font style="color:rgb(23, 43, 77);">1、设置java实现 http请求</font><br/><font style="color:rgb(23, 43, 77);">2、设置超时</font> | ![](md-img/压测工具-Jmeter/1731052520237-5d31f504-9648-43e9-8cab-0a116fb2ce4b.png) |
| <font style="color:rgb(23, 43, 77);">入参</font>           | <font style="color:rgb(23, 43, 77);">1）定义http头信息</font><br/><font style="color:rgb(23, 43, 77);">   </font><br/><font style="color:rgb(23, 43, 77);">   </font> | <font style="color:rgb(23, 43, 77);">   </font>              |
| <font style="color:rgb(23, 43, 77);">   </font>            | <font style="color:rgb(23, 43, 77);">2）入参，随机变量（配置元件）</font> | ![](md-img/压测工具-Jmeter/1731052547340-b60e55eb-83de-40ae-bbf9-45d8c5fdf5cb.png) |
| <font style="color:rgb(23, 43, 77);">   </font>            | <font style="color:rgb(23, 43, 77);">3）入参，读取文件（配置元件，参考解冻）</font> | ![](md-img/压测工具-Jmeter/1731052611357-a22737c0-2db2-47d1-a670-841f825d5408.png) |
| <font style="color:rgb(23, 43, 77);">出参</font>           | <font style="color:rgb(23, 43, 77);">增加出参断言</font><br/><font style="color:rgb(23, 43, 77);">参考《单场景-查询后领券事务_20t_300s》</font> | <font style="color:rgb(23, 43, 77);">   </font>              |
| <font style="color:rgb(23, 43, 77);">查看结果</font>       | <font style="color:rgb(23, 43, 77);">1、《汇总报告》</font><br/><font style="color:rgb(23, 43, 77);">2、《查看结果树》</font> | ![](md-img/压测工具-Jmeter/1731052637653-1656c81b-9bf1-457a-a514-149daa254ecb.png) |
| <font style="color:rgb(23, 43, 77);">多个接口一起跑</font> | <font style="color:rgb(23, 43, 77);">1、增加事务管理器</font><br/><font style="color:rgb(23, 43, 77);">2、增加出参断言</font><br/><font style="color:rgb(23, 43, 77);">参考《单场景-查询后领券事务_20t_300s》</font> | ![](md-img/压测工具-Jmeter/1731052659302-d045bea4-2bb9-48ec-b691-8ed0172fb640.png) |


<font style="color:rgb(77, 77, 77);"></font>

