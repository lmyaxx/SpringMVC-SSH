<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 有问题，建议改后台 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>商品列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
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
<script language="JavaScript">
    function check() {
        var ids = document.getElementsByName("buy_product");
        var flag = false ;
        for(var i=0;i<ids.length;i++){
            if(ids[i].Text!=null){
                flag = true ;
                break ;
            }
        }
        if(!flag){
            alert("请最少填写一项！");
        }else {
            document.product.submit();//如果有被选择就进行提交
        }
    }
</script>
 </head>
  <body>
	<div style="width:100%;height:100%;">
  	<form id="form2" style="width:100%;height:100%;" method="post" name='quantity' action="${pageContext.request.contextPath }/sale/getBuyProductInfo">

 		<table id="dg" class="easyui-datagrid" title="Product Infomation" style="width:100%;height:100%;"
            data-options="
                singleSelect:true,
                rownumbers:true,
                fitColumns:true,
                view:groupview,
                toolbar:'#tb',
                onClickCell: onClickCell,
                groupField:'supplier',
                groupFormatter:function(value,rows){
                    return value + ' - ' + rows.length + ' Item(s)';
                }
            ">
        <thead>
            <tr>
                <th data-options="field:'productid',width:60,align:'center'">产品ID</th>
                <th data-options="field:'productname',width:200,align:'center'">名称</th>
                <th data-options="field:'supplier',width:200,align:'center'">生产商</th>
                <th data-options="field:'price',width:60,align:'center'">价格</th>
                <th data-options="field:'quantity',width:60,align:'center'">库存</th>
                <th data-options="field:'unit',width:60,align:'center'">单位</th>
                <th data-options="field:'buyquantity',width:200,align:'center',styler:cellStyler,editor:'numberbox'">购买数量</th>
            </tr>
        </thead>
        <tbody>
		<c:forEach var="product" items="${ pList }">
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
           	<td>${product.supplierBySupplierId.name}</td>
           	<td>${product.price}</td>
           	<td>${product.quantity}</td>
           	<td>${product.unit}</td>
            <td>0</td>
        </tr>
		
		</c:forEach>
		</tbody>
	</table>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/expand/jquery-easyui-datagridview/datagrid-groupview.js"></script>
	<div id="tb" style="padding:2px 5px;">
		<input id="searchbox" name="search"  HaoyuSug="67AC8F6893E541B2AA4BF09EBC09E33E"  style="width:100px; "  class="easyui-textbox"> | 
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a> | 
		<script>
        function doSearch(value){
        	document.getElementById("na").value=document.getElementById("searchbox").value;
            document.getElementById("form1").submit();
        }
    	</script>
    	<a class="easyui-linkbutton" href ="javascript:void(0);" onclick ="doSearch();">Search</a> | 
    	<a class="easyui-linkbutton" href ="javascript:void(0);" onclick ="document.getElementById('form2').reset();">重置</a> | 
		<a class="easyui-linkbutton" id="tBox" href ="javascript:void(0);" onclick ="doSubmit();">提交</a>
	</div>
  	</form>
  	<form id="form1" style="width:100%;height:100%;" method="post" action="${pageContext.request.contextPath }/product/findAllProductByName">
  		<input type="hidden" id="na" name="name" value="">
	</form>

  	<script type="text/javascript">
  		function cellStyler(value,row,index){
  			//alert(index);
  			var rows = $('#dg').datagrid('getData').rows;
    		//alert(rows[index].quantity);
			if (parseInt(value)>rows[index].quantity){
				return 'background-color:#ffee00;color:red;';
			}
			else if(value>0){
				return 'background-color:66ff33;';
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
					var myform=$('#form2');
					var rows = $('#dg').datagrid('getData').rows;
					//var tmpInput;
					//console.log(rows);
					var flag=0;//代表没有一个选中
					for(var i=0;i<rows.length;i++){
						//console.log(rows[i]);
						//tmp=(String)(rows[i].productid);
						//console.log(tmp);
						if(rows[i].buyquantity==0){
							continue;
						}
						tmp=(String)(rows[i].productid);
						//alert(rows[i].productid);
						//alert(rows[i].buyquantity);
						if(parseInt(rows[i].buyquantity)>rows[i].quantity){
							flag=1;
							break;
						}
						tmpInput=$("<input type='hidden'/>");
						tmpInput.attr("name","id"+tmp);
						tmpInput.attr("value",(String)(rows[i].buyquantity));
						//alert(rows[i].buyquantity);
						flag=2;//代表可以提交
						myform.append(tmpInput);
					}
					//alert(flag);
					if(flag==2)
						document.getElementById('form2').submit();
					else if(flag==0){
						
				 		$("#tBox").tooltip({
            			//鼠标单击是显示提示框
            			showEvent: "click",
            			showDelay: 10,
            			position:"top",
            			//content: "<span style="">你还没有选择!</span>",
            			content: '<span style="color:#fff">你还没有填写购买数量!</span>',
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
  
  </body>
 <script charset="UTF-8" src="http://www.92find.com/inteltip.js"></script>
</html>

