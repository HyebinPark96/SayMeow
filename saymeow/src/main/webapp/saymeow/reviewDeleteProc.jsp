<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum");
	String filename = request.getParameter("filename");
	rMgr.deleteReview(rnum, filename);
	cMgr.deleteAllRComment(rnum);
	
	String msg = "�����Ǿ����ϴ�!";
	//cMgr.deleteRComment(rcNum); // ����� ���� 
%>

<script>
	alert('<%=msg%> : <%=rnum%>');
	location.href="reviewBoard.jsp";
</script>