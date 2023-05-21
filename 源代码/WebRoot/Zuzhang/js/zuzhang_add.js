$(function () {
	$("#zuzhang_account").validatebox({
		required : true, 
		missingMessage : '请输入账号',
	});

	$("#zuzhang_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#zuzhang_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#zuzhang_gender").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#zuzhang_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#zuzhang_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#zuzhang_email").validatebox({
		required : true, 
		missingMessage : '请输入邮箱',
	});

	$("#zuzhang_regTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#zuzhangAddButton").click(function () {
		//验证表单 
		if(!$("#zuzhangAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#zuzhangAddForm").form({
			    url:"Zuzhang/add",
			    onSubmit: function(){
					if($("#zuzhangAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#zuzhangAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#zuzhangAddForm").submit();
		}
	});

	//单击清空按钮
	$("#zuzhangClearButton").click(function () { 
		$("#zuzhangAddForm").form("clear"); 
	});
});
