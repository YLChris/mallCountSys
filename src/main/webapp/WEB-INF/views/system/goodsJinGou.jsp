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


<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-inline">
                    <form class="layui-form" id="roleSearchForm">
                        <div class="layui-input-inline" style="width:110px;">
                            <select name="searchTerm" >
                                <option value="productName">商品名称</option>
                                <option value="catagory">商品分类</option>
                            </select>
                        </div>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
                        </div>
                        <a class="layui-btn goodsSearchList_btn" lay-submit lay-filter="goodsSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                        <a class="layui-btn layui-btn-normal  goodAdd_btn"> <i class="layui-icon larry-icon larry-xinzeng1"></i>新增商品</a>
                    </form>
                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <div class="layui-tab-item  layui-show" style="padding: 10px 15px;">
                <table id="goodTableList" lay-filter="goodTableId"></table>
            </div>
        </div>
    </div>
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

        var loading = layer.load(0,{ shade: [0.3,'#000']});

        /**商品表格加载*/
        table.render({
            elem: '#goodTableList',
            url: '${ctx}/cProduct/ajax_goods_list.do',
            id:'goodTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title: '序号'},
                {field:'productId', title: '商品Id',align:'center',hide:true},
                {field:'productName', title: '商品名称',align:'center' },
                {field:'productPrice', title: '商品进购价格',align:'center'},
                {field:'productNum', title: '进购数量',align:'center'},
                {field:'productTotalPrice', title: '批次进购总价',align:'center'},
                {field:'jingouTime', title: '进购时间',align:'center'},
                {field:'catagory', title: '商品分类',align:'center',templet: '#titleTpl'},
                {field:'jingouOperator', title: '进购人',align:'center'},
                // {title: '操作', align:'center', width: '17%',toolbar: '#goodsBar'}
            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);
            }
        });
        /**商品新增*/
        $(".goodAdd_btn").click(function(){
            var url = "${ctx}/cProduct/goods_add.do";
            common.cmsLayOpen('新增商品',url,'550px','340px');
        });
        /**查询*/
        $(".goodsSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(goodsSearchFilter)', function (data) {
                table.reload('goodTableId',{
                    where: {
                        searchTerm:data.field.searchTerm,
                        searchContent:data.field.searchContent
                    },
                    height: 'full-140',
                    page: true,
                    done: function (res, curr, count) {
                        common.resizeGrid();
                        layer.close(loading);
                    }
                });
            });

        });
        
        
        /**监听工具条*/
        table.on('tool(goodTableId)', function(obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //修改商品
            if(layEvent === 'good_edit') {
                var productId = data.productId;
                var url = "${ctx}/cProduct/goods_update.do?productId="+productId;
                common.cmsLayOpen('编辑商品',url,'550px','340px');

                //商品授权
            }else if(layEvent === 'role_grant'){

                var roleId = data.roleId;
                var roleStatus = data.roleStatus;
                if(roleStatus == 1){
                    common.cmsLayErrorMsg("当前商品已失效,不能授权");
                    return false;
                }
                var url =  "${ctx}/role/role_grant.do?roleId="+roleId;
                common.cmsLayOpen('商品授权',url,'255px','520px');


                //商品失效
            }else if(layEvent === 'role_fail') {
                var roleId = data.roleId;
                var roleStatus = data.roleStatus;
                if(roleStatus == 1){
                    common.cmsLayErrorMsg("当前商品已失效");
                    return false;
                }

                var url = "${ctx}/role/ajax_role_fail.do";
                var param = {roleId:roleId};
                common.ajaxCmsConfirm('系统提示', '失效商品、解除商品、用户、菜单绑定关系?',url,param);

            }
        });
    });


</script>

<script type="text/html" id="titleTpl">
    {{#  if(d.catagory == 1){ }}
    <span>水果</span>
    {{#  }else if(d.catagory == 2){ }}
    <span>衣服</span>
    {{#  }else if(d.catagory == 3){ }}
    <span>食品</span>
    {{#  }else if(d.catagory == 4){ }}
    <span>蔬菜</span>
    {{#  } }}
</script>

<!--工具条 -->
<%--<script type="text/html" id="goodsBar">
    <div class="layui-btn-group">
        <a class="layui-btn layui-btn-xs good_edit" lay-event="good_edit"><i class="layui-icon larry-icon larry-bianji2"></i> 编辑</a>
    </div>
</script>--%>


</body>
</html>