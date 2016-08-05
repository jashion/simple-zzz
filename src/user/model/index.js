var TYPE = require('sequelize');
var sequelizeUtil = require(global.frameworkLibPath + '/util/sequelize');
var _ = require('lodash');

var table2Schema = {
    user: {
        id: {type: TYPE.STRING(64), primaryKey: true},
        account_id: {type: TYPE.STRING(64)},
        nickname: {type: TYPE.STRING(64)},
        head_portrait: {type: TYPE.STRING(256)},
        contact_number: {type: TYPE.STRING(32)},
        created_at: {type: TYPE.FLOAT, allowNull: false},
        updated_at: {type: TYPE.FLOAT, allowNull: false}
    }
};

exports.table2Fields = sequelizeUtil.table2Fields;

sequelizeUtil.define('user', table2Schema.user);