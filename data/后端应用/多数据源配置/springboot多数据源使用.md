> HTML 页面: [[page/wiki/data/后端应用/多数据源配置/springboot多数据源使用.html|打开 HTML 页面]]

### yml文件配置,配置多数据源
```java
spring:
  datasource:
    dynamic:
      primary: saaf
      datasource:
        saaf:
          url: jdbc:mysql://tstcombinetdb.tineco.com:3390/css_saaf_tst?useUnicode=true&allowPublicKeyRetrieval=true&useSSL=false&characterEncoding=utf8
          username: cssbasetster
          password: cssbasetster14pm
          driver-class-name: com.mysql.cj.jdbc.Driver
        log:
          url: jdbc:mysql://tstcombinetdb.tineco.com:3390/css_log_tst?useUnicode=true&allowPublicKeyRetrieval=true&useSSL=false&characterEncoding=utf8
          username: cssbasetster
          password: cssbasetster14pm
          driver-class-name: com.mysql.cj.jdbc.Driver
        gomssaaf:
          url: jdbc:mysql://tstcombinetdb.tineco.com:3390/saaf?useUnicode=true&allowPublicKeyRetrieval=true&useSSL=false&characterEncoding=utf8
          username: gomstdbdev
          password: gomstdbdev_15pm;
          driver-class-name: com.mysql.cj.jdbc.Driver
        serve:
          url: jdbc:mysql://tstcombinetdb.tineco.com:3390/css_serve_tst?useUnicode=true&allowPublicKeyRetrieval=true&useSSL=false&characterEncoding=utf8
          username: cssbasetster
          password: cssbasetster14pm
          driver-class-name: com.mysql.cj.jdbc.Driver
        mdb:
          url: jdbc:sqlserver://192.168.100.19:1433;databaseName=MDB
          username: dbuuser
          password: Dbuuser@init2024
          driver-class-name: com.microsoft.sqlserver.jdbc.SQLServerDriver
```

### <font style="color:rgb(31, 35, 40);">2. 使用Spring的</font>`<font style="color:rgb(31, 35, 40);">@Primary</font>`<font style="color:rgb(31, 35, 40);">注解</font>
<font style="color:rgb(31, 35, 40);">在你的配置中，你已经指定了一个</font>`<font style="color:rgb(31, 35, 40);">primary</font>`<font style="color:rgb(31, 35, 40);">数据源（</font>`<font style="color:rgb(31, 35, 40);">saaf</font>`<font style="color:rgb(31, 35, 40);">）。这意味着在没有明确指定数据源的情况下，Spring会默认使用这个数据源。</font>

### <font style="color:rgb(31, 35, 40);">3. 创建数据源配置类</font>
<font style="color:rgb(31, 35, 40);">你需要创建一个Java配置类来配置这些数据源。你可以使用</font>`<font style="color:rgb(31, 35, 40);">@Configuration</font>`<font style="color:rgb(31, 35, 40);">注解来定义这个类，并使用</font>`<font style="color:rgb(31, 35, 40);">@Bean</font>`<font style="color:rgb(31, 35, 40);">注解来定义每个数据源。</font>

```java
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {

    @Primary
    @Bean(name = "saafDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.saaf")
    public DataSource saafDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "logDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.log")
    public DataSource logDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "gomssaafDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.gomssaaf")
    public DataSource gomssaafDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "serveDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.serve")
    public DataSource serveDataSource() {
        return DataSourceBuilder.create().build();
    }

    @Bean(name = "mdbDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.mdb")
    public DataSource mdbDataSource() {
        return DataSourceBuilder.create().build();
    }
}

```

### <font style="color:rgb(31, 35, 40);">4. 使用</font>`<font style="color:rgb(31, 35, 40);">@Qualifier</font>`<font style="color:rgb(31, 35, 40);">注解来选择数据源</font>
<font style="color:rgb(31, 35, 40);">在需要使用特定数据源的地方，你可以使用</font>`<font style="color:rgb(31, 35, 40);">@Qualifier</font>`<font style="color:rgb(31, 35, 40);">注解来选择数据源。</font>

```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class MyService {

    private final JdbcTemplate saafJdbcTemplate;
    private final JdbcTemplate logJdbcTemplate;

    @Autowired
    public MyService(@Qualifier("saafDataSource") DataSource saafDataSource,
                     @Qualifier("logDataSource") DataSource logDataSource) {
        this.saafJdbcTemplate = new JdbcTemplate(saafDataSource);
        this.logJdbcTemplate = new JdbcTemplate(logDataSource);
    }

    public void performDatabaseOperations() {
        // 使用saafJdbcTemplate进行数据库操作
        saafJdbcTemplate.query("SELECT * FROM some_table", (rs, rowNum) -> {
            // 处理结果集
        });

        // 使用logJdbcTemplate进行数据库操作
        logJdbcTemplate.query("SELECT * FROM another_table", (rs, rowNum) -> {
            // 处理结果集
        });
    }
}

```

### <font style="color:rgb(31, 35, 40);">5. 使用事务管理</font>
<font style="color:rgb(31, 35, 40);">如果你需要在多个数据源之间进行事务管理，可以使用Spring的</font>`<font style="color:rgb(31, 35, 40);">@Transactional</font>`<font style="color:rgb(31, 35, 40);">注解，结合</font>`<font style="color:rgb(31, 35, 40);">PlatformTransactionManager</font>`<font style="color:rgb(31, 35, 40);">来实现。</font>

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.transaction.ChainedTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class TransactionManagerConfig {

    @Bean
    public PlatformTransactionManager transactionManager(
            @Qualifier("saafTransactionManager") PlatformTransactionManager saafTransactionManager,
            @Qualifier("logTransactionManager") PlatformTransactionManager logTransactionManager) {
        return new ChainedTransactionManager(saafTransactionManager, logTransactionManager);
    }
}

```

