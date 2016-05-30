var crypto = require('crypto');
var _ = require('lodash');

exports.enableDevMode = enableDevMode;

function enableDevMode(req, res) {
    if (!validate(req.query.signature, req.query.timestamp, req.query.nonce)) {
        res.send('validate failure');
        return;
    }

    res.send(req.query.echostr);
}

function validate(signature, timestamp, nonce) {
    var token = global.wechatOauth.token;
    var sorted = _.sortBy([token, timestamp, nonce]).join('');
    var hash = crypto.createHash('sha1').update(sorted).digest('hex');

    return hash === signature;
}