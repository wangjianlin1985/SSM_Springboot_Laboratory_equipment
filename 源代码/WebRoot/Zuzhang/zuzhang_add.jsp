<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zuzhang.css" />
<div id="zuzhangAddDiv">
	<form id="zuzhangAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_account" name="zuzhang.account" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_password" name="zuzhang.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_name" name="zuzhang.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_gender" name="zuzhang.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_birthDate" name="zuzhang.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">组长照片:</span>
			<span class="inputControl">
				<input id="zuzhangPhotoFile" name="zuzhangPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_telephone" name="zuzhang.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">邮箱:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_email" name="zuzhang.email" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_address" name="zuzhang.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">注册时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zuzhang_regTime" name="zuzhang.regTime" />

			</span>

		</div>
		<div class="operation">
			<a id="zuzhangAddButton" class="easyui-linkbutton">添加</a>
			<a id="zuzhangClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Zuzhang/js/zuzhang_add.js"></script> 
