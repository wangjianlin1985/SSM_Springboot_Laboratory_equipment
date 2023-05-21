<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deviceItem.css" /> 

<div id="deviceItem_manage"></div>
<div id="deviceItem_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="deviceItem_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="deviceItem_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="deviceItem_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="deviceItem_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="deviceItem_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="deviceItemQueryForm" method="post">
			实验名称：<input class="textbox" type="text" id="shiyanObj_shiyanId_query" name="shiyanObj.shiyanId" style="width: auto"/>
			所需设备：<input class="textbox" type="text" id="deviceObj_deviceNo_query" name="deviceObj.deviceNo" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="deviceItem_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="deviceItemEditDiv">
	<form id="deviceItemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceItem_deviceItemId_edit" name="deviceItem.deviceItemId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">实验名称:</span>
			<span class="inputControl">
				<input class="textbox"  id="deviceItem_shiyanObj_shiyanId_edit" name="deviceItem.shiyanObj.shiyanId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所需设备:</span>
			<span class="inputControl">
				<input class="textbox"  id="deviceItem_deviceObj_deviceNo_edit" name="deviceItem.deviceObj.deviceNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所需数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceItem_deviceCount_edit" name="deviceItem.deviceCount" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="DeviceItem/js/deviceItem_manage.js"></script> 
