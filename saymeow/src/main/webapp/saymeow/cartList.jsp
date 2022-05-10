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
<title>Cart List</title>
<script>
	function allChk() {
		c = document.cfrm;
		if(c.allCh.checked/*체크이벤트*/){
			for(i=1;i<c.cch.length;i++){
				c.cch[i].checked = true;
				if(c.cch[i].disabled)
					c.cch[i].checked = false;
			}
			c.btn.disabled = false;//버튼의 활성화
			c.btn.style.color = "blue";
		} else {
			for(i=1;i<c.cch.length;i++){
				c.cch[i].checked = false;
			}
			c.btn.disabled = true;//버튼의 비활성화
			c.btn.style.color = "gray";
		}
	}
	function chk() {
		c = document.cfrm;
		for(i=1;i<c.cch.length;i++){
			if(c.cch[i].checked/*체크가 되었을때*/){
				c.btn.disabled = false;//버튼의 활성화
				c.btn.style.color = "blue";
				return;
			}//---if
		}//----for
		//for문에서 해결을 못 했을때 밑에 3줄이 실행.
		c.allCh.checked = false;
		c.btn.disabled = true;//버튼의 비활성화
		c.btn.style.color = "gray";
	}

</script>
</head>
<body>
<form name="cfrm" action="cartDeleteProc.jsp">
<input type="hidden" name="cch" value="0">
<h1>내 장바구니</h1>
	<table>
		<tr>
		<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
		<td>NO</td>
		<td>상품명</td>
		<td>판매가</td>
		<td>수량</td>
		<td>금액</td>
		</tr>
<!-- Is Empty Start -->
		<%
			Vector<CartBean> vlist = cMgr.getCartList("1");
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
			<td><input type="checkbox" name="cch" value="<%=cart.getCnum()%>" onclick="chk()"></td>
			<td><%=i+1%></td>
			<td><%=cart.getPname()%></td>
			<td><%=price%></td>
			<td><%=quantity%></td>
			<td><%=total%></td>
		</tr>
		
			<%}
		}%>
	</table>
	<!-- Vector List End -->
	<table>
	<h1>장바구니의 총 금액은 <%=allTotal%>원 입니다</h1>
	</table>
	<table>
	<input type="submit" name="btn" value="삭제" disabled>
	<a href="orderProc.jsp"><input type="button" name="order" value="주문하기"></a>
	</table>
	</form>
</body>
</html>



