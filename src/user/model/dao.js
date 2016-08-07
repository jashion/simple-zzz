var dataUtils = require(global.frameworkLibPath + '/dao/dataUtils');
var model = require('./index');

exports.newUser = newUser;
exports.updateUser = updateUser;
exports.userByAccountId = userByAccountId;
exports.updateByAccountId = updateByAccountId;

function newUser(user, callback) {
    user.created_at = Date.now();
    user.updated_at = user.created_at;

    dataUtils.obj2DB('user', user, model.table2Fields('user'), callback);
}

function updateUser(user, callback) {
    delete user.created_at;
    user.updated_at = Date.now();

    dataUtils.updateObj2DB('user', user, model.table2Fields('user'), ['id'], callback);
}

function userByAccountId(accountId, callback) {
    dataUtils.query('user', {account_id: accountId}, callback);
}

function updateByAccountId(user, callback) {
    delete user.created_at;
    user.updated_at = Date.now();

    dataUtils.updateObj2DB('user', user, model.table2Fields('user'), ['account_id'], callback);
}