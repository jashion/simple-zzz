# oauth相关接口说明

## webWechatLogin
* 微信app内网页授权
* url: /svc/zzz/web/wechat/login
* method: GET  
* res: {code, result}

## wechatLogin
* 微信openId+accessToken登陆
* url: /svc/zzz/wechat/login
* method: POST
* body: {userId: string, accessToken: string, expiresIn: number}  
```
    userId: 微信用户的openId
    accessToken: 客户端按照微信登陆开发文档获得的access_token
    expiresIn: 登陆有效时长(秒)
```
* res: {code, result: {token: string, isThirdParty: boolean, expireTime: number}}