<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="saymeow.RCommentBean"%>
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 리뷰와 댓글 mgr 객체생성 -->
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr" />
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr" />
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 리뷰관리</title>

<!-- 혜빈 CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<!-- 혜빈 JS -->
<script src="scriptHB.js"></script>
<!-- 외부 CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp" %>
<% // 페이징 처리에 필요한 변수 선언
int totalRecord = 0; // 총 게시물 수 (최초 0개)
int numPerPage = 10; // 한 페이지당 불러올 레코드 개수 (디폴트 10개)
int pagePerBlock = 15; // 한 블럭당 총 15개 페이지 불러오기
int totalPage = 0; // 총 페이지 개수 (최초 0개)
int totalBlock = 0; // 총 블럭 개수
int nowPage = 1; // 현재 페이지 (최초 1페이지)
int nowBlock = 1; // 현재 블럭 (최초 1페이지 -> 1블럭에 위치)

if (request.getParameter("numPerPage") != null) { // x개씩보기 옵션 바꾸면 재귀호출되면서 다시 numPerPage 셋팅
	numPerPage = UtilMgr.parseInt(request, "numPerPage"); // 전달받은 numPerPage 값을 int형변환
}

// 검색 후 and 페이지 이동 시 재귀호출되므로 유지되어있음
String keyField = "", keyWord = ""; // 검색 전 디폴트
if (request.getParameter("keyWord") != null) { // 검색했다면
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

// 검색 후 '처음으로' 버튼 눌러야만 reload값이 전달되면서 검색 초기화된 상태로 재귀호출
if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
	keyField = "";
	keyWord = "";
}

// 최종 전체 리뷰 수 
totalRecord = rMgr.getTotalCountById(id); // 검색일 때만 keyField, keyWord 값 설정되어 있고, 아닐 때는 "" 값 가짐

// 페이지 클릭(list()함수) OR 게시글 읽고 '리스트로' 클릭 -> GET방식으로 위치해있던 nowPage 전달
if (request.getParameter("nowPage") != null) {
	nowPage = UtilMgr.parseInt(request, "nowPage");
}

// sql문 LIMIT에 들어가는 변수 선언 
int start = (nowPage * numPerPage) - numPerPage; // 1페이지일때 0, 2페이지일때 10, 3페이지일때 20, ...
int cnt = numPerPage; // 디폴트 10개 (한 페이지당 보여지는 레코드 개수)

// 전체 페이지 개수
totalPage = (int) Math.ceil((double) totalRecord / numPerPage); // Ex. 게시물 663개 -> 레코드개수/10(66페이지) + 1(올림 : 마지막페이지에 10으로 나눈 후 나머지 게시글 수(3개) 들어가야 하므로)

// 전체 블럭 개수
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // Ex. 총 67페이지 / 한 블럭당 15페이지 = 4.47 -> +1 (올림) 해서 5블럭

// 현재 몇번째 블럭인지 
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); // Ex. 현재 1페이지 / 한 블럭당 15페이지

%>



<script type="text/javascript">
// 페이징 처리
function pageing(page) {
	document.readFrm.nowPage.value /*value 빼먹지말기*/= page; // 매개변수로 받은 page를 nowPage의 값으로 요청
	document.readFrm.submit();
}

// 블럭 이동
function block(block) {
	document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1;
	// block=1 -> nowPage=0, block=2 -> nowPage=16, ...
	document.readFrm.submit();
}

// 한 페이지당 게시글 개수
function numPerFn(numPerPage) {
	document.readFrm.numPerPage.value = numPerPage;
	document.readFrm.submit(); // 재귀호출 시 변경된 numPerPage 전달
}

// (처음으로 버튼 눌러야만 실행되는 메소드) 목록 이동
function list() {
	document.listFrm.action = "readMyReview.jsp";
	document.listFrm.submit(); // reload와 nowPage VALUE를 POST방식으로 전달하여 재귀호출
}

// 검색
function check() {
	if (document.searchFrm.keyWord.value == "") {
		alert("검색어를 입력하세요.");
		document.searchFrm.keyWord.focus();
		return;
	}
	document.searchFrm.submit(); // action 없으므로 재귀호출
}

// 게시글 읽기
function read(i) {
	/*테스트 : 토글식으로 구현해보기*/
	if(document.getElementsByClassName('reviewDetail')[i].style.display = 'hidden'){
		document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block 대신 table-row해야 colspan 먹힘
	}
}

</script>
</head>
<body id="adminReviewBoard">
	<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="orderList.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문내역조회</button></a>
		<a href="memberUpdate.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원정보수정</button></a>
		<a href="readMyReview.jsp"><button class="nav-link active" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">내 리뷰 목록</button></a>
		<a href="deleteMember.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">회원탈퇴</button></a>
	</div>
    	<div align="center" id="review-board" style="margin:0 auto;">
		<br />
		<h2 class="review-board-topic">내가 작성한 리뷰</h2>
		<br/>
		<!-- 게시물 리스트 Start -->
		<table>
			<tr>
				<td align="center" colspan="2">
					<%
					// 로그인한 id의 리뷰목록만 보여준다!
					Vector<ReviewBean> vlist = rMgr.getReviewList(keyField, keyWord, start, cnt, id);
					int listSize = vlist.size(); // 각 페이지가 담는 총 레코드갯수 (최대 10개, 마지막 페이지는 10 이하의 값을 가질 수도 있음)
					if (vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
					} else {
					%>
						<table cellspacing="0" class="table table-hover">
							<tr align="center" class="table-column">
								<th width="100">번 호</th>
								<th width="100">별 점</th>
								<th width="200">제 목</th>
								<th width="100">아이디</th>
								<th width="100">날 짜</th>
								<th width="100">&nbsp;</th>
							</tr>
						<%
						/* for문 if절의 조건인 i==listSize의 listSize는 LIMIT 함수로 게시글을 불러와서 담은 Vector의 크기이며,
						(마지막페이지 제외) 한 페이지당 listSize=10이므로 절대 if절 조건에 참값을 가질 수 없지만(i는 최대 9임),
						마지막페이지는 10미만의 레코드개수를 가질 수 있으므로, 그만큼만 반복문 돌리고 빠져나간다는 의미 */
							for (int i = 0; i < numPerPage; /*10개*/ i++) {
								if (i == listSize)
									break;

								// vlist에서 순차적으로 가져와서 bean 객체 생성 후 담는다.
								ReviewBean bean = vlist.get(i);

								// bean에서 값 get
								int rnum = bean.getRnum();
								int onum = bean.getOnum();
								String rid = bean.getRid();
								int pnum = bean.getPnum();
								String date = bean.getDate();
								String subject = bean.getSubject();
								String content = bean.getContent();
								double score = bean.getScore();
								String filename = bean.getFilename(); // 파일 업로드 한 경우 제목 옆 아이콘 뜨게
								int filesize = bean.getFilesize();

								// 리뷰 댓글 수 count
								int rCount = cMgr.getRCommentCount(rnum);
								if(rid.equals(id)){
						%>
							<!-- 각 열(주제)에 맞는 값 반복문으로 들고옴 -->
							<tr align="center">
								<td><%=totalRecord - start - i%></td><!-- 리뷰순번 : 가장 최신글이 위에 오는 구조 -->
								<td><%=score%></td>
								<td align="left">
									<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=subject%></a> <!-- 리뷰제목 --> 
									<%if (filename != null) {%>
										<img src="img/file_icon1.png" width="15px" height="15px" align="middle"> <!-- 파일있으면 이모티콘 보임 -->
									<%}%>
									<%if (rCount > 0) {%> <!-- 댓글있다면 --> 
										<font color="red">(<%=rCount%>)</font> <!-- 빨간색으로 (댓글수) 보임 --> 
									<%}%>
								</td>
								<td><%=rid%></td><!-- 리뷰작성자 -->
								<td><%=date%></td><!-- 리뷰작성날짜 -->
								<td>
									<form name="deleteReviewFrm" action="myReviewDeleteProc.jsp" method="post">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="filename" value="<%=filename%>">
										<input type="submit" class="btn btn-primary submitBtn" value="삭제">
									</form>
								</td>
							</tr>
							<!-- 리뷰누르면 페이지 이동없이 아래로 뜨도록 -->
							<tr style="display:none; text-align:left" class="reviewDetail">
								<td colspan="6" align="left" style="">
									<form name="reviewDetailFrm" action="reviewUpdate.jsp?rnum=<%=rnum%>" method="POST" class="reviewDetailFrm">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="onum" value="<%=onum%>">
										<input type="hidden" name="rid" value="<%=rid%>">
										<input type="hidden" name="pnum" value="<%=pnum%>">
										<input type="hidden" name="date" value="<%=date%>">
										<input type="hidden" name="subject" value="<%=subject%>">
										<input type="hidden" name="content" value="<%=content%>">
										<input type="hidden" name="score" value="<%=score%>">
									
										<br><h4 style="text-align:center">[리뷰]</h4><br>
										작성자 ID : <%=rid%><br>
										작성날짜 : <%=date%><br>
										제목 : <%=subject%><br>
										내용 : <%=content%><br>
										별점 : <%=score%><br>
										<%if(filename!=null){ %>
											<img src="storage/<%=filename%>" width="800vw" height="400vw" style="display:block; margin: 0 auto; object-fit: cover;"><br><br>
											<input type="hidden" name="filename" value="<%=filename%>">
										<%} %>
										<%if(id.equals(rid) || id==rid) { /*본인리뷰라면 수정버튼 활성화*/%>
											<br><input type="submit" class="btn btn-primary submitBtn" value="수정" style="font-size:0.8em;">
										<%}%>
										<hr>
									</form>
									<h4 style="text-align:center">[댓글]</h4><br>
									<%
									Vector<RCommentBean> cvlist = cMgr.listRComment(rnum);
									for(int j=0; j<cvlist.size(); j++){
										rcBean = cvlist.get(j);
										
										int rcNum = rcBean.getRcNum();
										String cid = rcBean.getCid();
										String rcDate = rcBean.getRcDate();
										String comment = rcBean.getComment();
										
										if(!cvlist.isEmpty()) {
									%>
										<form name="commentListFrm" action="admin/commentDeleteProc.jsp" method="POST">
											순번 : <%=j+1%><br>
											작성자 ID : <%=cid %><br>
											작성날짜 : <%=rcDate %><br>
											댓글내용 : <%=comment%><br>
											<%if(id=="admin" || id.equals("admin")){%> <!-- 관리자만 모든 댓글 삭제 가능 -->
											<input type="hidden" name="rcNum" value="<%=rcNum%>">
											<input type="submit" class="btn btn-primary submitBtn" value="삭제">
											<%}%>
											<br><br>
										</form>
										<%} %>
									<%} %>
								</td>
							</tr>
						<%} //-- if(rid==id)문%>
					<%} // --- for문%>
					</table> 
				<%} // ---if-else문%>
			</td>
		</tr>
		<%if(totalRecord>1){ %>
		<%-- <%out.println(totalRecord); %> 테스트용 !! --%>
		<tr>
			<td align="center" style="font-size:1em;">
				<!-- 페이징 및 블럭 Start --> 
				<!-- 이전블럭 이동(첫블럭에서는 없어야 함)--> 
				<%if (nowBlock > 1) {%>
					<a href="javascript:block('<%=nowBlock - 1/*이전블럭*/%>')" class="review-board-aTag">&nbsp;이 전&nbsp;</a> 
				<%}%> <!-- 페이징(특정블럭) --> 
				<%// 아래변수로 for문 돌리면 최초 1~16 -> 1~15까지 반복
				int pageStart = (nowBlock - 1) * pagePerBlock + 1; /*최초1, 16, 31, ...*/
				/*마지막 블럭은 15페이지가 안될 수 있으므로 삼항연산자 사용*/
				int pageEnd = (pageStart + pagePerBlock /*15*/) < totalPage ? pageStart + pagePerBlock : totalPage + 1; 

 				// 반복문 (15번씩 반복, 마지막 블럭에서는 91~101페이지까지만 반복됨)
 				for (; pageStart < pageEnd; pageStart++) { // 비워진 조건 초기식은? pageStart = 1;부터 시작%> 
 					<a href="javascript:pageing('<%=pageStart%>')" class="review-board-aTag"> 
 						<%if (pageStart == nowPage) {%>
 								<font color="#A13FFF">
 						<%}%> 
 						[<%=pageStart%>] 
						<%if (pageStart == nowPage) {%>
							</font>
						<%}%> <!-- if절 두개인 이유: 조건에 맞아야만 font 코드 적용되도록-->
						</a> 
					<%} // --- for%> 
					<!-- 다음블럭 이동 기능 (마지막블럭만 없는 기능)--> 
					<%if (totalBlock > nowBlock) {%>
						<a href="javascript:block('<%=nowBlock + 1%>')" class="review-board-aTag">&nbsp;다 음&nbsp;</a> 
					<%}%> 
					<!-- 페이징 및 블럭 End -->
				</td>
			</tr>
			<%} // --totalRecord>1 if문 %>
				<tr>
					<!-- '처음으로' 버튼 눌렀을 때 list()함수 호출 -> listFrm submit -> reload = true 전달 -> keyField, keyWord 초기화됨 -->
					<td style="">
						<a href="javascript:list()" class="review-board-aTag"><button type="button" class="btn btn-primary" style="margin:1vw;">처음으로</button></a> 
					</td>
				</tr>
			</table>
			<!-- 게시물 리스트 End -->
			
			
			<!-- 처음으로 버튼 누르면 list() 메소드를 위해 post방식으로 전달 (초기화)-->
			<form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true"> 
				<input type="hidden" name="nowPage" value="1">
			</form>

			<!-- 아래 값들을 GET방식으로 전달하며, 10개 15개 등 아이템 바꿀때마다 재귀호출 -->
			<form name="readFrm">
				<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
				<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
				<input type="hidden" name="keyField" value="<%=keyField%>"> 
				<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
			</form>
		</div>
	</div>
</body>
</html>