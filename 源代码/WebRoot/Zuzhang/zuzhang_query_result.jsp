<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zuzhang.css" /> 

<div id="zuzhang_manage"></div>
<div id="zuzhang_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="zuzhang_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="zuzhang_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="zuzhang_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="zuzhang_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="zuzhang_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="zuzhangQueryForm" method="post">
			账号：<input type="text" class="textbox" id="account" name="account" style="width:110px" />
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="zuzhang_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="zuzhangEditDiv">
	<form id="zuzhangEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_account_edit" name="zuzhang.account" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_password_edit" name="zuzhang.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_name_edit" name="zuzhang.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_gender_edit" name="zuzhang.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_birthDate_edit" name="zuzhang.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">组长照片:</span>
			<span class="inputControl">
				<img id="zuzhang_zuzhangPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="zuzhang_zuzhangPhoto" name="zuzhang.zuzhangPhoto"/>
				<input id="zuzhangPhotoFile" name="zuzhangPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_telephone_edit" name="zuzhang.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_email_edit" name="zuzhang.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_address_edit" name="zuzhang.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">注册时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_regTime_edit" name="zuzhang.regTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Zuzhang/js/zuzhang_manage.js"></script> 
