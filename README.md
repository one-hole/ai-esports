* 客户端若是服务端请求我们 - 需要在 HTTP 请求头里面设置 KeepAlive 字段

  ```ruby
  {
    Connection: keep-alive,
    Authorization: your-api-key,
    Api-Version: 1
  }
  ```
