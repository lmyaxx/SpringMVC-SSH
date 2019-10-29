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
  	<form style="width:100%;height:100%;" method="post" action="${pageContext.request.contextPath }/sale/updateSalesToStateC" id="fms">
	    <div class="w_p_info" style="width:100%;height:100%;">
	    <table id="dg" class="easyui-datagrid" style="width:100%;height:100%;"
				   data-options="rownumbers:true,
								autoRowHeight:false,
								singleSelect:false,
								pagination:true,
								pageSize:10,

								remoteSort:false,
								fitColumns:true,
								multiSort:true"
		>
			<thead>
				<tr style="width:100%">
				 	<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'listId',width:100" align="center" sortable="true">销售单号</th>
					<th data-options="field:'listState',width:100" align="center">订单状态</th>
					<th data-options="field:'time',width:200" align="center"  sortable="true">销售时间</th>
					<th data-options="field:'saleId'" hidden="hidden"></th>
				</tr>
			</thead>
	    	<tbody>
			<c:forEach var="sale" items="${salelist}">
				<tr>
					<td></td>
					<td><a class="easyui-linkbutton button-grayish" href="${ pageContext.request.contextPath }/sale/getDetailSalesBySaleId?saleId=${sale.id}">${sale.id}</a></td>
					<td>${sale.state}</td>
					<td>${sale.time}</td>
					<td>${sale.id}</td>
				</tr>
			</c:forEach>
			</tbody>
			</table>
			<input type="hidden" name="method" value="confirmOutWarehouse"/>
			<div id="tb" style="padding:2px 5px;text-align:center;">
				<a href ="javascript:void(0);" onclick ="doOut()" id="tBox" class="easyui-linkbutton">确认出库</a>
			</div>
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
        
        function doOut(){
        	//document.getElementById("key").value="startToCreatePurchaseList";
            var rows = $('#dg').datagrid('getSelections');
            var tmp;
            var myform=$("#fms");
            var tmpInput;
            var tmpi;
			var flag=false;
			//alert("hahahaa");
            for(var i=0; i<rows.length; i++){
                var row = rows[i];
                tmp=(String)(row.saleId);
                if(tmp!=null){
                    flag=true;
				}
                tmpInput=$("<input type='hidden'/>");
                tmpInput.attr("name", 'keys');
                tmpInput.attr("value",tmp);
                myform.append(tmpInput);
            }
			if(flag)
				document.getElementById("fms").submit();
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
  </body>
</html>
