<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/purchase.css" /> 

<div id="purchase_manage"></div>
<div id="purchase_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="purchase_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="purchase_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="purchase_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="purchase_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="purchase_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="purchaseQueryForm" method="post">
			采购设备：<input class="textbox" type="text" id="deviceObj_deviceNo_query" name="deviceObj.deviceNo" style="width: auto"/>
			供应商：<input type="text" class="textbox" id="supplier" name="supplier" style="width:110px" />
			采购日期：<input type="text" id="purchaseDate" name="purchaseDate" class="easyui-datebox" editable="false" style="width:100px">
			采购人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="purchase_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="purchaseEditDiv">
	<form id="purchaseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">采购id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseId_edit" name="purchase.purchaseId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">采购设备:</span>
			<span class="inputControl">
				<input class="textbox"  id="purchase_deviceObj_deviceNo_edit" name="purchase.deviceObj.deviceNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">供应商:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_supplier_edit" name="purchase.supplier" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">采购数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseCount_edit" name="purchase.purchaseCount" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">采购单价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_price_edit" name="purchase.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">采购日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="purchase_purchaseDate_edit" name="purchase.purchaseDate" />

			</span>

		</div>
		<div>
			<span class="label">采购人:</span>
			<span class="inputControl">
				<input class="textbox"  id="purchase_userObj_user_name_edit" name="purchase.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">采购备注:</span>
			<span class="inputControl">
				<textarea id="purchase_purchaseMemo_edit" name="purchase.purchaseMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Purchase/js/purchase_manage.js"></script> 
