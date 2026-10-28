<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>用户功能</title>
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

  <body class="min-h-screen bg-cover bg-center bg-fixed" style="background-image: url('image/bg.png');">
	<%@ include file="header.jsp" %>

	<div class="max-w-4xl mx-auto px-6 py-12">
		<!-- Page Header -->
		<div class="text-center mb-12">
			<div class="w-20 h-20 bg-gradient-to-br from-ios-blue to-ios-green rounded-3xl flex items-center justify-center mx-auto shadow-lg mb-4">
				<svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
				</svg>
			</div>
			<h1 class="text-3xl font-bold text-ios-text mb-2">用户功能</h1>
			<p class="text-ios-textSecondary">选择您需要的功能</p>
		</div>

		<c:if test="${ myUser == null }">
			<c:redirect url="login.jsp"></c:redirect>
		</c:if>

		<!-- Function Cards Grid -->
		<div class="grid grid-cols-1 md:grid-cols-2 gap-6">

			<!-- Login Functions Card -->
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border hover:shadow-xl transition-shadow duration-300">
				<div class="flex items-center space-x-4 mb-6">
					<div class="w-12 h-12 bg-gradient-to-br from-ios-blue to-ios-blueLight rounded-2xl flex items-center justify-center shadow-md">
						<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
						</svg>
					</div>
					<h3 class="text-xl font-bold text-ios-text">登录相关</h3>
				</div>
				<div class="space-y-3">
					<a href="UserShow?userId=${ myUser.userId }" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-blueLight transition-colors duration-200 group">
						<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
						</svg>
						<span class="text-ios-text font-medium">个人信息</span>
					</a>
					<a href="Logout" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-red-50 transition-colors duration-200 group">
						<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
						</svg>
						<span class="text-ios-text font-medium group-hover:text-red-500">退出登录</span>
					</a>
				</div>
			</div>

			<!-- Guest Order Management Card -->
			<c:if test="${ myUser.role == 'guest'}">
				<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border hover:shadow-xl transition-shadow duration-300">
					<div class="flex items-center space-x-4 mb-6">
						<div class="w-12 h-12 bg-gradient-to-br from-ios-green to-ios-greenLight rounded-2xl flex items-center justify-center shadow-md">
							<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
							</svg>
						</div>
						<h3 class="text-xl font-bold text-ios-text">订单管理</h3>
					</div>
					<div class="space-y-3">
						<a href="GuestPetList" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-greenLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
							</svg>
							<span class="text-ios-text font-medium">宠物商城</span>
						</a>
						<a href="CartList" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-greenLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
							</svg>
							<span class="text-ios-text font-medium">购物车</span>
						</a>
						<a href="OrderList" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-greenLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
							</svg>
							<span class="text-ios-text font-medium">订单列表</span>
						</a>
					</div>
				</div>
			</c:if>

			<!-- Pet Management Card -->
			<c:if test="${ myUser.role == 'admin' || myUser.role == 'user'}">
				<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border hover:shadow-xl transition-shadow duration-300">
					<div class="flex items-center space-x-4 mb-6">
						<div class="w-12 h-12 bg-gradient-to-br from-ios-blue to-ios-blueLight rounded-2xl flex items-center justify-center shadow-md">
							<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
							</svg>
						</div>
						<h3 class="text-xl font-bold text-ios-text">宠物管理</h3>
					</div>
					<div class="space-y-3">
						<a href="PetList" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-blueLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"></path>
							</svg>
							<span class="text-ios-text font-medium">宠物列表</span>
						</a>
						<a href="PetAdd" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-blueLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
							</svg>
							<span class="text-ios-text font-medium">宠物新添</span>
						</a>
					</div>
				</div>
			</c:if>

			<!-- Order Management Card -->
			<c:if test="${ myUser.role == 'admin' || myUser.role == 'user'}">
				<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border hover:shadow-xl transition-shadow duration-300">
					<div class="flex items-center space-x-4 mb-6">
						<div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-purple-100 rounded-2xl flex items-center justify-center shadow-md">
							<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path>
							</svg>
						</div>
						<h3 class="text-xl font-bold text-ios-text">订单管理</h3>
					</div>
					<div class="space-y-3">
						<a href="OrderManage" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-purple-50 transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"></path>
							</svg>
							<span class="text-ios-text font-medium">订单列表</span>
						</a>
					</div>
				</div>
			</c:if>

			<!-- Breed Management Card -->
			<c:if test="${ myUser.role == 'admin' || myUser.role == 'user'}">
				<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border hover:shadow-xl transition-shadow duration-300">
					<div class="flex items-center space-x-4 mb-6">
						<div class="w-12 h-12 bg-gradient-to-br from-ios-green to-ios-greenLight rounded-2xl flex items-center justify-center shadow-md">
							<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path>
							</svg>
						</div>
						<h3 class="text-xl font-bold text-ios-text">品种管理</h3>
					</div>
					<div class="space-y-3">
						<a href="BreedList" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-greenLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"></path>
							</svg>
							<span class="text-ios-text font-medium">品种列表</span>
						</a>
						<a href="BreedAdd" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-ios-greenLight transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
							</svg>
							<span class="text-ios-text font-medium">品种新添</span>
						</a>
					</div>
				</div>
			</c:if>

			<!-- User Management Card (Admin Only) -->
			<c:if test="${ myUser.role == 'admin' }">
				<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border hover:shadow-xl transition-shadow duration-300">
					<div class="flex items-center space-x-4 mb-6">
						<div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-purple-100 rounded-2xl flex items-center justify-center shadow-md">
							<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
							</svg>
						</div>
						<h3 class="text-xl font-bold text-ios-text">用户管理</h3>
					</div>
					<div class="space-y-3">
						<a href="UserList" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-purple-50 transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 10h16M4 14h16M4 18h16"></path>
							</svg>
							<span class="text-ios-text font-medium">用户列表</span>
						</a>
						<a href="UserAdd" class="flex items-center space-x-3 px-4 py-3 bg-ios-gray rounded-2xl hover:bg-purple-50 transition-colors duration-200 group">
							<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
								<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
							</svg>
							<span class="text-ios-text font-medium">用户新添</span>
						</a>
					</div>
				</div>
			</c:if>

		</div>
	</div>

	<%@ include file="footer.jsp" %>
  </body>
</html>