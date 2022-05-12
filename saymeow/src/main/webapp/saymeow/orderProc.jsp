<%@page import="saymeow.CartBean"%>
<%@page import="saymeow.OrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<%
	//String id = (String)session.getAttribute("idKey");
	String id = "1";
	
	
	String msg = "주문이 완료되었습니다.";
	String url = "cartList.jsp";
	String address = request.getParameter("address");
	String snum[] = request.getParameterValues("cch");
	OrderBean order = new OrderBean();
	CartBean cart = new CartBean();
	for(int i=0;i<snum.length;i++){
		cart = cMgr.checkCart(Integer.parseInt(snum[i]));
		order.setOaddress(address);
		order.setPnum(cart.getPnum());
		order.setQty(cart.getQty());
		order.setPname(cart.getPname());
		order.setId(cart.getId());
		oMgr.insertOrder(order);
		//delete 추가하기
		cMgr.deleteCart(cart.getCnum());
		
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>