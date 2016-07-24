var crypto = require('crypto');
var _ = require('lodash');
var queryString = require('querystring');
var innerRequest = require(global.frameworkLibPath + '/utils/innerRequest');

exports.wechatEnableDevMode = wechatEnableDevMode;
exports.wechatLogin = wechatLogin;
exports.webWechatLogin = webWechatLogin;
exports.wechatCallback = wechatCallback;
exports.thirdPartyBind = thirdPartyBind;
exports.thirdPartyUnbind = thirdPartyUnbind;

function wechatEnableDevMode(req, res, callback) {
    if (!validate(req.query.signature, req.query.timestamp, req.query.nonce)) {
        callback('validate failure');
        return;
    }

    res.send(req.query.echostr);
}

function wechatLogin(req, res, callback) {
    var url = global.appEnv.authUrl + '/svc/auth/thirdParty/wechat/login';

    innerRequest.post(url, req.body, callback);
}

function webWechatLogin(req, res, callback) {
    var loginUrl = 'https://open.weixin.qq.com/connect/oauth2/authorize?' + queryString.stringify({
            appid: global.wechatOauth.appId,
            redirect_uri: global.wechatOauth.callbackUrl, // todo keep query string
            response_type: 'code',
            scope: 'snsapi_userinfo',
            state: 'state'
        }) + '#wechat_redirect';

    res.redirect(loginUrl);
}

function wechatCallback(req, res, callback) {
    // todo avoid client back history, the code is invalid.
    var url = global.appEnv.authUrl + '/svc/auth/thirdParty/wechat/userInfo?' + queryString.stringify({
            code: req.query.code,
            appId: global.wechatOauth.appId,
            secret: global.wechatOauth.secret
        });

    innerRequest.get(url, callback);
}

function thirdPartyBind(req, res, callback) {
    var url = global.appEnv.authUrl + '/svc/auth/thirdParty/bind';
    innerRequest.post(url, req.body, callback);
}

function thirdPartyUnbind(req, res, callback) {
    req.body.accountId = req.accountId;
    req.body.token4Account = req.headers['x-token'] || req.body.token || req.query.token;

    var url = global.appEnv.authUrl + '/svc/auth/thirdParty/unbind';
    innerRequest.post(url, req.body, callback);
}

function validate(signature, timestamp, nonce) {
    var token = global.wechatOauth.token;
    var sorted = _.sortBy([token, timestamp, nonce]).join('');
    var hash = crypto.createHash('sha1').update(sorted).digest('hex');

    return hash === signature;
}