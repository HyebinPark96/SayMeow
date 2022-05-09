<%@page contentType="text/html; charset=EUC-KR"%>
<%
	String id = null;
	/* 	if(session.getAttribute("idKey")!=null){ // id값이 세션으로 저장되어 있다면
			id = (String) session.getAttribute("idKey");
		} */
	// 테스트용 임의설정 
	id = "aaa";
%>
<!DOCTYPE html>
<html>
    <meta charset='EUC-KR'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='css/top.css'>
    <script></script>
    <style>
    </style>
<script>
function btn(btnId) { // 버튼활성/비활성화
	var btn = document.getElementById(btnId);
	if (btn.style.display == "none" ) {
		btn.style.display = "flex";
	}else {
		btn.style.display = "none";
	}
} 
</script>
<body>
<!-- 로고 / 검색창 / 로그인 버튼 -->
<section class = "ssection">
<div>
    <img class="logo" src="image/logo1.png">
    </div>
    	<!-- 검색창 -->
    	<div class="search">
    	<form class="serachFrm">
		<input class="sTf" type="search" placeholder="원하는 상품이 있다면 검색해보세요!" aria-label="Search">
		<button class="searchBtn" type="submit">Search</button>
		</form>
		</div>
		<!-- 로그인 -->
		<div class=btns>
		<button id=login>로그인</button>
		<button id=logout>로그아웃</button>
		<button id=join>회원가입</button>
		<button id=my>마이페이지</button>
		<button id=cart>장바구니</button>
		</div>
		<% if(id==null) { %>
		<script>
			btn('logout');
			btn('my');
			btn('cart');
		</script>
		<% }else { %>
		<script>
			btn('login');
			btn('join');
			</script>
		<% } %>
</section>
<!-- 카테고리 -->
<section class="csection">
&nbsp; &nbsp; <a href="product/food.jsp">고양이 사료</a>&nbsp; 
<a href="product/treat.jsp">고양이 간식</a>&nbsp;
<a href="product/toy.jsp">고양이 장난감</a>&nbsp; 
<a href="product/litter.jsp">고양이 배변용품</a>&nbsp; 
</section>
       
    </body>
</html>