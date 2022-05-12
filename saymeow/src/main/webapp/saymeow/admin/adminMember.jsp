<%@page import="saymeow.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.AdminMemberMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
String id = request.getParameter("id"); // 검색할 회원의 id
Vector<MemberBean> mvlist = new Vector<MemberBean>();
AdminMemberMgr mgr = new AdminMemberMgr();

 // 전체회원 리스트업 메소드
if(id==null || id.equals("")) {
	mvlist = mgr.getAllM(); // 전체회원 리스트업 메소드
	// System.out.println("[adminMember.jsp] 전체 회원 출력");
}else {
	mvlist = mgr.searchM(id); // 회원id로 검색 메소드
	// System.out.println("[adminMember.jsp] 회원 ID로 검색");  
} 
 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>adminMember</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminMember.css'>	
<jsp:include page = "../top2.jsp"/>
</head>
<script></script>
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
	<div class="mlist">
		<h1>회원관리</h1><br>
		<table border="1">
		<thead>
		<tr>
		<th>아이디</th>
		<th>이름</th>
		<th>연락처</th>
		<th>이메일</th>
		<th>회원등급</th>
		<th>정보수정</th>
		<th>메일발송</th>
		<th>회원삭제</th>
		</tr>
		</thead>
		<tbody>
<%		
	for (int i=0; i < mvlist.size(); i++) {
		MemberBean mbean = mvlist.get(i); 
%>
		<tr>
		<td><%=mbean.getId()%></td>
		<td><%=mbean.getName()%></td>
		<td><%=mbean.getPhone()%></td>
		<td><%=mbean.getEmail()%></td>
		<td><%=mbean.getGrade()%></td>
		<td><a href="../memberUpdate.jsp?id=<%=mbean.getId()%>">수정</a></td>
		<td><a href="#">메일발송</a></td> <!-- 추후 구현 -->
		<td><a href="#">회원삭제</a></td> <!-- 바로 회원탈퇴페이지로 이어지도록 -->
		</tr>
<% } %>		
		</tbody>
		</table>
  	</div>
  	<br><br><br>
  	<div class="memberSearch">
  	<form >
  	<input type="search" placeholder="회원 ID로 검색" name="id">
	<button type="submit">검색</button>
	<button onClick="location.href='adminMember.jsp'">전체보기</button>
	</form>
	</div>
</section>
</body>
</html>