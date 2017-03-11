/** 公共方法 */
$(function(){

});
//时间格式转换 var time = date.format('yyyy-MM-dd h:m:s');
Date.prototype.format = function(format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
}

//询问对话框
function confirm(msg, href) {
    layer.confirm(msg, {
        shade:0.01,
        offset: '30px',
        btn : [ '确定', '取消' ]
    }, function() {
        window.location.href=href;
    });
    return false;
}

//弹出提示
function alert(msg){
    layer.alert(msg);
}
//弹出消息提示
function showMsg(msg){
    layer.msg(msg,{offset: '55px',anim: 6});
}

/**
 * get数据
 */
function get(url,call){
    $.get(url,function(data){
        call && call(data);
    });
}
/**
 * post数据
 */
function post(url,param,call){
    $.post(url,param, function (data) {
        call && call(data);
    });
}
