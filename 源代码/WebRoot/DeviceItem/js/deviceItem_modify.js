$(function () {
	$.ajax({
		url : "DeviceItem/" + $("#deviceItem_deviceItemId_edit").val() + "/update",
		type : "get",
		data : {
			//deviceItemId : $("#deviceItem_deviceItemId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (deviceItem, response, status) {
			$.messager.progress("close");
			if (deviceItem) { 
				$("#deviceItem_deviceItemId_edit").val(deviceItem.deviceItemId);
				$("#deviceItem_deviceItemId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录id",
					editable: false
				});
				$("#deviceItem_shiyanObj_shiyanId_edit").combobox({
					url:"Shiyan/listAll",
					valueField:"shiyanId",
					textField:"shiyanName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#deviceItem_shiyanObj_shiyanId_edit").combobox("select", deviceItem.shiyanObjPri);
						//var data = $("#deviceItem_shiyanObj_shiyanId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#deviceItem_shiyanObj_shiyanId_edit").combobox("select", data[0].shiyanId);
						//}
					}
				});
				$("#deviceItem_deviceObj_deviceNo_edit").combobox({
					url:"Device/listAll",
					valueField:"deviceNo",
					textField:"deviceName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#deviceItem_deviceObj_deviceNo_edit").combobox("select", deviceItem.deviceObjPri);
						//var data = $("#deviceItem_deviceObj_deviceNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#deviceItem_deviceObj_deviceNo_edit").combobox("select", data[0].deviceNo);
						//}
					}
				});
				$("#deviceItem_deviceCount_edit").val(deviceItem.deviceCount);
				$("#deviceItem_deviceCount_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入所需数量",
					invalidMessage : "所需数量输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#deviceItemModifyButton").click(function(){ 
		if ($("#deviceItemEditForm").form("validate")) {
			$("#deviceItemEditForm").form({
			    url:"DeviceItem/" +  $("#deviceItem_deviceItemId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#deviceItemEditForm").form("validate"))  {
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
			$("#deviceItemEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
