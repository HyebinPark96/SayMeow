<%@page import="saymeow.UtilMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<title>SayMeow</title>
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<script>
	// 아이디 및 이메일 value를 .proc로 전달하는 기능
	function submitForMailSend(){
		document.mailSendFrm.submit();
	}
</script>
<!-- 외부 CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top.jsp" %>
</head>
<!-- id와 email 입력후 버튼 누르면 emailSendFrm의 value값 전달됨. -->
<body id="mailSendBody" >
	<h2 style="margin-top: 2vw; text-align:center;">아이디와 이메일로</h2>
	<h2 style="margin-bottom: 2vw; text-align:center;">비밀번호 찾기</h2>
	<div id="mailSend" style="background-color:pink; width: 40vw; margin:15vh auto;">
		<form name="mailSendFrm" action="mailSendProc.jsp" method="post" 
		style="">
			<table> 
				<tr>
					<th width="100" style="font-size:1.6em;">Id</th>
					<td><input name="id" style="width:20vw;" placeholder="abc1234"></td>
					<td rowspan="2"><input type="button" class="btn btn-primary" value="비밀번호 찾기" onclick="submitForMailSend()" style="font-size:1.3em; margin:2vw"></td>
				</tr>
				<tr>
					<th width="100" style="font-size:1.6em;">Email</th>
					<td><input name="email" style="width:20vw;" placeholder="abc@abc.com"></td>
				</tr>
			</table>
		</form>
	</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>
<%@ include file="bottom.jsp" %>
</body>
</html>