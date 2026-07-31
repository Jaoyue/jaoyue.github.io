> HTML 页面: [[page/wiki/data/添可项目/派恩/dify平台/接口对接/es_接口.html|打开 HTML 页面]]

```json
{
			"name": "es",
			"item": [
				{
					"name": "查询系列是否存在",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n                  \"query\": {\r\n                    \"term\": {\r\n                      \"series_name\": {\r\n                        \"value\": \"芙万4.0系列\"\r\n                      }\r\n                    }\r\n                  }\r\n                }",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "http://10.108.128.30:9200/series_match/_search",
							"protocol": "http",
							"host": [
								"10",
								"108",
								"128",
								"30"
							],
							"port": "9200",
							"path": [
								"series_match",
								"_search"
							]
						}
					},
					"response": []
				},
				{
					"name": "新建系列",
					"request": {
						"method": "POST",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n  \"series_name\": \"芙万4.0系列\",\r\n  \"series_no\": \"p00019\"\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "http://10.108.128.30:9200/series_match/_doc/p00019",
							"protocol": "http",
							"host": [
								"10",
								"108",
								"128",
								"30"
							],
							"port": "9200",
							"path": [
								"series_match",
								"_doc",
								"p00019"
							]
						}
					},
					"response": []
				},
				{
					"name": "查询索引是否存在",
					"request": {
						"method": "GET",
						"header": [],
						"url": {
							"raw": "http://10.108.128.30:9200/_cat/indices/p00019?h=index",
							"protocol": "http",
							"host": [
								"10",
								"108",
								"128",
								"30"
							],
							"port": "9200",
							"path": [
								"_cat",
								"indices",
								"p00019"
							],
							"query": [
								{
									"key": "h",
									"value": "index"
								}
							]
						}
					},
					"response": []
				},
				{
					"name": "创建索引",
					"request": {
						"method": "PUT",
						"header": [],
						"body": {
							"mode": "raw",
							"raw": "{\r\n  \"settings\": {\r\n    \"number_of_shards\": 1,\r\n    \"number_of_replicas\": 0\r\n  },\r\n  \"mappings\": {\r\n    \"properties\": {\r\n      \"repair_order_number\": {\r\n        \"type\": \"keyword\"\r\n      },\r\n      \"fault_class\": {\r\n        \"type\": \"text\",\r\n        \"analyzer\": \"ik_max_word\",\r\n        \"fields\": {\r\n          \"keyword\": {\r\n            \"type\": \"keyword\"\r\n          }\r\n        }\r\n      },\r\n      \"check_describe\": {\r\n        \"type\": \"text\",\r\n        \"analyzer\": \"ik_max_word\",\r\n        \"fields\": {\r\n          \"keyword\": {\r\n            \"type\": \"keyword\"\r\n          }\r\n        }\r\n      },\r\n      \"actual_fault\": {\r\n        \"type\": \"text\",\r\n        \"analyzer\": \"ik_max_word\",\r\n        \"fields\": {\r\n          \"keyword\": {\r\n            \"type\": \"keyword\"\r\n          }\r\n        }\r\n      },\r\n      \"bom_name\": {\r\n        \"type\": \"keyword\"\r\n      },\r\n      \"bom_sap\": {\r\n        \"type\": \"keyword\"\r\n      },\r\n      \"qty\": {\r\n        \"type\": \"integer\"\r\n      }\r\n    }\r\n  }\r\n}",
							"options": {
								"raw": {
									"language": "json"
								}
							}
						},
						"url": {
							"raw": "http://10.108.128.30:9200/p00020",
							"protocol": "http",
							"host": [
								"10",
								"108",
								"128",
								"30"
							],
							"port": "9200",
							"path": [
								"p00020"
							]
						}
					},
					"response": []
				}
			]
		}
```

