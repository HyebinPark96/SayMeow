<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rBean" class="saymeow.ReviewBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
	int rnum = rBean.getRnum();
	String msg = "�����Ǿ����ϴ�!";
	String filename = rBean.getFilename();
	rMgr.deleteReview(rnum, filename);
	//cMgr.deleteRComment(rcNum); // ����� ���� 
%>

<script>
	alert("<%=msg%> : <%=rnum%>, <%=rnum%>");
	location.href="reviewBoard.jsp";
</script>