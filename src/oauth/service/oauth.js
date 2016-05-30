exports.wechat = wechat;

function wechat(req, res, callback) {
    res.send(req.query.echostr);
}