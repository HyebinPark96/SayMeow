<%@page contentType="text/html; charset=EUC-KR"%>
<%
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품등록</title>
<link rel='stylesheet' type='text/css' media='screen' href='../css/adminProduct.css'>	
</head>
<body>
<!-- 본문 -->
<section class="contents">
	<div class="plist">
		<h1>상품등록</h1><br><br><br>
		<form method="post" action="adminProductProc.jsp?flag=insert" enctype="multipart/form-data">		
		<table border="1">
<tr>
<td>상품이름</td>
<td><input name="pname" value=""></td>
</tr>
<tr>
<td>상품대분류</td>
		<td>
		<select name="mclass" style="width:100px">
		<option value="food">사료(food)</option>
		<option value="treat">간식(treat)</option>
		<option value="toy">장난감(toy)</option>
		<option value="litter">배변용품(litter)</option>
		</select>
		</td>
</tr>
<tr>
<td>상품중분류</td>
		<td>
		<select name="sclass" style="width:100px">
		<option value="dry">건식사료(dry)</option>
		<option value="wet">습식사료(wet)</option>
		<option value="snack">스낵(snack)</option>
		<option value="stick">스틱(stick)</option>
		<option value="pole">막대/낚싯대(pole)</option>
		<option value="plush">인형(plush)</option>
		<option value="sand">모래(sand)</option>
		<option value="box">화장실(box)</option>
		</select>
		</td>
</tr>
<tr>
<td>상품가격</td>
<td><input name="price1" value=""></td>
</tr>
<tr>
<td>상품원가</td>
<td><input name="price2" value=""></td>
</tr>
<tr>
<td>상품마진</td>
<td><input name="price3" value=""></td>
</tr>
<tr>
<td>상품이미지</td>
<td><input type="file" name="image"></td>
</tr>
<tr>
<td>상품상세이미지</td>
<td><input type="file" name="detail"></td>
</tr>
<tr>
<td>판매상태</td>
<td><input name="pstat" value="1"></td>
</tr>
<tr>
<td>상품재고</td>
<td><input name="stock"></td>
</tr>
</table><br><br><br>
		<button type="submit">상품등록</button><br><br><br>
		</form>
		</div>
		</section>
</body>
</html>