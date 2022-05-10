<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum");
	String filename = request.getParameter("filename");
	rMgr.deleteReview(rnum, filename);
	
	String msg = "삭제되었습니다!";
	//cMgr.deleteRComment(rcNum); // 댓글은 아직 
%>

<script>
	alert('<%=msg%> : <%=rnum%>');
	location.href="reviewBoard.jsp";
</script>