<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Zuzhang" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Zuzhang zuzhang = (Zuzhang)request.getAttribute("zuzhang");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改组长信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">组长信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="zuzhangEditForm" id="zuzhangEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="zuzhang_account_edit" class="col-md-3 text-right">账号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="zuzhang_account_edit" name="zuzhang.account" class="form-control" placeholder="请输入账号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="zuzhang_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zuzhang_password_edit" name="zuzhang.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zuzhang_name_edit" name="zuzhang.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_gender_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zuzhang_gender_edit" name="zuzhang.gender" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date zuzhang_birthDate_edit col-md-12" data-link-field="zuzhang_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="zuzhang_birthDate_edit" name="zuzhang.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_zuzhangPhoto_edit" class="col-md-3 text-right">组长照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="zuzhang_zuzhangPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="zuzhang_zuzhangPhoto" name="zuzhang.zuzhangPhoto"/>
			    <input id="zuzhangPhotoFile" name="zuzhangPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zuzhang_telephone_edit" name="zuzhang.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_email_edit" class="col-md-3 text-right">邮箱:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zuzhang_email_edit" name="zuzhang.email" class="form-control" placeholder="请输入邮箱">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_address_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="zuzhang_address_edit" name="zuzhang.address" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zuzhang_regTime_edit" class="col-md-3 text-right">注册时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date zuzhang_regTime_edit col-md-12" data-link-field="zuzhang_regTime_edit">
                    <input class="form-control" id="zuzhang_regTime_edit" name="zuzhang.regTime" size="16" type="text" value="" placeholder="请选择注册时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxZuzhangModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#zuzhangEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改组长界面并初始化数据*/
function zuzhangEdit(account) {
	$.ajax({
		url :  basePath + "Zuzhang/" + account + "/update",
		type : "get",
		dataType: "json",
		success : function (zuzhang, response, status) {
			if (zuzhang) {
				$("#zuzhang_account_edit").val(zuzhang.account);
				$("#zuzhang_password_edit").val(zuzhang.password);
				$("#zuzhang_name_edit").val(zuzhang.name);
				$("#zuzhang_gender_edit").val(zuzhang.gender);
				$("#zuzhang_birthDate_edit").val(zuzhang.birthDate);
				$("#zuzhang_zuzhangPhoto").val(zuzhang.zuzhangPhoto);
				$("#zuzhang_zuzhangPhotoImg").attr("src", basePath +　zuzhang.zuzhangPhoto);
				$("#zuzhang_telephone_edit").val(zuzhang.telephone);
				$("#zuzhang_email_edit").val(zuzhang.email);
				$("#zuzhang_address_edit").val(zuzhang.address);
				$("#zuzhang_regTime_edit").val(zuzhang.regTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交组长信息表单给服务器端修改*/
function ajaxZuzhangModify() {
	$.ajax({
		url :  basePath + "Zuzhang/" + $("#zuzhang_account_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#zuzhangEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#zuzhangQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*出生日期组件*/
    $('.zuzhang_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*注册时间组件*/
    $('.zuzhang_regTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    zuzhangEdit("<%=request.getParameter("account")%>");
 })
 </script> 
</body>
</html>

