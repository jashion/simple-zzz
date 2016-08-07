var request = require('./lib/request');
var assert = require('assert');
var util = require('util');
var _ = require('lodash');

describe('account', function () {
    after(function (callback) {
        if (_.isEmpty(testConfig.mockData.token)) {
            callback(null);
            return;
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

    // describe('/sendVCode', function () {
    //     it('normal', function (done) {
    //         var data = {
    //             phoneNumber: testConfig.mockData.phoneNumber,
    //             reason: 'register'
    //         };
    //
    //         request.post('/sendVCode', data, function (err, body) {
    //             if (err) {
    //                 done(err);
    //                 return;
    //             }
    //
    //             assert(body.code === 0, 'code is not 0');
    //             done(null);
    //         });
    //     });
    // });

    describe('/register', function () {
        // 手机接收到的验证码无法模拟、测试验证码不正确的注册流程
        it('code is incorrect', function (done) {
            var data = {
                username: testConfig.mockData.phoneNumber,
                password: testConfig.mockData.password,
                code: _.random(1000, 9999) + ''
            };

            request.post('/register', data, function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code !== 0, 'code is 0');
                done(null);
            });
        });

        // todo register and login
    });

    describe('/mail/register', function () {
        it('normal', function (done) {
            request.post('/mail/register', _.pick(testConfig.mockData, ['username', 'password']), function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                testConfig.mockData.accountId = body.result.accountId;
                done(null);
            });
        });
    });

    describe('/login', function () {
        it('normal', function (done) {
            request.post('/login', _.pick(testConfig.mockData, ['username', 'password']), function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.token), 'token is empty');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                assert(util.isNumber(body.result.expireTime), 'expireTime is not number');
                testConfig.mockData.token = body.result.token;
                done(null);
            });
        });
    });

    describe('/token', function () {
        it('normal', function (done) {
            var options = {
                headers: {
                    'x-token': testConfig.mockData.token
                }
            };

            request.get('/token', options, function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.token), 'token is empty');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                assert(util.isNumber(body.result.expireTime), 'expireTime is not number');
                done(null);
            });
        });
    });

    describe('/password/update', function () {
        it('normal', function (done) {
            var options = {
                headers: {
                    'x-token': testConfig.mockData.token
                }
            };

            var data = {
                username: testConfig.mockData.username,
                oldPassword: testConfig.mockData.password,
                newPassword: '66666',
                reLogin: true
            };

            request.post('/password/update', data, options, function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.token), 'token is empty');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                assert(util.isNumber(body.result.expireTime), 'expireTime is not number');
                testConfig.mockData.token = body.result.token;
                done(null);
            });
        });
    });

    describe('/password/reset', function () {
        it('normal', function (done) {
            // 暂时无法模拟验证码, 邮箱密码修改
            request.post('/password/reset', _.pick(testConfig.mockData, ['username', 'password']), function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                done(null);
            });
        });
    });

    describe('/account/delete', function () {
        it('login', function (done) {
            request.post('/login', _.pick(testConfig.mockData, ['username', 'password']), function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.token), 'token is empty');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                assert(util.isNumber(body.result.expireTime), 'expireTime is not number');
                testConfig.mockData.token = body.result.token;
                done(null);
            });
        });

        it('normal', function (done) {
            var options = {
                headers: {
                    'x-token': testConfig.mockData.token
                }
            };
            request.post('/account/delete', {}, options, function (err, body) {
                if (err) {
                    done(err);
                    return;
                }

                assert(body.code === 0, 'code is not 0');
                assert(!_.isEmpty(body.result.accountId), 'account id is empty');
                testConfig.mockData.token = '';
                done(null);
            });
        });
    });
});