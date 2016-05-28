# 帐号相关接口说明

## sendVCode
* 发送验证码, 用于注册, 重置密码等
* url: /svc/zzz/sendVCode
* method: POST
* body: {phoneNumber: string, reason: string}  
```
    reason: 注册-register
```
* res: {code, result}  
```
    所有的请求code为0时表示成功, 其他均为失败(其他接口不再说明该点)
```

## register
* 注册, 支持手机号码+验证码或邮箱
* url: /svc/zzz/register
* method: POST
* body: {code: string|option, username: string, password: string, autoLogin: boolean|option}  
```
    username: 手机号码时需要code, 邮箱不需要code  
    autoLogin: 传值表明在注册后自动登陆, 接口会返回token
```
* res: {code, result}

## login
* 登陆, 支持多设备
* url: /svc/zzz/login
* method: POST
* body: {username: string, password: string, deviceId: string|option, deviceType: string|option, duration: number|option, kickOut: boolean|option}  
```    
    duration: 登陆有效时长, 单位秒  
    kickOut: 传值表明将其他同类型设备踢出
```
* res: {code, result: {token: string}}

## logout
* 登出
* url: /svc/zzz/logout
* method: POST
* body: {}
* res: {code, result}
* auth: authToken  
```
    授权才能调用的接口, 需要在请求头中附带x-token
```