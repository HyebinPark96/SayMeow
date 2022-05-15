<!-- 취합완료 -->

<!-- 로그인 처리페이지 -->
<%@page contentType="text/html;charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	int mode = mMgr.loginMember(id, pwd);
	 
	if(mode==2){ // 비회원일 경우%>
	<script>
		alert('아이디와 비밀번호가 정확하지 않습니다!');
		history.back();
	</script>
	<%
	} else if(mode==0 || mode==1){ // 회원이거나 관리자인경우
		session.setAttribute("idKey",id); // 로그인 성공한 id를 세션에 저장
		response.sendRedirect("index.jsp");
	}
	%>

