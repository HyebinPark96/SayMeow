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
<link rel="stylesheet" href="css/styleTW.css">
</head> 
<!-- �ܺ� CSS -->						
<link rel="stylesheet" href="css/style.css">											
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="top2.jsp"%>
<body> 
	 <form name="idsearch" method="post" >
      <%
       if (member_mid != null) {
      %>
      <table id="level">
		<tr><td id="level2">
		<table id="level3">
		<tr><td>
      <div class = "container" >
      	<div class = "found-success">
	      <h5>ȸ������ ���̵�� </h5><br>  
	      <div class ="found-id"><b><%=member_mid%></b><br><br></div>
	      <h5>�Դϴ�.</h5><br>
	     </div>
	     <div class = "found-login">
 		    <input type="button" class="find"id="btnLogin" value="�α���" onClick ="location.href='login.jsp'"/>
 		     <input type="button" class="cancel"id="btnLogin" value="��й�ȣ ã��" onClick ="location.href='findPw.jsp'"/>
       	</div>
       </div>
       </table>
 	</td></tr>
 	</table>
      <%
  } else {
 %>
 <table id="level">
		<tr><td id="level2">
		<table id="level3">
		<tr><td>
        <div class = "container" >
      	<div class = "found-fail" >
	      <h4>��ϵ� ȸ�� ������ �����ϴ� </h4><br><br> 
	     </div>
       </div>
       
       </td>
       </tr>
       <tr><td>
           <div class = "found-login">
 		    <input type="button" class="find"id="btnback" value="�ٽ� ã��" onClick="history.back()"/>
 		    <input type="button" class="cancel"id="btnjoin" value="ȸ������" onClick="location.href='member.jsp'"/>
       	</div>
       </td></tr>
       </table>
       </td></tr></table>
       <%
  }
 %> 
      </form>
</body> 
</html>