<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/28
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>东华论坛</title>
    <script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/global.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/layui.css">
    <style>
        .mce-window {
            transform: initial !important;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-container">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card" style="margin-top: 20px">
                    <div class="layui-card-header layui-bg-cyan">新闻通知</div>
                    <div class="layui-card-body">
                        <div class="fly-panel">
                            <table class="layui-table" lay-even lay-skin="nob" >
                                <thead>
                                <tr>
                                    <th >序号</th>
                                    <th >标题</th>

                                    <th >发布时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${requestScope.newsList}" var="news">
                                    <tr>
                                        <td>
                                                ${news.newsId}
                                        </td>
                                        <td><a class="my-list-title" href="${ pageContext.request.contextPath }/news/getNewsById?newsId=${news.newsId}">${news.title}</a></td>

                                        <td>${news.releaseTime}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div style="text-align: center">
                            <div class="laypage-main">
                                <a href="${ pageContext.request.contextPath }/news/getNewsByPageAndSize?page=${requestScope.page-1}&size=10" class="laypage-first">上一页</a>
                                <span class="laypage-curr">${requestScope.page}</span>
                                <a href="${ pageContext.request.contextPath }/news/getNewsByPageAndSize?page=${requestScope.page+1}&size=10" class="laypage-last">下一页</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>

</body>
</html>
