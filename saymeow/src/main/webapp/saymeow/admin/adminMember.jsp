<%@page import="saymeow.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.AdminMemberMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
String id = request.getParameter("id"); // �˻��� ȸ���� id
Vector<MemberBean> mvlist = new Vector<MemberBean>();
AdminMemberMgr mgr = new AdminMemberMgr();

 // ��üȸ�� ����Ʈ�� �޼ҵ�
if(id==null || id.equals("")) {
	mvlist = mgr.getAllM(); // ��üȸ�� ����Ʈ�� �޼ҵ�
	// System.out.println("[adminMember.jsp] ��ü ȸ�� ���");
}else {
	mvlist = mgr.searchM(id); // ȸ��id�� �˻� �޼ҵ�
	// System.out.println("[adminMember.jsp] ȸ�� ID�� �˻�");  
} 
 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>adminMember</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminMember.css'>	
<jsp:include page = "../top2.jsp"/>
</head>
<script></script>
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
	<div class="mlist">
		<h1>ȸ������</h1><br>
		<table border="1">
		<thead>
		<tr>
		<th>���̵�</th>
		<th>�̸�</th>
		<th>����ó</th>
		<th>�̸���</th>
		<th>ȸ�����</th>
		<th>��������</th>
		<th>���Ϲ߼�</th>
		<th>ȸ������</th>
		</tr>
		</thead>
		<tbody>
<%		
	for (int i=0; i < mvlist.size(); i++) {
		MemberBean mbean = mvlist.get(i); 
%>
		<tr>
		<td><%=mbean.getId()%></td>
		<td><%=mbean.getName()%></td>
		<td><%=mbean.getPhone()%></td>
		<td><%=mbean.getEmail()%></td>
		<td><%=mbean.getGrade()%></td>
		<td><a href="../memberUpdate.jsp?id=<%=mbean.getId()%>">����</a></td>
		<td><a href="#">���Ϲ߼�</a></td> <!-- ���� ���� -->
		<td><a href="#">ȸ������</a></td> <!-- �ٷ� ȸ��Ż���������� �̾������� -->
		</tr>
<% } %>		
		</tbody>
		</table>
  	</div>
  	<br><br><br>
  	<div class="memberSearch">
  	<form >
  	<input type="search" placeholder="ȸ�� ID�� �˻�" name="id">
	<button type="submit">�˻�</button>
	<button onClick="location.href='adminMember.jsp'">��ü����</button>
	</form>
	</div>
</section>
</body>
</html>