<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>                                      
<%
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR"> 
<script src="script.js"></script>
</head> 
<body> 
	<%@ include file="top.jsp" %>
		<form name="pwfindscreen" method = "POST">
			<div class = "search-title">
				<h3>����� ������ ����</h3>
			</div>
		<section class = "form-search">
			<div class = "find-id">
				<label>���̵�</label>
				<input type="text" name="mid" class = "btn-name" placeholder = "ID�� �Է��ϼ���.">
			<br>
			</div>
		
		 <div class = "find-phone">
				<label>��ȣ</label>
				<input type="text"  name="phone" class = "btn-phone" placeholder = "�޴�����ȣ�� '-'���� �Է�">
			</div> 
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" name="enter" value="ã��"  onClick="pw_search()">
		<input type="button" name="cancle" value="���" onClick="location.href='login.jsp'">
 	</div>
 </form>
	<%@ include file="bottom.jsp" %> 
</body> 
</html>