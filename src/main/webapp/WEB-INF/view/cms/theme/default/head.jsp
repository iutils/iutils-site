<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="${site.description}">
<meta name="keywords" content="${site.keywords}">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp"/>
<link rel="alternate icon" type="image/png" href="${pageContext.request.contextPath}/${site.icon}">
<link rel="stylesheet"
      href="${ctxStatic}/3rd-lib/amazeui/css/amazeui.min.css"/>
<link rel="stylesheet" href="${ctxStatic}/theme/default/css/comm.css"/>

<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${ctxStatic}/3rd-lib/amazeui/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${ctxStatic}/3rd-lib/jquery/2.2.3/jquery.min.js"></script>
<!--<![endif]-->
<script src="${ctxStatic}/3rd-lib/amazeui/js/amazeui.min.js"></script>
<script src="${ctxStatic}/3rd-lib/layer/layer.js"></script><!-- 弹出插件 -->
<script src="${ctxStatic}/3rd-lib/echo/echo.min.js"></script><!-- 图片懒加载 -->
<script src="${ctxStatic}/theme/${site.theme}/js/comm.js"></script>
<script type="text/javascript">
    var ctx = "${ctx}";
    var urlSuffix = "${urlSuffix}";
    var dataSuffix = "${dataSuffix}";
    $(document).ready(function () {
        //图片懒加载
        echo.init({
            callback: function (element, op) {
                if (op === 'load') {
                    $(element).scrollspy({animation: 'fade'});
                }
            }
        });
    });

</script>
