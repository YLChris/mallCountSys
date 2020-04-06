<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/comm/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>商场销售统计系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="商场销售统计系统">
    <meta name="description" content="致力于提供通用版本后台管理解决方案">
    <link rel="shortcut icon" href="${ctx}/static/img/favicon.ico">

    <link rel="stylesheet" href="${ctx}/static/layui_v2/css/layui.css">
    <link rel="stylesheet" href="${ctx}/static/css/global.css">

    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/personal.css" media="all">
    <link rel="stylesheet" type="text/css" href="http://at.alicdn.com/t/font_9h680jcse4620529.css">
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <script src="${ctx}/static/echarts/echarts.min.js"></script>

<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A">
    <div id="main" style="width: 100%;height:500px;margin-bottom: 10px;"></div>
    <div id="main2" style="width: 100%;height:500px;margin-bottom: 10px;"></div>
    <div id="main3" style="width: 100%;height:500px;margin-bottom: 10px;"></div>
</div>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common'], function () {
        var $ =  layui.$,
            form = layui.form,
            table = layui.table,
            layer = layui.layer,
            common = layui.common;

        // ========================111=======================

        var myChart = echarts.init(document.getElementById('main'));
        // 显示标题，图例和空的坐标轴
        myChart.setOption({
            title: {
                text: '商品利润柱状图'
            },
            tooltip: {},
            legend: {
                data:['商品']
            },
            xAxis: {
                data: []
            },
            yAxis: {},
            series: [{
                name: '利润',
                type: 'bar',
                data: []
            }]
        });

        // 异步加载数据
        $.get('${ctx}/cProduct/liRundata.do').done(function (data) {
            data = JSON.parse(data);
            // 填入数据
            myChart.setOption({
                xAxis: {
                    data: data.productNameData
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '利润',
                    data: data.liRunData
                }]
            });
        });


        // ========================222=======================

        var myChart2 = echarts.init(document.getElementById('main2'));
        // 显示标题，图例和空的坐标轴
        myChart2.setOption({
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 10,
                data: []
            },
            xAxis: {},
            yAxis: {},
            series: [{
                type: 'pie',
                radius: ['50%', '70%'],
                avoidLabelOverlap: false,
                label: {
                    show: false,
                    position: 'center'
                },
                emphasis: {
                    label: {
                        show: true,
                        fontSize: '30',
                        fontWeight: 'bold'
                    }
                },
                labelLine: {
                    show: false
                },
                name: '利润',
                data: []
            }]
        });

        // 异步加载数据
        $.get('${ctx}/cProduct/liRundata.do').done(function (data) {
            data = JSON.parse(data);
            // 填入数据
            myChart2.setOption({
                xAxis: {
                    data: data.productNameData
                },
                legend: {
                    data: data.productNameData
                },
                series: [{
                    data: data.nameValue
                }]
            });
        });


        // ========================333=======================

        var myChart3 = echarts.init(document.getElementById('main3'));
        // 显示标题，图例和空的坐标轴
        myChart3.setOption({
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    label: {
                        backgroundColor: '#6a7985'
                    }
                }
            },
            legend: {
                data: ['邮件营销', '联盟广告', '视频广告', '直接访问', '搜索引擎']
            },
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '邮件营销',
                    type: 'line',
                    data: [120, 132, 101, 134, 90, 230, 210]
                },
                {
                    name: '联盟广告',
                    type: 'line',
                    data: [220, 182, 191, 234, 290, 330, 310]
                },
                {
                    name: '视频广告',
                    type: 'line',
                    data: [150, 232, 201, 154, 190, 330, 410]
                },
                {
                    name: '直接访问',
                    type: 'line',
                    data: [320, 332, 301, 334, 390, 330, 320]
                },
                {
                    name: '搜索引擎',
                    type: 'line',
                    data: [820, 932, 901, 934, 1290, 1330, 1320]
                }
            ]
        });

        // 异步加载数据
        $.get('${ctx}/cProduct/liRundata.do').done(function (data) {
            data = JSON.parse(data);
            // 填入数据
            myChart2.setOption({
                xAxis: {
                    data: data.productNameData
                },
                legend: {
                    data: data.productNameData
                },
                series: [{
                    data: data.nameValue
                }]
            });
        });
    });
</script>


</body>
</html>