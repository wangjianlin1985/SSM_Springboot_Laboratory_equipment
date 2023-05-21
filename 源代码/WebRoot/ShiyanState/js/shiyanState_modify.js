$(function () {
	$.ajax({
		url : "ShiyanState/" + $("#shiyanState_shiyanStateId_edit").val() + "/update",
		type : "get",
		data : {
			//shiyanStateId : $("#shiyanState_shiyanStateId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (shiyanState, response, status) {
			$.messager.progress("close");
			if (shiyanState) { 
				$("#shiyanState_shiyanStateId_edit").val(shiyanState.shiyanStateId);
				$("#shiyanState_shiyanStateId_edit").validatebox({
					required : true,
					missingMessage : "请输入实验状态id",
					editable: false
				});
				$("#shiyanState_shiyanStateName_edit").val(shiyanState.shiyanStateName);
				$("#shiyanState_shiyanStateName_edit").validatebox({
					required : true,
					missingMessage : "请输入实验状态名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#shiyanStateModifyButton").click(function(){ 
		if ($("#shiyanStateEditForm").form("validate")) {
			$("#shiyanStateEditForm").form({
			    url:"ShiyanState/" +  $("#shiyanState_shiyanStateId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#shiyanStateEditForm").form("validate"))  {
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
			$("#shiyanStateEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
