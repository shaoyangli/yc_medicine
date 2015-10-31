/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : yc_medicine

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2015-10-31 15:57:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `hospitalinfo`
-- ----------------------------
DROP TABLE IF EXISTS `hospitalinfo`;
CREATE TABLE `hospitalinfo` (
`id`  int(10) NOT NULL COMMENT 'id' ,
`hospcode`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '住院号' ,
`name`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名' ,
`sex`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别' ,
`age`  varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '年龄' ,
`height`  varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身高' ,
`weight`  varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体重' ,
`surface_area`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '体表面积' ,
`operation_time`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手术时间' ,
`operator`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员id' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of hospitalinfo
-- ----------------------------
BEGIN;
INSERT INTO `hospitalinfo` VALUES ('1', '1', '李四', '1', '15', '178', '78', '1111', '2015-10-31 15:25:19', '1'), ('2', '112', '张三三', '1', '12', '150', '40', '12312', '2015-10-31 15:27:44', '3');
COMMIT;

-- ----------------------------
-- Table structure for `hsfs_org_base_info`
-- ----------------------------
DROP TABLE IF EXISTS `hsfs_org_base_info`;
CREATE TABLE `hsfs_org_base_info` (
`ORG_CODE`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_NAME`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_FAT_CODE`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`appropriation_Org`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_LEVEL`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_TYPEX`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_LEADER`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_ADDRESS`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_NCCMCODE`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_PHONE`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_AREAID`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`superFlag`  int(11) NULL DEFAULT NULL ,
`super`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`ORG_ID`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`BZBZ_JB`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=gbk COLLATE=gbk_chinese_ci

;

-- ----------------------------
-- Records of hsfs_org_base_info
-- ----------------------------
BEGIN;
INSERT INTO `hsfs_org_base_info` VALUES ('D001', '管理员', 'D001', null, null, null, null, null, null, null, '411300', null, null, null, null);
COMMIT;

-- ----------------------------
-- Table structure for `hsfs_user_info`
-- ----------------------------
DROP TABLE IF EXISTS `hsfs_user_info`;
CREATE TABLE `hsfs_user_info` (
`user_code`  int(11) NOT NULL ,
`user_name`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`org_code`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`USER_LOGINID`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`USER_PWD`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`POWER_ROLE`  int(11) NULL DEFAULT NULL ,
`IS_STOP`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`PDA_SN`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`DOC_ID`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=gbk COLLATE=gbk_chinese_ci

;

-- ----------------------------
-- Records of hsfs_user_info
-- ----------------------------
BEGIN;
INSERT INTO `hsfs_user_info` VALUES ('2', 'a001', 'D001', '111111', '123qwe', '1', '0', '', null), ('1', 'wang', 'D001', '000000', '123qwe', '1', '0', null, null), ('3', '张三医生', 'D001', '222222', '123qwe', '7', '0', '', null);
COMMIT;

-- ----------------------------
-- Table structure for `hsfs_user_power`
-- ----------------------------
DROP TABLE IF EXISTS `hsfs_user_power`;
CREATE TABLE `hsfs_user_power` (
`power_id`  int(11) NOT NULL AUTO_INCREMENT ,
`POWER_NAME`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`POWER_URL`  varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
`father_id`  int(11) NULL DEFAULT NULL ,
`ORDER_ID`  varchar(10) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL ,
PRIMARY KEY (`power_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=gbk COLLATE=gbk_chinese_ci
AUTO_INCREMENT=15

;

-- ----------------------------
-- Records of hsfs_user_power
-- ----------------------------
BEGIN;
INSERT INTO `hsfs_user_power` VALUES ('1', '用户管理', '', '0', '1'), ('2', '用户管理', 'user/userList.jsp', '1', '2'), ('3', '用户角色管理', 'user/userRole.jsp', '1', '3'), ('4', '权限管理', 'user/userPower.jsp', '1', '4'), ('5', '用户密码修改', 'user/userPassWord.jsp', '1', '5'), ('6', '角色分配权限', 'user/rolePower.jsp', '1', '6'), ('9', '用户添加', 'user/userRegister.jsp', '1', '7'), ('11', '给药信息管理', '', '0', '10'), ('13', '添加基本信息', '../medicine/hosp/addHospinfo.jsp', '11', '11'), ('14', '基本信息管理', '../medicine/hosp/hospinfoList.jsp', '11', '12');
COMMIT;

-- ----------------------------
-- Table structure for `hsfs_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `hsfs_user_role`;
CREATE TABLE `hsfs_user_role` (
`ROLE_CODE`  int(11) NULL DEFAULT NULL ,
`ROLE_NAME`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=gbk COLLATE=gbk_chinese_ci

;

-- ----------------------------
-- Records of hsfs_user_role
-- ----------------------------
BEGIN;
INSERT INTO `hsfs_user_role` VALUES ('1', '管理员'), ('7', '医生');
COMMIT;

-- ----------------------------
-- Table structure for `hsfs_user_role_power`
-- ----------------------------
DROP TABLE IF EXISTS `hsfs_user_role_power`;
CREATE TABLE `hsfs_user_role_power` (
`id`  int(11) NULL DEFAULT NULL ,
`ROLE_ID`  int(11) NULL DEFAULT NULL ,
`POWER_ID`  varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=gbk COLLATE=gbk_chinese_ci

;

-- ----------------------------
-- Records of hsfs_user_role_power
-- ----------------------------
BEGIN;
INSERT INTO `hsfs_user_role_power` VALUES ('1', '1', '1,2,3,4,5,6,9,11,13,14'), ('0', '7', '1,5,11,13,14');
COMMIT;

-- ----------------------------
-- Table structure for `meddetail_csa`
-- ----------------------------
DROP TABLE IF EXISTS `meddetail_csa`;
CREATE TABLE `meddetail_csa` (
`id`  int(11) NOT NULL COMMENT '记录id' ,
`hid`  int(11) NOT NULL ,
`mid`  int(11) NOT NULL COMMENT '给药信息id' ,
`dat2`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药日期' ,
`time`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药时间' ,
`amt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`cmt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药方式' ,
`rate`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药频率' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上次给药后的血液浓度' ,
`mdv`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有无dv值，0有1无' ,
`wt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体重' ,
`htc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞比积' ,
`atf`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合用抗真菌药物' ,
`dt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '环孢素治疗时间' ,
`tg`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '甘油三脂水平' ,
`age`  varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '年龄' ,
`sex`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别' ,
`ht`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`rbc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞计数' ,
`tbil`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总胆红素积' ,
`alt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷丙转氨酶' ,
`ast`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷草转氨酶' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of meddetail_csa
-- ----------------------------
BEGIN;
INSERT INTO `meddetail_csa` VALUES ('32', '4', '2', '2015-10-08', '15:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('33', '4', '2', '2015-10-09', '15:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('34', '4', '2', '2015-10-10', '15:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('35', '4', '2', '2015-10-11', '15:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('36', '4', '2', '2015-10-12', '15:00', '', '2', '', '282.67', '0', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('44', '4', '1', '2015-10-01', '13:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('45', '4', '1', '2015-10-02', '13:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('46', '4', '1', '2015-10-03', '13:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('47', '4', '1', '2015-10-04', '13:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('48', '4', '1', '2015-10-05', '13:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('49', '4', '1', '2015-10-06', '13:00', '100', '1', '', '', '1', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1'), ('50', '4', '1', '2015-10-06', '15:00', '', '2', '', '100', '0', '90', '1', '0', '0', '0', '40', '2', '178', '1', '1', '1', '1');
COMMIT;

-- ----------------------------
-- Table structure for `meddetail_fk`
-- ----------------------------
DROP TABLE IF EXISTS `meddetail_fk`;
CREATE TABLE `meddetail_fk` (
`id`  int(11) NOT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`mid`  int(11) NOT NULL COMMENT '给药信息id' ,
`dat2`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药日期或采血日期' ,
`time`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间，格式24小时制，这个也包括了给药时间及采血时间；' ,
`amt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`cmt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '给药方式：静脉给药输入”2”，口服给药输入”1”，若这一行有血药浓度数据，CMT格为空白' ,
`rate`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '1:\'QD\',2:\'Q12D\',3:\'24H滴注\'' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`mdv`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`wt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的体重，这个数值不是固定，因这些患者长期用药，体重可能会有变化' ,
`age`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的年龄，这个数值不是固定，因这些患者长期用药，年龄可能会有变化' ,
`hgb`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '血红蛋白，这个数值不是固定，应患者会经常检测这个指标' ,
`inhi`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用抗真菌药物（包括氟康唑、伊曲康唑、伏立康唑），若合用这些药物，输入“1”，未合用，输入“0”' ,
`pod`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '术后天数' ,
`sex`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别，男性输入“1”，女性输入“0”' ,
`ht`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的身高，这个数值不是固定，因这些患者长期用药，身高可能会有变化' ,
`rbc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞计数，这个数值不是固定，应患者会经常检测这个指标' ,
`htc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞比积，这个数值不是固定，应患者会经常检测这个指标' ,
`tbil`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总胆红素积，这个数值不是固定，应患者会经常检测这个指标' ,
`alt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷丙转氨酶，这个数值不是固定，应患者会经常检测这个指标' ,
`ast`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷草转氨酶，这个数值不是固定，应患者会经常检测这个指标' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of meddetail_fk
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `meddetail_vpa`
-- ----------------------------
DROP TABLE IF EXISTS `meddetail_vpa`;
CREATE TABLE `meddetail_vpa` (
`id`  int(11) NOT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`mid`  int(11) NOT NULL COMMENT '给药信息id' ,
`sex`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别' ,
`form`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '药物剂型，1=溶液剂，2=片剂，3=缓释剂' ,
`age`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '患者的年龄，这个数值不是固定，因这些患者长期用药，年龄可能会有变化' ,
`wt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的体重，这个数值不是固定，因这些患者长期用药，体重可能会有变化' ,
`bsa`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的体表面积，这个数值不是固定，因这些患者长期用药，体表面积可能会有变化' ,
`amt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`date`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药日期或采血日期' ,
`time`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间，格式24小时制，这个也包括了给药时间及采血时间；' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`mdv`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '若DV有数值，输入”0”,若DV无数值，输入”1”' ,
`tamt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '每日总剂量' ,
`lmsq`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用拉莫三嗪，合用输入”1”，未合用输入“0”' ,
`lxxp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用氯硝西泮，合用输入”1”，未合用输入“0”' ,
`kmxp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用卡马西平，合用输入”1”，未合用输入“0”' ,
`tt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”' ,
`bbbt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否用合苯巴比妥，合用输入”1”，未合用输入“0”' ,
`kpl`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”' ,
`okxp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用奥卡西平，合用输入”1”，未合用输入“0”' ,
`pht`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用苯妥英，合用输入”1”，未合用输入“0”' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of meddetail_vpa
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `meddetail_wf`
-- ----------------------------
DROP TABLE IF EXISTS `meddetail_wf`;
CREATE TABLE `meddetail_wf` (
`id`  int(11) NOT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`mid`  int(11) NOT NULL COMMENT '给药信息id' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`dose`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`mdv`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '若DV有数值，输入”0”,若DV无数值，输入”1”' ,
`age`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的年龄，这个数值不是固定，因这些患者长期用药，年龄可能会有变化' ,
`wt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的体重，这个数值不是固定，因这些患者长期用药，体重可能会有变化' ,
`adm`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用胺碘酮，合用输入”1”，未合用输入“0”' ,
`cyp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”' ,
`vkorc`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”' ,
`sex`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别，男性输入“1”，女性输入“0”' ,
`ht`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '患者的身高，这个数值不是固定，因这些患者长期用药，身高可能会有变化' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of meddetail_wf
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `medicine_csa`
-- ----------------------------
DROP TABLE IF EXISTS `medicine_csa`;
CREATE TABLE `medicine_csa` (
`id`  int(11) NULL DEFAULT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`date`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药日期或采血日期' ,
`time`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间，格式24小时制，这个也包括了给药时间及采血时间；' ,
`time2`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对于一天两次给药的第二次给药时间' ,
`amt2`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作为一天两次给药的第二次给药剂量，如一天一次的为null' ,
`cxrq`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '抽血日期' ,
`cxsj`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽血时间' ,
`amt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`cmt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '给药方式：静脉给药输入”2”，口服给药输入”1”，若这一行有血药浓度数据，CMT格为空白' ,
`rate`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '1:\'QD\',2:\'Q12D\',3:\'24H滴注\'' ,
`rate1`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '静脉给药速率，因这部分患者一般是24h给药，故应录入的数据为AMT/24值（即给药剂量除以24h），其余空白' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`htc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞比积，这个数值不是固定，应患者会经常检测这个指标' ,
`atf`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用抗真菌药物（包括氟康唑、伊曲康唑、伏立康唑），若合用这些药物，输入“1”，未合用，输入“0”' ,
`dt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '环孢素治疗时间，小于等于30天，输入“0”，大于30天，输入“1”' ,
`tg`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '甘油三脂水平，小于2.3mmol/L，输入“0”，大于等于2.3mmol/L，输入“1”；' ,
`rbc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞计数，这个数值不是固定，应患者会经常检测这个指标' ,
`tbil`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总胆红素积，这个数值不是固定，应患者会经常检测这个指标' ,
`alt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷丙转氨酶，这个数值不是固定，应患者会经常检测这个指标' ,
`ast`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷草转氨酶，这个数值不是固定，应患者会经常检测这个指标' ,
`jg`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剂量调整间隔' ,
`xysx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度上限' ,
`xyxx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度下限' ,
`zxyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小给药量' ,
`zdyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大给药量' ,
`ycxy`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预测血药浓度' ,
`jyyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生建议用量' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of medicine_csa
-- ----------------------------
BEGIN;
INSERT INTO `medicine_csa` VALUES ('1', '4', '2015-10-01', '13:00', '', '', '2015-10-06', '15:00', '100', '1', '1', null, '100', '1', '0', '0', '0', '1', '1', '1', '1', '10', '290', '270', '100', '100', '282.67', ''), ('2', '4', '2015-10-08', '15:00', '', '', '2015-10-12', '15:00', '100', '1', '1', null, '282.67', '1', '0', '0', '0', '1', '1', '1', '1', '10', '195', '180', '80', '110', '197.76', '');
COMMIT;

-- ----------------------------
-- Table structure for `medicine_fk`
-- ----------------------------
DROP TABLE IF EXISTS `medicine_fk`;
CREATE TABLE `medicine_fk` (
`id`  int(11) NOT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`date`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药日期或采血日期' ,
`time`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间，格式24小时制，这个也包括了给药时间及采血时间；' ,
`time2`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当日第二次给要时间，可以为null' ,
`amt2`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当日第二次给药剂量，可以为null' ,
`cxrq`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '抽血日期' ,
`cxsj`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽血时间' ,
`amt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`cmt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '给药方式：静脉给药输入”2”，口服给药输入”1”，若这一行有血药浓度数据，CMT格为空白' ,
`rate`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '1:\'QD\',2:\'Q12D\',3:\'24H滴注\'' ,
`rate1`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '静脉给药速率，因这部分患者一般是24h给药，故应录入的数据为AMT/24值（即给药剂量除以24h），其余空白' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`hgb`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '血红蛋白，这个数值不是固定，应患者会经常检测这个指标' ,
`inhi`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用抗真菌药物（包括氟康唑、伊曲康唑、伏立康唑），若合用这些药物，输入“1”，未合用，输入“0”' ,
`pod`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '术后天数' ,
`rbc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞计数，这个数值不是固定，应患者会经常检测这个指标' ,
`htc`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '红细胞比积，这个数值不是固定，应患者会经常检测这个指标' ,
`tbil`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总胆红素积，这个数值不是固定，应患者会经常检测这个指标' ,
`alt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷丙转氨酶，这个数值不是固定，应患者会经常检测这个指标' ,
`ast`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '谷草转氨酶，这个数值不是固定，应患者会经常检测这个指标' ,
`jg`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剂量调整间隔' ,
`xysx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度上限' ,
`xyxx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度下限' ,
`zxyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小给药量' ,
`zdyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大给药量' ,
`ycxy`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预测血药浓度' ,
`jyyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生建议用量' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of medicine_fk
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `medicine_vpa`
-- ----------------------------
DROP TABLE IF EXISTS `medicine_vpa`;
CREATE TABLE `medicine_vpa` (
`id`  int(11) NULL DEFAULT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`date`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药日期或采血日期' ,
`time`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间，格式24小时制，这个也包括了给药时间及采血时间；' ,
`time2`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药时间2' ,
`time3`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药时间3' ,
`cxrq`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽血日期' ,
`cxsj`  varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽血时间' ,
`rate`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药频率QD(一天一次)，BID一天两次 TID一天三次' ,
`amt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`amt2`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量2' ,
`amt3`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给药剂量3' ,
`tamt`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '每日总剂量' ,
`form`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '药物剂型，1=溶液剂，2=片剂，3=缓释剂' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`lmsq`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用拉莫三嗪，合用输入”1”，未合用输入“0”' ,
`lxxp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用氯硝西泮，合用输入”1”，未合用输入“0”' ,
`kmxp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用卡马西平，合用输入”1”，未合用输入“0”' ,
`tt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用妥泰（妥吡酯），合用输入”1”，未合用输入“0”' ,
`bbbt`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否用合苯巴比妥，合用输入”1”，未合用输入“0”' ,
`kpl`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用开普兰（左乙拉西坦），合用输入”1”，未合用输入“0”' ,
`okxp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用奥卡西平，合用输入”1”，未合用输入“0”' ,
`pht`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否合用苯妥英，合用输入”1”，未合用输入“0”' ,
`jg`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剂量调整间隔' ,
`xysx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度上限' ,
`xyxx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度下限' ,
`zxyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小给药量' ,
`zdyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大给药量' ,
`ycxy`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预测血药浓度' ,
`jyyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生建议用量' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of medicine_vpa
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for `medicine_wf`
-- ----------------------------
DROP TABLE IF EXISTS `medicine_wf`;
CREATE TABLE `medicine_wf` (
`id`  int(11) NOT NULL COMMENT 'id' ,
`hid`  int(11) NOT NULL COMMENT '关联住院信息id' ,
`dose`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '给药剂量,若这一行有血药浓度数据，AMT格为空白' ,
`dv`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上次给药后检测的血液浓度，有检测浓度输入相应检测浓度，无浓度空白' ,
`adm`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '是否合用胺碘酮，合用输入”1”，未合用输入“0”' ,
`cyp`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CYP2C9基因型，若为*1/*1型,输入“0”，若为*1/*3型,输入“1”' ,
`vkorc`  varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'VKORC1基因型，若为AA型,输入“0”，若为AG或GG型,输入“1”' ,
`jg`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剂量调整间隔' ,
`xysx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度上限' ,
`xyxx`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期望血液浓度下限' ,
`zxyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最小给药量' ,
`zdyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最大给药量' ,
`ycxy`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预测血药浓度' ,
`jyyl`  varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生建议用量' 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of medicine_wf
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Auto increment value for `hsfs_user_power`
-- ----------------------------
ALTER TABLE `hsfs_user_power` AUTO_INCREMENT=15;
