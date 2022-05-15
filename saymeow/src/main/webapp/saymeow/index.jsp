<!-- 취합완료 -->

<!-- 메인화면 -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ProductMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<% 
ProductMgr mgr = new ProductMgr();
Vector<ProductBean> pvlist = mgr.getP3(); 
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Index</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='css/index.css'>	
    <!-- 부트스트랩 CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">    
<%@ include file="top2.jsp" %>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}
</script>
<body>
	<!-- 배너 -->
    <section class="bsection">
    <img src="image/banner.png" height="360" width="1100">
    </section>	
	<!-- 상품리스트업 -->
	<section class="psection">
			<div class="plist">
				<br><br><h3 class="new">NEW PRODUCT<br><br><br></h3>
				<ul class="prow">
					<%
						for (int i=0; i<pvlist.size(); i++) {
						ProductBean pbean = pvlist.get(i);
					%>
					<li>
					<a href="#" onclick="send_form('frmP')">
					<img src="image/<%=pbean.getImage()%>" height="200" width="200">
						<%=pbean.getPname()%></a>
						<form method="post" id="frmP" action="product/productDetail.jsp">
							<input type=hidden name="id" value="<%=id%>">
							<input type=hidden name="pnum" value="<%=pbean.getPnum()%>">
						</form>
						<%=UtilMgr.monFormat(pbean.getPrice1())%>원<br><br>
					</li>
					<%} //--for%>
				</ul>	
			</div>
			<div class="more">
				<a href="product/food.jsp">
					<input type="button" value="more" class="btn btn-light">
				</a>
            </div>
		</section>
</body>				
</html>