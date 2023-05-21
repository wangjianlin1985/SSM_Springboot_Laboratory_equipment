$(function () {
	$("#deviceItem_shiyanObj_shiyanId").combobox({
	    url:'Shiyan/listAll',
	    valueField: "shiyanId",
	    textField: "shiyanName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#deviceItem_shiyanObj_shiyanId").combobox("getData"); 
            if (data.length > 0) {
                $("#deviceItem_shiyanObj_shiyanId").combobox("select", data[0].shiyanId);
            }
        }
	});
	$("#deviceItem_deviceObj_deviceNo").combobox({
	    url:'Device/listAll',
	    valueField: "deviceNo",
	    textField: "deviceName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#deviceItem_deviceObj_deviceNo").combobox("getData"); 
            if (data.length > 0) {
                $("#deviceItem_deviceObj_deviceNo").combobox("select", data[0].deviceNo);
            }
        }
	});
	$("#deviceItem_deviceCount").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入所需数量',
		invalidMessage : '所需数量输入不对',
	});

	//单击添加按钮
	$("#deviceItemAddButton").click(function () {
		//验证表单 
		if(!$("#deviceItemAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#deviceItemAddForm").form({
			    url:"DeviceItem/add",
			    onSubmit: function(){
					if($("#deviceItemAddForm").form("validate"))  { 
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
                        $("#deviceItemAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#deviceItemAddForm").submit();
		}
	});

	//单击清空按钮
	$("#deviceItemClearButton").click(function () { 
		$("#deviceItemAddForm").form("clear"); 
	});
});
