<!-- 리뷰등록 처리페이지 -->
<%@page import="saymeow.ReviewMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	if(rMgr.insertReview(request)){/*true 반환 -> 등록성공*/%>
	<script>
		alert('Yes'); // 한글깨짐. JS인코딩 방법 생각해보기
		location.href="reviewBoard.jsp?pnum=<%=pnum%>"; // 상품상세페이지는 GET방식으로 pnum값 전달받음
	</script>
	<%} else if(!rMgr.insertReview(request)){/*false반환 -> 등록실패*/%>
		<script>
			alert('No');
			history.back();
		</script>
	<%}%>

	
