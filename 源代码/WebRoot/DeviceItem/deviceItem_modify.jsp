<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deviceItem.css" />
<div id="deviceItem_editDiv">
	<form id="deviceItemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceItem_deviceItemId_edit" name="deviceItem.deviceItemId" value="<%=request.getParameter("deviceItemId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="deviceItemModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/DeviceItem/js/deviceItem_modify.js"></script> 
