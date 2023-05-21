<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ShiyanState" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ShiyanState> shiyanStateList = (List<ShiyanState>)request.getAttribute("shiyanStateList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>实验状态查询</title>
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
		<div class="col-md-12 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#shiyanStateListPanel" aria-controls="shiyanStateListPanel" role="tab" data-toggle="tab">实验状态列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ShiyanState/shiyanState_frontAdd.jsp" style="display:none;">添加实验状态</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="shiyanStateListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>实验状态id</td><td>实验状态名称</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<shiyanStateList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		ShiyanState shiyanState = shiyanStateList.get(i); //获取到实验状态对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=shiyanState.getShiyanStateId() %></td>
 											<td><%=shiyanState.getShiyanStateName() %></td>
 											<td>
 												<a href="<%=basePath  %>ShiyanState/<%=shiyanState.getShiyanStateId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="shiyanStateEdit('<%=shiyanState.getShiyanStateId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="shiyanStateDelete('<%=shiyanState.getShiyanStateId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
	<div style="display:none;">
		<div class="page-header">
    		<h1>实验状态查询</h1>
		</div>
		<form name="shiyanStateQueryForm" id="shiyanStateQueryForm" action="<%=basePath %>ShiyanState/frontlist" class="mar_t15" method="post">
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="shiyanStateEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;实验状态信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="shiyanStateEditForm" id="shiyanStateEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="shiyanState_shiyanStateId_edit" class="col-md-3 text-right">实验状态id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="shiyanState_shiyanStateId_edit" name="shiyanState.shiyanStateId" class="form-control" placeholder="请输入实验状态id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="shiyanState_shiyanStateName_edit" class="col-md-3 text-right">实验状态名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="shiyanState_shiyanStateName_edit" name="shiyanState.shiyanStateName" class="form-control" placeholder="请输入实验状态名称">
			 </div>
		  </div>
		</form> 
	    <style>#shiyanStateEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxShiyanStateModify();">提交</button>
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
    document.shiyanStateQueryForm.currentPage.value = currentPage;
    document.shiyanStateQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.shiyanStateQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.shiyanStateQueryForm.currentPage.value = pageValue;
    documentshiyanStateQueryForm.submit();
}

/*弹出修改实验状态界面并初始化数据*/
function shiyanStateEdit(shiyanStateId) {
	$.ajax({
		url :  basePath + "ShiyanState/" + shiyanStateId + "/update",
		type : "get",
		dataType: "json",
		success : function (shiyanState, response, status) {
			if (shiyanState) {
				$("#shiyanState_shiyanStateId_edit").val(shiyanState.shiyanStateId);
				$("#shiyanState_shiyanStateName_edit").val(shiyanState.shiyanStateName);
				$('#shiyanStateEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除实验状态信息*/
function shiyanStateDelete(shiyanStateId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ShiyanState/deletes",
			data : {
				shiyanStateIds : shiyanStateId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#shiyanStateQueryForm").submit();
					//location.href= basePath + "ShiyanState/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交实验状态信息表单给服务器端修改*/
function ajaxShiyanStateModify() {
	$.ajax({
		url :  basePath + "ShiyanState/" + $("#shiyanState_shiyanStateId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#shiyanStateEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.href= basePath + "ShiyanState/frontlist";
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

