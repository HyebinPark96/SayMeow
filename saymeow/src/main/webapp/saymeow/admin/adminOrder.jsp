<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="aoMgr" class="saymeow.AdminOrderMgr"/>
<%
	request.setCharacterEncoding("EUC-KR"); // get방식 한글처리
	
	/* 페이징 처리에 필요한 변수 선언 [디폴트로 셋팅해둠] */
	int totalRecord = 0; // 총 게시글 수
	int pagePerBlock = 15; // 한 블럭당 페이지 수
	int numPerPage = 10; // 한 페이지당 게시글 수
	
	int nowPage = 1; // 현재페이지 
	int nowBlock = 1; // 현재블럭 
	
	int totalPage = 0; // 전체 페이지 수
	int totalBlock = 1; // 전체 블럭 수
	
	
	if(request.getParameter("numPerPage")!=null){
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	
	// 디폴트 검색 안함
	String keyField = "";
	String keyWord = "";
	
	// 검색했다면 
	if(request.getParameter("keyWord")!=null) { // 그냥 keyword !=null 적는 오류 주의
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	totalRecord = aoMgr.getCountRecord(keyField, keyWord);
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	// 가장 최신글이 첫페이지에 보이도록 Mgr에 ORDER BY onum DESC 정렬 -> 첫 페이지의 start는 반대로 가장 낮은 수가 되어야 onum 높은 순으로 불러오기 가능함
	int start = (nowPage * numPerPage) - numPerPage; // 1페이지일때 0, 2페이지일때 10, 3페이지일때 20, ...
	int cnt = numPerPage;
	

	

	
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage); // 올림
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); // 올림
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock); // 올림
	



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="../css/styleHB.css">
<!-- 혜빈 JS -->
<script src="../scriptHB.js"></script>
<!-- 내부스크립트 -->
<script>
	function search(){ // 검색기능
		if (document.searchOrderFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchOrderFrm.keyWord.focus();
			return;
		}
		document.searchOrderFrm.submit();
	}
	
	function reset(){
		keyField = ""; // 초기화
		keyWord = ""; // 초기화
		document.resetOrderFrm.submit(); // 재귀호출
	}
	
	function pageing(page){ // 페이지이동기능
		document.readFrm.nowPage.value = page; // 페이지 a태그의 value값이 nowPage가 됨
		document.readFrm.submit(); // 재귀호출
	}
	
	function block(block){ // 다음OR이전 블럭이동기능 (1->16페이지->31페이지)
		document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1; // 다음 OR 이전 a태그의 블럭(+1 OR -1)값이 nowBlock이 됨
		document.readFrm.submit(); // 재귀호출
	}
	
	
	function allCheck(){ // 전체선택기능
		if(document.getElementsByClassName('allCheckChb')[0].checked == true){
			for(var i=0;i<<%=numPerPage%>;i++) {
				document.getElementsByName("chb")[i].checked=true; //name 을 사용하여 배열 형태로 담아 호출
			}
		}
		if(document.getElementsByClassName('allCheckChb')[0].checked == false){
			for(var i=0;i<<%=numPerPage%>;i++){
				document.getElementsByName("chb")[i].checked=false; //name 을 사용하여 배열 형태로 담아 호출
			}
		}
	}
	
	// 체크박스 레코드 삭제기능 
	function deleteCheckedBox(){
		var checkedBox = new Array();
		for(var i=0;i<<%=numPerPage%>;i++){
			if(document.getElementsByName("chb")[i].checked){
				console.log("checkedBox 배열의 " + i + "번째 인덱스 : " + checkedBox[i]);
				document.deleteFrm.onum.value += (document.getElementsByName("chb")[i].value+";");
			}
		}
		console.log(document.deleteFrm.onum.value);
		document.deleteFrm.action = "deleteOrderProc.jsp?";
		document.deleteFrm.submit();
	}
	
	
	
	
</script>
<!-- 외부 CSS -->
<link rel="stylesheet" href="../css/style.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top.jsp" %>
</head>
<body id="adminOrder">
<!-- 사이드바 40%, 창 60% -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="adminOrder.jsp"><button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문관리</button></a>
		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원관리</button></a>
		<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">리뷰관리</button></a>
		<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">상품관리</button></a>
		<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">매출관리</button></a>
		<a href="#"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">판매데이터</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent">
		<h1>주문관리</h1>
		<table class="orderTable" border="1">
			<tr>
				<td align="center" colspan="2">
					<table>
						<tr>
							<td width="100">주문순번</td>
							<td width="100">주문자 ID</td>
							<td width="100">주문상품번호</td>
							<td width="100">주문상품이름</td>
							<td width="100">주문수량</td>
							<td width="100">주문날짜</td>
							<td width="100">배송지</td>
							<td width="100">주문상태</td>
							<td width="100"><input type="checkbox" class="allCheckChb" onclick="allCheck()">&nbsp;전체선택</td>
						</tr>
						<%
						Vector<OrderBean> vlist = aoMgr.getOrderList(keyField, keyWord, start, cnt);
						if(vlist.size()==0){%>
							<tr>
								<td colspan="8" width="300" align="center">
									<br>
									<%out.println("주문내역이 없습니다."); %>
								</td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
						<%} else {
							for(int i=0; i<vlist.size(); i++){
								OrderBean bean = vlist.get(i);
								int onum = bean.getOnum();
								int pnum = bean.getPnum();
								int qty = bean.getQty();
								String pname = bean.getPname();
								String oid = bean.getOid();
								String regdate = bean.getRegdate();
								String oaddress = bean.getOaddress();
								String state = bean.getState();
							%>
						<tr align="left">
							<td><%=onum%></td>
							<td><%=oid%></td>
							<td><%=pnum%></td>
							<td><%=pname%></td>
							<td><%=qty%></td>
							<td><%=regdate%></td>
							<td><%=oaddress%></td>
							<td><%=state%></td>
							<td><input type="checkbox" class="chb" name="chb" value="<%=onum%>"></td>
						</tr>
						<%} // -- 반복문 끝%>
						<%} // -- if-else문 끝%>
					</table>			
				</td>
			</tr>
			<tr>
				<td align="center" class="page">
					<%if(nowBlock > 1) {%>
						<a href="javascript:block('<%=nowBlock-1%>')">&nbsp;이전&nbsp;</a>
					<%}%>
					<%
					// 각 블럭의 첫페이지와 마지막 페이지 계산
					int pageStart = (nowBlock - 1) * pagePerBlock + 1;
					int pageEnd = (pageStart + pagePerBlock) < totalPage ? pageStart + pagePerBlock : totalPage + 1; 
/*  					out.println("*totalPage : " + totalPage);
					out.println("*pageStart : " + pageStart);
					out.println("*pageEnd : " + pageEnd); */
					for(; pageStart<pageEnd; pageStart++){%>
						<a href="javascript:pageing('<%=pageStart%>')">
							[<%=pageStart%>]
						</a>
					<%}%>
					<%if(nowBlock < totalBlock) {%>
						<a href="javascript:block('<%=nowBlock+1%>')">&nbsp;다음&nbsp;</a>
					<%}%>
<%-- 					<%out.println("nowBlock : " + nowBlock);%>
					<%out.println("nowPage : " + nowPage);%>
					<%out.println("pagePerBlock : " + pagePerBlock); %>
					<%out.println("numPerPage : " + numPerPage);  %>
					<%out.println("*totalRecord : " + totalRecord);  %>
					<%out.println("start : " + start);  %>
					<%out.println("cnt : " + cnt);  %> --%>
				</td>
			</tr>
		</table>
  		
  		<!-- 검색 폼 -->
  		<form name="searchOrderFrm"> <!-- 재귀호출되도록 -->
			<select name="keyField"> <!-- 선택한 값이 keyField의 value로 가나요? -->
				<option value="oid">주문자 ID</option>
				<option value="pnum">주문상품번호</option>
				<option value="pname">주문상품이름</option>
				<option value="state">주문상태</option>
			</select>
			<input type="text" name="keyWord"> <!-- 입력한 값이 keyWord의 value로 가나요? -->
			<input type="button" onclick="search()" value="검색">
		</form>
		
		<form name="deleteFrm" style="text-align:right" method="post">
			<input type="hidden" name="onum">
			<input type="button" name="deleteBtn" value="삭제" onclick="deleteCheckedBox()">
			<input type="button" name="deleteAllBtn" value="전체삭제">
		</form>
		
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
		</form>
		
  		
  	</div> <!-- 본문 끝-->
</div><!-- 네비까지 포함한 본문 끝-->
<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>
<%@ include file="../bottom.jsp" %>
</body>
</html>