<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Device" %>
<%@ page import="com.chengxusheji.po.Shiyan" %>
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
<title>实验设备条目添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>DeviceItem/frontlist">实验设备条目列表</a></li>
			    	<li role="presentation" class="active"><a href="#deviceItemAdd" aria-controls="deviceItemAdd" role="tab" data-toggle="tab">添加实验设备条目</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="deviceItemList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="deviceItemAdd"> 
				      	<form class="form-horizontal" name="deviceItemAddForm" id="deviceItemAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="deviceItem_shiyanObj_shiyanId" class="col-md-2 text-right">实验名称:</label>
						  	 <div class="col-md-8">
							    <select id="deviceItem_shiyanObj_shiyanId" name="deviceItem.shiyanObj.shiyanId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="deviceItem_deviceObj_deviceNo" class="col-md-2 text-right">所需设备:</label>
						  	 <div class="col-md-8">
							    <select id="deviceItem_deviceObj_deviceNo" name="deviceItem.deviceObj.deviceNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="deviceItem_deviceCount" class="col-md-2 text-right">所需数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="deviceItem_deviceCount" name="deviceItem.deviceCount" class="form-control" placeholder="请输入所需数量">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxDeviceItemAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#deviceItemAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加实验设备条目信息
	function ajaxDeviceItemAdd() { 
		//提交之前先验证表单
		$("#deviceItemAddForm").data('bootstrapValidator').validate();
		if(!$("#deviceItemAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "DeviceItem/add",
			dataType : "json" , 
			data: new FormData($("#deviceItemAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#deviceItemAddForm").find("input").val("");
					$("#deviceItemAddForm").find("textarea").val("");
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
	//验证实验设备条目添加表单字段
	$('#deviceItemAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"deviceItem.deviceCount": {
				validators: {
					notEmpty: {
						message: "所需数量不能为空",
					},
					integer: {
						message: "所需数量不正确"
					}
				}
			},
		}
	}); 
	//初始化实验名称下拉框值 
	$.ajax({
		url: basePath + "Shiyan/listAll",
		type: "get",
		success: function(shiyans,response,status) { 
			$("#deviceItem_shiyanObj_shiyanId").empty();
			var html="";
    		$(shiyans).each(function(i,shiyan){
    			html += "<option value='" + shiyan.shiyanId + "'>" + shiyan.shiyanName + "</option>";
    		});
    		$("#deviceItem_shiyanObj_shiyanId").html(html);
    	}
	});
	//初始化所需设备下拉框值 
	$.ajax({
		url: basePath + "Device/listAll",
		type: "get",
		success: function(devices,response,status) { 
			$("#deviceItem_deviceObj_deviceNo").empty();
			var html="";
    		$(devices).each(function(i,device){
    			html += "<option value='" + device.deviceNo + "'>" + device.deviceName + "</option>";
    		});
    		$("#deviceItem_deviceObj_deviceNo").html(html);
    	}
	});
})
</script>
</body>
</html>
