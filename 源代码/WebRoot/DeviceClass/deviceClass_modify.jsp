<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deviceClass.css" />
<div id="deviceClass_editDiv">
	<form id="deviceClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">设备类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceClass_deviceClassId_edit" name="deviceClass.deviceClassId" value="<%=request.getParameter("deviceClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">设备类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceClass_deviceClassName_edit" name="deviceClass.deviceClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="deviceClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/DeviceClass/js/deviceClass_modify.js"></script> 
