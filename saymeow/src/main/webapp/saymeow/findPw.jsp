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
				<h3>등록한 정보로 인증</h3>
			</div>
		<section class = "form-search">
			<div class = "find-id">
				<label>아이디</label>
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
		<input type="button" name="enter" value="찾기"  onClick="pw_search()">
		<input type="button" name="cancle" value="취소" onClick="location.href='login.jsp'">
 	</div>
 </form>
	<%@ include file="bottom.jsp" %> 
</body> 
</html>