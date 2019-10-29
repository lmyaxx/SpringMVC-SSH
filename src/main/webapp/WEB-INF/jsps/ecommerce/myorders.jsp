<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/25
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>我的订单</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%--<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>--%>
    <!-- Bootstrap Core CSS -->
    <link href="${ pageContext.request.contextPath }/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
    <!-- Custom CSS -->
    <link href="${ pageContext.request.contextPath }/css/style.css" rel='stylesheet' type='text/css' />
    <!-- Graph CSS -->
    <link href="${ pageContext.request.contextPath }/css/font-awesome.css" rel="stylesheet">
    <!-- lined-icons -->
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/css/icon-font.min.css" type='text/css' />
    <script src="${ pageContext.request.contextPath }/js/serial.js"></script>
    <script src="${ pageContext.request.contextPath }/js/light.js"></script>
    <!-- //lined-icons -->
    <script src="${ pageContext.request.contextPath }/js/jquery-1.10.2.min.js"></script>
    <link href="${ pageContext.request.contextPath }/layui/css/layui.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="page-container">
    <!--/content-inner-->
    <div class="inner-content">
        <!-- header-starts -->
        <div class="header-section">
            <!-- top_bg -->
            <div class="top_bg">

                <div class="header_top">
                    <div class="top_right">
                        <ul>
                            <li>
                                <c:if test="${user!=null}">
                                    <a href="${ pageContext.request.contextPath }/ecommerce/userdetail">${user.name}</a>
                                </c:if>
                            </li>
                            <li>
                                <c:if test="${user==null}">
                                    <a href="${ pageContext.request.contextPath }/ecommerce/login_register">注册</a>
                                </c:if>
                            </li>
                            <li>
                                <c:if test="${user==null}">
                                    <a  href="${ pageContext.request.contextPath }/ecommerce/login_register">登录</a>
                                </c:if>
                                <c:if test="${user!=null}">
                                    <a  href="${ pageContext.request.contextPath }/customer/logout">注销</a>
                                </c:if>
                            </li>
                        </ul>
                    </div>
                    <div class="top_left">
                        <h2><span></span> 联系我们 :xxxxxxxxx</h2>
                    </div>
                    <div class="clearfix"> </div>
                </div>

            </div>
            <div class="clearfix"></div>
            <!-- /top_bg -->
        </div>
        <!-- //header-ends -->

        <!--content-->
        <div class="content">
            <div class="women_main">
                <div class="col-md-9 cart-items" style="margin:10px 10px!important;padding: 0px 0px!important;">
                    <h1 style="margin: 0px 0px!important;">全部订单</h1>
                </div>
                <table class="layui-table" lay-even lay-skin="nob">
                    <thead>
                    <tr>
                        <th>订单id</th>
                        <th>订单时间</th>
                        <th>收货人</th>
                        <th>收货地址</th>
                        <th>订单状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${itemlist}" var="item">
                        <tr>
                            <td><a class="layui-btn" href="/ecommerce/order?id=${item.id}">${item.id}</a></td>
                            <td>${item.time}</td>
                            <td>${item.customerByCustomerId.name}</td>
                            <td>${item.customerByCustomerId.addr}</td>
                            <td>${item.state}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--js -->
<%--<script src="${ pageContext.request.contextPath }/js/scripts.js"></script>--%>
<!-- Bootstrap Core JavaScript -->
<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<!-- /Bootstrap Core JavaScript -->
<!-- real-time -->
<script language="javascript" type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.flot.js"></script>
<script src="${ pageContext.request.contextPath }/js/menu_jquery.js"></script>
</body>
</html>
