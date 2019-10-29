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

  </head>
  
  <body>
    <form style="width:100%;height:100%;" method="post" action="${ pageContext.request.contextPath }/product/editProduct" id="fm">
	    <div class="w_p_info" style="width:100%;height:100%;">
			<table id="dg" class="easyui-datagrid" style="width:100%;height:100%;"
				   data-options="rownumbers:true,
								autoRowHeight:true,
								view:groupview,
								singleSelect:true,
								remoteSort:false,
								fitColumns:true,
								onClickCell: onClickCell,
								multiSort:true,
								groupField:'supplier',
				                groupFormatter:function(value,rows){
				                    return value + ' - ' + rows.length + ' Item(s)';
				                }
			"
			>
				<thead>
					<tr style="width:100%">
						<th data-options="field:'id',width:80" align="center" sortable="true" order="asc">产品编号</th>
						<th data-options="field:'name',width:100" align="center">产品名称</th>
						<th data-options="field:'supplier',width:100" align="center">供应商</th>
						<th data-options="field:'bid',width:60" align="center">进价</th>
						<th data-options="field:'price',width:60,editor:{
												type:'numberbox',
												options:{
													required:true
												}
											}" align="center">售价</th>
						<th data-options="field:'quantity',width:60" align="center">数量</th>
						<th data-options="field:'unit',width:60" align="center">单位</th>
						<th data-options="field:'alertline',width:60,editor:{
												type:'numberbox',
												options:{
													required:true
												}
											}" align="center">警戒线</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="product" items="${productlist}">
				<tr>
					<td>${product.id}</td>
					<td>${product.name}</td>
					<td>${product.supplierBySupplierId.name}</td>
					<td>${product.bid}</td>
					<td>${product.price}</td>
					<td>${product.quantity}</td>
					<td>${product.unit}</td>
					<td>${product.alertline}</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<input type="hidden" id="key" name="method" value="editProduct"/>

			<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/expand/jquery-easyui-datagridview/datagrid-groupview.js"></script>
	    </div>
    </form>
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
						//$('#dg').datagrid('acceptChanges');
					}
				}
				
				function doAlter(){
					var myform=$('#fm');
					var rows = $('#dg').datagrid('getChanges');
					var tmpInput;
					console.log(rows);
					for(var i=0;i<rows.length;i++){
						console.log(rows[i]);
						tmp=(String)(rows[i].id);
						console.log(tmp);
						tmpInput=$("<input type='hidden'/>");
						tmpInput.attr("name",'id'+tmp);
						tmpInput.attr("value",
							(String)(rows[i].price)+','+
							(String)(rows[i].alertline)
							);
						myform.append(tmpInput);
					}
					document.getElementById('fm').submit();
				}
	</script>
 </body>
  <div id="tb" style="padding:2px 5px;text-align:center">
	  <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a>
	  <a href ="javascript:void(0);" onclick ="doAlter()" class="easyui-linkbutton">确认修改</a>
  </div>
</html>
