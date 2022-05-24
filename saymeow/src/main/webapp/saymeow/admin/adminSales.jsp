<!-- �Ǹŵ����� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="dMgr" class="saymeow.AdminSalesDataMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Ǹŵ�����</title>
	<!-- �ܺ� JS -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
    <!-- �����׷��� -->
    <script type="text/javascript">
		google.charts.load("current", {packages:["corechart"]});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
        	var data = google.visualization.arrayToDataTable([
	          ['Task', 'Hours per Day'],
	          ['<%=dMgr.getSalesDataPname(0)%>',     <%=dMgr.getSalesDataPnum(0)%>],
	          ['<%=dMgr.getSalesDataPname(1)%>',      <%=dMgr.getSalesDataPnum(1)%>],
	          ['<%=dMgr.getSalesDataPname(2)%>',  <%=dMgr.getSalesDataPnum(2)%>],
	          ['<%=dMgr.getSalesDataPname(3)%>', <%=dMgr.getSalesDataPnum(3)%>],
	          ['<%=dMgr.getSalesDataPname(4)%>',    <%=dMgr.getSalesDataPnum(4)%>]
	        ]);

	        var options = {
	          title: 'Sales Data',
	          pieHole: 0.4,
	        };
	
	        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
	        chart.draw(data, options);
		}
	</script>
      
	<!-- ����׷��� : ���� �⵵�� �������� 4��ġ ������ (Ex.23��Ǹ� 20~23�� ������) -->
	<script type="text/javascript">
		google.charts.load('current', {packages:['bar']});
		google.charts.setOnLoadCallback(drawChart);

		function drawChart() {
			var data = google.visualization.arrayToDataTable([
	          ['Year', 'Sales', 'Expenses', 'Profit'], 
	          ['<%=dMgr.getStandardYear(3)%>', <%=dMgr.getSales(dMgr.getStandardYear(3))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(3))%>, <%=dMgr.getSales(dMgr.getStandardYear(3))-dMgr.getExpenses(dMgr.getStandardYear(3))%>],
	          ['<%=dMgr.getStandardYear(2)%>', <%=dMgr.getSales(dMgr.getStandardYear(2))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(2))%>, <%=dMgr.getSales(dMgr.getStandardYear(2))-dMgr.getExpenses(dMgr.getStandardYear(2))%>],
	          ['<%=dMgr.getStandardYear(1)%>', <%=dMgr.getSales(dMgr.getStandardYear(1))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(1))%>, <%=dMgr.getSales(dMgr.getStandardYear(1))-dMgr.getExpenses(dMgr.getStandardYear(1))%>],
	          ['<%=dMgr.getStandardYear(0)%>', <%=dMgr.getSales(dMgr.getStandardYear(0))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(0))%>, <%=dMgr.getSales(dMgr.getStandardYear(0))-dMgr.getExpenses(dMgr.getStandardYear(0))%>]
	        ]);

	        var options = {
	          chart: {
	            title: 'Company Performance',
	            subtitle: 'Sales, Expenses, and Profit: <%=dMgr.getStandardYear(3)%>-<%=dMgr.getStandardYear(0)%>',
	          },
	          bars: 'vertical',
	          vAxis: {format: 'decimal'},
	          height: 400,
	          colors: ['#1b9e77', '#d95f02', '#7570b3']
	        };

	        var chart = new google.charts.Bar(document.getElementById('chart_div'));
	
	        chart.draw(data, google.charts.Bar.convertOptions(options));
	
	
	        btns.onclick = function (e) {
	
	        if (e.target.tagName === 'BUTTON') {
				options.vAxis.format = e.target.id === 'none' ? '' : e.target.id;
	            chart.draw(data, google.charts.Bar.convertOptions(options));
			}
		}
	}
    </script>
    
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
</head>
<body>
	<div class="d-flex align-items-start">
		<!-- ���̵�� -->
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
			<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
			<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
			<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
			<a href="../sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
			<a href="adminSales.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
		</div>
		<!-- ���� -->
		<div>
			<div id="donutchart" style="width: 900px; height: 500px;">
			</div>
			<div id="chart_div" style="margin-top:4vh;">
			</div>
		</div>
	</div>
</body>
</html>