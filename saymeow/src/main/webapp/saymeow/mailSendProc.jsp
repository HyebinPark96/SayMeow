<!-- mailSend.jsp���� �޾ƿ� id�� email�� DB��ȸ -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mail" class="saymeow.MailSend"/>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	boolean result = mail.sendEmail(id, email);
	String msg = "���۽���";
	if(result) 
		msg = "���ۼ���";
%>
<script>
	alert("<%=msg%>");
	location.href="mailSend.jsp";
</script>