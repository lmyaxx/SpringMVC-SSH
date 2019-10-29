<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>采购详情</TITLE> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/layui.css">
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/global.css">
	<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/js/loading.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/layui/layui.js"></script>
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
	<link href="${ pageContext.request.contextPath }/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
	<link href="${pageContext.request.contextPath }/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">
<SCRIPT language=javascript>
	function to_page(page){
		if(page){
			$("#page").val(page);
		}
		document.customerForm.submit();
		
	}
</SCRIPT>

</HEAD>
<BODY>
	<FORM style="width:100%;height:100%;" id="customerForm" name="customerForm"
		action="${pageContext.request.contextPath }/PurchaseServlet?method=reassure"
		method=post>
		<input type="hidden" name="purchaseId" value="${purchase.id}">
	<div style="width:100%;height:100%;">
		<table  id="dg" class="easyui-datagrid" title="Detail List" style="width:100%;height:100%"
				data-options="
					singleSelect: true,
					fitColumns:true,
					rownumbers:true,
					view:groupview,
					toolbar:'#tb',
					remoteSort:false,
					multiSort:true,
					
					groupField:'supplier',
	                groupFormatter:function(value,rows){
	                    return value + ' - ' + rows.length + ' Item(s)';
	                }
				">
		<THEAD>
			<TR>
				<TH data-options="field:'productid',align:'center',width:80" sortable="true">产品id</TH>
				<TH data-options="field:'productname',align:'center',width:100" sortable="true">产品名称</TH>
				<TH data-options="field:'inquantity',align:'center',width:80">进货数量</TH>
				<TH data-options="field:'supplier',align:'center',width:100" sortable="true">供应商名</TH>
				<TH data-options="field:'bid',align:'center',width:80" sortable="true">以往单价（元）</TH>
		        <TH data-options="field:'phone',align:'center',width:100">联系电话</TH>
			</TR>
			</THEAD>
			<TBODY>
			<c:forEach items="${detailListPurchases}" var="dtp">
			<TR>
				<TD>${dtp.productId }</TD>
				<TD>${dtp.productByProductId.name }</TD>
				<Td>${dtp.quantity }</TD>
				<td>${dtp.productByProductId.supplierBySupplierId.name}</td>
				<TD>${dtp.productByProductId.bid}</TD>
				<TD>${dtp.productByProductId.supplierBySupplierId.phone}</TD>
			</TR>
			</c:forEach>

		</TBODY>
	</TABLE>
		${purchase.id}
		${purchase.staffByWarehouseKeeperId.name}
	<script type="text/javascript" src="${pageContext.request.contextPath }/insdep/themes/insdep/expand/jquery-easyui-datagridview/datagrid-groupview.js"></script>
		<DIV id="tb" style="padding:2px 5px;">

			<b>采购单编号：</b>${purchase.id} || 
			<b>发布人：</b>${purchase.staffByWarehouseKeeperId.name} ||
			<b>发布时间：</b>${purchase.releaseTime} 

		</DIV>
</div>
	</FORM>
</BODY>
</HTML>
