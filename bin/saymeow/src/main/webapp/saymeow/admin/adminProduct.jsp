<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.AdminProductMgr"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("EUC-KR");
String keyWord = request.getParameter("keyWord"); // 검색할 상품이름
Vector<ProductBean> pvlist = new Vector<ProductBean>();
AdminProductMgr mgr = new AdminProductMgr();

if(keyWord==null || keyWord.isEmpty()) {
	pvlist = mgr.getAllP();
	// System.out.println("[adminProduct.jsp] 전체 상품 출력");
}else {
	pvlist = mgr.getPList(keyWord);
	// System.out.println("[adminProduct.jsp] 검색 상품 출력");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>adminProduct</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminProduct.css'>	
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}
</script>
<body >
<!-- 사이드바 40%, 창 60% -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문관리</button></a>
		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원관리</button></a>
		<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">리뷰관리</button></a>
		<a href="adminProduct.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">상품관리</button></a>
		<a href="../sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">매출관리</button></a>
		<a href="#"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">판매데이터</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<!-- 본문 -->
<section class="contents">
	<div class="plist">
		<br><br><h1>상품관리</h1><br><br><br>
		<table border="1">
		<thead>
		<tr>
		<th>상품번호</th>
		<th>상품이름</th>
		<th>대분류</th>
		<th>중분류</th>
		<th>상품가격</th>
		<th>판매상태</th>
		<th>상품재고</th>
		<th>상품수정</th>
		<th>상품삭제</th>
		</tr>
		</thead>
		<tbody>
<%		
		for (int i=0; i < pvlist.size(); i++) {
		ProductBean pbean = pvlist.get(i);
%>
		<tr>
		<td><%=pbean.getPnum()%></td>
		<td><%=pbean.getPname()%></td>
		<td><%=pbean.getMclass()%></td>
		<td><%=pbean.getSclass()%></td>
		<td><%=UtilMgr.monFormat(pbean.getPrice1())%></td>
		<td><%=pbean.getPstat()%></td>
		<td><%=pbean.getStock()%></td>
		<td><a href="adminProductUpdate.jsp?pnum=<%=pbean.getPnum()%>">수정</a></td>
		<td>
		<form method="post" action="adminProductProc.jsp?flag=delete">
		<input type=hidden name="pnum" value="<%=pbean.getPnum()%>">
		<button type=submit>삭제</button>
		</form></td> 
		</tr>
		<% } //-for %>		
		</tbody>
		</table><br><br><br>
  	</div>
 </section>
 <section> 	
  	<div class="productSearch">
  	<form method="post" action="adminProductProc.jsp?flag=search">
  	<input type="search" placeholder="상품명으로 검색" name="keyWord">
	<button type="submit">검색</button>
	<button onClick="location.href='adminProduct.jsp'">전체보기</button>
	<button onclick="window.open('adminProductInsert.jsp')">상품등록</button ><br><br><br>
	</form>
	</div>
 
</section>
  	</div>
</div>

</body>
</html>