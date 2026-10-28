<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<header class="bg-gradient-to-r from-ios-blueLight to-ios-greenLight backdrop-blur-lg border-b border-ios-border sticky top-0 z-50 shadow-sm">
	<div class="max-w-6xl mx-auto px-6 py-4">
		<div class="flex items-center justify-between">
			<!-- Logo and Title -->
			<div class="flex items-center space-x-4">
				<div class="w-12 h-12 bg-gradient-to-br from-ios-blue to-ios-green rounded-2xl flex items-center justify-center shadow-lg">
					<svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
					</svg>
				</div>
				<h1 class="text-2xl font-bold bg-gradient-to-r from-ios-blue to-ios-green bg-clip-text text-transparent">
					宠物管理系统
				</h1>
			</div>

			<!-- Navigation -->
			<c:if test="${ myUser.role == null }">
				<nav class="flex items-center space-x-2">
					<a href='GuestPetList' class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						宠物列表
					</a>
					<a href="login.jsp" class="px-5 py-2 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
						用户登录
					</a>
					<a href="Register" class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						用户注册
					</a>
				</nav>
			</c:if>

			<c:if test="${ myUser.role == 'guest' }">
				<nav class="flex items-center space-x-2">
					<div class="flex items-center space-x-2 px-4 py-2 bg-white/60 rounded-2xl border border-ios-border">
						<div class="w-8 h-8 bg-gradient-to-br from-ios-blue to-ios-green rounded-full flex items-center justify-center">
							<span class="text-white text-sm font-bold">${ myUser.username.charAt(0) }</span>
						</div>
						<span class="text-ios-text font-medium">${ myUser.username }</span>
					</div>
					<a href='PetList' class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						宠物列表
					</a>
					<a href="main.jsp" class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						用户功能
					</a>
					<a href="Logout" class="px-4 py-2 text-red-500 hover:bg-red-50 rounded-xl transition-all duration-200 font-medium">
						退出
					</a>
				</nav>
			</c:if>

			<c:if test="${ myUser.role == 'admin' || myUser.role == 'user'}">
				<nav class="flex items-center space-x-2">
					<div class="flex items-center space-x-2 px-4 py-2 bg-white/60 rounded-2xl border border-ios-border">
						<div class="w-8 h-8 bg-gradient-to-br from-ios-blue to-ios-green rounded-full flex items-center justify-center">
							<span class="text-white text-sm font-bold">${ myUser.username.charAt(0) }</span>
						</div>
						<span class="text-ios-text font-medium">${ myUser.username }</span>
					</div>
					<div class="h-6 w-px bg-ios-border"></div>
					<a href='PetList' class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						宠物
					</a>
					<a href='BreedList' class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						品种
					</a>
					<a href="main.jsp" class="px-4 py-2 text-ios-text hover:bg-white/50 rounded-xl transition-all duration-200 font-medium">
						用户功能
					</a>
					<a href="Logout" class="px-4 py-2 text-red-500 hover:bg-red-50 rounded-xl transition-all duration-200 font-medium">
						退出
					</a>
				</nav>
			</c:if>
		</div>
	</div>
</header>