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
    <title>购物车</title>
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
                <!-- start content -->
                <div class="check">
                    <div class="col-md-9 cart-items">
                        <h1>我的购物车</h1>
                        <!--------------上面那个是静态示例，下面返回数据--------    ---------------->
                        <!--------List名称为itemlist，可选中后自行Ctrl+Alt+Shift+J替换-------------->
                        <form id="fm" action="/sale/doComputer" method="post">
                            <c:forEach var="item" items="${itemslist.detailListSalesById}">
                                <%--<c:if test="${calc==null}">--%>
                                <%--<script>$(document).ready(function(c) {--%>
                                <%--$('#close${item.productId}').on('click', function(c){--%>
                                <%--$('.cart-header${item.productId}').fadeOut('slow', function(c){--%>
                                <%--$('.cart-header${item.productId}').remove();--%>
                                <%----%>
                                <%--});--%>
                                <%--});--%>
                                <%--});--%>
                                <%--</script>--%>
                                <%--</c:if>--%>
                                <div class="cart-header${item.productId}">

                                    <div class="cart-sec simpleCart_shelfItem">
                                            <%--<c:if test="${calc==null}"><div class="close2" id="close${item.productId}"> </div></c:if>--%>
                                        <div class="cart-item cyc">
                                            <img src="${ pageContext.request.contextPath }/productPhoto/${item.productByProductId.picId}" class="img-responsive" alt="${item.productByProductId.name}" style="">
                                        </div>
                                        <div class="cart-item-info">
                                            <h3><a href="#">${item.productByProductId.name}</a><span>产品编号: ${item.productByProductId.id}</span></h3>
                                            <ul class="qty">
                                                <li><p>单价 :  ${item.productByProductId.price}</p></li>
                                                <li><p>数量 : <input type="text" <c:if test="${calc!=null && calc==1}">disabled</c:if> value="${item.quantity}" id="id${item.productId}" name="id${item.productId}" style="width: 20px;"></p></li>
                                            </ul>
                                            <div class="delivery">
                                                <p></p>
                                                <span></span>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>

                                        <div class="clearfix"></div>

                                    </div>
                                </div>
                            </c:forEach>
                        </form>
                    </div>
                    <div class="col-md-3 cart-total">
                        <c:if test="${user!=null}">
                            <c:if test="${calc==null}"><a class="continue" href="#" onclick="calculateprice()">继续</a></c:if>
                            <c:if test="${calc!=null && calc==1}">
                                <div id="bk1" class="price-details" >
                                    <h3>价格详情</h3>
                                    <span>总价</span>
                                    <span class="total1" id="totalprice">${itemslist.totalPrice}</span>
                                    <span>运费</span>
                                    <span class="total1">0.00</span>
                                    <div class="clearfix"></div>
                                </div>
                                <div id="bk2" class="price-details">
                                    <ul class="total_price">
                                        <li class="last_price"> <h4>总价</h4></li>
                                        <li class="last_price"><h4>${itemslist.totalPrice}</h4></li>
                                        <div class="clearfix"> </div>
                                    </ul>


                                    <div class="clearfix"></div>
                                    <a class="order" href="/sale/doBuy" >提交订单</a>
                                </div>
                            </c:if>
                        </c:if>
                        <c:if test="${user==null}">
                            <div class="price-details">
                                <a class="order" href="/ecommerce/login_register">登录</a>
                            </div>
                        </c:if>
                    </div>
                    <div class="clearfix"> </div>
                </div>

                <!-- end content -->
                <div class="footer">
                    <div class="clearfix"> </div>
                    <%--<p>Copyright &copy; 2016.Company name All rights reserved.More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>--%>
                </div>
            </div>

        </div>
        <!--content-->
    </div>
    <!--//content-inner-->
    <div class="clearfix"></div>
</div>
<!--js -->
<%--<script src="${ pageContext.request.contextPath }/js/scripts.js"></script>--%>
<!-- Bootstrap Core JavaScript -->
<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<!-- /Bootstrap Core JavaScript -->
<!-- real-time -->
<script language="javascript" type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.flot.js"></script>
<script src="${ pageContext.request.contextPath }/js/menu_jquery.js"></script>
<script>
    function calculateprice() {
        $("#fm").submit();
    }
</script>
</body>
</html>
