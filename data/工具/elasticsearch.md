> HTML 页面: [[page/wiki/data/工具/elasticsearch.html|打开 HTML 页面]]

Elasticsearch（简称ES）是一个分布式、可扩展、实时的搜索与数据分析引擎。ES不仅仅只是全文搜索，还支持结构化搜索、数据分析、复杂的语言处理、地理位置和对象间关联关系等。

### 倒排索引:

倒排索引包含两个部分：

- 单词词典（Term Dictionary）：记录所有文档的单词，记录单词到倒排列表的关联关系（单词词典一般比较大，通过 B+ 树或哈希拉链法实现，以满足高性能的插入与查询）
- 倒排表（Posting List）：记录了单词对应的文档结合，由倒排索引组成。

- 文档ID
- 词频 TF - 该单词在文档中分词的位置。用于语句搜索
- 位置（Position）- 单词在文档中分词的位置，用于语句搜索
- 偏移（Offset）- 记录单词的开始结束位置，实现高亮显示。

### 安装:

elasticsearch下载: [https://www.elastic.co/cn/downloads/elasticsearch](https://www.elastic.co/cn/downloads/elasticsearch)

kibana下载: [https://artifacts.elastic.co/downloads/kibana](https://artifacts.elastic.co/downloads/kibana)

ik分词器下载: [https://github.com/medcl/elasticsearch-analysis-ik/releases/download](https://github.com/medcl/elasticsearch-analysis-ik/releases/download)

### Java依赖:

注意依赖版本冲突,很多服务引用了spring-boot-dependencies,会有默认的es版本

```
        <dependency>
            <groupId>org.elasticsearch.client</groupId>
            <artifactId>elasticsearch-rest-high-level-client</artifactId>
            <version>7.10.2</version>
        </dependency>
        <dependency>
            <groupId>org.elasticsearch</groupId>
            <artifactId>elasticsearch</artifactId>
            <version>7.10.2</version>
        </dependency>
```

### Elastic工具类:

```
package com.tineco.domestic.marketing.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpHost;
import org.elasticsearch.action.admin.indices.create.CreateIndexRequest;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.support.WriteRequest;
import org.elasticsearch.action.support.master.AcknowledgedResponse;
import org.elasticsearch.action.update.UpdateRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.core.CountRequest;
import org.elasticsearch.client.core.CountResponse;
import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * Elastic工具类
 *
 * @version 7.10.2
 * @since 7.10.2
 */
public class ElasticUtils {


    private static final Log log = LogFactory.getLog(ElasticUtils.class);;

    // 相当于数据库名称（数据量小）索引名称
    public static String indexName = "indexName";
    public static String esSetPath = "src/main/resources/es/mappings_es.txt";

    private final RequestOptions options = RequestOptions.DEFAULT;

    private static ElasticUtils instance = new ElasticUtils();

    // 初始化api客户端
    public static RestHighLevelClient client = new RestHighLevelClient(
        RestClient.builder(new HttpHost("localhost", 9200, "http")));

    private ElasticUtils() {
    }

    public static ElasticUtils getInstance() {
        return instance;
    }

    /**
     * 创建索引
     *
     * @param indexName         es索引名
     * @param esSettingFilePath es索引的alias、settings和mapping的配置文件
     */
    public boolean createIndex(String indexName, String esSettingFilePath) {
        String aliases = null;
        String mappings = null;
        String settings = null;
        if (StringUtils.isEmpty(esSettingFilePath)) {
            esSettingFilePath = esSetPath;
        }
        if (StringUtils.isNotBlank(esSettingFilePath)) {
            try {
                String fileContent = readFileContent(esSettingFilePath);
                if (StringUtils.isNotBlank(fileContent)) {
                    JSONObject jsonObject = JSON.parseObject(fileContent);
                    aliases = jsonObject.getString("aliases");
                    mappings = jsonObject.getString("mappings");
                    settings = jsonObject.getString("settings");
                }
            } catch (Exception e) {
                log.error("createIndex error.", e);
                return false;
            }
        }

        if (checkIndex(indexName)) {
            log.error("createIndex indexName:已存在"+indexName);
            return false;
        }

        CreateIndexRequest request = new CreateIndexRequest(indexName);
        if ((StringUtils.isNotBlank(aliases))) {
            request.aliases(aliases);
        }

        if (StringUtils.isNotBlank(mappings)) {
            request.mapping(mappings, XContentType.JSON);
        }

        if (StringUtils.isNotBlank(settings)) {
            request.settings(settings, XContentType.JSON);
        }

        try {
            client.indices().create(request, options);
            return true;
        } catch (IOException e) {
            log.error("ElasticUtils createIndex error.", e);
            return false;
        }
    }

    private String readFileContent(String filePath) {
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            String line;
            StringBuilder stringBuilder = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                stringBuilder.append(line);
            }

            reader.close();
            return stringBuilder.toString();
        } catch (IOException e) {
            log.error("readFileContent error.", e);
        }
        return null;
    }

    public boolean checkIndex(String indexName) {
        try {
            return client.indices().exists(new GetIndexRequest(indexName), options);
        } catch (Exception e) {
            log.error("ElasticUtils checkIndex error.", e);
        }
        return false;
    }

    /**
     * 删除索引
     */
    public boolean deleteIndex(String indexName) {
        try {
            if (checkIndex(indexName)) {
                DeleteIndexRequest request = new DeleteIndexRequest(indexName);
                AcknowledgedResponse response = client.indices().delete(request, options);
                return response.isAcknowledged();
            }
        } catch (Exception e) {
            log.error("ElasticUtils deleteIndex error.", e);
        }
        return Boolean.FALSE;
    }
    public static String getIndexName() {
        return indexName;
    }

    public static void setIndexName(String indexName) {
        ElasticUtils.indexName = indexName;
    }

    public static RestHighLevelClient getClient() {
        return client;
    }

    public static void setClient(RestHighLevelClient client) {
        ElasticUtils.client = client;
    }

    /**
     * 查询总数
     */
    public Long count(String indexName) {
        CountRequest countRequest = new CountRequest(indexName);
        try {
            CountResponse countResponse = client.count(countRequest, options);
            return countResponse.getCount();
        } catch (Exception e) {
            log.error("ElasticUtils count error.", e);
        }
        return 0L;
    }

    /**
     * 查询数据集
     */
    public List<Map<String, Object>> list(String indexName, SearchSourceBuilder sourceBuilder) {
        SearchRequest searchRequest = new SearchRequest(indexName);
        searchRequest.source(sourceBuilder);
        try {
            SearchResponse searchResp = client.search(searchRequest, options);
            List<Map<String, Object>> data = new ArrayList<>();
            SearchHit[] searchHitArr = searchResp.getHits().getHits();
            for (SearchHit searchHit : searchHitArr) {
                Map<String, Object> temp = searchHit.getSourceAsMap();
                temp.put("id", searchHit.getId());
                data.add(temp);
            }
            return data;
        } catch (Exception e) {
            log.error("ElasticUtils list error.", e);
        }
        return null;
    }

    /**
     * 写入数据
     */
    public boolean insert(String indexName, Map<String, Object> dataMap) {
        try {
            BulkRequest request = new BulkRequest();
            request.add(new IndexRequest(indexName).opType("create")
                    .id(dataMap.get("id").toString())
                    .source(dataMap, XContentType.JSON));
            this.client.bulk(request, options);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("ElasticUtils insert error.", e);
        }
        return Boolean.FALSE;
    }

    /**
     * 批量写入数据
     */
    public boolean batchInsert(String indexName, List<Map<String, Object>> userIndexList) {
        try {
            BulkRequest request = new BulkRequest();
            for (Map<String, Object> dataMap : userIndexList) {
                request.add(new IndexRequest(indexName).opType("create")
                        .id(dataMap.get("id").toString())
                        .source(dataMap, XContentType.JSON));
            }
            this.client.bulk(request, options);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("ElasticUtils batchInsert error.", e);
        }
        return Boolean.FALSE;
    }

    /**
     * 根据id更新数据，可以直接修改索引结构
     *
     * @param refreshPolicy 数据刷新策略
     */
    public boolean update(String indexName, Map<String, Object> dataMap, WriteRequest.RefreshPolicy refreshPolicy) {
        try {
            UpdateRequest updateRequest = new UpdateRequest(indexName, dataMap.get("id").toString());
            updateRequest.setRefreshPolicy(refreshPolicy);
            updateRequest.doc(dataMap);
            this.client.update(updateRequest, options);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("EsDataOperation update error.", e);
        }
        return Boolean.FALSE;
    }

    /**
     * 删除数据
     */
    public boolean delete(String indexName, String id) {
        try {
            DeleteRequest deleteRequest = new DeleteRequest(indexName, id);
            this.client.delete(deleteRequest, options);
            return Boolean.TRUE;
        } catch (Exception e) {
            log.error("EsDataOperation delete error.", e);
        }
        return Boolean.FALSE;
    }
}
```