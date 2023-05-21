<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Purchase" %>
<%@ page import="com.chengxusheji.po.Device" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Purchase> purchaseList = (List<Purchase>)request.getAttribute("purchaseList");
    //获取所有的deviceObj信息
    List<Device> deviceList = (List<Device>)request.getAttribute("deviceList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Device deviceObj = (Device)request.getAttribute("deviceObj");
    String supplier = (String)request.getAttribute("supplier"); //供应商查询关键字
    String purchaseDate = (String)request.getAttribute("purchaseDate"); //采购日期查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>设备采购查询</title>
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
			    	<li role="presentation" class="active"><a href="#purchaseListPanel" aria-controls="purchaseListPanel" role="tab" data-toggle="tab">设备采购列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Purchase/purchase_frontAdd.jsp" style="display:none;">添加设备采购</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="purchaseListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>采购id</td><td>采购设备</td><td>供应商</td><td>采购数量</td><td>采购单价</td><td>采购日期</td><td>采购人</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<purchaseList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Purchase purchase = purchaseList.get(i); //获取到设备采购对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=purchase.getPurchaseId() %></td>
 											<td><%=purchase.getDeviceObj().getDeviceName() %></td>
 											<td><%=purchase.getSupplier() %></td>
 											<td><%=purchase.getPurchaseCount() %></td>
 											<td><%=purchase.getPrice() %></td>
 											<td><%=purchase.getPurchaseDate() %></td>
 											<td><%=purchase.getUserObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Purchase/<%=purchase.getPurchaseId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="purchaseEdit('<%=purchase.getPurchaseId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="purchaseDelete('<%=purchase.getPurchaseId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>设备采购查询</h1>
		</div>
		<form name="purchaseQueryForm" id="purchaseQueryForm" action="<%=basePath %>Purchase/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="deviceObj_deviceNo">采购设备：</label>
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
			<div class="form-group">
				<label for="supplier">供应商:</label>
				<input type="text" id="supplier" name="supplier" value="<%=supplier %>" class="form-control" placeholder="请输入供应商">
			</div>






			<div class="form-group">
				<label for="purchaseDate">采购日期:</label>
				<input type="text" id="purchaseDate" name="purchaseDate" class="form-control"  placeholder="请选择采购日期" value="<%=purchaseDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">采购人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
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
<div id="purchaseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;设备采购信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="purchaseEditForm" id="purchaseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="purchase_purchaseId_edit" class="col-md-3 text-right">采购id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="purchase_purchaseId_edit" name="purchase.purchaseId" class="form-control" placeholder="请输入采购id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="purchase_deviceObj_deviceNo_edit" class="col-md-3 text-right">采购设备:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_deviceObj_deviceNo_edit" name="purchase.deviceObj.deviceNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_supplier_edit" class="col-md-3 text-right">供应商:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_supplier_edit" name="purchase.supplier" class="form-control" placeholder="请输入供应商">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseCount_edit" class="col-md-3 text-right">采购数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_purchaseCount_edit" name="purchase.purchaseCount" class="form-control" placeholder="请输入采购数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_price_edit" class="col-md-3 text-right">采购单价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_price_edit" name="purchase.price" class="form-control" placeholder="请输入采购单价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseDate_edit" class="col-md-3 text-right">采购日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date purchase_purchaseDate_edit col-md-12" data-link-field="purchase_purchaseDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="purchase_purchaseDate_edit" name="purchase.purchaseDate" size="16" type="text" value="" placeholder="请选择采购日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_userObj_user_name_edit" class="col-md-3 text-right">采购人:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_userObj_user_name_edit" name="purchase.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseMemo_edit" class="col-md-3 text-right">采购备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="purchase_purchaseMemo_edit" name="purchase.purchaseMemo" rows="8" class="form-control" placeholder="请输入采购备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#purchaseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPurchaseModify();">提交</button>
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
    document.purchaseQueryForm.currentPage.value = currentPage;
    document.purchaseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.purchaseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.purchaseQueryForm.currentPage.value = pageValue;
    documentpurchaseQueryForm.submit();
}

/*弹出修改设备采购界面并初始化数据*/
function purchaseEdit(purchaseId) {
	$.ajax({
		url :  basePath + "Purchase/" + purchaseId + "/update",
		type : "get",
		dataType: "json",
		success : function (purchase, response, status) {
			if (purchase) {
				$("#purchase_purchaseId_edit").val(purchase.purchaseId);
				$.ajax({
					url: basePath + "Device/listAll",
					type: "get",
					success: function(devices,response,status) { 
						$("#purchase_deviceObj_deviceNo_edit").empty();
						var html="";
		        		$(devices).each(function(i,device){
		        			html += "<option value='" + device.deviceNo + "'>" + device.deviceName + "</option>";
		        		});
		        		$("#purchase_deviceObj_deviceNo_edit").html(html);
		        		$("#purchase_deviceObj_deviceNo_edit").val(purchase.deviceObjPri);
					}
				});
				$("#purchase_supplier_edit").val(purchase.supplier);
				$("#purchase_purchaseCount_edit").val(purchase.purchaseCount);
				$("#purchase_price_edit").val(purchase.price);
				$("#purchase_purchaseDate_edit").val(purchase.purchaseDate);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#purchase_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#purchase_userObj_user_name_edit").html(html);
		        		$("#purchase_userObj_user_name_edit").val(purchase.userObjPri);
					}
				});
				$("#purchase_purchaseMemo_edit").val(purchase.purchaseMemo);
				$('#purchaseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除设备采购信息*/
function purchaseDelete(purchaseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Purchase/deletes",
			data : {
				purchaseIds : purchaseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#purchaseQueryForm").submit();
					//location.href= basePath + "Purchase/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交设备采购信息表单给服务器端修改*/
function ajaxPurchaseModify() {
	$.ajax({
		url :  basePath + "Purchase/" + $("#purchase_purchaseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#purchaseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#purchaseQueryForm").submit();
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

    /*采购日期组件*/
    $('.purchase_purchaseDate_edit').datetimepicker({
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
})
</script>
</body>
</html>

