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
							<td colspan="3"><font color="#FFFFFF"><b>회원 가입</b></font></td>
						</tr>
						<tr>
							<td width="16%">아이디</td>
							<td width="57%"><input name="id" size="17"> <input
								type="button" value="ID중복확인"
								onClick="idCheck(this.form.id.value)"></td>
							
						</tr>
						<tr>
							<td>패스워드</td>
							<td><input type="password" name="pwd" size="17"></td>
							
						</tr>
						<tr>
							<td>패스워드 확인</td>
							<td><input type="password" name="repwd" size="17"></td>
							
						</tr>
						<tr>
							<td>이름</td>
							<td><input name="name" size="17"></td>
							
						</tr>
						
						<tr>
							<td>생년월일</td>
							<td><input name="birthday" size="27"> ex)830815</td>
							
						</tr>
						<tr>
						<td>전화번호</td>
						<td><input name="phone" size="27"></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input name="email" size="27"></td>
							
						</tr>
						<tr>
							<td>주소</td>
							<td><input name="address" size="40"></td>
							
						</tr>
						<tr>
							<td>고양이이름</td>
							<td><input name="petName" size="27"></td>
						</tr>
						<tr>
							<td>고양이나이</td>
							<td><input name="petAge" size="27">xxxx-xx-xx/-포함입력</td>
						
						</tr>
						<tr>
							<td>고양이성별</td>
							<td>남<input type="radio" name="petGender" value="1" checked>
								여<input type="radio" name="petGender" value="2">
							</td>
						</tr>
						<tr>
							<td>고양이품종</td>
							<td><input name="petBreed" size="27"></td>
						
						</tr>
						<tr>
							<td colspan="3" align="center"><input type="button"
								value="회원가입" onclick="inputCheck()"> &nbsp; &nbsp;
								&nbsp; &nbsp; &nbsp; &nbsp; <input type="button" value="가입취소" onClick="location.href='login.jsp'">
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

