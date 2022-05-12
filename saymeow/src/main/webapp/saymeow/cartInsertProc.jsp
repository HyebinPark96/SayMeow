<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="cart" class="saymeow.CartBean"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="order" class="saymeow.OrderBean"/>
<jsp:setProperty property="*" name="cart"/>
<%	
	String id = request.getParameter("id");
	int qty = Integer.parseInt(request.getParameter("qty"));
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String pname = request.getParameter("pname");
	int price1 = Integer.parseInt(request.getParameter("price1"));
	
	String flag = request.getParameter("flag");
	if(flag.equals("insert")){
		cart.setId(id);
		Vector<CartBean> vlist = cMgr.getCartList(id);
		if(cMgr.searchCartList(id, pnum)){
			cMgr.updateCart(qty, pnum);
		}else{
			cMgr.insertCart(cart);
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>Cart and Order</title>
<%if(flag.equals("insert")){%>
<script>
	alert("장바구니에 추가되었습니다.");
	location.href = "cartList.jsp";
</script>
<%}else if(flag.equals("direct")){%>
<body>
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
<input type="submit" value="결제">

<input type="hidden" name="pname" value="<%=pname%>">
<input type="hidden" name="price1" value="<%=price1%>">
<input type="hidden" name="qty" value="<%=qty%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="pnum" value="<%=pnum%>">
</form>
</body>
<%}%>