<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zuzhang.css" />
<div id="zuzhang_editDiv">
	<form id="zuzhangEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_account_edit" name="zuzhang.account" value="<%=request.getParameter("account") %>" style="width:200px" />
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
		<div class="operation">
			<a id="zuzhangModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Zuzhang/js/zuzhang_modify.js"></script> 
