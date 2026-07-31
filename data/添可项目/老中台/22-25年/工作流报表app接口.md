---

## 接口文档：StatFlowController

### 1. 查询工作流 AppModules

#### 请求地址
```
GET /v1/private/{deviceId}/{appCode}/{appVersion}/{channel}/{deviceType}/stat/flow/appModules
```


#### 请求参数
| 参数名     | 类型    | 必填 | 描述         |
| ---------- | ------- | ---- | ------------ |
| deviceId   | String  | 是   | 设备 ID      |
| appCode    | String  | 是   | 应用编码     |
| appVersion | String  | 是   | 应用版本     |
| channel    | String  | 是   | 渠道信息     |
| deviceType | String  | 是   | 设备类型     |
| appInfo    | AppInfo | 否   | 应用信息对象 |

#### 响应示例
```json
{
  "result": "SUCCESS",
  "data": ["module1", "module2"],
  "msg": ""
}
```


#### 错误响应示例
```json
{
  "result": "VALIDATE_ERROR",
  "data": null,
  "msg": "参数校验失败"
}
```


#### 备注
- 成功时返回应用模块列表。
- 若发生业务异常（如 `EcovacsValidateException`），返回对应错误码和消息。

---

### 2. 获取工作流数据

#### 请求地址
```
POST /v1/private/{deviceId}/{appCode}/{appVersion}/{channel}/{deviceType}/stat/flow/data
```


#### 请求参数
| 参数名     | 类型       | 必填 | 描述                  |
| ---------- | ---------- | ---- | --------------------- |
| deviceId   | String     | 是   | 设备 ID               |
| appCode    | String     | 是   | 应用编码              |
| appVersion | String     | 是   | 应用版本              |
| channel    | String     | 是   | 渠道信息              |
| deviceType | String     | 是   | 设备类型              |
| param      | JSONObject | 是   | JSON 格式的请求体参数 |

##### 示例请求体
```json
{
  "key1": "value1",
  "key2": "value2"
}
```


#### 响应示例
```json
{
  "result": "SUCCESS",
  "data": {
    "flowData": "exampleData"
  },
  "msg": ""
}
```


#### 备注
- 请求体会自动注入当前用户 ID（`userId`）。
- 返回工作流相关数据。

---

### 3. 获取工作流配置选项

#### 请求地址
```
GET /v1/private/{deviceId}/{appCode}/{appVersion}/{channel}/{deviceType}/stat/flow/selectOptions
```


#### 请求参数
| 参数名     | 类型    | 必填 | 描述                                            |
| ---------- | ------- | ---- | ----------------------------------------------- |
| deviceId   | String  | 是   | 设备 ID                                         |
| appCode    | String  | 是   | 应用编码                                        |
| appVersion | String  | 是   | 应用版本                                        |
| channel    | String  | 是   | 渠道信息                                        |
| deviceType | String  | 是   | 设备类型                                        |
| type       | Integer | 是   | 配置选项类型（ONE_ORG/TWO_ORG/COMPANY）         |
| orgId      | String  | 否   | 组织 ID（当 type 为 TWO_ORG 或 COMPANY 时必填） |

#### 响应示例
```json
{
  "result": "SUCCESS",
  "data": {
    "options": [
      {"id": "1", "name": "Option1"},
      {"id": "2", "name": "Option2"}
    ]
  },
  "msg": ""
}
```


#### 错误响应示例
```json
{
  "result": "FAIL",
  "data": null,
  "msg": "orgId is null"
}
```


#### 备注
- 根据 `type` 参数动态获取不同层级的组织或公司信息。
- 若 `type` 为 `TWO_ORG` 或 `COMPANY`，必须提供有效的 `orgId`。

---

