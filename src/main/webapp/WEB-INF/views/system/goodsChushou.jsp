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
    var $,common,productTotalNumArr = new Array(),productPriceArr = new Array();
    layui.config({
        base : "${ctx}/static/js/"
    }).extend({
        formSelects: 'formSelects-v4'
    }).use(['form', 'table', 'layer','common','formSelects'], function () {
        $ =  layui.$,common = layui.common;
        var  form = layui.form,
            table = layui.table,
            layer = layui.layer,
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
            productTotalNumArr = [];
            productPriceArr = [];
            for(index in productValArr){//循环组装商品
                var productItemObject = productValArr[index].split("-");
                productHtml="<div><label class='layui-form-label productName layui-elip'>"+productItemObject[0]+"</label>" +
                    "<input type='number' class='layui-input productItem goodName"+productItemObject[0]+index+"' " +
                    "name='productTotalNum"+productItemObject[2]+"' value='1' placeholder='请输入购买数量' required  " +
                    "lay-verify='required' autocomplete='off' onblur='changeProiceValue(this.value,"+productItemObject[1]+","+productItemObject[2]+");'/>" +
                    "<input type='number' name='productPrice"+productItemObject[2]+"' placeholder='价格' required  " +
                    "lay-verify='required' autocomplete='off' class='layui-input productPrice' " +
                    "value='"+productItemObject[1]+"' disabled/></div>"
                $(".productItemList").append(productHtml);
                productTotalNumArr.push("productTotalNum"+productItemObject[2]);
                productPriceArr.push("productPrice"+productItemObject[2]);
            }
            $(".productItemList").append("<a class='layui-btn' style='margin-left: 45%;margin-top:10px;' onclick='mkChushou()'>确定出售</a>");
        });


    });
    //更改价格
    function changeProiceValue(thisItem,price,productSeq){
        if(!new RegExp("^\\d*[1-9]\\d*$").test(thisItem)|| null==thisItem || ""==thisItem){
            common.cmsLayErrorMsg('出售数量只能正整数');
            $("input[name=productPrice"+productSeq+"]").val(price);
            return false;
        }
        var totalPrice = thisItem*price;
        $("input[name=productPrice"+productSeq+"]").val(totalPrice);
    }
    //确认出售
    function mkChushou(){
        var productInfoArr = "";//最后组装的商品信息
        var productTotalNumArr1 = this.productTotalNumArr;//进购数量
        var productPriceArr1 = this.productPriceArr;//进购总价格
        for(productTotalNumIndex in productTotalNumArr1){
            var productTotalNumItem = productTotalNumArr1[productTotalNumIndex];//进购数量name属性
            for(productPriceIndex in productPriceArr1){
                var productPriceItem = productPriceArr1[productPriceIndex];//进购价格name属性
                var productSeq;
                //两者商品序号一致  组装信息
                if(productTotalNumItem.substring(productTotalNumItem.length-6)==productPriceItem.substring(productPriceItem.length-6)){
                    productSeq = productTotalNumItem.substring(productTotalNumItem.length-6);//商品序号
                    var num = $("input[name="+productTotalNumItem+"]").val();//进购商品数量
                    if(!new RegExp("^\\d*[1-9]\\d*$").test(num)|| null==num || ""==num){
                        common.cmsLayErrorMsg('出售数量只能为正整数');
                        return false;
                    }
                    var itemProduct = productSeq+","+num+","+$("input[name="+productPriceItem+"]").val()+"&";
                    productInfoArr=productInfoArr+itemProduct;
                }
            }
        }

        //数据访问后台
        if(productInfoArr){
            var param = {productInfoArr:productInfoArr};
            $.ajax({
                url : '${ctx}/cProduct/Chushou.do',
                type : 'post',
                async: false,
                data : param,
                success : function(data) {
                    if(data.returnCode == 0000){
                        top.layer.msg("出售成功");
                        location.reload();
                    }else{
                        top.layer.msg(data.returnMessage,{icon: 5});
                    }
                },error:function(data){

                }
            });
        }
    }

</script>
</body>
</html>