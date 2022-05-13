<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="cart" class="saymeow.CartBean"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="order" class="saymeow.OrderBean"/>
<jsp:useBean id="dorder" class="saymeow.DirectOrderBean"/>
<jsp:setProperty property="*" name="cart"/>
<%	
	String oid = request.getParameter("oid");
	int qty = Integer.parseInt(request.getParameter("qty"));
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String pname = request.getParameter("pname");
	int price1 = Integer.parseInt(request.getParameter("price1"));
	
	String flag = request.getParameter("flag");
	if(flag.equals("insert")){
		cart.setOid(oid);
		Vector<CartBean> vlist = cMgr.getCartList(oid);
		if(cMgr.searchCartList(oid, pnum)){
			cMgr.updateCart(qty, pnum);
		}else{
			cMgr.insertCart(cart);
		}
	}else if(flag.equals("direct")){
		dorder.setOid(oid);
		dorder.setQty(qty);
		dorder.setPnum(pnum);
		dorder.setPrice1(price1);
		dorder.setPname(pname);
		cMgr.insertDirectOrder(dorder);
	}
%>
<%if(flag.equals("insert")){%>
<script>
	alert("장바구니에 추가되었습니다.");
	location.href = "cartList.jsp";
</script>
<%}else if(flag.equals("direct")){%>
<script>
	alert("구매 페이지로 넘어갑니다.");
	location.href = "direct.jsp";
</script>
<%}%>