<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.AdminProductMgr"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("EUC-KR");
String keyWord = request.getParameter("keyWord"); // �˻��� ��ǰ�̸�
Vector<ProductBean> pvlist = new Vector<ProductBean>();
AdminProductMgr mgr = new AdminProductMgr();

if(keyWord==null || keyWord.isEmpty()) {
	pvlist = mgr.getAllP();
	// System.out.println("[adminProduct.jsp] ��ü ��ǰ ���");
}else {
	pvlist = mgr.getPList(keyWord);
	// System.out.println("[adminProduct.jsp] �˻� ��ǰ ���");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>adminProduct</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminProduct.css'>	
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
</head>
<script>
function send_form(frmId) { // form ����
	document.getElementById(frmId).submit();
}
</script>
<body >
<!-- ���̵�� 40%, â 60% -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
		<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
		<a href="adminProduct.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
		<a href="../sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
		<a href="#"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<!-- ���� -->
<section class="contents">
	<div class="plist">
		<br><br><h1>��ǰ����</h1><br><br><br>
		<table border="1">
		<thead>
		<tr>
		<th>��ǰ��ȣ</th>
		<th>��ǰ�̸�</th>
		<th>��з�</th>
		<th>�ߺз�</th>
		<th>��ǰ����</th>
		<th>�ǸŻ���</th>
		<th>��ǰ���</th>
		<th>��ǰ����</th>
		<th>��ǰ����</th>
		</tr>
		</thead>
		<tbody>
<%		
		for (int i=0; i < pvlist.size(); i++) {
		ProductBean pbean = pvlist.get(i);
%>
		<tr>
		<td><%=pbean.getPnum()%></td>
		<td><%=pbean.getPname()%></td>
		<td><%=pbean.getMclass()%></td>
		<td><%=pbean.getSclass()%></td>
		<td><%=UtilMgr.monFormat(pbean.getPrice1())%></td>
		<td><%=pbean.getPstat()%></td>
		<td><%=pbean.getStock()%></td>
		<td><a href="adminProductUpdate.jsp?pnum=<%=pbean.getPnum()%>">����</a></td>
		<td>
		<form method="post" action="adminProductProc.jsp?flag=delete">
		<input type=hidden name="pnum" value="<%=pbean.getPnum()%>">
		<button type=submit>����</button>
		</form></td> 
		</tr>
		<% } //-for %>		
		</tbody>
		</table><br><br><br>
  	</div>
 </section>
 <section> 	
  	<div class="productSearch">
  	<form method="post" action="adminProductProc.jsp?flag=search">
  	<input type="search" placeholder="��ǰ������ �˻�" name="keyWord">
	<button type="submit">�˻�</button>
	<button onClick="location.href='adminProduct.jsp'">��ü����</button>
	<button onclick="window.open('adminProductInsert.jsp')">��ǰ���</button ><br><br><br>
	</form>
	</div>
 
</section>
  	</div>
</div>

</body>
</html>