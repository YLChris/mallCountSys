/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : contentmanagersystem_db

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2020-04-06 15:29:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cc_announcement_info
-- ----------------------------
DROP TABLE IF EXISTS `cc_announcement_info`;
CREATE TABLE `cc_announcement_info` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_type` int(11) DEFAULT NULL COMMENT '公告类型',
  `announcement_title` varchar(50) DEFAULT NULL COMMENT '公告标题',
  `announcement_content` varchar(500) DEFAULT NULL COMMENT '公告内容',
  `announcement_author` varchar(50) DEFAULT NULL COMMENT '发布者',
  `announcement_time` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`announcement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cc_announcement_info
-- ----------------------------
INSERT INTO `cc_announcement_info` VALUES ('1', '1', '注意了注意了  公告已发布', '<p>注意了注意了&nbsp; 公告已发布&nbsp; 注意了注意了&nbsp; 公告已发布</p>', 'admin', '2020-03-12 16:47:18');

-- ----------------------------
-- Table structure for cc_announcement_info_user
-- ----------------------------
DROP TABLE IF EXISTS `cc_announcement_info_user`;
CREATE TABLE `cc_announcement_info_user` (
  `announcement_info_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_id` int(11) DEFAULT NULL COMMENT '公告Id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户Id',
  `announcement_flag` int(11) DEFAULT NULL COMMENT '是否已读',
  PRIMARY KEY (`announcement_info_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cc_announcement_info_user
-- ----------------------------
INSERT INTO `cc_announcement_info_user` VALUES ('1', '1', '9', null);

-- ----------------------------
-- Table structure for cc_data_cleaning
-- ----------------------------
DROP TABLE IF EXISTS `cc_data_cleaning`;
CREATE TABLE `cc_data_cleaning` (
  `data_id` int(11) NOT NULL AUTO_INCREMENT,
  `data_type` int(11) DEFAULT NULL COMMENT '数据类型',
  `data_time` varchar(50) DEFAULT NULL COMMENT '数据时间',
  `data_count` int(11) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`data_id`),
  UNIQUE KEY `unique_data_type_time` (`data_type`,`data_time`) COMMENT '数据类型、日期唯一建索引'
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cc_data_cleaning
-- ----------------------------
INSERT INTO `cc_data_cleaning` VALUES ('1', '1', '2020-03-12', '1');
INSERT INTO `cc_data_cleaning` VALUES ('3', '1', '2020-03-14', '0');
INSERT INTO `cc_data_cleaning` VALUES ('4', '1', '2020-03-15', '1');
INSERT INTO `cc_data_cleaning` VALUES ('9', '1', '2020-03-16', '0');
INSERT INTO `cc_data_cleaning` VALUES ('10', '1', '2020-03-17', '0');
INSERT INTO `cc_data_cleaning` VALUES ('11', '1', '2020-03-18', '1');
INSERT INTO `cc_data_cleaning` VALUES ('15', '1', '2020-03-19', '0');
INSERT INTO `cc_data_cleaning` VALUES ('16', '1', '2020-03-20', '0');
INSERT INTO `cc_data_cleaning` VALUES ('17', '1', '2020-03-21', '0');
INSERT INTO `cc_data_cleaning` VALUES ('18', '1', '2020-03-22', '1');
INSERT INTO `cc_data_cleaning` VALUES ('19', '1', '2020-03-23', '0');
INSERT INTO `cc_data_cleaning` VALUES ('20', '1', '2020-03-24', '0');
INSERT INTO `cc_data_cleaning` VALUES ('21', '1', '2020-03-25', '0');
INSERT INTO `cc_data_cleaning` VALUES ('22', '1', '2020-03-26', '0');
INSERT INTO `cc_data_cleaning` VALUES ('23', '1', '2020-03-27', '0');
INSERT INTO `cc_data_cleaning` VALUES ('24', '1', '2020-03-28', '1');
INSERT INTO `cc_data_cleaning` VALUES ('26', '1', '2020-03-29', '1');

-- ----------------------------
-- Table structure for cc_resource
-- ----------------------------
DROP TABLE IF EXISTS `cc_resource`;
CREATE TABLE `cc_resource` (
  `res_id` int(11) NOT NULL AUTO_INCREMENT,
  `res_parentId` int(11) DEFAULT NULL,
  `res_name` varchar(50) NOT NULL,
  `res_status` int(11) DEFAULT NULL,
  `res_model_code` varchar(30) DEFAULT NULL COMMENT '模块标识',
  `res_link_address` varchar(200) DEFAULT NULL,
  `res_image` varchar(100) DEFAULT NULL,
  `res_level` int(11) DEFAULT NULL,
  `res_type` int(11) DEFAULT NULL,
  `res_display_order` int(11) DEFAULT NULL,
  `res_remark` varchar(200) DEFAULT NULL,
  `creator` varchar(40) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modifier` varchar(40) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of cc_resource
-- ----------------------------
INSERT INTO `cc_resource` VALUES ('2', '5', '员工管理', '0', '7JMoS6yG', '/user/user_list.do', 'larry-10103', '3', '0', '11', '', 'admin', '2020-03-12 16:57:22', 'admin', '2017-08-15 11:27:40');
INSERT INTO `cc_resource` VALUES ('3', '5', '角色管理', '0', 'SPAn6H46', '/role/role_list.do', 'larry-jiaoseguanli1', '3', '0', '3', '配置系统角色信息', 'admin', '2020-03-12 16:57:25', null, null);
INSERT INTO `cc_resource` VALUES ('4', '5', '菜单管理', '0', '0rbT8g7m', '/res/res_list.do', 'larry-caidanguanli', '3', '0', '4', '', 'admin', '2020-03-12 16:57:31', 'admin', '2020-03-12 16:31:10');
INSERT INTO `cc_resource` VALUES ('5', '7', '系统设置', '0', '0rbT8g9m', null, 'larry-xitongshezhi1', '2', '0', '5', '配置系统菜单信息', 'admin', '2017-07-28 09:31:43', null, null);
INSERT INTO `cc_resource` VALUES ('7', null, '系统管理', '0', '0rbT8g8m', '', 'larry-xitongshezhi1', '1', '0', '4', '配置系统菜单信息', 'admin', '2017-07-28 13:24:57', 'admin', '2020-03-14 17:26:14');
INSERT INTO `cc_resource` VALUES ('9', '7', '消息中心', '0', '0rbT8g2m', '', 'larry-gerenxinxi5', '2', '0', '8', '配置系统菜单信息', 'admin', '2017-07-28 14:23:35', 'admin', '2017-08-28 19:50:48');
INSERT INTO `cc_resource` VALUES ('10', '9', '公告管理', '0', '0rbT8t2m', '/announcement/announcement_list.do', 'larry-gonggaoguanli', '3', '0', '9', '配置系统菜单信息', 'admin', '2017-07-28 17:07:55', 'admin', '2017-09-04 11:07:18');
INSERT INTO `cc_resource` VALUES ('12', '2', '用户新增', '0', '0rbT8t2P', '/user/user_add.do', 'larry-gerenxinxi1', '3', '1', '3', '', 'admin', '2017-08-14 16:47:12', 'admin', '2020-03-12 16:31:05');
INSERT INTO `cc_resource` VALUES ('15', '2', '用户导出', '0', '0jOfTHGx', '/user/excel_users_export.do', 'larry-10103', '3', '1', null, '', 'admin', '2017-08-16 23:29:50', null, null);
INSERT INTO `cc_resource` VALUES ('16', '2', '用户修改', '0', 'fSv1B2kZ', '/user/user_update.do', 'larry-bianji2', '3', '1', null, '', 'admin', '2017-08-16 23:30:21', 'admin', '2020-03-12 16:30:47');
INSERT INTO `cc_resource` VALUES ('17', '2', '用户失效', '0', 'uBg9TdEr', '/user/ajax_user_fail.do', 'larry-10103', '3', '1', null, '', 'admin', '2017-08-16 23:30:46', null, null);
INSERT INTO `cc_resource` VALUES ('18', '2', '批量失效', '0', 'lBE3hz5c', '/user/ajax_user_batch_fail.do', 'caidanguanli', '3', '1', null, '', 'admin', '2017-08-16 23:31:09', null, null);
INSERT INTO `cc_resource` VALUES ('19', '2', '分配角色', '0', 'mScICO9G', '/user/user_grant.do', 'jiaoseguanli1', '3', '1', null, '', 'admin', '2017-08-16 23:31:37', null, null);
INSERT INTO `cc_resource` VALUES ('20', '3', '角色导出', '0', 'oCNcsKmk', '/role/excel_role_export.do', 'jiaoseguanli1', '3', '1', null, '', 'admin', '2017-08-16 23:32:29', null, null);
INSERT INTO `cc_resource` VALUES ('21', '3', '角色新增', '0', 'nxRVZA5i', '/role/role_add.do', 'caidanguanli', '3', '1', null, '', 'admin', '2017-08-16 23:33:01', null, null);
INSERT INTO `cc_resource` VALUES ('22', '3', '角色修改', '0', 'moHbdnjz', '/role/role_update.do', 'liuyan', '3', '1', null, '', 'admin', '2017-08-16 23:33:26', null, null);
INSERT INTO `cc_resource` VALUES ('23', '3', '角色失效', '0', 'tkwJk34z', '/role/ajax_role_fail.do', 'caidanguanli', '3', '1', null, '', 'admin', '2017-08-16 23:33:46', null, null);
INSERT INTO `cc_resource` VALUES ('24', '3', '批量失效', '0', 'qsieHTy4', '/role/ajax_role_batch_fail.do', 'liuyan', '3', '1', null, '', 'admin', '2017-08-16 23:34:04', 'admin', '2020-03-12 16:30:51');
INSERT INTO `cc_resource` VALUES ('25', '3', '角色赋权', '0', 'bSG7LAmU', '/role/role_grant.do', 'caidanguanli', '3', '1', null, '', 'admin', '2017-08-16 23:34:28', null, null);
INSERT INTO `cc_resource` VALUES ('26', '4', '菜单新增', '0', 'Mhtly5er', '/res/res_edit.do', 'larry-11', '3', '1', null, '', 'admin', '2017-08-22 13:41:27', null, null);
INSERT INTO `cc_resource` VALUES ('27', '4', '菜单编辑', '0', 'KxCQVzRq', '/res/res_update.do', 'larry-bianji5', '3', '1', null, '', 'admin', '2017-08-22 13:42:30', null, null);
INSERT INTO `cc_resource` VALUES ('28', '4', '菜单失效', '0', 'DK3uPfe7', '/res/ajax_res_fail.do', 'larry-shanchu8', '3', '1', null, '', 'admin', '2017-08-22 13:45:01', null, null);
INSERT INTO `cc_resource` VALUES ('29', '4', '菜单导出', '0', 'wPUNDGgZ', '/res/excel_res_export.do', 'larry-wangzhanneirong', '3', '1', null, '', 'admin', '2017-08-22 13:46:43', null, null);
INSERT INTO `cc_resource` VALUES ('30', '11', '测试菜单3', '0', '3T7k24R4', '/test.do', 'larry-nav', '3', '0', null, '', 'user_system', '2017-08-22 14:43:00', null, null);
INSERT INTO `cc_resource` VALUES ('51', '7', '日志中心', '0', 'gYFTwbQb', '', 'larry-gongzuoneirong', '2', '0', null, '', 'admin', '2017-08-30 17:58:16', 'admin', '2020-03-12 16:30:56');
INSERT INTO `cc_resource` VALUES ('52', '51', '日志管理', '0', 'oL6OcNAt', '/syslog/sys_log_list.do', 'larry-pingjiaguanli1', '3', '0', null, '', 'admin', '2017-08-30 18:03:00', 'admin', '2020-03-12 16:31:00');
INSERT INTO `cc_resource` VALUES ('54', '10', '新增公告', '0', '4JQVLmOd', '/announcement/announcement_add.do', 'larry-iconfontadd', '3', '1', null, '', 'admin', '2017-09-04 17:08:03', null, null);
INSERT INTO `cc_resource` VALUES ('55', '10', '删除公告', '0', 'eTDnjGAM', '/announcement/ajax_del_announcement.do', 'larry-shanchu9', '3', '1', null, '', 'admin', '2017-09-04 17:08:27', null, null);
INSERT INTO `cc_resource` VALUES ('56', null, '商品管理', '0', 'ITopswpT', '', 'larry-circularxiangxi', '1', '0', '2', '', 'admin', '2020-03-12 16:22:17', 'admin', '2020-03-14 17:26:39');
INSERT INTO `cc_resource` VALUES ('57', '56', '商品库存', '0', 'jW15aqWf', '/goods/goodsKuCun.do', 'larry-databasesql', '2', '0', null, '', 'admin', '2020-03-12 16:23:53', null, null);
INSERT INTO `cc_resource` VALUES ('58', '56', '商品出售', '0', 'QjGO0lFV', '/goods/goodsChushou.do', 'larry-tuichu1', '2', '0', null, '', 'admin', '2020-03-12 16:26:49', null, null);
INSERT INTO `cc_resource` VALUES ('59', '56', '货源进购', '0', 'thSPAwDY', '/goods/goodsJinGou.do', 'larry-iconfontxiazai', '2', '0', null, '', 'admin', '2020-03-12 16:27:29', 'admin', '2020-03-13 00:00:02');
INSERT INTO `cc_resource` VALUES ('60', '56', '商品信息更改', '0', 'f0Zdx3Uj', '/goods/goodsInfo.do', 'larry-iconfontpinglun', '2', '0', null, '', 'admin', '2020-03-12 16:28:24', null, null);
INSERT INTO `cc_resource` VALUES ('61', null, '商场收支分析', '0', 'YoHljQp1', '', 'larry-jiankong', '1', '0', '3', '', 'admin', '2020-03-12 16:32:11', 'admin', '2020-03-14 17:26:28');
INSERT INTO `cc_resource` VALUES ('62', '61', '统计与支出', '0', 'kr76mR7g', '', 'larry-shenheguanli', '2', '0', null, '', 'admin', '2020-03-12 16:32:57', null, null);
INSERT INTO `cc_resource` VALUES ('63', '62', '利润信息图形化', '0', 'TYogBxzh', '/goods/liRunXinxi.do', 'larry-zidian', '3', '0', null, '', 'admin', '2020-03-12 16:44:52', null, null);
INSERT INTO `cc_resource` VALUES ('64', '62', '商场收入支出', '0', 'E9GL7gyY', '/goods/shouruZhichu.do', 'larry-iconfontcolor16', '3', '0', '1', '', 'admin', '2020-03-12 16:45:54', null, null);
INSERT INTO `cc_resource` VALUES ('65', '56', '商品出售记录', '0', '0dzv7sqZ', '/goods/chushouRecord.do', 'larry-shuaxin4', '2', '0', null, '', 'admin', '2020-03-22 21:22:41', null, null);

-- ----------------------------
-- Table structure for cc_role
-- ----------------------------
DROP TABLE IF EXISTS `cc_role`;
CREATE TABLE `cc_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `role_status` int(11) NOT NULL,
  `role_remark` varchar(255) DEFAULT NULL,
  `creator` varchar(40) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modifier` varchar(40) DEFAULT NULL,
  `modifier_time` datetime DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of cc_role
-- ----------------------------
INSERT INTO `cc_role` VALUES ('55', '系统管理员', '0', '', 'admin', '2020-03-12 13:50:41', 'admin', '2020-03-12 16:59:55');
INSERT INTO `cc_role` VALUES ('56', '收费员', '0', '主要为商场收费员使用', 'admin', '2020-03-12 16:50:14', null, null);
INSERT INTO `cc_role` VALUES ('57', '测试', '1', '', 'admin', '2020-03-22 00:16:52', 'admin', '2020-03-22 00:17:17');
INSERT INTO `cc_role` VALUES ('58', '测试额', '1', '', 'admin', '2020-03-22 00:17:02', 'admin', '2020-03-22 00:17:17');

-- ----------------------------
-- Table structure for cc_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `cc_role_resource`;
CREATE TABLE `cc_role_resource` (
  `role_res_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  `creator` varchar(40) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modifier` varchar(40) DEFAULT NULL,
  `modifier_time` datetime DEFAULT NULL,
  PRIMARY KEY (`role_res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=759 DEFAULT CHARSET=utf8 COMMENT='角色与资源关系表';

-- ----------------------------
-- Records of cc_role_resource
-- ----------------------------
INSERT INTO `cc_role_resource` VALUES ('712', '55', '7', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('713', '55', '5', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('714', '55', '2', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('715', '55', '12', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('716', '55', '15', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('717', '55', '16', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('718', '55', '17', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('719', '55', '18', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('720', '55', '19', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('721', '55', '3', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('722', '55', '20', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('723', '55', '21', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('724', '55', '22', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('725', '55', '23', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('726', '55', '24', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('727', '55', '25', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('728', '55', '4', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('729', '55', '26', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('730', '55', '27', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('731', '55', '28', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('732', '55', '29', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('733', '55', '9', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('734', '55', '10', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('735', '55', '54', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('736', '55', '55', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('737', '55', '51', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('738', '55', '52', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('739', '55', '30', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('740', '55', '56', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('741', '55', '57', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('742', '55', '58', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('743', '55', '59', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('744', '55', '60', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('745', '55', '61', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('746', '55', '62', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('747', '55', '63', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('748', '55', '64', 'admin', '2020-03-12 19:23:23', null, null);
INSERT INTO `cc_role_resource` VALUES ('749', '56', '56', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('750', '56', '57', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('751', '56', '58', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('752', '56', '59', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('753', '56', '60', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('754', '56', '65', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('755', '56', '61', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('756', '56', '62', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('757', '56', '63', 'admin', '2020-03-12 19:41:41', null, null);
INSERT INTO `cc_role_resource` VALUES ('758', '56', '64', 'admin', '2020-03-12 19:41:41', null, null);

-- ----------------------------
-- Table structure for cc_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `cc_sys_log`;
CREATE TABLE `cc_sys_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_title` varchar(20) DEFAULT NULL COMMENT '日志标题',
  `log_type` varchar(10) DEFAULT NULL COMMENT '日志类型 info error',
  `log_url` varchar(50) DEFAULT NULL COMMENT '日志请求url',
  `log_method` varchar(10) DEFAULT NULL COMMENT '请求方式 get post',
  `log_params` varchar(300) DEFAULT NULL COMMENT '请求参数',
  `log_exception` varchar(200) DEFAULT NULL COMMENT '请求异常',
  `log_user_name` varchar(50) DEFAULT NULL COMMENT '请求用户Id',
  `log_ip` varchar(20) DEFAULT NULL COMMENT '请求IP',
  `log_ip_address` varchar(40) DEFAULT NULL COMMENT '请求ip所在地',
  `log_start_time` datetime DEFAULT NULL COMMENT '请求开始时间',
  `log_elapsed_time` bigint(20) DEFAULT NULL COMMENT '请求耗时',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cc_sys_log
-- ----------------------------
INSERT INTO `cc_sys_log` VALUES ('1', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"skpiu\",\"username\":\"admin\"}', null, 'admin', '0:0:0:0:0:0:0:1', null, '2020-03-12 20:23:45', '58');
INSERT INTO `cc_sys_log` VALUES ('2', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"c9t69\",\"username\":\"711027\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-15 22:26:56', '39');
INSERT INTO `cc_sys_log` VALUES ('3', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"PMYY1\",\"username\":\"711027\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-18 21:48:27', '59');
INSERT INTO `cc_sys_log` VALUES ('4', '保存商品信息', 'info', '/cProduct/ajax_save_goods.do', 'POST', '{\"productDesc\":\"方便面描述\",\"catagory\":\"3\",\"productNum\":\"10\",\"productName\":\"方便面\",\"productPrice\":\"3\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-22 18:52:14', '21');
INSERT INTO `cc_sys_log` VALUES ('5', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"86bzs\",\"username\":\"admin\"}', null, 'admin', '0:0:0:0:0:0:0:1', null, '2020-03-22 21:21:22', '6');
INSERT INTO `cc_sys_log` VALUES ('6', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"82med\",\"username\":\"711027\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-28 23:09:24', '174');
INSERT INTO `cc_sys_log` VALUES ('7', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"3fvuv\",\"username\":\"711027\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-28 23:49:17', '109');
INSERT INTO `cc_sys_log` VALUES ('8', '用户登陆', 'info', '/loginCheck.do', 'POST', '{\"password\":\"\",\"code\":\"cxsmx\",\"username\":\"711027\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-29 10:56:49', '174');
INSERT INTO `cc_sys_log` VALUES ('9', '保存商品信息', 'info', '/cProduct/ajax_saveChushou_goods.do', 'POST', '{\"productDesc\":\"用于洗脸\",\"catagory\":\"衣服\",\"xiaoPrice\":\"3\",\"productStatus\":\"1\",\"productSeq\":\"645033\",\"productName\":\"毛巾\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-29 11:19:58', '4');
INSERT INTO `cc_sys_log` VALUES ('10', '保存商品信息', 'info', '/cProduct/ajax_save_goods.do', 'POST', '{\"productDesc\":\"水果类\",\"catagory\":\"1\",\"productNum\":\"30\",\"productName\":\"榴莲\",\"productPrice\":\"100\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-29 13:42:00', '11');
INSERT INTO `cc_sys_log` VALUES ('11', '保存商品信息', 'info', '/cProduct/ajax_saveChushou_goods.do', 'POST', '{\"productDesc\":\"水果类\",\"catagory\":\"水果\",\"xiaoPrice\":\"150\",\"productStatus\":\"1\",\"productSeq\":\"720497\",\"productName\":\"榴莲\"}', null, '711027', '0:0:0:0:0:0:0:1', null, '2020-03-29 13:42:20', '24');

-- ----------------------------
-- Table structure for cc_user
-- ----------------------------
DROP TABLE IF EXISTS `cc_user`;
CREATE TABLE `cc_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login_name` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_status` bigint(20) NOT NULL,
  `creator` varchar(50) NOT NULL,
  `create_time` datetime NOT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `salary` varchar(255) DEFAULT NULL COMMENT '薪水',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cc_user
-- ----------------------------
INSERT INTO `cc_user` VALUES ('8', 'admin', '超级管理员', '123456', '0', 'admin', '2020-03-12 14:30:53', 'admin', '2020-03-12 16:12:36', '3000');
INSERT INTO `cc_user` VALUES ('9', '711027', '张三少年', '123456', '0', 'admin', '2020-03-12 16:49:43', 'admin', '2020-03-15 19:39:16', '7000');
INSERT INTO `cc_user` VALUES ('11', '711026', '李泉少年', '123456', '0', 'admin', '2020-03-14 16:27:56', 'admin', '2020-03-15 19:39:02', '8000');

-- ----------------------------
-- Table structure for cc_user_role
-- ----------------------------
DROP TABLE IF EXISTS `cc_user_role`;
CREATE TABLE `cc_user_role` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `creator` varchar(40) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modifier` varchar(40) DEFAULT NULL,
  `modifier_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=516 DEFAULT CHARSET=utf8 COMMENT='用户和角色关系表';

-- ----------------------------
-- Records of cc_user_role
-- ----------------------------
INSERT INTO `cc_user_role` VALUES ('506', '8', '55', 'admin', '2020-03-12 14:41:43', null, null);
INSERT INTO `cc_user_role` VALUES ('511', '11', '56', 'admin', '2020-03-14 16:51:37', null, null);
INSERT INTO `cc_user_role` VALUES ('515', '9', '56', '711027', '2020-03-14 17:24:58', null, null);

-- ----------------------------
-- Table structure for c_product
-- ----------------------------
DROP TABLE IF EXISTS `c_product`;
CREATE TABLE `c_product` (
  `product_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `product_price` varchar(255) DEFAULT NULL COMMENT '商品单价',
  `jingou_time` datetime DEFAULT NULL,
  `jingou_operator` varchar(255) DEFAULT NULL,
  `update_operator` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `catagory` varchar(255) NOT NULL COMMENT '产品类别（1-水果 2-衣服 3-食品 4-蔬菜）',
  `product_num` int(255) NOT NULL,
  `product_total_price` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_product
-- ----------------------------
INSERT INTO `c_product` VALUES ('60', '大葱', '2', '2020-03-22 18:49:54', '711027', null, null, '4', '10', '20');
INSERT INTO `c_product` VALUES ('61', '方便面', '3', '2020-03-22 18:52:14', '711027', null, null, '3', '10', '30');
INSERT INTO `c_product` VALUES ('62', '牙刷', '5', '2020-03-22 18:53:16', '711027', null, null, '1', '10', '50');
INSERT INTO `c_product` VALUES ('63', '大葱', '2', '2020-03-22 21:17:59', '711027', null, null, '4', '10', '20');
INSERT INTO `c_product` VALUES ('64', '毛巾', '20', '2020-03-29 11:19:46', '711027', null, null, '2', '40', '800');
INSERT INTO `c_product` VALUES ('65', '西红柿', '10', '2020-03-29 13:41:36', '711027', null, null, '4', '30', '300');
INSERT INTO `c_product` VALUES ('66', '榴莲', '100', '2020-03-29 13:42:00', '711027', null, null, '1', '30', '3000');

-- ----------------------------
-- Table structure for c_product_condition
-- ----------------------------
DROP TABLE IF EXISTS `c_product_condition`;
CREATE TABLE `c_product_condition` (
  `product_seq` varchar(6) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_desc` varchar(255) DEFAULT NULL,
  `product_price` varchar(255) DEFAULT NULL COMMENT '产品进购价',
  `catagory` varchar(255) DEFAULT NULL,
  `ku_cun_liang` int(255) DEFAULT NULL COMMENT '库存量',
  `xiao_liang` int(255) DEFAULT '0' COMMENT '销量',
  `xiao_price` varchar(255) DEFAULT '0' COMMENT '销售价格',
  `xiao_total_price` varchar(255) DEFAULT '0' COMMENT '该产品的销售总额',
  `li_run` varchar(255) DEFAULT '0' COMMENT '净利润',
  `jingou_num` int(255) DEFAULT NULL COMMENT '进购产品总数量',
  `product_status` varchar(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_product_condition
-- ----------------------------
INSERT INTO `c_product_condition` VALUES ('723244', '大葱', '做饭', '2', '4', '0', '20', '4', '80', '40', '20', '1');
INSERT INTO `c_product_condition` VALUES ('292682', '方便面', '方便面描述', '3', '3', '0', '10', '10', '100', '70', '10', '1');
INSERT INTO `c_product_condition` VALUES ('492217', '牙刷', '苹果', '5', '1', '0', '10', '10', '100', '50', '10', '1');
INSERT INTO `c_product_condition` VALUES ('645033', '毛巾', '用于洗脸', '20', '2', '12', '28', '30', '840', '40', '40', '1');
INSERT INTO `c_product_condition` VALUES ('569396', '西红柿', '食物', '10', '4', '0', '30', '30', '900', '600', '30', '1');
INSERT INTO `c_product_condition` VALUES ('720497', '榴莲', '水果类', '100', '1', '1', '29', '150', '4350', '1350', '30', '1');

-- ----------------------------
-- Table structure for c_selltime_product
-- ----------------------------
DROP TABLE IF EXISTS `c_selltime_product`;
CREATE TABLE `c_selltime_product` (
  `product_seq` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `xiaoshou_year` varchar(4) DEFAULT NULL,
  `xiaoshou_month` varchar(2) DEFAULT NULL,
  `xiaoshou_day` varchar(2) DEFAULT NULL,
  `xiaoshou_liang` varchar(10) DEFAULT NULL COMMENT '单笔销售量',
  `xiaoshou_price` varchar(255) DEFAULT NULL,
  `xiaoshou_total_price` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_selltime_product
-- ----------------------------
INSERT INTO `c_selltime_product` VALUES ('723244', '大葱', '2020', '3', '22', '1', '4', '4', '711027');
INSERT INTO `c_selltime_product` VALUES ('723244', '大葱', '2020', '3', '22', '5', '4', '20', '711027');
INSERT INTO `c_selltime_product` VALUES ('492217', '牙刷', '2020', '3', '22', '5', '10', '50', '711027');
INSERT INTO `c_selltime_product` VALUES ('292682', '方便面', '2020', '3', '22', '5', '10', '50', '711027');
INSERT INTO `c_selltime_product` VALUES ('723244', '大葱', '2020', '3', '22', '4', '4', '16', '711027');
INSERT INTO `c_selltime_product` VALUES ('723244', '大葱', '2020', '3', '29', '5', '4', '20', '711027');
INSERT INTO `c_selltime_product` VALUES ('723244', '大葱', '2020', '3', '29', '5', '4', '20', '711027');
INSERT INTO `c_selltime_product` VALUES ('492217', '牙刷', '2020', '3', '29', '1', '10', '10', '711027');
INSERT INTO `c_selltime_product` VALUES ('645033', '毛巾', '2020', '3', '29', '6', '30', '180', '711027');
INSERT INTO `c_selltime_product` VALUES ('645033', '毛巾', '2020', '3', '29', '7', '30', '210', '711027');
INSERT INTO `c_selltime_product` VALUES ('645033', '毛巾', '2020', '3', '29', '10', '30', '300', '711027');
INSERT INTO `c_selltime_product` VALUES ('645033', '毛巾', '2020', '3', '29', '5', '30', '150', '711027');
INSERT INTO `c_selltime_product` VALUES ('720497', '榴莲', '2020', '3', '29', '20', '150', '3000', '711027');
INSERT INTO `c_selltime_product` VALUES ('569396', '西红柿', '2020', '3', '29', '30', '30', '900', '711027');
INSERT INTO `c_selltime_product` VALUES ('720497', '榴莲', '2020', '3', '29', '1', '150', '150', '711027');
INSERT INTO `c_selltime_product` VALUES ('720497', '榴莲', '2020', '3', '29', '8', '150', '1200', '711027');
INSERT INTO `c_selltime_product` VALUES ('492217', '牙刷', '2020', '4', '2', '4', '10', '40', '711026');
INSERT INTO `c_selltime_product` VALUES ('292682', '方便面', '2020', '4', '2', '5', '10', '50', '711026');
