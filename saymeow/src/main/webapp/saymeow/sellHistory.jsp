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
    int getPrice = 1000;//재설정하기 (물품 가격)
    
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
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top2.jsp" %>
</head>
<body>
<!-- 사이드바 40%, 창 60% -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="admin/adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문관리</button></a>
		<a href="admin/adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원관리</button></a>
		<a href="admin/adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">리뷰관리</button></a>
		<a href="admin/adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">상품관리</button></a>
		<a href="sellHistory.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">매출관리</button></a>
		<a href="#"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">판매데이터</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<!-- 본문 -->
<form name="sFrm">
	<select name="year" onchange="selectYFn(this.form.year.value)">
		<option value="2022" selected>2022년</option>
	</select>
	<select name="month" onchange="selectMFn(this.form.month.value)">
		<%for(int i=1;i<13;i++){%>
		<option value="<%=i%>"><%=i%>월</option>
		<%}%>
	</select>
</form>
	<script>
		document.sFrm.year.value=<%=year%>;
		document.sFrm.month.value=<%=month%>;
	</script>
<table>
	<tr>
		<td>상품 번호</td>
		<td>상품명</td>
		<td>판매 수량</td>
		<td>판매 금액</td>
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
		<td colspan="4">판매 내역이 없습니다</td>
	</tr>
	<%	}
	}%>
</table>


<h1>총 판매금액은 <%=sellTotal%>원 입니다.</h1>


<form name="readFrm">
<input type="hidden" name="year" value="<%=year%>">
<input type="hidden" name="month" value="<%=month%>"> 
</form>
  	</div>
</div>

</body>
</html>