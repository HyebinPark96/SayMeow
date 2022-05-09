<!-- 관리자 댓글 한 개 단위 삭제 -->
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rcNum = UtilMgr.parseInt(request, "rcNum"); // rcNum 전달받기
	cMgr.deleteRComment(rcNum);
	
%>
<script>
	alert('<%=rcNum%>레코드가 삭제되었습니다!');
	location.href = "../reviewBoard.jsp";
</script>