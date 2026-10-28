<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>用户登录</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="UEditor/third-party/jquery-1.10.2.min.js"></script>
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

  <body class="min-h-screen bg-cover bg-center bg-fixed" style="background-image: url('image/bg.png');">
	<%@ include file="header.jsp" %>

	<div class="flex items-center justify-center px-4 py-12">
		<div class="w-full max-w-md">
			<!-- Login Card -->
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-2xl p-8 space-y-8 border border-ios-border">
				<!-- Header -->
				<div class="text-center space-y-2">
					<div class="w-20 h-20 bg-gradient-to-br from-ios-blue to-ios-green rounded-3xl flex items-center justify-center mx-auto shadow-lg">
						<svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
						</svg>
					</div>
					<h2 class="text-3xl font-bold text-ios-text">欢迎回来</h2>
					<p class="text-ios-textSecondary">登录您的账户</p>
				</div>

				<!-- Form -->
				<form onkeyup="submitInput(event)" class="space-y-6">
					<!-- Username Input -->
					<div class="space-y-2">
						<label class="block text-sm font-medium text-ios-text">用户名</label>
						<input type="text" name="username"
							class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary"
							placeholder="请输入用户名">
					</div>

					<!-- Password Input -->
					<div class="space-y-2">
						<label class="block text-sm font-medium text-ios-text">密码</label>
						<input type="password" name="password"
							class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary"
							placeholder="请输入密码">
					</div>

					<!-- Verification Code -->
					<div class="space-y-2">
						<label class="block text-sm font-medium text-ios-text">验证码</label>
						<div class="flex items-stretch space-x-3">
							<input type="text" name="code" maxlength="4"
								class="flex-1 px-4 h-12 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary text-center tracking-widest"
								placeholder="验证码">
							<img src="" id="imgCode" onclick="changeCode()" title="点击刷新验证码"
								class="h-12 w-28 rounded-xl cursor-pointer hover:opacity-80 transition-opacity border border-ios-border">
						</div>
					</div>

					<!-- Submit Button -->
					<button type="button" onclick="ajax()"
						class="w-full py-4 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold text-lg shadow-lg hover:shadow-xl transform hover:scale-[1.02] transition-all duration-200">
						登录
					</button>
				</form>

				<!-- Message -->
				<div id="msg" class="text-center text-red-500 font-medium">${ msg }</div>

				<!-- Footer Info -->
				<div class="pt-6 border-t border-ios-border">
					<p class="text-center text-sm text-ios-textSecondary space-y-2">
						<span class="block">游客角色guest登录(可注册)：guest，1</span>
						<span class="block">普通用户角色user登录：user，user</span>
						<span class="block">管理员角色admin登录：admin，admin</span>
					</p>
				</div>
			</div>

			<!-- Register Link -->
			<div class="mt-6 text-center">
				<p class="text-ios-textSecondary">
					还没有账户？
					<a href="Register" class="text-ios-blue font-semibold hover:underline">立即注册</a>
				</p>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp" %>
  </body>

<script type="text/javascript">

window.onload = changeCode();									//网页转载、后退时，将刷新验证码图片

function changeCode() {											//刷新验证码图片

	var t = (new Date()).getTime();								//将当前时间转换为毫秒
	$("#imgCode").attr("src", "VerifyCodeNumChar?t=" + t);		//【重要】设置属性src的值。添加时间参数为了能刷新图片
	$("[name='code']").val("");									//清空验证码输入框
	$("[name='code']").focus();									//获得焦点，插入光标定位在验证码输入框中
}

function ajax() {												//应用Ajax技术实现登录

	var username 	= $("[name='username']").val();				//根据name获取输入的值
	var password 	= $("[name='password']").val();
	var code 		= $("[name='code']").val();

	var url = "LoginDo";										//【重要】目标地址
	var arg = {	"username" : username, "password" : password,
		   		"code" 	   : code };							//JSON格式数据： {key:value, k2:v2}

	$.post(url, arg, function(data) {							//应用jQuery中的Ajax技术
		setMsg(data);
	});
}

function setMsg(msg) {

	var prefix = "@Redirect:";									//前缀

	if (msg.indexOf(prefix) == 0) {								//如果msg的前面部分是"@Redirect:"
		var url = msg.substring(prefix.length); 				//截取前缀后面的路径名，得到main.jsp
		window.location.href = url;								//网页转向
		return;
	}

	prefix = "@RefreshCode:";									//前缀

	if (msg.indexOf(prefix) == 0) {								//如果msg的前面部分是"@RefreshCode:"
		changeCode();											//刷新验证码
		msg = msg.substring(prefix.length); 					//得到前缀后面的消息内容
	}

	$("#msg").html(msg);										//显示消息
}

function submitInput(event){ 			//执行键盘按键命令

	 if (event.keyCode == 13) {			//回车键是13
	 	ajax();							//提交输入
	 }
}
</script>
</html>