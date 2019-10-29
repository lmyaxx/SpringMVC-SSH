<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<TITLE>更新供应商信息</TITLE> 
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
		action="${pageContext.request.contextPath }/supplier/updateSupplier"
		method=post>
		<input type="hidden" name="id" value="${supplier.id }"/>
					<div style="width:100%;height:8%;">
					<table style="text-align:right;width:100%;"><tr><td>
					<a class="easyui-linkbutton button-line-darkblue button-line-unbackground" href ="javascript:void(0);" onclick ="check()" id=sButton2 name=sButton2>更新</a>
					</td></tr></table>
									</div>
		<p><hr/><br/></p>
	<div style="width:100%;height:88%;">
		<TABLE class="table table-very table-basic" style="width:100%;text-align:center;">
			<TR>
				<td style="width:50%">
				<INPUT style="width:90%;height:30px" class="easyui-textbox"  data-options="editable:false,label:'供应商名称：',labelPosition:'left',prompt:'Name'"
					id="name"
					maxLength=50 name="name" value="${supplier.name }">
				</td>
				<td style="width:50%">
				<INPUT style="width:90%;height:30px" class="easyui-textbox"  data-options="label:'联系电话：',labelPosition:'left',prompt:'Phone'"
					 maxLength=50 name="phone" value="${supplier.phone}" id="phone">
				</td>
			</TR>
			
			<TR>
				<td style="width:50%">
				<INPUT style="width:90%;height:30px" class="easyui-textbox"  data-options="label:'供应商地址：',labelPosition:'left',prompt:'Address'"
				id="addr" maxLength=50 name="addr" value="${supplier.addr }">
				</td>
				<td style="width:50%">
				<INPUT style="width:90%;height:30px" class="easyui-textbox"  data-options="label:'联系人姓名：',labelPosition:'left',prompt:'Linkman'"
				id="linkman" maxLength=50 name="linkman" value="${supplier.linkman }">
				</td>
			</TR>
			<TR>
			    <td style="width:50%">
				供应商状态：
				<input name="state" class="easyui-switchbutton" data-options="onText:'合作中',offText:'不合作',width:80"
				<c:if test="${supplier.state == 'T' }">
				                        checked="checked"
				</c:if>>
				</td>
				<td></td>
			</TR>
			<tr style="height:0px;"><td></td><td></td></tr>
		</TABLE>
		</div>
	</FORM>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {  
		
    //验证汉字  
    CHS: {  
        validator: function (value) {  
            return /^[\u0391-\uFFE5]+$/.test(value);  
        },  
        message: '请输入中文'  
    },  
    
    mobileAndTel: {
        validator: function (value, param) {
            return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^(()|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
        },
        message: '请正确输入电话号码'
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
	
			
		$('#name').textbox({    
				//validType:['CHS','minLength[2,10]'],
				missingMessage:"不可修改"
			});
		$('#addr').textbox({   
				required:true,
				validType:['CHS','minLength[2,10]'],
				missingMessage:"请输入地址"
		});
		$('#phone').textbox({   
				 
				required:true,
				validType:'mobileAndTel',
				missingMessage:"请输入手机号码"
		});
		$('#linkman').textbox({   
				 
				required:true,
				validType:['CHS','minLength[2,4]'],
				missingMessage:"请输入联系人"
		});
		
		
		function check() {
			if($('#form1').form('validate')){
				document.getElementById('form1').submit();
			}
    }	
	</script>
</BODY>
</HTML>
