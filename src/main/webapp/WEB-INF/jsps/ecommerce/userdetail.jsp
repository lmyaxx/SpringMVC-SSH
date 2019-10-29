<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/25
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>个人信息</title>
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
</head>
<body>
<div class="page-container">
    <!--/content-inner-->
    <div class="inner-content">
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
                        <h2><span></span> 联系我们 : 032 2352 782</h2>
                    </div>
                    <div class="clearfix"> </div>
                </div>

            </div>
            <div class="clearfix"></div>
            <!-- /top_bg -->
        </div>
        <!--content-->
        <div class="content">
            <div class="women_main" style="padding:12px 12px!important;">
                <div class="panel panel-widget forms-panel">
                    <div class="progressbar-heading general-heading">
                        <h4>个人信息:</h4>
                    </div>
                    <div class="forms">
                        <h3 class="title1"></h3>
                        <div class="form-three widget-shadow">
                            <form class="form-horizontal" action="/customer/editCustomer1">
                                <div class="form-group">
                                    <label for="username" class="col-sm-2 control-label">姓名</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control1" id="username" name="name" placeholder="${user.name}" style="width:200px;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="phonenumber" class="col-sm-2 control-label">手机号</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control1" id="phonenumber" name="phone" placeholder="${user.phone}" style="width:200px;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="col-sm-2 control-label">地址</label>
                                    <div class="col-sm-8"><textarea name="addr" id="address" cols="50" rows="4" class="form-control1" style="height: 100px"></textarea></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-10">
                                        <button type="submit" class="btn btn-default">确认修改</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
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
