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
<body> 
	<%@ include file="top.jsp" %>
		<form name="pwfindscreen" method = "POST">
		<table id="level">
		<tr><td id="level2">
		<table id="level3">
		<tr><td>
			<div class = "search-title">
				<h3><span class="loginlo">등록한 정보로 인증</span></h3>
			</div>
		<section class = "form-search">
			<div class = "find-id">
				<label>I D</label>
				<input type="text" name="mid" class = "btn-name" placeholder = "ID를 입력하세요.">
			<br>
			</div>
		
		 <div class = "find-phone">
				<label>번호</label>
				<input type="text"  name="phone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div> 
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" class="lbtn"name="enter" value="찾기"  onClick="pw_search()">
		<input type="button" class="lbtn"name="cancle" value="취소" onClick="location.href='login.jsp'">
 	</div>
 		</td></tr>
 	</table>
 	</td></tr>
 	</table>
 </form>
	<%@ include file="bottom.jsp" %> 
</body> 
</html>