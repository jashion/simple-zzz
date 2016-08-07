#user

## addOrUpdateUser
* `comment`: 添加或更新用户信息
* `url`: /user/addOrUpdate
* `method`: post
* `middleware`: [authCheck]
* `body`: {user: {id: string|default: '', nickname: string|default: '', head_portrait: string|default: ''}}
```
user: when id is empty then new else update by id
```
* `res`: {code: number, result: {user: {id: string, nickname: string, head_portrait: string}}}

## userInfo
* `comment`: 获取用户信息
* `url`: /user
* `method`: get
* `middleware`: [authCheck]
* `res`: {code: number, result: {user: {id: string, nickname: string, head_portrait: string}}}

## uploadPortrait
* `comment`: 用户头像上传, multipart/form-data方式
* `url`: /user/portrait/upload
* `method`: post
* `middleware`: [authCheck, ossUpload]
* `res`: {code: number, result: {head_portrait: string}}
