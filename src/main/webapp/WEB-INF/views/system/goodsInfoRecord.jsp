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
                            </select>
                        </div>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
                        </div>
                        <a class="layui-btn goodsConditionSearchList_btn" lay-submit lay-filter="goodsConditionSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                    </form>
                </div>
                <div class="layui-inline">
                    <a class="layui-btn layui-btn-normal excelUserExport_btn"  style="background-color:#5FB878"> <i class="layui-icon larry-icon larry-danye"></i>导出</a>
                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <div class="layui-tab-item  layui-show" style="padding: 10px 15px;">
                <table id="goodRecordTableList" lay-filter="goodRecordTableId"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var productFlag;
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
            elem: '#goodRecordTableList',
            url: '${ctx}/cProduct/goodsRecordInfo.do',
            id:'goodRecordTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"numbers",title: '序号'},
                {field:'productName', title: '商品名称',align:'center' },
                {field:'xiaoshouLiang', title: '单批次销量',align:'center' },
                {field:'xiaoshouPrice', title: '商品售价',align:'center' },
                {field:'xiaoshouTotalPrice', title: '单批次总收益',align:'center' },
                {field:'xiaoshouYear', title: '年份',align:'center'},
                {field:'xiaoshouMonth', title: '月份',align:'center'},
                {field:'xiaoshouDay', title: '日期',align:'center'},
                {field:'operator', title: '收费员',align:'center'}
            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);
            }
        });

        /**查询*/
        $(".goodsConditionSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(goodsConditionSearchFilter)', function (data) {
                table.reload('goodRecordTableId',{
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

        /**导出员工信息*/
        $(".excelUserExport_btn").click(function(){
            var url = '${ctx}/cProduct/excel_sellProudctReport_export.do';
            $("#roleSearchForm").attr("action",url);
            $("#roleSearchForm ").submit();
        });

        /**监听工具条*/
        table.on('tool(goodRecordTableId)', function(obj) {
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //修改商品
            if(layEvent === 'good_edit') {
                var productId = data.productId;
                var url = "${ctx}/cProduct/goodsChuShou_edit.do?productId="+productId;
                layui.layer.open({
                    title : '<i class="larry-icon larry-bianji3"></i>'+'编辑商品',
                    type : 2,
                    skin : 'layui-layer-molv',
                    content : url,
                    area: ['550px', '340px'],
                    resize:true,
                    anim:1,
                    success : function(layero, index){
                        var body = layer.getChildFrame('body', index);
                        var iframeWin = layero.find('iframe')[0].contentWindow;//新iframe窗口的对象
                        body.find("#productName").val(data.productName);
                        body.find("#productDesc").val(data.productDesc);
                        body.find("#xiaoPrice").val(data.xiaoPrice);
                        body.find("#productSeq").val(data.productSeq);
                        productFlag = data.productStatus;
                        switch (data.catagory) {
                            case "1":
                                body.find("#catagory").val("水果");
                                break;
                            case "2":
                                body.find("#catagory").val("衣服");
                                break;
                            case "3":
                                body.find("#catagory").val("食品");
                                break;
                            case "4":
                                body.find("#catagory").val("蔬菜");
                                break;
                        }
                        form.render();
                        if(productFlag == 1){
                            body.find("#up").attr("checked",true);
                            iframeWin.layui.form.render();
                        }else if(productFlag == 0){
                            body.find("#down").attr("checked",true);
                            iframeWin.layui.form.render();
                        }
                    }
                });
                //商品授权
            }else if(layEvent === 'goodXiajia'){

                var roleId = data.roleId;
                var roleStatus = data.roleStatus;
                if(roleStatus == 1){
                    common.cmsLayErrorMsg("当前商品已失效,不能授权");
                    return false;
                }
                var url =  "${ctx}/role/role_grant.do?roleId="+roleId;
                common.cmsLayOpen('商品授权',url,'255px','520px');
            }
        });
    });


</script>
<!--工具条 -->
<script type="text/html" id="goodBar">
    <div class="layui-btn-group">
        <a class="layui-btn layui-btn-xs" lay-event="good_edit"><i class="layui-icon larry-icon larry-bianji2"></i> 商品信息修改</a>
        <%--<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="goodXiajia"><i class="layui-icon larry-icon larry-bianji2"></i> 商品下架</a>--%>
    </div>
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
<script type="text/html" id="proFlag">
    {{#  if(d.productStatus == 0){ }}
    <span  style="color:red;">未上架</span>
    {{#  }else if(d.productStatus == 1){ }}
    <span  style="color:green;">已上架</span>
    {{#  } }}
</script>


</body>
</html>