<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<html>
<head>
<title>saymeow</title>
<script src="script.js"></script>	
</head>
<!-- �ܺ� CSS -->						
<link rel="stylesheet" href="css/style.css">						
<link rel="stylesheet" href="css/styleTW.css">						
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="top.jsp"%>
<body >
<form name="regForm" method="post" action="memberProc.jsp">
<table id="level" >

<tr>  
	<td id="level2">
		<table id="level3">
		<tr align="center" bgcolor="#A13FFF" id="level4">
			<td colspan="3" id="level4">ȸ�� ����</td>
		</tr>
		<tr>
							<td width="16%">���̵�</td>
							<td width="57%"><input name="id" size="17"> <input
								type="button" value="ID�ߺ�Ȯ��"
								onClick="idCheck(this.form.id.value)" class="lbtn"></td>
							
						</tr>
						<tr>
							<td>�н�����</td>
							<td><input type="password" name="pwd" size="17"></td>
							
						</tr>
						<tr>
							<td>�н����� Ȯ��</td>
							<td><input type="password" name="repwd" size="17"></td>
							
						</tr>
						<tr>
							<td>�̸�</td>
							<td><input name="name" size="17"></td>
							
						</tr>
						
						<tr>
							<td>�������</td>
							<td><input name="birthday" size="27"> ex)830815</td>
							
						</tr>
						<tr>
						<td>��ȭ��ȣ</td>
						<td><input name="phone" size="27"></td>
						</tr>
						<tr>
							<td>�̸���</td>
							<td><input name="email" size="27"></td>
							
						</tr>
						<tr>
							<td>�ּ�</td>
							<td><input name="address" size="40"></td>
							
						</tr>
						<tr>
							<td>������̸�</td>
							<td><input name="petName" size="27"></td>
						</tr>
						<tr>
							<td>����̳���</td>
							<td><input name="petAge" size="27">xxxx-xx-xx/-�����Է�</td>
						
						</tr>
						<tr>
							<td>����̼���</td>
							<td>��<input type="radio" name="petGender" value="1" checked>
								��<input type="radio" name="petGender" value="2">
							</td>
						</tr>
						<tr>
							<td>�����ǰ��</td>
							<td><input name="petBreed" size="27"></td>
						
						</tr>
		<tr> 
							<td colspan="3" align="center"><input type="button"
								value="ȸ������" onclick="inputCheck()" class="lbtn"> &nbsp; &nbsp;
								&nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value="�������" onClick="location.href='login.jsp'" class="lbtn">
							</td>
		</tr>
		<tr>
</tr>
</table>
</td>
</tr>
</table>
</form>
	<%@ include file="bottom.jsp"%>
</body>
</html>

