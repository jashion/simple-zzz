# user相关接口说明

## newOrUpdate
* 添加或更新用户信息
* url: /svc/zzz/user/newOrUpdate
* method: POST
* body: {user: {nickname: string, head_portrait: string, self_declaration: string, contact_number: string}}
```
    nickname: 昵称
    head_portrait: 头像url
    self_declaration: 个人签名
    contact_number: 联系方式
```
* res: {code, result}
* auth: x-token

## userInfo
* 获取用户信息
* url: /svc/zzz/user
* method: GET  
* res: {code, result}
* auth: x-token