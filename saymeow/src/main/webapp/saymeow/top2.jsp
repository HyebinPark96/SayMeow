<%@page contentType="text/html; charset=EUC-KR"%>
<%
request.setCharacterEncoding("EUC-KR");
	String id = null;
	/* 	if(session.getAttribute("idKey")!=null){ // id���� �������� ����Ǿ� �ִٸ�
			id = (String) session.getAttribute("idKey");
		} */
	// �׽�Ʈ�� ���Ǽ��� 
	id = "aaa";
	String oid = "1";//������ ȣȯ �׽�Ʈ��
	String keyWord = request.getParameter("keyWord");	
%>
<!DOCTYPE html>
<html>
    <meta charset='EUC-KR'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='/jspproject/saymeow/css/top2.css'>
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
    <a href="/jspproject/saymeow/index.jsp"><img class="logo" src="/jspproject/saymeow/image/logo1.png"></a>
    </div>
    	<!-- �˻�â -->
    	<div class="search">
    	<form method="post" action="/jspproject/saymeow/product/productSearch.jsp">
		<input class="sTf" name="keyWord" type="search" placeholder="���ϴ� ��ǰ�� �ִٸ� �˻��غ�����!" aria-label="Search">
		<button class="searchBtn" type="submit">Search</button>
		</form>
		</div>
		<!-- �α��� -->
		<div class=btns>
		<form><button id=login type="submit">�α���</button></form>&nbsp;
		<form><button id=logout type="submit">�α׾ƿ�</button></form>&nbsp;
		<form><button id=join type="submit">ȸ������</button></form>&nbsp;
		<form><button id=my type="submit">����������</button></form>&nbsp;
		<form><button id=admin type="submit">�����ڸ޴�</button></form>&nbsp;
		<form><button id=cart type="submit">��ٱ���</button></form>&nbsp;
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
<!-- ī�װ� -->
<section class="csection">
&nbsp; &nbsp; <a href="/jspproject/saymeow/product/food.jsp">����� ���</a>&nbsp; 
<a href="/jspproject/saymeow/product/treat.jsp">����� ����</a>&nbsp;
<a href="/jspproject/saymeow/product/toy.jsp">����� �峭��</a>&nbsp; 
<a href="/jspproject/saymeow/product/litter.jsp">����� �躯��ǰ</a>&nbsp; 
</section>
       
    </body>
</html>