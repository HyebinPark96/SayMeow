<!-- top.jsp : 페이지 상단 레이아웃 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<div id="bootstrap-overrides" class="top">
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
				<a class="navbar-brand" href="#">saymeow</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02"
					aria-controls="navbarTogglerDemo02" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
				<%if(id!=null){%> <!-- 로그인 성공한경우 -->
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="#">장바구니</a>
						</li>
					</ul>
				<%}else{%> <!-- 로그인 실패한경우 -->
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">로그인</a> <!-- 로그인성공하면 마이페이지로 --></li>
						<li class="nav-item"><a class="nav-link" href="#">회원가입</a> <!-- 로그인성공하면 장바구니로 -->
						</li>
					</ul>
				<%}%>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item nav-item-space"><a class="nav-link"
							aria-current="page" href="#">사료</a></li>
						<li class="nav-item nav-item-space"><a class="nav-link"
							href="#">간식</a></li>
						<li class="nav-item nav-item-space"><a class="nav-link"
							aria-current="page" href="#">장난감</a></li>
						<li class="nav-item nav-item-space"><a class="nav-link"
							href="#">배변용품</a></li>
					</ul>
					<form class="d-flex">
						<input class="form-control me-2" type="search"
							placeholder="원하는 상품이 있다면 검색해보세요!" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</div>
			</div>
		</nav>
	</header>
</div>