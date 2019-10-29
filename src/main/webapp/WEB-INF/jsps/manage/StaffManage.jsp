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
    <form style="width:100%;height:100%;" method="post" action="${ pageContext.request.contextPath }/staff/updateStaffInfo" id="fm">
	    <div class="w_p_info" style="width:100%;height: 100%">
			<table id="dg" class="easyui-datagrid" style="width:100%;height:100%;"
				   data-options="rownumbers:true,
								autoRowHeight:true,
								view:groupview,
								singleSelect:false,
								remoteSort:false,
								fitColumns:true,
								onClickCell: onClickCell,
								multiSort:true,
								groupField:'job',
				                groupFormatter:function(value,rows){
				                    return value + ' - ' + rows.length + ' Item(s)';
				                }
			"
			>
				<thead>
					<tr style="width:100%">
						<th data-options="field:'staffid',width:80" align="center" sortable="true" order="asc">员工编号</th>
						<th data-options="field:'staffname',width:100,editor:'textbox'" align="center">员工姓名</th>
						<th data-options="field:'sex',width:70,
											editor:{
												type:'combobox',
												options:{
													required:true,
													editable:false,
													valueField: 'value',  
                            						textField: 'text', 
													data:[  
														{'value':'男','text':'男'},  
														{'value':'女','text':'女'},  
													]
												}
											}
						" align="center">性别</th>
						<th data-options="field:'job',width:70,
											editor:{
												type:'combobox',
												options:{
													required:true,
													editable:false,
													valueField: 'value',  
                            						textField: 'text', 
													data:[  
														{'value':'S','text':'S'},  
														{'value':'B','text':'B'}, 
														{'value':'W','text':'W'},  
														{'value':'M','text':'M'},  
													]
												}
											}
						" align="center">职务</th>
						<th data-options="field:'password',width:100,editor:'textbox'" align="center">密码</th>
						<th data-options="field:'phonenum',width:100,editor:'numberbox'" align="center">电话</th>
						<th data-options="field:'address',width:200,editor:'textbox'" align="center">地址</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="staff" items="${stafflist}">
				<tr>
					<td>${staff.id}</td>
					<td>${staff.name}</td>
					<td>${staff.sex}</td>
					<td>${staff.job}</td>
					<td>${staff.pw}</td>
					<td>${staff.phone}</td>
					<td>${staff.addr}</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<%--<input type="hidden" id="key" name="method" value="alterStaffs"/>--%>

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
				    accept();
					var myform=$('#fm');
					var rows = $('#dg').datagrid('getChanges');
					var tmpInput;
					console.log(rows);
					for(var i=0;i<rows.length;i++){
						console.log(rows[i]);
						tmp=(String)(rows[i].staffid);
						//console.log(tmp);
						tmpInput=$("<input type='hidden'/>");
						tmpInput.attr("name",'id'+tmp);
						tmpInput.attr("value",
							(String)(rows[i].staffname)+','+
							(String)(rows[i].sex)+','+
							(String)(rows[i].job)+','+
							(String)(rows[i].phonenum)+','+
							(String)(rows[i].password)+','+
							(String)(rows[i].address)
							);
						myform.append(tmpInput);
					}
					document.getElementById('fm').submit();
				}
	</script>
 </body>
  <div id="tb" style="padding:10px 10px;text-align: center">
	  <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a>
	  <a href ="/staff/getAddStaffViewer" class="easyui-linkbutton">添加员工</a>
	  <a href ="javascript:void(0);" onclick ="doAlter()" class="easyui-linkbutton">确认修改</a>
  </div>
</html>
