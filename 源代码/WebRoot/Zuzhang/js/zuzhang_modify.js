$(function () {
	$.ajax({
		url : "Zuzhang/" + $("#zuzhang_account_edit").val() + "/update",
		type : "get",
		data : {
			//account : $("#zuzhang_account_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (zuzhang, response, status) {
			$.messager.progress("close");
			if (zuzhang) { 
				$("#zuzhang_account_edit").val(zuzhang.account);
				$("#zuzhang_account_edit").validatebox({
					required : true,
					missingMessage : "请输入账号",
					editable: false
				});
				$("#zuzhang_password_edit").val(zuzhang.password);
				$("#zuzhang_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#zuzhang_name_edit").val(zuzhang.name);
				$("#zuzhang_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#zuzhang_gender_edit").val(zuzhang.gender);
				$("#zuzhang_gender_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#zuzhang_birthDate_edit").datebox({
					value: zuzhang.birthDate,
					required: true,
					showSeconds: true,
				});
				$("#zuzhang_zuzhangPhoto").val(zuzhang.zuzhangPhoto);
				$("#zuzhang_zuzhangPhotoImg").attr("src", zuzhang.zuzhangPhoto);
				$("#zuzhang_telephone_edit").val(zuzhang.telephone);
				$("#zuzhang_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#zuzhang_email_edit").val(zuzhang.email);
				$("#zuzhang_email_edit").validatebox({
					required : true,
					missingMessage : "请输入邮箱",
				});
				$("#zuzhang_address_edit").val(zuzhang.address);
				$("#zuzhang_regTime_edit").datetimebox({
					value: zuzhang.regTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#zuzhangModifyButton").click(function(){ 
		if ($("#zuzhangEditForm").form("validate")) {
			$("#zuzhangEditForm").form({
			    url:"Zuzhang/" +  $("#zuzhang_account_edit").val() + "/update",
			    onSubmit: function(){
					if($("#zuzhangEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#zuzhangEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
