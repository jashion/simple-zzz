#oauth

## wechat
* `comment`: 开启微信开发模式
* `url`: /wechat
* `method`: get
* `query`: {signature: string|required, timestamp: string|required, nonce: string|required, echostr: string|required}
* `res`: string
```
校验通过原样返回echostr
```

## wechatLogin
* `comment`: 微信登录
* `url`: /oauth/wechat/login
* `method`: post
* `body`: {openId: string|required, accessToken: string|required, duration: number|default: 3600 * 24 * 30}
```
duration: 单位秒
```
* `res`: {code: number, result: {accountId: string, expireTime: number, token: string, isTemporary: boolean}}
```
accountId: 若已绑定平台账户, 结果为平台帐号id, 否则为用户unionId或openId
```

## webWechatLogin
* `comment`: 微信app内redirect到授权页面
* `url`: /oauth/web/wechat/login
* `method`: get

## wechatCallback
* `comment`: 微信用户授权后回调
* `url`: /oauth/wechat/callback
* `method`: get
* `res`: {code: number, result: {userInfo: {}, isBound: string}}
```
userInfo: 微信公开信息
isBound: 是否已绑定平台帐号
```

## thirdPartyBind
* `comment`: 第三方帐号绑定
* `url`: /oauth/thirdParty/bind
* `method`: post
* `body`: {openId: string|required, token4OpenId: string|required, accountId: string|required, token4AccountId: string|required}
* `res`: {code: number, result: {}}

## thirdPartyUnbind
* `comment`: 第三方帐号解除绑定
* `url`: /oauth/thirdParty/unbind
* `method`: post
* `body`: {openId: string|required}
* `res`: {code: number, result: {}}
