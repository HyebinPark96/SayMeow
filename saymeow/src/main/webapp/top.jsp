<%@page contentType="text/html; charset=EUC-KR"%>
<%
	String id = null;
	/* 	if(session.getAttribute("idKey")!=null){ // id���� �������� ����Ǿ� �ִٸ�
			id = (String) session.getAttribute("idKey");
		} */
	// �׽�Ʈ�� ���Ǽ��� 
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
function btn(btnId) { // ��ưȰ��/��Ȱ��ȭ
	var btn = document.getElementById(btnId);
	if (btn.style.display == "none" ) {
		btn.style.display = "flex";
	}else {
		btn.style.display = "none";
	}
} 
</script>
<body>
<!-- �ΰ� / �˻�â / �α��� ��ư -->
<section class = "ssection">
<div>
    <img class="logo" src="image/logo1.png">
    </div>
    	<!-- �˻�â -->
    	<div class="search">
    	<form class="serachFrm">
		<input class="sTf" type="search" placeholder="���ϴ� ��ǰ�� �ִٸ� �˻��غ�����!" aria-label="Search">
		<button class="searchBtn" type="submit">Search</button>
		</form>
		</div>
		<!-- �α��� -->
		<div class=btns>
		<button id=login>�α���</button>
		<button id=logout>�α׾ƿ�</button>
		<button id=join>ȸ������</button>
		<button id=my>����������</button>
		<button id=cart>��ٱ���</button>
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
<!-- ī�װ� -->
<section class="csection">
&nbsp; &nbsp; <a href="product/food.jsp">����� ���</a>&nbsp; 
<a href="product/treat.jsp">����� ����</a>&nbsp;
<a href="product/toy.jsp">����� �峭��</a>&nbsp; 
<a href="product/litter.jsp">����� �躯��ǰ</a>&nbsp; 
</section>
       
    </body>
</html>