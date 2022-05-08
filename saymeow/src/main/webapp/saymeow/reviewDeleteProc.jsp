<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rBean" class="saymeow.ReviewBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
	int rnum = rBean.getRnum();
	String msg = "삭제되었습니다!";
	String filename = rBean.getFilename();
	rMgr.deleteReview(rnum, filename);
	//cMgr.deleteRComment(rcNum); // 댓글은 아직 
%>

<script>
	alert("<%=msg%> : <%=rnum%>, <%=rnum%>");
	location.href="reviewBoard.jsp";
</script>