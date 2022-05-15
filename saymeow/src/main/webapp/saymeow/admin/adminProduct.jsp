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
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminMember.css'>	
<jsp:include page = "../top2.jsp"/>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}
</script>
<body >
<!-- 사이드바-->
<section class="side">
	<div>
		<a href="adminOrder.jsp"><button >주문관리</button></a>
		<a href="adminMember.jsp"><button>회원관리</button></a>
		<a href="adminReviewBoard.jsp"><button >리뷰관리</button></a>
		<a href="adminProduct.jsp"><button >상품관리</button></a>
		<a href="adminSales.jsp"><button >매출관리</button></a>
		<a href="#"><button >판매데이터</button></a>
	</div>
	
</section>
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
  	<div class="productSearch">
  	<form method="post" action="adminProductProc.jsp?flag=search">
  	<input type="search" placeholder="상품명으로 검색" name="keyWord">
	<button type="submit">검색</button>
	<button onClick="location.href='adminProduct.jsp'">전체보기</button>
	<button onclick="window.open('adminProductInsert.jsp')">상품등록</button ><br><br><br>
	</form>
	</div>
 
</section>
</body>
</html>