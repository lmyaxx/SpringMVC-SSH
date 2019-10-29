<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<script type="text/javascript" src="${ pageContext.request.contextPath }/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>

  </head>
  
  <body>
    <form style="width:100%;height:100%;" method="post" action="${ pageContext.request.contextPath }/managers/staffProfitChart" id="fm">
		<%--<input class="easyui-datebox" required id="stime" name="stime" >--%>
		<%--<input class="easyui-datebox" required id="etime" name="etime" >--%>
	    <div class="w_p_info" style="width:100%;height:100%;">
			<table id="dg" class="easyui-datagrid" style="width:100%;height:100%;"
				   data-options="rownumbers:true,
								autoRowHeight:true,
								singleSelect:${selecttype},
								remoteSort:false,
								fitColumns:true,
								multiSort:true,
			"
			>
				<thead>
					<tr style="width:100%">
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'staffid',width:80" align="center" sortable="true" order="asc">员工编号</th>
						<th data-options="field:'staffname',width:100" align="center">员工姓名</th>
						<th data-options="field:'sex',width:70
						" align="center">性别</th>
						<th data-options="field:'job',width:70
						" align="center">职务</th>
						<th data-options="field:'password',width:100" align="center">密码</th>
						<th data-options="field:'phonenum',width:100" align="center">电话</th>
						<th data-options="field:'address',width:200" align="center">地址</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="staff" items="${stafflist}">
				<c:if test='${staff.job=="S" }'>
				<tr>
					<td></td>
					<td>${staff.id}</td>
					<td>${staff.name}</td>
					<td>${staff.sex}</td>
					<td>${staff.job}</td>
					<td>${staff.pw}</td>
					<td>${staff.phone}</td>
					<td>${staff.addr}</td>
				</tr>
				</c:if>
				</c:forEach>
				</tbody>
			</table>
			<input type="hidden" id="key" name="method" value="${charttype}"/>
			<input type="hidden"  id="stime" name="stime" value=""/>
			<input type="hidden"  id="etime" name="etime" value=""/>
	    </div>
    </form>
    <script>


        layui.use(['laydate','layer'], function(){
            var layer = layui.layer;
            var laydate = layui.laydate;
            //日期范围
            laydate.render({
                elem: '#test6'
                ,range: true
				,done: function(value, date, endDate){
                    var starttime="";
                    var endtime="";
                    starttime+=date.year;
                    starttime+="-";
                    //if (date.month<10) starttime+="0";
                    starttime+=date.month;
                    starttime+="-";
                    //if (date.date<10) starttime+="0";
                    starttime+=date.date;
                    endtime+=endDate.year;
                    endtime+="-";
                    //if (endDate.month<10) endtime+="0";
                    endtime+=endDate.month;
                    endtime+="-";
                    //if (endDate.date<10) endtime+="0";
                    endtime+=endDate.date;
                    // console.log( $('#stime'));
                    // console.log( $('#etime'));
                    $('#stime').val(starttime);
                    $('#etime').val(endtime);
				}
            });

            layer.open({
                type:1
                ,title:'操作'
                ,content:$("#tb")
                ,shade:0
                ,shadeClose:true
                ,resize:false
                ,maxmin:true
                ,area:'140px'
                ,offset:'rt'
                ,cancel: function(index, layero){
                    return false;
                }
            })
        });
				function doNext(){
					var myform=$('#fm');
					var rows = $('#dg').datagrid('getSelections');
					var tmpInput;
					console.log(rows);
					if (rows.length>=1) {
                        for (var i = 0; i < rows.length; i++) {
                            console.log(rows[i]);
                            tmp = (String)(rows[i].staffid);
                            //console.log(tmp);
                            if (rows.length == 1) {
                                tmpInput = $("<input type='hidden'/>");
                                tmpInput.attr("name", 'sid');
                                tmpInput.attr("value", tmp);
                                myform.append(tmpInput);
                            }
                            tmpInput = $("<input type='hidden'/>");
                            tmpInput.attr("name", 'id' + tmp);
                            tmpInput.attr("value", tmp);
                            myform.append(tmpInput);
                        }
                        document.getElementById('fm').submit();
                    }
                    else{
					    layui.layer.alert("请选择员工")
					}
				}
	</script>
 </body>
  <div id="tb" style="padding:2px 5px;text-align:center">
	  选择日期：
	  <input type="text" class="layui-input" id="test6" placeholder=" - ">
	  <hr>
	  <a href ="javascript:void(0);" onclick ="doNext()" class="easyui-linkbutton">生成</a>
  </div>
</html>
