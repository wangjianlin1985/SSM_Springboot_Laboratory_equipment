var deviceClass_manage_tool = null; 
$(function () { 
	initDeviceClassManageTool(); //建立DeviceClass管理对象
	deviceClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#deviceClass_manage").datagrid({
		url : 'DeviceClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "deviceClassId",
		sortOrder : "desc",
		toolbar : "#deviceClass_manage_tool",
		columns : [[
			{
				field : "deviceClassId",
				title : "设备类别id",
				width : 70,
			},
			{
				field : "deviceClassName",
				title : "设备类别名称",
				width : 140,
			},
		]],
	});

	$("#deviceClassEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#deviceClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#deviceClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#deviceClassEditForm").form({
						    url:"DeviceClass/" + $("#deviceClass_deviceClassId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#deviceClassEditDiv").dialog("close");
			                        deviceClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#deviceClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#deviceClassEditDiv").dialog("close");
				$("#deviceClassEditForm").form("reset"); 
			},
		}],
	});
});

function initDeviceClassManageTool() {
	deviceClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#deviceClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#deviceClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#deviceClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#deviceClassQueryForm").form({
			    url:"DeviceClass/OutToExcel",
			});
			//提交表单
			$("#deviceClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#deviceClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var deviceClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							deviceClassIds.push(rows[i].deviceClassId);
						}
						$.ajax({
							type : "POST",
							url : "DeviceClass/deletes",
							data : {
								deviceClassIds : deviceClassIds.join(","),
							},
							beforeSend : function () {
								$("#deviceClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#deviceClass_manage").datagrid("loaded");
									$("#deviceClass_manage").datagrid("load");
									$("#deviceClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#deviceClass_manage").datagrid("loaded");
									$("#deviceClass_manage").datagrid("load");
									$("#deviceClass_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#deviceClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "DeviceClass/" + rows[0].deviceClassId +  "/update",
					type : "get",
					data : {
						//deviceClassId : rows[0].deviceClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (deviceClass, response, status) {
						$.messager.progress("close");
						if (deviceClass) { 
							$("#deviceClassEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
