<%@page contentType="text/html; charset=EUC-KR"%>
<%
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ���</title>
<link rel='stylesheet' type='text/css' media='screen' href='../css/adminProduct.css'>	
</head>
<body>
<!-- ���� -->
<section class="contents">
	<div class="plist">
		<h1>��ǰ���</h1><br><br><br>
		<form method="post" action="adminProductProc.jsp?flag=insert" enctype="multipart/form-data">		
		<table border="1">
<tr>
<td>��ǰ�̸�</td>
<td><input name="pname" value=""></td>
</tr>
<tr>
<td>��ǰ��з�</td>
		<td>
		<select name="mclass" style="width:100px">
		<option value="food">���(food)</option>
		<option value="treat">����(treat)</option>
		<option value="toy">�峭��(toy)</option>
		<option value="litter">�躯��ǰ(litter)</option>
		</select>
		</td>
</tr>
<tr>
<td>��ǰ�ߺз�</td>
		<td>
		<select name="sclass" style="width:100px">
		<option value="dry">�ǽĻ��(dry)</option>
		<option value="wet">���Ļ��(wet)</option>
		<option value="snack">����(snack)</option>
		<option value="stick">��ƽ(stick)</option>
		<option value="pole">����/���˴�(pole)</option>
		<option value="plush">����(plush)</option>
		<option value="sand">��(sand)</option>
		<option value="box">ȭ���(box)</option>
		</select>
		</td>
</tr>
<tr>
<td>��ǰ����</td>
<td><input name="price1" value=""></td>
</tr>
<tr>
<td>��ǰ����</td>
<td><input name="price2" value=""></td>
</tr>
<tr>
<td>��ǰ����</td>
<td><input name="price3" value=""></td>
</tr>
<tr>
<td>��ǰ�̹���</td>
<td><input type="file" name="image"></td>
</tr>
<tr>
<td>��ǰ���̹���</td>
<td><input type="file" name="detail"></td>
</tr>
<tr>
<td>�ǸŻ���</td>
<td><input name="pstat" value="1"></td>
</tr>
<tr>
<td>��ǰ���</td>
<td><input name="stock"></td>
</tr>
</table><br><br><br>
		<button type="submit">��ǰ���</button><br><br><br>
		</form>
		</div>
		</section>
</body>
</html>