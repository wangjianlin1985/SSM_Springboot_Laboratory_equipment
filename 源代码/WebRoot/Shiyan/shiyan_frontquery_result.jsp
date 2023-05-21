<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Shiyan" %>
<%@ page import="com.chengxusheji.po.ShiyanState" %>
<%@ page import="com.chengxusheji.po.Zuzhang" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Shiyan> shiyanList = (List<Shiyan>)request.getAttribute("shiyanList");
    //获取所有的shiyanStateObj信息
    List<ShiyanState> shiyanStateList = (List<ShiyanState>)request.getAttribute("shiyanStateList");
    //获取所有的zuzhangObj信息
    List<Zuzhang> zuzhangList = (List<Zuzhang>)request.getAttribute("zuzhangList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String shiyanName = (String)request.getAttribute("shiyanName"); //实验名称查询关键字
    String shiyanTime = (String)request.getAttribute("shiyanTime"); //实验时间查询关键字
    ShiyanState shiyanStateObj = (ShiyanState)request.getAttribute("shiyanStateObj");
    Zuzhang zuzhangObj = (Zuzhang)request.getAttribute("zuzhangObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>实验查询</title>
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
			    	<li role="presentation" class="active"><a href="#shiyanListPanel" aria-controls="shiyanListPanel" role="tab" data-toggle="tab">实验列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Shiyan/shiyan_frontAdd.jsp" style="display:none;">添加实验</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="shiyanListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>实验id</td><td>实验名称</td><td>实验时间</td><td>实验状态</td><td>组长姓名</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<shiyanList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Shiyan shiyan = shiyanList.get(i); //获取到实验对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=shiyan.getShiyanId() %></td>
 											<td><%=shiyan.getShiyanName() %></td>
 											<td><%=shiyan.getShiyanTime() %></td>
 											<td><%=shiyan.getShiyanStateObj().getShiyanStateName() %></td>
 											<td><%=shiyan.getZuzhangObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Shiyan/<%=shiyan.getShiyanId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="shiyanEdit('<%=shiyan.getShiyanId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="shiyanDelete('<%=shiyan.getShiyanId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>实验查询</h1>
		</div>
		<form name="shiyanQueryForm" id="shiyanQueryForm" action="<%=basePath %>Shiyan/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="shiyanName">实验名称:</label>
				<input type="text" id="shiyanName" name="shiyanName" value="<%=shiyanName %>" class="form-control" placeholder="请输入实验名称">
			</div>






			<div class="form-group">
				<label for="shiyanTime">实验时间:</label>
				<input type="text" id="shiyanTime" name="shiyanTime" class="form-control"  placeholder="请选择实验时间" value="<%=shiyanTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="shiyanStateObj_shiyanStateId">实验状态：</label>
                <select id="shiyanStateObj_shiyanStateId" name="shiyanStateObj.shiyanStateId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ShiyanState shiyanStateTemp:shiyanStateList) {
	 					String selected = "";
 					if(shiyanStateObj!=null && shiyanStateObj.getShiyanStateId()!=null && shiyanStateObj.getShiyanStateId().intValue()==shiyanStateTemp.getShiyanStateId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=shiyanStateTemp.getShiyanStateId() %>" <%=selected %>><%=shiyanStateTemp.getShiyanStateName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="zuzhangObj_account">组长姓名：</label>
                <select id="zuzhangObj_account" name="zuzhangObj.account" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Zuzhang zuzhangTemp:zuzhangList) {
	 					String selected = "";
 					if(zuzhangObj!=null && zuzhangObj.getAccount()!=null && zuzhangObj.getAccount().equals(zuzhangTemp.getAccount()))
 						selected = "selected";
	 				%>
 				 <option value="<%=zuzhangTemp.getAccount() %>" <%=selected %>><%=zuzhangTemp.getName() %></option>
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
<div id="shiyanEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;实验信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="shiyanEditForm" id="shiyanEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="shiyan_shiyanId_edit" class="col-md-3 text-right">实验id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="shiyan_shiyanId_edit" name="shiyan.shiyanId" class="form-control" placeholder="请输入实验id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="shiyan_shiyanName_edit" class="col-md-3 text-right">实验名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="shiyan_shiyanName_edit" name="shiyan.shiyanName" class="form-control" placeholder="请输入实验名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shiyan_shiyanTime_edit" class="col-md-3 text-right">实验时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date shiyan_shiyanTime_edit col-md-12" data-link-field="shiyan_shiyanTime_edit">
                    <input class="form-control" id="shiyan_shiyanTime_edit" name="shiyan.shiyanTime" size="16" type="text" value="" placeholder="请选择实验时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shiyan_shiyanContent_edit" class="col-md-3 text-right">实验内容:</label>
		  	 <div class="col-md-9">
			 	<textarea name="shiyan.shiyanContent" id="shiyan_shiyanContent_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shiyan_shiyanStateObj_shiyanStateId_edit" class="col-md-3 text-right">实验状态:</label>
		  	 <div class="col-md-9">
			    <select id="shiyan_shiyanStateObj_shiyanStateId_edit" name="shiyan.shiyanStateObj.shiyanStateId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shiyan_zuzhangObj_account_edit" class="col-md-3 text-right">组长姓名:</label>
		  	 <div class="col-md-9">
			    <select id="shiyan_zuzhangObj_account_edit" name="shiyan.zuzhangObj.account" class="form-control">
			    </select>
		  	 </div>
		  </div>
		</form> 
	    <style>#shiyanEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxShiyanModify();">提交</button>
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
var shiyan_shiyanContent_edit = UE.getEditor('shiyan_shiyanContent_edit'); //实验内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.shiyanQueryForm.currentPage.value = currentPage;
    document.shiyanQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.shiyanQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.shiyanQueryForm.currentPage.value = pageValue;
    documentshiyanQueryForm.submit();
}

/*弹出修改实验界面并初始化数据*/
function shiyanEdit(shiyanId) {
	$.ajax({
		url :  basePath + "Shiyan/" + shiyanId + "/update",
		type : "get",
		dataType: "json",
		success : function (shiyan, response, status) {
			if (shiyan) {
				$("#shiyan_shiyanId_edit").val(shiyan.shiyanId);
				$("#shiyan_shiyanName_edit").val(shiyan.shiyanName);
				$("#shiyan_shiyanTime_edit").val(shiyan.shiyanTime);
				shiyan_shiyanContent_edit.setContent(shiyan.shiyanContent, false);
				$.ajax({
					url: basePath + "ShiyanState/listAll",
					type: "get",
					success: function(shiyanStates,response,status) { 
						$("#shiyan_shiyanStateObj_shiyanStateId_edit").empty();
						var html="";
		        		$(shiyanStates).each(function(i,shiyanState){
		        			html += "<option value='" + shiyanState.shiyanStateId + "'>" + shiyanState.shiyanStateName + "</option>";
		        		});
		        		$("#shiyan_shiyanStateObj_shiyanStateId_edit").html(html);
		        		$("#shiyan_shiyanStateObj_shiyanStateId_edit").val(shiyan.shiyanStateObjPri);
					}
				});
				$.ajax({
					url: basePath + "Zuzhang/listAll",
					type: "get",
					success: function(zuzhangs,response,status) { 
						$("#shiyan_zuzhangObj_account_edit").empty();
						var html="";
		        		$(zuzhangs).each(function(i,zuzhang){
		        			html += "<option value='" + zuzhang.account + "'>" + zuzhang.name + "</option>";
		        		});
		        		$("#shiyan_zuzhangObj_account_edit").html(html);
		        		$("#shiyan_zuzhangObj_account_edit").val(shiyan.zuzhangObjPri);
					}
				});
				$('#shiyanEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除实验信息*/
function shiyanDelete(shiyanId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Shiyan/deletes",
			data : {
				shiyanIds : shiyanId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#shiyanQueryForm").submit();
					//location.href= basePath + "Shiyan/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交实验信息表单给服务器端修改*/
function ajaxShiyanModify() {
	$.ajax({
		url :  basePath + "Shiyan/" + $("#shiyan_shiyanId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#shiyanEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#shiyanQueryForm").submit();
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

    /*实验时间组件*/
    $('.shiyan_shiyanTime_edit').datetimepicker({
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

