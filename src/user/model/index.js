var TYPE = require('sequelize');
var sequelizeWrap = require('../../lib/sequelizeWrap');
var _ = require('lodash');

var table2Schema = {
    user: {
        id: {type: TYPE.STRING(64), primaryKey: true},
        account_id: {type: TYPE.STRING(64)},
        nickname: {type: TYPE.STRING(64)},
        head_portrait: {type: TYPE.STRING(256)},
        self_declaration: {type: TYPE.TEXT},
        contact_number: {type: TYPE.STRING(32)},
        created_at: {type: TYPE.FLOAT, allowNull: false},
        updated_at: {type: TYPE.FLOAT, allowNull: false}
    }
};

sequelizeWrap.define('user', table2Schema.user);

exports.table2Fields = table2Fields;

function table2Fields(tableName) {
    return _.keys(table2Schema[tableName]);
}