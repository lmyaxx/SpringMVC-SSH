<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>待采购详情</TITLE> 
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
		action="${pageContext.request.contextPath }/supplier/getProductsOfSupplierByName"
		method=post>
		<input type="hidden" name="supplierId" value="${supplierId}" >
		<div style="width:100%;height:100%;">
				<table  id="dg" class="easyui-datagrid" title="Product Lists" style="width:100%;height:100%"
				data-options="
					singleSelect: true,
					fitColumns:true,
					rownumbers:true,
					pagination:true,
					toolbar: '#tb',
					pageSize:10,
					remoteSort:false,
					multiSort:true
				">
			<THEAD>
				<TR>
					
				<TH data-options="field:'productid',align:'center',width:80" sortable="true">产品id</TH>
					<TH data-options="field:'productname',align:'center',width:100" sortable="true">产品名称</TH>
					<TH data-options="field:'productbid',align:'center',width:80" sortable="true">产品进价</TH>
					<TH data-options="field:'unit',align:'center',width:80">产品单位</TH>
				</TR>
				</THEAD>
				<TBODY>
				<c:forEach items="${products}" var="dtp">
				<TR>
					<TD>${dtp.id }</TD>
					<TD>${dtp.name }</TD>
					<TD>${dtp.bid }</TD>
					<TD>${dtp.unit }</TD>
				</TR>
				</c:forEach>

			</TBODY>
		</TABLE>
<div id="tb" style="height:auto">
				<INPUT style="width:200px;height:30px" data-options="label:'产品名称：',labelPosition:'left',prompt:'Name'" class="easyui-textbox" id=sChannel2
					 maxLength=50 name="productName">
				 | <a class="easyui-linkbutton" href ="javascript:void(0);" onclick ="document.getElementById('customerForm').submit();" id=sButton2 name=sButton2>筛选</a> | 
				 <a class="easyui-linkbutton " href="${pageContext.request.contextPath }/supplier/getAddProductPage?supplierId=${supplierId}">添加产品</a>
			</div>
			</div>
	</FORM>
	<script>
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
			$('#dg').datagrid('clientPaging');
		});
	</script>
</BODY>
</HTML>
