var request = require('./lib/request');
var assert = require('assert');
var _ = require('lodash');
var util = require('util');
var async = require('async');

describe('user', function () {
    before(function (callback) {
        async.series([_register, _login], callback);

        function _register(callback) {
            request.post('/mail/register', _.pick(testConfig.mockData, ['username', 'password']), function (err, body) {
                if (err) {
                    callback(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                testConfig.mockData.accountId = body.result.accountId;
                callback(null);
            });
        }

        function _login(callback) {
            request.post('/login', _.pick(testConfig.mockData, ['username', 'password']), function (err, body) {
                if (err) {
                    callback(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.token), 'token is empty');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                assert(util.isNumber(body.result.expireTime), 'expireTime is not number');
                testConfig.mockData.token = body.result.token;
                callback(null);
            });
        }
    });

    after(function (callback) {
        if (_.isEmpty(testConfig.mockData.token)) {
            callback(null);
        }

        var options = {
            headers: {
                'x-token': testConfig.mockData.token
            }
        };

        request.post('/account/delete', {}, options, function (err, body) {
            if (err) {
                callback(err);
                return;
            }

            assert(body.code === 0, 'code is not 0');
            assert(!_.isEmpty(body.result.accountId), 'account id is empty');
            callback(null);
        });
    });

    describe('/user/addOrUpdate', function () {
        it('normal', function (done) {
            var options = {
                headers: {
                    'x-token': testConfig.mockData.token
                }
            };
            var data = {
                user: _.pick(testConfig.mockData, ['nickname'])
            };

            request.post('/user/addOrUpdate', data, options, function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.user), 'user is empty');
                assert(!_.isEmpty(body.result.user.id), 'user id is empty');
                assert(body.result.user.nickname === testConfig.mockData.nickname, 'nickname is not right');
                done(null);
            });
        });
    });

    describe('/user', function () {
        it('normal', function (done) {
            var options = {
                headers: {
                    'x-token': testConfig.mockData.token
                }
            };

            request.get('/user', options, function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.user), 'user is empty');
                assert(!_.isEmpty(body.result.user.id), 'user id is empty');
                assert(body.result.user.nickname === testConfig.mockData.nickname, 'nickname is not right');
                done(null);
            });
        });
    });
});