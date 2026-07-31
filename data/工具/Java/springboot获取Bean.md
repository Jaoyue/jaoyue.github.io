> HTML 页面: [[page/wiki/data/工具/Java/springboot获取Bean.html|打开 HTML 页面]]

### 1. **通过Spring上下文获取Bean**

如果你有Spring上下文的引用，可以通过上下文来获取Bean实例。这是最常见的方法。

```
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class MyApp {
    public static void main(String[] args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
        MyService myService = context.getBean(MyService.class);
        myService.doSomething();
    }
}
```

### 2. **通过**`**ApplicationContextAware**`**接口**

实现`ApplicationContextAware`接口可以让你的类获取到Spring上下文，从而获取Bean。

```
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class MyBeanProvider implements ApplicationContextAware {

    private static ApplicationContext context;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) {
        context = applicationContext;
    }

    public static <T> T getBean(Class<T> beanClass) {
        return context.getBean(beanClass);
    }
}
```

### 3. **通过静态方法获取**

结合`ApplicationContextAware`和静态方法，可以在非Spring管理的类中获取Bean。

```
public class BeanUtil implements ApplicationContextAware {

    private static ApplicationContext context;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) {
        context = applicationContext;
    }

    public static <T> T getBean(Class<T> beanClass) {
        return context.getBean(beanClass);
    }
}
```

### 4. 使用`ListableBeanFactory`获取Bean

```
package com.ecovacs.core;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ListableBeanFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;

import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


public class ServiceManager {
    private static Logger logger = LoggerFactory.getLogger(ServiceManager.class);

    private static ListableBeanFactory factory;

    private static final Map<Object, Object> cache = new ConcurrentHashMap<Object, Object>();

    public static void setApplicationContext(ListableBeanFactory factory) {
        ServiceManager.factory = factory;
    }

	private static <T> T getBeanByClass(Class<T> clazz) {
        try {
            return factory.getBean(clazz);
        } catch (NoSuchBeanDefinitionException e) {
            Map clazzes = factory.getBeansOfType(clazz);
            for (Iterator i$ = clazzes.values().iterator(); i$.hasNext(); ) {
                Object entry = i$.next();
                if (clazz.isInterface()) {
                    Class[] interfaces = entry.getClass().getInterfaces();
                    for (Class c : interfaces) {
                        if (c.isAssignableFrom(clazz))
                            return (T) entry;
                    }
                } else if (clazz.isAssignableFrom(entry.getClass())) {
                    return (T) entry;
                }
            }
            throw new NoSuchBeanDefinitionException(clazz, "ServiceManager can not find bean !");
        } finally {

        }
    }

	public static <T> T getService(Class<T> clazz){
        T service = (T) cache.get(clazz);
        if (service != null) {
            return service;
        }
        if (logger.isDebugEnabled()) {
            logger.debug(" ServiceManager lookup service clazz = '" + clazz + "'");
        }
        service = getBeanByClass(clazz);
        if (logger.isDebugEnabled()) {
            logger.debug(" return service object:" + service);
        }
        cache.put(clazz, service);
        return service;
    }
}
```