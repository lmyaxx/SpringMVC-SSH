<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>客户列表</TITLE> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		action="${pageContext.request.contextPath }/customer/searchCustomerByName"
		method=post>
		<input name="addr" type="hidden" value="sale">
		<div style="width:100%;height:100%;">
		<table id="dg" class="easyui-datagrid" title="Customer Infomation" style="width:100%;height:100%;"
				   data-options="rownumbers:true,
								autoRowHeight:false,
								fitColumns:true,
								singleSelect:true,
								pagination:true,
								pageSize:10,
								toolbar:'#tb',
								remoteSort:false,
								multiSort:true"
			>
			<THEAD>
				<TR>
					<TH data-options="field:'customerid',width:100" align="center" sortable="true">客户编号</TH>
					<TH data-options="field:'customername',width:200" align="center" sortable="true">客户名称</TH>
					<TH data-options="field:'vip',width:80,styler:cellStyler" align="center" sortable="true">客户级别</TH>
					<TH data-options="field:'phone',width:100" align="center">电话</TH>
					<TH data-options="field:'addr',width:300" align="center">客户地址</TH>
					<TH data-options="field:'func',width:100" align="center">操作</TH>
				</TR>
			</THEAD>
			<TBODY>
				<c:forEach items="${cList }" var="customer">
				<TR>
					<TD>${customer.id }</TD>
					<TD>${customer.name }</TD>
					<c:if test='${customer.vip==1}'>
						<TD>vip</TD>
					</c:if>
					<c:if test='${customer.vip==0}'>
						<TD>普通客户</TD>
					</c:if>
					<TD>${customer.phone }</TD>
					<TD>${customer.addr }</TD>
					<TD><a class="easyui-linkbutton button-grayish" href="${pageContext.request.contextPath }/sale/writeOrder?customerId=${customer.id}">确定</TD>
				</TR>
				</c:forEach>
			</TBODY>
		</TABLE>
		<div id="tb" style="padding:2px 5px;">
			<INPUT style="width:200px;" data-options="label:'客户名称：',labelPosition:'left',prompt:'Name'" 
						class="easyui-textbox" maxLength=50 name="name"></TD>
			<a class="easyui-linkbutton" href ="javascript:void(0);" 
				onclick ="document.getElementById('customerForm').submit();" >筛选</a>
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
		
		function cellStyler(value,row,index){
			if (value == "vip"){
				return 'color:red;';
			}
		}
	</script>
</BODY>
</HTML>
