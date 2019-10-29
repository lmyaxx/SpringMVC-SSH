<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	  <link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
	  <link href="${ pageContext.request.contextPath }/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
	  <script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
	<script src="${ pageContext.request.contextPath }/insdep/plugin/justgage-1.2.2/raphael-2.1.4.min.js"></script>
    <script src="${ pageContext.request.contextPath }/insdep/plugin/justgage-1.2.2/justgage.js"></script>
    <script src="${ pageContext.request.contextPath }/insdep/plugin/Highcharts-5.0.0/js/highcharts.js"></script>
  </head>
  
  <body>
  <div class="layui-row layui-col-md12">
	  <div class="layui-card" style="margin-bottom: 0px!important;">
		  <div class="layui-card-body" style="padding-top: 0px!important;padding-bottom: 0px!important;" >
    <div id="tt" class="easyui-tabs theme-tab-blue-block theme-tab-line-bold" style="width:100%;height:100%">
		<div title="About" style="padding:10px;width:100%;height:100%">
			<form id="fm" style="visibilit:hidden;height:0px;width:0px;">
				<input type="hidden" id="totalC" value="${tC }"/>
				<input type="hidden" id="vipC" value="${vC }"/>
				<input type="hidden" id="activeC" value="${aC }"/>
				<input type="hidden" id="totalS" value="${tS }"/>
				<input type="hidden" id="activeS" value="${aS }"/>
			</form>
			<table style="width:100%;height:90%;text-align:center">
			<tr>
				<td style="width:30%">
					客户总数：${tC }
					<br/>
					Vip客户总数：${vC }
					<br/>
					活跃客户总数：${aC }
				</td>
				<td style="width:40%">
				    <div id="g1"></div>
				</td>
				<td style="width:40%">
				    <div id="g2"></div>
				</td>
			</tr>
			<tr>
				<td style="width:30%">
					供应商信息总数：${tS }
					<br/>
					合作中供应商总数：${aS }
				</td>
				<td style="width:40%">
					<div id="g3"></div>
				</td>
				<td style="width:40%">
					
				</td>
			</tr>
			</table>
		</div>
		<div title="统计图" style="padding:10px;width:100%;height:100%">
		    <table style="width:100%;height:100%;text-align:center;">
    	<tr style="height:50%;">
    	<td style="width:50%;">
    		<a style="width:60%;height:60%;" href="${ pageContext.request.contextPath }/managers/createStaffProfitChart" class="easyui-linkbutton button-line-darkblue">员工销售利润折线图</a>
    	</td>
    	<td style="width:50%;">
    		<a style="width:60%;height:60%;" href="${ pageContext.request.contextPath }/managers/createStaffProfitCompareChart" class="easyui-linkbutton button-line-darkblue">员工销售利润比较图</a>
    	</td></tr>
    	<tr style="height:50%;">
    	<td style="width:50%;">
    		
    	</td>
    	<td style="width:50%;">
    		
    	</td></tr>
    </table>
		</div>
	</div>
		  </div>
	  </div>
  </div>
	<script type="text/javascript">
		$(function(){
			//var test=[[Date.UTC(1970, 9, 21), 0],[Date.UTC(1975, 1, 11), 0]];
			//console.log(JSON.stringify(test));
			
			var tabs = $('#tt').tabs().tabs('tabs');
			for(var i=0; i<tabs.length; i++){
				tabs[i].panel('options').tab.unbind().bind('mouseenter',{index:i},function(e){
					$('#tt').tabs('select', e.data.index);
				});
			}
		});
		
		document.addEventListener("DOMContentLoaded", function(event) {

		    var dfltc = {
		      min: 0,
		      max: document.getElementById('totalC').value,
		      donut: true,
		      gaugeWidthScale: 0.6,
		      counter: true,
		      hideInnerShadow: true
		    }
		    
		    var dflts = {
		      min: 0,
		      max: document.getElementById('totalS').value,
		      donut: true,
		      gaugeWidthScale: 0.6,
		      counter: true,
		      hideInnerShadow: true
		    }
		
		    var g1 = new JustGage({
		      id: 'g1',
		      value: document.getElementById('vipC').value,
		      title: 'VIP',
		      defaults: dfltc
		    });
		
		    var g2 = new JustGage({
		      id: 'g2',
		      value: document.getElementById('activeC').value,
		      title: 'Active Customers',
		      defaults: dfltc
		    });
		    
		    var g3 = new JustGage({
		      id: 'g3',
		      value: document.getElementById('activeS').value,
		      title: 'Active Suppliers',
		      defaults: dfltc
		    });
		
		  });
	</script>
  </body>
</html>
