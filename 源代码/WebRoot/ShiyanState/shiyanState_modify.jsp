<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shiyanState.css" />
<div id="shiyanState_editDiv">
	<form id="shiyanStateEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">实验状态id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shiyanState_shiyanStateId_edit" name="shiyanState.shiyanStateId" value="<%=request.getParameter("shiyanStateId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">实验状态名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shiyanState_shiyanStateName_edit" name="shiyanState.shiyanStateName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="shiyanStateModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ShiyanState/js/shiyanState_modify.js"></script> 
