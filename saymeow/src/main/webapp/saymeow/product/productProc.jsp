<%@page contentType="text/html; charset=EUC-KR"%>

<%
String mClass = request.getParameter("mClass");
String sClass = request.getParameter("sClass");


if (sClass!=null) { // �ߺз� ���� %>
	<form  method="post" id="frm" action="<%=mClass%>.jsp">
		<input type=hidden name="mClass" value="<%=mClass%>">
		<input type=hidden name="sClass" value="<%=sClass%>">
	</form> 
	<script>
		document.getElementById('frm').submit();
	</script> 
<% }else { // �ߺз� �̼��� %>
	<form  method="post" id="frm" action="<%=mClass%>.jsp">
		<input type=hidden name="mClass" value="<%=mClass%>">
	</form> 
	<script>
		document.getElementById('frm').submit();
	</script>
	<% 	}	
	System.out.println("[proProc]mClass:" + mClass + " /sClass:" + sClass); 
%>

