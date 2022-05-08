<%@page import="saymeow.MemberMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>                                      
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
 request.setCharacterEncoding("EUC-KR");
    String name = request.getParameter("name");
     String phone = request.getParameter("phone");
     
MemberMgr mgr = new MemberMgr();
 String member_mid = mMgr.findid(name, phone); 
 
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR"> 
</head> 
<body> 
	<%@ include file="top.jsp" %>
	 <form name="idsearch" method="post">
      <%
       if (member_mid != null) {
      %>
      
      <div class = "container">
      	<div class = "found-success">
	      <h4>  회원님의 아이디는 </h4>  
	      <div class ="found-id"><%=member_mid%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onClick ="location.href='login.jsp'"/>
 		     <input type="button" id="btnLogin" value="비밀번호 찾기" onClick ="location.href='findPw.jsp'"/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      <h4>  등록된 정보가 없습니다 </h4>  
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnback" value="다시 찾기" onClick="history.back()"/>
 		    <input type="button" id="btnjoin" value="회원가입" onClick="location.href='member.jsp'"/>
       	</div>
       </div>
       <%
  }
 %> 
      </form>
	<%@ include file="bottom.jsp" %> 
</body> 
</html>