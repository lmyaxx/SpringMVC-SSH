<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

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
    <script src="${ pageContext.request.contextPath }/insdep/plugin/Highcharts-5.0.0/js/highcharts.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/js/loading.js"></script>
		<script type="text/javascript">
$(function () {
	var datax0='${datax}';
	var datay0='${datay}';
	datax0=datax0+"";
	datay0=datay0+"";
	console.log(datax0);
	console.log(datay0);
	var datax=[];
	var datay=[];
	datax=datax0.split("*");
	datay1=datay0.split("*");
	console.log(datay1);
	for (var i in datay1){
		console.log(i);
		datay.push(parseFloat(datay1[i]));
	}
	//var data3=[];
	//data3.push(data2);
	//console.log(data3);
    $('#container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text:'Profit Compare Chart'
        },
        xAxis: {
            categories: datax,
            title: {
                text: null
            }
        },
        yAxis: {
            title: {
                text: 'Profit (元)'
            },
            min: 0
        },
        tooltip: {
           valueSuffix: ' 元'
        },

        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 80,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        },

        series:[{
            name: 'Compare',
            data: datay
        }]
    });
});
		</script>
	</head>
	<body>


<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

	</body>
</html>
