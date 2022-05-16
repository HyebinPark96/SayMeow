<!-- 메일기능 뺐어요 -->
<%@page import="java.util.ArrayList"%>
<%@page import="saymeow.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.AdminMemberMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="amMgr" class="saymeow.AdminMemberMgr"/>
<%
String sid = request.getParameter("sid"); // 검색할 회원의 id
Vector<MemberBean> mvlist = new Vector<MemberBean>();

 // 전체회원 리스트업 메소드
if(sid==null || sid.equals("")) {
	mvlist = amMgr.getAllM(); // 전체회원 리스트업 메소드
	// System.out.println("[adminMember.jsp] 전체 회원 출력");
}else {
	mvlist = amMgr.searchM(sid); // 회원id로 검색 메소드
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
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
<script> // 단일 회원수정 기능 : 반복문이므로 JS를 통해 동적으로 값을 전달받도록 합니다.
function updateOneMember(value){
	document.adminMemberUpdateFrm.selectedId.value=value;
	document.adminMemberUpdateFrm.action="adminMemberUpdate.jsp";
	document.adminMemberUpdateFrm.submit();
}
</script>

</head>

<body>
	<!-- 사이드바 -->
	<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문관리</button></a>
			<a href="adminMember.jsp"><button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원관리</button></a>
			<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">리뷰관리</button></a>
			<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">상품관리</button></a>
			<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">매출관리</button></a>
			<a href="../sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">판매데이터</button></a>
		</div>	

		<!-- 본문 -->
		<section class="contents">
		<form name="adminMemberUpdateFrm" action="adminMemberUpdateProc.jsp" method="post">
		<div class="mlist"><br><br>
		<h3>회원관리</h3><br>
		<table border="1">
						<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>연락처</th>
								<th>이메일</th>
								<th>회원등급</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<%		
									for (int i=0; i < mvlist.size(); i++) {
										MemberBean mbean = mvlist.get(i); 
								%>
							<tr>
								<%-- <input type="hidden" name="mId[]" value="<%=mbean.getId()%>"> --%>
								<input type="hidden" name="mid" value="<%=mbean.getId()%>">
								<td><%=mbean.getId()%></td>
								<td><%=mbean.getName()%></td>
								<td><%=mbean.getPhone()%></td>
								<td><%=mbean.getEmail()%></td>
								<td>
									<div class="count">
										<input type="number" value="<%=mbean.getGrade()%>"
											autocomplete="off" min="0" max="5" name="grade[]"
											style="width: 3vw;">
										<div class="num_">
											<div class="btn_ up"></div>
											<div class="btn_ down"></div>
										</div>
									</div>
								</td>
								<td><input type="button" value="회원 수정하기" onclick="updateOneMember(this.form.mid[<%=i%>].value)"></td>
								<!-- 메일은 추후 구현 -->
							</tr>
							<%} // -- for문 끝%>
							<input type="hidden" name="selectedId">
						</tbody>
					</table>
				  	</div>

			<br><br>
			<input type="submit" value="수정" name="updateBtn">
			</form>

	
		<section class="searchsection">
		<div class="memberSearch">
			<form>
			<br><br>
				<input type="search" placeholder="회원 ID로 검색" name="sid">
				<button type="submit">검색</button>
				<button onClick="location.href='adminMember.jsp'">전체보기</button>
			<br><br>
			</form>
		</div>
		</section>
</div>
</body>
</html>