<!-- �α��ξ��ϸ� ���ٺҰ��� ����ǰ�� �α������� �̵��ȴ�. �׷��Ƿ� ������� ���Ǽ��� ���ؼ��� �����ִ� �������� �̵��� �� �ְ� �ϴ� ���� ����.
�׷��� ����������� �����־����� ������ �޾Ƽ� if���� �����ؾ��ϴµ�, �̰� ���Ŀ� �ð� ������ �����ϸ� ���� �� ����.-->
<!-- ���տϷ� -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />                                      
<%
	//<input type="button" value="ȸ����������" onclick="location.href='memberUpdate.jsp';"><<ȸ���������� ��ư

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<!-- �ܺ� CSS -->				
<link rel="stylesheet" href="css/styleTW.css">						
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">						
<%@include file="top2.jsp"%>
</head> 
<body> 
	<form method="post" action="loginProc.jsp" id="item">
		<table id="level">
			<tr>  
				<td id="level2">
					<table id="level3">
						<tr> 
							<td colspan="2" align="center"><span class="loginlo"><h3>�α���</h3><br><br></span></td>
						</tr>
						<tr align="center"> 
							<td><span class="loginlo">���̵�&nbsp;</span></td>
							<td><input class="idTf" name="id" value="aaa"></td>
						</tr>
						<tr align="center"> 
							<td><span class="loginlo">��й�ȣ&nbsp;<br><br></span></td>
							<td><input class="pwTf" name="pwd" value="1234"><br><br></td>	
						</tr>
						<tr>
							<td style="padding:2px" colspan="4" align="center">
							<button type="submit" class="logbtn">�α���</button></td>
						</tr>
						<tr>
							<td style="padding:2px" colspan="4" align="center">	
							<input type="button" class="joinbtn" value="ȸ������" onclick="location.href='member.jsp'">
							</td>
						</tr>
						<tr>
							<td style="padding:2px" colspan="2" align="center">
								<input type="button" class="lbtn" value="IDã��" onclick="location.href='findid.jsp'">
								<input type="button" class="lbtn" value="PWã��" onclick="location.href='findPw.jsp'">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>		
</body> 
</html>