# SSM_Springboot_Laboratory_equipment
JSP基于SSM生物实验室设备管理系统可升级SpringBoot毕业源码案例设计

## 前台框架： Bootstrap(一个HTML5响应式框架）
## 开发环境：myEclipse/Eclipse/Idea + mysql数据库
## 后台框架: SSM(SpringMVC + Spring + Mybatis)
### (1)采购员：主要负责所有设备的购进，当设备购进后采购员负责对设备信息进行新增，为设备分类编号，并且每个设备都有属于自己的ID号。
采购员对应的功能：信息查询管理：设备信息查询，设备新购查询
设备类别管理：增加新类别，修改已有类别
采购员信息管理：采购员信息注册，登录，密码修改
### (2)组长：组长由实验组老师担任。组长每次做实验之前向管理员申请此次实验所用到的实验设备，管理员通过申请，组长填写借出设备信息表（包括组长姓名，电话等信息）领取设备。最重要的是组长在每次实验结束后填写反馈日志进行设备使用情况的说明。
组长对应的功能：组长信息管理：组长信息注册，登录，密码修改
### (3)管理员：管理员由实验中心主任担任。管理员负责设备信息的查询；管理员负责对后台数据库进行及时更新。管理员每天都需要通过组长反馈的日志信息，来对设备进行最后统计，并且填写日志信息，提出解决措施。
管理员对应的功能：信息查询管理：设备信息查询，设备维修查询，设备新购查询
设备类别管理：增加新类别，修改已有类别
设备维修管理: 维修信息查询，维修信息增加
维修信息删除，维修信息修改
设备报废管理：报废信息查询，报废信息修改
报废信息删除，报废信息修改
管理员信息管理：管理员信息注册，登录，密码修改
## 实体ER属性如下：
采购员: 用户名,登录密码,姓名,性别,出生日期,用户照片,联系电话,邮箱,家庭地址,注册时间

组长: 账号,登录密码,姓名,性别,出生日期,组长照片,联系电话,邮箱,家庭地址,注册时间

设备类别: 设备类别id,设备类别名称

实验设备: 设备编号,设备类别,设备名称,设备照片,设备库存,设备说明,发布时间

设备采购: 采购id,采购设备,供应商,采购数量,采购单价,采购日期,采购人,采购备注

实验: 实验id,实验名称,实验时间,实验内容,实验状态,组长姓名

实验设备条目: 记录id,实验名称,所需设备,所需数量

实验状态: 实验状态id,实验状态名称

反馈日志: 反馈id,反馈标题,反馈内容,反馈组长,反馈时间,解决措施

设备维修: 维修id,维修的设备,故障数量,设备问题,故障日期,维修内容,维修费用,备注信息

设备报废: 报废id,报废的设备,报废数量,报废原因,报废日期,报废备注