<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/view/cms/theme/include/taglib.jsp" %>
<html>
<head>
    <title>${site.name} - ${category.name}</title>
    <%@ include file="head.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/3rd-lib/wangEditor/css/wangEditor.min.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="am-container">
    <div class="content" id="content">
        <!-- 模块排版 -->
        <img src="${ctxStatic}/3rd-lib/echo/i/blank.gif" class="img-full" style="max-height: 149px;"
             data-echo="${ctxStatic}/theme/default/img/share.jpg"/>

        <div class="am-panel am-panel-default">
            <div class="title"><span>笔记分享 - ${categoryChild.name}</span></div>
            <div class="am-panel-bd">
                <c:if test="${not empty loginUser}">
                    <form id="article" class="am-form am-form-horizontal" action="${rest}/article/submit" method="post">
                        <input type="hidden" name="categoryId" value="${categoryChild.id}"/>

                        <div class="am-form-group">
                            <label class="am-form-label">分类：</label>

                            <div>
                                <input type="text" value="${categoryChild.name}" readonly/>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-form-label">文章标题：</label>

                            <div>
                                <input type="text" id="title" name="title" required/>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-form-label">文章正文：</label>

                            <div>
                                <textarea id="contentArea" name="content" rows="10" placeholder="请输入内容..." minlength="5"
                                          required></textarea>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-form-label">关键字：</label>

                            <div>
                                <input type="text" name="keywords" required/>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <div>
                                <button type="button" id="save" class="am-btn am-btn-primary">发表</button>
                                <button type="button" class="am-btn am-btn-success" onclick="history.go(-1)">取 消
                                </button>
                            </div>
                        </div>
                    </form>
                </c:if>
                <c:if test="${empty loginUser}"><span class="blank"><a href="${ctx}/login">登录</a>后可分享</span></c:if>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script type="text/javascript" src="${ctxStatic}/3rd-lib/wangEditor/js/wangEditor.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/custom/js/jq.editor.js"></script>
<script type="text/javascript">
    //当前地址
    var cctx = '${pageContext.request.contextPath}';
    $(document).ready(function () {
        //初始化编辑器
        $.fn.initEditor('${ctx}', '${ctxStatic}', 'contentArea');

        //提交文章
        $("form#article").on('click', '#save', function () {
            //验证
            if ($("#title").val() == '') {
                showMsg("文章标题不能为空");
                return;
            }
            if ($("#contentArea").val() == '') {
                showMsg("文章正文不能为空");
                return;
            }
            var $this = $(this);
            var $form = $("#article");
            var article = $form.serialize();
            post($form.attr("action"), article, function (data) {
                if (data.ret == 1) {
                    showMsg("发表成功");
                    setTimeout(function () {
                        location.reload();
                    }, 500);
                } else {
                    showMsg("发表失败");
                }
            });
        });
    });
</script>
</body>
</html>