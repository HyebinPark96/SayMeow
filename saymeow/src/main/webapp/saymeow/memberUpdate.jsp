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
<body bgcolor="#996600">
	<br>

	<%@ include file="top.jsp"%>
	<%
		MemberBean mBean = mMgr.getMember(id);
	%>
	<form name="regForm" method="post" action="memberUpdateProc.jsp" >
		<table width="75%" align="center" bgcolor="#FFFF99">
			<tr>
				<td align="center" bgcolor="#FFFFCC">
					<table width="95%" align="center" bgcolor="#FFFF99" border="1">
						<tr align="center" bgcolor="#996600">
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
								value="�����Ϸ�"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
								<input type="reset" value="�ٽþ���">
								<input type="button" value="ȸ��Ż��" onclick="location.href='deleteMember.jsp';">
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
