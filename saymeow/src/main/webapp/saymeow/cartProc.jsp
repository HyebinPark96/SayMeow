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
		msg = "선택된 물품이 없습니다.";
	}else if(flag.equals("delete")){
		msg = "장바구니에서 삭제되었습니다.";
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
<%for(int i=1;i<snum.length;i++){
	cart = cMgr.checkCart(Integer.parseInt(snum[i]));
	int price = cart.getPrice1();
	int quantity = cart.getQty();
	int total = price*quantity;
	allTotal += total;
	%>
<tr>
	<td><%=cart.getPname()%></td>
	<td><%=cart.getPrice1()%>원</td>
	<td><%=cart.getQty()%></td>
	<td><%=total%>원</td>
</tr>
<input type="hidden" name="cch" value="<%=Integer.parseInt(snum[i])%>">
<%}%>
</table>
<p>총 주문금액은 <%=allTotal%>원 입니다.</p>
<input type="button" value="취소" onclick="history.back()">
<input type="submit" value="결제">
</form>
</body>
<%}%>