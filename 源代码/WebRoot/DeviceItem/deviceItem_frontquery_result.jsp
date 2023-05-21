<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.DeviceItem" %>
<%@ page import="com.chengxusheji.po.Device" %>
<%@ page import="com.chengxusheji.po.Shiyan" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<DeviceItem> deviceItemList = (List<DeviceItem>)request.getAttribute("deviceItemList");
    //获取所有的deviceObj信息
    List<Device> deviceList = (List<Device>)request.getAttribute("deviceList");
    //获取所有的shiyanObj信息
    List<Shiyan> shiyanList = (List<Shiyan>)request.getAttribute("shiyanList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Shiyan shiyanObj = (Shiyan)request.getAttribute("shiyanObj");
    Device deviceObj = (Device)request.getAttribute("deviceObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>实验设备条目查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#deviceItemListPanel" aria-controls="deviceItemListPanel" role="tab" data-toggle="tab">实验设备条目列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>DeviceItem/deviceItem_frontAdd.jsp" style="display:none;">添加实验设备条目</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="deviceItemListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录id</td><td>实验名称</td><td>所需设备</td><td>所需数量</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<deviceItemList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		DeviceItem deviceItem = deviceItemList.get(i); //获取到实验设备条目对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=deviceItem.getDeviceItemId() %></td>
 											<td><%=deviceItem.getShiyanObj().getShiyanName() %></td>
 											<td><%=deviceItem.getDeviceObj().getDeviceName() %></td>
 											<td><%=deviceItem.getDeviceCount() %></td>
 											<td>
 												<a href="<%=basePath  %>DeviceItem/<%=deviceItem.getDeviceItemId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="deviceItemEdit('<%=deviceItem.getDeviceItemId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="deviceItemDelete('<%=deviceItem.getDeviceItemId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>实验设备条目查询</h1>
		</div>
		<form name="deviceItemQueryForm" id="deviceItemQueryForm" action="<%=basePath %>DeviceItem/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="shiyanObj_shiyanId">实验名称：</label>
                <select id="shiyanObj_shiyanId" name="shiyanObj.shiyanId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Shiyan shiyanTemp:shiyanList) {
	 					String selected = "";
 					if(shiyanObj!=null && shiyanObj.getShiyanId()!=null && shiyanObj.getShiyanId().intValue()==shiyanTemp.getShiyanId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=shiyanTemp.getShiyanId() %>" <%=selected %>><%=shiyanTemp.getShiyanName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="deviceObj_deviceNo">所需设备：</label>
                <select id="deviceObj_deviceNo" name="deviceObj.deviceNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Device deviceTemp:deviceList) {
	 					String selected = "";
 					if(deviceObj!=null && deviceObj.getDeviceNo()!=null && deviceObj.getDeviceNo().equals(deviceTemp.getDeviceNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=deviceTemp.getDeviceNo() %>" <%=selected %>><%=deviceTemp.getDeviceName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="deviceItemEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;实验设备条目信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#deviceItemEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxDeviceItemModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.deviceItemQueryForm.currentPage.value = currentPage;
    document.deviceItemQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.deviceItemQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.deviceItemQueryForm.currentPage.value = pageValue;
    documentdeviceItemQueryForm.submit();
}

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
				$('#deviceItemEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除实验设备条目信息*/
function deviceItemDelete(deviceItemId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "DeviceItem/deletes",
			data : {
				deviceItemIds : deviceItemId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#deviceItemQueryForm").submit();
					//location.href= basePath + "DeviceItem/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

