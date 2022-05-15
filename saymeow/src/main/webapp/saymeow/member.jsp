<!-- 취합완료 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<html>
<head>
<title>saymeow</title>
<script src="script.js"></script>
</head>
<!-- 외부 CSS -->
<link rel="stylesheet" href="css/styleTW.css">
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp"%>
<body id="memberbd">
	<form name="regForm" method="post" action="memberProc.jsp">
		<table class="regFormTb">

			<tr>
				<td>
				<h3 style="text-align:center"><br>회원가입</h3><br>
					<table class="jointb">										
						<tr>
							<td style="padding:2px" width="16%">아이디</td>
							<td style="padding:2px" width="57%">
								<input name="id" size="17"> 
								<input type="button" value="중복확인" onClick="idCheck(this.form.id.value)" 
								class="btn btn-primary checkIdBtn">
							</td>
						</tr>
						<tr>
							<td style="padding:2px">패스워드</td>
							<td style="padding:2px"><input type="password" name="pwd" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">패스워드 확인</td>
							<td style="padding:2px"><input type="password" name="repwd" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">이름</td>
							<td style="padding:2px"><input name="name" size="17"></td>

						</tr>

						<tr>
							<td style="padding:2px">생년월일</td>
							<td style="padding:2px"><input name="birthday" size="17"> ex)830815</td>

						</tr>
						<tr>
							<td style="padding:2px">전화번호</td>
							<td style="padding:2px"><input name="phone" size="17"></td>
						</tr>
						<tr>
							<td style="padding:2px">이메일</td>
							<td style="padding:2px"><input name="email" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">주소</td>
							<td style="padding:2px"><input name="address" size="17"></td>

						</tr>
						<tr>
							<td style="padding:2px">고양이이름</td>
							<td style="padding:2px"><input name="petName" size="17"></td>
						</tr>
						<tr>
							<td style="padding:2px">고양이나이</td>
							<td style="padding:2px"><input name="petAge" size="17"> xxxx-xx-xx/-포함입력</td>

						</tr>
						<tr>
							<td style="padding:2px">고양이성별</td>
							<td style="padding:2px">남<input type="radio" name="petGender" value="1" checked>
								여<input type="radio" name="petGender" value="2">
							</td>
						</tr>
						<tr>
							<td style="padding:2px">고양이품종</td>
							<td style="padding:2px"><input name="petBreed" size="17"></td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<div style="margin: 2vw;">
									<input type="button" value="회원가입" onclick="inputCheck()" class="btn btn-primary"> 
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
									<input type="button" value="가입취소" onClick="location.href='login.jsp'" class="btn btn-primary">
								</div>
							</td>
						</tr>
						<tr>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>

</body>
</html>

