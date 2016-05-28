var _ = require('lodash');
var authRequest = require('./authRequest');

exports.sendVCode = sendVCode;
exports.register = register;
exports.login = login;
exports.logout = logout;

function sendVCode(req, res, callback) {
    authRequest.sendVCode(req.body, callback);
}

function register(req, res, callback) {
    authRequest.register(req.body, function (err) {
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
}

function login(req, res, callback) {
    authRequest.login(req.body, callback);
}

function logout(req, res, callback) {
    authRequest.logout(req.body, callback);
}