<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/view/cms/theme/include/taglib.jsp" %>
<html>
<head>
    <title>${site.name} - ${category.name}</title>
    <%@ include file="head.jsp" %>
    <style>
        .am-gallery{padding:0;}
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="am-container">
    <div class="content" id="content">
        <!-- 模块排版 -->
        <div class="am-g">
            <div class="am-u-sm-12" style="padding: 0px;">
                <div class="am-panel am-panel-default">
                    <%--<div class="title"><span>插件列表</span></div>--%>
                    <div class="am-panel-bd">
                        <c:if test="${empty categorys}"><c:set var="categoryIds" value="${cms:getNavListBy(144)}"/></c:if>
                        <c:if test="${not empty categorys}"><c:set var="categoryIds" value="${categorys}"/></c:if>
                        <c:set var="page" value="${cms:getArticlePage(categoryIds, param.pageNo, param.pageSize)}"/>
                        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-4 am-gallery-bordered" >
                            <c:forEach items="${page.list}" var="article">
                            <li>
                                <div class="am-gallery-item">
                                    <a title="查看详情" href="${ctxF}/${category.id}/${article.id}/detail${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>">
                                        <img src="${pageContext.request.contextPath}/${article.image}" style="max-height:140px;" />
                                        <h3 class="am-gallery-title">${article.title}</h3>
                                        <div class="am-gallery-desc">作者：${empty article.user.name?article.user.username:article.user.name} &nbsp;&nbsp;更新：${fnc:relativeDate(article.updateDate)} &nbsp;&nbsp;浏览：${article.hits}次</div>
                                    </a>
                                </div>
                            </li>
                            </c:forEach>
                        </ul>
                        <ul class="am-pagination blog-pagination">
                            <li class="am-pagination-prev <c:if test="${page.hasFirstPage}">am-disabled</c:if>"><a href="${ctxF}/${category.id}/view/programmer${urlSuffix}?pageNo=${page.prev}<c:if test="${not empty param.id}">&id=${param.id}</c:if>">« 上一页</a></li>
                            <li class="am-pagination-next <c:if test="${page.hasLastPage}">am-disabled</c:if>"><a href="${ctxF}/${category.id}/view/programmer${urlSuffix}?pageNo=${page.next}<c:if test="${not empty param.id}">&id=${param.id}</c:if>">下一页 »</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <%--<div class="am-u-sm-3" style="padding: 0px;padding-right: 1.1em;">--%>
                <%--<div class="am-panel am-panel-default">--%>
                    <%--<div class="title"><span>操作区</span></div>--%>
                    <%--<div class="am-panel-bd">--%>

                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>