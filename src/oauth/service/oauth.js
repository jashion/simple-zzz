var crypto = require('crypto');
var _ = require('lodash');
var queryString = require('querystring');
var innerRequest = require(global.frameworkLibPath + '/utils/innerRequest');

exports.wechatEnableDevMode = wechatEnableDevMode;
exports.oauthLogin = oauthLogin;
exports.webOauthLogin = webOauthLogin;
exports.oauthCallback = oauthCallback;

function wechatEnableDevMode(req, res, callback) {
    if (!validate(req.query.signature, req.query.timestamp, req.query.nonce)) {
        callback('validate failure');
        return;
    }

    res.send(req.query.echostr);
}

function oauthLogin(req, res, callback) {
    var thirdParty = req.params.thirdParty;

    switch (thirdParty) {
        case 'wechat':
            wechatLogin(req, res, callback);
            break;

        default:
            callback('unknown third party');
    }
}

function webOauthLogin(req, res, callback) {
    var thirdParty = req.params.thirdParty;

    switch (thirdParty) {
        case 'wechat':
            wechatWebLogin(req, res, callback);
            break;

        default:
            callback('unknown third party');
    }
}

function oauthCallback(req, res, callback) {
    var thirdParty = req.params.thirdParty;

    switch (thirdParty) {
        case 'wechat':
            _wechatCallback();
            break;

        default:
            callback('unknown third party');
    }

    function _wechatCallback() {
        // todo avoid client back history, the code is invalid.

        var url = global.appEnv.authUrl + '/svc/auth/wechat/userInfo?' + queryString.stringify({
                code: req.query.code,
                appId: global.wechatOauth.appId,
                secret: global.wechatOauth.secret
            });

        innerRequest.get(url, callback);
    }
}

function validate(signature, timestamp, nonce) {
    var token = global.wechatOauth.token;
    var sorted = _.sortBy([token, timestamp, nonce]).join('');
    var hash = crypto.createHash('sha1').update(sorted).digest('hex');

    return hash === signature;
}

function wechatLogin(req, res, callback) {
    var url = global.appEnv.authUrl + '/svc/auth/wechat/login';

    innerRequest.post(url, req.body, callback);
}

function wechatWebLogin(req, res) {
    var loginUrl = 'https://open.weixin.qq.com/connect/oauth2/authorize?' + queryString.stringify({
            appid: global.wechatOauth.appId,
            redirect_uri: global.wechatOauth.callbackUrl, // todo keep query string
            response_type: 'code',
            scope: 'snsapi_userinfo',
            state: 'state'
        }) + '#wechat_redirect';

    res.redirect(loginUrl);
}