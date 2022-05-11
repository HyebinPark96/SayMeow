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
    <link rel='stylesheet' type='text/css' media='screen' href='css/top2.css'>
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
		<form><button id=login type="submit">로그인</button></form>
		<form><button id=logout type="submit">로그아웃</button></form>
		<form><button id=join type="submit">회원가입</button></form>
		<form><button id=my type="submit">마이페이지</button></form>
		<form><button id=admin type="submit">관리자메뉴</button></form>
		<form><button id=cart type="submit">장바구니</button></form>
		</div>
		
		<% if(id==null) { %>
		<script>
			btn('logout');
			btn('my');
			btn('cart');
			btn('admin');
		</script>
		<% }else if(id.equals("admin")) { %>
		<script>
			btn('login');
			btn('join');
			btn('logout');
			btn('my');
			btn('cart');
		</script>
		<% }else { %>
		<script>
			btn('login');
			btn('join');
			btn('admin');
		</script>
		
		<%} %>
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