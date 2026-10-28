<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>品种详情</title>
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
			<h1 class="text-3xl font-bold text-ios-text mb-2">🏷️ 品种详情</h1>
			<p class="text-ios-textSecondary">查看品种详细信息</p>
		</div>

		<c:if test="${ breed != null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<!-- Table Header -->
				<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
					<h2 class="text-white font-bold text-lg">品种信息</h2>
				</div>

				<!-- Table -->
				<div class="divide-y divide-ios-border">
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">品种ID：</div>
						<div class="flex-1 text-ios-text font-mono font-bold">${ breed.breedId }</div>
					</div>
					<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium">品种名称：</div>
						<div class="flex-1 text-ios-text">${ breed.breedName }</div>
					</div>
					<div class="flex items-start px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
						<div class="w-40 text-ios-textSecondary font-medium pt-1">品种描述：</div>
						<div class="flex-1 text-ios-text leading-relaxed">${ breed.breedDesc }</div>
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="bg-ios-gray px-6 py-4 border-t border-ios-border">
					<div class="flex items-center justify-between">
						<div class="flex space-x-3">
							<a href="BreedEdit?breedId=${ breed.breedId }"
								class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
								✏️ 修改
							</a>
							<a href="BreedDeleteDo?breedId=${ breed.breedId }"
								onclick="return confirm('确定要删除该品种吗？');"
								class="px-6 py-3 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
								🗑️ 删除
							</a>
						</div>
						<a href="BreedList" class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							← 返回列表
						</a>
					</div>
				</div>
			</div>
		</c:if>

		<c:if test="${ breed == null }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-20 h-20 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-4">
					<span class="text-4xl">🏷️</span>
				</div>
				<p class="text-ios-textSecondary text-lg font-medium">品种不存在</p>
			</div>
		</c:if>
	</div>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

	<%@ include file="../footer.jsp" %>
  </body>
</html>