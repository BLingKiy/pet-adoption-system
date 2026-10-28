<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>用户列表</title>
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

	<div class="max-w-6xl mx-auto px-6 py-8">
		<!-- Page Header -->
		<div class="mb-8">
			<h1 class="text-3xl font-bold text-ios-text mb-2">用户列表</h1>
			<p class="text-ios-textSecondary">浏览和管理所有用户信息</p>
		</div>

		<!-- Search Form -->
		<form action="" method="post" class="mb-8">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-6 border border-ios-border">
				<div class="flex flex-wrap items-center gap-4">
					<!-- Search Input -->
					<div class="flex items-center space-x-3">
						<label class="text-ios-text font-medium">搜索：</label>
						<input type="text" name="search" value="${ search }"
							class="px-4 py-3 bg-ios-gray rounded-2xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text placeholder-ios-textSecondary w-48"
							placeholder="昵称、真实姓名">
					</div>

					<!-- Action Button -->
					<div>
						<button type="submit" name="buttonSearch" value="搜索"
							class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
							搜索
						</button>
					</div>
				</div>
				<p class="mt-3 text-sm text-ios-textSecondary">（在昵称、真实姓名中搜索）</p>
			</div>
		</form>

		<!-- User List and Delete Form -->
		<form action="UserList" method="post">
		<c:if test="${ userList.size() > 0 }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
				<!-- Table Header -->
				<div class="bg-gradient-to-r from-purple-500 to-purple-400 px-6 py-4">
					<h2 class="text-white font-bold text-lg">用户信息</h2>
				</div>

				<!-- Table -->
				<div class="overflow-x-auto">
					<table class="w-full">
						<thead>
							<tr class="bg-ios-gray border-b border-ios-border">
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">序号</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">用户名</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">真实姓名</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">角色级别</th>
								<th class="px-6 py-4 text-left text-xs font-bold text-ios-text uppercase tracking-wider">更新时间</th>
								<th class="px-6 py-4 text-center text-xs font-bold text-ios-text uppercase tracking-wider">操作</th>
								<th class="px-6 py-4 text-center text-xs font-bold text-ios-text uppercase tracking-wider">选择</th>
							</tr>
						</thead>
						<tbody class="divide-y divide-ios-border">
							<c:forEach var="user" items="${ userList }" varStatus="status">
								<tr class="hover:bg-purple-50/50 transition-colors duration-200">
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-textSecondary text-sm">${ status.index + indexStart + 1 }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<div class="flex items-center space-x-3">
											<div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-purple-100 rounded-full flex items-center justify-center shadow-md">
												<span class="text-white font-bold text-sm">${ user.username.charAt(0) }</span>
											</div>
											<span class="text-ios-text font-bold">${ user.username }</span>
										</div>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-text">${ user.realName }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="px-3 py-1 rounded-full text-xs font-bold
											${ user.role == 'admin' ? 'bg-purple-100 text-purple-600' :
											   user.role == 'user' ? 'bg-blue-100 text-blue-600' :
											   user.role == 'guest' ? 'bg-green-100 text-green-600' :
											   'bg-ios-gray text-ios-textSecondary' }">
											${ user.role }
										</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap">
										<span class="text-ios-textSecondary text-sm">${ user.timeRenew }</span>
									</td>
									<td class="px-6 py-4 whitespace-nowrap text-center">
										<div class="flex items-center justify-center space-x-3">
											<a href="UserShow?userId=${ user.userId }" title="详情"
												class="p-2 bg-ios-gray rounded-xl hover:bg-purple-50 transition-colors duration-200 group">
												<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
													<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
												</svg>
											</a>
											<a href="UserEdit?userId=${ user.userId }" title="修改"
												class="p-2 bg-ios-gray rounded-xl hover:bg-purple-50 transition-colors duration-200 group">
												<svg class="w-5 h-5 text-ios-textSecondary group-hover:text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
													<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
												</svg>
											</a>
										</div>
									</td>
									<td class="px-6 py-4 whitespace-nowrap text-center">
										<input type="checkbox" name="userId" value="${ user.userId }" onchange="check()"
											class="w-5 h-5 rounded-lg border-2 border-ios-border text-purple-500 focus:ring-purple-500 focus:ring-offset-0">
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- Table Footer -->
				<div class="bg-ios-gray px-6 py-4 border-t border-ios-border">
					<div class="flex flex-wrap items-center justify-between gap-4">
						<div class="flex items-center space-x-3">
							<a href="UserAdd" class="px-5 py-2 bg-gradient-to-r from-purple-500 to-purple-400 text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200">
								+ 新添用户
							</a>
							<button type="submit" name="buttonDelete" value="删除"
								onclick="return confirm('确认删除所选记录？');"
								class="px-5 py-2 bg-red-500 text-white rounded-2xl font-semibold hover:bg-red-600 transition-colors duration-200">
								删除
							</button>
						</div>
						<label class="flex items-center space-x-2 text-ios-text cursor-pointer">
							<input type="checkbox" name="checkboxAll" onchange="checkAll()"
								class="w-5 h-5 rounded-lg border-2 border-ios-border text-purple-500 focus:ring-purple-500 focus:ring-offset-0">
							<span class="font-medium">全选</span>
						</label>
					</div>
				</div>
			</div>

			<!-- Pagination -->
			<div class="mt-6 text-right text-ios-textSecondary">
				${ page }
			</div>
		</c:if>

		<c:if test="${ userList.size() == 0 }">
			<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg p-12 border border-ios-border text-center">
				<div class="w-20 h-20 bg-ios-gray rounded-full flex items-center justify-center mx-auto mb-4">
					<svg class="w-10 h-10 text-ios-textSecondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12 a9 9 0 11-18 0 9 9 0 0118 0z"></path>
					</svg>
				</div>
				<p class="text-ios-textSecondary text-lg font-medium">暂无记录</p>
			</div>
		</c:if>
		</form>

	<div id="msg" class="text-center text-red-500 font-medium mt-4">${ msg }</div>
	</div>

	<%@ include file="../footer.jsp" %>
  </body>

<script type="text/javascript">
function checkAll() {
	var checkboxList = document.getElementsByName("userId");
	var checkboxAll  = document.getElementsByName("checkboxAll")[0];

	for (var i = 0; i < checkboxList.length; i++) {
		checkboxList[i].checked = checkboxAll.checked;
	}
}

function check() {
	var checkboxList = document.getElementsByName("userId");
	var checkboxAll  = document.getElementsByName("checkboxAll")[0];
	var isChecked = true;

	for (var i = 0; i < checkboxList.length; i++) {
		if (checkboxList[i].checked == false) {
			isChecked = false;
			break;
		}
	}

	if (isChecked) {
		checkboxAll.checked = true;
	} else {
		checkboxAll.checked = false;
	}
}
</script>
</html>