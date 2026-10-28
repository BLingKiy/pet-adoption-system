<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>订单详情</title>
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
			<a href="OrderList" class="inline-flex items-center text-ios-blue hover:text-ios-blueLight transition-colors mb-4">
				← 返回订单列表
			</a>
			<h1 class="text-3xl font-bold text-ios-text mb-2">📦 订单详情</h1>
			<p class="text-ios-textSecondary">订单号：${ order.orderNo }</p>
		</div>

		<c:if test="${ order != null }">
			<div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
				<!-- Left Column: Order Info -->
				<div class="lg:col-span-2 space-y-6">
					<!-- Order Status -->
					<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border">
						<div class="flex flex-wrap items-center justify-between gap-4">
							<div>
								<h2 class="text-xl font-bold text-ios-text mb-2">订单状态</h2>
								<!-- Status Badge -->
								<c:choose>
									<c:when test="${ order.status == '待付款' }">
										<span class="inline-block px-6 py-3 bg-yellow-400 text-yellow-900 rounded-2xl text-lg font-bold">
											⏳ ${ order.status }
										</span>
									</c:when>
									<c:when test="${ order.status == '已付款' }">
										<span class="inline-block px-6 py-3 bg-blue-500 text-white rounded-2xl text-lg font-bold">
											💰 ${ order.status }
										</span>
									</c:when>
									<c:when test="${ order.status == '已发货' }">
										<span class="inline-block px-6 py-3 bg-purple-500 text-white rounded-2xl text-lg font-bold">
											🚚 ${ order.status }
										</span>
									</c:when>
									<c:when test="${ order.status == '已完成' }">
										<span class="inline-block px-6 py-3 bg-ios-green text-white rounded-2xl text-lg font-bold">
											✓ ${ order.status }
										</span>
									</c:when>
									<c:when test="${ order.status == '已取消' }">
										<span class="inline-block px-6 py-3 bg-gray-400 text-white rounded-2xl text-lg font-bold">
											✕ ${ order.status }
										</span>
									</c:when>
									<c:otherwise>
										<span class="inline-block px-6 py-3 bg-gray-300 text-gray-700 rounded-2xl text-lg font-bold">
											${ order.status }
										</span>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="text-right">
								<p class="text-sm text-ios-textSecondary mb-1">下单时间</p>
								<p class="text-ios-text font-medium">${ order.timeCreate }</p>
							</div>
						</div>
					</div>

					<!-- Shipping Info -->
					<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border">
						<h2 class="text-xl font-bold text-ios-text mb-4 pb-4 border-b border-ios-border">
							📍 收货信息
						</h2>
						<div class="space-y-3">
							<div class="flex">
								<span class="w-24 text-ios-textSecondary font-medium">收货人：</span>
								<span class="text-ios-text">${ order.receiverName }</span>
							</div>
							<div class="flex">
								<span class="w-24 text-ios-textSecondary font-medium">联系电话：</span>
								<span class="text-ios-text">${ order.receiverPhone }</span>
							</div>
							<div class="flex">
								<span class="w-24 text-ios-textSecondary font-medium">收货地址：</span>
								<span class="text-ios-text">${ order.receiverAddress }</span>
							</div>
							<c:if test="${ not empty order.remark }">
								<div class="flex">
									<span class="w-24 text-ios-textSecondary font-medium">备注：</span>
									<span class="text-ios-text">${ order.remark }</span>
								</div>
							</c:if>
						</div>
					</div>

					<!-- Order Items -->
					<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
						<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
							<h2 class="text-white font-bold text-lg">商品清单</h2>
						</div>
						<div class="divide-y divide-ios-border">
							<c:forEach var="detail" items="${ detailList }">
								<div class="p-6 hover:bg-ios-blueLight/50 transition-colors duration-200">
									<div class="flex items-center space-x-6">
										<!-- Pet Image -->
										<div class="flex-shrink-0">
											<img src="fileUpload/petImage/${ detail.image }" alt="${ detail.petName }"
												onerror="this.style.display='none'"
												class="w-24 h-24 rounded-2xl object-cover border-2 border-ios-border">
										</div>

										<!-- Pet Info -->
										<div class="flex-1">
											<h3 class="text-xl font-bold text-ios-text mb-2">${ detail.petName }</h3>
											<div class="space-y-1 text-sm text-ios-textSecondary">
												<p><span class="font-medium">编号：</span>${ detail.petNo }</p>
												<p><span class="font-medium">品种：</span>${ detail.breedName }</p>
												<p><span class="font-medium">单价：</span><span class="text-ios-green font-bold">¥${ detail.price }</span></p>
											</div>
										</div>

										<!-- Quantity -->
										<div class="text-center">
											<p class="text-sm text-ios-textSecondary mb-1">数量</p>
											<p class="text-xl font-bold text-ios-text">x${ detail.quantity }</p>
										</div>

										<!-- Subtotal -->
										<div class="text-right">
											<p class="text-sm text-ios-textSecondary mb-1">小计</p>
											<p class="text-2xl font-bold text-ios-green">¥${ detail.price * detail.quantity }</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

				<!-- Right Column: Order Summary -->
				<div class="lg:col-span-1">
					<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border sticky top-24">
						<h2 class="text-xl font-bold text-ios-text mb-6 pb-4 border-b border-ios-border">
							💰 订单汇总
						</h2>

						<div class="space-y-4 mb-6">
							<div class="flex justify-between text-ios-text">
								<span>订单号</span>
								<span class="font-bold">${ order.orderNo }</span>
							</div>
							<div class="flex justify-between text-ios-text">
								<span>下单时间</span>
								<span class="font-bold">${ order.timeCreate }</span>
							</div>
							<div class="flex justify-between text-ios-text">
								<span>商品总数</span>
								<c:set var="totalCount" value="0"/>
								<c:forEach var="detail" items="${ detailList }">
									<c:set var="totalCount" value="${ totalCount + detail.quantity }"/>
								</c:forEach>
								<span class="font-bold">${ totalCount }件</span>
							</div>
							<div class="flex justify-between text-ios-text">
								<span>商品金额</span>
								<span class="font-bold">¥${ order.totalAmount }</span>
							</div>
							<div class="flex justify-between text-ios-text">
								<span>运费</span>
								<span class="font-bold">¥0.00</span>
							</div>
						</div>

						<div class="border-t border-ios-border pt-4 mb-6">
							<div class="flex justify-between items-center">
								<span class="text-xl font-bold text-ios-text">应付总额</span>
								<span class="text-3xl font-bold text-ios-green">¥${ order.totalAmount }</span>
							</div>
						</div>

						<div class="space-y-3">
							<a href="OrderList" class="block w-full text-center px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
								← 返回订单列表
							</a>
							<c:if test="${ order.status == '待付款' }">
								<a href="OrderCancel?orderId=${ order.orderId }"
									onclick="return confirm('确认取消该订单？');"
									class="block w-full text-center px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
									取消订单
								</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${ order == null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-24 h-24 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-6">
					<span class="text-5xl">❓</span>
				</div>
				<h2 class="text-2xl font-bold text-ios-text mb-4">订单不存在</h2>
				<p class="text-ios-textSecondary text-lg mb-6">该订单可能已被删除或不存在！</p>
				<a href="OrderList" class="inline-block px-8 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
					查看我的订单 →
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