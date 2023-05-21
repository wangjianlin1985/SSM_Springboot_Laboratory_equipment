<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fankui.css" /> 

<div id="fankui_manage"></div>
<div id="fankui_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="fankui_manage_tool.edit();">解决回复</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="fankui_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="fankui_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="fankui_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="fankui_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="fankuiQueryForm" method="post">
			反馈标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			反馈组长：<input class="textbox" type="text" id="zuzhangObj_account_query" name="zuzhangObj.account" style="width: auto"/>
			反馈时间：<input type="text" id="fankuiTime" name="fankuiTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="fankui_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="fankuiEditDiv">
	<form id="fankuiEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">反馈id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fankui_fankuiId_edit" name="fankui.fankuiId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">反馈标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fankui_title_edit" name="fankui.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">反馈内容:</span>
			<span class="inputControl">
				<script name="fankui.content" id="fankui_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">反馈组长:</span>
			<span class="inputControl">
				<input class="textbox"  id="fankui_zuzhangObj_account_edit" name="fankui.zuzhangObj.account" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">反馈时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fankui_fankuiTime_edit" name="fankui.fankuiTime" />

			</span>

		</div>
		<div>
			<span class="label">解决措施:</span>
			<span class="inputControl">
				<textarea id="fankui_jjcs_edit" name="fankui.jjcs" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var fankui_content_editor = UE.getEditor('fankui_content_edit'); //反馈内容编辑器
</script>
<script type="text/javascript" src="Fankui/js/fankui_manage.js"></script> 
