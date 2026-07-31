> HTML 页面: [[page/wiki/data/工具/Infinity笔记.html|打开 HTML 页面]]

# 补考勤逻辑
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">含当天6天内（10号最多补5号）</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">门店必须有分部经理审核（业务员表这个分部的分部经理）</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">审核红点</font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">大区分部组织</font>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">业务功能涉及:</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">网点维护</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">门店维护</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">业务员维护</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">店员维护</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">分销商维护</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">市占数据</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">人员视图改造</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">报表涉及:</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">考试报表</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">作业报表</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">培训任务报表</font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">赠品校验逻辑</font>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">1.校验赠品活动(查询goms所有的赠品活动, 是否包含当前订单赠品中赠品活动编号, 若包含, 活动是否过期)</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">2.校验条件赠品(将当前订单中的所有条件赠品挑出来, 哪它们的物料号, 和门店编码去goms查询赠品, 将查到的赠品与条件赠品进行匹配)</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">3. 校验套购赠品活动(查询goms所有的套购赠品活动, 是否包含当前订单套购赠品中赠品活动编号, 若包含, 活动是否过期)</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">4.校验套购赠品(查询goms所有套购赠品, 和当前订单中的套购赠品进行匹配)</font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">终端等级</font>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">首页搜索</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">官网api接口</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">零售报表</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">终端单产</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">门店新进</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">(经营配置费率)</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">门店重装</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">销售销退导入</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">店员编制</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">终端零售报表</font>
>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">终端出样配置</font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">虚拟机配置</font>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">-server -Xmx1g -Xms1g -Xmn256m -XX:PermSize=512m -Dmode.dev=true -Dscheduler.on=true</font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">浏览器post请求</font>
```javascript
var url = "https://esb-gateway.tineco.com/restcloud/dbu-store/v1/api/storeEwm/getSalesOrder4OriginalOrderNo&appkey=630ef8c859ab2a60b458ef94"; //请求路径
var params = {
    "originalOrderNo":"601686299474730279260"
}; //此为json格式的参数
var xhr = new XMLHttpRequest();
xhr.open("POST", url, true);
xhr.setRequestHeader("Content-Type", "application/json");
xhr.setRequestHeader("Authorization","xxx");
xhr.onload = function (e) {
 if (xhr.readyState === 4) {
  if (xhr.status === 200) {
   console.log(xhr.responseText);
  } else {
   console.error(xhr.statusText);
  }
 }
};
xhr.send(JSON.stringify(params));
xhr.onerror = function (e) {
 console.error(xhr.statusText);
};
```

# Linux常用命令
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">查看日志: tail -100f  catalina.out</font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">密码</font>
> <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">APP店员端账号密码</font>  
<font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">沈晨琪 13771737492 正式scqT2477 测试Eco1234567</font>  
  
<font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">APP业务员端账号密码</font>  
<font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);">沈晨琪 evan.shen 正式Eco@123456 测试scqT2477  </font>
>

# <font style="color:rgb(51, 51, 51);background-color:rgb(249, 249, 249);"></font>
