<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <title>管理主界面</title>
      <link href="${ pageContext.request.contextPath }/layui/css/layui.css" rel="stylesheet" type="text/css">
      <script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
      <script type="text/javascript" src="${ pageContext.request.contextPath }/js/loading.js"></script>
  </head>

  <body>
  <div class="layui-layout layui-layout-admin">

      <div class="layui-header">
          <div class="layui-logo">TLZ进销存系统
          </div>
          <ul class="layui-nav layui-layout-right">
              <li class="layui-nav-item">
                  <a href="javascript:;">
                      <img src="${ pageContext.request.contextPath }/images/${requestScope.stafftype}.png
                      <%--<c:choose>--%>
                        <%--<c:when test="${requestScope.staff==null}">${pageContext.request.contextPath }/images/default.jpg</c:when>--%>
                        <%--<c:when test="${requestScope.staff!=null && requestScope.staff.picId==null}">${pageContext.request.contextPath }/images/default.jpg</c:when>--%>
                        <%--<c:otherwise>${pageContext.request.contextPath }/headsculpture/${requestScope.staff.id}.jpg</c:otherwise>--%>
                      <%--</c:choose>--%>
                      " class="layui-nav-img">
                      ${requestScope.staff.name}
                  </a>
                  <dl class="layui-nav-child">
                      <dd><a href="${ pageContext.request.contextPath }/staff/userInfo?id=${staff.id}" target="mainframe">资料编辑</a></dd>
                      <%--<dd><a href="editUserInfo" target="mainframe">资料编辑1</a></dd>--%>
                  </dl>
              </li>
              <li class="layui-nav-item"><a href="/staff/logout">注销</a></li>
          </ul>
      </div>


      <div class="layui-side layui-bg-black">
          <div class="layui-side-scroll">
              <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
              <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                  <li class="layui-nav-item"><a href="/main_welcome" target="mainframe">首页</a></li>
                  <c:choose>
                      <c:when test='${stafftype =="W"}'>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/product/getAllProducts" target="mainframe">产品状况</a></li>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/purchase/getPurchasesStateNotEqualD" target="mainframe">采购清单</a></li>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/sale/getSalesStateEqualB" target="mainframe">销售清单</a></li>
                      </c:when>
                      <c:when test='${stafftype=="B"}'>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/purchase/getPurchasesStateEqualA" target="mainframe">待办采购</a></li>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/purchase/getPurchasesStateEqualBbyStaff" target="mainframe">我的采购</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/supplier/getAllSuppliers" target="mainframe">供应商列表</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/supplier/getAddSupplierPage" target="mainframe">新增供应商</a></li>
                      </c:when>
                      <c:when test='${stafftype=="S"}'>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/customer/returnAddCustomerVierer" target="mainframe">新增客户</a></li>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/customer/customerList" target="mainframe">客户列表</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/product/findAllProduct" target="mainframe">填写订单</a></li>
                          <li  class="layui-nav-item"><a href="${pageContext.request.contextPath }/sale/getSaleList" target="mainframe">订单列表</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/sale/getCurrentSalerBills" target="mainframe">我的订单</a></li>
                      </c:when>
                      <c:when test='${stafftype=="M"}'>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/staff/staffManage" target="mainframe">员工管理</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/product/manageProduct" target="mainframe">产品管理</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/managers/analysisData" target="mainframe">分析统计</a></li>
                          <li class="layui-nav-item"><a href="${pageContext.request.contextPath }/managers/addnews" target="mainframe">发布通知</a></li>
                      </c:when>
                      <c:otherwise>
                      </c:otherwise>
                  </c:choose>
              </ul>
          </div>
      </div>

      <div class="layui-body" style="bottom: 0px">

          <iframe id="mainframe" name="mainframe" scrolling="auto" src="main_welcome"></iframe>

      </div>
      <script type="text/javascript" src="${ pageContext.request.contextPath }/layui/layui.all.js"></script>
      <script>
          layui.use('element', function(){
              var element = layui.element;
          });
          //mainframe自适应
          $(function(){
              var w=document.body.clientWidth;
              var h=document.body.clientHeight;
              $("#mainframe").css("position","absolute").css("left",0).css("top",0).css("width",w-200).css("height",h-60);
              $("#mainframe").css("border","none");
          });

          window.onresize = function(){
              var w=document.body.clientWidth;
              var h=document.body.clientHeight;
              $("#mainframe").css("left",0).css("top",0).css("width",w-200).css("height",h-60);
          };
          //左侧栏收缩接口
          // //通过图标id来触发左侧导航栏收缩功能动画效果
          // $('#animation-left-nav').click(function(){
          //     //这里定义一个全局变量来方便判断动画收缩的效果,也就是放在最外面
          //     if(i==0){
          //         $(".layui-side").animate({width:'toggle'});
          //         $(".layui-body").animate({left:'0px'});
          //         i++;
          //     }else{
          //         $(".layui-side").animate({width:'toggle'});
          //         $(".layui-body").animate({left:'200px'});
          //         i--;
          //     }
          // });
          // //左侧导航栏收缩提示
          // $('#animation-left-nav').hover(function(){
          //     layer.tips('收缩左侧导航栏', '#animation-left-nav', {tips:[4,'#FF8000'],time:0});
          // },function(){
          //     layer.closeAll('tips');
          // });
      </script>
  </div>
  </body>
</html>
