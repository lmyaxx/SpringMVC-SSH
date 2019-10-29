<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户登陆</title>
      <link href="${ pageContext.request.contextPath }/layui/css/layui.css" rel="stylesheet" type="text/css">
      <script type="text/javascript" src="${ pageContext.request.contextPath }/layui/layui.all.js"></script>
      <script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
      <script type="text/javascript" src="${ pageContext.request.contextPath }/js/loading.js"></script>
	<%--<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">--%>
	<%--<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_animation.css" rel="stylesheet" type="text/css">--%>
	<%--<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_plus.css" rel="stylesheet" type="text/css">--%>
	<%--<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">--%>
	<%--<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">--%>
	<%----%>
	<%--<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.min.js"></script>--%>
	<%--<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.easyui.min.js"></script>--%>
	<%--<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>--%>
  </head>
  <body style="background-image: url(../../../images/index.jpg);background-repeat:no-repeat;width: 100%;height: 100%;background-size: 100% 100%">
  <div class="layui-card layui-col-md6 layui-col-lg-offset3" style="top:10%;opacity:0.8;">
      <div class="layui-card-body">
          <div class="fly-panel fly-panel-user"  pad20>
              <div class="layui-logo" align="center">TLZ进销存系统
              </div>
              <div class="layui-tab layui-tab-brief" lay-filter="user">
                  <ul class="layui-tab-title">
                      <li class="layui-this">登入</li>
                  </ul>
                  <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                      <div class="layui-tab-item layui-show">
                          <div class="layui-form layui-form-pane">
                              <form method="post" action="/index">
                                  <div class="layui-form-item">
                                      <label for="L_username" class="layui-form-label">用户名</label>
                                      <div class="layui-input-inline">
                                          <input type="text" id="L_username" name="username" required lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                                      </div>
                                  </div>
                                  <div class="layui-form-item">
                                      <label for="L_password" class="layui-form-label">密码</label>
                                      <div class="layui-input-inline">
                                          <input type="password" id="L_password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">

                                      </div>
                                      <div class="layui-form-mid layui-word-aux">${msg}</div>
                                  </div>
                                  <div class="layui-form-item">
                                      <label for="L_vercode" class="layui-form-label">验证码</label>
                                      <div class="layui-input-inline">
                                          <input type="text" id="L_vercode" name="vercode" required lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                                      </div>
                                      <div >
                                          <img id="imgObj" alt="验证码" src="/captcha/getCaptchaImage.jpg" onclick="changeImg()">
                                      </div>
                                      <input id="timestamp" name="timestamp" value="${timestamp }" type="hidden" >
                                  </div>

                                  <div class="layui-form-item">
                                      <button class="layui-btn" lay-filter="*" lay-submit>立即登录</button>
                                        <span style="padding-left:20px;">
                                          <a ></a>
                                        </span>
                                  </div>

                              </form>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
  </div>

  <script type="text/javascript">
      if (top.location !== self.location){
          top.location=self.location;
      }
      layui.use('element', function(){
          var element = layui.element;
      });
      function checkImageCode(code) {
          var timestamp = $("#timestamp").val().trim();
          console.log(code + " " + timestamp);
          var haha = "";

          $.ajax({
              type : 'post',
              async : false,
              url : '/captcha/checkCaptcha',
              data : {
                  "code" : code
              },
              success : function(data) {
                  haha = data;
              }
          });
          console.log(haha);
          return haha;
      }
      $("form").submit(function check(){
          //alert("teete");
          var code = $("#L_vercode").val().trim();
          if(code.length != 0 ){
              var status = checkImageCode(code).trim();
              //alert(status);
              if(status.indexOf("true")>=0){
                  //alert("成功");
                  return true;
              }else{
                  changeImg();
                  alert("验证码错误");
              }
          }else{
              alert("请输入验证码");
          }

          return false;
      });
      function changeImg() {
          var imgSrc = $("#imgObj");
          var src = imgSrc.attr("src");
          imgSrc.attr("src", chgUrl(src));
      };
      //时间戳
      //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
      function chgUrl(url) {
          var timestamp = (new Date()).valueOf();
          var stamp = $("#timestamp");
          /* alert(url);
          url = url.substring(0, 60);
          if ((url.indexOf("&") >= 0)) {
              url = url + "×tamp=" + timestamp;
          } else {
              url = url + "?timestamp=" + timestamp;
              stamp.val(timestamp);
          } */
          return url;
      };
  </script>

  <script type="text/javascript">



      // function checkImageCode(code) {
      //     var timestamp = $("#timestamp").val().trim();
      //     console.log(code + " " + timestamp);
      //     var haha = "";
      //
      //     $.ajax({
      //         type : 'post',
      //         async : false,
      //         url : '/captcha/checkCaptcha',
      //         data : {
      //             "code" : code
      //         },
      //         success : function(data) {
      //             haha = data;
      //         }
      //     });
      //     console.log(haha);
      //     return haha;
      // }
      // $("form").submit(function check(){
      //     //alert("teete");
      //     var code = $("#L_vercode").val().trim();
      //     if(code.length != 0 ){
      //         var status = checkImageCode(code).trim();
      //         //alert(status);
      //         if(status.indexOf("true")>=0){
      //             //alert("成功");
      //             return true;
      //         }else{
      //             changeImg();
      //             alert("验证码错误");
      //         }
      //     }else{
      //         alert("请输入验证码");
      //     }
      //
      //     return false;
      // });
      // function changeImg() {
      //     var imgSrc = $("#imgObj");
      //     var src = imgSrc.attr("src");
      //     imgSrc.attr("src", chgUrl(src));
      // };
      // //时间戳
      // //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
      // function chgUrl(url) {
      //     var timestamp = (new Date()).valueOf();
      //     var stamp = $("#timestamp");
      //     /* alert(url);
      //     url = url.substring(0, 60);
      //     if ((url.indexOf("&") >= 0)) {
      //         url = url + "×tamp=" + timestamp;
      //     } else {
      //         url = url + "?timestamp=" + timestamp;
      //         stamp.val(timestamp);
      //     } */
      //     return url;
      // };
  </script>

  </body>
  <%--<body class="theme-login-layout">--%>
		<%--<div class="theme-login-header" style="height: 60px;"></div>--%>
		<%--<div id="theme-login-form">--%>
            <%--<form id="form" action="/staff/login" class="theme-login-form" method="post">--%>
            <%--<input type="hidden" name="method" value="userLogin" />--%>
            <%--<dl>--%>
                <%--<dt><img src="${ pageContext.request.contextPath }/images/logo_110.png"></dt>--%>
                <%--<dd><input id="username" name="username" class="theme-login-text "  style="width:100%;"/></dd>--%>
                <%--<dd><input id="password" name="password" class="theme-login-text"  style="width:100%;"/></dd>--%>
                <%--<dd><a class="submit" href ="javascript:void(0);" onclick="check()">登录</a><a class="easyui-linkbutton button" href="${ pageContext.request.contextPath }/login?method=forgetPw">忘记密码</a></dd>--%>
            <%--</dl>--%>
            <%--</form>--%>
        <%--</div>--%>

    	<%--<div class="theme-login-footer">--%>
        	<%--<dl>--%>
        	<%--</dl>--%>
        <%--</div>--%>
    <%--<script>--%>
    	<%--$.extend($.fn.validatebox.defaults.rules, {  --%>
		<%--comboxRequired: {--%>
        <%--validator: function (value, param) {--%>
            <%--if (value == param[0]) {--%>
                <%--return false;--%>
            <%--} else {--%>
                <%--return true;--%>
            <%--}--%>
        <%--},--%>
               <%--message: '请选择'--%>
    <%--},--%>
	<%----%>
   <%----%>
	<%--minLength: {--%>
        <%--validator: function (value, param) {--%>
            <%--return value.length >= param[0]--%>
        <%--},--%>
        <%--message: '至少输入{0}位'--%>
    <%--},--%>
    <%--Number: {  --%>
        <%--validator: function (value) {  --%>
            <%--var reg =/^[0-9]*$/;  --%>
            <%--return reg.test(value);  --%>
        <%--},  --%>
        <%--message: '请输入数字'  --%>
    <%--},  --%>
<%--})--%>
    		<%----%>

			<%--/*布局部分*/--%>
			<%--$('#theme-login-layout').layout({--%>
				<%--fit:true/*布局框架全屏*/--%>
			<%--});     --%>
			<%----%>
			<%--$('#username').textbox({    --%>
				<%--prompt:'Account or number',--%>
				<%--required:true,--%>
				<%--validType:['Number','minLength[4,10]'],--%>
				<%--missingMessage:"请输入用户名"--%>
			<%--});--%>
			<%--$('#password').textbox({    --%>
				<%--type:"password",--%>
				<%--prompt:'Password',--%>
				<%--required:true,--%>
				<%--validType:['Number','minLength[6,10]'],--%>
				<%--missingMessage:"请输入密码"--%>
			<%--});--%>
			<%----%>
			<%--$('.submit').linkbutton({    --%>
				<%----%>
			<%--}); --%>
			<%----%>
			<%--function check() {--%>
				<%--if($('#form').form('validate')){--%>
					<%--document.getElementById('form').submit();--%>
				<%--}--%>
			<%--}--%>
    <%--</script>--%>
  <%--</body>--%>
</html>