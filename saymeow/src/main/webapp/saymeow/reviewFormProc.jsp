<!-- 리뷰등록 처리페이지 -->
<%@page import="saymeow.ReviewMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
		// 레코드 추가
		if(rMgr.insertReview(request)){/*true 반환 -> 등록성공*/%>
			<script>
				alert('작성되었습니다!'); // 한글깨짐. JS인코딩 방법 생각해보기
				location.href="readMyReview.jsp";
			</script>
			<%} else if(!rMgr.insertReview(request)){/*false반환 -> 등록실패*/%>
				<script>
					alert('작성에 실패하였습니다.');
					history.back();
				</script>
			<%}
		
		if(rMgr.insertReview(request)){/*true 반환 -> 등록성공*/%>
			<script>
				alert('작성되었습니다!'); // 한글깨짐. JS인코딩 방법 생각해보기
				location.href="readMyReview.jsp";
			</script>
			<%} else if(!rMgr.insertReview(request)){/*false반환 -> 등록실패*/%>
				<script>
					alert('작성에 실패하였습니다.');
					history.back();
				</script>
			<%} %>

	
