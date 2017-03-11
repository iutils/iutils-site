<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/view/cms/theme/include/taglib.jsp" %>
<html>
<head>
  <title>${site.name} - ${category.name}</title>
  <%@ include file="head.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="am-container">
  <div class="content" id="content">
    <!-- 模块排版 -->
    <img src="${ctxStatic}/3rd-lib/echo/i/blank.gif" class="img-full" style="max-height: 149px;"
         data-echo="${ctxStatic}/theme/default/img/share.jpg"/>
    <!--排版-->
    <div class="am-g">
      <div class="am-u-sm-9" style="padding: 0px;padding-right: 1.1em;">
        <div class="am-panel am-panel-default" style="margin-top: 20px;">
          <div class="title"><span>笔记分享</span></div>
          <div class="am-panel-bd">
            <!-- 文章内容 -->
            <div id="blog-body">
              <c:if test="${empty categorys}"><c:set var="categoryIds" value="${cms:getNavListBy(39)}"/></c:if>
              <c:if test="${not empty categorys}"><c:set var="categoryIds" value="${categorys}"/></c:if>
              <c:set var="page" value="${cms:getArticlePage(categoryIds, param.pageNo, param.pageSize)}"/>
              <c:forEach items="${page.list}" var="article">
                <article class="am-article">
                  <div class="am-article-hd">
                    <h1 class="am-article-title">
                      <div class="category"><span><a href="${ctxF}/${category.id}/view/notes${urlSuffix}?categoryId=${article.category.id}<c:if test="${not empty param.id}">&id=${param.id}</c:if>">${article.category.name}</a></span></div>
                      <a title="查看详情" href="${ctxF}/${category.id}/${article.id}/detail${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>">${article.title}</a></h1>
                    <p class="am-article-meta">作者：<a href="#">${empty article.user.name?article.user.username:article.user.name}</a> 更新：${fnc:relativeDate(article.updateDate)} &nbsp;&nbsp;浏览：${article.hits}次</p>
                  </div>
                  <div class="am-article-bd">
                      ${article.articleData.content}
                  </div>
                </article>
                <hr>
              </c:forEach>
            </div>
            <ul class="am-pagination blog-pagination">
              <li class="am-pagination-prev <c:if test="${page.hasFirstPage}">am-disabled</c:if>"><a href="${ctxF}/${category.id}/view/notes${urlSuffix}?pageNo=${page.prev}<c:if test="${not empty param.id}">&id=${param.id}</c:if>">« 上一页</a></li>
              <li class="am-pagination-next <c:if test="${page.hasLastPage}">am-disabled</c:if>"><a href="${ctxF}/${category.id}/view/notes${urlSuffix}?pageNo=${page.next}<c:if test="${not empty param.id}">&id=${param.id}</c:if>">下一页 »</a></li>
            </ul>
          </div>
        </div>
      </div>

      <div class="am-u-sm-3" style="padding: 0px;">
        <div class="am-panel am-panel-default" style="margin-top: 20px;">
          <div class="title"><span>分类</span></div>
          <div class="am-panel-bd">
            <ul class="am-list am-list-static class-list">
              <c:set var="navs" value="${cms:getNavListBy(category.id)}"/>
              <c:forEach items="${navs}" var="nav">
                <li style="padding:0;"><a href="${ctxF}/${category.id}/view/notes${urlSuffix}?categoryId=${nav.id}<c:if test="${not empty param.id}">&id=${param.id}</c:if>" class="am-text-truncate" <c:if test="${nav.id==param.categoryId}">style="color:#DD514C;"</c:if>><c:if test="${nav.id==param.categoryId}"><i class="am-icon-hand-o-right"></i></c:if> ${nav.name} </a> <a href="${ctxF}/${category.id}/${nav.id}/share${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>" style="float:right;margin-top:-50px;border-bottom:none;"><span class="am-badge am-badge-warning">发表</span><span class="am-badge am-badge-success">${cms:getCategoryArticleCount(nav.id)}</span></a></li>
              </c:forEach>
            </ul>
          </div>
        </div>

        <%--<div class="am-panel am-panel-default">--%>
          <%--<div class="title"><span>分享达人</span></div>--%>
          <%--<div class="am-panel-bd masterlist">--%>
            <%--<ul style="padding-left:15px;">--%>
              <%--<li>--%>
                <%--<span><img src="${ctxStatic}/custom/images/user.png" width="54" height="54"></span>--%>
                <%--<span>管理员</span>--%>
                <%--<span class="c1">文章&nbsp;10</span>--%>
              <%--</li>--%>
            <%--</ul>--%>
          <%--</div>--%>
        <%--</div>--%>

      </div>

    </div>
  </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>