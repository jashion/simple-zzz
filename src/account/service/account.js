var _ = require('lodash');
var async = require('async');
var innerRequest = require(global.frameworkLibPath + '/utils/innerRequest');
var authRequest = require('./authRequest');

exports.sendVCode = sendVCode;
exports.register = register;
exports.login = login;
exports.logout = logout;
exports.updatePassword = updatePassword;
exports.resetPassword = resetPassword;

function sendVCode(req, res, callback) {
    // todo 受信验证

    var url = global.appEnv.smsUrl + '/svc/sms/sendVCode';

    innerRequest.post(url, req.body, callback);
}

function register(req, res, callback) {
    var username = req.body.username;

    async.series([_verificationCode, _register], function (err) {
        if (err) {
            callback(err);
            return;
        }

        if (_.isUndefined(req.body.autoLogin)) {
            callback(null);
            return;
        }

        login(req, res, callback);
    });

    function _verificationCode(callback) {
        if (isMail(username)) {
            process.nextTick(callback);
            return;
        }

        var url = global.appEnv.smsUrl + '/svc/sms/checkVCode';
        var data = {
            phoneNumber: username,
            reason: 'register',
            code: req.body.code
        };

        innerRequest.post(url, data, callback);
    }

    function _register(callback) {
        authRequest.register(req.body, callback);
    }
}

function login(req, res, callback) {
    authRequest.login(req.body, callback);
}

function logout(req, res, callback) {
    authRequest.logout(_.assign({username: req.username}, req.body), callback);
}

function updatePassword(req, res, callback) {
    var username = req.username;
    var oldPassword = req.body.oldPassword;
    var newPassword = req.body.newPassword;

    if (_.isEmpty(newPassword)) {
        callback(null, {code: 1, result: '新密码不能为空'});
        return;
    }

    async.series([_check, _update], callback);

    function _check(callback) {
        var data = {
            username: username,
            password: oldPassword
        };

        authRequest.checkPassword(data, callback);
    }

    function _update(callback) {
        var data = {
            username: username,
            password: newPassword
        };

        authRequest.updatePassword(data, callback);
    }
}

function resetPassword(req, res, callback) {
    var username = req.body.username;

    async.series([_verificationCode, _reset], callback);

    function _verificationCode(callback) {
        if (isMail(username)) {
            process.nextTick(callback);
            return;
        }

        var url = global.appEnv.smsUrl + '/svc/sms/checkVCode';
        var data = {
            phoneNumber: username,
            reason: 'resetPassword',
            code: req.body.code
        };

        innerRequest.post(url, data, callback);
    }

    function _reset(callback) {
        var data = {
            username: username,
            password: req.body.password
        };

        authRequest.updatePassword(data, callback);
    }
}

function isMail(username) {
    var mailReg = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;

    return mailReg.test(username);
}