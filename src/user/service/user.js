var innerRequest = require(global.frameworkLibPath + '/utils/innerRequest');
var logger = require(global.frameworkLibPath + '/logger');
var _ = require('lodash');
var uuid = require('node-uuid');
var dao = require('../model/dao');
var async = require('async');

exports.addOrUpdate = addOrUpdate;
exports.userInfo = userInfo;

function addOrUpdate(req, res, callback) {
    var user = req.body.user;
    if (!_.isObject(user)) {
        callback('却少必要参数user');
        return;
    }

    var isNew = _.isEmpty(user.id);
    var isUpdate = !isNew;
    var accountId = req.accountId;

    async.series([_accountId, _newOrUpdate], function (err) {
        if (err) {
            callback(err);
            return;
        }

        callback(null, {user: user});
    });

    function _accountId(callback) {
        var url = global.appEnv.authUrl + '/svc/auth/account/id/' + encodeURIComponent(req.accountId);

        innerRequest.get(url, function (err, result) {
            if (err) {
                callback(err);
                return;
            }

            if (!_.isEmpty(result.account)) {
                accountId = result.account.id;
            }

            callback(null);
        });
    }

    function _newOrUpdate(callback) {
        if (isNew) {
            user.id = uuid.v4();
            user.account_id = accountId;
            dao.newUser(user, callback);
            return;
        }

        if (isUpdate) {
            dao.updateUser(user, callback);
            return;
        }

        callback('do nothing');
    }
}

function userInfo(req, res, callback) {
    var accountId = req.accountId;
    var user = {};

    var doneCallback = callback;
    async.series([_tryThirdPartyAccount, _userByAccountId], function (err) {
        if (err) {
            callback(err);
            return;
        }

        callback(null, {user: user});
    });

    // 第三方未绑定帐号, user表中account_id为第三方登陆的accountId(openId)
    function _tryThirdPartyAccount(callback) {
        dao.userByAccountId(accountId, function (err, result) {
            if (err) {
                callback(err);
                return;
            }

            if (!_.isEmpty(result)) {
                doneCallback(null, {user: result[0]});
                return;
            }

            callback(null);
        });
    }

    function _userByAccountId(callback) {
        dao.userByAccountId(accountId, function (err, result) {
            if (err) {
                callback(err);
                return;
            }

            if (!_.isEmpty(result)) {
                user = result[0];
            }

            callback(null);
        });
    }
}