<%@page import="saymeow.DirectOrderBean"%>
<%@page import="saymeow.OrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<%
	String msg = "주문이 완료되었습니다.";
	String oid = request.getParameter("oid");
	int qty = Integer.parseInt(request.getParameter("qty"));
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String pname = request.getParameter("pname");
	int price1 = Integer.parseInt(request.getParameter("price1"));
	String address = request.getParameter("address");
	
	OrderBean order = new OrderBean();
	order.setOid(oid);
	order.setPnum(pnum);
	order.setQty(qty);
	order.setPname(pname);
	order.setOid(oid);
	order.setOaddress(address);
	
	oMgr.insertOrder(order);
	cMgr.deleteDirectOrder(oid);
	
%>
<script>
	alert("<%=msg%>");
	location.href="TESTCART.jsp";
</script>