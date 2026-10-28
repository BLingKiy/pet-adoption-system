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
	<%@ include file="../header.jsp" %>

	<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<c:if test="${ myUser.role == 'admin' || myUser.role == 'user' }">
				<a href="OrderManage" class="inline-flex items-center text-ios-blue hover:text-ios-blueLight transition-colors mb-4">
					← 返回订单列表
				</a>
			</c:if>
			<c:if test="${ myUser.role == 'guest' }">
				<a href="OrderList" class="inline-flex items-center text-ios-blue hover:text-ios-blueLight transition-colors mb-4">
					← 返回订单列表
				</a>
			</c:if>
			<h1 class="text-3xl font-bold text-ios-text mb-2">📦 订单详情</h1>
			<p class="text-ios-textSecondary">订单号：${ order.orderNo }</p>
		</div>

		<c:if test="${ order != null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border">
				<!-- Order Info -->
				<div class="mb-6 pb-6 border-b border-ios-border">
					<h2 class="text-xl font-bold text-ios-text mb-4">订单信息</h2>
					<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">订单号</p>
							<p class="text-ios-text font-medium">${ order.orderNo }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">用户</p>
							<p class="text-ios-text font-medium">${ order.username }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">订单金额</p>
							<p class="text-ios-green font-bold text-xl">¥${ order.totalAmount }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">创建时间</p>
							<p class="text-ios-text font-medium">${ order.timeCreate }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">更新时间</p>
							<p class="text-ios-text font-medium">${ order.timeUpdate }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">订单状态</p>
							<c:choose>
								<c:when test="${ order.status == '待付款' }">
									<span class="inline-block px-3 py-1 bg-yellow-400 text-yellow-900 rounded-full text-sm font-bold">
										⏳ ${ order.status }
									</span>
								</c:when>
								<c:when test="${ order.status == '已付款' }">
									<span class="inline-block px-3 py-1 bg-blue-500 text-white rounded-full text-sm font-bold">
										💰 ${ order.status }
									</span>
								</c:when>
								<c:when test="${ order.status == '已发货' }">
									<span class="inline-block px-3 py-1 bg-purple-500 text-white rounded-full text-sm font-bold">
										🚚 ${ order.status }
									</span>
								</c:when>
								<c:when test="${ order.status == '已完成' }">
									<span class="inline-block px-3 py-1 bg-ios-green text-white rounded-full text-sm font-bold">
										✓ ${ order.status }
									</span>
								</c:when>
								<c:when test="${ order.status == '已取消' }">
									<span class="inline-block px-3 py-1 bg-gray-400 text-white rounded-full text-sm font-bold">
										✕ ${ order.status }
									</span>
								</c:when>
								<c:otherwise>
									<span class="inline-block px-3 py-1 bg-gray-300 text-gray-700 rounded-full text-sm font-bold">
										${ order.status }
									</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<!-- Shipping Info -->
				<div class="mb-6 pb-6 border-b border-ios-border">
					<h2 class="text-xl font-bold text-ios-text mb-4">收货信息</h2>
					<div class="space-y-4">
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">收货人姓名</p>
							<p class="text-ios-text font-medium">${ order.receiverName }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">联系电话</p>
							<p class="text-ios-text font-medium">${ order.receiverPhone }</p>
						</div>
						<div>
							<p class="text-sm text-ios-textSecondary mb-1">收货地址</p>
							<p class="text-ios-text font-medium">${ order.receiverAddress }</p>
						</div>
						<c:if test="${ not empty order.remark }">
							<div>
								<p class="text-sm text-ios-textSecondary mb-1">备注</p>
								<p class="text-ios-text font-medium">${ order.remark }</p>
							</div>
						</c:if>
					</div>
				</div>

				<!-- Order Items -->
				<div class="mb-6">
					<h2 class="text-xl font-bold text-ios-text mb-4">商品清单</h2>
					<div class="divide-y divide-ios-border">
						<c:forEach var="detail" items="${ detailList }">
							<div class="p-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
								<div class="flex items-center space-x-4">
									<!-- Pet Image -->
									<div class="flex-shrink-0">
										<img src="fileUpload/petImage/${ detail.image }" alt="${ detail.petName }"
											onerror="this.style.display='none'"
											class="w-20 h-20 rounded-2xl object-cover border-2 border-ios-border">
									</div>

									<!-- Pet Info -->
									<div class="flex-1">
										<p class="text-lg font-bold text-ios-text mb-1">${ detail.petName }</p>
										<div class="space-y-1 text-sm text-ios-textSecondary">
											<p><span class="font-medium">编号：</span>${ detail.petNo }</p>
											<p><span class="font-medium">品种：</span>${ detail.breedName }</p>
											<p><span class="font-medium">单价：</span><span class="text-ios-green font-bold">¥${ detail.price }</span></p>
										</div>
									</div>

									<!-- Quantity -->
									<div class="text-center">
										<p class="text-sm text-ios-textSecondary mb-1">数量</p>
										<p class="text-lg font-bold text-ios-text">x${ detail.quantity }</p>
									</div>

									<!-- Subtotal -->
									<div class="text-right">
										<p class="text-sm text-ios-textSecondary mb-1">小计</p>
										<p class="text-xl font-bold text-ios-green">¥${ detail.price * detail.quantity }</p>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="flex items-center justify-end space-x-4 pt-4">
					<c:if test="${ myUser.role == 'admin' || myUser.role == 'user' }">
						<a href="OrderManage" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							返回订单列表
						</a>
					</c:if>
					<c:if test="${ myUser.role == 'admin' }">
						<a href="OrderEdit?orderId=${ order.orderId }" class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
							编辑订单
						</a>
						<c:if test="${ order.status == '已取消' }">
							<a href="OrderDelete?orderId=${ order.orderId }" onclick="return confirm('确认删除此订单？');"
								class="px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
								删除订单
							</a>
						</c:if>
					</c:if>
					<c:if test="${ myUser.role == 'user' }">
						<c:if test="${ order.status == '待付款' }">
							<a href="OrderCancel?orderId=${ order.orderId }" onclick="return confirm('确认取消此订单？');"
								class="px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
								取消订单
							</a>
						</c:if>
					</c:if>
					<c:if test="${ myUser.role == 'guest' }">
						<a href="OrderList" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							返回订单列表
						</a>
						<c:if test="${ order.status == '待付款' }">
							<a href="OrderCancel?orderId=${ order.orderId }" onclick="return confirm('确认取消此订单？');"
								class="px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
								取消订单
							</a>
						</c:if>
					</c:if>
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
				<c:if test="${ myUser.role == 'admin' || myUser.role == 'user' }">
					<a href="OrderManage" class="inline-block px-8 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
						返回订单列表 →
					</a>
				</c:if>
				<c:if test="${ myUser.role == 'guest' }">
					<a href="OrderList" class="inline-block px-8 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
						返回订单列表 →
					</a>
				</c:if>
			</div>
		</c:if>
	</div>

	<%@ include file="../footer.jsp" %>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>
  </body>
</html>