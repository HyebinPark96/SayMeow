<%@page import="saymeow.CartBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cart" class="saymeow.CartBean"/>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<%
	String oid = request.getParameter("oid");
	String snum[] = request.getParameterValues("cch");
	String msg = "";
	String flag = request.getParameter("flag");
	int allTotal = 0;
	if(snum.length==1){
		msg = "���õ� ��ǰ�� �����ϴ�.";
	}else if(flag.equals("delete")){
		msg = "��ٱ��Ͽ��� �����Ǿ����ϴ�.";
		for(int i=0;i<snum.length;i++){
			cMgr.deleteCart(Integer.parseInt(snum[i]));
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<title>Order</title>
<%if(flag.equals("delete")||snum.length==1){ %>
<script>
	alert("<%=msg%>");
	location.href = "cartList.jsp";
</script>
</head>
<%}else if(flag.equals("order")){%>
<body>
<form method="post" name="chFrm" action="orderProc.jsp">
<h1>��� �Է�</h1>
<p>�����ּ�<p><input name="address" size="20">
<h1>���� ����</h1>
<table border="1">
<tr>
	<td>��ǰ��</td>
	<td>�ǸŰ�</td>
	<td>����</td>
	<td>�ֹ��ݾ�</td>
</tr>
<%for(int i=1;i<snum.length;i++){
	cart = cMgr.checkCart(Integer.parseInt(snum[i]));
	int price = cart.getPrice1();
	int quantity = cart.getQty();
	int total = price*quantity;
	allTotal += total;
	%>
<tr>
	<td><%=cart.getPname()%></td>
	<td><%=cart.getPrice1()%>��</td>
	<td><%=cart.getQty()%></td>
	<td><%=total%>��</td>
</tr>
<input type="hidden" name="cch" value="<%=Integer.parseInt(snum[i])%>">
<%}%>
</table>
<p>�� �ֹ��ݾ��� <%=allTotal%>�� �Դϴ�.</p>
<input type="button" value="���" onclick="history.back()">
<input type="submit" value="����">
</form>
</body>
<%}%>