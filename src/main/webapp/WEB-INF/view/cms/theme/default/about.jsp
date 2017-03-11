<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/view/cms/theme/include/taglib.jsp" %>
<html>
<head>
    <title>${site.name} - ${category.name}</title>
    <%@ include file="head.jsp" %>
    <style>
        .am-comment-main:after, .am-comment-main:before{
            border-style:none;
            border-width:0;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="am-container">
    <div class="content" id="content">
        <!-- 模块排版 -->
        <img src="${ctxStatic}/3rd-lib/echo/i/blank.gif" class="img-full" style="max-height: 182px;"
             data-echo="${ctxStatic}/theme/default/img/about.jpg"/>
        <div class="am-g">
            <div class="am-u-sm-8" style="padding: 0px;padding-right: 1.1em;">
                <div class="module" style="margin-top:20px;">
                    <div class="am-panel am-panel-default">
                        <c:set var="about" value="${cms:getArticle(24)}"/>
                        <div class="title"><span>${about.title}</span></div>
                        <div class="am-panel-bd">
                            ${about.articleData.content}
                        </div>

                        <c:set var="plan" value="${cms:getArticle(44)}"/>
                        <div class="title"><span>${plan.title}</span></div>
                        <div class="am-panel-bd">
                            ${plan.articleData.content}
                        </div>

                        <c:set var="follow" value="${cms:getArticle(63)}"/>
                        <div class="title"><span>${follow.title}</span></div>
                        <div class="am-panel-bd">
                            ${follow.articleData.content}
                        </div>

                        <c:set var="support" value="${cms:getArticle(86)}"/>
                        <div class="title"><span>${support.title}</span></div>
                        <div class="am-panel-bd">
                            ${support.articleData.content}
                        </div>
                    </div>
                </div>
            </div>
            <div class="am-u-sm-4" style="padding: 0px;">
                <div class="am-panel am-panel-default" style="margin-top: 20px;">
                    <c:set var="team" value="${cms:getArticle(96)}"/>
                    <div class="title"><span>${team.title}</span></div>
                    <div class="am-panel-bd">
                        ${team.articleData.content}
                    </div>

                    <div class="title"><span id="guestbookTitle">留言板</span></div>
                    <div class="am-panel-bd">
                        <div class="am-panel am-panel-default" style="border: 1px solid #ddd;">
                            <div class="am-panel-bd">
                                <form id="guestbook" class="am-form am-form-horizontal" action="${rest}/guestbook/submit" method="post" style="margin-bottom: 0;">
                                    <input type="hidden" name="channel" value="iutils_cn">
                                    <div class="am-form-group">
                                        <div class="am-u-sm-12" style="padding: 0;">
                                            <input type="text" name="name" value="${user.name}" placeholder="昵称" required />
                                        </div>
                                    </div>
                                    <div class="am-form-group">
                                        <div class="am-u-sm-12" style="padding: 0;">
                                            <textarea id="contentArea" name="content" rows="3" placeholder="说点什么吧…" minlength="5" required></textarea>
                                        </div>
                                    </div>
                                    <div class="am-form-group" style="margin-bottom: 0;">
                                        <div class="am-u-sm-12" style="padding: 0;">
                                            <button type="button" class="am-btn am-btn-primary am-align-right">留 言</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="am-panel-bd" id="commentHtml">
                        正在载入留言...
                    </div>
                    <div id="more" class="page-more"><a href="javascript:;">加载更多</a></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script src="${ctxStatic}/3rd-lib/tpl/tpl.js"></script>
<!-- 定义模板 -->
<script type="text/template" id="commentTpl" desc="留言模板">
    <ul class="am-comments-list am-comments-list-flip">
        <# for(var i=0; i<list.length; i++) {var item=list[i];#>
        <li id="<#=item.id #>" class="am-comment">
            <div class="am-comment-main" style="margin:0;">
                <div class="am-comment-hd">
                    <div class="am-comment-meta">
                        <a href="#link-to-user" class="am-comment-author"><#=item.name #></a>
                        留言于 <#=new Date(item.createDate).format('yyyy-MM-dd h:m:s') #>
                    </div>
                    <div class="am-comment-actions">
                        <!-- 判断是否可删除 -->
                        <# if(isGuestbookDelete=='true'){#>
                            <a href="javascript:;" doType="delete" title="删除" do="${ctx}/guestbook/delete?id=<#=item.id #>"><i class="am-icon-close"></i></a>
                        <#}#>
                    </div>
                </div>
                <div class="am-comment-bd">
                    <p><#=item.content #></p>
                    <# if(item.reContent!=null){#>
                    <blockquote><#=item.reContent #></blockquote>
                    <#}#>
                </div>
                <div class="am-comment-footer">
                    <div class="am-comment-actions">
                        <a href="javascript:;" title="赞" do="${rest}/up?channel=guestbook&contentId=<#=item.id #>"><i class="am-icon-thumbs-up"></i><span><#=item.upCount#></span></a>
                        <a href="javascript:;" title="踩" do="${rest}/down?channel=guestbook&contentId=<#=item.id #>"><i class="am-icon-thumbs-down"></i><span><#=item.downCount#></span></a>
                        <a href="javascript:;" title="举报" do="${rest}/guestbook/report?id=<#=item.id #>"><i class="am-icon-info-circle"></i> <span><#=item.report#></span></a>
                        <# if(item.reContent==null && isGuestbookReply=='true'){#><!-- 判断是否可回复 -->
                        <a href="javascript:;" doType="reply" title="回复"><i class="am-icon-reply"></i></a>
                        <#}#>
                    </div>
                    <# if(item.reContent==null && isGuestbookReply=='true'){#><!-- 判断是否可回复 -->
                    <div class="am-comment-body">
                        <form class="am-form am-form-horizontal" action="${ctx}/guestbook/reply" method="post">
                            <input type="hidden" name="id" value="<#=item.id #>">
                            <div class="am-form-group">
                                <textarea name="reContent" rows="2" placeholder="回复内容..." minlength="5" required style="margin-bottom: 10px;"></textarea>
                                <button type="button" class="am-btn am-btn-primary am-btn-xs am-align-right comment-reply">回 复</button>
                                <button type="button" class="am-btn am-btn-xs am-align-right comment-cancel">取 消</button>
                            </div>
                        </form>
                    </div>
                    <#}#>
                </div>
            </div>
        </li>
        <#}#>
    </ul>
</script>
<script type="text/javascript">
    //初始化权限
    var isGuestbookReply = '<shiro:hasPermission name="guestbook:reply">true</shiro:hasPermission>',isGuestbookDelete = '<shiro:hasPermission name="guestbook:delete">true</shiro:hasPermission>';
    var pageNo = 0;//分页
    $(document).ready(function(){

        //加载留言板
        var loadGuestbook = function(isInit){
            get('${rest}/guestbook/page?channel=iutils_cn&pageSize=10&pageNo='+pageNo,function(data){
                if(data.ret==1 && data.data.list){
                    if(data.data.hasLastPage){
                        //控制是否显示加载更多
                        $("#more").remove();
                    }
                    $("#guestbookTitle").html("共"+data.data.total+"条留言");
                    //加载留言板
                    if(isInit){
                        $("#commentHtml").html(tpl('#commentTpl', data.data));
                    }else{
                        $("#commentHtml").append(tpl('#commentTpl', data.data));
                        $("#more").find("a").html("加载更多");
                    }
                    //绑定事件
                    //取消回复
                    $(".am-comment-body").on('click','button.comment-cancel',function(){
                        var _this = $(this);
                        _this.parent().parent().parent().hide();
                    });
                    //回复
                    $(".am-comment-body").on('click','button.comment-reply',function(){
                        var _this = $(this);
                        var _form = _this.parent().parent();
                        //验证表单是否合法
                        var reContent = _form.find("textarea[name='reContent']");
                        if(reContent.val()==''){
                            showMsg("请填写回复内容");
                            return;
                        }
                        var guestbook = _form.serialize();
                        post(_form.attr("action"),guestbook,function(data){
                            if(data.ret==1){
                                showMsg("回复成功");
                                _form.parent().prev().parent().prev().append('<blockquote>'+reContent.val()+'</blockquote>');//回写回复内容
                                reContent.val("");//清空回复框
                                _form.parent().prev().find("a[dotype='reply']").remove();
                                _form.parent().remove();
                            }else{
                                showMsg("回复失败");
                            }
                        });
                    });

                    //绑定操作
                    $(".am-comment-actions").on('click','a',function(){
                        var _this = $(this);
                        if(isLogin=='1'){
                            var url = _this.attr("do");
                            var doType = _this.attr("doType");
                            if(doType=='reply'){
                                //打开回复框
                                _this.parent().parent().find(".am-comment-body").toggle();
                            }else if(doType=='delete'){
                                //删除
                                get(url,function(data){
                                    if(data.ret==1){
                                        $("#"+data.data).remove();
                                    }
                                });
                            }else{
                                //普通操作
                                get(url,function(data){
                                    if(data.ret==1){
                                        _this.find("span").html(data.data);
                                    }
                                });
                            }
                        }else{
                            showMsg("未登录");
                        }
                    });
                }else{
                    if(isInit){
                        $("#commentHtml").html("暂无留言");
                    }else{
                        showMsg("没有了");
                    }
                    $("#more").remove();
                }
            });
        }
        loadGuestbook(true);

        //加载更多
        $("#more").on('click','a',function(){
            pageNo++;
            $(this).html("正在加载...");
            loadGuestbook(false);
        });

        //提交留言
        $("form#guestbook").on('click','button',function(){
            //验证
            if($("#contentArea").val()==''){
                showMsg("请填写留言内容");
                return;
            }
            var _this = $(this);
            var _form = $("#guestbook");
            var guestbook = _form.serialize();
            post(_form.attr("action"),guestbook,function(data){
                if(data.ret==1){
                    showMsg("留言成功");
                    setTimeout(function(){location.reload();},200);
                }else{
                    showMsg("留言失败");
                }
            });
        });
    });
</script>
</body>
</html>