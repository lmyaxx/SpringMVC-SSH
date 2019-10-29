<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		action="${pageContext.request.contextPath }/DetailPurchaseList/reassureUpdate"
		method=post>
		<input type="hidden" name="purchaseId" id="purchaseId" value="${purchase.id}">
		<div style="width:100%;height:8%;">
		<TABLE style="width:100%;height:100%;text-align:center;">
			<TR>
									<TD><b>采购单编号:</b>${purchase.id}</TD>
									<TD><b>发布人：</b>${purchase.staffByWarehouseKeeperId.name}</TD>
									<TD><b>发布时间：</b>${purchase.releaseTime}</TD>
								</TR>
		</TABLE>
		</div>
		<hr/>
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
				<thead>
					<TR>
						<TH data-options="field:'productid',align:'center',width:80" sortable="true">产品id</TH>
						<TH data-options="field:'productname',align:'center',width:100" sortable="true">产品名称</TH>
						<TH data-options="field:'inquantity',align:'center',width:80">进货数量</TH>
						<TH data-options="field:'supplier',align:'center',width:100" sortable="true">供应商名</TH>
						<TH data-options="field:'bid',align:'center',width:80,styler:cellStyler,editor:{type:'numberbox',options:{precision:2}}">单位价格（元）</TH>
				        <TH data-options="field:'state',align:'center',width:100">状态</TH>
					</TR>
					</thead>
					<TBODY>
					<c:forEach items="${detailListPurchases}" var="dtp" varStatus="status">
					<TR>
						<TD>${dtp.productId}</TD>
						<TD>${dtp.productByProductId.name}</TD>
						<Td>${dtp.quantity}</TD>
						<td>${dtp.productByProductId.supplierBySupplierId.name}</td>
						<TD>
							<c:if test='${empty dtp.bid}'>0.00</c:if><c:if test='${not empty dtp.bid}'>${dtp.bid}</c:if>
						</TD>
						<td>校验信息</td>
					</TR>
						<input type="hidden" name="detailListPurchases[${status.index }].id" value="${dtp.id}">
						<input type="hidden" name="detailListPurchases[${status.index }].productId" value="${dtp.productId}">
					</c:forEach>

				</TBODY>
			</TABLE>
			<div id="tb" style="text-align: center">
				<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a><hr>
				<a class="easyui-linkbutton" id="tBox" href ="javascript:void(0);" onclick ="doSubmit()" >提交</a>
			</div>
			<script type="text/javascript" src="${pageContext.request.contextPath }/insdep/themes/insdep/expand/jquery-easyui-datagridview/datagrid-groupview.js"></script>
			<script>
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
			function cellStyler(value,row,index){
				//alert(value);
				if (parseFloat(value)<0.1){
					return 'background-color:#ffee00;color:red;';
				}else{
					return 'color:green;';
				}
			}
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
				
				function doSubmit(){
					var myform=$('#customerForm');
					var rows = $('#dg').datagrid('getData').rows;
					var tmpInput;
					var flag=true;
					for(var i=0;i<rows.length;i++){

						if(rows[i].bid==0){
							flag=false;
						}
						tmpInput=$("<input type='hidden'/>");
						tmpInput.attr("name","detailListPurchases["+(String)(i)+"].bid");
						tmpInput.attr("value",(String)(rows[i].bid));
						myform.append(tmpInput);
					}
					if(flag)
					document.getElementById("customerForm").submit();
				else{
					//alert(flag);
				 	$("#tBox").tooltip({
            		//鼠标单击是显示提示框
            		showEvent: "click",
            		showDelay: 10,
            		//position:"top",
            		//content: "<span style="">你还没有选择!</span>",
            		content: '<span style="color:#fff">你还没有选择!</span>',
					onShow: function(){
					$(this).tooltip('tip').css({
						backgroundColor: '#666',
						borderColor: '#666'
					});
				},
            	//hideDelay: 500
        	});
				}
				
		}
			</script>
			</div>
	</FORM>
</BODY>
</HTML>
