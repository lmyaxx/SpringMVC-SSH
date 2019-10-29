<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Success</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 
    <link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_animation.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_plus.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_color.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
  </head>
  
  <body style="text-align:center;">
  	<table style="width:100%;height:100%;text-align:center;">
  	<tr>
  	<td style="height:40%"><div class="font-green" style="text-align:center;font-size:48px;width:100%;height:20%;">Success</div></td>
  	</tr>
  	<tr style="height:40%"><td><div class="font-black" style="text-align:center;font-size:36px;width:100%;height:20%;"">您的操作成功！</div><br/><hr/><br/></td></tr>
  	<tr style="height:20%"><td></td></tr>

  	<script language="javascript" type="text/javascript"> 
	var i = 2; 
	var intervalid; 
	intervalid = setInterval("fun()", 1000); 
	function fun() { 
		if (i == 0) { 
			document.getElementById("fm").submit();
			clearInterval(intervalid); 
		} 
		i--; 
	} 
	</script> 
  	</table>
  	  	<form id="fm" method="post" action="${ pageContext.request.contextPath }/main_welcome">
  		<input type="hidden" name="method" value="successJump">
  	</form>
  </body>
</html>
