<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>我的订单</title>
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
					<a href="CartList" class="px-4 py-2 text-ios-text hover:text-ios-blue font-medium transition-colors">
						🛒 购物车
					</a>
					<a href="OrderList" class="px-4 py-2 text-ios-blue font-bold transition-colors">
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
			<h1 class="text-3xl font-bold text-ios-text mb-2">📋 我的订单</h1>
			<p class="text-ios-textSecondary">查看和管理您的订单</p>
		</div>

		<c:if test="${ orderList.size() > 0 }">
			<div class="space-y-6">
				<c:forEach var="order" items="${ orderList }">
					<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border hover:shadow-2xl transition-all duration-300">
						<!-- Order Header -->
						<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
							<div class="flex flex-wrap items-center justify-between gap-4">
								<div class="flex items-center space-x-6">
									<div>
										<p class="text-white text-sm opacity-90">订单号</p>
										<p class="text-white font-bold text-lg">${ order.orderNo }</p>
									</div>
									<div>
										<p class="text-white text-sm opacity-90">下单时间</p>
										<p class="text-white font-medium">${ order.timeCreate }</p>
									</div>
								</div>
								<div class="flex items-center space-x-4">
									<!-- Status Badge -->
									<c:choose>
										<c:when test="${ order.status == '待付款' }">
											<span class="px-4 py-2 bg-yellow-400 text-yellow-900 rounded-full text-sm font-bold">
												⏳ ${ order.status }
											</span>
										</c:when>
										<c:when test="${ order.status == '已付款' }">
											<span class="px-4 py-2 bg-blue-500 text-white rounded-full text-sm font-bold">
												💰 ${ order.status }
											</span>
										</c:when>
										<c:when test="${ order.status == '已发货' }">
											<span class="px-4 py-2 bg-purple-500 text-white rounded-full text-sm font-bold">
												🚚 ${ order.status }
											</span>
										</c:when>
										<c:when test="${ order.status == '已完成' }">
											<span class="px-4 py-2 bg-ios-green text-white rounded-full text-sm font-bold">
												✓ ${ order.status }
											</span>
										</c:when>
										<c:when test="${ order.status == '已取消' }">
											<span class="px-4 py-2 bg-gray-400 text-white rounded-full text-sm font-bold">
												✕ ${ order.status }
											</span>
										</c:when>
										<c:otherwise>
											<span class="px-4 py-2 bg-gray-300 text-gray-700 rounded-full text-sm font-bold">
												${ order.status }
											</span>
										</c:otherwise>
									</c:choose>

									<!-- Action Buttons -->
									<a href="OrderDetail?orderId=${ order.orderId }"
										class="px-4 py-2 bg-white text-ios-blue rounded-xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
										查看详情
									</a>
									<c:if test="${ order.status == '待付款' }">
										<a href="OrderCancel?orderId=${ order.orderId }"
											onclick="return confirm('确认取消该订单？');"
											class="px-4 py-2 bg-red-500 text-white rounded-xl font-semibold hover:bg-red-600 transition-colors duration-200">
											取消订单
										</a>
									</c:if>
								</div>
							</div>
						</div>

						<!-- Order Body -->
						<div class="p-6">
							<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
								<!-- Shipping Info -->
								<div class="space-y-2">
									<h3 class="text-ios-text font-bold mb-3">📍 收货信息</h3>
									<p class="text-ios-text"><span class="font-medium">收货人：</span>${ order.receiverName }</p>
									<p class="text-ios-text"><span class="font-medium">联系电话：</span>${ order.receiverPhone }</p>
									<p class="text-ios-text"><span class="font-medium">收货地址：</span>${ order.receiverAddress }</p>
									<c:if test="${ not empty order.remark }">
										<p class="text-ios-text"><span class="font-medium">备注：</span>${ order.remark }</p>
									</c:if>
								</div>

								<!-- Order Total -->
								<div class="text-right space-y-2">
									<h3 class="text-ios-text font-bold mb-3">💰 订单金额</h3>
									<p class="text-3xl font-bold text-ios-green">¥${ order.totalAmount }</p>
									<p class="text-ios-textSecondary text-sm">共 ${ order.totalAmount / 100 } 元</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>

		<c:if test="${ orderList.size() == 0 }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-24 h-24 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-6">
					<span class="text-5xl">📋</span>
				</div>
				<h2 class="text-2xl font-bold text-ios-text mb-4">暂无订单</h2>
				<p class="text-ios-textSecondary text-lg mb-6">您还没有任何订单，快去选购心仪的宠物吧！</p>
				<a href="GuestPetList" class="inline-block px-8 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
					去购物 →
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