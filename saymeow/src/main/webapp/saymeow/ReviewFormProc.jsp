<!-- 리뷰 작성 후 게시판으로 업로드하기 위한 처리페이지 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"></jsp:useBean>
<%
	rMgr.insertReview(request);
	response.sendRedirect("main.jsp");
%>