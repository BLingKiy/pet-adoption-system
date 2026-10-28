<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>修改宠物</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<script type="text/javascript" src="../UEditor/ueditor.config.js"></script>
	<script type="text/javascript" src="../UEditor/ueditor.all.js"></script>
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
			<h1 class="text-3xl font-bold text-ios-text mb-2">✏️ 修改宠物</h1>
			<p class="text-ios-textSecondary">编辑宠物信息</p>
		</div>

		<div class="bg-white/80 backdrop-blur-md rounded-3xl shadow-lg overflow-hidden border border-ios-border">
			<!-- Form Header -->
			<div class="bg-gradient-to-r from-ios-blue to-ios-green px-6 py-4">
				<h2 class="text-white font-bold text-lg">宠物信息编辑</h2>
			</div>

			<form id="petForm" method="post" enctype="multipart/form-data" class="divide-y divide-ios-border">
				<input type="hidden" name="petId" value="${ pet.petId }">
				<!-- Pet No -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">宠物编号：</div>
					<div class="flex-1">
						<input type="text" name="petNo" value="${ pet.petNo }" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入宠物编号">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Pet Name -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">宠物名称：</div>
					<div class="flex-1">
						<input type="text" name="petName" value="${ pet.petName }" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入宠物名称">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Breed -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">品种：</div>
					<div class="flex-1">
						<select name="breedId" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text">
							<option value="">请选择品种</option>
							<c:forEach var="breed" items="${ breedList }">
								<c:if test="${ breed.breedId != pet.breedId }">
									<option value="${ breed.breedId }">${ breed.breedName }</option>
								</c:if>
								<c:if test="${ breed.breedId == pet.breedId }">
									<option value="${ breed.breedId }" selected="selected">${ breed.breedName }</option>
								</c:if>
							</c:forEach>
						</select>
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Gender -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">性别：</div>
					<div class="flex-1 flex items-center space-x-4">
						<c:if test="${ pet.gender == '公' }">
							<label class="flex items-center space-x-2 cursor-pointer">
								<input type="radio" name="gender" value="公" checked class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
								<span class="text-ios-text">公</span>
							</label>
							<label class="flex items-center space-x-2 cursor-pointer">
								<input type="radio" name="gender" value="母" class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
								<span class="text-ios-text">母</span>
							</label>
						</c:if>
						<c:if test="${ pet.gender == '母' }">
							<label class="flex items-center space-x-2 cursor-pointer">
								<input type="radio" name="gender" value="公" class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
								<span class="text-ios-text">公</span>
							</label>
							<label class="flex items-center space-x-2 cursor-pointer">
								<input type="radio" name="gender" value="母" checked class="w-5 h-5 text-ios-blue focus:ring-ios-blue">
								<span class="text-ios-text">母</span>
							</label>
						</c:if>
						<span class="text-red-500 text-sm">*</span>
					</div>
				</div>

				<!-- Age -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">年龄（岁）：</div>
					<div class="flex-1">
						<input type="number" name="age" value="${ pet.age }" min="0" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入年龄">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Weight -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">体重（公斤）：</div>
					<div class="flex-1">
						<input type="number" name="weight" value="${ pet.weight }" min="0" step="0.01" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入体重">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Color -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">颜色：</div>
					<div class="flex-1">
						<input type="text" name="color" value="${ pet.color }" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入颜色">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Health Status -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">健康状况：</div>
					<div class="flex-1">
						<select name="healthStatus" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text">
							<option value="">请选择健康状况</option>
							<c:if test="${ pet.healthStatus == '健康' }">
								<option value="健康" selected="selected">健康</option>
								<option value="生病">生病</option>
								<option value="康复中">康复中</option>
								<option value="待检查">待检查</option>
							</c:if>
							<c:if test="${ pet.healthStatus == '生病' }">
								<option value="健康">健康</option>
								<option value="生病" selected="selected">生病</option>
								<option value="康复中">康复中</option>
								<option value="待检查">待检查</option>
							</c:if>
							<c:if test="${ pet.healthStatus == '康复中' }">
								<option value="健康">健康</option>
								<option value="生病">生病</option>
								<option value="康复中" selected="selected">康复中</option>
								<option value="待检查">待检查</option>
							</c:if>
							<c:if test="${ pet.healthStatus == '待检查' }">
								<option value="健康">健康</option>
								<option value="生病">生病</option>
								<option value="康复中">康复中</option>
								<option value="待检查" selected="selected">待检查</option>
							</c:if>
						</select>
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Price -->
				<div class="flex items-center px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium">价格（元）：</div>
					<div class="flex-1">
						<input type="number" name="price" value="${ pet.price }" min="0" step="0.01" required
							class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text"
							placeholder="请输入价格">
						<span class="text-red-500 text-sm ml-2">*</span>
					</div>
				</div>

				<!-- Image -->
				<div class="flex items-start px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium pt-2">宠物图片：</div>
					<div class="flex-1">
						<c:if test="${ pet.image != null && pet.image != '' }">
							<img src="fileUpload/petImage/${ pet.image }" alt="宠物图片" class="w-32 h-32 rounded-xl object-cover border-2 border-ios-border mb-3">
						</c:if>
						<input type="file" name="image" accept="image/*" class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text">
						<p class="text-ios-textSecondary text-sm mt-2">（如需更换图片，请选择新图片）</p>
					</div>
				</div>

				<!-- Detail -->
				<div class="flex items-start px-6 py-4 hover:bg-ios-blueLight/50 transition-colors duration-200">
					<div class="w-40 text-ios-textSecondary font-medium pt-2">详细描述：</div>
					<div class="flex-1">
						<textarea name="detail" id="detail" class="w-full px-4 py-2 bg-ios-gray rounded-xl border-2 border-transparent focus:border-ios-blue focus:bg-white transition-all duration-200 outline-none text-ios-text" rows="6">${ pet.detail }</textarea>
						<script type="text/javascript">
							var editor = new UE.ui.Editor();
							editor.render("detail");
						</script>
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="bg-ios-gray px-6 py-4">
					<div class="flex items-center justify-between">
						<div class="flex space-x-3">
							<input type="button" value="提交" onclick="submitPet()"
								class="px-6 py-3 bg-gradient-to-r from-ios-blue to-ios-green text-white rounded-2xl font-semibold shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-200 cursor-pointer">
							<input type="reset" value="重置"
								class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200 cursor-pointer">
						</div>
						<a href="PetShow?petId=${ pet.petId }"
							class="px-6 py-3 bg-ios-gray text-ios-text rounded-2xl font-semibold hover:bg-ios-blueLight transition-colors duration-200">
							← 返回详情
						</a>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="msg" class="text-center text-green-500 font-medium mt-4">${ msg }</div>

	<%@ include file="../footer.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/UEditor/third-party/jquery-1.10.2.js"></script>
	<script type="text/javascript">
	function submitPet() {
		// 获取表单数据
		var formData = new FormData(document.getElementById('petForm'));
		
		// 显示加载提示
		$("#msg").html("正在提交...");
		
		// 发送AJAX请求
		$.ajax({
			url: 'PetEditDo',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				// 检查是否是重定向响应
				if (response.indexOf('PetShow?petId=') >= 0) {
					// 成功，跳转到详情页
					window.location.href = response;
				} else {
					// 失败，显示错误信息
					alert(response);
					$("#msg").html(response);
				}
			},
			error: function(xhr, status, error) {
				alert('提交失败：' + error);
				$("#msg").html('系统错误，请稍后重试');
			}
		});
	}
	</script>
  </body>
</html>