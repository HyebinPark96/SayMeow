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
							<td colspan="2" align="center"><span class="loginlo">�α���</span></td>
						</tr>
						<tr align="center"> 
							<td><span class="loginlo">ID</span></td>
							<td><input name="id" value="aaa"></td>
						</tr>
						<tr> 
							<td align="center"><span class="loginlo">Password</span></td>
							<td align="center"><input name="pwd" value="1234"></td>	
						</tr>
						<tr>
							<td colspan="2" align="center" ><input type="submit" value="�α���" class="logbtn">
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="button" class="lbtn"value="ȸ������" onclick="location.href='member.jsp';">
								<input type="button" class="lbtn" value="���̵�ã��" onclick="location.href='findid.jsp'">
								<input type="button" class="lbtn" value="��й�ȣã��" onclick="location.href='findPw.jsp'">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>		
</body> 
</html>