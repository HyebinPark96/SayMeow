<!-- ��� -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<title>SayMeow</title>
<!-- �ܺ� CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- ���� CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<!-- �¿� CSS -->
<link rel="stylesheet" href="css/styleTW.css">
<!-- ���� CSS -->
<link rel="stylesheet" href="css/styleSH.css">
<!-- ���� CSS -->
<link rel="stylesheet" href="css/styleJW.css">
<!-- ��ȭ CSS -->
<link rel="stylesheet" href="css/styleIH.css">
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="scriptHB.js"></script> <!-- ���� ��ũ��Ʈ ���� ���� -->
</head>
<body id="bootstrap-overrides" class="top">
<% 
	String id = null;
/* 	if(session.getAttribute("idKey")!=null){ // id���� �������� ����Ǿ� �ִٸ�
		id = (String) session.getAttribute("idKey");
	} */
	// �׽�Ʈ�� ���Ǽ��� 
	id = "aaa";
%>
	<header class="header">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
				<a class="navbar-brand" href="index.jsp">SAYMEOW</a>
				<form class="container-fluid">
					<span class="input-group">
						<input type="text" class="form-control" placeholder="���ϴ� ��ǰ�� �˻��غ�����."> 
						<a href="search.jsp" class="input-group-text" id="basic-addon1">SEARCH</a> 
					</span>
				</form>
				<%if(id==null){%>
					<div class="top-aTags">
						<a href="#" class="aTag top-aTag">�α���</a><!--�α��� �����ϸ� ����������-->
						<a href="#" class="aTag top-aTag">ȸ������</a><!--�α��� �����ϸ� ��ٱ���-->
					</div>
				<%}else{%>
					<div class="top-aTags">
						<a href="#" class="aTag top-aTag">����������</a>
						<a href="#" class="aTag top-aTag">��ٱ���</a>
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
			<!--ī�װ�-->
			<div class="navbar-collapse categories" id="navbarTogglerDemo01">
				<a href="#" class="aTag category">Ĺ Ǫ��</a>&ensp;
				|&ensp;
				<a href="#" class="aTag category">����</a>&ensp;
				|&ensp;
				<a href="#" class="aTag category">�峭��</a>&ensp;
				|&ensp;
				<a href="#" class="aTag category">�躯��ǰ</a>
			</div>
		</div>
	</nav>
</header>