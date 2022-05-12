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
<jsp:include page = "top2.jsp"/>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}
</script>
<body>
메인입니다.
	<!-- 배너 -->
    <section class="bsection">
    <img src="image/banner.png" height="360" width="1100"> 
    </section>	
	<!-- 상품리스트업 -->
	<section class="psection">
			<div class="plist">
				<h1>NEW PRODUCT</h1><br>
				<ul class="prow">
					<%
						for (int i=0; i<pvlist.size(); i++) {
						ProductBean pbean = pvlist.get(i);
					%>
					<li><img src="image/<%=pbean.getImage()%>" height="200" width="200">
						<br><%=pbean.getPname()%><br>
						<%=UtilMgr.monFormat(pbean.getPrice1())%>원<br><br>
					</li>
					<%} //--for%>
				</ul>	
			</div>
			<div class="more">
				<a href="product/food.jsp">more</a>
            </div>
		</section>
</body>
<!-- 부트스트랩 JS -->					
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"					
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"					
crossorigin="anonymous">					
</script>					
<%@ include file="bottom.jsp" %>					
</html>