/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : device_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-05-24 14:43:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_device`
-- ----------------------------
DROP TABLE IF EXISTS `t_device`;
CREATE TABLE `t_device` (
  `deviceNo` varchar(20) NOT NULL COMMENT 'deviceNo',
  `deviceClassObj` int(11) NOT NULL COMMENT '设备类别',
  `deviceName` varchar(20) NOT NULL COMMENT '设备名称',
  `devicePhoto` varchar(60) NOT NULL COMMENT '设备照片',
  `deviceCount` int(11) NOT NULL COMMENT '设备库存',
  `deviceDesc` varchar(8000) NOT NULL COMMENT '设备说明',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`deviceNo`),
  KEY `deviceClassObj` (`deviceClassObj`),
  CONSTRAINT `t_device_ibfk_1` FOREIGN KEY (`deviceClassObj`) REFERENCES `t_deviceclass` (`deviceClassId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_device
-- ----------------------------
INSERT INTO `t_device` VALUES ('SB001', '2', '100ML烧杯', 'upload/7a283f00-e6fa-4ea4-9ea1-812949c8c723.jpg', '50', '<p>这个是玻璃做的，请轻拿轻放，别摔烂了！</p>', '2019-05-22 21:28:05');
INSERT INTO `t_device` VALUES ('SB002', '2', '250ML烧杯', 'upload/c69e4f21-0391-4656-a596-72259f22ad31.jpg', '40', '<p>玻璃做的，小心拿放</p>', '2019-05-24 13:06:28');
INSERT INTO `t_device` VALUES ('SB003', '1', '托盘天平称含砝码', 'upload/3c670706-6131-4215-9a1e-52f8b82eb21c.jpg', '10', '<p>品牌名称：Tzzt&nbsp;</p><p>颜色分类: 托盘天平100g含砝码 托盘天平200g含砝码 托盘天平500g含砝码 只是砝码100g 只是砝码200g 简易天平 200g/1g 只是砝码500g 托盘天平1000g含砝码品牌: Tzzt系列: 托盘天平型号: 200g</p><p><br/></p>', '2019-05-24 14:22:46');

-- ----------------------------
-- Table structure for `t_deviceclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_deviceclass`;
CREATE TABLE `t_deviceclass` (
  `deviceClassId` int(11) NOT NULL auto_increment COMMENT '设备类别id',
  `deviceClassName` varchar(20) NOT NULL COMMENT '设备类别名称',
  PRIMARY KEY  (`deviceClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_deviceclass
-- ----------------------------
INSERT INTO `t_deviceclass` VALUES ('1', '测量仪器');
INSERT INTO `t_deviceclass` VALUES ('2', '盛放容器');

-- ----------------------------
-- Table structure for `t_deviceitem`
-- ----------------------------
DROP TABLE IF EXISTS `t_deviceitem`;
CREATE TABLE `t_deviceitem` (
  `deviceItemId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `shiyanObj` int(11) NOT NULL COMMENT '实验名称',
  `deviceObj` varchar(20) NOT NULL COMMENT '所需设备',
  `deviceCount` int(11) NOT NULL COMMENT '所需数量',
  PRIMARY KEY  (`deviceItemId`),
  KEY `shiyanObj` (`shiyanObj`),
  KEY `deviceObj` (`deviceObj`),
  CONSTRAINT `t_deviceitem_ibfk_2` FOREIGN KEY (`deviceObj`) REFERENCES `t_device` (`deviceNo`),
  CONSTRAINT `t_deviceitem_ibfk_1` FOREIGN KEY (`shiyanObj`) REFERENCES `t_shiyan` (`shiyanId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_deviceitem
-- ----------------------------
INSERT INTO `t_deviceitem` VALUES ('1', '2', 'SB001', '2');
INSERT INTO `t_deviceitem` VALUES ('2', '1', 'SB001', '3');
INSERT INTO `t_deviceitem` VALUES ('3', '2', 'SB002', '2');
INSERT INTO `t_deviceitem` VALUES ('4', '1', 'SB003', '3');

-- ----------------------------
-- Table structure for `t_fankui`
-- ----------------------------
DROP TABLE IF EXISTS `t_fankui`;
CREATE TABLE `t_fankui` (
  `fankuiId` int(11) NOT NULL auto_increment COMMENT '反馈id',
  `title` varchar(20) NOT NULL COMMENT '反馈标题',
  `content` varchar(8000) NOT NULL COMMENT '反馈内容',
  `zuzhangObj` varchar(30) NOT NULL COMMENT '反馈组长',
  `fankuiTime` varchar(20) default NULL COMMENT '反馈时间',
  `jjcs` varchar(800) NOT NULL COMMENT '解决措施',
  PRIMARY KEY  (`fankuiId`),
  KEY `zuzhangObj` (`zuzhangObj`),
  CONSTRAINT `t_fankui_ibfk_1` FOREIGN KEY (`zuzhangObj`) REFERENCES `t_zuzhang` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_fankui
-- ----------------------------
INSERT INTO `t_fankui` VALUES ('1', '反馈标题aaaaaa', '<p>反馈内容bbbbbbbbbb</p>', 'zz001', '2019-05-22 21:33:34', '解决办法ccccccccc');
INSERT INTO `t_fankui` VALUES ('2', '反馈标题ggggggggg', '<p>反馈内容hhhhhhhhhhhhh</p>', 'zz001', '2019-05-24 13:21:57', '--');

-- ----------------------------
-- Table structure for `t_purchase`
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase`;
CREATE TABLE `t_purchase` (
  `purchaseId` int(11) NOT NULL auto_increment COMMENT '采购id',
  `deviceObj` varchar(20) NOT NULL COMMENT '采购设备',
  `supplier` varchar(20) NOT NULL COMMENT '供应商',
  `purchaseCount` int(11) NOT NULL COMMENT '采购数量',
  `price` float NOT NULL COMMENT '采购单价',
  `purchaseDate` varchar(20) default NULL COMMENT '采购日期',
  `userObj` varchar(30) NOT NULL COMMENT '采购人',
  `purchaseMemo` varchar(800) default NULL COMMENT '采购备注',
  PRIMARY KEY  (`purchaseId`),
  KEY `deviceObj` (`deviceObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_purchase_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_purchase_ibfk_1` FOREIGN KEY (`deviceObj`) REFERENCES `t_device` (`deviceNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_purchase
-- ----------------------------
INSERT INTO `t_purchase` VALUES ('1', 'SB001', '供应商111111', '20', '10', '2019-05-22', 'cg001', 'test');
INSERT INTO `t_purchase` VALUES ('2', 'SB003', '供应商bbbbb', '10', '50', '2019-05-24', 'cg001', '测试采购');

-- ----------------------------
-- Table structure for `t_repair`
-- ----------------------------
DROP TABLE IF EXISTS `t_repair`;
CREATE TABLE `t_repair` (
  `repairId` int(11) NOT NULL auto_increment COMMENT '维修id',
  `deviceObj` varchar(20) NOT NULL COMMENT '维修的设备',
  `repairCount` int(11) NOT NULL COMMENT '故障数量',
  `question` varchar(800) NOT NULL COMMENT '设备问题',
  `questionDate` varchar(20) default NULL COMMENT '故障日期',
  `repairContent` varchar(800) NOT NULL COMMENT '维修内容',
  `repairMoney` float NOT NULL COMMENT '维修费用',
  `repairMemo` varchar(800) default NULL COMMENT '备注信息',
  PRIMARY KEY  (`repairId`),
  KEY `deviceObj` (`deviceObj`),
  CONSTRAINT `t_repair_ibfk_1` FOREIGN KEY (`deviceObj`) REFERENCES `t_device` (`deviceNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_repair
-- ----------------------------
INSERT INTO `t_repair` VALUES ('1', 'SB001', '2', '设备问题11111111111111', '2019-05-15', '维修内容22222222222222', '45', 'dddd');
INSERT INTO `t_repair` VALUES ('2', 'SB003', '3', '设备问题aaaaaaaaaa', '2019-05-24', '维修内容bbbbbbbbbb', '100', '测试信息');

-- ----------------------------
-- Table structure for `t_scrap`
-- ----------------------------
DROP TABLE IF EXISTS `t_scrap`;
CREATE TABLE `t_scrap` (
  `scrapId` int(11) NOT NULL auto_increment COMMENT '报废id',
  `deviceObj` varchar(20) NOT NULL COMMENT '报废的设备',
  `scrapCount` int(11) NOT NULL COMMENT '报废数量',
  `reason` varchar(60) NOT NULL COMMENT '报废原因',
  `scrapDate` varchar(20) default NULL COMMENT '报废日期',
  `scrapMemo` varchar(800) default NULL COMMENT '报废备注',
  PRIMARY KEY  (`scrapId`),
  KEY `deviceObj` (`deviceObj`),
  CONSTRAINT `t_scrap_ibfk_1` FOREIGN KEY (`deviceObj`) REFERENCES `t_device` (`deviceNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_scrap
-- ----------------------------
INSERT INTO `t_scrap` VALUES ('1', 'SB001', '3', '原因ffffffffff', '2019-05-22', 'test');
INSERT INTO `t_scrap` VALUES ('2', 'SB002', '10', '报废原因bbbbbb', '2019-05-24', '备注aaaaaaaaaa');

-- ----------------------------
-- Table structure for `t_shiyan`
-- ----------------------------
DROP TABLE IF EXISTS `t_shiyan`;
CREATE TABLE `t_shiyan` (
  `shiyanId` int(11) NOT NULL auto_increment COMMENT '实验id',
  `shiyanName` varchar(20) NOT NULL COMMENT '实验名称',
  `shiyanTime` varchar(20) default NULL COMMENT '实验时间',
  `shiyanContent` varchar(8000) NOT NULL COMMENT '实验内容',
  `shiyanStateObj` int(11) NOT NULL COMMENT '实验状态',
  `zuzhangObj` varchar(30) NOT NULL COMMENT '组长姓名',
  PRIMARY KEY  (`shiyanId`),
  KEY `shiyanStateObj` (`shiyanStateObj`),
  KEY `zuzhangObj` (`zuzhangObj`),
  CONSTRAINT `t_shiyan_ibfk_2` FOREIGN KEY (`zuzhangObj`) REFERENCES `t_zuzhang` (`account`),
  CONSTRAINT `t_shiyan_ibfk_1` FOREIGN KEY (`shiyanStateObj`) REFERENCES `t_shiyanstate` (`shiyanStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shiyan
-- ----------------------------
INSERT INTO `t_shiyan` VALUES ('1', '无机电解质的聚沉作用与高分子的絮凝作用', '2019-05-23 21:30:07', '<p>1.掌握溶胶的聚沉原理与方法；<br/></p><p>2.验证电解质聚沉的符号和价数法则；</p><p>3.了解水溶性高分子对溶胶的絮凝作用。</p><p>&nbsp;二.实验原理<br/></p><p>1.无机电解质的聚沉作用 溶胶由于失去聚结稳定性进而失去动力稳定性的整个过程叫聚沉。电解质可以使溶<br/></p><p>胶发生聚沉。原因是电解质能使溶胶的§电势下降，且电解质的浓度越高§电势下降幅 度越大。当§电势下降至某一数值时，溶胶就会失去聚结稳定性，进而发生聚沉。<br/></p><p>不同电解质对溶胶有不同的聚沉能力，常用聚沉值来表示。聚沉值是指一定时间内， 能使溶胶发生明显聚沉的电解质的最低浓度。聚沉值越大，电解质对溶胶的聚沉能力越 小。<br/></p><p>聚沉值的大小与电解质中与溶胶所带电荷符号相反的离子的价数有关。这种相反符 号离子的价数越高，电解质的聚沉能力越大。叔采－哈迪(SchlZe--Hardy)分别研究了 电解质对不同溶胶的聚沉值，并归纳得出了聚沉离子的价数与聚沉值的关系：<br/></p><p>M+:M+2:M+3＝（25～150）：（0.5～2）：（0.01～0.1） 这个规律称为叔采－哈迪规则。<br/></p><p>2.相互聚沉现象 两种具有相反电荷的溶胶相互混合也能产生聚沉，这种现象称为相互聚沉现象。通<br/></p><p><br/></p><p>常认为有两种作用机理。</p><p>（1）电荷相反的两种胶粒电性中和；<br/></p><p>（2）一种溶胶是具有相反电荷溶胶的高价反离子。<br/></p><p><br/></p><p>3.高分子的絮凝作用 当高分子的浓度很低时，高分子主要表现为对溶胶的絮凝作用。絮凝作用是由于高分子对溶胶胶粒的“桥联”作用产生的。“桥联”理论认为：在高分子浓度很低时，高 分子的链可以同时吸附在几个胶体粒子上，通过“架桥”的方式将几个胶粒连在一起， 由于高分子链段的旋转和振动，将胶体粒子聚集在一起而产生沉降。</p><p><br/></p><p>&nbsp;</p><p><br/></p><p>&nbsp;</p><p><br/></p>', '5', 'zz001');
INSERT INTO `t_shiyan` VALUES ('2', '实验2实验2测试', '2019-05-31 21:45:48', '<p>实验内容写这里，测试数据，你自己修改就是!</p>', '1', 'zz001');

-- ----------------------------
-- Table structure for `t_shiyanstate`
-- ----------------------------
DROP TABLE IF EXISTS `t_shiyanstate`;
CREATE TABLE `t_shiyanstate` (
  `shiyanStateId` int(11) NOT NULL auto_increment COMMENT '实验状态id',
  `shiyanStateName` varchar(20) NOT NULL COMMENT '实验状态名称',
  PRIMARY KEY  (`shiyanStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shiyanstate
-- ----------------------------
INSERT INTO `t_shiyanstate` VALUES ('1', '实验申请待审核');
INSERT INTO `t_shiyanstate` VALUES ('2', '审核通过,待领取设备');
INSERT INTO `t_shiyanstate` VALUES ('3', '实验申请审核不通过');
INSERT INTO `t_shiyanstate` VALUES ('4', '实验领取设备申请');
INSERT INTO `t_shiyanstate` VALUES ('5', '设备领取成功等待归还');
INSERT INTO `t_shiyanstate` VALUES ('6', '实验完毕设备归还成功');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('cg001', '123', '李明翠', '女', '2019-05-16', 'upload/28cd9b20-ad72-47ec-a3b7-1f9bfce3a200.jpg', '13958342342', 'mingcui@163.com', '四川成都红星路13号', '2019-05-22 21:27:28');
INSERT INTO `t_userinfo` VALUES ('cg002', '123', '王晓燕', '女', '2019-05-10', 'upload/109ceaea-6203-4133-a105-e27292e698a6.jpg', '13573598343', 'xiaoyan@163.com', '四川南充滨江路', '2019-05-22 21:49:49');

-- ----------------------------
-- Table structure for `t_zuzhang`
-- ----------------------------
DROP TABLE IF EXISTS `t_zuzhang`;
CREATE TABLE `t_zuzhang` (
  `account` varchar(30) NOT NULL COMMENT 'account',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `zuzhangPhoto` varchar(60) NOT NULL COMMENT '组长照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_zuzhang
-- ----------------------------
INSERT INTO `t_zuzhang` VALUES ('zz001', '123', '张晓霞', '女', '2019-05-24', 'upload/e2e2cd19-6b18-4f13-a0d2-d3bd5d042680.jpg', '13508030843', 'xiaoxia@126.com', '四川达州', '2019-05-22 21:27:44');
INSERT INTO `t_zuzhang` VALUES ('zz002', '123', '吴丽丽', '女', '2019-05-22', 'upload/2a915a20-88c9-42e3-8731-051eafb330cb.jpg', '1308402243', 'wulili@163.com', '四川南充', '2019-05-22 21:50:17');
