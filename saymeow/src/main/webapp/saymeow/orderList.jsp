<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<%
	//if(session.getAttribute("idKey")==null){
	//	response.sendRedirect("");
	//	return;
	//}
	int price = 0;
	int quantity = 0;
	int totalPrice = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title>주문 내역 조회</title>
<script>
	function allChk() {
		o = document.ofrm;
		if(o.allCh.checked/*체크이벤트*/){
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = true;
				if(o.och[i].disabled)
					o.och[i].checked = false;
			}
			o.btn.disabled = false;//버튼의 활성화
			o.btn.style.color = "blue";
		} else {
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = false;
			}
			o.btn.disabled = true;//버튼의 비활성화
			o.btn.style.color = "gray";
		}
	}
	function chk() {
		o = document.ofrm;
		for(i=1;i<o.och.length;i++){
			if(o.och[i].checked/*체크가 되었을때*/){
				o.btn.disabled = false;//버튼의 활성화
				o.btn.style.color = "blue";
				return;
			}//---if
		}//----for
		//for문에서 해결을 못 했을때 밑에 3줄이 실행.
		o.allCh.checked = false;
		o.btn.disabled = true;//버튼의 비활성화
		o.btn.style.color = "gray";
	}

</script>
</head>
	<body>
<!-- include top Start -->

<!-- include top End -->
<table>
<ul>
<ol><a href="orderList.jsp">주문 내역 조회</a></ol>
<ol><a href="">회원 정보 수정</a></ol>
<ol><a href="">내 리뷰 목록</a></ol>
<ol><a href="">회원 탈퇴</a></ol>
</ul>
<form name="ofrm" action="orderCancleProc.jsp">
<input type="hidden" name="och" value="0">
<h1>주문 내역 조회</h1>
</table>
		<table border="1" >
			<tr>
				<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
				<td>주문 번호</td>
				<td>주문 일자</td>
				<td>상품명</td>
				<td>주문 수량</td>
				<td>주문 금액</td>
				<td>주문 상태</td>
			</tr>
<!-- Is Empty Start -->
		<%
			Vector<OrderBean> vlist = oMgr.getOrderList("1");
			if(vlist.isEmpty()){
		%>
			<tr>
				<td colspan="5">주문하신 상품이 없습니다.</td>
			</tr>
<!-- Is Empty End -->
<!-- Vector List Start -->
		<%}else{
				for(int i=0;i<vlist.size();i++){
				OrderBean order = vlist.get(i);
				
				
				quantity = order.getQty();
				%>
			<tr>
				<td>
				<%if(order.getState().equals("5") || order.getState().equals("6")){ %>
				<input type="checkbox" name="och" value="<%=order.getOnum()%>" onclick="chk()" disabled>
				<%}else{ %>
				<input type="checkbox" name="och" value="<%=order.getOnum()%>" onclick="chk()">
				<%}%>
				</td>
				<td><%=order.getOnum()%></td>
				<td><%=order.getRegdate()%></td>
				<td><a href=""><%=order.getPname()%></a></td>
				<td><%=quantity%></td>
				<td>임시1</td>
				<td>
				<%
					switch(order.getState()){
						case"1": out.print("접수중");break;
						case"2": out.print("접수");break;
						case"3": out.print("배송준비");break;
						case"4": out.print("배송중");break;
						case"5": out.print("배송완료");break;
						case"6": out.print("주문취소");break;
					}
				%>
				</td>
			</tr>
				<%}//--for
		}//--else-if %>
<!-- Vector List End -->
		</table>
		<table>
		<input type="submit" name="btn" value="주문취소" disabled>
		</table>
		</form>
<!-- include bottom Start -->

<!-- include bottom End -->
	<form name="oDetail" method="post" action="">
		<input type="hidden" name="onum">
	</form>
</body>
</html>	 