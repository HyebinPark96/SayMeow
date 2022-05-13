<%@page import="saymeow.DirectOrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<body>
<%@ include file="top2.jsp" %>
<%	
	DirectOrderBean dorder = cMgr.selectDirectOrder(oid);
	String pname = dorder.getPname();
	int price1 = dorder.getPrice1();
	int qty = dorder.getQty();
	int pnum = dorder.getPnum();
%>
<form method="post" name="doFrm" action="directOrderProc.jsp">
<h1>배송 입력</h1>
<p>수취주소<p><input name="address" size="20">
<h1>구매 정보</h1>
<table border="1">
<tr>
	<td>상품명</td>
	<td>판매가</td>
	<td>수량</td>
	<td>주문금액</td>
</tr>
<tr>
	<td><%=pname %></td>
	<td><%=price1 %></td>
	<td><%=qty %></td>
	<td><%=price1*qty %></td>
</tr>
</table>
<input type="button" value="취소" onclick="history.back()">
<input type="submit" value="결제">

<input type="hidden" name="pname" value="<%=pname%>">
<input type="hidden" name="price1" value="<%=price1%>">
<input type="hidden" name="qty" value="<%=qty%>">
<input type="hidden" name="oid" value="<%=oid%>">
<input type="hidden" name="pnum" value="<%=pnum%>">
</form>
</body>