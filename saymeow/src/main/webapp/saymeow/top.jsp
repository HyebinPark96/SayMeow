<!-- top.jsp : ������ ��� ���̾ƿ� -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<div id="bootstrap-overrides" class="top">
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
				<a class="navbar-brand" href="#">saymeow</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02"
					aria-controls="navbarTogglerDemo02" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
				<%if(id!=null){%> <!-- �α��� �����Ѱ�� -->
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">����������</a></li>
						<li class="nav-item"><a class="nav-link" href="#">��ٱ���</a>
						</li>
					</ul>
				<%}else{%> <!-- �α��� �����Ѱ�� -->
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">�α���</a> <!-- �α��μ����ϸ� ������������ --></li>
						<li class="nav-item"><a class="nav-link" href="#">ȸ������</a> <!-- �α��μ����ϸ� ��ٱ��Ϸ� -->
						</li>
					</ul>
				<%}%>
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item nav-item-space"><a class="nav-link"
							aria-current="page" href="#">���</a></li>
						<li class="nav-item nav-item-space"><a class="nav-link"
							href="#">����</a></li>
						<li class="nav-item nav-item-space"><a class="nav-link"
							aria-current="page" href="#">�峭��</a></li>
						<li class="nav-item nav-item-space"><a class="nav-link"
							href="#">�躯��ǰ</a></li>
					</ul>
					<form class="d-flex">
						<input class="form-control me-2" type="search"
							placeholder="���ϴ� ��ǰ�� �ִٸ� �˻��غ�����!" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</div>
			</div>
		</nav>
	</header>
</div>