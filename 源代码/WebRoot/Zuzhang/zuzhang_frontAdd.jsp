<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>组长添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Zuzhang/frontlist">组长管理</a></li>
  			<li class="active">注册组长</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="zuzhangAddForm" id="zuzhangAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="zuzhang_account" class="col-md-2 text-right">账号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="zuzhang_account" name="zuzhang.account" class="form-control" placeholder="请输入账号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="zuzhang_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="zuzhang_password" name="zuzhang.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="zuzhang_name" name="zuzhang.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_gender" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="zuzhang_gender" name="zuzhang.gender" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_birthDateDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="zuzhang_birthDateDiv" class="input-group date zuzhang_birthDate col-md-12" data-link-field="zuzhang_birthDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="zuzhang_birthDate" name="zuzhang.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_zuzhangPhoto" class="col-md-2 text-right">组长照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="zuzhang_zuzhangPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="zuzhang_zuzhangPhoto" name="zuzhang.zuzhangPhoto"/>
					    <input id="zuzhangPhotoFile" name="zuzhangPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="zuzhang_telephone" name="zuzhang.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_email" class="col-md-2 text-right">邮箱:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="zuzhang_email" name="zuzhang.email" class="form-control" placeholder="请输入邮箱">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="zuzhang_address" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="zuzhang_address" name="zuzhang.address" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
				  <div class="form-group" style="display:none;">
				  	 <label for="zuzhang_regTimeDiv" class="col-md-2 text-right">注册时间:</label>
				  	 <div class="col-md-8">
		                <div id="zuzhang_regTimeDiv" class="input-group date zuzhang_regTime col-md-12" data-link-field="zuzhang_regTime">
		                    <input class="form-control" id="zuzhang_regTime" name="zuzhang.regTime" size="16" type="text" value="" placeholder="请选择注册时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxZuzhangAdd();" class="btn btn-primary bottom5 top5">组长注册</span>
		          </div> 
		          <style>#zuzhangAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加组长信息
	function ajaxZuzhangAdd() { 
		//提交之前先验证表单
		$("#zuzhangAddForm").data('bootstrapValidator').validate();
		if(!$("#zuzhangAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Zuzhang/add",
			dataType : "json" , 
			data: new FormData($("#zuzhangAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#zuzhangAddForm").find("input").val("");
					$("#zuzhangAddForm").find("textarea").val("");
				} else {
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
	//验证组长添加表单字段
	$('#zuzhangAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"zuzhang.account": {
				validators: {
					notEmpty: {
						message: "账号不能为空",
					}
				}
			},
			"zuzhang.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"zuzhang.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"zuzhang.gender": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"zuzhang.birthDate": {
				validators: {
					notEmpty: {
						message: "出生日期不能为空",
					}
				}
			},
			"zuzhang.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"zuzhang.email": {
				validators: {
					notEmpty: {
						message: "邮箱不能为空",
					}
				}
			},
			 
		}
	}); 
	//出生日期组件
	$('#zuzhang_birthDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#zuzhangAddForm').data('bootstrapValidator').updateStatus('zuzhang.birthDate', 'NOT_VALIDATED',null).validateField('zuzhang.birthDate');
	});
	//注册时间组件
	$('#zuzhang_regTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#zuzhangAddForm').data('bootstrapValidator').updateStatus('zuzhang.regTime', 'NOT_VALIDATED',null).validateField('zuzhang.regTime');
	});
})
</script>
</body>
</html>
