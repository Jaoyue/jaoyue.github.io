> HTML 页面: [[page/wiki/data/工具/小玩意/代码生成工具-基于mybatis(高斯框架).html|打开 HTML 页面]]

```java
@Test
public void contextLoaded() throws Exception {
    CodeGeneratorUtil.init("jdbc:mysql://10.108.132.13:3306/dbu_asm_front?useUnicode=true&characterEncoding=utf-8",
            "root", "abc123", "com.tineco.dbu.after", "", true);
    CodeGeneratorUtil.autoGenerator("asm_user", "");
}
```

```java
package gauss.boot.mybatis.utils;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import gauss.boot.common.utils.StreamUtil;
import gauss.boot.mybatis.entity.BaseEntity;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;

import java.io.File;
import java.io.StringWriter;
import java.util.Map;

/**
 * 代码生成器
 *
 * @author wangcheng
 * 2021/10/9
 **/
public class CodeGeneratorUtil {

    /**
     * 代码包名字
     */
    public static String PACKAGE_NAME;

    /**
     * maven module
     */
    public static String MODULE_NAME = "";

    /**
     * class路径
     */
    public static final String SRC_MAIN_JAVA = "src/main/java";

    /**
     * Resource路径
     */
    public static final String SRC_MAIN_RESOURCES = "src/main/resources";

    /**
     * 作者
     */
    public static final String AUTHOR = System.getProperty("user.name");

    /**
     * 项目路径
     */
    public static String PROJECT_PATH = System.getProperty("user.dir");

    /**
     * 数据库驱动
     */
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    /**
     * 数据库链接
     */
    private static String JDBC_MYSQL_URL;

    /**
     * 数据库用户名
     */
    private static String JDBC_USERNAME;

    /**
     * 数据库密码
     */
    private static String JDBC_PASSWORD;

    /**
     * 自动生成增删改查借口
     */
    public static Boolean AUTO_GENERATOR_CRUD = false;

    /**
     * 初始化数据
     *
     * @param url         数据库链接：jdbc:mysql://localhost:3306/auth_service?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8
     * @param username    数据库用户名：root
     * @param password    数据库密码：root
     * @param packageName 包名，例如：com.tineco.user
     * @param moduleName  模块名 生成到某个maven子模块
     **/
    public static void init(String url, String username, String password, String packageName, String moduleName) {
        CodeGeneratorUtil.JDBC_MYSQL_URL = url;
        CodeGeneratorUtil.JDBC_USERNAME = username;
        CodeGeneratorUtil.JDBC_PASSWORD = password;
        CodeGeneratorUtil.PACKAGE_NAME = packageName;
        CodeGeneratorUtil.MODULE_NAME = moduleName;
    }

    /**
     * 初始化数据
     *
     * @param url          数据库链接：jdbc:mysql://localhost:3306/auth_service?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8
     * @param username     数据库用户名：root
     * @param password     数据库密码：root
     * @param packageName  包名，例如：com.tineco.user
     * @param moduleName   模块名 生成到某个maven子模块
     * @param generateCRUD 是否自动生成crud
     */
    public static void init(String url, String username, String password, String packageName, String moduleName, Boolean generateCRUD) {
        init(url, username, password, packageName, moduleName);
        CodeGeneratorUtil.AUTO_GENERATOR_CRUD = generateCRUD;
    }

    /**
     * 开始自动生成
     *
     * @param tableName   可以多个，以,分割，例如：user,role,app
     * @param tablePrefix 表前缀 比如 t_
     */
    public static void autoGenerator(String tableName, String tablePrefix) {
        // 代码生成器
        new AutoGenerator(new DataSourceConfig
                .Builder(CodeGeneratorUtil.JDBC_MYSQL_URL, CodeGeneratorUtil.JDBC_USERNAME, CodeGeneratorUtil.JDBC_PASSWORD)
                .build())
                .global(new GlobalConfig.Builder()
                        .outputDir(PROJECT_PATH + File.separator + MODULE_NAME + File.separator + SRC_MAIN_JAVA)
                        .author(AUTHOR)
                        .openDir(false)
                        .commentDate("yyyy-MM-dd HH:mm")
                        .enableSwagger()
                        .dateType(DateType.ONLY_DATE)
                        .fileOverride()
                        .build()
                ).packageInfo(new PackageConfig.Builder()// 包配置
                .parent(PACKAGE_NAME)
                .moduleName(MODULE_NAME)
                .controller("controller")
                .entity("entity")
                .service("service")
                .serviceImpl("service.impl")
                .mapper("mapper")
                .build()
        ).strategy(new StrategyConfig.Builder()// 策略配置
                .enableCapitalMode()// 全局大写命名
                .addInclude(tableName.split(","))// 排除生成的表 sys_user
                .addTablePrefix(tablePrefix) // 表前缀
                .enableSkipView() //跳过视图
                .controllerBuilder()
                .enableRestStyle() //@RestController 注解
                .enableHyphenStyle() //url中驼峰转连字符
                .formatFileName("%sController")
                .entityBuilder()
                .enableLombok()// lombok 模型
                .enableChainModel() // 链式操作
                .enableSerialVersionUID()
                .idType(IdType.ASSIGN_ID)
                .superClass(BaseEntity.class)
                .naming(NamingStrategy.underline_to_camel)
                .enableTableFieldAnnotation()
                .serviceBuilder()
                .formatServiceFileName("I%sService")
                .formatServiceImplFileName("%sServiceImpl")
                .mapperBuilder()
                .build()
        ).template(new TemplateConfig.Builder()
                .entity("/templates-generator/entity.java.vm")
                .controller("/templates-generator/controller.java.vm")
                .service("/templates-generator/service.java.vm", "/templates-generator/serviceImpl.java.vm")
                .mapper("/templates-generator/mapper.java.vm")
                .disable(TemplateType.XML)
                .build()
        ).injection(new CustomInjectionConfig()).execute();
    }

    /**
     * 自定义注入配置器
     */
    public static class CustomInjectionConfig extends InjectionConfig {

        public CustomInjectionConfig() {
            super();
        }

        @Override
        public void beforeOutputFile(TableInfo tableInfo, Map<String, Object> objectMap) {
            super.beforeOutputFile(tableInfo, objectMap);
            objectMap.put("AUTO_GENERATOR_CRUD", AUTO_GENERATOR_CRUD);
            //生成xml文件
            VelocityEngine velocityEngine = new VelocityEngine();
            velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
            velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
            velocityEngine.init();
            Template template = velocityEngine.getTemplate("/templates-generator/mapper.xml.vm");
            VelocityContext ctx = new VelocityContext();
            objectMap.forEach(ctx::put);
            StringWriter sw = new StringWriter();
            template.merge(ctx, sw);
            String XML_RESOURCE_PATH = PROJECT_PATH + File.separator + MODULE_NAME + File.separator + SRC_MAIN_RESOURCES + File.separator + "mapper";
            StreamUtil.stringWriteFile(sw.toString(), XML_RESOURCE_PATH + File.separator + tableInfo.getXmlName() + ".xml");
        }
    }
}

```

```java
package gauss.boot.mybatis.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.Version;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * @author wangcheng
 * 2021/10/9
 **/
@Data
@Accessors(chain = true)
public class BaseEntity implements Serializable {

    /**
     * 创建人
     */
    @ApiModelProperty(hidden = true)
    @TableField(value = "create_by", fill = FieldFill.INSERT)
    private String createBy;

    /**
     * 创建时间
     */
    @ApiModelProperty(hidden = true)
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新人
     */
    @ApiModelProperty(hidden = true)
    @TableField(value = "update_by", fill = FieldFill.INSERT_UPDATE)
    private String updateBy;

    /**
     * 更新时间
     */
    @ApiModelProperty(hidden = true)
    @TableField(value = "update_time", fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 乐观锁版本号
     */
    @ApiModelProperty(hidden = true)
    @Version
    @TableField(fill = FieldFill.INSERT)
    private Integer version;

    /**
     * 是否删除
     */
    @ApiModelProperty(hidden = true)
    @TableLogic
    @TableField("is_deleted")
    private Boolean isDeleted = false;
}

```

```java
package gauss.boot.common.utils;

import gauss.boot.common.exception.BusinessException;
import org.apache.commons.lang3.StringUtils;

import java.io.*;

/**
 * 流处理工具
 * @author wangcheng
 */
public class StreamUtil {

    /**
     * 流转字符串
     * @param is 输入流
     * @return 字符串
     */
    public static String streamToString(InputStream is) {
        StringBuilder result = new StringBuilder();
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line).append("\n\r");
            }
        } catch (Exception e) {
            throw new BusinessException(e);
        } finally {
            closeStream(br);
            closeStream(isr);
        }
        return result.toString();
    }

    /**
     * 流转文件
     * @param is 输入流
     * @param filePath 文件路径
     * @return 文件
     */
    public static File streamWriteFile(InputStream is, String filePath) {
        return StreamUtil.streamWriteFile(is, filePath, null);
    }

    /**
     * 流输出文件
     * @param is 输入流
     * @param filePath 文件夹路径
     * @param fileName 文件名称
     * @return 文件
     */
    public static File streamWriteFile(InputStream is, String filePath, String fileName) {
        FileOutputStream fos = null;
        File file = StringUtils.isEmpty(fileName) ? new File(filePath) : new File(filePath, fileName);
        try {
            FileUtil.createNewFile(file);
            fos = new FileOutputStream(file);
            streamWriteStream(is, fos);
        } catch (Exception e) {
            throw new BusinessException(e);
        } finally {
            closeStream(fos);
        }
        return file;
    }

    /**
     * 文件输出到流
     * @param file 文件
     * @param os 输出流
     */
    public static void fileWriteStream(File file, OutputStream os) {
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
            streamWriteStream(fis, os);
        } catch (Exception e) {
            throw new BusinessException(e);
        } finally {
            closeStream(fis);
        }
    }

    /**
     * 流输出流
     * @param is 输入流
     * @param os 输出流
     */
    public static void streamWriteStream(InputStream is, OutputStream os) {
        try {
            byte[] b = new byte[1024];
            int len;
            while ((len = is.read(b)) > 0) {
                os.write(b, 0, len);
            }
        } catch (Exception e) {
            throw new BusinessException(e);
        }
    }

    /**
     * 文件复制
     * @param sourceFilePath 原文件路径
     * @param distFilePath 新文件路径
     * @return 新文件
     */
    public static File fileWriteFile(String sourceFilePath, String distFilePath) {
        File file = new File(sourceFilePath);
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
            return StreamUtil.streamWriteFile(fis, distFilePath);
        } catch (Exception e) {
            throw new BusinessException(e);
        } finally {
            StreamUtil.closeStream(fis);
        }
    }

    /**
     * 文本输出到文件
     * @param text 文本
     * @param filePath 文件路径
     * @return 文件
     */
    public static File stringWriteFile(String text, String filePath) {
        return StreamUtil.stringWriteFile(text, filePath, null);
    }

    /**
     * 文本输出到文件
     * @param text 文本
     * @param filePath 文件路径
     * @param fileName 文件名
     * @return 文件
     */
    public static File stringWriteFile(String text, String filePath, String fileName) {
        File file = StringUtils.isEmpty(fileName) ? new File(filePath) : new File(filePath, fileName);
        FileOutputStream fos = null;
        OutputStreamWriter osw = null;
        try {
            FileUtil.createNewFile(file);
            fos = new FileOutputStream(file);
            osw = new OutputStreamWriter(fos);
            osw.write(text);
            return file;
        } catch (Exception e) {
            throw new BusinessException(e);
        } finally {
            StreamUtil.closeStream(osw);
            StreamUtil.closeStream(fos);
        }
    }

    /**
     * 关闭流
     * @param closeable 实现关闭接口的类
     */
    public static void closeStream(Closeable closeable) {
        try {
            if (closeable != null) {
                closeable.close();
            }
        } catch (Exception ignored) {
        }
    }
}

```

