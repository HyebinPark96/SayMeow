<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>
<jsp:setProperty property="*" name="rcBean"/>
<%
	cMgr.insertRComment(rcBean); // ��� �߰� �޼ҵ�
%>

<script>
	alert('����� �߰��߽��ϴ�.');
	location.href = "adminReviewBoard.jsp" // ../ : ������� �̵�
</script>