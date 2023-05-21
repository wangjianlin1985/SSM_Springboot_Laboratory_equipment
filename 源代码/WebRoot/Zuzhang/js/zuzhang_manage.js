var zuzhang_manage_tool = null; 
$(function () { 
	initZuzhangManageTool(); //建立Zuzhang管理对象
	zuzhang_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#zuzhang_manage").datagrid({
		url : 'Zuzhang/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "account",
		sortOrder : "desc",
		toolbar : "#zuzhang_manage_tool",
		columns : [[
			{
				field : "account",
				title : "账号",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "gender",
				title : "性别",
				width : 140,
			},
			{
				field : "birthDate",
				title : "出生日期",
				width : 140,
			},
			{
				field : "zuzhangPhoto",
				title : "组长照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "email",
				title : "邮箱",
				width : 140,
			},
			{
				field : "regTime",
				title : "注册时间",
				width : 140,
			},
		]],
	});

	$("#zuzhangEditDiv").dialog({
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
				if ($("#zuzhangEditForm").form("validate")) {
					//验证表单 
					if(!$("#zuzhangEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#zuzhangEditForm").form({
						    url:"Zuzhang/" + $("#zuzhang_account_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#zuzhangEditDiv").dialog("close");
			                        zuzhang_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#zuzhangEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#zuzhangEditDiv").dialog("close");
				$("#zuzhangEditForm").form("reset"); 
			},
		}],
	});
});

function initZuzhangManageTool() {
	zuzhang_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#zuzhang_manage").datagrid("reload");
		},
		redo : function () {
			$("#zuzhang_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#zuzhang_manage").datagrid("options").queryParams;
			queryParams["account"] = $("#account").val();
			queryParams["name"] = $("#name").val();
			queryParams["birthDate"] = $("#birthDate").datebox("getValue"); 
			queryParams["telephone"] = $("#telephone").val();
			$("#zuzhang_manage").datagrid("options").queryParams=queryParams; 
			$("#zuzhang_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#zuzhangQueryForm").form({
			    url:"Zuzhang/OutToExcel",
			});
			//提交表单
			$("#zuzhangQueryForm").submit();
		},
		remove : function () {
			var rows = $("#zuzhang_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var accounts = [];
						for (var i = 0; i < rows.length; i ++) {
							accounts.push(rows[i].account);
						}
						$.ajax({
							type : "POST",
							url : "Zuzhang/deletes",
							data : {
								accounts : accounts.join(","),
							},
							beforeSend : function () {
								$("#zuzhang_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#zuzhang_manage").datagrid("loaded");
									$("#zuzhang_manage").datagrid("load");
									$("#zuzhang_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#zuzhang_manage").datagrid("loaded");
									$("#zuzhang_manage").datagrid("load");
									$("#zuzhang_manage").datagrid("unselectAll");
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
			var rows = $("#zuzhang_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Zuzhang/" + rows[0].account +  "/update",
					type : "get",
					data : {
						//account : rows[0].account,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (zuzhang, response, status) {
						$.messager.progress("close");
						if (zuzhang) { 
							$("#zuzhangEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
