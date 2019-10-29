<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	  <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/layui.css">
	  <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/global.css">
	  <script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
	  <script type="text/javascript" src="${ pageContext.request.contextPath }/js/loading.js"></script>
	  <script type="text/javascript" src="${ pageContext.request.contextPath }/layui/layui.js"></script>
	  <title>Welcome</title>
  <body class="layui-layout-body">
  <div class="layui-layout layui-layout-admin" >
	  <div class="layui-container">
		  <div class="layui-row" style="margin-bottom: 10px;margin-top: 10px;">
			  <div class="layui-carousel" id="test1">
				  <div carousel-item>
					  <c:forEach items="${requestScope.newsList}" var="news">
						  <div><a href="${ pageContext.request.contextPath }/news/getNewsById?newsId=${news.newsId}">
							  <img src="${ pageContext.request.contextPath }/images/news/${news.picId}" width="980px" height="370px"/>
						  </a> </div>
					  </c:forEach>
					  <%--<div><a href="#"><img src="/images/1.jpg"/></a> </div>--%>
					  <%--<div><a href="#"><img src="/images/default.jpg"/></a> </div>--%>
				  </div>
			  </div>
		  </div>
		  <div class="layui-row layui-col-space10">
			  <div class="layui-col-md12">
				  <div class="layui-card">
					  <div class="layui-card-header layui-bg-cyan">新闻通知
						  <span class="fly-filter-right">
                            <a class="layui-badge layui-bg-blue" href="${ pageContext.request.contextPath }/news/getNewsByPageAndSize?page=1&size=10"><h3>更多</h3></a>
                        </span>
					  </div>
					  <div class="layui-card-body">
						  <ul>
							  <c:forEach var="news" items="${requestScope.newsList}">
							  	<li><a href="${ pageContext.request.contextPath }/news/getNewsById?newsId=${news.newsId}">${news.title}</a></li>
							  </c:forEach>
						  </ul>
					  </div>
				  </div>
			  </div>
		  </div>
	  </div>
  </div>

  <script>
      //layui初始化
      layui.use(['element','carousel'], function(){
          var element = layui.element;
          var carousel = layui.carousel;
          //建造实例
          carousel.render({
              elem: '#test1'
              ,width: '100%' //设置容器宽度
              ,height: '300px'
              ,arrow: 'always' //始终显示箭头
              //,anim: 'fade' //切换动画方式
          });
      })

  </script>
  </body>
</html>