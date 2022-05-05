<!-- 리뷰등록 처리페이지 -->
<!-- 대문자명 표기 틀렸음 -->
<%@page import="saymeow.ReviewMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%
	String pnum = request.getParameter("pnum");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	if(rMgr.insertReview(request)){/*true 반환 -> 등록성공*/%>
	<script>
		alert('a'); // 한글깨짐. JSP->JS인코딩 방법 생각해보기
		location.href="reviewBoard.jsp?pnum="+<%=pnum%>; // 상품상세페이지는 GET방식으로 pnum값 전달받음
	</script>
	<%} else if(!rMgr.insertReview(request)){/*false반환 -> 등록실패*/%>
		<script>
			alert('d');
			history.back();
		</script>
	<%}%>

	
