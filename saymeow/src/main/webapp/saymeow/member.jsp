<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<title>saymeow</title>
<script src="script.js"></script>
</head>

<body bgcolor="#996600" topmargin="100">

	<%@ include file="top.jsp"%>

	<table width="75%" align="center" bgcolor="#FFFF99">
		<tr>
			<td align="center" bgcolor="#FFFFCC">

				<table width="95%" align="center" bgcolor="#FFFF99" border="1">
					<form name="regForm" method="post" action="memberInsert.jsp">
						<tr align="center" bgcolor="#996600">
							<td colspan="3"><font color="#FFFFFF"><b>ȸ�� ����</b></font></td>
						</tr>
						<tr>
							<td width="16%">���̵�</td>
							<td width="57%"><input name="id" size="17"> <input
								type="button" value="ID�ߺ�Ȯ��"
								onClick="idCheck(this.form.id.value)"></td>
							
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
								value="ȸ������" onclick="inputCheck()"> &nbsp; &nbsp;
								&nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value="�������" onClick="location.href='login.jsp'">
							</td>
						</tr>
					</form>
				</table>
			</td>
		</tr>
	</table>
	<%@ include file="bottom.jsp"%>
</body>
</html>

