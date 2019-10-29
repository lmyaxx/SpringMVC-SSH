<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_animation.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_plus.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui_color.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/plugin/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/insdep_tables.css" rel="stylesheet" type="text/css">

	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/loading.js"></script>
  </head>

  
	<body>
		<div style="width:100%;">
		<table  id="dg1" class="easyui-datagrid" title="购买物品 - # ${id }" style="width:100%;height:auto;"
		data-options="
			singleSelect: true,
			collapsible:true,
			fitColumns:true,
			rownumbers:true,
			remoteSort:false,
			multiSort:true,
			onLoadSuccess: function(){
									$(this).datagrid('freezeRow',0);
								}"
		">
  		<thead><tr>
            <th data-options="field:'productid',align:'center',width:80" sortable="true">产品ID</th>
            <th data-options="field:'productname',align:'center',width:100" sortable="true">名称</th>
            <th data-options="field:'supplicer',align:'center',width:200" sortable="true">生产商</th>
            <th data-options="field:'price',align:'center',width:80" sortable="true">价格</th>
            <th data-options="field:'quantity',align:'center',width:60">购买数量</th>
            <th data-options="field:'unit',align:'center',width:60">购买单位</th>
            <th data-options="field:'subtotal',align:'center',width:60" sortable="true">小计</th>
        </tr></thead>
        <tbody>
        <tr><td></td><td></td><td></td><td></td><td></td><td>总价：</td><td>${item.total}</td></tr>
		<c:forEach var="item" items="${sale.detailListSalesById}">
        <tr>
            <td>${item.productByProductId.id}</td>
            <td>${item.productByProductId.name}</td>
           	<td>${item.productByProductId.supplierBySupplierId.name}</td>
           	<td>${item.productByProductId.price}</td>
           	<td>${item.quantity}</td>
           	<td>${item.productByProductId.unit}</td>
            <td>${item.productByProductId.price*item.quantity}</td>
        </tr>
	</c:forEach>
	</tbody>
	</table>
	<br/><hr/><br/>
  		<table  id="dg2" class="easyui-datagrid" title="客户信息 - # ${id }" style="width:100%;height:auto;"
		data-options="
			singleSelect:true,
			collapsible:true,
			fitColumns:true,
		">
        <thead><tr>
            <th data-options="field:'customerid',align:'center',width:80">客户编号</th>
            <th data-options="field:'customername',align:'center',width:80">客户姓名</th>
            <th data-options="field:'phone',align:'center',width:100">联系方式</th>
            <th data-options="field:'customeraddr',align:'center',width:200">地址</th>
            <th data-options="field:'vip',align:'center',width:60">客户级别</th>
            <th data-options="field:'date',align:'center',width:80">购买日期</th>
            <th data-options="field:'state',align:'center',width:60">订单状态</th>
        </tr></thead>
        <tbody> 
        <tr>
            <td>${sale.customerByCustomerId.id}</td>
            <td>${sale.customerByCustomerId.name}</td>
           	<td>${sale.customerByCustomerId.phone}</td>
           	<td>${sale.customerByCustomerId.addr}</td>
			<c:if test='${sale.customerByCustomerId.vip==1}'>
				<TD>vip</TD>
			</c:if>
			<c:if test='${sale.customerByCustomerId.vip==0}'>
				<TD>普通客户</TD>
			</c:if>
           	<td>${sale.time}</td>
           	<td>${sale.state}</td>
        </tr>
        </tbody>
</table>
<br/><hr/><br/>
  		<table  id="dg3" class="easyui-datagrid" title="销售员信息 - # ${id }" style="width:100%;height:auto;"
		data-options="
			singleSelect:true,
			collapsible:true,
			fitColumns:true,
		">
        <thead><tr>
            <th data-options="field:'salerid',align:'center',width:80">编号</th>
            <th data-options="field:'saler',align:'center',width:80">姓名</th>
            <th data-options="field:'salerphone',align:'center',width:80">联系方式</th>
            <th data-options="field:'saleraddr',align:'center',width:200">地址</th>
        </tr></thead>
        <tbody>
        <tr>
        	<td>${sale.staffBySalerId.id}</td>
        	<td>${sale.staffBySalerId.name}</td>
        	<td>${sale.staffBySalerId.phone}</td>
        	<td>${sale.staffBySalerId.addr}</td>
        </tr>
        </tbody>   
</table>
</div>

	</body>
</html>
