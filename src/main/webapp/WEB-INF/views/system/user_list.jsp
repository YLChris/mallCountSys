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


<body>
<div class="larry-grid layui-anim layui-anim-upbit larryTheme-A ">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-inline">
                    <form class="layui-form" id="userSearchForm">
                        <div class="layui-input-inline" style="width:110px;">
                            <select name="searchTerm" >
                                <option value="userLoginNameTerm">登陆账号</option>
                                <option value="userNameTerm">员工姓名</option>
                            </select>
                        </div>
                        <div class="layui-input-inline" style="width:145px;">
                            <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
                        </div>
                        <a class="layui-btn userSearchList_btn" lay-submit lay-filter="userSearchFilter"><i class="layui-icon larry-icon larry-chaxun7"></i>查询</a>
                    </form>
                </div>
                <shiro:hasPermission name="0rbT8t2P">
                    <div class="layui-inline">
                        <a class="layui-btn layui-btn-normal userAdd_btn"> <i class="layui-icon larry-icon larry-xinzeng1"></i>新增员工</a>
                    </div>
                </shiro:hasPermission>
                <shiro:hasPermission name="0jOfTHGx">
                    <div class="layui-inline">
                        <a class="layui-btn layui-btn-normal excelUserExport_btn"  style="background-color:#5FB878"> <i class="layui-icon larry-icon larry-danye"></i>导出</a>
                    </div>
                </shiro:hasPermission>
                <shiro:hasPermission name="lBE3hz5c">
                    <div class="layui-inline">
                        <a class="layui-btn layui-btn-danger userBatchFail_btn"><i class="layui-icon larry-icon larry-shanchu"></i>批量失效</a>
                    </div>
                </shiro:hasPermission>

            </blockquote>
            <div class="larry-separate"></div>
            <!-- 员工列表 -->
            <div class="layui-tab-item layui-show " style="padding: 10px 15px;">
                <table id="userTableList"  lay-filter="userTableId" ></table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var $;
    layui.config({
        base : "${ctx}/static/js/"
    }).use(['form', 'table', 'layer','common'], function () {
         $ =  layui.$;
                var form = layui.form,
                table = layui.table,
                layer = layui.layer,
                common = layui.common;

        var loading = layer.load(0,{ shade: [0.3,'#000']});
        /**员工表格加载*/
        table.render({
            elem: '#userTableList',
            url: '${ctx}/user/ajax_user_list.do',
            id:'userTableId',
            method: 'post',
            height:'full-140',
            skin:'row',
            even:'true',
            size: 'sm',
            cols: [[
                {type:"checkbox"},
                {field:'userLoginName', title: '登陆账号',align:'center' },
                {field:'userName', title: '员工姓名',align:'center'},
                {field:'userStatus', title: '员工状态',align:'center',width: '8%',templet: '#userStatusTpl'},
                {field:'roleNames', title: '拥有角色',align:'center'},
                {field:'salary', title: '薪水',align:'center'},
                {field:'creator', title: '创建人',align:'center'},
                {field:'createTime', title: '创建时间',align:'center',width: '12%'},
                {field:'modifier', title: '修改人',align:'center'},
                {field:'updateTime', title: '修改时间',align:'center',width: '12%'},
                {title: '操作', align:'center', width: '17%',toolbar: '#userBar'}
            ]],
            page: true,
            done: function (res, curr, count) {
                common.resizeGrid();
                layer.close(loading);

            }
        });

        /**查询*/
        $(".userSearchList_btn").click(function(){
            var loading = layer.load(0,{ shade: [0.3,'#000']});
            //监听提交
            form.on('submit(userSearchFilter)', function (data) {
                table.reload('userTableId',{
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

        /**新增员工*/
        $(".userAdd_btn").click(function(){
            var url = "${ctx}/user/user_add.do";
            common.cmsLayOpen('新增员工',url,'550px','265px');
        });

        /**导出员工信息*/
        $(".excelUserExport_btn").click(function(){
            var url = '${ctx}/user/excel_users_export.do';
            $("#userSearchForm").attr("action",url);
            $("#userSearchForm").submit();
        });
        /**批量失效*/
        $(".userBatchFail_btn").click(function(){

            //表格行操作
            var checkStatus = table.checkStatus('userTableId');
            if(checkStatus.data.length == 0){
                common.cmsLayErrorMsg("请选择要失效的员工信息");
            }else{
                var isCreateBy = false;
                var userStatus = false;
                var currentUserName = '${LOGIN_NAME.userId}';
                var userIds = [];

                $(checkStatus.data).each(function(index,item){
                    userIds.push(item.userId);
                    //不能失效当前登录员工
                    if(currentUserName != item.userId){
                        isCreateBy = true;
                    }else{
                        isCreateBy = false;
                        return false;
                    }
                    //员工已失效
                    if(item.userStatus == 0){
                        userStatus = true;
                    }else{
                        userStatus = false;
                        return false;
                    }

                });

                if(isCreateBy==false){
                    common.cmsLayErrorMsg("当前登录员工不能被失效,请重新选择");

                    return false;
                }
                if(userStatus==false){
                    common.cmsLayErrorMsg("当前选择的员工已离职");
                    return false;
                }

                var url = "${ctx}/user/ajax_user_batch_fail.do";
                var param = {userIds:userIds};
                common.ajaxCmsConfirm('系统提示', '确定解雇当前员工，并解除与角色绑定关系吗?',url,param);

            }

        });

        /**监听工具条*/
        table.on('tool(userTableId)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值

            //修改员工
            if(layEvent === 'user_edit') {
                var userId = data.userId;
                var url =  "${ctx}/user/user_update.do?userId="+userId;
                common.cmsLayOpen('编辑员工',url,'550px','265px');

            //分配角色
            }else if(layEvent === 'user_grant'){
                var userId = data.userId;
                var userStatus = data.userStatus;
                if(userStatus == 1){
                    common.cmsLayErrorMsg("当前员工已离职,不能被分配角色");
                    return false;
                }
                var url =  "${ctx}/user/user_grant.do?userId="+userId;
                common.cmsLayOpen('分配角色',url,'500px','440px');

            //员工离职
            }else if(layEvent === 'user_fail') {
                var userId = data.userId;
                var userStatus = data.userStatus;
                var currentUserId = '${LOGIN_NAME.userId}';/*当前登录员工的ID*/
                if(userStatus == 1){
                    common.cmsLayErrorMsg("当前员工已离职");
                    return false;
                }
                if(userId == currentUserId){
                    common.cmsLayErrorMsg("当前登陆员工不能被离职");
                    return false;
                }

                var url = "${ctx}/user/ajax_user_fail.do";
                var param = {userId:userId};
                common.ajaxCmsConfirm('系统提示', '确定解雇员工，并解除与角色绑定关系吗?',url,param);

            }
        });


    });
</script>
<!-- 员工状态tpl-->
<script type="text/html" id="userStatusTpl">

    {{# if(d.userStatus == 0){ }}
    <span style="color:#5FB878;font-weight:bold"> 0-在职</span>
    {{# } else if(d.userStatus == 1){ }}
    <span style="color:#FF5722;font-weight:bold"> 1-离职</span>

    {{# } else { }}
    {{d.userStatus}}
    {{# }  }}
</script>


<!--工具条 -->
<script type="text/html" id="userBar">
    <div class="layui-btn-group">
        <shiro:hasPermission name="fSv1B2kZ">
            <a class="layui-btn layui-btn-xs user_edit" lay-event="user_edit"><i class="layui-icon larry-icon larry-bianji2"></i> 编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="mScICO9G">
            <a class="layui-btn layui-btn-xs layui-btn-warm  user_grant" lay-event="user_grant"><i class="layui-icon larry-icon larry-jiaoseguanli3"></i>角色</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="uBg9TdEr">
            <a class="layui-btn layui-btn-xs layui-btn-danger user_fail" lay-event="user_fail"><i class="layui-icon larry-icon larry-ttpodicon"></i>解雇</a>
        </shiro:hasPermission>
    </div>
</script>



</body>
</html>