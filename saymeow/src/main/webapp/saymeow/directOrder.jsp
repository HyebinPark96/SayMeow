
<!-- �ٷ��ֹ����� ���������� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr" />

<%
int onum = UtilMgr.parseInt(request, "onum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�����ϱ�</title>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp"%>
    <link rel='stylesheet' type='text/css' media='screen' href='css/directOrder.css'>
</head>
<body>
<br><br>
<div class="title"><h3>�����ϱ�</h3></div>
<br><br>

<section class="contents">
<form name="paymentFrm" action="directOrderPaymentProc.jsp" method="post">
		<h4>[����� �Է�]</h4><br>
		<input name="oaddress" size="100px" height="50px"><br><br>
		<br><br>
		<h4>[�ֹ�����]</h4><br>
	<table>
		<%
		OrderBean oBean = oMgr.getOrderDetail(onum); // �ֹ����� ��������
		%>
		<tr>
			<th width="100">��ǰ��</th>
			<th width="100">����</th>
			<th width="150">�� ������ �ݾ�</th>
		</tr>
		<tr>
			<td><%=oBean.getPname()%></td>
			<td><%=oBean.getQty()%>��</td>
			<td><%=oBean.getPrice1() * oBean.getQty()%>��</td>
		</tr>
		<tr>
			<td><br><br></td>
		</tr>
		<tr>
		<td colspan="3">
				<input type="hidden" name="onum" value="<%=oBean.getOnum()%>"> 
				<input type="hidden" name="state" value="<%=oBean.getState()%>">
				
				�� �����ݾ��� <%=oBean.getPrice1() * oBean.getQty()%> �� �Դϴ�.
				
				<input type="button" value="���" onclick="history.back()">
				<input type="submit" value="����">
			</td>
			</tr>
		</table>
		</form>
<br><br>
	<!-- ��Ʈ��Ʈ�� JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>
</section>
</bod>