<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>用户新添</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<script type="text/javascript" src="../UEditor/third-party/jquery-1.10.2.min.js"></script>
	<script>
		tailwind.config = {
			theme: {
				extend: {
					colors: {
						ios: {
							blue: '#007AFF',
							blueLight: '#E3F2FD',
							green: '#34C759',
							greenLight: '#E8F5E9',
							gray: '#F2F2F7',
							grayLight: '#FAFAFA',
							text: '#1C1C1E',
							textSecondary: '#8E8E93',
							border: '#E5E5EA',
							background: '#FFFFFF',
							shadow: 'rgba(0, 0, 0, 0.08)'
						}
					}
				}
			}
		}
	</script>
  </head>
  <body class="min-h-screen bg-cover bg-center bg-fixed" style="background-image: url('../image/bg.png');">
	<%@ include file="../header.jsp" %>

	<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<h1 class="text-3xl font-bold text-ios-text mb-2">➕ 用户新添</h1>
			<p class="text-ios-textSecondary">添加新用户信息</p>
		</div>

		<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
			<!-- Form Header -->
			<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
				<h2 class="text-white font-bold text-lg">用户信息录入</h2>
			</div>

			<div class="divide-y divide-ios-border">
				<!-- Username -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">用户名：</div>
					<div class="flex-1">
						<input type="text" name="username" maxlength="45"
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入用户名">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Password -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">密码：</div>
					<div class="flex-1">
						<input type="password" name="password" maxlength="45"
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入密码">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Password2 -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">确认密码：</div>
					<div class="flex-1">
						<input type="password" name="password2" maxlength="45"
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请再次输入密码">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Real Name -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">真实姓名：</div>
					<div class="flex-1">
						<input type="text" name="realName" maxlength="45"
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入真实姓名">
					</div>
				</div>

				<!-- Role -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">角色级别：</div>
					<div class="flex-1 flex items-center space-x-4">
						<label class="flex items-center space-x-2 cursor-pointer">
							<input type="radio" name="role" value="guest" class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
							<span class="text-ios-text">guest</span>
						</label>
						<label class="flex items-center space-x-2 cursor-pointer">
							<input type="radio" name="role" value="user" class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
							<span class="text-ios-text">user</span>
						</label>
						<label class="flex items-center space-x-2 cursor-pointer">
							<input type="radio" name="role" value="admin" class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
							<span class="text-ios-text">admin</span>
						</label>
						<span class="text-red-500 text-sm">*</span>
					</div>
				</div>
			</div>

			<!-- Action Buttons -->
			<div class="bg-ios-gray px-6 py-4">
				<div class="flex items-center justify-between">
					<div class="flex space-x-3">
						<input type="button" value="提交" onclick="ajax()"
							class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200 cursor-pointer">
					</div>
					<a href="UserList"
						class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
						← 返回列表
					</a>
				</div>
			</div>
		</div>
	</div>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

	<%@ include file="../footer.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/UEditor/third-party/jquery-1.10.2.js"></script>
	<script type="text/javascript">

	// 检查jQuery是否加载
	if (typeof jQuery == 'undefined') {
		alert('jQuery未加载，请检查路径！');
	}

	function ajax() {
		console.log('ajax函数被调用');
		var username 	= $("[name='username']").val();			//根据name获取输入的值
		var password 	= $("[name='password']").val();
		var password2 	= $("[name='password2']").val();
		var realName 	= $("[name='realName']").val();

		var role 		= $("[name='role']:checked").val();		//获取被勾选单选按钮的值。复选框的处理方法类似

		// 验证必填字段
		if (!username || username.trim() == "") {
			alert("请输入用户名！");
			return;
		}
		if (!password || password.trim() == "") {
			alert("请输入密码！");
			return;
		}
		if (!password2 || password2.trim() == "") {
			alert("请输入确认密码！");
			return;
		}
		if (!role) {
			alert("请选择角色级别！");
			return;
		}

		var url = "UserAddDo";									//****目标地址
		var arg = {	"username" 	: username, 	"password" : password,
			   	"password2" : password2,  	"realName" : realName,
			   	"role"   	: role};						//JSON格式数据： {key:value, k2:v2}

		$.post(url, arg, function(data) {
			setMsg(data);
		}).fail(function(xhr, status, error) {
			alert("提交失败：" + error);
			console.log("Error:", xhr.responseText);
		});
	}

	function setMsg(msg) {

		var prefix = "@Redirect:";								//前缀

		if (msg.indexOf(prefix) == 0) {							//如果msg的前面部分是"@Redirect:"
			var url = msg.substring(prefix.length); 			//截取前缀后面的路径名
			window.location.href = url;							//网页转向
			return;
		}

		// 显示错误信息：弹窗提示
		alert(msg);
		$("#msg").html(msg);									//显示内容
	}
	</script>
  </body>
</html>