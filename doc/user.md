#user

## addOrUpdateUser
* `comment`: 添加或更新用户信息
* `url`: /user/addOrUpdate
* `method`: post
* `body`: {user: {id: string|default: '', nickname: string|default: '', head_portrait: string|default: ''}}
```
user: when id is empty then new else update by id
```
* `res`: {code: number, result: {user: {}}}

## userInfo
* `url`: /user
* `method`: get
* `res`: {code: number, result: {user: {}}}
