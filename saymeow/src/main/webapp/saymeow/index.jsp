<!-- ����ȭ�� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ProductMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<% 

//id�� �޾ƿ���
String id = request.getParameter("id"); // ���� ���������� �޾ƿ���
if(session.getAttribute("idKey")!=null){ // id���� �������� ����Ǿ� �ִٸ�
	id = (String) session.getAttribute("idKey");
} 

//�׽�Ʈ�� ���Ǽ��� 
id = "aaa";


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
function send_form(frmId) { // form ����
	document.getElementById(frmId).submit();
}
</script>
<body>
<br><br>
	<!-- ��� -->
    <section class="bsection">
    <img src="image/banner.png" height="360" width="1100">
    </section>	
	<!-- ��ǰ����Ʈ�� -->
	<section class="psection">
			<div class="plist">
				<br><br><br><div class="new">NEW PRODUCT<br><br><br></div>
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
						<%=UtilMgr.monFormat(pbean.getPrice1())%>��<br><br>
					</li>
					<%} //--for%>
				</ul>	
			</div>
			<div class="more">
				<br><br><a href="product/food.jsp">more</a>
            </div>
		</section>
</body>
<!-- ��Ʈ��Ʈ�� JS -->					
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"					
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"					
crossorigin="anonymous">					
</script>					
<%@ include file="bottom.jsp" %>					
</html>