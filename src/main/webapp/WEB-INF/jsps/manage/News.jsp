<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/28
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/global.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/layui.css">
    <script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <!-- 内容主体区域 -->
    <div class="layui-container">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12 content detail">
                <div class="fly-panel detail-box">
                    <h1>${requestScope.news.title}</h1>
                    <div class="fly-detail-info">
                        <c:if test="${requestScope.isadmin==1}">
                            <div id="adminbox" class="fly-admin-box"  data-id="123">
                                <a href="${ pageContext.request.contextPath }/news/deleteNewsById?newsid=${requestScope.news.newId}" id="delbt" class="layui-btn layui-btn-xs jie-admin" type="del">删除</a>
                            </div>
                        </c:if>
                    </div>
                    <div class="detail-about" style="padding-left: 15px!important;">
                        <div class="fly-detail-user">
                            <span>发布时间：${requestScope.news.releaseTime}</span>
                        </div>
                    </div>
                    <div class="detail-body photos">
                        ${requestScope.news.content}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ pageContext.request.contextPath }/layui/layui.all.js"></script>
</body>
</html>
