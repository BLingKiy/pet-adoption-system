<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>宠物商城</title>
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
		<div class="text-center mb-10">
			<h1 class="text-4xl font-bold text-ios-text mb-4">欢迎来到宠物商城</h1>
			<p class="text-ios-textSecondary text-lg">发现您心仪的宠物伙伴</p>
		</div>

		<!-- Search and Filter Form -->
		<form action="" method="post" class="mb-8">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border">
				<div class="flex flex-wrap items-center justify-center gap-4">
					<!-- Breed Filter -->
					<div class="flex items-center space-x-3">
						<label class="text-ios-text font-medium">按品种筛选：</label>
						<select name="breedName" class="px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text">
							<option value="">全部品种</option>
							<c:forEach var="breed" items="${ breedList }">
								<c:if test="${ breed.breedName != search }">
									<option value="${ breed.breedName }">${ breed.breedName }</option>
								</c:if>
								<c:if test="${ breed.breedName == search }">
									<option value="${ breed.breedName }" selected="selected">${ breed.breedName }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>

					<!-- Search Input -->
					<div class="flex items-center space-x-3">
						<label class="text-ios-text font-medium">搜索：</label>
						<input type="text" name="search" value="${ search }"
							class="px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary w-48"
							placeholder="编号、名称、品种、颜色">
					</div>

					<!-- Action Buttons -->
					<div class="flex space-x-3">
						<button type="submit" name="buttonFilter" value="筛选"
							class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
							筛选
						</button>
						<button type="submit" name="buttonSearch" value="搜索"
							class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							搜索
						</button>
					</div>
				</div>
			</div>
		</form>

		<!-- Pet Grid -->
		<c:if test="${ petList.size() > 0 }">
			<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
				<c:forEach var="pet" items="${ petList }">
					<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1">
						<!-- Pet Image -->
						<div class="relative h-64 bg-ios-gray">
							<img src="fileUpload/petImage/${ pet.image }" alt="${ pet.petName }"
								onerror="this.style.display='none'"
								class="w-full h-full object-cover">
							<div class="absolute top-4 right-4 bg-ios-green text-white px-3 py-1 rounded-full text-sm font-bold">
								¥${ pet.price }
							</div>
						</div>

						<!-- Pet Info -->
						<div class="p-6">
							<h3 class="text-xl font-bold text-ios-text mb-2">${ pet.petName }</h3>
							<div class="space-y-2 text-sm text-ios-textSecondary mb-4">
								<p><span class="font-medium">编号：</span>${ pet.petNo }</p>
								<p><span class="font-medium">品种：</span>${ pet.breedName }</p>
								<p><span class="font-medium">年龄：</span>${ pet.age }岁</p>
								<p><span class="font-medium">性别：</span>${ pet.gender }</p>
								<p><span class="font-medium">颜色：</span>${ pet.color }</p>
								<p><span class="font-medium">健康状况：</span>${ pet.healthStatus }</p>
							</div>

							<!-- Action Buttons -->
							<div class="flex space-x-3">
																<a href="CartAdd?petId=${ pet.petId }"
																	class="flex-1 px-4 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200 text-center">
																	🛒 加入购物车
																</a>
																<a href="GuestPetShow?petId=${ pet.petId }"
																	class="px-4 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
																	👁️ 详情
																</a>
															</div>						</div>
					</div>
				</c:forEach>
			</div>

			<!-- Pagination -->
			<div class="mt-8 text-center text-ios-textSecondary">
				${ page }
			</div>
		</c:if>

		<c:if test="${ petList.size() == 0 }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-20 h-20 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-4">
					<span class="text-4xl">🐾</span>
				</div>
				<p class="text-ios-textSecondary text-lg font-medium">暂无宠物信息</p>
			</div>
		</c:if>
	</div>

	<!-- Footer -->
	<footer class="bg-white/80 backdrop-blur-md shadow-lg mt-12">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
			<div class="text-center text-ios-textSecondary">
				<p>&copy; 2026 姆斯集团 宠物商城 - 让每个家庭都有爱的陪伴</p>
			</div>
		</div>
	</footer>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

  </body>
</html>