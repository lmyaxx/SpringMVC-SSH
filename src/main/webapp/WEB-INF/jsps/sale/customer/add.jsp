<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<% 

response.setHeader("Cache-Control", "no-cache");

response.setHeader("Cache-Control", "no-store");
 
response.setDateHeader("Expires", 0); 
 
response.setHeader("Pragma", "no-cache"); 
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>添加客户</TITLE> 
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
</head>
<BODY>
	<FORM   style="width:100%;height:100%;" id=form1 name=form1
		action="/customer/saveCustomer"
		method=post>
		<div class="layui-row" style="padding: 10px 10px!important;">
			<div class="layui-card">
				<div class="layui-card-header">
					<b>添加客户信息</b>
				</div>
				<div class="layui-card-body">
					<div class="layui-form-item">
						<label class="layui-form-label">客户名称</label>
						<div class="layui-input-block">
							<INPUT  style="width:20%;height:30px" id="name" class="easyui-textbox" maxLength=50 name="name" data-options="prompt:'Name'">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户级别</label>
						<div class="layui-input-block">
							<select id="level" style="width:15%;height:30px" class="easyui-combobox"  name="vip" data-options="editable:false,required:true,validType:'comboxRequired[\'-- 请选择 --\']'">
								<option value="">-- 请选择 --</option>
								<option value="1">vip</option>
								<option value="0">普通客户 </option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">联系地址</label>
						<div class="layui-input-block">
							<INPUT class="easyui-textbox" id="addr" data-options="prompt:'Address'"
								   style="width:90%;height:30px" maxLength=50 name="addr">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户手机</label>
						<div class="layui-input-block">
							<INPUT class="easyui-textbox" id="phone" data-options="required:true,validType:'Mobile',prompt:'Phone'"
								   style="width:20%;height:30px" maxLength=50 name="phone">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户Email</label>
						<div class="layui-input-block">
							<INPUT class="easyui-textbox" id="email" data-options="required:true,validType:'Email',prompt:'Email'"
								   style="width:20%;height:30px" maxLength=50 name="email">
						</div>
					</div>
					<div class="layui-form-item" style="text-align: right;padding-right: 10%!important;">
						<a class="layui-bg-green layui-btn" href ="javascript:void(0);" onclick ="check()" id=sButton2 name=sButton2>保存</a>
					</div>
				</div>
			</div>
		</div>
	</FORM>
	<script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {  
		comboxRequired: {
        validator: function (value, param) {
            if (value == param[0]) {
                return false;
            } else {
                return true;
            }
        },
               message: '请选择'
    },
	
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

        Email: {//value值为文本框中的值
            validator: function (value) {
                var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
                return reg.test(value);
            },
            message: '请输入正确的邮箱地址'
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
})
    $('#email').textbox({

        required:true,
        validType:['Email'],
        missingMessage:"请输入邮箱地址"
    });
			
		$('#name').textbox({    
				
				required:true,
				validType:['CHS','minLength[2,10]'],
				missingMessage:"请输入客户姓名"
			});
		$('#addr').textbox({   
				 
				required:true,
				validType:'CHS',
				missingMessage:"请输入地址"
		});
		
		function check() {
			if($('#form1').form('validate')){
				document.getElementById('form1').submit();
			}
    }	
		
	</script>
</BODY>
</HTML>
