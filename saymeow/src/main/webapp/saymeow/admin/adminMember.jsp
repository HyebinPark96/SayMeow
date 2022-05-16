<!-- ���ϱ�� ����� -->
<%@page import="java.util.ArrayList"%>
<%@page import="saymeow.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.AdminMemberMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="amMgr" class="saymeow.AdminMemberMgr"/>
<%
String sid = request.getParameter("sid"); // �˻��� ȸ���� id
Vector<MemberBean> mvlist = new Vector<MemberBean>();

 // ��üȸ�� ����Ʈ�� �޼ҵ�
if(sid==null || sid.equals("")) {
	mvlist = amMgr.getAllM(); // ��üȸ�� ����Ʈ�� �޼ҵ�
	// System.out.println("[adminMember.jsp] ��ü ȸ�� ���");
}else {
	mvlist = amMgr.searchM(sid); // ȸ��id�� �˻� �޼ҵ�
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
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
<script> // ���� ȸ������ ��� : �ݺ����̹Ƿ� JS�� ���� �������� ���� ���޹޵��� �մϴ�.
function updateOneMember(value){
	document.adminMemberUpdateFrm.selectedId.value=value;
	document.adminMemberUpdateFrm.action="adminMemberUpdate.jsp";
	document.adminMemberUpdateFrm.submit();
}
</script>

</head>

<body>
	<!-- ���̵�� -->
	<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
			<a href="adminMember.jsp"><button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
			<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
			<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
			<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
			<a href="../sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
		</div>	

		<!-- ���� -->
		<section class="contents">
		<form name="adminMemberUpdateFrm" action="adminMemberUpdateProc.jsp" method="post">
		<div class="mlist"><br><br>
		<h3>ȸ������</h3><br>
		<table border="1">
						<thead>
							<tr>
								<th>���̵�</th>
								<th>�̸�</th>
								<th>����ó</th>
								<th>�̸���</th>
								<th>ȸ�����</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<%		
									for (int i=0; i < mvlist.size(); i++) {
										MemberBean mbean = mvlist.get(i); 
								%>
							<tr>
								<%-- <input type="hidden" name="mId[]" value="<%=mbean.getId()%>"> --%>
								<input type="hidden" name="mid" value="<%=mbean.getId()%>">
								<td><%=mbean.getId()%></td>
								<td><%=mbean.getName()%></td>
								<td><%=mbean.getPhone()%></td>
								<td><%=mbean.getEmail()%></td>
								<td>
									<div class="count">
										<input type="number" value="<%=mbean.getGrade()%>"
											autocomplete="off" min="0" max="5" name="grade[]"
											style="width: 3vw;">
										<div class="num_">
											<div class="btn_ up"></div>
											<div class="btn_ down"></div>
										</div>
									</div>
								</td>
								<td><input type="button" value="ȸ�� �����ϱ�" onclick="updateOneMember(this.form.mid[<%=i%>].value)"></td>
								<!-- ������ ���� ���� -->
							</tr>
							<%} // -- for�� ��%>
							<input type="hidden" name="selectedId">
						</tbody>
					</table>
				  	</div>

			<br><br>
			<input type="submit" value="����" name="updateBtn">
			</form>

	
		<section class="searchsection">
		<div class="memberSearch">
			<form>
			<br><br>
				<input type="search" placeholder="ȸ�� ID�� �˻�" name="sid">
				<button type="submit">�˻�</button>
				<button onClick="location.href='adminMember.jsp'">��ü����</button>
			<br><br>
			</form>
		</div>
		</section>
</div>
</body>
</html>