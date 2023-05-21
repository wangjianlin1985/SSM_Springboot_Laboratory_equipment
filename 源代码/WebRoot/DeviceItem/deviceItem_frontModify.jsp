<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.DeviceItem" %>
<%@ page import="com.chengxusheji.po.Device" %>
<%@ page import="com.chengxusheji.po.Shiyan" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的deviceObj信息
    List<Device> deviceList = (List<Device>)request.getAttribute("deviceList");
    //获取所有的shiyanObj信息
    List<Shiyan> shiyanList = (List<Shiyan>)request.getAttribute("shiyanList");
    DeviceItem deviceItem = (DeviceItem)request.getAttribute("deviceItem");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改实验设备条目信息</TITLE>
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
  		<li class="active">实验设备条目信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="deviceItemEditForm" id="deviceItemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="deviceItem_deviceItemId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="deviceItem_deviceItemId_edit" name="deviceItem.deviceItemId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="deviceItem_shiyanObj_shiyanId_edit" class="col-md-3 text-right">实验名称:</label>
		  	 <div class="col-md-9">
			    <select id="deviceItem_shiyanObj_shiyanId_edit" name="deviceItem.shiyanObj.shiyanId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="deviceItem_deviceObj_deviceNo_edit" class="col-md-3 text-right">所需设备:</label>
		  	 <div class="col-md-9">
			    <select id="deviceItem_deviceObj_deviceNo_edit" name="deviceItem.deviceObj.deviceNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="deviceItem_deviceCount_edit" class="col-md-3 text-right">所需数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="deviceItem_deviceCount_edit" name="deviceItem.deviceCount" class="form-control" placeholder="请输入所需数量">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxDeviceItemModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#deviceItemEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改实验设备条目界面并初始化数据*/
function deviceItemEdit(deviceItemId) {
	$.ajax({
		url :  basePath + "DeviceItem/" + deviceItemId + "/update",
		type : "get",
		dataType: "json",
		success : function (deviceItem, response, status) {
			if (deviceItem) {
				$("#deviceItem_deviceItemId_edit").val(deviceItem.deviceItemId);
				$.ajax({
					url: basePath + "Shiyan/listAll",
					type: "get",
					success: function(shiyans,response,status) { 
						$("#deviceItem_shiyanObj_shiyanId_edit").empty();
						var html="";
		        		$(shiyans).each(function(i,shiyan){
		        			html += "<option value='" + shiyan.shiyanId + "'>" + shiyan.shiyanName + "</option>";
		        		});
		        		$("#deviceItem_shiyanObj_shiyanId_edit").html(html);
		        		$("#deviceItem_shiyanObj_shiyanId_edit").val(deviceItem.shiyanObjPri);
					}
				});
				$.ajax({
					url: basePath + "Device/listAll",
					type: "get",
					success: function(devices,response,status) { 
						$("#deviceItem_deviceObj_deviceNo_edit").empty();
						var html="";
		        		$(devices).each(function(i,device){
		        			html += "<option value='" + device.deviceNo + "'>" + device.deviceName + "</option>";
		        		});
		        		$("#deviceItem_deviceObj_deviceNo_edit").html(html);
		        		$("#deviceItem_deviceObj_deviceNo_edit").val(deviceItem.deviceObjPri);
					}
				});
				$("#deviceItem_deviceCount_edit").val(deviceItem.deviceCount);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交实验设备条目信息表单给服务器端修改*/
function ajaxDeviceItemModify() {
	$.ajax({
		url :  basePath + "DeviceItem/" + $("#deviceItem_deviceItemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#deviceItemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#deviceItemQueryForm").submit();
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
    deviceItemEdit("<%=request.getParameter("deviceItemId")%>");
 })
 </script> 
</body>
</html>

