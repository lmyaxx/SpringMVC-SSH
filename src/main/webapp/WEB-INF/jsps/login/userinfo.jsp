<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/18
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/global.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/layui.css">
    <script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
</head>
<body>

<div class="layui-container">
    <div class="layui-card" style="margin-top: 20px">
        <div class="layui-card-body">
            <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title" id="LAY_mine">
                    <li class="layui-this" lay-id="info">我的资料</li>
                    <%--<li lay-id="avatar">头像</li>--%>
                    <li lay-id="pass">密码</li>
                </ul>
                <div class="layui-tab-content" style="padding: 20px 0;">
                    <div class="layui-form layui-form-pane layui-tab-item layui-show">
                        <div class="layui-form-item">
                            <label for="L_username" class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="L_username" name="username" disabled required lay-verify="required" autocomplete="off" value="${requestScope.staff.name}" class="layui-input">
                            </div>
                            <div class="layui-inline">
                                <c:choose>
                                    <c:when test="${requestScope.staff.sex eq '男'}">
                                        <div class="layui-input-inline">
                                            <input type="radio" name="sex" value="0" checked title="男">
                                            <input type="radio" name="sex" value="1" title="女">
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="layui-input-inline">
                                            <input type="radio" name="sex" value="0" title="男">
                                            <input type="radio" name="sex" value="1" checked  title="女">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="L_phone" class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" id="L_phone" name="phone" disabled required lay-verify="required" autocomplete="off" value="${requestScope.staff.phone}" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="L_addr" class="layui-form-label">地址</label>
                            <div class="layui-input-block">
                                <input type="text" id="L_addr" name="addr" disabled required lay-verify="required" autocomplete="off" value="${requestScope.staff.addr}" class="layui-input">
                            </div>
                        </div>
                    </div>

                    <%--<div class="layui-form layui-form-pane layui-tab-item">--%>
                        <%--<div class="layui-form-item">--%>
                            <%--<div class="avatar-add">--%>
                                <%--<p>建议尺寸168*168，支持jpg、png、gif，最大不能超过50KB</p>--%>
                                <%--<button id="test1" type="button" class="layui-btn upload-img">--%>
                                    <%--<i class="layui-icon">&#xe67c;</i>上传头像--%>
                                <%--</button>--%>
                                <%--<img src="${requestScope.staff.profilephoto}" id="demo1">--%>
                                <%--<span class="loading"></span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>

                    <div class="layui-form layui-form-pane layui-tab-item">
                        <form action="/staff/alterPassword" method="post">
                            <div class="layui-form-item">
                                <label for="L_nowpass" class="layui-form-label">当前密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="L_nowpass" name="nowpass" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label for="L_pass" class="layui-form-label">新密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="L_pass" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
                            </div>
                            <input type="hidden" name="id" value="${staff.id}">
                            <div class="layui-form-item">
                                <label for="L_repass" class="layui-form-label">确认密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" id="L_repass" name="rePassword" required lay-verify="required" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" key="set-mine" lay-filter="*" lay-submit>确认修改</button>
                            </div>
                        </form>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
</div>
</div>

<script src="../layui/layui.js"></script>
<script>
    layui.use(['element','form'], function(){
        var element = layui.element;
    });

    layui.use('upload', function() {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            , url: 'uploadProfileImg'
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                }
                else{
                    return layer.msg('修改成功');
                    //window.parent.location.reload();
                }
                //上传成功
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
    });
    // layui.use('form', function(){
    //     var element = layui.element;
    // });

    function mailVercode(){
        var mail=$("#L_email");
        var truedata=mail[0].value;
        $.ajax({
            url:"checkEmailAddr",
            data:{email:truedata},
            dataType:"text",
            success:function (data) {
                if (data.trim()!="error"){
                    alert("发送成功");
                }
                else{
                    alert("发送失败");
                }
            },
            error:function (data) {
                if (data.trim()!="error"){
                    alert("发送成功");
                }
                else{
                    alert("发送失败");
                }
            }
        });
    }

    function checkVercode(){
        var vercode=$("#L_vercode");
        var truedata=vercode[0].value;
        $.ajax({
            url:"checkEmailVercode",
            data:{vercode:truedata},
            dataType:"text",
            success:function (data) {
                if (data.trim()!="error"){
                    alert("校验成功");
                }
                else{
                    alert("校验失败");
                }
            },
            error:function (data) {
                if (data.trim()!="error"){
                    alert("校验成功");
                }
                else{
                    alert("校验失败");
                }
            }
        });
    }

</script>
</body>
</html>
