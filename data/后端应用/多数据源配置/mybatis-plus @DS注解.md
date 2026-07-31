> HTML 页面: [[page/wiki/data/后端应用/多数据源配置/mybatis-plus @DS注解.html|打开 HTML 页面]]

### <font style="color:rgb(77, 77, 77);">DS注解的基本概念：</font>
`<font style="color:rgb(199, 37, 78);background-color:rgb(249, 242, 244);">@DS</font>`<font style="color:rgb(77, 77, 77);">注解用于动态数据源切换，用于指定方法或类使用特定的数据源  
</font>`<font style="color:rgb(199, 37, 78);background-color:rgb(249, 242, 244);">@DS</font>`<font style="color:rgb(77, 77, 77);">注解一般来自</font><font style="color:rgb(78, 161, 219) !important;">MyBatis-Plus</font><font style="color:rgb(77, 77, 77);">中的Dynamic DataSource模块，它允许在方法级别进行数据源切换</font>

<font style="color:rgb(77, 77, 77);">需要注意下核心的功能：</font>

+ **<font style="color:rgba(0, 0, 0, 0.75);">方法级别的数据源切换</font>**<font style="color:rgba(0, 0, 0, 0.75);">：@DS注解可以直接应用在方法上，使该方法在执行时使用指定的数据源</font>
+ **<font style="color:rgba(0, 0, 0, 0.75);">类级别的数据源切换</font>**<font style="color:rgba(0, 0, 0, 0.75);">：@DS注解可以应用在类上，使该类中的所有方法在执行时使用指定的数据源</font>
+ **<font style="color:rgba(0, 0, 0, 0.75);">优先级</font>**<font style="color:rgba(0, 0, 0, 0.75);">：方法级别的@DS注解优先于类级别的@DS注解</font>

### <font style="color:rgb(77, 77, 77);">引入对应的依赖</font>
```java
<dependency>
  <groupId>com.baomidou</groupId>
  <artifactId>dynamic-datasource-spring-boot-starter</artifactId>
  <version>${version}</version>
</dependency>
```

### <font style="color:rgb(77, 77, 77);">配置对应的数据源：</font>
```java
spring:
  datasource:
    dynamic:
      primary: master
      strict: false
      datasource:
        master:
          url: jdbc:mysql://xx.xx.xx.xx:3306/dynamic
          username: root
          password: 123456
          driver-class-name: com.mysql.jdbc.Driver
        slave_1:
          url: jdbc:mysql://xx.xx.xx.xx:3307/dynamic
          username: root
          password: 123456
          driver-class-name: com.mysql.jdbc.Driver
        slave_2:
          url: ENC(xxxxx)
          username: ENC(xxxxx)
          password: ENC(xxxxx)
          driver-class-name: com.mysql.jdbc.Driver
```

### <font style="color:rgb(77, 77, 77);">基本的切换数据源方式如下：</font>
```java
@Service
@DS("slave")
public class UserServiceImpl implements UserService {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  @Override
  @DS("slave_1")
  public List selectByCondition() {
    return jdbcTemplate.queryForList("select * from user where age >10");
  }
}
```

### <font style="color:rgb(77, 77, 77);">在写代码的时候有两个注意事项：</font>
+ <font style="color:rgba(0, 0, 0, 0.75);">单机 + 单数据源：@Transactional 注解</font>
+ <font style="color:rgba(0, 0, 0, 0.75);">单机 + 多数据源：@DSTransactional 注解（新版本支持，旧版本可以使用</font>`<font style="color:rgb(199, 37, 78);background-color:rgb(249, 242, 244);">@Transactional(propagation = Propagation.REQUIRES_NEW)</font>`<font style="color:rgba(0, 0, 0, 0.75);">）</font>
+ <font style="color:rgba(0, 0, 0, 0.75);">多机 + 单/多数据源：Seata 分布式事务</font>

资料参考: [详细分析MybatisPLus中@DS切换数据源的基本知识（附Demo）_ds注解-CSDN博客](https://blog.csdn.net/weixin_47872288/article/details/136545319)

