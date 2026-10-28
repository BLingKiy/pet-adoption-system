<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>品种修改</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/UEditor/third-party/jquery-1.10.2.js"></script>
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
			<h1 class="text-3xl font-bold text-ios-text mb-2">✏️ 品种修改</h1>
			<p class="text-ios-textSecondary">编辑品种信息</p>
		</div>

		<c:if test="${ breed != null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<!-- Form Header -->
				<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
					<h2 class="text-white font-bold text-lg">品种信息编辑</h2>
				</div>

				<div class="divide-y divide-ios-border">
					<!-- Breed ID -->
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">品种ID：</div>
						<div class="flex-1 text-ios-text font-mono font-bold">${ breed.breedId }</div>
					</div>

					<!-- Breed Name -->
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">品种名称：</div>
						<div class="flex-1">
							<input type="text" name="breedName" value="${ breed.breedName }" maxlength="45"
								class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
								placeholder="请输入品种名称">
							<span class="text-red-500 text-sm ml-2">*</span>
						</div>
					</div>

					<!-- Breed Description -->
					<div class="flex items-start px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium pt-2">品种描述：</div>
						<div class="flex-1">
							<input type="text" name="breedDesc" value="${ breed.breedDesc }" maxlength="200"
								class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
								placeholder="请输入品种描述">
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
						<a href="BreedShow?breedId=${ breed.breedId }"
							class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							← 返回详情
						</a>
					</div>
				</div>
			</div>
		</c:if>

		<div class="mt-4">
			<a href="BreedList" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
				← 返回品种列表
			</a>
		</div>
	</div>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

	<%@ include file="../footer.jsp" %>
	<script type="text/javascript">

	// 检查jQuery是否加载
	if (typeof jQuery == 'undefined') {
		alert('jQuery未加载，请检查路径！');
	}

	function ajax() {
		console.log("ajax函数被调用");
		var breedName 	= $("[name='breedName']").val();
		var breedDesc 	= $("[name='breedDesc']").val();
		console.log("breedName:", breedName);
		console.log("breedDesc:", breedDesc);

		// 验证必填字段
		if (!breedName || breedName.trim() == "") {
			alert("请输入品种名称！");
			return;
		}

		var url = "BreedEditDo?breedId=${ breed.breedId }";
		var arg = {	"breedName" : breedName, "breedDesc" : breedDesc};
		console.log("发送AJAX请求到:", url);

		$.post(url, arg, function(data) {
			console.log("收到响应:", data);
			setMsg(data);
		}).fail(function(xhr, status, error) {
			alert("提交失败：" + error);
			console.log("Error:", xhr.responseText);
		});
	}

	function setMsg(msg) {

		var prefix = "@Redirect:";

		if (msg.indexOf(prefix) == 0) {
			var url = msg.substring(prefix.length);
			window.location.href = url;
			return;
		}

		// 显示错误信息：弹窗提示
		alert(msg);
		$("#msg").html(msg);
	}
	</script>
  </body>
</html>