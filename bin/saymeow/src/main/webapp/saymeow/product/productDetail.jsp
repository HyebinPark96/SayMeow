<!-- 취합완료, 더보기 예시는 테스트 못해봄 -> 더보기 접기 가능-->
<!-- (중요) 지우님이 만드신 saymeowScript.js가 우선순위로 작동하여서, 인화님의 로그인 체크 스크립트문 아예 실행X 안되는 문제 해결을 위해
지우님의 js파일 참조코드를 아예 빼버렸음. 
-->
<!-- image null 파일 없다고 뜸. -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.RCommentBean"%>
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pdMgr" class="saymeow.ProductDetailMgr" />
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr" />
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr" />
<jsp:useBean id="rcBean" class="saymeow.RCommentBean" />

<%
request.setCharacterEncoding("EUC-KR");
// pnum 값 받아오기 
int pnum = UtilMgr.parseInt(request, "pnum");


ProductBean pbean = pdMgr.getProduct(pnum);

int price1 = pbean.getPrice1();
String image = pbean.getImage();
String detail = pbean.getDetail();
String mClass = pbean.getMclass();
String cClass = pbean.getSclass();
String pname = pbean.getPname();
%>
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
totalRecord = rMgr.getTotalCountByPnum(keyField, keyWord, pnum); // 검색일 때만 keyField, keyWord 값 설정되어 있고, 아닐 때는 "" 값 가짐

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

<!doctype html>
<html>
<head>
<style>
img {
	display: block;
	margin: auto;
}

table, tr, td {
	border: none;
}

td, th {
	vertical-align: middle;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
}

.shop_info {
	display: flex;
	width: 1080px;
	height: 300px;
	margin: 10px auto 100px;
	border: 1px solid #000;
	border-radius: 20px;
	padding: 10px;
	align-items: center;
	justify-content: space-between;
}

.img_area {
	width: 200px;
	height: 200px;
	margin-left: 150px;
	overflow: hidden;
}

.img_area img {
	width: 100%;
}

.info_list {
	width: 200px;
	margin-lefT: 50px;
}

.info_list>div dt {
	display: block;
	width: 100px;
}

.info_list>div {
	display: flex;
	margin-bottom: 0px;
}

.info_list>div:nth-child(3) {
	margin-bottom: 25px;
}

.info_list>div dt {
	font-weight: 700;
	color: #888;
}

.info_list>div dd {
	font-weight: 700;
	color: #000;
}

.info_list input {
	vertical-align: top;
	text-align: center;
	border: 1px solid #777;
	border-right: none;
	width: 50px;
	height: 30px;
	background: transparent;
	font-size: 16px;
	font-weight: bold;
	box-sizing: border-box;
	color: #111;
	line-height: 25px;
	padding: 11px 0 9px 0;
	border-radius: 0;;
}

input {
	outline: none;;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.info_list .num_ {
	width: 15px;
	height: 30px;
	background-color: #eee;;
}

.info_list .num_ .btn_ {
	position: relative;
	width: 15px;
	height: 15px;
	display: block;
	border: 1px solid #777;
}

.info_list .num_ .btn_:after {
	position: absolute;
	width: 5px;
	height: 5px;
	border-top: 2px solid #000;
	content: "";
	display: block;
	border-right: 2px solid #000;
}

.info_list .count dd {
	display: flex;
}

.up:after {
	transform: rotate(-45deg);
	top: 4.5px;
	left: 4px;
}

.down:after {
	transform: rotate(135deg);
	top: 1.5px;
	left: 4px;
}

.btn_wrap {
	display: flex;
	margin-top: 100px;
	margin-right: 100px;
}

.btn_wrap .side_btn {
	width: 120px;
	height: 40px;
	background-color: #9598ca;
	display: block;
	text-align: center;
	margin-right: 10px;
	line-height: 40px;
	color: #fff;
	border-radius: 5px;
}

.detail {
	width: 1080px;
	height: 100px;
	margin: auto;
	overflow: hidden;
	position: relative;
	margin-bottom: 100px;
}

.show_btn {
	width: 100%;;
	height: 50px;
	background-color: #9598ca;
	line-height: 50px;
	text-align: center;
	margin: auto;
	cursor: pointer;
	position: absolute;
	bottom: 0;;
	font-size: 20px;
	font-weight: 700;
	color: #fff;
	display: none;
}

.detail>span {
	position: absolute;
	top: 0;
	left: 10px;
	font-weight: 700;
	font-size: 12px;
}

.detail.on {
	height: auto
}

.show_btn.show {
	display: block;
}

.review {
	width: 1080px;
	border-top: 1px solid #000;
	height: auto;
	margin: auto;
	overflow: hidden;
	position: relative;
	padding: 10px;
}

.review>span {
	position: absolute;
	top: 0;
	left: 10px;
	font-weight: 700;
	font-size: 12px;
}

.review .review_cate {
	text-align: right;
}

.review .review_cate a {
	color: #888
}

.review .review_cate span {
	margin: 0 5px;
}

.review_wrap {
	margin-top: 20px;
}

.review_wrap table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse
}

.review_wrap table tr {
	height: 40px;
	line-height: 40px;
}

.review_wrap table th {
	background-color: #eee;
	text-align: center;
}

.review_wrap table td {
	text-align: center;
	padding: 5px;
	border-bottom: 1px solid #aaa;
}

.review_wrap table td:nth-child(2) {
	text-align: left;
}

.review_wrap table td a {
	color: #000;;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.review_wrap table tr.re td a {
	margin-left: 10px;
}

.review_wrap table tr.re td a:before {
	content: "RE";
	color: #fff;
	background-color: #aaa;
	font-weight: 700;
	padding: 0 4px
}

.review_wrap table th {
	border-bottom: 1px solid #aaa;
}

.review_wrap table tbody tr:first-child, .review_wrap table tbody tr:first-child td
	{
	border-top: none;
}
</style>
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="../css/styleHB.css">

<script>
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
	document.listFrm.action = "productDetail.jsp";
	document.listFrm.submit(); // reload와 nowPage VALUE를 POST방식으로 전달하여 재귀호출
}

// 검색
function check() {
	if (document.searchFrm.keyWord.value == "") {
		alert("검색어를 입력하세요.");
		document.searchFrm.keyWord.focus();
		return;
	}
	document.searchFrm.submit();
}

// 게시글 읽기
function read(i) {
	// document.readFrm.rnum.value = rnum;
	// document.readFrm.action = "reviewRead.jsp"; // JS에서 action 지정 가능
	// document.readFrm.submit(); // 값 전달
	
	/*테스트 : 토글식으로 구현해보기*/
	if(document.getElementsByClassName('reviewDetail')[i].style.display = 'hidden'){
		document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block 대신 table-row해야 colspan 먹힘
	}
}
</script>
<!-- 혜빈 JS -->
<script src="../scriptHB.js"></script>
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
</head>
<body>
	<div sp-edit="text" style="padding: 1rem 0; text-align: center;"
		class="initialize" area="before"></div>
	<table width="75%" align="center">
		<form method="post" name="frmC" action="../cartInsertProc.jsp">
		<tr>
			<td align="center">
				<table width="95%" border="1">
					<tr>
						<td colspan="2" align="center"><font color="#FFFFFF"></font></td>
					</tr>
				</table>

				<div sp-edit="text" style="padding: 1rem 0; text-align: center;"
					class="initialize" area="before">
					<span sp-font="13" style="color: #333; margin-bottom: 20px;"><b>상품
							상세 페이지&nbsp;</b></span></br>
				</div>

				<div class="shop_info">
					<div class="img_area">
						<img src="../image/<%=image%>" alt="#">
					</div>
				
						<dl class="info_list">

							<div class="category">
								<dt>카테고리</dt>
								<dd><%=mClass%>
									>
									<%=cClass%></dd>
							</div>
							<div class="name">
								<dt>이름</dt>
								<dd><%=pname%></dd>
							</div>
							<div class="price">
								<dt>가격</dt>
								<dd class="cost"><%=price1%></dd>
								원
							</div>
							<div class="count">
								<dt>수량</dt>
								<dd>
									<input onkeyup="costCount()" type="number" value="1"
										autocomplete="off" min="0" name="qty">
									<div class="num_">
										<div class="btn_ up"></div>
										<div class="btn_ down"></div>
									</div>
								</dd>
							</div>

							<div>
								<dt>총 가격</dt>
								<dd class="last_cost">
									<span></span>원
								</dd>
							</div>

						</dl>

						<div class="btn_wrap">
							<form name="cartFrm">
								<input type="button" class="side_btn" value="장바구니"
									onclick="javascript:cartInsert(this.form)"> <input
									type="button" class="side_btn" value="구매하기"
									onclick="javascript:directOrder(this.form)"> <input
									type="hidden" name="flag" value="insert"> <input
									type="hidden" name="id" value="<%=id%>"> <input
									type="hidden" name="pnum" value="<%=pnum%>"> <input
									type="hidden" name="pname" value="<%=pname%>"> <input
									type="hidden" name="price1" value="<%=price1%>">
							</form>
						</div>
				</div>
				<div class="detail">
					<span>상품 상세 이미지</span> <img src="../image/<%=detail%>" alt="">
					<div class="show_btn show">더보기</div>
				</div>
				
				
				
				
				
				
				<!-- 리뷰페이지 Start -->
				<div class="review">
					<div class="review_wrap">
<%-- 						<table>
							<thead>
							<colgroup>
								<col width="5%">
								<col width="72.5%">
								<col width="10%">
								<col width="12.5%">
							</colgroup>
							<tr>
								<th>번호</th>
								<th>구매후기</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
							</thead>
							<tbody>

								<%
								/*  제품과 관련된 리뷰 데이터들을 모두 불러온다. */
								Vector<ReviewBean> reviewList = pdMgr.getReviewListByPnum(pnum);

								/* 리뷰 데이터가 존재한다면 */
								if (!reviewList.isEmpty()) {
									for (int i = 0; i < reviewList.size(); i++) {

										/* 리뷰 Bean에 각각 담아서 화면에 뿌려준다 */
										ReviewBean bean = reviewList.get(i);

										int rnum = bean.getRnum();
										String rid = bean.getRid();
										String date = bean.getDate();
										String subject = bean.getSubject();
								%>
								<tr>
									<td><%=rnum%></td>
									<td><%=subject%></td>
									<td><%=rid%></td>
									<td><%=date%></td>
								</tr>

								<%
								}
								}
								%>
							</tbody>
						</table> --%> <!-- 인화님거 -->
						
						<!-- 혜빈거 -->
							<div align="center" id="review-board">
		<br />
		<h2 class="review-board-topic">리뷰</h2> <!-- pnum의 리뷰라고 하고, 어차피 상품상세에서 pnum받아옴 -->
		<label>해당 상품은 총 <b><%=totalRecord%></b>개의 리뷰가 있습니다!</label>
		<br/>
		<table>
			<tr>
				<td>
					<!-- action 생략이므로 재귀호출 -->
					<form name="npFrm" method="post">
						<!-- select태그의 size속성 : 한번에 보일 옵션의 개수, onchange() : 아이템 바꿀 때마다 -->
						<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)" class="npFrm-td form-select form-select-numPerPage">
							<!-- 5,10,15,20 중 하나 -->
							<option value="5">5개씩 보기</option>
							<option value="10" selected>10개씩 보기</option>
							<option value="15">15개씩 보기</option>
							<option value="30">30개씩 보기</option>
						</select>
					</form> 
					<script>
						<!-- if) '20개 보기' 선택 후, 게시글 읽고 리스트로 돌아와도 기존 numPerPage 유지된 상태로 list.jsp 호출하기 위함-->
						document.npFrm.numPerPage.value = <%=numPerPage%>;
					</script>
				</td>
				<td width="600" align="right" class="npFrm-td">
					현재페이지 : <%=nowPage%> / 전체 페이지 : <%=totalPage%>
				</td>
			</tr>
		</table>
		<!-- 게시물 리스트 Start -->
		<table>
			<tr>
				<td align="center" colspan="2">
					<%
					// pnum에 맞는 리뷰만 가져오기
					Vector<ReviewBean> vlist = rMgr.getReviewListByPnum(keyField, keyWord, start, cnt, pnum);
					int listSize = vlist.size(); // 각 페이지가 담는 총 레코드갯수 (최대 10개, 마지막 페이지는 10 이하의 값을 가질 수도 있음)
					if (vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
					} else {
					%>
					<table class="table table-hover">
						<tr align="center" class="table-column">
							<th width="100">번 호</th>
							<th width="50">별 점</th>
							<th width="100">제 목</th>
							<th width="20">&nbsp;</th>
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
							pnum = bean.getPnum();
							String date = bean.getDate();
							String subject = bean.getSubject();
							String content = bean.getContent();
							double score = bean.getScore();
							String filename = bean.getFilename(); // 파일 업로드 한 경우 제목 옆 아이콘 뜨게
							int filesize = bean.getFilesize();

							// 리뷰 댓글 수 count
							int rCount = cMgr.getRCommentCount(rnum);
						%>
						<!-- 각 열(주제)에 맞는 값 반복문으로 들고옴 -->
						<tr align="center">
							<td><a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=totalRecord - start - i%></a></td><!-- 리뷰순번 : 가장 최신글이 위에 오는 구조 -->
							<td><a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=score%></a></td>
							<td align="left">
								<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=subject%></a> <!-- 리뷰제목 --> 
							</td>
							<td>								<%if (filename != null) {%>
									<img src="../img/file_icon1.png" width="15px" height="15px" align="middle"> <!-- 파일있으면 이모티콘 보임 -->
								<%}%>
								<%if (rCount > 0) {%> <!-- 댓글있다면 --> 
									<font color="red">(<%=rCount%>)</font> <!-- 빨간색으로 (댓글수) 보임 --> 
									<%}%></td>
							<td><%=rid%></td><!-- 리뷰작성자 -->
							<td><%=date%></td><!-- 리뷰작성날짜 -->
							
							<td>
								<%if(id.equals(rid) || id==rid || id=="admin" || id.equals("admin")){
									if(id.equals(rid) || id==rid){%>
									<form name="deleteReviewFrm" action="../reviewDeleteProc.jsp" method="post">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="filename" value="<%=filename%>">
										<input type="hidden" name="pnum" value="<%=pnum%>">
										<input type="hidden" name="keyField" value="<%=keyField%>">
										<input type="hidden" name="keyWord" value="<%=keyWord%>">
										<input type="hidden" name="nowPage" value="<%=nowPage%>">
										<input type="submit" class="btn btn-primary submitBtn" value="삭제">
									</form>	
									<%} else if(id=="admin" || id.equals("admin")){%>
									<form name="deleteReviewFrm" action="../reviewDeleteProc.jsp" method="post">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="pnum" value="<%=pnum%>">
										<input type="hidden" name="filename" value="<%=filename%>">
										<input type="hidden" name="keyField" value="<%=keyField%>">
										<input type="hidden" name="keyWord" value="<%=keyWord%>">
										<input type="hidden" name="nowPage" value="<%=nowPage%>">
										<input type="submit" class="btn btn-primary submitBtn" value="삭제">
									</form>
								<%}%>
							<%} %>
							</td>
						</tr>
						
						
						<!-- 리뷰누르면 페이지 이동없이 아래로 뜨도록 -->
					
						<tr style="display:none;" class="reviewDetail">
							<td colspan="7" width="500" align="center" style="margin:0 auto;">
								<br><h3>[리뷰]</h3><br>
								<form name="reviewDetailFrm" action="../reviewUpdate.jsp?rnum=<%=rnum%>" method="POST" class="reviewDetailFrm" style="text-align:left;">
									<input type="hidden" name="rnum" value="<%=rnum%>">
									<input type="hidden" name="onum" value="<%=onum%>">
									<input type="hidden" name="rid" value="<%=rid%>">
									<input type="hidden" name="pnum" value="<%=pnum%>">
									<input type="hidden" name="date" value="<%=date%>">
									<input type="hidden" name="subject" value="<%=subject%>">
									<input type="hidden" name="content" value="<%=content%>">
									<input type="hidden" name="score" value="<%=score%>">
									
									<br>작성자 ID : <%=rid%><br>
									작성날짜 : <%=date%><br>
									제목 : <%=subject%><br>
									내용 : <%=content%><br>
									별점 : <%=score%><br><br><br>
									<%if(filename!=null){ %>
										<img src="../storage/<%=filename%>" width="800vw" height="400vw" style="display:block; margin: 0 auto; object-fit: cover;"><br>
										<input type="hidden" name="filename" value="<%=filename%>">
									<%} %>
									<%if(id.equals(rid) || id==rid) { /*본인리뷰라면 수정버튼 활성화*/%>
										<input type="submit" class="btn btn-primary submitBtn" value="수정"><br>
									<%}%>
									<hr>
								</form>
								<h3>[댓글]</h3><br>
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
										<form name="commentListFrm" action="../admin/commentDeleteProc.jsp" method="POST" style="text-align:left;">
											<br>순번 : <%=j+1%><br>
											작성자 ID : <%=cid %><br>
											작성날짜 : <%=rcDate %><br>
											댓글내용 : <%=comment%><br>
											<%if(id=="admin" || id.equals("admin")){%> <!-- 관리자만 모든 댓글 삭제 가능 -->
											<input type="hidden" name="rcNum" value="<%=rcNum%>">
											<input type="submit" class="btn btn-primary submitBtn" value="삭제"><br>
											<%}%>
										</form>
									<%} %>
								<%} %>
									
							<%if(id.equals("admin")||id=="admin") {%>
								<form name="commentFrm" action="../admin/CommentInsertProc.jsp" method="post">
									<input type="hidden" name="rnum" value="<%=rnum%>">
									<input type="hidden" name="cid" value="<%=id%>">
									<input type="hidden" name="pnum" value="<%=pnum%>">
									<input type="text" name="comment">
									<input type="submit" class="btn btn-primary submitBtn" value="작성"><br>
								</form>
							<%}%>
							</td>
						</tr>
						<%} // --- for문%>
					</table> 
					<%} // ---if-else문%>
				</td>
			</tr>
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
 							<font color="#A13FFF"><%}%> [<%=pageStart%>] 
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
			<tr>
				<td colspan="6">
					<div style="text-align:center; margin: 2vw;">
						<form name="searchFrm" class="searchFrm">
							<select name="keyField" size="1" class="form-select" style="display:inline">
								<option value="rid">작성자 ID</option>
								<option value="subject">제 목</option>
								<option value="content">내 용</option>
							</select> <!-- 디폴트 text type --> 
							<input name="keyWord" size="16" class="form-control" style="display:inline"> 
							<input type="hidden" name="nowPage" value="1"> <!-- 검색 후 초기화 : 보통 검색 결과가 1페이지부터 보여지므로-->
							<input type="hidden" name="pnum" value="<%=pnum%>">
							<input type="button" value="검색" onclick="check()" class="btn btn-primary reviewSearchBtn">
						</form>
					</div>
				</td>
			</tr>
			<tr>
				<!-- '처음으로' 버튼 눌렀을 때 list()함수 호출 -> listFrm submut -> reload = true 전달 -> keyField, keyWord 초기화됨 -->
				<td style="text-align:right">
					<a href="javascript:list()" class="review-board-aTag"><button type="button" class="btn btn-primary" style="margin-bottom:1.5vh;">처음으로</button></a> 
				</td>
			</tr>
		</table>
		<!-- 게시물 리스트 End -->
		
		

		<!-- 처음으로 버튼 누르면 list() 메소드를 위해 post방식으로 전달 (초기화)-->
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
			<input type="hidden" name="pnum" value="<%=pnum%>">
		</form>

		<!-- 아래 값들을 GET방식으로 전달하며, 10개 15개 등 아이템 바꿀때마다 재귀호출 -->
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
			<input type="hidden" name="rnum">
			<input type="hidden" name="pnum" value="<%=pnum%>">
		</form>
	</div>	
					</div>
					<!-- 리뷰페이지 End -->		
					<input type="button" value="<BACK" onClick="history.go(-1)">
					<!-- 이전페이지로 돌아가기 -->
				</div>
			</td>
		</tr>
	</table>
	<script>
    window.onload = function () {
        costCount()

        const infoList = document.querySelector('.info_list');
        const btnU = document.querySelector('.up');
        const btnD = document.querySelector('.down');
        const btnS = document.querySelector('.show');
        const det = document.querySelector('.detail');
    	const basket = document.querySelector('#basket');
        const buyBtn = document.querySelector('#buyBtn');

        console.log(btnS.length)

        btnS.addEventListener('click', function(){
            if(det.classList.contains('on')){
                det.classList.remove('on');
                btnS.innerText = '더보기';
            }
            else{
                det.classList.add('on');
                btnS.innerText = '접기';
            }
        })

        btnU.addEventListener('click', function () {
            infoList.querySelector('input').value++;
            costCount();
        })
        btnD.addEventListener('click', function () {
            if(infoList.querySelector('input').value > 0){
                infoList.querySelector('input').value--;
                costCount();
            }
            
        })

    }
        
    function costCount() {
        const infoList = document.querySelector('.info_list');
        const infoItem = infoList.querySelector('.cost');
        const infoCost = infoList.querySelector('.last_cost');
        
        var cost = infoItem.innerText // 상품 가격
        var count = infoList.querySelector('input').value; // 상품 수량
        infoCost.querySelector('span').innerText = count * cost;
    }


     //cart
     function cartDelete(form){
    		form.flag.value="delete";
    		form.submit();
    }

     function cartOrder(form){
    		form.flag.value="order";
    		form.submit();
    }
     
     function cartInsert(form){ // 장바구니 버튼 클릭
    	const id = '<%=id%>';
    	if(<%=session.getAttribute("idKey")==null%>){ 
    		alert("로그인 후 이용해주세요.");
    		location.href="../login.jsp";
    	} else {
    		form.flag.value="insert";
    		form.submit();
    		location.href("../cartInsertProc.jsp"); // cartInsertProc.jsp -> OrderMgr
    	}
     }
     
    function directOrder(form){ // 주문하기 버튼 클릭
    	const id = '<%=id%>';
    	if(<%=session.getAttribute("idKey")==null%>){ 
    		alert("로그인 후 이용해주세요.");
    		location.href="../login.jsp";
    	} else {
    		form.flag.value = "direct";
    		form.submit();
    		location.href("../cartInsertProc.jsp");// cartInsertProc.jsp -> OrderMgr
    	}
    }
	</script>

</body>
</html>