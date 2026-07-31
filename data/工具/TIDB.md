> HTML 页面: [[page/wiki/data/工具/TIDB.html|打开 HTML 页面]]

TiDB 是 PingCAP 公司自主设计、研发的开源分布式关系型数据库。

是一款同时支持在线事务处理与在线分析处理 (Hybrid Transactional and Analytical Processing, HTAP)的融合型分布式数据库产品，具备水平扩容或者缩容、金融级高可用、实时 HTAP、[云原生](https://baike.baidu.com/item/%E4%BA%91%E5%8E%9F%E7%94%9F/53770166?fromModule=lemma_inlink)的分布式数据库、兼容 MySQL 5.7 协议和 MySQL 生态等重要特性。

#### MySQL迁移至TiDB发现的问题

|   |   |   |
|---|---|---|
||问题点||
|update脚本兼容|**问题SQL**<br><br>UPDATE dmp_wms.wms_product_onhand h  <br>SET h.lock_qty = h.lock_qty + 3,  <br>h.used_able_qty = h.onhand_qty - h.lock_qty  <br>WHERE h.product_onhand_id = 3;  <br>在上面的sql中, mysql使用h.lock_qty更新后的值, tidb使用更新前的值<br><br>  <br>  <br><br>**测试数据：**<br><br>SELECT product_onhand_id, onhand_qty, used_able_qty, lock_qty  <br>FROM `wms_product_onhand`  <br>WHERE product_onhand_id =1<br><br>  <br>  <br><br>**改造方案一**<br><br>（移植表达式，例如：h.used_able_qty = h.onhand_qty - (h.lock_qty + 3) ，遵从标准SQL规范）<br><br>  <br>  <br><br>**改造方案二**<br><br>UPDATE dmp_wms.wms_product_onhand h  <br>SET h.lock_qty = h.lock_qty + 3,  <br>h.used_able_qty = h.used_able_qty - 3  <br>WHERE h.product_onhand_id = 3;||
||||