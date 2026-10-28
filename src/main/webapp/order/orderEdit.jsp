<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>编辑订单</title>
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
			<a href="OrderManage" class="inline-flex items-center text-ios-blue hover:text-ios-blueLight transition-colors mb-4">
				← 返回订单列表
			</a>
			<h1 class="text-3xl font-bold text-ios-text mb-2">✏️ 编辑订单</h1>
			<p class="text-ios-textSecondary">订单号：${ order.orderNo }</p>
		</div>

		<c:if test="${ order != null }">
			<form action="OrderEditDo" method="post">
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
						</div>
					</div>

					<!-- Shipping Info -->
					<div class="mb-6 pb-6 border-b border-ios-border">
						<h2 class="text-xl font-bold text-ios-text mb-4">收货信息</h2>
						<div class="space-y-4">
							<div>
								<label class="block text-ios-text font-medium mb-2">收货人姓名 <span class="text-red-500">*</span></label>
								<input type="text" name="receiverName" value="${ order.receiverName }" required
									class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary"
									placeholder="请输入收货人姓名">
							</div>
							<div>
								<label class="block text-ios-text font-medium mb-2">联系电话 <span class="text-red-500">*</span></label>
								<input type="tel" name="receiverPhone" value="${ order.receiverPhone }" required
									class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary"
									placeholder="请输入联系电话">
							</div>
							<div>
								<label class="block text-ios-text font-medium mb-2">收货地址 <span class="text-red-500">*</span></label>
								<textarea name="receiverAddress" required rows="3"
									class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary resize-none"
									placeholder="请输入详细收货地址">${ order.receiverAddress }</textarea>
							</div>
							<div>
								<label class="block text-ios-text font-medium mb-2">备注</label>
								<textarea name="remark" rows="2"
									class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary resize-none"
									placeholder="选填，可以填写特殊要求">${ order.remark }</textarea>
							</div>
						</div>
					</div>

					<!-- Order Status -->
					<div class="mb-6">
						<h2 class="text-xl font-bold text-ios-text mb-4">订单状态</h2>
						<div>
							<label class="block text-ios-text font-medium mb-2">状态 <span class="text-red-500">*</span></label>
							<select name="status" required
								class="w-full px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text">
								<option value="待付款" ${ order.status == '待付款' ? 'selected' : ''}>⏳ 待付款</option>
								<option value="已付款" ${ order.status == '已付款' ? 'selected' : ''}>💰 已付款</option>
								<option value="已发货" ${ order.status == '已发货' ? 'selected' : ''}>🚚 已发货</option>
								<option value="已完成" ${ order.status == '已完成' ? 'selected' : ''}>✓ 已完成</option>
								<option value="已取消" ${ order.status == '已取消' ? 'selected' : ''}>✕ 已取消</option>
							</select>
						</div>
					</div>

					<!-- Action Buttons -->
					<div class="flex items-center justify-end space-x-4 pt-4">
						<a href="OrderManage" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							取消
						</a>
						<button type="submit"
							onclick="return confirm('确认保存修改？');"
							class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
							保存修改
						</button>
					</div>
				</div>

				<input type="hidden" name="orderId" value="${ order.orderId }">
			</form>
		</c:if>

		<c:if test="${ order == null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-24 h-24 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-6">
					<span class="text-5xl">❓</span>
				</div>
				<h2 class="text-2xl font-bold text-ios-text mb-4">订单不存在</h2>
				<p class="text-ios-textSecondary text-lg mb-6">该订单可能已被删除或不存在！</p>
				<a href="OrderManage" class="inline-block px-8 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-bold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
					返回订单列表 →
				</a>
			</div>
		</c:if>
	</div>

	<%@ include file="../footer.jsp" %>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>
  </body>
</html>