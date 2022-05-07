<%@page import="saymeow.MemberMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>                                      
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />                                   
<%
 request.setCharacterEncoding("EUC-KR");
    String mid = request.getParameter("mid");     
    String phone = request.getParameter("phone");
     
MemberMgr mgr = new MemberMgr();
 String pwd = mMgr.findPw(mid, phone); 
 
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
       if (pwd != null) {
      %>
      
      <div class = "container">
      	<div class = "found-success">
	      <h4>회원님의 비밀번호는 </h4>  
	      <div class ="found-id"> <%=pwd%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-login">
 		   <input type="button" id="btnLogin" value="로그인" onClick ="location.href='login.jsp'"/>
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