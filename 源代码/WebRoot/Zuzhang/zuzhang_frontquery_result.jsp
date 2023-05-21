<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Zuzhang" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Zuzhang> zuzhangList = (List<Zuzhang>)request.getAttribute("zuzhangList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String account = (String)request.getAttribute("account"); //账号查询关键字
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>组长查询</title>
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
  			<li><a href="<%=basePath %>Zuzhang/frontlist">组长信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Zuzhang/zuzhang_frontAdd.jsp" style="display:none;">添加组长</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<zuzhangList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Zuzhang zuzhang = zuzhangList.get(i); //获取到组长对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Zuzhang/<%=zuzhang.getAccount() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=zuzhang.getZuzhangPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		账号:<%=zuzhang.getAccount() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=zuzhang.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=zuzhang.getGender() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=zuzhang.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=zuzhang.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		邮箱:<%=zuzhang.getEmail() %>
			     	</div>
			     	<div class="field">
	            		注册时间:<%=zuzhang.getRegTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Zuzhang/<%=zuzhang.getAccount() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="zuzhangEdit('<%=zuzhang.getAccount() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="zuzhangDelete('<%=zuzhang.getAccount() %>');" style="display:none;">删除</a>
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
    		<h1>组长查询</h1>
		</div>
		<form name="zuzhangQueryForm" id="zuzhangQueryForm" action="<%=basePath %>Zuzhang/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="account">账号:</label>
				<input type="text" id="account" name="account" value="<%=account %>" class="form-control" placeholder="请输入账号">
			</div>
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="zuzhangEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;组长信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#zuzhangEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxZuzhangModify();">提交</button>
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
    document.zuzhangQueryForm.currentPage.value = currentPage;
    document.zuzhangQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.zuzhangQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.zuzhangQueryForm.currentPage.value = pageValue;
    documentzuzhangQueryForm.submit();
}

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
				$('#zuzhangEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除组长信息*/
function zuzhangDelete(account) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Zuzhang/deletes",
			data : {
				accounts : account,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#zuzhangQueryForm").submit();
					//location.href= basePath + "Zuzhang/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

