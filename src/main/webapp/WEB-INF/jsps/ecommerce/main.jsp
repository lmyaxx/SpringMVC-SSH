<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/25
  Time: 18:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>首页</title>
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
    <%--<script src="${ pageContext.request.contextPath }/js/serial.js"></script>--%>
    <%--<script src="${ pageContext.request.contextPath }/js/light.js"></script>--%>
    <!-- //lined-icons -->
    <script src="${ pageContext.request.contextPath }/js/jquery-1.10.2.min.js"></script>
</head>
<body>
<div class="page-container">
    <!--/content-inner-->
    <div class="inner-content" >
        <!-- header-starts -->
        <div class="header-section" style="overflow:hidden;">
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
                            <li>
                                <c:if test="${user!=null}">
                                    <a  href="${ pageContext.request.contextPath }/sale/getMyBuyHistory?customerId=${user.id}">我的订单</a>
                                </c:if>

                            </li>
                        </ul>
                    </div>
                    <div class="top_left">
                        <h2><span></span> 联系我们 : xxxxxxxxx</h2>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="clearfix"></div>
            <!-- /top_bg -->
        </div>
        <div class="header_bg">
            <div class="header">
                <div class="head-t">
                    <div class="logo">
                        <c:if test="${user!=null}">
                            <a href="${ pageContext.request.contextPath }/ecommerce/emain"><img src="/headsculpture/${user.picId}" width="40" height="40" class="img-responsive" alt=""> </a>
                        </c:if>
                        <c:if test="${user==null}">
                            <a href="${ pageContext.request.contextPath }/ecommerce/emain"><img src="/images/logo.png" class="img-responsive" alt=""> </a>
                        </c:if>
                    </div>
                    <!-- start header_right -->
                    <div class="header_right">
                        <div class="rgt-bottom">
                            <div class="reg">
                                <a href=""></a>
                            </div>
                            <div class="reg">
                                <a href=""></a>
                            </div>
                            <div class="cart box_1">
                                <c:choose>
                                    <c:when test="${total==null}">
                                        <a href="${ pageContext.request.contextPath }/sale/showCart">
                                            <h3> <span id="simpleCart_total" class="simpleCart_total">$0.00</span> (<span id="simpleCart_quantity" class="simpleCart_quantity">0</span> 件)<img src="${ pageContext.request.contextPath }/images/bag.png" alt=""></h3>
                                        </a>
                                    </c:when>
                                    <%--这里做了判断所以实际上不会有问题--%>
                                    <c:when test="${total!=null}">
                                        <a href="${ pageContext.request.contextPath }/sale/showCart">
                                            <h3> <span id="simpleCart_total" class="simpleCart_total">$${total}</span> (<span id="simpleCart_quantity" class="simpleCart_quantity">${quantity}</span> 件)<img src="${ pageContext.request.contextPath }/images/bag.png" alt=""></h3>
                                        </a>
                                    </c:when>
                                </c:choose>
                                <p><a href="javascript:;" onclick="emptycart()" class="simpleCart_empty">(清空购物车)</a></p>
                                <div class="clearfix"> </div>
                            </div>
                            <div class="create_btn">
                                <a href="${ pageContext.request.contextPath }/sale/showCart">结账</a>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="search">
                            <form style="margin-bottom: 0px!important;" method="post" action="${ pageContext.request.contextPath }/product/findProductByName">
                                <input type="text" id="txt" name="name" value="" placeholder="${name}">
                                <div id = "ul">
                                    <ul id="" style="z-index:999!important;"></ul>
                                </div>


                                <%--<select id="ul" style="z-index:999!important;"></select>--%>
                                <input type="hidden" name="pageIndex" value="1">
                                <input type="submit" value="">

                                <script language="JavaScript">
                                    (function(){
                                        //ajax四部曲
                                        function ajax(url,fnSuccess,fnFail){
                                            var oAjax=null;
                                            if(window.XMLHttpRequest){
                                                oAjax=new XMLHttpRequest();
                                            }
                                            else{
                                                oAjax=new ActiveXObject("Microsoft.XMLHTTP");
                                            }

                                            oAjax.open("GET",url,true);

                                            oAjax.send();

                                            oAjax.onreadystatechange=function(){
                                                if(oAjax.readyState==4 && oAjax.status==200){
                                                    fnSuccess(oAjax.responseText);
                                                }
                                                else{
                                                    if(fnFail){
                                                        fnFail();
                                                    }
                                                }
                                            }
                                        }

                                        var oTxt=document.getElementById("txt"),
                                            oUl=document.getElementById("ul"),
                                            c=-1,
                                            oldVal=oTxt.value,
                                            aLi=oUl.getElementsByTagName("li");;

                                        oTxt.onkeyup=function(e){
                                            var e=e||window.event;
                                            eKey=e.keyCode;
                                            ajax("/product/findProductByJson",fnSuccess,fnFail);
                                        }

                                        function fnSuccess(str){
                                            var e=e||window.event;
                                            oUl.innerHTML="";
                                            if(oTxt.value!=oldVal){
                                                c=-1;
                                                oldVal=oTxt.value;
                                            }
                                            if(oTxt.value){
                                                var str=eval("("+str+")"), // 使用eval解析数组
                                                    val=oTxt.value.toLowerCase(),
                                                    valLen=oTxt.value.length;
                                                for(var i=0;i<str.length;i++){
                                                    if(str[i].substring(0,valLen)==val){
                                                        var oLi=document.createElement("li");
                                                        oLi.innerHTML=str[i];
                                                        oUl.appendChild(oLi);
                                                        eleShow(oUl);
                                                    }
                                                }

                                                document.onclick=function(){
                                                    oUl.style.display="none";
                                                }

                                                if(oUl.style.display=="block"){
                                                    mouseLi();
                                                    keyLi();
                                                }
                                            }
                                        }

                                        function fnFail(){}

                                        //键盘操作列表选择
                                        function keyLi(){
                                            switch(eKey){
                                                // 40 下
                                                // 38 上
                                                // 13 enter
                                                case 40:
                                                    c++;
                                                    listChange();
                                                    break;
                                                case 38:
                                                    c--;
                                                    listChange();
                                                    break;
                                                case 13:
                                                    eleHide(oUl);
                                                    oTxt.value=aLi.innerHTML;
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }

                                        function listChange(){
                                            if(c==aLi.length){
                                                c=0;
                                            }
                                            for(var i=0;i<aLi.length;i++){
                                                aLi[i].className="";
                                            }
                                            aLi.className="cur";
                                        }

                                        //鼠标操作列表选择
                                        function mouseLi(){
                                            for(var i=0;i<aLi.length;i++){
                                                aLi[i].onclick=function(){
                                                    oTxt.value=this.innerHTML;
                                                    eleHide(oUl);
                                                }
                                                aLi[i].onmouseover=function(){
                                                    this.className="cur";
                                                }
                                                aLi[i].onmouseout=function(){
                                                    this.className="";
                                                }
                                            }
                                        }

                                        function eleShow(obj){
                                            obj.style.display="block";
                                        }

                                        function eleHide(obj){
                                            obj.style.display="none";
                                        }
                                    })()

                                </script>
                            </form>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <!-- //header-ends -->
        <!--content-->
        <div class="content">
            <div class="women_main">
                <!-- start content -->
                <div class="w_content">
                    <div class="women">
                        <%--<a href="#"><h4>ALL - <span>${itemlist.size()}按理说应该是总数量 items</span> </h4></a>--%>
                        <div class="clearfix"></div>
                    </div>
                    <!--------------上面那个是静态示例，下面返回16个数据------------------------>
                    <!--------List名称为itemlist，可选中后自行Ctrl+Alt+Shift+J替换-------------->
                    <%--<img src="${ pageContext.request.contextPath }/productPhoto/${itemlist.get(0).picId}" class="img-responsive" alt="${itemlist.get(0).name}">--%>
                    <c:if test="${itemlist!=null}">
                        <div class="grids_of_4">
                            <c:if test="${itemlist.size()>=1}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist.get(0).id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist.get(0).picId}" class="img-responsive" alt="${itemlist.get(0).name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist.get(0).id}">${itemlist[0].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist.get(0).price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[0].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=2}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[1].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[1].picId}" class="img-responsive" alt="${itemlist[1].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[1].id}">${itemlist[1].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[1].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[1].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=3}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[2].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[2].picId}" class="img-responsive" alt="${itemlist[2].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[2].id}">${itemlist[2].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[2].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[2].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=4}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[3].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[3].picId}" class="img-responsive" alt="${itemlist[3].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[3].id}">${itemlist[3].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[3].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[3].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="grids_of_4">
                            <c:if test="${itemlist.size()>=5}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[4].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[4].picId}" class="img-responsive" alt="${itemlist[4].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[4].id}">${itemlist[4].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[4].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[4].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=6}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[5].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[5].picId}" class="img-responsive" alt="${itemlist[5].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[5].id}">${itemlist[5].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[5].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[5].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=7}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[6].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[6].picId}" class="img-responsive" alt="${itemlist[6].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[6].id}">${itemlist[6].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[6].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[6].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=8}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[7].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[7].picId}" class="img-responsive" alt="${itemlist[7].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[7].id}">${itemlist[7].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[7].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[7].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="grids_of_4">
                            <c:if test="${itemlist.size()>=9}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[8].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[8].picId}" class="img-responsive" alt="${itemlist[8].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[8].id}">${itemlist[8].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[8].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[8].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=10}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[9].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[9].picId}" class="img-responsive" alt="${itemlist[9].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[9].id}">${itemlist[9].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[9].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[9].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=11}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[10].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[10].picId}" class="img-responsive" alt="${itemlist[10].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[10].id}">${itemlist[10].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[10].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[10].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=12}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[11].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[11].picId}" class="img-responsive" alt="${itemlist[11].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[11].id}">${itemlist[11].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[11].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[11].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="grids_of_4">

                            <c:if test="${itemlist.size()>=13}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[12].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[12].picId}" class="img-responsive" alt="${itemlist[12].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[12].id}">${itemlist[12].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[12].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[12].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=14}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[13].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[13].picId}" class="img-responsive" alt="${itemlist[13].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[13].id}">${itemlist[13].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[13].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[13].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=15}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[14].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[14].picId}" class="img-responsive" alt="${itemlist[14].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[14].id}">${itemlist[14].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[14].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[14].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${itemlist.size()>=16}">
                                <div class="grid1_of_4">
                                    <div class="content_box"><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[15].id}">
                                        <img style="height: 300px;width: 300px" src="${ pageContext.request.contextPath }/productPhoto/${itemlist[15].picId}" class="img-responsive" alt="${itemlist[15].name}">
                                    </a>
                                        <h4><a href="${ pageContext.request.contextPath }/product/getProductDetailInfo?productId=${itemlist[15].id}">${itemlist[15].name}</a></h4>
                                        <div class="grid_1 simpleCart_shelfItem">
                                            <div class="item_add"><span class="item_price"><h6>仅 ${itemlist[15].price}</h6></span></div>
                                            <div class="item_add"><span class="item_price"><a href="javascript:;" onclick="addcart(${itemlist[15].id})">加入购物车</a></span></div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                    <!-- end grids_of_4 -->

                </div>
                <div class="clearfix"></div>
                <!-- end content -->
                <div class="foot-top">
                    <div style="text-align: center">
                        <form id="page" action="/product/${method}" method="post">
                            <c:if test="${method eq 'findProductByName'}">
                                <a href="/product/${method}?pageIndex=${pageIndex-1}&name=${name}">上一页</a>
                            </c:if>
                            <c:if test="${method eq 'findProductByName'}">
                                <a href="/product/${method}?pageIndex=${pageIndex+1}&name=${name}">下一页</a>
                            </c:if>
                            <c:if test="${method eq 'getProductListByPage'}">
                                <a href="/product/${method}?pageIndex=${pageIndex-1}">上一页</a>
                            </c:if>
                            <c:if test="${method eq 'getProductListByPage'}">
                                <a href="/product/${method}?pageIndex=${pageIndex+1}">下一页</a>
                            </c:if>
                            <%--<a href="/product/${method}?pageIndex=${pageIndex-1}">上一页</a>--%>
                            <%--<input type="text" id="pagebox" name="page" value="{#6 pageIndex}" style="width: 20px">--%>

                            <%--<a href="javascript:;" onclick="javascript:$('#page').submit();">跳转</a>--%>
                        </form>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <%--<div class="footer">--%>
                <%--<div class="clearfix"> </div>--%>
                <%--<p>Copyright &copy; 2016.Company name All rights reserved.More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>--%>
                <%--</div>--%>
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
    function emptycart() {
        $.ajax({
            type: "POST",
            url: "/sale/emptyCart",
            success: function (ret) {
                var result = ret;
                // alert(JSON.stringify(result));
                if (result.error.indexOf("true")>=0) {
                    console.log(result);
                    // document.getElementById("simpleCart_total").innerHTML
                    document.getElementById("simpleCart_total").innerHTML="$0.00";
                    document.getElementById("simpleCart_quantity").innerHTML="0";
                }
                else{
                    alert("未知错误！");
                }
            },
            error:function() {
                alert("error");
            },
            dataType: "json"
        });
    }
    function addcart(id) {
        $.ajax({
            type: "POST",
            url: "/sale/addProductToCart?productId="+id,
            // data:{ productId:id},
            success: function (ret) {
                // alert(JSON.stringify(ret));
                // console.log(ret);
                var result=ret;
                if (result.error.indexOf("true")>=0){
                    document.getElementById("simpleCart_total").innerHTML="$"+result.total;
                    document.getElementById("simpleCart_quantity").innerHTML=""+result.quantity;
                }
                else{
                    alert("未知错误");
                }
            },
            error:function(){
                alert("error");
            },
            dataType: "json"
        });
    }

    layui.layer.open({
        type: 1,
        content: $('#ul') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
    });
</script>

</body>
</html>