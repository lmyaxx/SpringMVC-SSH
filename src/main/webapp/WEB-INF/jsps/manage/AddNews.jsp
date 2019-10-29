<%--
  Created by IntelliJ IDEA.
  User: zicyair
  Date: 2018/6/28
  Time: 12:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/global.css">
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/layui/css/layui.css">
    <style>
        .mce-window {
            transform: initial !important;
        }
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-container">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card" style="margin-top: 20px">
                    <div class="layui-card-header layui-bg-cyan">新闻通知</div>
                    <div class="layui-card-body">
                        <div class="fly-panel my-editor-panel">
                            <div class="layui-form layui-form-pane">
                                <div class="layui-tab layui-tab-brief" lay-filter="user">
                                    <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                                        <div class="layui-tab-item layui-show">
                                            <form class="layui-form" action="${ pageContext.request.contextPath }/news/addNews" method="post">
                                                <div class="layui-row layui-col-space15 layui-form-item">
                                                    <div class="layui-col-md12">
                                                        <label for="L_title" class="layui-form-label">标题</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" id="L_title" name="title" required lay-verify="required" autocomplete="off" class="layui-input">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="layui-row layui-col-space15 layui-form-item">
                                                    <div class="layui-col-md12">
                                                        <div class="layui-inline">
                                                            <div class="layui-upload">
                                                                <button type="button" class="layui-btn layui-btn-normal" id="test8">选择轮播图片</button>
                                                                <button type="button" class="layui-btn" id="test9">开始上传</button>
                                                                <input type="hidden" id="L_img" name="img" value="">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item layui-form-text">
                                                    <div class="layui-input-block">
                                                        <textarea id="L_content" name="content"></textarea>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item">
                                                    <button  class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
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
        </div>
    </div>
</div>
</div>
</div>

<script src="${ pageContext.request.contextPath }/layui/layui.js"></script>
<script src="${ pageContext.request.contextPath }/tinymce_4.7.13/tinymce/js/tinymce/tinymce.min.js"></script>
<script src="${ pageContext.request.contextPath }/js/jquery.form.js"></script>
<script>
    tinymce.init({
        selector: '#L_content',
        language:'zh_CN',
        height: 400,
        theme: 'modern',
        convert_urls: false,
        menubar: false,
        plugins: 'fullpage searchreplace autolink directionality visualblocks visualchars fullscreen imageupload link template code codesample table charmap hr toc insertdatetime advlist paste emoticons lists textcolor wordcount imagetools contextmenu colorpicker textpattern help',
        toolbar1: 'undo redo paste searchreplace | formatselect | bold italic strikethrough forecolor backcolor charmap hr | table codesample link imageupload emoticons insertdatetime | alignleft aligncenter alignright alignjustify | numlist bullist outdent indent | visualblocks visualchars | removeformat | help',
        image_advtab: true,
        codesample_dialog_height:400,
        imageupload_url: '${ pageContext.request.contextPath }/uploadImg?addr=news',
    });
</script>
<script>
    //JavaScript代码区域
    layui.use(['element','form','upload'], function(){
        var element = layui.element;
        //选完文件后不自动上传
        var $ = layui.jquery
            ,upload = layui.upload;
        upload.render({
            elem: '#test8'
            ,url: '${ pageContext.request.contextPath }/uploadNewsImg'
            ,auto: false
            //,multiple: true
            ,bindAction: '#test9'
            ,done: function(res){
                //console.log(res);
                $("#L_img").attr("value",res.data.src);

            }
        });
    });

    // function submitNews(urlInfo,dataInfo) {
    //     //alert("start");
    //     //alert(urlInfo);
    //     //alert(dataInfo);
    //     $.post(urlInfo,dataInfo,
    //         function(data) {
    //             //alert(data);
    //             var reg = new RegExp("<body class=\"layui-layout-body\">(.|\s|\r|\n|\f)*</body>");
    //             var arr = data.match(reg);
    //             //alert(arr);
    //             document.body.innerHTML=arr;
    //             $.getScript("../js/jquery.min.js");
    //             $.getScript("../layui/layui.js");
    //         }
    //     );
    // }
</script>
</body>
</html>