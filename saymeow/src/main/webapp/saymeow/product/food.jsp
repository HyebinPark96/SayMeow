<!-- 사료 카테고리 (메인에서 눌러서 들어옴) -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ProductMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<%
ProductMgr mgr = new ProductMgr();

String mClass = request.getParameter("mClass");
String sClass = request.getParameter("sClass");
String sort = request.getParameter("sort");

if(mClass==null) {
mClass="food";
}

System.out.println("[product] mClass:"+ mClass + " /sClass:"+sClass + " /sort:" + sort);
Vector<ProductBean> pvlist = mgr.getP2(mClass, sClass, sort); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>food</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' type='text/css' media='screen'href='css/plist.css'>
<jsp:include page = "../top2.jsp"/>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}


function sel(){ 
	var langSelect = document.getElementById("sort"); 
	// select element에서 선택된 option의 value가 저장된다. 
	var selectValue = langSelect.options[langSelect.selectedIndex].value; 
	// select element에서 선택된 option의 text가 저장된다. 
	var selectText = langSelect.options[langSelect.selectedIndex].text; 
}

</script>
<body>
	상품리스트페이지입니다.
	<div id="container">
		<!-- 카테고리(sidebar) -->
		<section class="category">
			<h3>카테고리</h3>
			<ul>
				<li><a href="#" onclick="return send_form('frmFo')">고양이 사료</a>
					<form method="post" id="frmFo" action="productProc.jsp">
						<input type=hidden name="mClass" value="food">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmDr')">건식사료</a>
							<form method="post" id="frmDr" action="productProc.jsp">
								<input type=hidden name="mClass" value="food"> <input
									type=hidden name="sClass" value="dry">
							</form></li>
						<li><a href="#" onclick="return send_form('frmWe')">습식사료</a>
							<form method="post" id="frmWe" action="productProc.jsp">
								<input type=hidden name="mClass" value="food"> <input
									type=hidden name="sClass" value="wet">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmTr')">고양이 간식</a>
					<form method="post" id="frmTr" action="productProc.jsp">
						<input type=hidden name="mClass" value="treat">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmSn')">스낵</a>
							<form method="post" id="frmSn" action="productProc.jsp">
								<input type=hidden name="mClass" value="treat"> <input
									type=hidden name="sClass" value="snack">
							</form></li>
						<li><a href="#" onclick="return send_form('frmSt')">스틱</a>
							<form method="post" id="frmSt" action="productProc.jsp">
								<input type=hidden name="mClass" value="treat"> <input
									type=hidden name="sClass" value="stick">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmTo')">고양이 장난감</a>
					<form method="post" id="frmTo" action="productProc.jsp">
						<input type=hidden name="mClass" value="toy">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmPo')">막대/낚싯대</a>
							<form method="post" id="frmPo" action="productProc.jsp">
								<input type=hidden name="mClass" value="toy"> <input
									type=hidden name="sClass" value="pole">
							</form></li>
						<li><a href="#" onclick="return send_form('frmPl')">인형</a>
							<form method="post" id="frmPl" action="productProc.jsp">
								<input type=hidden name="mClass" value="toy"> <input
									type=hidden name="sClass" value="plush">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmLi')">고양이
						배변용품</a>
					<form method="post" id="frmLi" action="productProc.jsp">
						<input type=hidden name="mClass" value="litter">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmSa')">모래</a>
							<form method="post" id="frmSa" action="productProc.jsp">
								<input type=hidden name="mClass" value="litter"> <input
									type=hidden name="sClass" value="sand">
							</form></li>
						<li><a href="#" onclick="return send_form('frmBo')">화장실</a>
							<form method="post" id="frmBo" action="productProc.jsp">
								<input type=hidden name="mClass" value="litter"> <input
									type=hidden name="sClass" value="box">
							</form></li>
					</ol></li>
			</ul>
		</section>
		<section class="plist">
			<div class="ptop">
			
				현재 카테고리:
				<%=mClass%> - <%=sClass%>
				<div class="array">n개의 상품이 있습니다. 
				<form action="productProc.jsp">
				<h5>정렬방식
				<select name="sort" onchange="this.form.submit()">
				<option value="0">최신순</option>
				<option value="1">높은가격순</option>
				<option value="2">낮은가격순</option>
<!-- 			<option value="3" >인기순</option>
				<option value="4" >리뷰순</option> -->
				</select>
				<input type=hidden name="mClass" value="<%=mClass%>">
				<input type=hidden name="sClass" value="<%=sClass%>">
				</h5>
				</form>
				</div>
				
			</div>
			<div class="product_list" id="product_list">
				여기서부터 상품진열<br>
				<ul class="product_row">
					<%
							for (int i=0; i<pvlist.size(); i++) {
								ProductBean pbean = pvlist.get(i);
						%>
					<li><img src="../image/<%=pbean.getImage()%>" height="200"
						width="200"><br> <%=pbean.getPname()%><br> <%=UtilMgr.monFormat(pbean.getPrice1())%>원<br>
					</li>
					<%} //--for%>
				</ul>	
			</div>

		</section>
	</div>
</body>
</html>
