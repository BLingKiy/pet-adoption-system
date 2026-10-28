<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>订单管理</title>
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

	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<h1 class="text-3xl font-bold text-ios-text mb-2">📋 订单管理</h1>
			<p class="text-ios-textSecondary">管理所有订单信息</p>
		</div>

		<c:if test="${ orderList.size() > 0 }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<!-- Table Header -->
				<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
					<h2 class="text-white font-bold text-lg">订单列表</h2>
				</div>

				<div class="overflow-x-auto">
					<table class="w-full">
						<thead>
							<tr class="bg-ios-gray border-b border-ios-border">
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">序号</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">订单号</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">用户</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">金额</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">状态</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">收货人</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">创建时间</th>
								<th class="px-6 py-4 text-center text-xs font-bold text-ios-text uppercase tracking-wider">操作</th>
							</tr>
						</thead>
						<tbody class="divide-y divide-ios-border">
							<c:forEach var="order" items="${ orderList }" varStatus="status">
								<tr class="hover:bg-ios-blueLight/50 transition-colors duration-200">
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-textSecondary text-sm">${ status.index + 1 }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-text font-bold">${ order.orderNo }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-text">${ order.username }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-green font-bold text-lg">¥${ order.totalAmount }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<c:choose>
											<c:when test="${ order.status == '待付款' }">
												<span class="px-3 py-1 bg-yellow-400 text-yellow-900 rounded-full text-xs font-bold">
													⏳ ${ order.status }
												</span>
											</c:when>
											<c:when test="${ order.status == '已付款' }">
												<span class="px-3 py-1 bg-blue-500 text-white rounded-full text-xs font-bold">
													💰 ${ order.status }
												</span>
											</c:when>
											<c:when test="${ order.status == '已发货' }">
												<span class="px-3 py-1 bg-purple-500 text-white rounded-full text-xs font-bold">
													🚚 ${ order.status }
												</span>
											</c:when>
											<c:when test="${ order.status == '已完成' }">
												<span class="px-3 py-1 bg-ios-green text-white rounded-full text-xs font-bold">
													✓ ${ order.status }
												</span>
											</c:when>
											<c:when test="${ order.status == '已取消' }">
												<span class="px-3 py-1 bg-gray-400 text-white rounded-full text-xs font-bold">
													✕ ${ order.status }
												</span>
											</c:when>
											<c:otherwise>
												<span class="px-3 py-1 bg-gray-300 text-gray-700 rounded-full text-xs font-bold">
													${ order.status }
												</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-text">${ order.receiverName }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-textSecondary text-sm">${ order.timeCreate }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap text-center">
										<div class="flex items-center justify-center space-x-2">
											<a href="OrderDetail?orderId=${ order.orderId }" title="详情"
												class="p-2 bg-ios-gray rounded-xl hover:bg-ios-blueLight transition-colors duration-200 group">
												<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
													<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
												</svg>
											</a>
											<c:if test="${ myUser.role == 'admin' }">
												<a href="OrderEdit?orderId=${ order.orderId }" title="编辑"
													class="p-2 bg-ios-gray rounded-xl hover:bg-ios-greenLight transition-colors duration-200 group">
													<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-ios-green" fill="none" stroke="currentColor" viewBox="0 0 24 24">
														<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
													</svg>
												</a>
											</c:if>
											<c:if test="${ myUser.role == 'admin' && order.status == '已取消' }">
												<a href="OrderDelete?orderId=${ order.orderId }" title="删除"
													onclick="return confirm('确认删除该订单？删除后无法恢复。');"
													class="p-2 bg-ios-gray rounded-xl hover:bg-red-50 transition-colors duration-200 group">
													<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
														<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
													</svg>
												</a>
											</c:if>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</c:if>

		<c:if test="${ orderList.size() == 0 }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-20 h-20 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-4">
					<span class="text-4xl">📋</span>
				</div>
				<p class="text-ios-textSecondary text-lg font-medium">暂无订单</p>
			</div>
		</c:if>
	</div>

	<%@ include file="../footer.jsp" %>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>
  </body>
</html>