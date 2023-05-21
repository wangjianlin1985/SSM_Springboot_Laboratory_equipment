$(function () {
	$.ajax({
		url : "DeviceClass/" + $("#deviceClass_deviceClassId_edit").val() + "/update",
		type : "get",
		data : {
			//deviceClassId : $("#deviceClass_deviceClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (deviceClass, response, status) {
			$.messager.progress("close");
			if (deviceClass) { 
				$("#deviceClass_deviceClassId_edit").val(deviceClass.deviceClassId);
				$("#deviceClass_deviceClassId_edit").validatebox({
					required : true,
					missingMessage : "请输入设备类别id",
					editable: false
				});
				$("#deviceClass_deviceClassName_edit").val(deviceClass.deviceClassName);
				$("#deviceClass_deviceClassName_edit").validatebox({
					required : true,
					missingMessage : "请输入设备类别名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#deviceClassModifyButton").click(function(){ 
		if ($("#deviceClassEditForm").form("validate")) {
			$("#deviceClassEditForm").form({
			    url:"DeviceClass/" +  $("#deviceClass_deviceClassId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#deviceClassEditForm").form("validate"))  {
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
			$("#deviceClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
