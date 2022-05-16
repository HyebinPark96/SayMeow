<!-- 취합완료 -->
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
    <title>Index</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="css/direct.css">
    <!-- 부트스트랩 CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">    
<%@ include file="top2.jsp" %>
</head>
<body>
<%
	OrderBean oBean = oMgr.getDirectOrderList(id); // 현재 로그인한 id의 가장 최근 주문내역(바로주문내역) 1개 보여주기 위한 빈즈
	int pnum = oBean.getPnum();
	int price1 = oBean.getPrice1();
	int qty = oBean.getQty();
	String regDate = oBean.getRegdate();
	String pname = oBean.getPname();
	int onum = oBean.getOnum();
	String oid = oBean.getOid();
	String state = oBean.getState();
%>
<section class="contents">
<form method="post" name="doFrm" action="directOrderProc.jsp">
<div class="title"><br><br><h3>상품 바로 주문</h3><br></div>
<h4>아래 주문정보를 확인해주세요.</h4><br>

<table border="1">
<tr>
	<td width="100">주문번호</td>
	<td width="100">상품명</td>
	<td width="100">개당 판매가</td>
	<td width="100">수량</td>
	<td width="100">총 결제금액</td>
	<td width="100">주문날짜</td>
	<td width="100">현재상태</td>
	<td width="100">결제</td>
</tr>
<tr>
	<td><%=onum %>번</td>
	<td><%=pname%></td>
	<td><%=price1%>원</td>
	<td><%=qty%>개</td>
	<td><%=price1 * qty%>원</td>
	<td><%=regDate%></td>
	<td>
	<%if(state.equals("1")){%>
		결제 전</td>
	<td><input type="submit" value="결제하기"></td>
	<%} else if(state.equals("2")){ %>
	<td>결제완료(배송완료)</td>
	<td>완료</td>
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
