<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="aMgr" class="saymeow.AdminMgr"/>
<%
	int sellTotal = 0;
	String state = "1";
	int month = 0;
	int year = 0;
	
    if(request.getParameter("year")!=null){
    	year = UtilMgr.parseInt(request, "year");
    }
    if(request.getParameter("month")!=null){
    	month = UtilMgr.parseInt(request, "month");
    }
    int getPrice = 1000;//�缳���ϱ� (��ǰ ����)
    
%>
<!DOCTYPE html>
<html>
<head>
<title>Sell History</title>
<script type="text/javascript">
function selectYFn(year){
	document.readFrm.year.value=year;
	document.readFrm.submit();
}
function selectMFn(month){
	document.readFrm.month.value=month;
	document.readFrm.submit();
}
</script>
</head>
<body>
<form name="sFrm">
	<select name="year" onchange="selectYFn(this.form.year.value)">
		<option value="2022" selected>2022��</option>
	</select>
	<select name="month" onchange="selectMFn(this.form.month.value)">
		<%for(int i=1;i<13;i++){%>
		<option value="<%=i%>"><%=i%>��</option>
		<%}%>
	</select>
</form>
	<script>
		document.sFrm.year.value=<%=year%>;
		document.sFrm.month.value=<%=month%>;
	</script>
<table>
	<tr>
		<td>��ǰ ��ȣ</td>
		<td>��ǰ��</td>
		<td>�Ǹ� ����</td>
		<td>�Ǹ� �ݾ�</td>
	</tr>
	<%if(year==0&&month==0){
		Vector<OrderBean> vlist = aMgr.showAllOrder();
		for(int i=0;i<vlist.size();i++){
			OrderBean order = vlist.get(i);
			int pnum = order.getPnum();
			String pname = order.getPname();
			int qty = order.getQty();
			int total = qty*getPrice;
			sellTotal += total;
	%>
	<tr>
		<td><%=pnum%></td>
		<td><%=pname%></td>
		<td><%=qty%></td>
		<td><%=total%></td>
	</tr>
	<%	}
	}else if(year!=0&&month==0){
		Vector<OrderBean> vlist = aMgr.selectYRegdate(year);
		for(int i=0;i<vlist.size();i++){
			OrderBean order = vlist.get(i);
			int pnum = order.getPnum();
			String pname = order.getPname();
			int qty = order.getQty();
			int total = qty*getPrice;
			sellTotal += total;
	%>
	<tr>
		<td><%=pnum%></td>
		<td><%=pname%></td>
		<td><%=qty%></td>
		<td><%=total%></td>
	</tr>
	<%	}
	}else if(year!=0&&month!=0){
		Vector<OrderBean> vlist = aMgr.selectYMRegdate(year, month);
		if(vlist.size()!=0){
			for(int i=0;i<vlist.size();i++){
				OrderBean order = vlist.get(i);
				int pnum = order.getPnum();
				String pname = order.getPname();
				int qty = order.getQty();
				int total = qty*getPrice;
				sellTotal += total;
	%>
	<tr>
		<td><%=pnum%></td>
		<td><%=pname%></td>
		<td><%=qty%></td>
		<td><%=total%></td>
	</tr>
	<%		}
		}else if(vlist.size()==0){%>
	<tr>
		<td colspan="4">�Ǹ� ������ �����ϴ�</td>
	</tr>
	<%	}
	}%>
</table>


<h1>�� �Ǹűݾ��� <%=sellTotal%>�� �Դϴ�.</h1>


<form name="readFrm">
<input type="hidden" name="year" value="<%=year%>">
<input type="hidden" name="month" value="<%=month%>"> 
</form>
</body>
</html>