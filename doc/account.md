#account

## sendVCode
* `comment`: 发送验证码, 用于注册, 重置密码等
* `url`: /sendVCode
* `method`: post
* `body`: {phoneNumber: string|required, reason: string|required}
```
reason: 注册-register, 重置密码-resetPassword
```
* `res`: {code: number, result: {}}

## register
* `comment`: 手机注册
* `url`: /register
* `method`: post
* `body`: {username: string|required, password: string|required, code: string, autoLogin: boolean|default: false}
```
username: 手机号码
code: 短信验证码
autoLogin: 传值表明在注册后自动登陆, 接口会返回token
```
* `res`: {code: number, result: {}}

## mailRegister
* `comment`: 邮箱注册
* `url`: /mail/register
* `method`: post
* `body`: {username: string|required, password: string|required, autoLogin: boolean|default: false}
```
username: 邮箱地址
autoLogin: 传值表明在注册后自动登陆, 接口会返回token
```
* `res`: {code: number, result: {}}

## login
* `comment`: 登录
* `url`: /login
* `method`: post
* `body`: {username: string|required, password: string|required, duration: number|default: 3600 * 24 * 30}
```
duration: 单位秒
```
* `res`: {code: number, result: {accountId: string, expireTime: number, token: string, isTemporary: boolean}}

## logout
* `comment`: 登出
* `url`: /logout
* `method`: post
* `body`: [object Object]
* `res`: {code: number, result: {}}

## updatePassword
* `comment`: 修改密码
* `url`: /password/update
* `method`: post
* `body`: {username: string|required, oldPassword: string|required, newPassword: string|required, reLogin: string|default: true}
```
reLogin: 修改密码后, 之前的token会失效, 可选择重新登录
```
* `res`: {code: number, result: {}}

## resetPassword
* `comment`: 重置密码
* `url`: /password/reset
* `method`: post
* `body`: {username: string|required, password: string|required, code: string|required}
* `res`: {code: number, result: {}}

## tokenInfo
* `comment`: 获取登陆信息
* `url`: /token
* `method`: get
* `res`: {code: number, result: {accountId: string, expireTime: number, token: string, isTemporary: boolean}}

## deleteAccount
* `comment`: 删除帐号
* `url`: /account/delete
* `method`: post
* `res`: {code: number, result: {accountId: string}}
