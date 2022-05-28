<!-- ���տϷ� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="saymeow.DirectOrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>direct</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='css/direct.css'>
    <!-- ��Ʈ��Ʈ�� CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">    
<%@ include file="top2.jsp" %>
</head>
<body>
<%
	OrderBean oBean = oMgr.getDirectOrderList(id); // ���� �α����� id�� ���� �ֱ� �ֹ�����(�ٷ��ֹ�����) 1�� �����ֱ� ���� ����
	int pnum = oBean.getPnum();
	int price1 = oBean.getPrice1();
	int qty = oBean.getQty();
	String regDate = oBean.getRegdate();
	String pname = oBean.getPname();
	int onum = oBean.getOnum();
	String oid = oBean.getOid();
	String state = oBean.getState();
	String uPrice1 = UtilMgr.monFormat(price1);
	String total = UtilMgr.monFormat(price1*qty);
%>
<section class="contents">
<form method="post" name="doFrm" action="directOrderProc.jsp">
<div class="title">
<br><br><h3>[��ǰ �ٷ� �ֹ�]</h3><br><br>
</div>
<h5>�Ʒ� �ֹ������� Ȯ�����ּ���.</h5><br><br>
<table border="1">
<tr>
	<td width="100">�ֹ���ȣ</td>
	<td width="100">��ǰ��</td>
	<td width="100">���� �ǸŰ�</td>
	<td width="100">����</td>
	<td width="100">�� �����ݾ�</td>
	<td width="100">�ֹ���¥</td>
	<td width="100">�������</td>
	<td width="100">����</td>
</tr>
<tr>
	<td><%=onum %>��</td>
	<td><%=pname%></td>
	<td><%=uPrice1%>��</td>
	<td><%=qty %>��</td>
	<td><%=total%>��</td>
	<td><%=regDate%></td>
	
	<%if(state.equals("1")){%>
		<td>���� ��</td>
		<td><input type="submit" value="�����ϱ�"></td>
	<%} else if(state.equals("2")){ %>
		<td>�����Ϸ�(��ۿϷ�)</td>
		<td>�Ϸ�</td>
	<%}%>
	
</tr>
</table>
<input type="hidden" name="pname" value="<%=pname%>">
<input type="hidden" name="price1" value="<%=price1%>">
<input type="hidden" name="qty" value="<%=qty%>">
<input type="hidden" name="oid" value="<%=oid%>">
<input type="hidden" name="pnum" value="<%=pnum%>">
<input type="hidden" name="state" value="<%=state%>">
<input type="hidden" name="onum" value="<%=onum%>">
</form>
</section>
</body>				
</html>
