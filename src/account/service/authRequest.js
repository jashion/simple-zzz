var request = require(global.frameworkLibPath + '/utils/innerRequest');
var authUrl = global.appEnv.authUrl;

exports.sendVCode = sendVCode;
exports.register = register;
exports.login = login;
exports.logout = logout;

function sendVCode(data, callback) {
    var url = authUrl + '/svc/auth/sendVCode';

    request.post(url, data, callback);
}

function register(data, callback) {
    var url = authUrl + '/svc/auth/register';

    request.post(url, data, callback);
}

function login(data, callback) {
    var url = authUrl + '/svc/auth/login';

    request.post(url, data, callback);
}

function logout(data, callback) {
    var url = authUrl + '/svc/auth/logout';

    request.post(url, data, callback);
}