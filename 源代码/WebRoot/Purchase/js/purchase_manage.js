var purchase_manage_tool = null; 
$(function () { 
	initPurchaseManageTool(); //建立Purchase管理对象
	purchase_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#purchase_manage").datagrid({
		url : 'Purchase/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "purchaseId",
		sortOrder : "desc",
		toolbar : "#purchase_manage_tool",
		columns : [[
			{
				field : "purchaseId",
				title : "采购id",
				width : 70,
			},
			{
				field : "deviceObj",
				title : "采购设备",
				width : 140,
			},
			{
				field : "supplier",
				title : "供应商",
				width : 140,
			},
			{
				field : "purchaseCount",
				title : "采购数量",
				width : 70,
			},
			{
				field : "price",
				title : "采购单价",
				width : 70,
			},
			{
				field : "purchaseDate",
				title : "采购日期",
				width : 140,
			},
			{
				field : "userObj",
				title : "采购人",
				width : 140,
			},
		]],
	});

	$("#purchaseEditDiv").dialog({
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
				if ($("#purchaseEditForm").form("validate")) {
					//验证表单 
					if(!$("#purchaseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#purchaseEditForm").form({
						    url:"Purchase/" + $("#purchase_purchaseId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#purchaseEditForm").form("validate"))  {
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
			                        $("#purchaseEditDiv").dialog("close");
			                        purchase_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#purchaseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#purchaseEditDiv").dialog("close");
				$("#purchaseEditForm").form("reset"); 
			},
		}],
	});
});

function initPurchaseManageTool() {
	purchase_manage_tool = {
		init: function() {
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
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#purchase_manage").datagrid("reload");
		},
		redo : function () {
			$("#purchase_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#purchase_manage").datagrid("options").queryParams;
			queryParams["deviceObj.deviceNo"] = $("#deviceObj_deviceNo_query").combobox("getValue");
			queryParams["supplier"] = $("#supplier").val();
			queryParams["purchaseDate"] = $("#purchaseDate").datebox("getValue"); 
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#purchase_manage").datagrid("options").queryParams=queryParams; 
			$("#purchase_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#purchaseQueryForm").form({
			    url:"Purchase/OutToExcel",
			});
			//提交表单
			$("#purchaseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#purchase_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var purchaseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							purchaseIds.push(rows[i].purchaseId);
						}
						$.ajax({
							type : "POST",
							url : "Purchase/deletes",
							data : {
								purchaseIds : purchaseIds.join(","),
							},
							beforeSend : function () {
								$("#purchase_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#purchase_manage").datagrid("loaded");
									$("#purchase_manage").datagrid("load");
									$("#purchase_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#purchase_manage").datagrid("loaded");
									$("#purchase_manage").datagrid("load");
									$("#purchase_manage").datagrid("unselectAll");
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
			var rows = $("#purchase_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Purchase/" + rows[0].purchaseId +  "/update",
					type : "get",
					data : {
						//purchaseId : rows[0].purchaseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (purchase, response, status) {
						$.messager.progress("close");
						if (purchase) { 
							$("#purchaseEditDiv").dialog("open");
							$("#purchase_purchaseId_edit").val(purchase.purchaseId);
							$("#purchase_purchaseId_edit").validatebox({
								required : true,
								missingMessage : "请输入采购id",
								editable: false
							});
							$("#purchase_deviceObj_deviceNo_edit").combobox({
								url:"Device/listAll",
							    valueField:"deviceNo",
							    textField:"deviceName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#purchase_deviceObj_deviceNo_edit").combobox("select", purchase.deviceObjPri);
									//var data = $("#purchase_deviceObj_deviceNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#purchase_deviceObj_deviceNo_edit").combobox("select", data[0].deviceNo);
						            //}
								}
							});
							$("#purchase_supplier_edit").val(purchase.supplier);
							$("#purchase_supplier_edit").validatebox({
								required : true,
								missingMessage : "请输入供应商",
							});
							$("#purchase_purchaseCount_edit").val(purchase.purchaseCount);
							$("#purchase_purchaseCount_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入采购数量",
								invalidMessage : "采购数量输入不对",
							});
							$("#purchase_price_edit").val(purchase.price);
							$("#purchase_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入采购单价",
								invalidMessage : "采购单价输入不对",
							});
							$("#purchase_purchaseDate_edit").datebox({
								value: purchase.purchaseDate,
							    required: true,
							    showSeconds: true,
							});
							$("#purchase_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#purchase_userObj_user_name_edit").combobox("select", purchase.userObjPri);
									//var data = $("#purchase_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#purchase_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#purchase_purchaseMemo_edit").val(purchase.purchaseMemo);
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
