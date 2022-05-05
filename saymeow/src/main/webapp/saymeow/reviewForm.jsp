<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%@ include file="top.jsp" %>
<%
/* 	int onum = Integer.parseInt(request.getParameter("onum"));
	int pnum = Integer.parseInt(request.getParameter("pnum")); */
	
	// 테스트
	int onum = 1;
	int pnum = 1; 
%>
	
	<%//if(id!=null){%> 
	<%if(true){%> <!-- 테스트 끝나면 위 코드로 수정하기 -->
	<div id="review-board-container">
		<div class="review-section">
			<h3 class="title">상품구매리뷰</h3>
			<!-- 리뷰 작성 폼 -->
			<!-- GET방식과 multipart 같이 사용 -->
			<form class="review-form" action="ReviewFormProc.jsp?pnum=<%=pnum%>" method="post" 
			enctype="multipart/form-data"> <!-- 파일업로드 할 수도 있으므로 post로 보내기 -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">제목</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="제목을 입력하세요.">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">내용</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content" maxlength="500"></textarea>
				</div>
				<div class="mb-3">
 					<input type="file" class="form-control" id="formFile" name="filename">
				</div>
				<span class="star">
  					★★★★★ <!-- 빈 별 -->
  					<span>★★★★★</span> <!-- 배경색 있는 별 -->
  					<!-- DB insert할때는 /2 해서 insert -->
  					<input type="range" oninput="star(this)" value="1" step="1" min="0" max="10" name="score"> <!-- 오픈소스 참고 -->
				</span>
				<input type="hidden" name="onum" value="<%=onum%>"> <!-- 마이페이지에서 들고오기 -->
				<input type="hidden" name="id" value="<%=id%>">
				<input type="hidden" name="pnum" value="<%=pnum%>">
				<div class="d-grid gap-2 d-md-block">
  					<input type="submit" class="btn btn-primary submitBtn" type="submit" value="글쓰기">
				</div>
			</form>
		</div>
	</div>
	
	<%} else {%>	
		<div id="review-board-container">
			<%out.println("로그인을 먼저 진행해주세요");%>
		</div>
	<%}%>
<%@ include file="bottom.jsp" %>