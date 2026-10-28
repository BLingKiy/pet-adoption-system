<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>宠物详情</title>
	<script src="https://cdn.tailwindcss.com"></script>
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

	<!-- Navigation -->
	<nav class="bg-white/80 backdrop-blur-md shadow-lg sticky top-0 z-50">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
			<div class="flex justify-between h-16">
				<div class="flex items-center">
					<a href="GuestPetList" class="text-2xl font-bold text-ios-blue">
						🐾 宠物商城
					</a>
				</div>
				<div class="flex items-center space-x-4">
					<a href="GuestPetList" class="px-4 py-2 text-ios-text hover:text-ios-blue font-medium transition-colors">
						🏠 首页
					</a>
					<a href="CartList" class="px-4 py-2 text-ios-text hover:text-ios-blue font-medium transition-colors flex items-center">
						🛒 购物车
					</a>
					<a href="OrderList" class="px-4 py-2 text-ios-text hover:text-ios-blue font-medium transition-colors">
						📋 我的订单
					</a>
					<div class="border-l border-ios-border pl-4 ml-2">
						<c:if test="${ myUser == null }">
							<a href="login.jsp" class="px-4 py-2 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-xl font-medium hover:shadow-lg transition-all duration-200">
								登录 / 注册
							</a>
						</c:if>
						<c:if test="${ myUser != null }">
							<a href="main.jsp" class="px-4 py-2 bg-ios-gray text-ios-text rounded-xl font-medium hover:bg-ios-blueLight transition-colors duration-200">
								返回管理系统
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<a href="GuestPetList" class="inline-flex items-center text-ios-blue hover:text-ios-blueLight transition-colors mb-4">
				← 返回商城
			</a>
			<h1 class="text-3xl font-bold text-ios-text mb-2">🐾 宠物详情</h1>
		</div>

		<c:if test="${ pet != null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<div class="grid grid-cols-1 lg:grid-cols-2">
					<!-- Pet Image -->
					<div class="bg-ios-gray p-8 flex items-center justify-center">
						<c:if test="${ pet.image != null && pet.image != '' }">
							<img src="fileUpload/petImage/${ pet.image }" alt="${ pet.petName }"
								onerror="this.style.display='none'"
								class="w-full max-w-md rounded-3xl object-cover border-4 border-white shadow-2xl">
						</c:if>
						<c:if test="${ pet.image == null || pet.image == '' }">
							<div class="w-64 h-64 bg-ios-grayLight rounded-3xl flex items-center justify-center">
								<span class="text-6xl">🐾</span>
							</div>
						</c:if>
					</div>

					<!-- Pet Info -->
					<div class="p-8">
						<h2 class="text-4xl font-bold text-ios-text mb-6">${ pet.petName }</h2>

						<div class="space-y-4 mb-8">
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">宠物编号</span>
								<span class="text-ios-text font-semibold">${ pet.petNo }</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">品种</span>
								<span class="text-ios-text font-semibold">${ pet.breedName }</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">性别</span>
								<span class="text-ios-text font-semibold">${ pet.gender }</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">年龄</span>
								<span class="text-ios-text font-semibold">${ pet.age }岁</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">体重</span>
								<span class="text-ios-text font-semibold">${ pet.weight }公斤</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">颜色</span>
								<span class="text-ios-text font-semibold">${ pet.color }</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">健康状况</span>
								<span class="text-ios-green font-semibold">${ pet.healthStatus }</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">价格</span>
								<span class="text-ios-green font-bold text-2xl">¥${ pet.price }</span>
							</div>
							<div class="flex items-center justify-between py-3 border-b border-ios-border">
								<span class="text-ios-textSecondary font-medium">登记时间</span>
								<span class="text-ios-text font-semibold">${ pet.timeRegister }</span>
							</div>
						</div>

						<!-- Detail Description -->
						<c:if test="${ pet.detail != null && pet.detail != '' }">
							<div class="mb-8">
								<h3 class="text-xl font-bold text-ios-text mb-3">详细描述</h3>
								<p class="text-ios-text leading-relaxed">${ pet.detail }</p>
							</div>
						</c:if>

						<!-- Action Buttons -->
						<div class="flex space-x-4">
							<a href="CartAdd?petId=${ pet.petId }"
								class="flex-1 px-6 py-4 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold text-lg shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200 text-center">
								🛒 加入购物车
							</a>
							<a href="GuestPetList"
								class="px-6 py-4 bg-ios-gray text-ios-text rounded-2xl font-bold hover:bg-ios-blueLight transition-colors duration-200">
								← 返回商城
							</a>
						</div>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${ pet == null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-24 h-24 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-6">
					<span class="text-5xl">❓</span>
				</div>
				<h2 class="text-2xl font-bold text-ios-text mb-4">宠物不存在</h2>
				<p class="text-ios-textSecondary text-lg mb-6">该宠物可能已被删除或不存在！</p>
				<a href="GuestPetList" class="inline-block px-8 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
					返回商城 →
				</a>
			</div>
		</c:if>
	</div>

	<!-- Footer -->
	<footer class="bg-white shadow-lg mt-12">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
			<div class="text-center text-ios-textSecondary">
				<p>&copy; 2026 姆斯集团 宠物商城 - 让每个家庭都有爱的陪伴</p>
			</div>
		</div>
	</footer>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>
  </body>
</html>