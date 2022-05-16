<!-- ����ó�������� -->
<%@page import="saymeow.OrderBean"%>
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.CartBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cart" class="saymeow.CartBean" />
<jsp:useBean id="cMgr" class="saymeow.CartMgr" />
<jsp:useBean id="oMgr" class="saymeow.OrderMgr" />
<%
String pname = null;
pname = request.getParameter("pname");

String flag = request.getParameter("flag");

String snum[] = null;
snum = request.getParameterValues("cch");
String msg = "";

int allTotal = 0;

if (flag.equals("delete")) {
	for (int i = 0; i < snum.length; i++) {
		cMgr.deleteCart(Integer.parseInt(snum[i]));
	}
%>
<script>
	alert("��ٱ��Ͽ��� �����Ǿ����ϴ�.");
	location.href = "cartList.jsp";
</script>
<%
} else if (flag.equals("order")) {
%>

<!DOCTYPE html>
<html>
<head>
    <link rel='stylesheet' type='text/css' media='screen' href='css/cart.css'>
<title>�����ϱ�</title>
<script src="saymeowScript.js"></script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp"%>
</head>
<body>
	<section class="contents">
	<br><br>
	<h3>�����ϱ�</h3>
	<br><br>

	<form method="post" name="chFrm" action="orderProc.jsp">
		<h4>[����� �Է�]</h4>
		<input name="address" size="60"><br><br>
		<input type="hidden" name="flag" value="cart"><br><br>
		
		<h4>[�ֹ�����]</h4>
		<table border="1">
			<thead >
			<tr>
			<th>NO</th>
			<th>��ǰ��</th>
			<th>�ǸŰ�</th>
			<th>����</th>
			<th>�ݾ�</th>
			</tr>
			</thead>
			<%
			for (int i = 1; i < snum.length; i++) {
				cart = cMgr.checkCart(Integer.parseInt(snum[i]));
				int price = cart.getPrice1();
				int quantity = cart.getQty();
				int total = price * quantity;
				allTotal += total;
			%>
			<tr>
				<td><%=i%></td>
				<td><%=cart.getPname()%></td>
				<td><%=cart.getPrice1()%>��</td>
				<td><%=cart.getQty()%></td>
				<td><%=total%>��</td>
				<input type="hidden" name="cch" value="<%=Integer.parseInt(snum[i])%>">
				<input type="hidden" name="cnum" value="<%=cart.getCnum()%>">
			</tr>
			<%
			} // --- for�� ��
			%>
		</table>
		<br><br>
		�� �����ݾ��� <%=allTotal %>�� �Դϴ�.
		<input type="button" value="���" onclick="history.back()"> <input
			type="submit" value="����">
	</form>
	<!-- ��Ʈ��Ʈ�� JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>
	</section>
</body>
</html>
<%
} // -- if�� ��
%>