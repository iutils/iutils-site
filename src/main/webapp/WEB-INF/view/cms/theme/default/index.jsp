<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/view/cms/theme/include/taglib.jsp" %>
<html>
<head lang="zh">
    <title>${site.name}</title>
    <%@ include file="/WEB-INF/view/cms/theme/default/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/view/cms/theme/default/header.jsp" %>
<div class="am-container">
    <div class="content" id="content">
        <!-- 模块排版 -->
        <img src="${ctxStatic}/3rd-lib/echo/i/blank.gif" class="img-full" style="max-height: 380px;" data-echo="${ctxStatic}/theme/default/img/codemonkey.jpg"/>
        <div class="notice"><c:set var="notice" value="${cms:getArticle(27)}" />
            <span class="horn"><img src="${ctxStatic}/theme/default/img/notice.png" /></span>
            <span>${notice.articleData.content}</span>
        </div>
        <!--排版-->
        <div class="am-g">
            <div class="am-u-sm-12 am-u-md-8 am-u-lg-8" style="padding: 0px;padding-right: 1.1em;">
                <div class="am-panel am-panel-default" style="margin-top: 20px;">
                    <div class="title"><span>最新笔记</span></div>
                    <div class="am-panel-bd">
                        <!-- 文章内容 -->
                        <div id="blog-body">
                            <c:set var="categoryIds" value="${cms:getNavListBy(39)}" />
                            <c:forEach items="${cms:getArticlePage(categoryIds, 0, 10).list}" var="article">
                                <article class="am-article">
                                    <div class="am-article-hd">
                                        <h1 class="am-article-title">
                                            <div class="category"><span><a href="${ctxF}/39/view/notes${urlSuffix}?categoryId=${article.category.id}<c:if test="${not empty param.id}">&id=${param.id}</c:if>">${article.category.name}</a></span></div>
                                            <a title="查看详情" href="${ctxF}/39/${article.id}/detail${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>">${article.title}</a>
                                        </h1>
                                        <p class="am-article-meta">作者：<a href="#">${empty article.user.name?article.user.username:article.user.name}</a> 更新：${fnc:relativeDate(article.updateDate)} &nbsp;&nbsp;浏览：${article.hits}次</p>
                                    </div>
                                    <div class="am-article-bd">
                                        ${article.articleData.content}
                                    </div>
                                </article>
                                <hr>
                            </c:forEach>
                        </div>
                        <a class="am-btn am-btn-primary am-btn-sm" href="${ctxF}/39/view/notes${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>">查看更多 →</a>
                    </div>
                </div>
            </div>

            <div class="am-u-sm-12 am-u-md-4 am-u-lg-4" style="padding: 0px;">
                <div class="am-panel am-panel-default" style="margin-top: 20px;">
                    <div class="title"><span>开源动态</span></div>
                    <div class="am-panel-bd">
                        <script src='https://git.oschina.net/TokenHuang/iutils-admin/widget_preview'></script>
                        <style>
                            .pro_name a{color: #4183c4;}
                            .osc_git_title{background-color: #d8e5f1;}
                            .osc_git_box{background-color: #fff;}
                            .ui.segment.osc_git_box{border-color: #fff;}
                            .osc_git_info{color: #666;}
                            .osc_git_main a{color: #4183c4;}
                        </style>
                    </div>

                    <div class="am-panel-bd">
                        <script src='http://git.oschina.net/TokenHuang/iutils-code/widget_preview'></script>
                        <style>
                            .pro_name a{color: #4183c4;}
                            .osc_git_title{background-color: #d8e5f1;}
                            .osc_git_box{background-color: #fff;}
                            .ui.segment.osc_git_box{border-color: #fff;}
                            .osc_git_info{color: #666;}
                            .osc_git_main a{color: #4183c4;}
                        </style>
                    </div>
                </div>

                <div class="am-panel am-panel-default">
                    <div class="title"><span>精品工具</span></div>
                    <div class="am-panel-bd">
                        <ul class="am-list">
                            <c:forEach items="${cms:getLinkList(53, 2, 10)}" var="link" varStatus="status">
                                <li><a href="${link.href}" target="_blank" title="${link.title}">${status.index+1}、${link.title}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div class="am-panel am-panel-default">
                    <div class="title"><span>常用网站</span></div>
                    <div class="am-panel-bd">
                        <ul class="am-list">
                            <c:forEach items="${cms:getLinkList(50, 2, 10)}" var="link" varStatus="status">
                                <li><a href="${link.href}" target="_blank" title="${link.title}">${status.index+1}、${link.title}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

                <div class="am-panel am-panel-default">
                    <div class="title"><span>精品书籍</span></div>
                    <div class="am-panel-bd">
                        <ul class="am-list">
                            <c:forEach items="${cms:getLinkList(51, 2, 10)}" var="link" varStatus="status">
                                <li><a href="${link.href}" target="_blank" class="am-text-truncate" title="点击下载：${link.title}">${status.index+1}、${link.title}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
        <!-- 友情链接 -->
        <div class="module">
            <div class="am-panel am-panel-default">
                <div class="title"><span>友情链接</span></div>
                <div class="am-panel-bd">
                    <c:forEach items="${cms:getLinkList(43,2, 10)}" var="link">
                        <a href="${link.href}" target="_blank" title="${link.title}"><span class="am-badge am-badge-primary">${link.title}</span></a>&nbsp;
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/view/cms/theme/default/footer.jsp" %>
</body>
</html>