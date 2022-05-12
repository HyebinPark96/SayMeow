<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="cart" class="saymeow.CartBean"/>
<jsp:setProperty property="*" name="cart"/>
<%	
	String id = request.getParameter("id");
	int qty = Integer.parseInt(request.getParameter("qty"));
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	cart.setId(id);
	Vector<CartBean> vlist = cMgr.getCartList(id);
	if(cMgr.searchCartList(id, pnum)){
		cMgr.updateCart(qty, pnum);
	}else{
		cMgr.insertCart(cart);
	}
	response.sendRedirect("TESTCART.jsp");
%>