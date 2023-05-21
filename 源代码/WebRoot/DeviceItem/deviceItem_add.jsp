<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deviceItem.css" />
<div id="deviceItemAddDiv">
	<form id="deviceItemAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">实验名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceItem_shiyanObj_shiyanId" name="deviceItem.shiyanObj.shiyanId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所需设备:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceItem_deviceObj_deviceNo" name="deviceItem.deviceObj.deviceNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">所需数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceItem_deviceCount" name="deviceItem.deviceCount" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="deviceItemAddButton" class="easyui-linkbutton">添加</a>
			<a id="deviceItemClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/DeviceItem/js/deviceItem_add.js"></script> 
