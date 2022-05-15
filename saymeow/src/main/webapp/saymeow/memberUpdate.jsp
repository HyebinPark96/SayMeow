<!-- 취합완료했으나 회원가입 시 고양이 정보 입력안했으면 에러남. -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<%@ page import="java.util.*,saymeow.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" /> 
<html>
<head>
<title>회원수정</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>
<!-- 외부 CSS -->						
<link rel="stylesheet" href="css/style.css">						
<link rel="stylesheet" href="css/styleTW.css">						
<!-- 부트스트랩 CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="top2.jsp"%>
<body>
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="orderList.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문내역조회</button></a>
		<a href="memberUpdate.jsp"><button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원정보수정</button></a>
		<a href="readMyReview.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">내 리뷰 목록</button></a>
		<a href="deleteMember.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">회원탈퇴</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
	<%
		MemberBean mBean = mMgr.getMember(id);
	%>
	<form name="regForm" method="post" action="memberUpdateProc.jsp" >
	<br>
	<h2 style="text-align:center;">회원정보 수정</h2>
		<table id="level">
			<tr>
				<td id="levl2">
					<table id="level3">
						<tr>
							<td>아이디</td>
							<td><%=mBean.getId()%></td>
						</tr>
						<tr>
							<td>패스워드</td>
							<td><input name="pwd" value="<%=mBean.getPwd()%>"></td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input name="name" value="<%=mBean.getName()%>"></td>
						</tr>
						<tr>
							<td>생년월일</td>
							<td><input name="birthday" size="6"
								value="<%=mBean.getBirthday()%>"> ex)830815</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input name="phone" value="<%=mBean.getPhone()%>"></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input name="email" size="30"
								value="<%=mBean.getEmail()%>"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input name="address" size="50"
								value="<%=mBean.getAddress()%>"></td>
						</tr>
						<tr>
							<td>고양이이름</td>
							<td><input name="petname" value="<%=mBean.getPetName()%>"></td>
						</tr>
						<tr>
							<td>고양이나이</td>
							<td><input name="petAge" value="<%=mBean.getPetAge()%>">ex)xxxx-xx-xx</td>
						</tr>
						<tr>
							<td>고양이성별</td>
							<td>
								남<input type="radio" name="petGender" value="0"
								<%=mBean.getPetGender()==0 ? "checked" : ""%>> 
								여<input type="radio" name="petGender" value="1"
								<%=mBean.getPetGender()==1 ? "checked" : ""%>>
							</td>
						</tr>
						<tr>
							<td>고양이품종</td>
							<td><input name="Breed" value="<%=mBean.getPetBreed()%>"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="submit" value="수정완료" class="lbtn"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
								<input type="reset" value="다시쓰기" class="lbtn">
								<input type="button" value="회원탈퇴" onclick="location.href='deleteMember.jsp'" class="lbtn">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="id" value="<%=id%>">
	</form>
  	</div>
</div>

</body>
</html>
