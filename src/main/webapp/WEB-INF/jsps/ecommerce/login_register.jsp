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
    <title>登录/注册</title>
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

        <!--content-->
        <div class="content">
            <div class="women_main" style="padding:12px 12px!important;">
                <!-- start content -->
                <div class="registration" style="padding:0px 0px!important;">
                    <div class="registration_left">
                        <h2>新用户? <span> 创建一个账号吧</span></h2>
                        <!-- [if IE]
                            < link rel='stylesheet' type='text/css' href='ie.css'/>
                         [endif] -->

                        <!-- [if lt IE 7]>
                            < link rel='stylesheet' type='text/css' href='ie6.css'/>
                        <! [endif] -->
                        <script>
                            (function() {

                                // Create input element for testing
                                var inputs = document.createElement('input');

                                // Create the supports object
                                var supports = {};

                                supports.autofocus   = 'autofocus' in inputs;
                                supports.required    = 'required' in inputs;
                                supports.placeholder = 'placeholder' in inputs;

                                // Fallback for autofocus attribute
                                if(!supports.autofocus) {

                                }

                                // Fallback for required attribute
                                if(!supports.required) {

                                }

                                // Fallback for placeholder attribute
                                if(!supports.placeholder) {

                                }

                                // Change text inside send button on submit
                                var send = document.getElementById('register-submit');
                                if(send) {
                                    send.onclick = function () {
                                        this.innerHTML = '...Sending';
                                    }
                                }

                            })();
                        </script>
                        <div class="registration_form">
                            <!-- Form -->
                            <form action="/customer/saveCustomer1" method="post">
                                <div>
                                    <label>
                                        <input placeholder="姓名:" name="name" type="text" tabindex="2" required="" autofocus="">
                                    </label>
                                </div>
                                <div>
                                    <label>
                                        <input placeholder="邮箱:必填" name="email" required="" type="email" tabindex="3">
                                    </label>
                                </div>
                                <div>
                                    <label>
                                        <input placeholder="家庭地址:必填" name="addr" required="" type="text" tabindex="3">
                                    </label>
                                </div>
                                <div class="sky-form">
                                    <div class="sky_form1">
                                        <ul>
                                            <li><label class="radio left"><input type="radio" name="radio" checked=""><i></i>男</label></li>
                                            <li><label class="radio"><input type="radio" name="radio"><i></i>女</label></li>
                                            <div class="clearfix"></div>
                                        </ul>
                                    </div>
                                </div>
                                <div>
                                    <label>
                                        <input placeholder="密码" id="password" name="password" type="password" tabindex="4" required="">
                                    </label>
                                </div>
                                <div>
                                    <label>
                                        <input placeholder="确认密码" id="repassword" type="password" tabindex="4" required="">
                                    </label>
                                </div>

                                <div class="sky-form">
                                    <label class="checkbox"><input type="checkbox" name="checkbox"><i></i>我同意以上条款 &nbsp;</label>
                                </div>
                                <div>
                                    <input type="submit" onclick="validate()" value="创建新账户">
                                </div>
                                <script language="JavaScript">

                                    function validate() {
                                        var pwd1 = document.getElementById("password").value;
                                        var pwd2 = document.getElementById("repassword").value;
                                        if(pwd1 == pwd2) {
                                            document.getElementById("tishi").innerHTML="<font color='gray'>输入正确</font>";
                                            /*         $("#tishi").hide(1500); */
                                            document.getElementById("dosubmit").disabled = false;
                                        }
                                        else {
                                            document.getElementById("tishi").innerHTML="<font color='red'>两次密码不相同</font>";
                                            document.getElementById("dosubmit").disabled = true;
                                        }
                                    }
                                </script>
                            </form>
                            <!-- /Form -->
                        </div>
                    </div>
                    <div class="registration_left">
                        <h2>已有账户</h2>
                        <div class="registration_form">
                            <!-- Form -->
                            <form method="post" action="${ pageContext.request.contextPath }/customer/customer_login">
                                <div>
                                    <label>
                                        <input placeholder="邮箱" name="email" type="email" tabindex="3" required="">
                                    </label>
                                </div>
                                <div>
                                    <label>
                                        <input placeholder="密码" name="password" type="password" tabindex="4" required="">
                                    </label>
                                </div>
                                <div>
                                    <input type="submit" value="登陆">
                                </div>
                                <div class="forget">
                                    <a href="#"></a>
                                </div>
                            </form>
                            <!-- /Form -->
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!-- end content -->
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
</body>
</html>
