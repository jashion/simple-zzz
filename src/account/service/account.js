var _ = require('lodash');
var async = require('async');
var innerRequest = require(global.frameworkLibPath + '/util/innerRequest');

exports.sendVCode = sendVCode;
exports.register = register;
exports.mailRegister = mailRegister;
exports.login = login;
exports.logout = logout;
exports.updatePassword = updatePassword;
exports.resetPassword = resetPassword;
exports.tokenInfo = tokenInfo;
exports.deleteAccount = deleteAccount;

function sendVCode(req, res, callback) {
    // todo 受信验证
    var url = global.appEnv.smsUrl + '/svc/sms/sendVCode';

    innerRequest.post(url, req.body, callback);
}

function register(req, res, callback) {
    var username = req.body.username;
    var autoLogin = req.body.autoLogin || false;
    var accountId = '';

    async.series([_verificationCode, _register], function (err) {
        if (err) {
            callback(err);
            return;
        }

        if (autoLogin) {
            login(req, res, callback);
            return;
        }

        callback(null, {accountId: accountId});
    });

    function _verificationCode(callback) {
        var url = global.appEnv.smsUrl + '/svc/sms/checkVCode';
        var data = {
            phoneNumber: username,
            reason: 'register',
            code: req.body.code
        };

        innerRequest.post(url, data, callback);
    }

    function _register(callback) {
        var url = global.appEnv.authUrl + '/svc/auth/register';
        innerRequest.post(url, req.body, function (err, result) {
            if (err) {
                callback(err);
                return;
            }

            accountId = result.accountId;
            callback(null);
        });
    }
}

function mailRegister(req, res, callback) {
    var autoLogin = req.body.autoLogin || false;

    var url = global.appEnv.authUrl + '/svc/auth/register';
    innerRequest.post(url, req.body, function (err, result) {
        if (err) {
            callback(err);
            return;
        }

        if (autoLogin) {
            login(req, res, callback);
            return;
        }

        callback(null, result);
    });
}

function login(req, res, callback) {
    var url = global.appEnv.authUrl + '/svc/auth/login';
    innerRequest.post(url, req.body, callback);
}

function logout(req, res, callback) {
    var data = {
        token: req.headers['x-token']
    };

    _.assign(data, req.body);

    var url = global.appEnv.authUrl + '/svc/auth/logout';
    innerRequest.post(url, data, callback);
}

function updatePassword(req, res, callback) {
    var username = req.body.username;
    var newPassword = req.body.newPassword;
    var reLogin = req.body.reLogin || true;

    var url = global.appEnv.authUrl + '/svc/auth/password/update';
    innerRequest.post(url, req.body, function (err) {
        if (err) {
            callback(err);
            return;
        }

        if (!reLogin) {
            callback(null);
            return;
        }

        _login(callback);
    });

    function _login(callback) {
        var data = {
            username: username,
            password: newPassword
        };

        var url = global.appEnv.authUrl + '/svc/auth/login';
        innerRequest.post(url, data, callback);
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

        var url = global.appEnv.authUrl + '/svc/auth/password/reset';
        innerRequest.post(url, data, callback);
    }
}

function tokenInfo(req, res, callback) {
    var url = global.appEnv.authUrl + '/svc/auth/token/' + encodeURIComponent(req.headers['x-token']);
    innerRequest.get(url, callback);
}

function deleteAccount(req, res, callback) {
    var accountId = req.accountId;

    var url = global.appEnv.authUrl + '/svc/auth/account/delete';
    innerRequest.post(url, {accountId: accountId}, callback);
}

function isMail(username) {
    var mailReg = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;

    return mailReg.test(username);
}