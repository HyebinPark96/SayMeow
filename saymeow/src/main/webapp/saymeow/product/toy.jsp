<!-- �峭�� ī�װ��� (���ο��� ������ ����) -->
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
mClass="toy";
} 
System.out.println("[catfood] mClass:"+ mClass + " /sClass:"+sClass + " /sort:" + sort);
Vector<ProductBean> pvlist = mgr.getP2(mClass, sClass, sort); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>toy</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' type='text/css' media='screen'href='../css/plist.css'>
</head>
<script>
function send_form(frmId) { // form ����
	document.getElementById(frmId).submit();
}
</script>
<body>
	��ǰ����Ʈ�������Դϴ�.
	<div id="container">
		<!-- ī�װ���(sidebar) -->
		<section class="category">
			<h3>ī�װ���</h3>
			<ul>
				<li><a href="#" onclick="return send_form('frmFo')">������ ���</a>
					<form method="post" id="frmFo" action="productProc.jsp">
						<input type=hidden name="mClass" value="food">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmDr')">�ǽĻ��</a>
							<form method="post" id="frmDr" action="productProc.jsp">
								<input type=hidden name="mClass" value="food"> <input
									type=hidden name="sClass" value="dry">
							</form></li>
						<li><a href="#" onclick="return send_form('frmWe')">���Ļ��</a>
							<form method="post" id="frmWe" action="productProc.jsp">
								<input type=hidden name="mClass" value="food"> <input
									type=hidden name="sClass" value="wet">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmTr')">������ ����</a>
					<form method="post" id="frmTr" action="productProc.jsp">
						<input type=hidden name="mClass" value="treat">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmSn')">����</a>
							<form method="post" id="frmSn" action="productProc.jsp">
								<input type=hidden name="mClass" value="treat"> <input
									type=hidden name="sClass" value="snack">
							</form></li>
						<li><a href="#" onclick="return send_form('frmSt')">��ƽ</a>
							<form method="post" id="frmSt" action="productProc.jsp">
								<input type=hidden name="mClass" value="treat"> <input
									type=hidden name="sClass" value="stick">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmTo')">������ �峭��</a>
					<form method="post" id="frmTo" action="productProc.jsp">
						<input type=hidden name="mClass" value="toy">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmPo')">����/���˴�</a>
							<form method="post" id="frmPo" action="productProc.jsp">
								<input type=hidden name="mClass" value="toy"> <input
									type=hidden name="sClass" value="pole">
							</form></li>
						<li><a href="#" onclick="return send_form('frmPl')">����</a>
							<form method="post" id="frmPl" action="productProc.jsp">
								<input type=hidden name="mClass" value="toy"> <input
									type=hidden name="sClass" value="plush">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmLi')">������
						�躯��ǰ</a>
					<form method="post" id="frmLi" action="productProc.jsp">
						<input type=hidden name="mClass" value="litter">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmSa')">��</a>
							<form method="post" id="frmSa" action="productProc.jsp">
								<input type=hidden name="mClass" value="litter"> <input
									type=hidden name="sClass" value="sand">
							</form></li>
						<li><a href="#" onclick="return send_form('frmBo')">ȭ���</a>
							<form method="post" id="frmBo" action="productProc.jsp">
								<input type=hidden name="mClass" value="litter"> <input
									type=hidden name="sClass" value="box">
							</form></li>
					</ol></li>
			</ul>
		</section>
		<section class="plist">
			<div class="ptop">
				���� ī�װ���:
				<%=mClass%> - <%=sClass%>
				<div class="array">n���� ��ǰ�� �ֽ��ϴ�. 
				<form action="productProc.jsp">
				<h5>���Ĺ��
				<select name="sort" onchange="this.form.submit()">
				<option value="0">�ֽż�</option>
				<option value="1" >�������ݼ�</option>
				<option value="2" >�������ݼ�</option>
<!-- 			<option value="3" >�α��</option>
				<option value="4" >�����</option> -->
				</select>
				<input type=hidden name="mClass" value="<%=mClass%>">
				<input type=hidden name="sClass" value="<%=sClass%>">
				</h5>
				</form>
				</div>
			</div>
			<div class="product_list" id="product_list">
				���⼭���� ��ǰ����<br>
				<ul class="product_row">
					<%
							for (int i=0; i<pvlist.size(); i++) {
								ProductBean pbean = pvlist.get(i);
						%>
					<li><img src="../image/<%=pbean.getImage()%>" height="200"
						width="200"><br> <%=pbean.getPname()%><br> <%=UtilMgr.monFormat(pbean.getPrice1())%>��<br>
					</li>
					<%} //--for%>
				</ul>
			</div>

		</section>
	</div>
</body>
</html>