<!-- 한 개 리뷰 불러오는 페이지 -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="rBean" class="saymeow.ReviewBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum"); // GET방식으로 rnum 전달받은 것 int형변환
	rBean = rMgr.getReview(rnum); // 빈즈에 셋팅하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>리뷰읽기</title>
<!-- 탑바텀 CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<script>
	function submitForDelete() { // 삭제용 폼 제출
		document.reviewReadFrm.action = "reviewDeleteProc.jsp"; // 액션 지정
		document.reviewReadFrm.submit(); // 제출
	}
</script>
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top.jsp" %>
</head>
<body>

	<div id="review-board-container" style="text-align:left;">
		<div class="review-section">
			<h3 class="title" style="text-align:center;">상품구매리뷰</h3>
			<!-- 리뷰 작성 폼 -->
			<!-- GET방식과 multipart 같이 사용 -->
			<form name="reviewReadFrm" method="post" 
			> <!-- 파일업로드 할 수도 있으므로 post로 보내기 -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">순번 :&nbsp</label>
  					<input name="rnum" value="<%=rBean.getRnum()%>" readonly>
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">제목 :&nbsp</label>
  					<input name="subject" value="<%=rBean.getSubject()%>" readonly>
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">내용 :&nbsp</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content"
  					maxlength="500" style="width:30vw;"readonly><%=rBean.getContent()%></textarea>
				</div>
				<%if(rBean.getFilename()!=null && !rBean.getFilename().trim().equals("")){/*파일업로드된 리뷰라면*/%>
					<div class="mb-3">
  						<label for="exampleFormControlInput1" class="form-label">
  							업로드 파일명 :&nbsp
  							<input name="filename" value="<%=rBean.getFilename()%>" readonly>
  						</label>
  						<label for="exampleFormControlInput1" class="form-label">
  							업로드 파일크기 :&nbsp
  							<input name="filesize" value="<%=rBean.getFilesize()%>" readonly>Byte
  						</label>
					</div>
				<%}else{%>
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">
							업로드 파일이 없습니다.
						</label>
					</div>
				<%}%>
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">
							별점 :&nbsp
							<input name="score" value="<%=rBean.getScore()%>" readonly>
						</label>
					</div>
				<input type="hidden" name="pnum" value="<%=rBean.getPnum()%>" readonly>
				
				<%if(id == rBean.getRid()){ /*로그인id와 리뷰작성자id 같다면*/%>
				<div class="d-grid gap-2 d-md-block" style="text-align:center;">
  					<input type="submit" class="btn btn-primary submitBtn" value="수정" >
				</div>
				<div class="d-grid gap-2 d-md-block" style="text-align:center;">
  					<input type="submit" class="btn btn-primary submitBtn" value="삭제" >
				</div>
				<%} else if(id=="admin"){%>
				<div class="d-grid gap-2 d-md-block" style="text-align:center;">
  					<input type="submit" class="btn btn-primary submitBtn" onclick="submitForDelete()" value="[관리자권한] 삭제">
				</div>
				<%} else{%>
					
				<%} %>
			</form>
		</div>
	</div>
	<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous">
</script>
<%@ include file="bottom.jsp"%>	
</body>
</html>