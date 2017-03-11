<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/view/cms/theme/include/taglib.jsp"%>
<html>
<head>
  <title>${site.name} - ${article.title}</title>
  <%@ include file="head.jsp"%>
</head>
<body>
<%@ include file="header.jsp"%>
<div class="am-container">
	<div class="content" id="content">
		<div class="am-g">
			<div class="am-u-sm-12" style="padding: 0px;">
				<div class="am-panel am-panel-default" style="margin-top: 5px;">
					<div class="am-panel-bd">
						<!-- 文章内容 -->
						<div class="am-article">
							<div class="am-article-hd">
								<h1 class="am-article-title">${article.title}</h1>
								<p class="am-article-meta">作者：<a href="#">${empty article.user.name?article.user.username:article.user.name}</a> 更新：${fnc:relativeDate(article.updateDate)} &nbsp;&nbsp;浏览：${article.hits}次</p>
							</div>
							<div class="am-article-bd">
								${articleData.content}
							</div>
						</div>
					</div>

					<!-- 评论 -->
					<div class="am-panel-bd">
						<div class="am-center" style="text-align: center;">
							<button class="am-btn am-btn-success" id="up" do="${rest}/up/up?channel=article_up&contentId=${article.id}"><i class="am-icon-thumbs-o-up"></i> <span>0</span> 赞</button>
							<button class="am-btn am-btn-warning" id="down" do="${rest}/down/down?channel=article_down&contentId=${article.id}"><i class="am-icon-thumbs-o-down"></i> <span>0</span> 踩</button>
						</div>
					</div>
					<div class="title"><span id="commentTitle">还没有评论</span></div>
					<div class="am-panel-bd" id="commentHtml">

					</div>
					<div id="more" class="page-more"><a href="javascript:;">加载更多</a></div>
					<!-- 评论框 -->
					<div class="am-panel-bd" style="margin-right: 46px;">
						<c:if test="${not empty loginUser}">
							<form id="comment" class="am-form am-form-horizontal" action="${ctx}/comment/create" method="post">
								<input type="hidden" name="channel" value="article_comment">
								<input type="hidden" name="contentId" value="${article.id}">
								<div class="am-form-group">
									<div class="am-u-sm-12" style="padding-left: 62px;">
										<textarea id="contentArea" name="content" rows="3" placeholder="说点什么吧…" minlength="5" required></textarea>
										<button type="button" class="am-btn am-btn-primary am-align-right" style="margin-top: 5px;">发 布</button>
									</div>
								</div>
							</form>
						</c:if>
						<c:if test="${empty loginUser}"><div class="notlogin"><a href="${ctx}/login">登录</a>后可评论</div></c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="footer.jsp" %>
<script src="${ctxStatic}/3rd-lib/tpl/tpl.js"></script>
<!-- 定义模板 -->
<script type="text/template" id="commentTpl" desc="评论模板">
	<ul class="am-comments-list am-comments-list-flip">
		<# for(var i=0; i<list.length; i++) {var item=list[i];#>
		<li id="<#=item.id #>" class="am-comment">
			<a href="#link-to-user-home"><img src="${pageContext.request.contextPath}/<#=item.user.photo #>" class="am-comment-avatar" width="48" height="48"></a>
			<div class="am-comment-main">
				<div class="am-comment-hd">
					<div class="am-comment-meta"><a href="#link-to-user" class="am-comment-author"><# if(item.user.name!=null){#><#=item.user.name #><#}else{#><#=item.user.username #><#}#></a>
						评论于 <#=new Date(item.createDate).format('yyyy-MM-dd h:m:s') #>
					</div>
					<div class="am-comment-actions">
						<!-- 判断是否可删除 -->
						<# if(item.user.id=='${loginUser.id}'){#>
							<a href="javascript:;" doType="delete" title="删除" do="${ctx}/comment/delete?id=<#=item.id #>"><i class="am-icon-close"></i></a>
							<#}#>
					</div>
				</div>
				<div class="am-comment-bd"><p>
					<p><#=item.content #></p>
				</div>
				<div class="am-comment-footer">
					<div class="am-comment-actions">
						<a href="javascript:;" title="赞" do="${rest}/up?channel=article_comment&contentId=<#=item.id #>"><i class="am-icon-thumbs-up"></i><span><#=item.upCount#></span></a>
						<a href="javascript:;" title="踩" do="${rest}/down?channel=article_comment&contentId=<#=item.id #>"><i class="am-icon-thumbs-down"></i><span><#=item.downCount#></span></a>
						<a href="javascript:;" title="举报" do="${rest}/comment/report?id=<#=item.id #>"><i class="am-icon-info-circle"></i> <span><#=item.report#></span></a>
						<a href="javascript:;" doType="reply" title="回复" style="display: none;"><i class="am-icon-reply"></i></a>
					</div>
					<div class="am-comment-body">
						<form class="am-form am-form-horizontal" action="${ctx}/comment/create" method="post">
							<input type="hidden" name="channel" value="article_comment">
							<input type="hidden" name="contentId" value="${article.id}">
							<input type="hidden" name="parentId" value="<#=item.id #>">
							<input type="hidden" name="parentIds" value="<#=item.parentIds #><#=item.id #>/">
							<div class="am-form-group reply-box">
								<textarea name="reContent" rows="2" placeholder="回复内容..." minlength="5" required style="margin-bottom: 10px;"></textarea>
								<button type="button" class="am-btn am-btn-primary am-btn-xs am-align-right comment-reply">回 复</button>
								<button type="button" class="am-btn am-btn-xs am-align-right comment-cancel">取 消</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</li>
		<#}#>
	</ul>
</script>
<script type="text/javascript">
	var pageNo = 0;//分页
	$(document).ready(function(){

		//获取赞数
		get("${rest}/up/count?channel=article_up&contentId=${article.id}",function(data){
			if(data.ret==1){
				$("#up").find("span").html(data.data);
			}
		});
		//获取踩数
		get("${rest}/down/count?channel=article_down&contentId=${article.id}",function(data){
			if(data.ret==1){
				$("#down").find("span").html(data.data);
			}
		});
		//赞按钮
		$("#up").bind('click',function(){
			$("#up").unbind('click');
			var $this = $(this);
			var url = $this.attr("do");
			get(url,function(data){
				if(data.ret==1){
					$this.find("span").html(data.data);
				}
			});
		});
		//踩按钮
		$("#down").bind('click',function(){
			$("#down").unbind('click');
			var $this = $(this);
			var url = $this.attr("do");
			get(url,function(data){
				if(data.ret==1){
					$this.find("span").html(data.data);
				}
			});
		});

		//加载评论
		var loadComment = function(isInit){
			get('${rest}/comment/page?channel=article_comment&contentId=${article.id}&pageNo='+pageNo,function(data){
				if(data.ret==1 && data.data.list){
					if(data.data.hasLastPage){
						//控制是否显示加载更多
						$("#more").remove();
					}
					$("#commentTitle").html("共"+data.data.total+"条评论");
					if(isInit){
						$("#commentHtml").html(tpl('#commentTpl', data.data));
					}else{
						$("#commentHtml").append(tpl('#commentTpl', data.data));
					}
					//取消回复
					$(".am-comment-body").on('click','button.comment-cancel',function(){
						var $this = $(this);
						$this.parent().parent().parent().hide();
					});
					//回复
					$(".am-comment-body").on('click','button.comment-reply',function(){
						var $this = $(this);
						var $form = $this.parent().parent();
						//验证表单是否合法
						var reContent = $form.find("textarea[name='reContent']");
						if(reContent.val()==''){
							showMsg("请填写回复内容");
							return;
						}
						var guestbook = $form.serialize();
						post($form.attr("action"),guestbook,function(data){
							if(data.ret==1){
								showMsg("回复成功");
								$form.parent().prev().parent().prev().append('<blockquote>'+reContent.val()+'</blockquote>');//回写回复内容
								reContent.val("");//清空回复框
								$form.parent().prev().find("a[dotype='reply']").remove();
								$form.parent().remove();
							}else{
								showMsg("回复失败");
							}
						});
					});
					//绑定操作
					$(".am-comment-actions").on('click','a',function(){
						var $this = $(this);
						if(isLogin=='1'){
							var url = $this.attr("do");
							var doType = $this.attr("doType");
							if(doType=='reply'){
								//打开回复框
								$this.parent().parent().find(".am-comment-body").toggle();
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
										$this.find("span").html(data.data);
									}
								});
							}
						}else{
							showMsg("未登录");
						}
					});
				}else{
					if(isInit){
						$("#commentHtml").html("&nbsp;&nbsp;快来评论吧！");
					}else{
						showMsg("没有了");
					}
					$("#more").remove();
				}
			});
		}
		loadComment(true);

		//加载更多
		$("#more").on('click','a',function(){
			pageNo++;
			$(this).html("正在加载...");
			loadComment(false);
		});

		//提交评论
		$("form#comment").on('click','button',function(){
			//验证
			if($("#contentArea").val()==''){
				showMsg("请填写评论内容");
				return;
			}
			var $this = $(this);
			var $form = $("#comment");
			var comment = $form.serialize();
			post($form.attr("action"),comment,function(data){
				if(data.ret==1){
					showMsg("评论成功");
					$("#contentArea").val("");
					setTimeout(function(){location.reload();},200);
				}else{
					showMsg("评论失败");
				}
			});
		});
	});
</script>
</body>
</html>