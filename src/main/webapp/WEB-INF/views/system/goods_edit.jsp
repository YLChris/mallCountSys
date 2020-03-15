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


    <script src="${ctx}/static/layui_v2/layui.js"></script>

</head>
<body class="childrenBody" style="font-size: 12px;margin: 10px 10px 0;">
<div class="main">
    <!--商品进购-->
    <form class="layui-form" action="">
        <input id="pageFlag"  type="hidden" value="${pageFlag}"/>
        <input id="catagoryHide" type="hidden" style="display: none;" value="${cProduct.catagory}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">商品名称</label>
            <div class="layui-input-block">
                <input type="text" name="productName" required  lay-verify="required" value="${cProduct.productName}" placeholder="请输入商品名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品分类</label>
            <div class="layui-input-block">
                <select name="catagory" lay-verify="required" id="catagory">
                    <option value="">请选择商品分类</option>
                    <option value="1">水果</option>
                    <option value="2">衣服</option>
                    <option value="3">食品</option>
                    <option value="4">蔬菜</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品价格</label>
            <div class="layui-input-block">
                <input type="number" name="productPrice" required  value="${cProduct.productPrice}" lay-verify="required|productPrice" placeholder="请输入商品价格" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">进购数量</label>
            <div class="layui-input-block">
                <input type="number" name="productNum" required  lay-verify="required|productNum" placeholder="请输入进购数量" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="saveGoods">保存</button>
                <button type="layui-btn" id="cancle" class="layui-btn layui-btn-primary">取消</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form','layer','jquery','common'],function(){
        var $ = layui.$,
                form = layui.form,
                common = layui.common,
                layer = parent.layer === undefined ? layui.layer : parent.layer;

        /**表单验证*/
        form.verify({
            productPrice: function(value,item){
                if(!new RegExp("^[0-9]+$").test(value)){
                    return '进购价格只能为数字';
                }
            },
            productNum:function(value,item){
                if(!new RegExp("^[0-9]+$").test(value)){
                    return '进购数量只能为数字';
                }else if(value==0){
                    return '进购数量不能为零';
                }
            }
        });
        //分类回显
        $("#catagory").each(function() {
            // this代表的是<option></option>，对option再进行遍历
            $(this).children("option").each(function() {
                // 判断需要对那个选项进行回显
                if (this.value == $("#catagoryHide").val()) {
                    $(this).attr("selected","selected");
                }
            });
        })
        form.render();
        //保存
        form.on("submit(saveGoods)",function(data){
            var roleSaveLoading = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                url : '${ctx}/cProduct/ajax_save_goods.do',
                type : 'post',
                async: false,
                data : data.field,
                success : function(data) {
                    if(data.returnCode == 0000){
                        top.layer.close(roleSaveLoading);
                        common.cmsLaySucMsg("商品信息保存成功！");
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index); //再执行关闭                        //刷新父页面
                        parent.location.reload();
                    }else{
                        top.layer.close(roleSaveLoading);
                        common.cmsLayErrorMsg(data.returnMessage);
                    }
                },error:function(data){
                    top.layer.close(index);

                }
            });
            return false;
        });

        //取消
        $("#cancle").click(function(){
            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
            parent.layer.close(index); //再执行关闭
        });

    });

</script>
</body>
</html>