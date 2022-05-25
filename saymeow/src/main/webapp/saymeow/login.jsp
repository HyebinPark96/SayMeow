<!-- 로그인안하면 접근불가한 기능의경우 로그인으로 이동된다. 그러므로 사용자의 편의성을 위해서는 보고있던 페이지로 이동할 수 있게 하는 것이 좋다.
그런데 어느페이지를 보고있었는지 변수를 받아서 if절로 구분해야하는데, 이건 차후에 시간 남으면 구현하면 좋을 것 같다.-->
<!-- 취합완료 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />                                      
<%
	//<input type="button" value="회원정보수정" onclick="location.href='memberUpdate.jsp';"><<회원정보수정 버튼

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<!-- 외부 CSS -->				
<link rel="stylesheet" href="css/styleTW.css">						
<!-- 부트스트랩 CSS -->						
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
							<td colspan="2" align="center"><span class="loginlo"><h3>로그인</h3><br><br></span></td>
						</tr>
						<tr align="center"> 
							<td><span class="loginlo">아이디&nbsp;</span></td>
							<td><input class="idTf" name="id" value="aaa"></td>
						</tr>
						<tr align="center"> 
							<td><span class="loginlo">비밀번호&nbsp;<br><br></span></td>
							<td><input class="pwTf" name="pwd" value="1234"><br><br></td>	
						</tr>
						<tr>
							<td style="padding:2px" colspan="4" align="center">
							<button type="submit" class="logbtn">로그인</button></td>
						</tr>
						<tr>
							<td style="padding:2px" colspan="4" align="center">	
							<input type="button" class="joinbtn" value="회원가입" onclick="location.href='member.jsp'">
							</td>
						</tr>
						<tr>
							<td style="padding:2px" colspan="2" align="center">
								<input type="button" class="lbtn" value="ID찾기" onclick="location.href='findid.jsp'">
								<input type="button" class="lbtn" value="PW찾기" onclick="location.href='findPw.jsp'">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>		
</body> 
</html>