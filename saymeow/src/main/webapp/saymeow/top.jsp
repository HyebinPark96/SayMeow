<!-- 헤더 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<title>SayMeow</title>
<!-- 외부 CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<!-- 태우 CSS -->
<link rel="stylesheet" href="css/styleTW.css">
<!-- 서하 CSS -->
<link rel="stylesheet" href="css/styleSH.css">
<!-- 지우 CSS -->
<link rel="stylesheet" href="css/styleJW.css">
<!-- 인화 CSS -->
<link rel="stylesheet" href="css/styleIH.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="scriptHB.js"></script> <!-- 각자 스크립트 파일 연결 -->
</head>
<body id="bootstrap-overrides" class="top">
<% 
	String id = null;
/* 	if(session.getAttribute("idKey")!=null){ // id값이 세션으로 저장되어 있다면
		id = (String) session.getAttribute("idKey");
	} */
	// 테스트용 임의설정 
	id = "aaa";
%>
	<header class="header">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
				<a class="navbar-brand" href="index.jsp">SAYMEOW</a>
				<form class="container-fluid">
					<span class="input-group">
						<input type="text" class="form-control" placeholder="원하는 상품을 검색해보세요."> 
						<a href="search.jsp" class="input-group-text" id="basic-addon1">SEARCH</a> 
					</span>
				</form>
				<%if(id==null){%>
					<div class="top-aTags">
						<a href="#" class="aTag top-aTag">로그인</a><!--로그인 성공하면 마이페이지-->
						<a href="#" class="aTag top-aTag">회원가입</a><!--로그인 성공하면 장바구니-->
					</div>
				<%}else{%>
					<div class="top-aTags">
						<a href="#" class="aTag top-aTag">마이페이지</a>
						<a href="#" class="aTag top-aTag">장바구니</a>
					</div>
				<%}%> 
			</div>
		</div>
	</nav>
	<nav class="navbar-expand-lg second-nav">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01"
				aria-controls="navbarTogglerDemo01" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<!--카테고리-->
			<div class="navbar-collapse categories" id="navbarTogglerDemo01">
				<a href="#" class="aTag category">캣 푸드</a>&ensp;
				|&ensp;
				<a href="#" class="aTag category">간식</a>&ensp;
				|&ensp;
				<a href="#" class="aTag category">장난감</a>&ensp;
				|&ensp;
				<a href="#" class="aTag category">배변용품</a>
			</div>
		</div>
	</nav>
</header>