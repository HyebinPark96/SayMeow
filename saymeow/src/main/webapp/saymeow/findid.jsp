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
<!-- 외부 CSS -->						
<link rel="stylesheet" href="css/style.css">						
<link rel="stylesheet" href="css/styleTW.css">						
<!-- 부트스트랩 CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="top2.jsp"%>
<body> 
		<form name="idfindscreen" method = "POST">
		<table id="level">
		<tr><td id="level2">
		<table id="level3">
		<tr><td>
			<div class = "search-title">
				<h3><span class="loginlo">휴대폰 본인확인</span></h3><br><br>
			</div>
			</td></tr>
			<tr><td>
		<section class = "form-search">
			<div class = "find-name">
				<label>이름</label>
				<input type="text" size="25" name="name" class = "btn-name" placeholder = "등록한 이름">
			<br><br>
			</div>
			<div class = "find-phone">
				<label>번호</label>
				<input type="text" size="25"  name="phone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			<br>
	</section>
	</td></tr>
	<tr><td>
	<div class ="btnSearch">
		<input type="button" class="find" name="enter" value="찾기"  onClick="id_search()">
		<input type="button" class="cancel" name="cancle" value="취소" onClick="location.href='login.jsp'">
 	</div>
 	</td></tr>
 	</table>
 	</td></tr>
 	</table>
 </form>
</body> 
</html>