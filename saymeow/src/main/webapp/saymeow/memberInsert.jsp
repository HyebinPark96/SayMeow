<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>   
<%@ page import="java.util.*,saymeow.*"%>
<%@page import="saymeow.MemberMgr" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<html>
<head>
<title>ȸ������ Ȯ��</title>
<script src="script.js"></script>
</head>
<body>
	<br>

	<%@ include file="top.jsp"%>

	<table width="75%" align="center" >
		<tr>
			<td align="center" bgcolor="#FFFFCC">

				<table width="95%" align="center"  border="1">
					<form name="regForm" method="post" action="memberProc.jsp">
						<tr align="center" >
							<td colspan="3"><font color="#FFFFFF"><b> <jsp:getProperty
											name="mBean" property="name" /> ȸ������ �ۼ��Ͻ� �����Դϴ�. Ȯ���� �ּ���
								</b></font></td>
						</tr>
						<tr>
							<td>���̵�</td>
							<td><input name="id"
								value="<jsp:getProperty name="mBean" property="id" />"></td>
						</tr>
						<tr>
							<td>�н�����</td>
							<td><input name="pwd"
								value="<jsp:getProperty name="mBean" property="pwd" />"></td>
						</tr>
						<tr>
							<td>�̸�</td>
							<td><input name="name"
								value="<jsp:getProperty name="mBean" property="name" />"></td>
						</tr>
						<tr>
							<td>�������</td>
							<td><input name="birthday"
								value="<jsp:getProperty name="mBean" property="birthday" />"></td>
						</tr>
						<tr>
							<td>��ȭ��ȣ</td>
							<td><input name="phone"
								value="<jsp:getProperty name="mBean" property="phone" />"></td>
						</tr>
					<tr>
						<td>�̸���</td>
						<td><input name="email" size="30"
							value="<jsp:getProperty name="mBean" property="email" />"></td>
					</tr>
					<tr>
						<td>�ּ�</td>
						<td><input name="address" size="50"
							value="<jsp:getProperty name="mBean" property="address" />"></td>
					</tr>
					<tr>
							<td>������̸�</td>
							<td><input name="petName"
								value="<jsp:getProperty name="mBean" property="petName" />"></td>
						</tr>
						<tr>
							<td>����̳���</td>
							<td><input name="petAge"
								value="<jsp:getProperty name="mBean" property="petAge" />"></td>
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
							<td><input name="petBreed"
								value="<jsp:getProperty name="mBean" property="petBreed" />"></td>
						</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="Ȯ�οϷ�"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input
							type="button" value="�ٽþ���" onClick="history.back()"></td>
					</tr>
					</form>
				</table>
			</td>
		</tr>
	</table>
	<%@ include file="bottom.jsp"%>
</body>
</html>
