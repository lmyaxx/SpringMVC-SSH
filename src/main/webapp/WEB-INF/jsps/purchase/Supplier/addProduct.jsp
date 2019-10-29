<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>增加供应商产品</TITLE> 
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
</HEAD>
<BODY>
	<FORM style="width:100%;height:100%;" id=form1 name=form1
		action="${pageContext.request.contextPath }/SupplierServlet?method=addProduct"
		method=post>
		<input type="hidden" name="supplierId" value="${supplier.id }"/>
		<input type="hidden" name="alertline" value="0"/>
		<input type="hidden" name="price" value="0"/>
		<input type="hidden" name="quantity" value="0"/>
		<div class="layui-row" style="padding: 10px 10px!important;">
			<div class="layui-card">
				<div class="layui-card-header">
					<b>添加产品</b>
				</div>
				<div class="layui-card-body">
					<div class="layui-form-item">
						<label class="layui-form-label">产品名称</label>
						<div class="layui-input-block">
							<input style="width:30%;height:30px" id="name" class="easyui-textbox" maxLength=50 name="name" data-options="prompt:'Name'">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">预期价格</label>
						<div class="layui-input-block">
							<input style="width:10%;height:30px" id="bid" class="easyui-textbox" maxLength=50 name="bid" data-options="prompt:'Bid'">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">产品单位</label>
						<div class="layui-input-block">
							<input style="width:10%;height:30px" id="unit" class="easyui-textbox" maxLength=50 name="unit" data-options="prompt:'Unit'">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">供应商</label>
						<div class="layui-input-block">
							<input value="${supplier.name}" disabled="disabled" style="width:60%;height:30px" id=sChannel2 class="easyui-textbox" maxLength=50 name="supplierName" data-options="prompt:'SupplierName'">
						</div>
					</div>
					<div class="layui-form-item" style="text-align: right;padding-right: 10%!important;">
						<a class="layui-btn layui-bg-green" href ="javascript:void(0);" onclick ="check()" id=sButton2 name=sButton2>确认增加</a>
					</div>
				</div>
			</div>
		</div>
	</FORM>
	<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {  
		
    //验证汉字  
    CHS: {  
        validator: function (value) {  
            return /^[\u0391-\uFFE5]+$/.test(value);  
        },  
        message: '请输入汉字'  
    },  
    //移动手机号码验证  
    Mobile: {//value值为文本框中的值  
        validator: function (value) {  
            var reg = /^1[3|4|5|8|9]\d{9}$/;  
            return reg.test(value);  
        },  
        message: '请输入正确的联系方式'  
    },  
	minLength: {
        validator: function (value, param) {
            return value.length >= param[0]
        },
        message: '至少输入{0}个字'
    },
    Number: {  
        validator: function (value) {  
            var reg =/^[0-9]*$/;  
            return reg.test(value);  
        },  
        message: '请输入数字'  
    },  
    money: {
        validator: function (value, param) {
        	if(value == 0)
        		return false;
            return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(value);
        },
        message: '请输入正确的金额'

    }
})
	
			
		$('#name').textbox({    
				
				required:true,
				validType:['CHS','minLength[2,10]'],
				missingMessage:"请输入产品名称"
			});
		$('#bid').textbox({   
				required:true,
				validType:'money',
				missingMessage:"请输入价格"
		});
		$('#unit').textbox({   
				 
				required:true,
				validType:['CHS','minLength[1,10]'],
				missingMessage:"请输入单位"
		});
		
		
		
		function check() {
			if($('#form1').form('validate')){
				document.getElementById('form1').submit();
			}
    }	
		
	</script>
</BODY>
</HTML>
