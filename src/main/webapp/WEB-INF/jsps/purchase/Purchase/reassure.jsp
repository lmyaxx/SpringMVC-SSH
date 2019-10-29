<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>采购详情</TITLE>
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
		action="${pageContext.request.contextPath }/purchase/updatePurchaseFromBToC"
		method=post>
		<input type="hidden" name="purchaseId" value="${purchase.id}">
		<input type="hidden" name="totalPrice" value="${totalPrice}">
		<div style="width:100%;height:8%;">
		<TABLE style="width:100%;height:100%;text-align:center;">
			<TR>
									<TD><b>采购单编号:</b>${purchase.id}</TD>
									<TD><b>发布人：</b>${purchase.staffByWarehouseKeeperId.name}</TD>
									<TD><b>发布时间：</b>${purchase.releaseTime}</TD>
									<TD><b>总价：</b>${totalPrice}元</TD>

								</TR>
		</TABLE>
		</div>
		<p><hr/><br/></p>
		<div style="width:100%;height:88%;">
		<table  id="dg" class="easyui-datagrid" title="Detail List" style="width:100%;height:100%"
				data-options="
					singleSelect:true,
					fitColumns:true,
					rownumbers:true,
					view:groupview,
					remoteSort:false,
					multiSort:true,
					onClickCell: onClickCell,
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
						<TH data-options="field:'bid',align:'center',width:80">单位价格</TH>
				</TR>
				</THEAD>
				<TBODY>
				<c:forEach items="${detailListPurchases}" var="dtp">
				<TR>
					<TD>${dtp.productId }</TD>
					<TD>${dtp.productByProductId.name }</TD>
					<Td>${dtp.quantity }</TD>
					<td>${dtp.productByProductId.supplierBySupplierId.name}</td>
					<TD>${dtp.bid}</TD>
				</TR>
				</c:forEach>

			</TBODY>
		</TABLE>
		<script type="text/javascript" src="${pageContext.request.contextPath }/insdep/themes/insdep/expand/jquery-easyui-datagridview/datagrid-groupview.js"></script>
		<div id="tb" style="height:auto;text-align:center;">
			<a class="easyui-linkbutton" href ="javascript:void(0);" onclick ="document.getElementById('customerForm').submit();">确认提交</a>
		</div>
		<script type="text/javascript">
            layui.use('layer', function(){
                var layer = layui.layer;

                layer.open({
                    type:1
                    ,title:'操作'
                    ,content:$("#tb")
                    ,shade:0
                    ,shadeClose:true
                    ,resize:false
                    ,maxmin:true
                    ,area:'140px'
                    ,offset:'r'
                    ,cancel: function(index, layero){
                        return false;
                    }
                })
            });
							var editIndex = undefined;
				function endEditing(){
					if (editIndex == undefined){return true}
					if ($('#dg').datagrid('validateRow', editIndex)){
						$('#dg').datagrid('endEdit', editIndex);
						editIndex = undefined;
						return true;
					} else {
						return false;
					}
				}
				function onClickCell(index, field){
					if (editIndex != index){
						if (endEditing()){
							$('#dg').datagrid('selectRow', index)
									.datagrid('beginEdit', index);
							var ed = $('#dg').datagrid('getEditor', {index:index,field:field});
							if (ed){
								($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
							}
							editIndex = index;
						} else {
							setTimeout(function(){
								$('#dg').datagrid('selectRow', editIndex);
							},0);
						}
					}
				}

				function accept(){
					if (endEditing()){
						$('#dg').datagrid('acceptChanges');
					}
				}
		</script>
	</div>
	</FORM>
</BODY>
</HTML>
