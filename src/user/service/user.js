var logger = require(global.frameworkLibPath + '/logger');
var _ = require('lodash');
var uuid = require('node-uuid');
var dao = require('../model/dao');
var async = require('async');

exports.addOrUpdate = addOrUpdate;
exports.userInfo = userInfo;
exports.uploadPortrait = uploadPortrait;

function addOrUpdate(req, res, callback) {
    var user = req.body.user;
    if (!_.isObject(user)) {
        callback('却少必要参数user');
        return;
    }

    var isNew = _.isEmpty(user.id);
    var isUpdate = !isNew;
    var accountId = req.accountId;

    if (isNew) {
        user.id = uuid.v4();
        user.account_id = accountId;
        dao.newUser(user, _done);
        return;
    }

    if (isUpdate) {
        dao.updateUser(user, _done);
        return;
    }

    callback('do nothing');

    function _done(err) {
        if (err) {
            callback(err);
            return;
        }

        callback(null, {user: user});
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

function uploadPortrait(req, res, callback) {
    var ossUrl = req.file.ossUrl;
    var accountId = req.accountId;

    var user = {
        account_id: accountId,
        head_portrait: ossUrl
    };

    dao.updateByAccountId(user, function (err) {
        if (err) {
            callback(err);
            return;
        }

        callback(null, {head_portrait: user.head_portrait});
    });
}