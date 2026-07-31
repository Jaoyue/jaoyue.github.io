**HttpServlet是在继承GenericServlet的基础上进一步的扩展。提供将要被子类化以创建适用于Web站点的HTTP servlet的抽象类。**

**HTTPServlet的子类可以重写父类的方法，该方法通常是：**

- doGet()：用于HTTP GET请求
- doPost()：用于HTTP POST请求
- doPut()：用于HTTP PUT请求
- doDelete()：用于HTTP DELETE请求

### 自定义Servlet

Servlet两种创建方式:

1. 实现Servlet接口, 使用这种方式创建Servlet类比较麻烦，需要重写Servlet接口中的所有方法

```
public class MyServlet01 implements Servlet {
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
 
    }
 
    @Override
    public ServletConfig getServletConfig() {
        return null;
    }
 
    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {
        System.out.println("使用实现Servlet接口创建的MyServlet类");
        servletResponse.getWriter().println("Servlet is very interesting ");
    }
 
    @Override
    public String getServletInfo() {
        return null;
    }
 
    @Override
    public void destroy() {
 
    }
}
```

2. 继承HttpServlet（推荐使用）

```
public class InitServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(InitServlet.class);

    private static final Properties p = new Properties();

    /*
     * 初始化 init方法在应用实例创建时就会执行, 适合在项目初始化的时候加载一些资源
     */
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {

        logger.info("##########################");
        logger.info("ecovacs-store-api start...");
        logger.info("##########################");

        try {
            Constants.MyDomain = SystemDomain.STORE;
            initProperties();
            MemCachedManager.init(p);
            initCache();
            WXConfigure.initWXConfig(p); //微信config 配置
            AliPayConfigs.initAliPayConfig(p);
            initLTS();
        } catch (Exception e) {
            logger.error("InitServlet初始化失败", e);
            throw new ServletException("ecovacs-store-api start error!");
        }
        logger.info("ecovacs-store-api 当前时间："+ DateUtil.convertDateToDateString("yyyy-MM-dd HH:mm:ss:ZZZ",new Date()));
        logger.info("ecovacs-store-api end...");
        super.init(servletConfig);
    }

}
```

### Servlet两张配置方式

1. 使用web.xml配置

```

<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <servlet>
        <!-- Servlet名称 -->
        <servlet-name>myServlet01</servlet-name>
        <!-- Servlet的全称类名 -->
        <servlet-class>com.cxyzxc.www.servlet01.MyServlet01</servlet-class>
       <!-- 启动的优先级，数字越小越先起作用 -->
        <load-on-startup>1</load-on-startup>
    </servlet>
 
    <!-- Servlet映射配置 -->
    <servlet-mapping>
        <!-- Servlet名称 -->
        <servlet-name>myServlet01</servlet-name>
        <!-- 资源的匹配原则：精确匹配 -->
        <url-pattern>/servlet01</url-pattern>
    </servlet-mapping>
</web-app>
```

2. 注释配置

```

@WebServlet("/*")
public class MyServlet02 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("使用继承HttpServlet类创建的MyServlet类");
        resp.getWriter().println("Servlet is very funny ");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
```

#### @WebServlet注解常用属性

- name：Servlet名字（可选）
- value：配置url路径，可以配置多个
- urlPatterns：配置url路径，和value作用一样，不能同时使用
- loadOnStartup：配置Servlet的创建的时机，如果是0或者正数，启动程序时创建，如果是负数，则访问时创建。数字越小优先级越高。
- 注: 如果要重写HttpServlet的service方法或get/post/put/delete方法, 必须要添加@WebServlet注解, 否则重写的方法不生效
- HttpServlet的service执行顺序在spring拦截器之前