<!-- sendAccount.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr"/>
<%
		String id = request.getParameter("id");
		mMgr.sendAccount(id);
%>
<script>
	alert("������ �߼� �Ͽ����ϴ�.");
	location.href = "login.jsp";
</script>		