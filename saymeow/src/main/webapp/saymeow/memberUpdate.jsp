<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<%@ page import="java.util.*,saymeow.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" /> 
<html>
<head>
<title>ȸ������</title>
<link href="style.css" rel="stylesheet" type="text/css">
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
<body bgcolor="#996600">
	<br>

	
	<%
		MemberBean mBean = mMgr.getMember(id);
	%>
	<form name="regForm" method="post" action="memberUpdateProc.jsp" >
		<table id="level">
			<tr>
				<td id="levl2">
					<table id="level3">
						<tr align="center" bgcolor="#A13FFF">
							<td colspan="3"><font color="#FFFFFF"><b> <%=mBean.getName()%>
										ȸ������ ������ �����մϴ�.
								</b></font></td>
						</tr>
						<tr>
							<td>���̵�</td>
							<td><%=mBean.getId()%></td>
						</tr>
						<tr>
							<td>�н�����</td>
							<td><input name="pwd" value="<%=mBean.getPwd()%>"></td>
						</tr>
						<tr>
							<td>�̸�</td>
							<td><input name="name" value="<%=mBean.getName()%>"></td>
						</tr>
						<tr>
							<td>�������</td>
							<td><input name="birthday" size="6"
								value="<%=mBean.getBirthday()%>"> ex)830815</td>
						</tr>
						<tr>
							<td>��ȭ��ȣ</td>
							<td><input name="phone" value="<%=mBean.getPhone()%>"></td>
						</tr>
						<tr>
							<td>�̸���</td>
							<td><input name="email" size="30"
								value="<%=mBean.getEmail()%>"></td>
						</tr>
						<tr>
							<td>�ּ�</td>
							<td><input name="address" size="50"
								value="<%=mBean.getAddress()%>"></td>
						</tr>
						<tr>
							<td>������̸�</td>
							<td><input name="petname" value="<%=mBean.getPetName()%>"></td>
						</tr>
						<tr>
							<td>����̳���</td>
							<td><input name="petAge" value="<%=mBean.getPetAge()%>">ex)xxxx-xx-xx</td>
						</tr>
						<tr>
							<td>����̼���</td>
							<td>��<input type="radio" name="petGender" value="1"
								<%=mBean.getPetGender().equals("1") ? "checked" : ""%>> ��<input
								type="radio" name="petGender" value="2"
								<%=mBean.getPetGender().equals("2") ? "checked" : ""%>>
							</td>
						</tr>
						<tr>
							<td>�����ǰ��</td>
							<td><input name="Breed" value="<%=mBean.getPetBreed()%>"></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="submit"
								value="�����Ϸ�" class="lbtn"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
								<input type="reset" value="�ٽþ���" class="lbtn">
								<input type="button" value="ȸ��Ż��" onclick="location.href='deleteMember.jsp';"
								class="lbtn">
								</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="id" value="<%=id%>">
	</form>
	<%@ include file="bottom.jsp"%>
</body>
</html>
