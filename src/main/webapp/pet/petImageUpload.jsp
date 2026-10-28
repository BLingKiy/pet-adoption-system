<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh">
  <head>
	<title>宠物图片上传</title>
	<link rel="stylesheet" type="text/css" href="../css/css.css">
  </head>
  <body>
	<%@ include file="../header.jsp" %>

	<h3>宠物图片上传</h3>

	<div class="divGrid">
	<form action="PetImageUploadDo" method="post" enctype="multipart/form-data">
	<table style="width:600px; margin:0 auto;" class="table_border table_border_bg">
		<tr>
			<td style="width:120px; text-align:right; padding-right:10px;">选择图片：</td>
			<td>
				<input type="file" name="image" accept="image/*" required>
				<span class="note">*（支持jpg、jpeg、png、gif格式）</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center; height:60px;">
				<input type="submit" value="上传">&emsp;&emsp;
				<input type="button" value="关闭" onclick="window.close();">
			</td>
		</tr>
	</table>
	<input type="hidden" name="petUUID" value="${ param.petUUID }">
	</form>
	</div>

	<div id="msg" class="msg">${ msg }</div>

	<%@ include file="../footer.jsp" %>
  </body>
</html>