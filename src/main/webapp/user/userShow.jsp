<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>用户详情</title>
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
	<%@ include file="../header.jsp" %>

	<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<h1 class="text-3xl font-bold text-ios-text mb-2">👤 用户详情</h1>
			<p class="text-ios-textSecondary">查看用户信息</p>
		</div>

		<c:if test="${ user != null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<!-- Table Header -->
				<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
					<h2 class="text-white font-bold text-lg">用户信息</h2>
				</div>

				<!-- Table -->
				<div class="divide-y divide-ios-border">
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-32 text-ios-textSecondary font-medium">用户名</div>
						<div class="flex-1 text-ios-text font-bold">${ user.username }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-32 text-ios-textSecondary font-medium">真实姓名</div>
						<div class="flex-1 text-ios-text">${ user.realName }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-32 text-ios-textSecondary font-medium">角色级别</div>
						<div class="flex-1">
							<c:choose>
								<c:when test="${ user.role == 'admin' }">
									<span class="px-3 py-1 bg-purple-500 text-white rounded-full text-sm font-bold">管理员</span>
								</c:when>
								<c:when test="${ user.role == 'user' }">
									<span class="px-3 py-1 bg-ios-blue text-white rounded-full text-sm font-bold">用户</span>
								</c:when>
								<c:when test="${ user.role == 'guest' }">
									<span class="px-3 py-1 bg-ios-gray text-ios-text rounded-full text-sm font-bold">游客</span>
								</c:when>
								<c:otherwise>
									<span class="px-3 py-1 bg-gray-300 text-gray-700 rounded-full text-sm font-bold">${ user.role }</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-32 text-ios-textSecondary font-medium">更新时间</div>
						<div class="flex-1 text-ios-text">${ user.timeRenew }</div>
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="bg-ios-gray px-6 py-4 border-t border-ios-border">
					<div class="flex items-center justify-between">
						<div class="flex space-x-3">
							<a href="UserEdit?userId=${ user.userId }"
								class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
								✏️ 修改
							</a>
							<c:if test="${ myUser.role == 'admin' }">
								<a href="UserDeleteDo?userId=${ user.userId }"
									onclick="return confirm('确定要删除该用户吗？');"
									class="px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
									🗑️ 删除
								</a>
							</c:if>
						</div>
						<c:if test="${ myUser.role == 'admin' }">
							<a href="UserList" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
								← 返回用户列表
							</a>
						</c:if>
						<c:if test="${ myUser.role != 'admin' }">
							<a href="main.jsp" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
								← 返回用户功能页
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${ user == null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-20 h-20 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-4">
					<span class="text-4xl">👤</span>
				</div>
				<p class="text-ios-textSecondary text-lg font-medium">用户不存在</p>
			</div>
		</c:if>
	</div>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

	<%@ include file="../footer.jsp" %>
  </body>
</html>
