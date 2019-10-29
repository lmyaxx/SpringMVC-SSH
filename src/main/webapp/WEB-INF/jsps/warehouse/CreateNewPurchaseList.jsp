<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <form style="width:100%;height:100%;"  id="fmc">
		<input type="hidden" id="key" name="method" value=""/>
    <div class="w_p_info" style="width:100%;height:100%;">
	<table  id="dg" class="easyui-datagrid" style="width:100%;height:100%"
				data-options="
					singleSelect: true,
					fitColumns:true,
					rownumbers:true,
					remoteSort:false,
					multiSort:true
				">
			<thead>
				<tr>
					<th data-options="field:'productid',align:'center',width:100">产品编号</th>
					<th data-options="field:'productname',align:'center',width:300">产品名称</th>
					<th data-options="field:'quantity',align:'center',width:80">现有数量</th>
					<th data-options="field:'alertline',align:'center',width:80">警戒线</th>
					<th data-options="field:'buyquantity',align:'center',width:60,editor:'numberbox'">购买数量</th>
				</tr>
			</thead>
			<tbody>
	    	<c:forEach  var="product" items="${selected}" varStatus="status">
                <input type="hidden" name="products[${status.index}].id" value="${product.id}">
				<%--<input type="hidden" name="products[${status.index}].bid" value="${product.bid}">--%>
	    		<tr>
	    			<td>${product.id}</td>
	    			<td>${product.name}</td>
	    			<td>${product.quantity}</td>
	    			<td>${product.alertline}</td>
	    			<td>0</td>
	    		</tr>
	    	</c:forEach>
	    	</tbody>
		</table>

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
                ,offset:'l'
                ,cancel: function(index, layero){
                    return false;
                }
            })
        });
		$.extend($.fn.datagrid.methods, {
			editCell: function(jq,param){
				return jq.each(function(){
					var opts = $(this).datagrid('options');
					var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor1 = col.editor;
						if (fields[i] != param.field){
							col.editor = null;
						}
					}
					$(this).datagrid('beginEdit', param.index);
                    var ed = $(this).datagrid('getEditor', param);
                    if (ed){
                        if ($(ed.target).hasClass('textbox-f')){
                            $(ed.target).textbox('textbox').focus();
                        } else {
                            $(ed.target).focus();
                        }
                    }
					for(var i=0; i<fields.length; i++){
						var col = $(this).datagrid('getColumnOption', fields[i]);
						col.editor = col.editor1;
					}
				});
			},
            enableCellEditing: function(jq){
                return jq.each(function(){
                    var dg = $(this);
                    var opts = dg.datagrid('options');
                    opts.oldOnClickCell = opts.onClickCell;
                    opts.onClickCell = function(index, field){
                        if (opts.editIndex != undefined){
                            if (dg.datagrid('validateRow', opts.editIndex)){
                                dg.datagrid('endEdit', opts.editIndex);
                                opts.editIndex = undefined;
                            } else {
                                return;
                            }
                        }
                        dg.datagrid('selectRow', index).datagrid('editCell', {
                            index: index,
                            field: field
                        });
                        opts.editIndex = index;
                        opts.oldOnClickCell.call(this, index, field);
                    }
                });
            }
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
		function accept(){
			if (endEditing()){
				$('#dg').datagrid('acceptChanges');
			}
		}

		$(function(){
			$('#dg').datagrid('enableCellEditing');
		});
		
    	function doBack(){
            document.getElementById("fmc").action="${pageContext.request.contextPath }/product/getAllProducts";
			document.getElementById("fmc").submit();
        }
        function doSubmit(){
            document.getElementById("fmc").action="${pageContext.request.contextPath }/purchase/createPurchase";
			var rows = $('#dg').datagrid('getData').rows;
			var myform=$("#fmc");
			var tmpInput;
			for(var i=0;i<rows.length;i++){
				tmp=(String)(rows[i].productid);
				//console.log(tmp);
				tmpInput=$("<input type='hidden'/>");
				tmpInput.attr("name","products["+(String)(i)+"].quantity");
				tmpInput.attr("value",(String)(rows[i].buyquantity));
				myform.append(tmpInput);
			}
			document.getElementById("fmc").submit();
        }
	</script>

    </form>
  </body>
  <div id="tb" style="padding:2px 5px;text-align:center;">

	  <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a>
	  <a href ="javascript:void(0);" onclick ="doBack()" class="easyui-linkbutton">返回</a>
	  <a href ="javascript:void(0);" onclick ="doSubmit()" class="easyui-linkbutton">确认提交</a>
  </div>
</html>
