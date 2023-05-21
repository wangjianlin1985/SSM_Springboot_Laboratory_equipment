var fankui_manage_tool = null; 
$(function () { 
	initFankuiManageTool(); //建立Fankui管理对象
	fankui_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#fankui_manage").datagrid({
		url : 'Fankui/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "fankuiId",
		sortOrder : "desc",
		toolbar : "#fankui_manage_tool",
		columns : [[
			{
				field : "fankuiId",
				title : "反馈id",
				width : 70,
			},
			{
				field : "title",
				title : "反馈标题",
				width : 140,
			},
			{
				field : "zuzhangObj",
				title : "反馈组长",
				width : 140,
			},
			{
				field : "fankuiTime",
				title : "反馈时间",
				width : 140,
			},
			/*
			{
				field : "jjcs",
				title : "解决措施",
				width : 140,
			},*/
		]],
	});

	$("#fankuiEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#fankuiEditForm").form("validate")) {
					//验证表单 
					if(!$("#fankuiEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#fankuiEditForm").form({
						    url:"Fankui/" + $("#fankui_fankuiId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#fankuiEditForm").form("validate"))  {
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
			                        $("#fankuiEditDiv").dialog("close");
			                        fankui_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#fankuiEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#fankuiEditDiv").dialog("close");
				$("#fankuiEditForm").form("reset"); 
			},
		}],
	});
});

function initFankuiManageTool() {
	fankui_manage_tool = {
		init: function() {
			$.ajax({
				url : "Zuzhang/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#zuzhangObj_account_query").combobox({ 
					    valueField:"account",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{account:"",name:"不限制"});
					$("#zuzhangObj_account_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#fankui_manage").datagrid("reload");
		},
		redo : function () {
			$("#fankui_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#fankui_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["zuzhangObj.account"] = $("#zuzhangObj_account_query").combobox("getValue");
			queryParams["fankuiTime"] = $("#fankuiTime").datebox("getValue"); 
			$("#fankui_manage").datagrid("options").queryParams=queryParams; 
			$("#fankui_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#fankuiQueryForm").form({
			    url:"Fankui/OutToExcel",
			});
			//提交表单
			$("#fankuiQueryForm").submit();
		},
		remove : function () {
			var rows = $("#fankui_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var fankuiIds = [];
						for (var i = 0; i < rows.length; i ++) {
							fankuiIds.push(rows[i].fankuiId);
						}
						$.ajax({
							type : "POST",
							url : "Fankui/deletes",
							data : {
								fankuiIds : fankuiIds.join(","),
							},
							beforeSend : function () {
								$("#fankui_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#fankui_manage").datagrid("loaded");
									$("#fankui_manage").datagrid("load");
									$("#fankui_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#fankui_manage").datagrid("loaded");
									$("#fankui_manage").datagrid("load");
									$("#fankui_manage").datagrid("unselectAll");
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
			var rows = $("#fankui_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Fankui/" + rows[0].fankuiId +  "/update",
					type : "get",
					data : {
						//fankuiId : rows[0].fankuiId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (fankui, response, status) {
						$.messager.progress("close");
						if (fankui) { 
							$("#fankuiEditDiv").dialog("open");
							$("#fankui_fankuiId_edit").val(fankui.fankuiId);
							$("#fankui_fankuiId_edit").validatebox({
								required : true,
								missingMessage : "请输入反馈id",
								editable: false
							});
							$("#fankui_title_edit").val(fankui.title);
							$("#fankui_title_edit").validatebox({
								required : true,
								missingMessage : "请输入反馈标题",
							});
							fankui_content_editor.setContent(fankui.content, false);
							$("#fankui_zuzhangObj_account_edit").combobox({
								url:"Zuzhang/listAll",
							    valueField:"account",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#fankui_zuzhangObj_account_edit").combobox("select", fankui.zuzhangObjPri);
									//var data = $("#fankui_zuzhangObj_account_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#fankui_zuzhangObj_account_edit").combobox("select", data[0].account);
						            //}
								}
							});
							$("#fankui_fankuiTime_edit").datetimebox({
								value: fankui.fankuiTime,
							    required: true,
							    showSeconds: true,
							});
							$("#fankui_jjcs_edit").val(fankui.jjcs);
							$("#fankui_jjcs_edit").validatebox({
								required : true,
								missingMessage : "请输入解决措施",
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
