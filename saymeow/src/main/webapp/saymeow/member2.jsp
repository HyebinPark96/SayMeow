<!-- 취합완료 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean"/>
<jsp:setProperty name="mBean" property="*"/>

<html>
<head>	
<title>회원가입</title>
<script src="script.js">

</script>
</head>
<!-- 외부 CSS -->
<!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel='stylesheet' type='text/css' media='screen' href='css/member.css'>
<%@ include file="top2.jsp"%>
<body>
	<div class="title" align="center">
	<h2><b>회원가입</b></h2>
	</div>
	<section>
	<form name="joinFrm" method="post" action="memberProc2.jsp">
	<fieldset>
	<br><br><br>
	<legend>회원 정보</legend>
	<ul>
	<li>
		<label for="id">회원 아이디</label>
		<input name="id" class="id" required autofocus>
		<input type="button" class="btn" value="중복확인" onClick="idCheck(this.form.id.value)"/>
	</li>
	<li>
		<label for="pwd">비밀번호</label>
		<input name="pwd" type="password" required autofocus>
	</li>	
	<li>
		<label for="repwd">비밀번호 확인</label>
		<input name="repwd" type="password" required autofocus>
	</li>	
	<li>
		<label for="name">회원 이름</label>
		<input name="name" required autofocus>
	</li>	
	<li>
		<label for="birthday">회원 생년월일</label>
		<select name="year" class="year">
	<% // 생년
		for (int i = 1960; i <= 2010; i++) { %>
		<option value="<%=i%>">
		<%=i%>
		</option>
	<%} //-- for %> 
		</select>
		<select name="mon">
	<% // 생월
		for (int i = 1; i <= 12; i++) { %>
		<option value="<%=i%>">
		<%=i%>
		</option>
	<%} //-- for %>
		</select>
		<select name="day">
	<% // 생일
		for (int j = 1; j <= 31; j++) { %>
		<option value="<%=j%>">
		<%=j%>
		</option>
	<%} //-- for %>
		</select><br>
	</li>	
	<li>
		<label for="phone">회원 연락처</label>
		<input name="phone" required autofocus>
	</li>
	<li>
		<label for="email">회원 이메일</label>
		<input name="email" required autofocus>
	</li>
	<li>
		<label for="address">회원 주소</label>
		<input name="address" required autofocus>
	</li>	
	</ul>
	<legend>고양이 정보</legend>
	<ul>
	<li>
		<label for="petName">고양이 이름</label>
		<input name="petName" required autofocus>
	</li>
	<li>
		<label for="petAge">고양이 생년월일</label>
		<select name="p_year" class="year">
	<% // 생년
		for (int i = 2000; i <= 2022; i++) { %>
		<option value="<%=i%>">
		<%=i%>
		</option>
	<%} //-- for %> 
		</select>
		<select name="p_mon">
	<% // 생월
		for (int k = 1; k <= 12; k++) { %>
		<option value="<%=k%>">
		<%=k%>
		</option>
	<%} //-- for %>
		</select>
		<select name="p_day">
	<% // 생일
		for (int l = 1; l <= 31; l++) { %>
		<option value="<%=l%>">
		<%=l%>
		</option>
	<%} //-- for %>
		</select><br>
	</li>
	<li>
	<label for="petGender">고양이 성별</label>
	여<input type="radio" name="petGender" class="radio" value="1" checked>
	남<input type="radio" name="petGender" class="radio" value="0">
	</li>
	<li>
	<label for="petBreed">고양이 품종</label>
	<input name="petBreed" required autofocus>

	</li>
	</ul>
		<br><br><br>
		<input type="button" class="btn" onclick="inputCheck()" value="회원가입"/>
		<br><br><br>
	</fieldset>
	</form>
	</section>
	
	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
	</script>

</body>
</html>

