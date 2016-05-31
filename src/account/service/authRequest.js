var innerRequest = require(global.frameworkLibPath + '/utils/innerRequest');
var authUrl = global.appEnv.authUrl;

// all function just one variable different~~~
exports.register = register;
exports.login = login;
exports.logout = logout;
exports.checkPassword = checkPassword;
exports.updatePassword = updatePassword;

function register(data, callback) {
    var url = authUrl + '/svc/auth/register';

    innerRequest.post(url, data, callback);
}

function login(data, callback) {
    var url = authUrl + '/svc/auth/login';

    innerRequest.post(url, data, callback);
}

function logout(data, callback) {
    var url = authUrl + '/svc/auth/logout';

    innerRequest.post(url, data, callback);
}

function checkPassword(data, callback) {
    var url = authUrl + '/svc/auth/password/check';

    innerRequest.post(url, data, callback);
}

function updatePassword(data, callback) {
    var url = authUrl + '/svc/auth/password/update';

    innerRequest.post(url, data, callback);
}