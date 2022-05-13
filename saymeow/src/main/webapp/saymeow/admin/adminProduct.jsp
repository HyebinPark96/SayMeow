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
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminMember.css'>	
<jsp:include page = "../top2.jsp"/>
</head>
<script>
function send_form(frmId) { // form ����
	document.getElementById(frmId).submit();
}
</script>
<body >
<!-- ���̵��-->
<section class="side">
	<div>
		<a href="adminOrder.jsp"><button >�ֹ�����</button></a>
		<a href="adminMember.jsp"><button>ȸ������</button></a>
		<a href="adminReviewBoard.jsp"><button >�������</button></a>
		<a href="adminProduct.jsp"><button >��ǰ����</button></a>
		<a href="adminSales.jsp"><button >�������</button></a>
		<a href="#"><button >�Ǹŵ�����</button></a>
	</div>
	
</section>
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
  	<div class="productSearch">
  	<form method="post" action="adminProductProc.jsp?flag=search">
  	<input type="search" placeholder="��ǰ������ �˻�" name="keyWord">
	<button type="submit">�˻�</button>
	<button onClick="location.href='adminProduct.jsp'">��ü����</button>
	<button onclick="window.open('adminProductInsert.jsp')">��ǰ���</button ><br><br><br>
	</form>
	</div>
 
</section>
</body>
</html>