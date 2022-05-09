<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="rBean" class="saymeow.ReviewBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum");
	rBean = rMgr.getReview(rnum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Review Update</title>
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<!-- 혜빈 JS -->
<script src="scriptHB.js"></script>
<script>
	function updateFile(){
		document.getElementsByClassName('fileInsertForm')[0].style.display = "block";
	}
</script>
<!-- 외부 CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top.jsp" %>
</head>
<body>
	<div id="review-board-container" style="text-align:center;">
		<div class="review-section">
			<h3 class="title">리뷰 수정하기</h3>
			<!-- 리뷰 작성 폼 -->
			<!-- GET방식과 multipart 같이 사용 -->
			<form class="review-form" action="reviewUpdateProc.jsp?rnum=<%=rnum%>" method="post" 
			enctype="multipart/form-data"> <!-- 파일업로드 할 수도 있으므로 post로 보내기 -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">제목</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="제목을 입력하세요."
  					value="<%=rBean.getSubject()%>">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">내용</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content" maxlength="500"><%=rBean.getContent() %></textarea>
				</div>
				
				<!-- 파일 유지원하거나, 수정한다면 조건따라-->
				<%if(rBean.getFilename()!=null && !rBean.getFilename().equals("")){// 기존 파일 업로드 했었다면 %>
				<div class="mb-3">
 					<label for="exampleFormControlTextarea1" class="form-label">기존파일</label><br>
					<input type="image" src="storage/<%=rBean.getFilename()%>" width="100vw" height="100vh">
				</div>
				<%}%>
				
				<div>
					<label for="exampleFormControlTextarea1" class="form-label">▽▽ 파일변경을 원하면 아래 버튼을 클릭하세요. ▽▽</label><br>
					<input type="button" class="btn btn-primary" value="change" onclick="updateFile()">
				</div>
				<div class="mb-3 fileInsertForm" style="display:none;">
 					<input type="file" class="form-control" id="formFile" name="filename" value="<%=rBean.getFilename()%>">
				</div>
				<div>
					<%out.println("기존 별점 : " + rBean.getScore());%>
				</div>
				<span class="star">
  					★★★★★ <!-- 빈 별 -->
  					<span>★★★★★</span> <!-- 배경색 있는 별 -->
  					<!-- DB insert할때는 /2 해서 insert -->
  					<input type="range" oninput="star(this)" value="0" step="1" min="0" max="10" name="score"> <!-- 오픈소스 참고 -->
				</span>
				<input type="hidden" name="rnum" value="<%=rBean.getRnum()%>">
				<input type="hidden" name="onum" value="<%=rBean.getOnum()%>">
				<input type="hidden" name="rid" value="<%=rBean.getRid()%>">
				<input type="hidden" name="pnum" value="<%=rBean.getPnum()%>">
				<input type="hidden" name="date" value="<%=rBean.getDate()%>">
				<div class="d-grid gap-2 d-md-block">
  					<input type="submit" class="btn btn-primary submitBtn" value="수정하기">
				</div>
			</form>
		</div>
	</div>
<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>
<%@ include file="bottom.jsp" %>
</body>
</html>