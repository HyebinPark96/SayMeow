<!-- ���տϷ� -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<html>
<head>
<title>saymeow</title>
<script src="script.js"></script>
</head>
<!-- �ܺ� CSS -->
<link rel="stylesheet" href="css/styleTW.css">
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp"%>
<body id="memberbd">
	<form name="regForm" method="post" action="memberProc.jsp">
		<table class="regFormTb">

			<tr>
				<td>
				<h3 style="text-align:center"><br>ȸ������</h3><br>
					<table class="jointb">										
						<tr>
							<td style="padding:2px" width="16%">���̵�</td>
							<td style="padding:2px" width="57%">
								<input name="id" size="17"> 
								<input type="button" value="�ߺ�Ȯ��" onClick="idCheck(this.form.id.value)" 
								class="btn btn-primary checkIdBtn">
							</td>
						</tr>
						<tr>
							<td style="padding:2px">�н�����</td>
							<td style="padding:2px"><input type="password" name="pwd" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">�н����� Ȯ��</td>
							<td style="padding:2px"><input type="password" name="repwd" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">�̸�</td>
							<td style="padding:2px"><input name="name" size="17"></td>

						</tr>

						<tr>
							<td style="padding:2px">�������</td>
							<td style="padding:2px"><input name="birthday" size="17"> ex)830815</td>

						</tr>
						<tr>
							<td style="padding:2px">��ȭ��ȣ</td>
							<td style="padding:2px"><input name="phone" size="17"></td>
						</tr>
						<tr>
							<td style="padding:2px">�̸���</td>
							<td style="padding:2px"><input name="email" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">�ּ�</td>
							<td style="padding:2px"><input name="address" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">������̸�</td>
							<td style="padding:2px"><input name="petName" size="17"></td>
						</tr>
						<tr>
							<td style="padding:2px">����̳���</td>
							<td style="padding:2px"><input name="petAge" size="17"> xxxx-xx-xx/-�����Է�</td>

						</tr>
						<tr>
							<td style="padding:2px">����̼���</td>
							<td style="padding:2px">��<input type="radio" name="petGender" value="1" checked>
								��<input type="radio" name="petGender" value="2">
							</td>
						</tr>
						<tr>
							<td style="padding:2px">�����ǰ��</td>
							<td style="padding:2px"><input name="petBreed" size="17"></td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<div style="margin: 2vw;">
									<input type="button" value="ȸ������" onclick="inputCheck()" class="btn btn-primary"> 
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
									<input type="button" value="�������" onClick="location.href='login.jsp'" class="btn btn-primary">
								</div>
							</td>
						</tr>
						<tr>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<!-- ��Ʈ��Ʈ�� JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>

</body>
</html>

