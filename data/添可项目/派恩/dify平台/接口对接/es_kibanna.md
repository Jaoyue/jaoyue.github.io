```json
GET /series_match/_search
{
  "query": {
    "term": {
      "series_name": {
        "value": "动力源系列"
      }
    }
  }
}

PUT /series_match
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "series_name": {
        "type": "keyword"
      },
      "series_no": {
        "type": "keyword"
      }
    }
  }
}

GET /floor_one_2/_count

GET /floor_one_2/_search
{
  "size": 10,  
  "query": {
    "match_all": {}  
  }
}

GET /floor_one_2/_search
{
  "size": 10,
  "query": {
    "bool": {
      "must": [
        { "match": { "actual_fault": "充电故障-充电无反应-电池包故障" } }
      ]
    }
  }
}


```

