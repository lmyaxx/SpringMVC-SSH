<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
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
  	<form id="fm" style="width:100%;height:100%;" method="post" action="${pageContext.request.contextPath }/DetailPurchaseList/updateDetailPurchaseListQuantityOrDelete">
    <div  class="w_p_info" style="width:100%;height:100%;">
    	<table  id="dg" class="easyui-datagrid" style="width:100%;height:100%"
				data-options="
					singleSelect: true,
					fitColumns:true,
					rownumbers:true,
					pagination:true,
					pageSize:10,
					remoteSort:false,
					multiSort:true
				">
			<thead>
				<tr>
					<th data-options="field:'productid',align:'center',width:100">产品编号</th>
					<th data-options="field:'productname',align:'center',width:300">产品名称</th>
					<c:if test="${pstate != 'A'}"><th data-options="field:'quantity',align:'center',width:80">产品数量</th></c:if>
					<c:if test="${pstate == 'A'}"><th data-options="field:'quantity',align:'center',width:80,editor:'numberbox'">产品数量</th></c:if>
					<c:if test="${pstate == 'A'}"><th data-options="field:'del',align:'center',width:60,editor:{type:'checkbox',options:{on:'√',off:''}}">删除</th></c:if>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="d" items="${detail}" varStatus="status">
				<input type="hidden" name="detailListPurchases[${status.index}].id" value="${d.id}">
				<input type="hidden" name="detailListPurchases[${status.index}].productId" value="${d.productId}">
				<tr>
					<td>${d.productId }</td>
					<td>${d.productByProductId.name }</td>
					<td>${d.quantity}</td>
					<c:if test="${pstate == 'A'}"><td></td></c:if>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<c:if test="${pstate == 'A'}">
			<input type="hidden" name="listid" value="${listid}">
			<input type="hidden" name="method" value="editPurchaseList"/>

		</c:if>
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
		
		(function($){
			function pagerFilter(data){
				if ($.isArray(data)){	// is array
					data = {
						total: data.length,
						rows: data
					};
				}
				var target = this;
				var dg = $(target);
				var state = dg.data('datagrid');
				var opts = dg.datagrid('options');
				if (!state.allRows){
					state.allRows = (data.rows);
				}
				if (!opts.remoteSort && opts.sortName){
					var names = opts.sortName.split(',');
					var orders = opts.sortOrder.split(',');
					state.allRows.sort(function(r1,r2){
						var r = 0;
						for(var i=0; i<names.length; i++){
							var sn = names[i];
							var so = orders[i];
							var col = $(target).datagrid('getColumnOption', sn);
							var sortFunc = col.sorter || function(a,b){
								return a==b ? 0 : (a>b?1:-1);
							};
							r = sortFunc(r1[sn], r2[sn]) * (so=='asc'?1:-1);
							if (r != 0){
								return r;
							}
						}
						return r;
					});
				}
				var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
				var end = start + parseInt(opts.pageSize);
				data.rows = state.allRows.slice(start, end);
				return data;
			}

			var loadDataMethod = $.fn.datagrid.methods.loadData;
			var deleteRowMethod = $.fn.datagrid.methods.deleteRow;
			$.extend($.fn.datagrid.methods, {
				clientPaging: function(jq){
					return jq.each(function(){
						var dg = $(this);
                        var state = dg.data('datagrid');
                        var opts = state.options;
                        opts.loadFilter = pagerFilter;
                        var onBeforeLoad = opts.onBeforeLoad;
                        opts.onBeforeLoad = function(param){
                            state.allRows = null;
                            return onBeforeLoad.call(this, param);
                        };
                        var pager = dg.datagrid('getPager');
						pager.pagination({
							onSelectPage:function(pageNum, pageSize){
								opts.pageNumber = pageNum;
								opts.pageSize = pageSize;
								pager.pagination('refresh',{
									pageNumber:pageNum,
									pageSize:pageSize
								});
								dg.datagrid('loadData',state.allRows);
							}
						});
                        $(this).datagrid('loadData', state.data);
                        if (opts.url){
                        	$(this).datagrid('reload');
                        }
					});
				},
                loadData: function(jq, data){
                    jq.each(function(){
                        $(this).data('datagrid').allRows = null;
                    });
                    return loadDataMethod.call($.fn.datagrid.methods, jq, data);
                },
                deleteRow: function(jq, index){
                	return jq.each(function(){
                		var row = $(this).datagrid('getRows')[index];
                		deleteRowMethod.call($.fn.datagrid.methods, $(this), index);
                		var state = $(this).data('datagrid');
                		if (state.options.loadFilter == pagerFilter){
                			for(var i=0; i<state.allRows.length; i++){
                				if (state.allRows[i] == row){
                					state.allRows.splice(i,1);
                					break;
                				}
                			}
                			$(this).datagrid('loadData', state.allRows);
                		}
                	});
                },
                getAllRows: function(jq){
                	return jq.data('datagrid').allRows;
                }
			});
		})(jQuery);

		$(function(){
			$('#dg').datagrid('clientPaging').datagrid('enableCellEditing');
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
		
		function doEdit(){
			accept();
			var rows = $('#dg').datagrid('getData').rows;
			var myform=$("#fm");
			var tmpInput;
			var temInputa;
			//var temInput2;
			for(var i=0;i<rows.length;i++){
                tmpInput=$("<input type='hidden'/>");
				//console.log(rows[i].del);
				if (rows[i].del!="√"){

					//0表示更新，1表示删除
                    tmpInput=$("<input type='hidden'/>");
                    temInputa=$("<input type='hidden'/>");
                    tmpInput.attr("name","detailListPurchases["+(String)(i)+"].bid");
                    tmpInput.attr("value","0");


                    temInputa.attr("name","detailListPurchases["+(String)(i)+"].quantity");
                    temInputa.attr("value",(String)(rows[i].quantity));
					myform.append(tmpInput);
					myform.append(temInputa);
				}
				else{
					tmp=(String)(rows[i].productid);
					tmpInput=$("<input type='hidden'/>");
					tmpInput.attr("name","detailListPurchases["+(String)(i)+"].bid");
					tmpInput.attr("value","1");
					myform.append(tmpInput);
				}
			}
			document.getElementById("fm").submit();
		}
	</script>
	</form>
  </body>
  <div id="tb" style="padding:2px 5px;text-align:center;">

	  <a href ="javascript:void(0);" onclick ="doEdit()" class="easyui-linkbutton">确认修改</a>
  </div>
</html>
