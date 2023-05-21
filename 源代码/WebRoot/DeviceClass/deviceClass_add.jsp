<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/deviceClass.css" />
<div id="deviceClassAddDiv">
	<form id="deviceClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">设备类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="deviceClass_deviceClassName" name="deviceClass.deviceClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="deviceClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="deviceClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/DeviceClass/js/deviceClass_add.js"></script> 
