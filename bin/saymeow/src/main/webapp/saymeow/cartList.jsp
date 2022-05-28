<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<%
	int allTotal=0;
%>
<!DOCTYPE html>
<html>
<head>
    <link rel='stylesheet' type='text/css' media='screen' href='css/cart.css'>
<title>Cart List</title>
<script src="saymeowScript.js"></script>
    <!-- 부트스트랩 CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">    
<%@ include file="top2.jsp" %>
</head>
<body>
<section class="contents">
<form method="post" name="cfrm" action="cartProc.jsp">
<input type="hidden" name="cch" value="0">
<br><br>
<h3>내 장바구니</h3>
<br><br>
	<table id="carttb" border="1">
		<thead >
		<tr>
		<th><input type="checkbox" name="allCh" onclick="javascript:allChk()"></th>
		<th>NO</th>
		<th>상품명</th>
		<th>판매가</th>
		<th>수량</th>
		<th>금액</th>
		</tr>
		</thead>
		<tbody>
<!-- Is Empty Start -->
		<%
			Vector<CartBean> vlist = cMgr.getCartList(id);
			if(vlist.isEmpty()){
		%>
			<tr>
				<td colspan="6">장바구니에 추가한 상품이 없습니다.</td>
			</tr>
<!-- Is Empty End -->



<!-- Vector List Start -->
		<%}else{
			for(int i=0;i<vlist.size();i++){
			CartBean cart = vlist.get(i);
			int price = cart.getPrice1();
			int quantity = cart.getQty();
			int total = price*quantity;
			allTotal += total;
		%>
		<tr>
			<td><input type="checkbox" name="cch" value="<%=cart.getCnum()%>" onclick="javascript:chk()"></td>
			<td><%=i+1%></td>
			<td><%=cart.getPname()%></td>
			<td><%=UtilMgr.monFormat(price)%>원</td>
			<td><%=quantity%></td>
			<td><%=UtilMgr.monFormat(total)%>원</td>
		</tr>
			<%} // -- for문 끝
		}//-- if-else문 끝%>
		</tbody>
	</table>
	<!-- Vector List End -->
	
	
	<br><br>
	<table>
	<h2>장바구니의 총 금액은 <%=allTotal%>원 입니다</h2>
	</table>
	<input type="button" value="삭제" onclick="javascript:cartDelete(this.form)">
	<input type="button" value="주문하기" onclick="javascript:cartOrder(this.form)">
	<input type="hidden" name="flag" value="order">
	</form>
	</section>
</body>				
</html>

