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
    <title>商品详情</title>
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
                        <h2><span></span> 联系我们 : 032 2352 782</h2>
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
                <!-- start content -->
                <div class="row single">
                    <form id="addToCart" method="post" action="/sale/addProductToCart2">
                        <div class="det">
                            <div class="single_left">
                                <div class="grid images_3_of_2">
                                    <div class="flexslider">
                                        <div class="flex-viewport" style="overflow: hidden; position: relative;">
                                            <div class="thumb-image">
                                                <img src="${ pageContext.request.contextPath }/productPhoto/${product.picId}" data-imagezoom="true" class="img-responsive" draggable="false">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="desc1 span_3_of_2">
                                    <h3>${product.name}</h3>
                                    <span class="brand"><a href="#"></a></span>
                                    <br>
                                    <%--<span class="code">${product.id}</span>--%>
                                    <%--<p>{product introduction}</p>--%>
                                    <div class="price">
                                        <span class="text">价格:</span>
                                        <span class="price-new">${product.price}</span><span class="price-old">${product.price + 200}</span>
                                    </div>
                                    <div class="det_nav1">
                                        <h4>数量:</h4>
                                        <div class=" sky-form col col-4">
                                            <input type="hidden" id="productId" name="productId" value="${product.id}">
                                            <input type="text" id="quantity" name="quantity" value="1" style="width: 40px!important;">
                                        </div>
                                    </div>
                                    <div class="btn_form">
                                        <%--<a href="addtocart">add to cart</a>--%>
                                        <a href="javascript:;" onclick="javascript:$('#addToCart').submit();">加入购物车</a>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <c:if test="${detailListSales!=null && detailListSales.size()!=0}">
                                <div class="single-bottom1">
                                    <h6>用户评价</h6>
                                    <c:forEach items="${detailListSales}" var="detailListSale">
                                        <div c>
                                        <p class="text-primary bg-warning">${detailListSale.comment}</p>
                                        </div>
                                    </c:forEach>


                                            <%--Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option--%>

                                </div>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- end content -->
            </div>

        </div>
        <!--content-->
    </div>

    <!--//content-inner-->
    <div class="clearfix"></div>
</div>
<script>

</script>
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
