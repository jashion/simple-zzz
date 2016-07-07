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
    expiresIn: 登陆有效时长(秒)
```
* res: {code, result: {token: string, isThirdParty: boolean, expireTime: number}}