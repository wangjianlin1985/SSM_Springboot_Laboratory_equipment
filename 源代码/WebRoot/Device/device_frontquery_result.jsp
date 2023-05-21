<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Device" %>
<%@ page import="com.chengxusheji.po.DeviceClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Device> deviceList = (List<Device>)request.getAttribute("deviceList");
    //获取所有的deviceClassObj信息
    List<DeviceClass> deviceClassList = (List<DeviceClass>)request.getAttribute("deviceClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String deviceNo = (String)request.getAttribute("deviceNo"); //设备编号查询关键字
    DeviceClass deviceClassObj = (DeviceClass)request.getAttribute("deviceClassObj");
    String deviceName = (String)request.getAttribute("deviceName"); //设备名称查询关键字
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>实验设备查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Device/frontlist">实验设备信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Device/device_frontAdd.jsp" style="display:none;">添加实验设备</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<deviceList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Device device = deviceList.get(i); //获取到实验设备对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Device/<%=device.getDeviceNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=device.getDevicePhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		设备编号:<%=device.getDeviceNo() %>
			     	</div>
			     	<div class="field">
	            		设备类别:<%=device.getDeviceClassObj().getDeviceClassName() %>
			     	</div>
			     	<div class="field">
	            		设备名称:<%=device.getDeviceName() %>
			     	</div>
			     	<div class="field">
	            		设备库存:<%=device.getDeviceCount() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=device.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Device/<%=device.getDeviceNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="deviceEdit('<%=device.getDeviceNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="deviceDelete('<%=device.getDeviceNo() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>实验设备查询</h1>
		</div>
		<form name="deviceQueryForm" id="deviceQueryForm" action="<%=basePath %>Device/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="deviceNo">设备编号:</label>
				<input type="text" id="deviceNo" name="deviceNo" value="<%=deviceNo %>" class="form-control" placeholder="请输入设备编号">
			</div>
            <div class="form-group">
            	<label for="deviceClassObj_deviceClassId">设备类别：</label>
                <select id="deviceClassObj_deviceClassId" name="deviceClassObj.deviceClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(DeviceClass deviceClassTemp:deviceClassList) {
	 					String selected = "";
 					if(deviceClassObj!=null && deviceClassObj.getDeviceClassId()!=null && deviceClassObj.getDeviceClassId().intValue()==deviceClassTemp.getDeviceClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=deviceClassTemp.getDeviceClassId() %>" <%=selected %>><%=deviceClassTemp.getDeviceClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="deviceName">设备名称:</label>
				<input type="text" id="deviceName" name="deviceName" value="<%=deviceName %>" class="form-control" placeholder="请输入设备名称">
			</div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="deviceEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;实验设备信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="deviceEditForm" id="deviceEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="device_deviceNo_edit" class="col-md-3 text-right">设备编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="device_deviceNo_edit" name="device.deviceNo" class="form-control" placeholder="请输入设备编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="device_deviceClassObj_deviceClassId_edit" class="col-md-3 text-right">设备类别:</label>
		  	 <div class="col-md-9">
			    <select id="device_deviceClassObj_deviceClassId_edit" name="device.deviceClassObj.deviceClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="device_deviceName_edit" class="col-md-3 text-right">设备名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="device_deviceName_edit" name="device.deviceName" class="form-control" placeholder="请输入设备名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="device_devicePhoto_edit" class="col-md-3 text-right">设备照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="device_devicePhotoImg" border="0px"/><br/>
			    <input type="hidden" id="device_devicePhoto" name="device.devicePhoto"/>
			    <input id="devicePhotoFile" name="devicePhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="device_deviceCount_edit" class="col-md-3 text-right">设备库存:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="device_deviceCount_edit" name="device.deviceCount" class="form-control" placeholder="请输入设备库存">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="device_deviceDesc_edit" class="col-md-3 text-right">设备说明:</label>
		  	 <div class="col-md-9">
			 	<textarea name="device.deviceDesc" id="device_deviceDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="device_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date device_addTime_edit col-md-12" data-link-field="device_addTime_edit">
                    <input class="form-control" id="device_addTime_edit" name="device.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#deviceEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxDeviceModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var device_deviceDesc_edit = UE.getEditor('device_deviceDesc_edit'); //设备说明编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.deviceQueryForm.currentPage.value = currentPage;
    document.deviceQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.deviceQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.deviceQueryForm.currentPage.value = pageValue;
    documentdeviceQueryForm.submit();
}

/*弹出修改实验设备界面并初始化数据*/
function deviceEdit(deviceNo) {
	$.ajax({
		url :  basePath + "Device/" + deviceNo + "/update",
		type : "get",
		dataType: "json",
		success : function (device, response, status) {
			if (device) {
				$("#device_deviceNo_edit").val(device.deviceNo);
				$.ajax({
					url: basePath + "DeviceClass/listAll",
					type: "get",
					success: function(deviceClasss,response,status) { 
						$("#device_deviceClassObj_deviceClassId_edit").empty();
						var html="";
		        		$(deviceClasss).each(function(i,deviceClass){
		        			html += "<option value='" + deviceClass.deviceClassId + "'>" + deviceClass.deviceClassName + "</option>";
		        		});
		        		$("#device_deviceClassObj_deviceClassId_edit").html(html);
		        		$("#device_deviceClassObj_deviceClassId_edit").val(device.deviceClassObjPri);
					}
				});
				$("#device_deviceName_edit").val(device.deviceName);
				$("#device_devicePhoto").val(device.devicePhoto);
				$("#device_devicePhotoImg").attr("src", basePath +　device.devicePhoto);
				$("#device_deviceCount_edit").val(device.deviceCount);
				device_deviceDesc_edit.setContent(device.deviceDesc, false);
				$("#device_addTime_edit").val(device.addTime);
				$('#deviceEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除实验设备信息*/
function deviceDelete(deviceNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Device/deletes",
			data : {
				deviceNos : deviceNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#deviceQueryForm").submit();
					//location.href= basePath + "Device/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交实验设备信息表单给服务器端修改*/
function ajaxDeviceModify() {
	$.ajax({
		url :  basePath + "Device/" + $("#device_deviceNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#deviceEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#deviceQueryForm").submit();
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

    /*发布时间组件*/
    $('.device_addTime_edit').datetimepicker({
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
})
</script>
</body>
</html>

