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
	      <h4>ȸ������ ��й�ȣ�� </h4>  
	      <div class ="found-id"> <%=pwd%></div>
	      <h4>  �Դϴ� </h4>
	     </div>
	     <div class = "found-login">
 		   <input type="button" id="btnLogin" value="�α���" onClick ="location.href='login.jsp'"/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      <h4>  ��ϵ� ������ �����ϴ� </h4>  
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnback" value="�ٽ� ã��" onClick="history.back()"/>
 		   <input type="button" id="btnjoin" value="ȸ������" onClick="location.href='member.jsp'"/>
       	</div>
       </div>
       
       
       <%
  }
 %> 
      </form>
	<%@ include file="bottom.jsp" %> 
</body> 
</html>