<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%@ include file="top.jsp" %>
	<%if(id!=null){%>
	<div id="review-board-container">
		<div class="review-section">
			<h3 class="title">상품구매리뷰</h3>
			<!-- 리뷰 작성 폼 -->
			<form class="review-form" action="ReviewFormProc.jsp" method="post" enctype="multipart/form-data"> <!-- 파일업로드 할 수도 있으므로 post로 보내기 -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">제목</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="제목을 입력하세요.">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">내용</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content"></textarea>
				</div>
				<div class="mb-3">
 					<input class="form-control" type="file" id="formFile" name="file">
				</div>
				<div class="d-grid gap-2 d-md-block">
  					<button class="btn btn-primary submitBtn" type="button" onclick="javascript:send();">작성하기</button>
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