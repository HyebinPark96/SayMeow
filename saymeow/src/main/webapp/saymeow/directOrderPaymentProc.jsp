<!-- �ٷ��ֹ��� ���� ó�������� -->
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<%
	int onum = UtilMgr.parseInt(request, "onum");
	String oaddress = request.getParameter("oaddress");
	String state = request.getParameter("state");

	if(state=="1" || state.equals("1")){ // ������ ���¶��
		oMgr.updateDirectOrder(onum, oaddress); // ������� state ������Ʈ �޼ҵ�
	}
	
%>
<script>
	alert('���� �Ϸ�Ǿ����ϴ�!');
	location.href = "orderList.jsp";
</script>