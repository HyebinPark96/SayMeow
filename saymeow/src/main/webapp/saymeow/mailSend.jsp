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
<!-- ���� CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<script>
	// ���̵� �� �̸��� value�� .proc�� �����ϴ� ���
	function submitForMailSend(){
		document.mailSendFrm.submit();
	}
</script>
<!-- �ܺ� CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top.jsp" %>
</head>
<!-- id�� email �Է��� ��ư ������ emailSendFrm�� value�� ���޵�. -->
<body id="mailSendBody" >
	<h2 style="margin-top: 2vw; text-align:center;">���̵�� �̸��Ϸ�</h2>
	<h2 style="margin-bottom: 2vw; text-align:center;">��й�ȣ ã��</h2>
	<div id="mailSend" style="background-color:pink; width: 40vw; margin:15vh auto;">
		<form name="mailSendFrm" action="mailSendProc.jsp" method="post" 
		style="">
			<table> 
				<tr>
					<th width="100" style="font-size:1.6em;">Id</th>
					<td><input name="id" style="width:20vw;" placeholder="abc1234"></td>
					<td rowspan="2"><input type="button" class="btn btn-primary" value="��й�ȣ ã��" onclick="submitForMailSend()" style="font-size:1.3em; margin:2vw"></td>
				</tr>
				<tr>
					<th width="100" style="font-size:1.6em;">Email</th>
					<td><input name="email" style="width:20vw;" placeholder="abc@abc.com"></td>
				</tr>
			</table>
		</form>
	</div>

<!-- ��Ʈ��Ʈ�� JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>
<%@ include file="bottom.jsp" %>
</body>
</html>