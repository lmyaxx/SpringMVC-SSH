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
  	<form style="width:100%;height:100%;" method="post"  id="fms">
	    <div class="w_p_info" style="width:100%;height:100%;">
	    	
			<table class="easyui-datagrid"  style="width:100%;height:100%;"
	            data-options="
	                singleSelect:true,
	                rownumbers:true,
	                fitColumns:true,
	                view:groupview,

	                groupField:'liststate',
	                groupFormatter:function(value,rows){
	                    return value + ' - ' + rows.length + ' Item(s)';
	                }
	            ">
	        <thead>
	            <tr>
	                <th data-options="field:'listid',width:80,align:'center'">采购单号</th>
	                <th data-options="field:'liststate',width:100,align:'center'">订单状态</th>
	                <th data-options="field:'time',width:80,align:'center'">提交时间</th>
	                <th data-options="field:'ck',width:60,align:'center'">入库</th>
	                <th data-options="field:'ckd',width:60,align:'center'">删除</th>
	            </tr>
	        </thead>
	        <tbody>
			<c:forEach var="purchase" items="${purchaselist}" varStatus="status">
				<input type="hidden" name="purchases[${status.index}].id" value="${purchase.id}">
			<c:choose>
				<c:when test="${purchase.state == 'C'}">
					<tr>
						<td><a class="easyui-linkbutton button-grayish" href="${ pageContext.request.contextPath }/purchase/getDetailPurchaseListByPurchaseId?purchaseId=${purchase.id}">${purchase.id}</a></td>
						<td>${purchase.state}</td>
						<td>${purchase.releaseTime}</td>
						<td>
							<input type="checkbox" class="ckck" name="purchases[${status.index}].buyerId"/>
						</td>
						<td>
							<input type="checkbox" class="unck" disabled="disabled"/>
						</td>
					</tr>
				</c:when>
				<c:when test="${purchase.state == 'A'}">
					<tr>
						<td><a class="easyui-linkbutton button-grayish" href="${ pageContext.request.contextPath }/purchase/getDetailPurchaseListByPurchaseId?purchaseId=${purchase.id}">${purchase.id}</a></td>
						<td>${purchase.state}</td>
						<td>${purchase.releaseTime}</td>
						<td>
							<input type="checkbox" class="unck" disabled="disabled"/>
						</td>
						<td>
							<input type="checkbox" class="ckck" name="purchases[${status.index}].buyerId"/>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td><a class="easyui-linkbutton button-grayish" href="${ pageContext.request.contextPath }/purchase/getDetailPurchaseListByPurchaseId?purchaseId=${purchase.id}">${purchase.id}</a></td>
						<td>${purchase.state}</td>
						<td>${purchase.releaseTime}</td>
						<td><input type="checkbox" class="unck" disabled="disabled"/></td>
						<td><input type="checkbox" class="unck" disabled="disabled"/></td>
					</tr>
				</c:otherwise>
			</c:choose>
			</c:forEach>
			</tbody>
	    </table>
	    <div id="tb" style="padding:2px 5px;text-align:center;">
	    	<input type="hidden" id="key" name="method" value=""/>
	    	<a href ="javascript:void(0);" onclick ="doDel();" class="easyui-linkbutton">删除清单</a><hr>
			<a href ="javascript:void(0);" onclick ="doIn();" class="easyui-linkbutton">确认入库</a>
		</div>
    	<script type="text/javascript" src="${pageContext.request.contextPath }/insdep/themes/insdep/expand/jquery-easyui-datagridview/datagrid-groupview.js"></script>
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
	    	$(function(){
	    		$(".ckck").change(function (){
	    			if ($(this).attr("checked")=="checked"){
	    			    $(this).attr("value","0");
	    				$(this).removeAttr("checked");
	    			}
	    			else{
                        $(this).attr("value","1");
	    				$(this).attr("checked","checked");
	    			}
	    		});
	    	});
	    	
	    	function doIn(){
                document.getElementById("fms").action="${pageContext.request.contextPath }/purchase/updatePurchaseStateToDByPurchaseList";
	    		document.getElementById('fms').submit();
	    	}
	    	
	    	function doDel(){
                document.getElementById("fms").action="${pageContext.request.contextPath }/purchase/deletePurchaseStateEqualAByPurchaseList";
	    		document.getElementById('fms').submit();
	    	}
	    </script>
	    </div>
	</form>
  </body>
</html>
