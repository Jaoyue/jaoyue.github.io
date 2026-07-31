> HTML 页面: [[page/wiki/data/后端应用/Java过滤器.html|打开 HTML 页面]]

### <font style="color:rgb(77, 77, 77);">filter也称之为过滤器，它是</font>[javaWeb](https://so.csdn.net/so/search?q=javaWeb&spm=1001.2101.3001.7020)<font style="color:rgb(77, 77, 77);">三大组件之一（Servlet程序、Listener监听器、Filter过滤器）, 既可以对请求进行拦截，也可以对响应进行处理.</font>
**<font style="color:rgb(77, 77, 77);">要想调用配置一个过滤器：</font>**

**<font style="color:rgb(77, 77, 77);">1）启动类上增加注解</font>****<font style="color:rgb(77, 77, 77);">@ServletComponentScan</font>**

**<font style="color:rgb(77, 77, 77);">2）新建一个类使其实现Filter接口，并实现里面的三个方法</font>**

**<font style="color:rgb(77, 77, 77);">3）在新建类上加上@WebFilter()注解，配置需要拦截的规则</font>**

**<font style="color:rgb(77, 77, 77);">4）在doFilter方法中控制filterChain.doFilter(servletRequest, servletResponse)调用</font>**

**<font style="color:rgb(77, 77, 77);">同样，如果前后端交互有遇到跨域问题的，也可以通过Filter解决（亲测有效）</font>**

**<font style="color:rgb(77, 77, 77);">示例:</font>**

```java
package com.tineco.domestic.marketing.common;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Component
public class BaseFilter implements Filter {
    Logger logger = LogManager.getLogger(BaseFilter.class);
    /**
     * web应用启动时，web服务器将创建Filter的实例对象，并调用init方法，读取web.xml的配置，完成对象的初始化功能，
     * 从而为后续的用户请求做好拦截的准备工作（filter对象只会创建一次，init方法也只会执行一次，开发人员通过init的参数，
     * 可或得代表当前filter配置信息的FilterConfig对象）
     * @param filterConfig
     * @throws ServletException
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    /**
     * 这个方法完成实际的过滤操作，当客户请求访问与过滤器相关联的URL的时候，Servlet过滤器将先执行doFilter方法，FilterChain参数用于访问后续过滤器
     * @param servletRequest
     * @param servletResponse
     * @param filterChain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        String requestURI = request.getRequestURI();
        String uid = request.getParameter("uid");
        //请求开始时间
        Long dateStart = System.currentTimeMillis();
        filterChain.doFilter(servletRequest,servletResponse);
        logger.error("[IP:" + servletRequest.getRemoteHost() + " User:" + uid + "]>>" + "Request url: " + requestURI + "; Request times: " + (System.currentTimeMillis() - dateStart) + "ms");
    }

    /**
     * filter创建后会保存在内存中，当web应用移除或者服务器停止时才销毁，该方法在Filter的生命周期中仅执行一次，在这个方法中，可以释放过滤器使用的资源
     */
    @Override
    public void destroy() {

    }
}

```

#### 除了在启动类上添加注解, 也可以通过在启动类里添加Bean注册
```java

@SpringBootApplication
public class SpringbootInterceptorApplication {
 
    public static void main(String[] args) {
        SpringApplication.run(SpringbootInterceptorApplication.class, args);
    }
 
 
    /**
     * 注册Filter
     */
    @Bean
    public FilterRegistrationBean getFilterRegistrationBean(){
        FilterRegistrationBean bean = new FilterRegistrationBean(new MyFilterOne());
        //bean.addUrlPatterns(new String[]{"*.do","*.jsp"});
        bean.addUrlPatterns("/*");
        return bean;
    }

}
```

### filter解决跨域:
```java
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
 
public class CorsFilter implements Filter {
 
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 过滤器初始化
    }
 
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse) response;
 
        // 允许所有源
        res.setHeader("Access-Control-Allow-Origin", "*");
        // 允许的HTTP方法
        res.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, PUT");
        // 允许的头信息字段
        res.setHeader("Access-Control-Allow-Headers", "Content-Type, api_key, Authorization");
        // 是否需要凭据
        res.setHeader("Access-Control-Allow-Credentials", "true");
 
        chain.doFilter(request, response);
    }
 
    @Override
    public void destroy() {
        // 过滤器销毁
    }
}
```

```xml
<filter>
  <filter-name>CorsFilter</filter-name>
  <filter-class>com.yourpackage.CorsFilter</filter-class>
</filter>
<filter-mapping>
  <filter-name>CorsFilter</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
```

