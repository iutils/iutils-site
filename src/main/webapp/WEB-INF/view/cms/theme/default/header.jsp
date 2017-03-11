<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="loginUser" value="${fnc:getLoginUser()}"></c:set>
<header class="am-topbar am-topbar-fixed-top">
    <div class="am-container">
        <h1 class="am-topbar-brand" style="padding:0;margin-top: 9px;">
            <a href="${pageContext.request.contextPath}/"><img class="logo" src="${pageContext.request.contextPath}/${site.logo}" /></a>
        </h1>
        <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-secondary am-show-sm-only"
                data-am-collapse="{target: '#collapse-head'}"><span class="am-sr-only">导航切换</span> <span
                class="am-icon-bars"></span></button>
        <div class="am-collapse am-topbar-collapse" id="collapse-head">
            <!-- 自定义导航内容 -->
            <ul class="am-nav am-nav-pills am-topbar-nav">
                <c:forEach items="${cms:getNavBy(site.id, '0')}" var="nav" varStatus="status">
                    <c:if test="${nav.showHome && !nav.isBy}">
                        <li class="${category.id==nav.id?'am-active':''}${category.parentId==nav.id?'am-active':''}${(navId==null && status.first)?'am-active':''}">
                            <c:if test="${status.first}">
                                <a href="${pageContext.request.contextPath}/">${nav.name}</a>
                            </c:if>
                            <c:if test="${!status.first}">
                                <c:if test="${empty nav.customView}">
                                    <a href="${ctxF}/${nav.id}/nav${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>">${nav.name}</a>
                                </c:if>
                                <c:if test="${not empty nav.customView}">
                                    <a href="${ctxF}/${nav.id}/view/${nav.customView}${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>">${nav.name}</a>
                                </c:if>
                            </c:if>
                        </li>
                    </c:if>
                    <c:if test="${nav.isBy}">
                        <li class="am-dropdown" data-am-dropdown>
                            <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">${nav.name} <span class="am-icon-caret-down"></span></a>
                            <ul class="am-dropdown-content">
                                <c:forEach items="${cms:getNavBy(site.id, nav.id)}" var="navTwo">
                                    <c:if test="${nav.showHome}">
                                        <li><a href="#">${navTwo.name}</a></li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>

            <!-- 搜索 -->
            <form id="searchForm" class="am-topbar-form am-topbar-right" action="${ctxF}/${empty category?0:category.id}/search${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>" method="get" style="margin:0;padding:0;">
                <input id="pageNo" name="pageNo" type="hidden" value="${empty page.pageNo?0:page.pageNo}"/>
                <input id="pageSize" name="pageSize" type="hidden" value="${empty page.pageSize?10:page.pageSize}"/>
                <div class=" am-topbar-left user-bar-info">
                    <shiro:guest><a class="am-btn-link" href="${ctx}/login">登录</a> | <a class="am-btn-link" href="${ctx}/login?a=0">注册</a></shiro:guest>
                    <shiro:user>欢迎您！<a href="${ctxF}/user${urlSuffix}<c:if test="${not empty param.id}">?id=${param.id}</c:if>" title="个人中心">${empty loginUser.name?loginUser.username:loginUser.name}</a> <a class="am-btn-link" href="${ctx}/logout">注销</a></shiro:user>
                </div>
                <div class="am-topbar-left am-form-icon am-form-feedback" style="margin-top:14px;">
                    <i class="am-icon-search" style="cursor: pointer;" onclick="$('#searchForm').submit()"></i>
                    <input type="text" name="key" class="am-form-field am-input-sm am-radius" value="${page.key}" placeholder="全站搜索">
                </div>
            </form>
        </div>
    </div>
</header>
<script>
    //是否已登录
    var isLogin = '<shiro:user>1</shiro:user>';
</script>