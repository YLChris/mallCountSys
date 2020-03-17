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
    <link rel="stylesheet" href="${ctx}/static/css/formSelects-v4.css">
    <script src="${ctx}/static/layui_v2/layui.js"></script>
    <style>
        .productsClassItem{position: absolute;width: 50%;margin-left: 10%;}
        .productsClassBtn{position: relative;margin-left: 62%;}
        .productItem{width: 551px;display: inline-block;}
        .productName{padding: 9px 8px;width: 200px;}
        .productItemList{padding: 20px 15px;border-top: 1px solid darkgray;margin-top: 20px;}
        .productPrice{width: 100px;display: inline-block;}
    </style>
<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                商品出售
            </blockquote>
            <div class="larry-separate"></div>
            <!--商品出售-->
            <form class="layui-form" action="">
                <div class="layui-form-item productsClassItem">
                    <select class="productsClass" name="productsList" xm-select="GoodsChuShouSelect" xm-select-height="36px" xm-select-show-count="3">
                        <option value="">请选择商品</option>
                    </select>
                </div>
                <a class="layui-btn productsClassBtn" href="javascript:void(0);" id="productsChushou">出售</a>
            </form>
            <div class="productItemList"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).extend({
        formSelects: 'formSelects-v4'
    }).use(['form', 'table', 'layer','common','formSelects'], function () {
        var $ =  layui.$,
            form = layui.form,
            table = layui.table,
            layer = layui.layer,
            common = layui.common,
            formSelects = layui.formSelects;
        var productHtml;//存储商品
        layui.formSelects.config('GoodsChuShouSelect', {
            beforeSuccess: function(id, url, searchVal, result){
                result = result.data;
                $.each(result, function(index, item) {
                    item.name
                    item.value
                });
                return result;
            }
        }).data('GoodsChuShouSelect', 'server', {
            url: '${ctx}/cProduct/getGoods.do'
        });


        //显现商品详情
        $("#productsChushou").click(function(){
            $(".productItemList").empty();
            var productValArr = layui.formSelects.value('GoodsChuShouSelect', 'val');//取值val数组
            productHtml = "";
            for(index in productValArr){//循环组装商品
                var productItemObject = productValArr[index].split("-");
                var object= "'"+productItemObject[0]+index+"'";
                productHtml="<div><label class='layui-form-label productName layui-elip'>"+productItemObject[0]+"</label>" +
                    "<input type='number' class='layui-input productItem goodName"+productItemObject[0]+index+"' " +
                    "name='"+productItemObject[0]+index+"' value='1' placeholder='请输入购买数量' required  " +
                    "lay-verify='required' autocomplete='off' oninput='changeProiceValue(this.value,"+productItemObject[1]+","+object+");'/>" +
                    "<input type='number' name='goodPrice"+productItemObject[0]+index+"' placeholder='价格' required  " +
                    "lay-verify='required' autocomplete='off' class='layui-input productPrice' " +
                    "value='"+productItemObject[1]+"' disabled/></div>"
                $(".productItemList").append(productHtml);
            }
            $(".productItemList").append("<a class='layui-btn' href='javascript:void(0);' style='margin-left: 45%;margin-top:10px;'>确定出售</a>");
        });

    });
    //更改价格
    function changeProiceValue(thisItem,price,priceName){
        console.log(thisItem+"---"+price+"---"+priceName)
    }


</script>
</body>
</html>