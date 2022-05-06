<!-- 깃헙으로 복붙하면 임포트 에러날 가능성있으므로, 에러나면 지우고 다시 임포트해오기 -->
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int totalRecord = 0; // 총 게시물 수
	int numPerPage = 10; // 한 페이지당 불러올 레코드 개수 (응용해서 5,10,15,30 기능 추가 예정)
	int pagePerBlock = 15; // 한 블럭당 총 15개 페이지 불러오기 (Ex. 한 블럭에 1~15페이지 나열)
	int totalPage = 0; // 총 페이지 개수
	int totalBlock = 0; // 총 블럭 개수 (15페이지씩 몇 블럭이 있는가?)
	int nowPage = 1; // 현재 페이지
	int nowBlock = 1; // 현재 블럭
	
	if(request.getParameter("numPerPage")!=null) { // x개씩보기 옵션 바꾸면 재귀호출되면서 다시 numPerPage 셋팅
		numPerPage = UtilMgr.parseInt(request, "numPerPage"); 
	}
	
	// 검색에 필요한 변수 
	String keyField = "", keyWord = ""; // 검색 전 디폴트
	if(request.getParameter("keyWord")!=null){ // 검색했다면
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	// 검색 후 '처음으로' 버튼 눌러야만 reload값이 전달되면서 검색 초기화된 상태로 재귀호출
	if(request.getParameter("reload")!=null&&request.getParameter("reload").equals("true")){
		keyField = "";
		keyWord = "";
	}
	
	// mgr getTotalCount 메소드 : 검색일 때 아닐 때 구분하여 SQL문 달리 작성되어 있음 
	totalRecord = rMgr.getTotalCount(keyField, keyWord); // 검색일 때만 keyField, keyWord 값 설정되어 있고, 아닐 때는 "" 값 가짐
	// out.println(totalRecord); // (테스트용) 1000 리턴
	
	// 페이지 클릭 OR 게시글 읽고 '리스트로' 클릭 -> GET방식으로 위치해있던 nowPage 전달 (+keyField, keyWord도 유지됨)
	if(request.getParameter("nowPage")!=null){ 
		nowPage = UtilMgr.parseInt(request, "nowPage"); 
	}
	
	// sql문 LIMIT에 들어가는 변수 선언 
	int start = (nowPage * numPerPage) - numPerPage; // 1페이지일때 0, 2페이지일때 10, 3페이지일때 20, ...
	int cnt =  numPerPage; // 디폴트 10개 (한 페이지당 보여지는 레코드 개수)
	
	// 전체 페이지 개수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage); // Ex. 게시물 663개 -> 레코드개수/10(66페이지) + 1(올림 : 마지막페이지에 10으로 나눈 후 나머지 게시글 수(3개) 들어가야 하므로)
	
	// 전체 블럭 개수
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock); // Ex. 총 67페이지 / 한 블럭당 15페이지 = 4.47 -> +1 (올림) 해서 5블럭
	
	// 현재 몇번째 블럭인지 
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); // Ex. 현재 1페이지 / 한 블럭당 15페이지
	
	// 테스트용
	// out.println("totalPage : "+ totalPage + "<br>");
	// out.println("totalBlock : "+ totalBlock + "<br>");
	// out.println("nowBlock : "+ nowBlock + "<br>");
	
%>
<!DOCTYPE html>
<html>
<head>
<title>SayMeow</title>
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<script type="text/javascript">
	// 페이징 처리
	function pageing(page) {
		document.readFrm.nowPage.value /*value 빼먹지말기*/ = page; // 매개변수로 받은 page를 nowPage의 값으로 요청
		document.readFrm.submit();
	}

	// 블럭 이동
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
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
		document.listFrm.action = "reviewBoard.jsp";
		document.listFrm.submit(); // reload와 nowPage post방식으로 전달하여 재귀호출
	}
	
	// 검색
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit(); // readFrm에 값들 전송
	}
	
	// 게시글 읽기
	function read(rnum) {
		document.readFrm.rnum.value = rnum;
		document.readFrm.action = "#";
		document.readFrm.submit();
	}
	
</script>
<!-- 혜빈 JS -->
<script src="scriptHB.js"></script>
<%@ include file="top.jsp" %>
<!-- 외부 CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
<div align="center"><br/>
<h2>리뷰보기</h2><br/>
<table>
	<tr>
		<td width="600">
		Total : <%=totalRecord%>Articles(<font color="red">
		<%=nowPage + "/" + totalPage%> Pages</font>)
		</td>
		<td align="right">
		<!-- action 생략이므로 재귀호출 -->
			<form name="npFrm" method="post">
			<!-- select태그의 size속성 : 한번에 보일 옵션의 개수, onchange() : 아이템 바꿀 때마다 -->
				<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)"> <!-- 5,10,15,20 중 하나 -->
    				<option value="5">5개 보기</option>
    				<option value="10" selected>10개 보기</option>
    				<option value="15">15개 보기</option>
    				<option value="30">30개 보기</option>
   				</select>
   			</form>
   			<script>
   			<!-- if) '20개 보기' 선택 후, 게시글 읽고 리스트로 돌아와도 기존 numPerPage 유지된 상태로 list.jsp 호출하기 위함-->
   				document.npFrm.numPerPage.value = <%=numPerPage%>;
   			</script>
		</td>
	</tr>
</table>
<!-- 게시물 리스트 Start -->
<table>
	<tr>
		<td align="center" colspan="2">
			<%
				Vector<ReviewBean> vlist = rMgr.getBoardList(keyField, keyWord, start, cnt);
				int listSize = vlist.size(); // 각 페이지가 담는 총 레코드갯수 (최대 10개, 마지막 페이지는 10 이하의 값을 가질 수도 있음)
				
				if(vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다."); 
				} else {
			%>
					<table cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0">
						<td width="100">번 호</td>
						<td width="250">제 목</td>
						<td width="100">아이디</td>
						<td width="150">날 짜</td>
					</tr>	
				<% 
				/* for문 if절의 조건인 i==listSize의 listSize는 LIMIT 함수로 게시글을 불러와서 담은 Vector의 크기이며,
				(마지막페이지 제외) 한 페이지당 listSize=10이므로 절대 if절 조건에 참값을 가질 수 없지만(i는 최대 9임),
				마지막페이지는 10미만의 레코드개수를 가질 수 있으므로, 그만큼만 반복문 돌리고 빠져나간다는 의미 */
					for(int i=0; i<numPerPage;/*10개*/ i++){
						if(i==listSize)
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
						int score = bean.getScore();
						String filename = bean.getFilename(); // 파일 업로드 한 경우 제목 옆 아이콘 뜨게
						int filesize=  bean.getFilesize();
						
						// 리뷰 댓글 수 count
						int rCount = cMgr.getRCommentCount(rnum);
				%>
				<!-- 각 열(주제)에 맞는 값 반복문으로 들고옴 -->
					<tr align="center">
						<td><%=totalRecord-start-i%></td> <!-- 리뷰순번 -->
						<td align="left">
							<a href="javascript:read('<%=rnum%>')">
							<%=subject%></a> <!-- 리뷰제목 -->
							<%if(filename!=null&&!filename.equals("")){ %>
								<img src="img/file_icon1.png" align="middle"> <!-- 파일있으면 이모티콘 보임 -->
							<%}%>
							<%if(rCount>0){%> <!-- 댓글있다면 -->
								<font color="red">(<%=rnum%>)</font> <!-- 빨간색으로 (댓글수) 보임 -->
							<%}%>
						</td>
						<td><%=rid%></td> <!-- 리뷰작성자 -->
						<td><%=date%></td> <!-- 리뷰작성날짜 -->
					</tr>
				<%} // --- for문%>
			</table>					
			<%} // ---if-else문 %>
		</td>
	</tr>
	<tr>
		<td colspan="2"><br><br>
	</tr>
	<tr>
		<td>
			<!-- 페이징 및 블럭 Start -->
			<!-- 이전블럭 이동(첫블럭에서는 없어야 함)-->
			<% if(nowBlock>1){%>
				<a href="javascript:block('<%=nowBlock-1/*이전블럭*/%>')">prev...</a>
			<%}%>
		
			<!-- 페이징(특정블럭) -->
			<%
			// 아래변수로 for문 돌리면 최초 1~16 -> 1~15까지 반복
				int pageStart = (nowBlock - 1) * pagePerBlock + 1; /*최초1부터시작 */
				int pageEnd = (pageStart + pagePerBlock /*15*/) < totalPage?pageStart+pagePerBlock:totalPage+1; /*마지막 블럭은 15페이지가 안될 수 있으므로 삼항연산자 사용*/
			
				// 반복문
				for(;pageStart<pageEnd;pageStart++){ // 비워진 조건 초기식은? pageStart = 1;부터 시작
			%>
				<a href="javascript:pageing('<%=pageStart%>')">
					<%if(pageStart==nowPage){%><font color="blue"><%}%>
						[<%=pageStart%>]
					<%if(pageStart==nowPage){%></font><%}%>	<!-- if절 두개인 이유: 조건에 맞아야만 font 코드 적용되도록-->
				</a>
			<%} // --- for%>
		
			<!-- 다음블럭 이동(마지막블럭에서는 없어야 함)-->
			<%if(totalBlock>nowBlock){%>
				<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
			<%}%>
			<!-- 페이징 및 블럭 End -->
		</td>
		<td align="right">
			<a href="javascript:list()">[처음으로]</a> <!-- 처음으로 버튼 눌렀을 때 list()함수 호출-> -->
		</td>
	</tr>
</table>
<!-- 게시물 리스트 End -->
<hr width="750">
<form name="searchFrm">
	<table width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
  				<select name="keyField" size="1">
  					<option value="name">이 름</option>
  					<option value="subject">제 목</option>
  					<option value="content">내 용</option>
  				</select> 
  				<!-- 디폴트 text type -->
  				<input name="keyWord" size="16">
  				<input type="hidden" name="nowPage" value="1"> <!-- 검색 후 초기화 : 보통 검색 결과가 1페이지부터 보여지므로-->
  				<input type="button" value="찾기" onclick="check()"> 
  			</td>
 		</tr>
	</table>
</form>

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
	<input type="hidden" name="rnum">
</form>
</div>
      
<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>
<%@ include file="bottom.jsp" %>
</body>
</html>