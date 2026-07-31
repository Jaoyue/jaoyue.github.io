> HTML 页面: [[page/wiki/data/工具/Java/AbstractProcessor注解处理器.html|打开 HTML 页面]]

示例: [Java注解编译期处理AbstractProcessor详解 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/625759003)

[好玩的编译时注解处理工具——APT_annotationprocessorpaths-CSDN博客](https://blog.csdn.net/qq_31142553/article/details/103843936)  
注: 尝试使用了@AutoService注解, 没有成功

### 编写注解处理器module

```
package com.processor;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.SOURCE)
@Target(ElementType.METHOD)
public @interface Building {
}
```

```
package com.processor;

import javax.annotation.processing.*;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.Element;
import javax.lang.model.element.TypeElement;
import javax.lang.model.type.ExecutableType;
import javax.tools.Diagnostic;
import javax.tools.JavaFileObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@SupportedAnnotationTypes("com.processor.Building")
@SupportedSourceVersion(SourceVersion.RELEASE_7)
public class BuildingProcessor extends AbstractProcessor {
    @Override
    public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment roundEnv) {

        System.out.println("SzzBuildProcessor.process ;");

        for (TypeElement annotation : annotations) {
            // 获取所有被该注解标记过的实例
            Set<? extends Element> annotatedElements = roundEnv.getElementsAnnotatedWith(annotation);

            // 按照需求检查注解使用的是否正确，以set开头，并且参数只有一个
            Map<Boolean, List<Element>> annotatedMethods = new HashMap<Boolean, List<Element>>();
            annotatedMethods.put(true, new ArrayList<Element>());
            annotatedMethods.put(false, new ArrayList<Element>());

            for (Element element : annotatedElements) {
                boolean isSetter = ((ExecutableType) element.asType()).getParameterTypes().size() == 1
                        && element.getSimpleName().toString().startsWith("set");
                annotatedMethods.get(isSetter).add(element);
            }

            List<Element> setters = annotatedMethods.get(true);
            List<Element> otherMethods = annotatedMethods.get(false);

            // 打印注解使用错误的case
            for (Element element : otherMethods) {
                processingEnv.getMessager().printMessage(Diagnostic.Kind.ERROR,
                        "@BuilderProperty 注解必须放到方法上并且是set开头的单参数方法", element);
            }

            if (setters.isEmpty()) {
                continue;
            }

            Map<String, List<Element>> groupMap = new HashMap<String, List<Element>>();

            // 按照全限定类名分组。一个类创建一个Build
            for (Element setter : setters) {
                // 全限定类名
                String className = ((TypeElement) setter.getEnclosingElement()).getQualifiedName().toString();
                List<Element> elements = groupMap.get(className);
                if (elements != null) {
                    elements.add(setter);
                } else {
                    List<Element> newElements = new ArrayList<Element>();
                    newElements.add(setter);
                    groupMap.put(className, newElements);
                }
            }

            for (Map.Entry<String, List<Element>> entry : groupMap.entrySet()) {
                String groupSetterKey = entry.getKey();
                List<Element> groupSetterValue = entry.getValue();

                // 获取类名SimpleName和set方法的入参
                Map<String, String> setterMap = new HashMap<String, String>();
                for (Element setter : groupSetterValue) {
                    String methodName = setter.getSimpleName().toString();
                    String argumentType = ((ExecutableType) setter.asType()).getParameterTypes().get(0).toString();
                    setterMap.put(methodName, argumentType);
                }

                try {
                    // 组装XXXBuild类。并创建对应的类文件
                    writeBuilderFile(groupSetterKey, setterMap);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }

        // 返回false表示当前处理器处理了之后其他的处理器也可以接着处理，返回true表示，我处理完了之后其他处理器不再处理
        return true;
    }

    private void writeBuilderFile(String className, Map<String, String> setterMap) throws IOException {

        String packageName = null;
        int lastDot = className.lastIndexOf('.');
        if (lastDot > 0) {
            packageName = className.substring(0, lastDot);
        }

        String simpleClassName = className.substring(lastDot + 1);
        String builderClassName = className + "Builder";
        String builderSimpleClassName = builderClassName.substring(lastDot + 1);

        JavaFileObject builderFile = processingEnv.getFiler().createSourceFile(builderClassName);

        try (PrintWriter out = new PrintWriter(builderFile.openWriter())) {

            if (packageName != null) {
                out.print("package ");
                out.print(packageName);
                out.println(";");
                out.println();
            }

            out.print("public class ");
            out.print(builderSimpleClassName);
            out.println(" {");
            out.println();

            out.print("    private ");
            out.print(simpleClassName);
            out.print(" object = new ");
            out.print(simpleClassName);
            out.println("();");
            out.println();

            out.print("    public ");
            out.print(simpleClassName);
            out.println(" build() {");
            out.println("        return object;");
            out.println("    }");
            out.println();

            for (Map.Entry<String, String> setter : setterMap.entrySet()) {
                String methodName = setter.getKey();
                String argumentType = setter.getValue();

                out.print("    public ");
                out.print(builderSimpleClassName);
                out.print(" ");
                out.print(methodName);

                out.print("(");

                out.print(argumentType);
                out.println(" value) {");
                out.print("        object.");
                out.print(methodName);
                out.println("(value);");
                out.println("        return this;");
                out.println("    }");
                out.println();
            }

            out.println("}");
        }
    }

    @Override
    public synchronized void init(ProcessingEnvironment processingEnv) {
        super.init(processingEnv);
        System.out.println("----------");

        System.out.println(processingEnv.getOptions());
    }
}
```

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>


   <groupId>com.ecovacs</groupId>
    <artifactId>store-processor</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>jar</packaging>


    <dependencies>
        <dependency>
            <groupId>com.sun</groupId>
            <artifactId>tools</artifactId>
            <version>1.7</version>
            <scope>system</scope>
            <systemPath>${java.home}/../lib/tools.jar</systemPath>
        </dependency>
        <dependency>
            <groupId>org.javassist</groupId>
            <artifactId>javassist</artifactId>
            <version>3.18.0-GA</version>
        </dependency>

    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.7</source>
                    <target>1.7</target>
<!--                    重要配置, 不加的话会报错 -->
                    <compilerArgument>-proc:none</compilerArgument>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
```

```
com.processor.BuildingProcessor
```

### 使用maven命令 mvn clean install 编译module成jar包

### 项目中引入依赖

```
<dependency>
            <groupId>com.ecovacs</groupId>
            <artifactId>store-processor</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
```

**下面的配置千万别加,除非项目里没有其他的注解处理器,但这是不可能的,lombok和slf4都是基于注解处理器实现的**

```
<!--<plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <encoding>${project.build.sourceEncoding}</encoding>
                    <source>1.7</source>
                    <target>1.7</target>
                   &lt;!&ndash; <annotationProcessorPaths>
                        <path>
                            <groupId>com.ecovacs</groupId>
                            <artifactId>store-processor</artifactId>
                            <version>1.0-SNAPSHOT</version>
                        </path>
                    </annotationProcessorPaths>&ndash;&gt;
                </configuration>
            </plugin>-->
```

```
package com.ecovacs.store.api.domain.order;

import com.ecovacs.common.constants.Constants;
import com.ecovacs.store.dto.order.SpSalesOrderDTO;
import com.processor.Building;
import org.springframework.data.domain.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xinyu.qiu on 2016/7/20.
 */
public class SalesOrderListResponse {
    private Integer hasNextPage;//1：有下一页0：没有下一页
    private List<SalesOrderInfoResponse> items;

    public SalesOrderListResponse(Page<SpSalesOrderDTO> salesOrderDTOPage) {
        hasNextPage = salesOrderDTOPage.hasNext() ? Constants.BOOLEAN_TRUE_FLAG : Constants.BOOLEAN_FALSE_FLAG;
        items = new ArrayList<>();
        for (SpSalesOrderDTO salesOrderDTO : salesOrderDTOPage.getContent()) {
            SalesOrderInfoResponse salesOrderInfoResponse = new SalesOrderInfoResponse(salesOrderDTO);
            items.add(salesOrderInfoResponse);
        }
    }

    public SalesOrderListResponse() {
    }
    public Integer getHasNextPage() {
        return hasNextPage;
    }
    @Building
    public void setHasNextPage(Integer hasNextPage) {
        this.hasNextPage = hasNextPage;
    }

    public List<SalesOrderInfoResponse> getItems() {
        return items;
    }

    public void setItems(List<SalesOrderInfoResponse> items) {
        this.items = items;
    }
}
```

### 编译后生成builder类的class文件

```
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.ecovacs.store.api.domain.order;

public class SalesOrderListResponseBuilder {
    private SalesOrderListResponse object = new SalesOrderListResponse();

    public SalesOrderListResponseBuilder() {
    }

    public SalesOrderListResponse build() {
        return this.object;
    }

    public SalesOrderListResponseBuilder setHasNextPage(Integer value) {
        this.object.setHasNextPage(value);
        return this;
    }
}
```