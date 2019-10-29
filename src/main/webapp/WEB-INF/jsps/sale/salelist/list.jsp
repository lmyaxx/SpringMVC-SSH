<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>客户列表</TITLE> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT language=javascript>
	function to_page(page){
		if(page){
			$("#page").val(page);
		}
		document.customerForm.submit();
		
	}
</SCRIPT>
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
</HEAD>
<BODY>
	<FORM id="customerForm" name="customerForm" style="width:100%;height:100%;"
		action="${pageContext.request.contextPath }/sale/getSaleListByState"
		method=post>
		<%--标记是从我的订单进入该页面的还是从订单列表，便于使用这个隐含条件
		订单列表进入取值 billList
		我的订单进入取值：myList
		--%>
		<input name="method" type="hidden" value="billList">
		
	<div style="width:100%;height:100%;">
		<table id="dg" class="easyui-datagrid" title="Salelists Infomation" style="width:100%;height:100%;"
			   data-options="rownumbers:true,
							autoRowHeight:false,
							singleSelect:true,
							pagination:true,
							pageSize:10,
							toolbar:'#tb',
							remoteSort:false,
							fitColumns:true,
							multiSort:true"
			>
				<thead>
					<tr>
						<th data-options="field:'saleid',width:60" align="center" sortable="true" order="asc">销售单号</th>
						<th data-options="field:'saler',width:80" align="center">销售员</th>
						<th data-options="field:'customer',width:80" align="center"  sortable="true">客户</th>
						<th data-options="field:'date',width:100" align="center" sortable="true">日期</th>
						<th data-options="field:'totalprice',width:100" align="center" sortable="true">总价</th>
						<th data-options="field:'state',width:80" align="center" sortable="true">状态</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${sList }" var="bill">
				<TR>
					<TD><a class="easyui-linkbutton button-grayish"
						   href="${pageContext.request.contextPath }/sale/getDetailSaleInfo?saleId=${bill.id}">${bill.id}</a></TD>
					<TD>${bill.staffBySalerId.name }</TD>
					<TD>${bill.customerByCustomerId.name}</TD>
					<TD>${bill.time}</TD>
					<TD>${bill.totalPrice }</TD>
					<td>${bill.state }</td>
				</TR>
				</c:forEach>
			</tbody>
		</table>
		<div id="tb" style="padding:2px 5px;">
			<select style="width:200px;h" class="easyui-combobox" name="state" data-options="label:'供应商状态：',labelPosition:'left'">
					<option value="B" selected="selected">未出库</option>
					<option value="C">出库 </option>
			</select>
			<a class="easyui-linkbutton" href ="javascript:void(0);" onclick ="document.getElementById('customerForm').submit();" >筛选</a>
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
			//$('#dg').datagrid('clientPaging');
		});
		
		
	</script>
</BODY>
</HTML>
