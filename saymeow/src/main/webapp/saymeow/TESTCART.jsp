<%@page contentType="text/html; charset=EUC-KR"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<title>TESTCART</title>
<script src="saymeowScript.js">

</script>
</head>
<body>
<%@ include file="top2.jsp" %>
<form method="post" name="test" action="cartInsertProc.jsp">
<table>
<tr>
<td><input name="pnum" value="15" ></td>
<td><input name="price1" value="3000" ></td>
<td><input name="pname" value="�Է¿�1"></td>
<td><input name="qty" value="5"></td>
<td><input name="oid" value="<%=oid%>"></td>
</tr>
</table>
<input type="button" value="��ٱ��� ���" onclick="javascript:cartInsert(this.form)">
<input type="button" value="�����ϱ�" onclick="javascript:directOrder(this.form)">


<input type="hidden" name="flag">
</form>
</body>
</html>