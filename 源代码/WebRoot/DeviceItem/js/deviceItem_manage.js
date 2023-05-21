var deviceItem_manage_tool = null; 
$(function () { 
	initDeviceItemManageTool(); //建立DeviceItem管理对象
	deviceItem_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#deviceItem_manage").datagrid({
		url : 'DeviceItem/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "deviceItemId",
		sortOrder : "desc",
		toolbar : "#deviceItem_manage_tool",
		columns : [[
			{
				field : "deviceItemId",
				title : "记录id",
				width : 70,
			},
			{
				field : "shiyanObj",
				title : "实验名称",
				width : 140,
			},
			{
				field : "deviceObj",
				title : "所需设备",
				width : 140,
			},
			{
				field : "deviceCount",
				title : "所需数量",
				width : 70,
			},
		]],
	});

	$("#deviceItemEditDiv").dialog({
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
				if ($("#deviceItemEditForm").form("validate")) {
					//验证表单 
					if(!$("#deviceItemEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#deviceItemEditForm").form({
						    url:"DeviceItem/" + $("#deviceItem_deviceItemId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#deviceItemEditDiv").dialog("close");
			                        deviceItem_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#deviceItemEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#deviceItemEditDiv").dialog("close");
				$("#deviceItemEditForm").form("reset"); 
			},
		}],
	});
});

function initDeviceItemManageTool() {
	deviceItem_manage_tool = {
		init: function() {
			$.ajax({
				url : "Shiyan/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#shiyanObj_shiyanId_query").combobox({ 
					    valueField:"shiyanId",
					    textField:"shiyanName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{shiyanId:0,shiyanName:"不限制"});
					$("#shiyanObj_shiyanId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Device/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#deviceObj_deviceNo_query").combobox({ 
					    valueField:"deviceNo",
					    textField:"deviceName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{deviceNo:"",deviceName:"不限制"});
					$("#deviceObj_deviceNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#deviceItem_manage").datagrid("reload");
		},
		redo : function () {
			$("#deviceItem_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#deviceItem_manage").datagrid("options").queryParams;
			queryParams["shiyanObj.shiyanId"] = $("#shiyanObj_shiyanId_query").combobox("getValue");
			queryParams["deviceObj.deviceNo"] = $("#deviceObj_deviceNo_query").combobox("getValue");
			$("#deviceItem_manage").datagrid("options").queryParams=queryParams; 
			$("#deviceItem_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#deviceItemQueryForm").form({
			    url:"DeviceItem/OutToExcel",
			});
			//提交表单
			$("#deviceItemQueryForm").submit();
		},
		remove : function () {
			var rows = $("#deviceItem_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var deviceItemIds = [];
						for (var i = 0; i < rows.length; i ++) {
							deviceItemIds.push(rows[i].deviceItemId);
						}
						$.ajax({
							type : "POST",
							url : "DeviceItem/deletes",
							data : {
								deviceItemIds : deviceItemIds.join(","),
							},
							beforeSend : function () {
								$("#deviceItem_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#deviceItem_manage").datagrid("loaded");
									$("#deviceItem_manage").datagrid("load");
									$("#deviceItem_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#deviceItem_manage").datagrid("loaded");
									$("#deviceItem_manage").datagrid("load");
									$("#deviceItem_manage").datagrid("unselectAll");
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
			var rows = $("#deviceItem_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "DeviceItem/" + rows[0].deviceItemId +  "/update",
					type : "get",
					data : {
						//deviceItemId : rows[0].deviceItemId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (deviceItem, response, status) {
						$.messager.progress("close");
						if (deviceItem) { 
							$("#deviceItemEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
