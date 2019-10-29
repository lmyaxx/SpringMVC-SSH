<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    

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

<c:if test="${ fn:length(sale.detailListSalesById) ne 0}">
  	<form id="form1" style="width:100%;height:100%;" method="post" name='quantity' action="${pageContext.request.contextPath }/customer/findCustomerList">
  		<input name="method" type="hidden" value="findAll">
  		<input name="addr" type="hidden" value="sale">
  		<div style="width:100%;height:8%;">
			<table style="text-align:right;width:100%;"><tr><td>
			<a class="easyui-linkbutton button-line-darkblue button-line-unbackground" href ="javascript:void(0);" onclick ="document.getElementById('form1').submit();" id=sButton2 name=sButton2>确定</a>
			</td></tr></table>
		</div>
		<p><hr/><br/></p>	
		<div style="width:100%;height:88%;">
  		<table id="dg" class="easyui-datagrid" title="Product Infomation" style="width:100%;height:100%;"
				   data-options="rownumbers:true,
								autoRowHeight:false,
								fitColumns:true,
								singleSelect:true,
								toolbar:'#tb',
								remoteSort:false,
								multiSort:true,
								onLoadSuccess: function(){
									$(this).datagrid('freezeRow',0);
								}"
			>
  		<thead>
        <tr>
            <th data-options="field:'productid',width:80" align="center" sortable="true">产品ID</th>
            <th data-options="field:'productname',width:100" align="center" sortable="true">名称</th>
            <th data-options="field:'supplier',width:200" align="center" sortable="true">生产商</th>
            <th data-options="field:'price',width:100" align="center" sortable="true">价格</th>
            <th data-options="field:'unit',width:60" align="center">单位</th>
            <th data-options="field:'quantity',width:60" align="center">购买数量</th>
            <th data-options="field:'subsum',width:60" align="center" sortable="true">小计</th>
            <th data-options="field:'func',width:80" align="center">操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
			<td></td><td></td><td></td><td></td><td></td><td>总计：</td><td>${sale.totalPrice}</td><td></td>
		</tr>
		<c:forEach var="item" items="${sale.detailListSalesById}">
		   
        <tr>
            <td>${item.productByProductId.id}</td>
            <td>${item.productByProductId.name}</td>
           	<td>${item.productByProductId.supplierBySupplierId.name}</td>
           	<td>${item.productByProductId.price}</td>
           	<td>${item.productByProductId.unit}</td>
           	<td>${item.quantity}</td>
            <td>${item.productByProductId.price*item.quantity}</td>
            <td><a class="easyui-linkbutton button-grayish" href="${pageContext.request.contextPath}/sale/deleteAddedProductByid?id=${item.productByProductId.id}">删除</a></td>
        </tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
</form>	
</c:if>
  </body>
</html>
