<!-- 구매처리페이지 -->
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
	alert("장바구니에서 삭제되었습니다.");
	location.href = "cartList.jsp";
</script>
<%
} else if (flag.equals("order")) {
%>

<!DOCTYPE html>
<html>
<head>
<title>결제하기</title>
<script src="saymeowScript.js"></script>
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp"%>
</head>
<body>
	<h1>결제하기</h1>
	<br>
	<br>
	<form method="post" name="chFrm" action="orderProc.jsp">
		<h3>[배송지 입력]</h3>
		<input name="address" size="22"><br><br>
		<input type="hidden" name="flag" value="cart"><br><br>
		
		<h3>[주문정보]</h3>
		<table border="1">
			<tr>
				<td width="100">순번</td>
				<td width="100">상품명</td>
				<td width="100">판매가</td>
				<td width="100">수량</td>
				<td width="100">주문금액</td>
			</tr>
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
				<td><%=cart.getPrice1()%>원</td>
				<td><%=cart.getQty()%></td>
				<td><%=total%>원</td>
				<input type="hidden" name="cch" value="<%=Integer.parseInt(snum[i])%>">
				<input type="hidden" name="cnum" value="<%=cart.getCnum()%>">
			</tr>
			<%
			} // --- for문 끝
			%>
		</table>
		<br><br>
		총 결제금액은 <%=allTotal %>원 입니다.
		<input type="button" value="취소" onclick="history.back()"> <input
			type="submit" value="결제">
	</form>
	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>
</body>
</html>
<%
} // -- if문 끝
%>