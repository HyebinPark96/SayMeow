<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>                                      
<%
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR"> 
<script src="script.js"></script>
<link rel="stylesheet" href="css/styleTW.css">
</head> 
<!-- �ܺ� CSS -->						
<link rel="stylesheet" href="css/style.css">						
<link rel="stylesheet" href="css/styleTW.css">						
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="top2.jsp"%>
<body> 
	
		<form name="pwfindscreen" method = "POST">
		<table id="level">
		<tr><td id="level2">
		<table id="level3">
		<tr><td>
			<div class = "search-title">
				<h3><span class="loginlo">����� ������ ����</span></h3><br><br>
			</div>
		<section class = "form-search">
			<div class = "find-id">
				<label>���̵�</label>
				<input type="text" size="20" name="mid" class = "btn-name" placeholder = "ID�� �Է��ϼ���.">
			<br><br>
			</div>
		
		 <div class = "find-phone">
				<label>����ó</label>
				<input type="text" size="20" name="phone" class = "btn-phone" placeholder = "�޴�����ȣ�� '-'���� �Է�">
			</div> 
			<br><br>
	</section>
	<div class ="btnSearch">
		<input type="button" class="find"name="enter" value="ã��"  onClick="pw_search()">
		<input type="button" class="cancel"name="cancle" value="���" onClick="location.href='login.jsp'">
 	</div>
 		</td></tr>
 	</table>
 	</td></tr>
 	</table>
 </form>
</body> 
</html>