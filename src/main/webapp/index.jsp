<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户登陆</title>
    <link href="${ pageContext.request.contextPath }/layui/css/layui.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${ pageContext.request.contextPath }/layui/layui.all.js"></script>
    <script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
  </head>
  
  <body>
  	<jsp:include page="/WEB-INF/jsps/login/login.jsp"></jsp:include>
  </body>
</html>