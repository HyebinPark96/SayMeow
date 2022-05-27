<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>
<jsp:setProperty property="*" name="rcBean"/>
<%
	String comment = request.getParameter("comment"); // 댓글내용
	if(comment.trim().equals("")||comment==null){%>
		<script>
			alert('(공백제외) 1자 이상 댓글을 입력해주세요.');
			history.back();
		</script>
	<%} else {%>
		<script>
			alert('댓글을 추가했습니다.');
			location.href = "adminReviewBoard.jsp" // ../ : 이전경로 이동
		</script>
<%
		cMgr.insertRComment(rcBean); // 댓글 추가 메소드
	}
%>

