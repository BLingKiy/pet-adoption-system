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
	<%@ include file="../header.jsp" %>

	<div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<h1 class="text-3xl font-bold text-ios-text mb-2">🐾 宠物详情</h1>
			<p class="text-ios-textSecondary">查看宠物详细信息</p>
		</div>

		<c:if test="${ pet != null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<!-- Table Header -->
				<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
					<h2 class="text-white font-bold text-lg">宠物信息</h2>
				</div>

				<!-- Pet Image -->
				<div class="bg-ios-gray px-6 py-4">
					<div class="flex items-center space-x-4">
						<div class="w-32 text-ios-textSecondary font-medium">宠物图片：</div>
						<div>
							<c:if test="${ pet.image != null && pet.image != '' }">
								<img src="fileUpload/petImage/${ pet.image }" alt="宠物图片" class="w-48 h-48 rounded-2xl object-cover border-2 border-ios-border">
							</c:if>
							<c:if test="${ pet.image == null || pet.image == '' }">
								<div class="w-48 h-48 bg-ios-grayLight rounded-2xl flex items-center justify-center border-2 border-ios-border">
									<span class="text-ios-textSecondary">暂无图片</span>
								</div>
							</c:if>
						</div>
					</div>
				</div>

				<!-- Table -->
				<div class="divide-y divide-ios-border">
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">宠物编号：</div>
						<div class="flex-1 text-ios-text font-mono">${ pet.petNo }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">宠物名称：</div>
						<div class="flex-1 text-ios-text font-bold text-xl">${ pet.petName }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">品种：</div>
						<div class="flex-1">
							<span class="px-3 py-1 bg-ios-blueLight text-ios-blue rounded-full text-sm font-bold">${ pet.breedName }</span>
						</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">性别：</div>
						<div class="flex-1 text-ios-text">${ pet.gender }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">年龄：</div>
						<div class="flex-1 text-ios-text">${ pet.age } 岁</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">体重：</div>
						<div class="flex-1 text-ios-text">${ pet.weight } 公斤</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">颜色：</div>
						<div class="flex-1 text-ios-text">${ pet.color }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">健康状况：</div>
						<div class="flex-1">
							<c:choose>
								<c:when test="${ pet.healthStatus == '健康' }">
									<span class="px-3 py-1 bg-ios-greenLight text-ios-green rounded-full text-sm font-bold">健康</span>
								</c:when>
								<c:otherwise>
									<span class="px-3 py-1 bg-yellow-100 text-yellow-700 rounded-full text-sm font-bold">${ pet.healthStatus }</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">价格：</div>
						<div class="flex-1 text-ios-green font-bold text-2xl">¥ ${ pet.price }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">登记时间：</div>
						<div class="flex-1 text-ios-text">${ pet.timeRegister }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">更新时间：</div>
						<div class="flex-1 text-ios-text">${ pet.timeRenew }</div>
					</div>
					<div class="flex items-start px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium pt-1">详细描述：</div>
						<div class="flex-1 text-ios-text leading-relaxed">${ pet.detail }</div>
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="bg-ios-gray px-6 py-4 border-t border-ios-border">
					<div class="flex items-center justify-between">
						<div class="flex space-x-3">
							<a href="PetList" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
								← 返回列表
							</a>
							<a href="PetEdit?petId=${ pet.petId }" class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
								✏️ 修改
							</a>
							<a href="PetDeleteDo?petId=${ pet.petId }" onclick="return confirm('确认删除此宠物记录？');"
								class="px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
								🗑️ 删除
							</a>
						</div>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${ pet == null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-20 h-20 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-4">
					<span class="text-4xl">🐾</span>
				</div>
				<p class="text-ios-textSecondary text-lg font-medium">宠物不存在</p>
			</div>
		</c:if>
	</div>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

	<%@ include file="../footer.jsp" %>
  </body>
</html>