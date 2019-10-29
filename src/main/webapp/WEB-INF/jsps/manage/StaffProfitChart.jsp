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
	var data='${datas}';
	var sid='${stid}';
	sid=sid+"";
	data=data+"";
	console.log(data);
	var data2=[];
	data0=data.split("|");
	for (var i in data0){
		data1=data0[i].split("*");
		data2.push([Date.UTC(data1[0],data1[1],data1[2]),parseFloat(data1[3])]);
	}
	//var data3=[];
	//data3.push(data2);
	//console.log(data3);
    $('#container').highcharts({
        chart: {
            type: 'spline'
        },
        title: {
            text:sid +' Profit Chart'
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%e. %b',
                year: '%b'
            },
            title: {
                text: 'Date'
            }
        },
        yAxis: {
            title: {
                text: 'Profit (元)'
            },
            min: 0
        },
        tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x:%e. %b}: {point.y:.2f} 元'
        },

        plotOptions: {
            spline: {
                marker: {
                    enabled: true
                }
            }
        },

        series: [{
            name: '#'+ sid,
            // Define the data points. All series have a dummy year
            // of 1970/71 in order to be compared on the same x axis. Note
            // that in JavaScript, months start at 0 for January, 1 for February etc.
            data: data2
        }]
    });
});
		</script>
	</head>
	<body>


<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>

	</body>
</html>
