<!-- ���տϷ�, ������ ���ô� �׽�Ʈ ���غ� -> ������ ���� ����-->
<!-- (�߿�) ������� ����� saymeowScript.js�� �켱������ �۵��Ͽ���, ��ȭ���� �α��� üũ ��ũ��Ʈ�� �ƿ� ����X �ȵǴ� ���� �ذ��� ����
������� js���� �����ڵ带 �ƿ� ��������. 
-->
<!-- image null ���� ���ٰ� ��. -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.RCommentBean"%>
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pdMgr" class="saymeow.ProductDetailMgr" />
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr" />
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr" />
<jsp:useBean id="rcBean" class="saymeow.RCommentBean" />

<%
request.setCharacterEncoding("EUC-KR");
// pnum �� �޾ƿ��� 
int pnum = UtilMgr.parseInt(request, "pnum");


ProductBean pbean = pdMgr.getProduct(pnum);

int price1 = pbean.getPrice1();
String image = pbean.getImage();
String detail = pbean.getDetail();
String mClass = pbean.getMclass();
String cClass = pbean.getSclass();
String pname = pbean.getPname();
%>
<% // ����¡ ó���� �ʿ��� ���� ����
int totalRecord = 0; // �� �Խù� �� (���� 0��)
int numPerPage = 10; // �� �������� �ҷ��� ���ڵ� ���� (����Ʈ 10��)
int pagePerBlock = 15; // �� ���� �� 15�� ������ �ҷ�����
int totalPage = 0; // �� ������ ���� (���� 0��)
int totalBlock = 0; // �� �� ����
int nowPage = 1; // ���� ������ (���� 1������)
int nowBlock = 1; // ���� �� (���� 1������ -> 1���� ��ġ)

if (request.getParameter("numPerPage") != null) { // x�������� �ɼ� �ٲٸ� ���ȣ��Ǹ鼭 �ٽ� numPerPage ����
	numPerPage = UtilMgr.parseInt(request, "numPerPage"); // ���޹��� numPerPage ���� int����ȯ
}

// �˻� �� and ������ �̵� �� ���ȣ��ǹǷ� �����Ǿ�����
String keyField = "", keyWord = ""; // �˻� �� ����Ʈ
if (request.getParameter("keyWord") != null) { // �˻��ߴٸ�
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

// �˻� �� 'ó������' ��ư �����߸� reload���� ���޵Ǹ鼭 �˻� �ʱ�ȭ�� ���·� ���ȣ��
if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
	keyField = "";
	keyWord = "";
}

// ���� ��ü ���� �� 
totalRecord = rMgr.getTotalCountByPnum(keyField, keyWord, pnum); // �˻��� ���� keyField, keyWord �� �����Ǿ� �ְ�, �ƴ� ���� "" �� ����

// ������ Ŭ��(list()�Լ�) OR �Խñ� �а� '����Ʈ��' Ŭ�� -> GET������� ��ġ���ִ� nowPage ����
if (request.getParameter("nowPage") != null) {
	nowPage = UtilMgr.parseInt(request, "nowPage");
}

// sql�� LIMIT�� ���� ���� ���� 
int start = (nowPage * numPerPage) - numPerPage; // 1�������϶� 0, 2�������϶� 10, 3�������϶� 20, ...
int cnt = numPerPage; // ����Ʈ 10�� (�� �������� �������� ���ڵ� ����)

// ��ü ������ ����
totalPage = (int) Math.ceil((double) totalRecord / numPerPage); // Ex. �Խù� 663�� -> ���ڵ尳��/10(66������) + 1(�ø� : �������������� 10���� ���� �� ������ �Խñ� ��(3��) ���� �ϹǷ�)

// ��ü �� ����
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // Ex. �� 67������ / �� ���� 15������ = 4.47 -> +1 (�ø�) �ؼ� 5��

// ���� ���° ������ 
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); // Ex. ���� 1������ / �� ���� 15������

%>

<!doctype html>
<html>
<head>
<style>
img {
	display: block;
	margin: auto;
}

table, tr, td {
	border: none;
}

td, th {
	vertical-align: middle;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
}

.shop_info {
	display: flex;
	width: 1080px;
	height: 300px;
	margin: 10px auto 100px;
	border: 1px solid #000;
	border-radius: 20px;
	padding: 10px;
	align-items: center;
	justify-content: space-between;
}

.img_area {
	width: 200px;
	height: 200px;
	margin-left: 150px;
	overflow: hidden;
}

.img_area img {
	width: 100%;
}

.info_list {
	width: 200px;
	margin-lefT: 50px;
}

.info_list>div dt {
	display: block;
	width: 100px;
}

.info_list>div {
	display: flex;
	margin-bottom: 0px;
}

.info_list>div:nth-child(3) {
	margin-bottom: 25px;
}

.info_list>div dt {
	font-weight: 700;
	color: #888;
}

.info_list>div dd {
	font-weight: 700;
	color: #000;
}

.info_list input {
	vertical-align: top;
	text-align: center;
	border: 1px solid #777;
	border-right: none;
	width: 50px;
	height: 30px;
	background: transparent;
	font-size: 16px;
	font-weight: bold;
	box-sizing: border-box;
	color: #111;
	line-height: 25px;
	padding: 11px 0 9px 0;
	border-radius: 0;;
}

input {
	outline: none;;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.info_list .num_ {
	width: 15px;
	height: 30px;
	background-color: #eee;;
}

.info_list .num_ .btn_ {
	position: relative;
	width: 15px;
	height: 15px;
	display: block;
	border: 1px solid #777;
}

.info_list .num_ .btn_:after {
	position: absolute;
	width: 5px;
	height: 5px;
	border-top: 2px solid #000;
	content: "";
	display: block;
	border-right: 2px solid #000;
}

.info_list .count dd {
	display: flex;
}

.up:after {
	transform: rotate(-45deg);
	top: 4.5px;
	left: 4px;
}

.down:after {
	transform: rotate(135deg);
	top: 1.5px;
	left: 4px;
}

.btn_wrap {
	display: flex;
	margin-top: 100px;
	margin-right: 100px;
}

.btn_wrap .side_btn {
	width: 120px;
	height: 40px;
	background-color: #9598ca;
	display: block;
	text-align: center;
	margin-right: 10px;
	line-height: 40px;
	color: #fff;
	border-radius: 5px;
}

.detail {
	width: 1080px;
	height: 100px;
	margin: auto;
	overflow: hidden;
	position: relative;
	margin-bottom: 100px;
}

.show_btn {
	width: 100%;;
	height: 50px;
	background-color: #9598ca;
	line-height: 50px;
	text-align: center;
	margin: auto;
	cursor: pointer;
	position: absolute;
	bottom: 0;;
	font-size: 20px;
	font-weight: 700;
	color: #fff;
	display: none;
}

.detail>span {
	position: absolute;
	top: 0;
	left: 10px;
	font-weight: 700;
	font-size: 12px;
}

.detail.on {
	height: auto
}

.show_btn.show {
	display: block;
}

.review {
	width: 1080px;
	border-top: 1px solid #000;
	height: auto;
	margin: auto;
	overflow: hidden;
	position: relative;
	padding: 10px;
}

.review>span {
	position: absolute;
	top: 0;
	left: 10px;
	font-weight: 700;
	font-size: 12px;
}

.review .review_cate {
	text-align: right;
}

.review .review_cate a {
	color: #888
}

.review .review_cate span {
	margin: 0 5px;
}

.review_wrap {
	margin-top: 20px;
}

.review_wrap table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse
}

.review_wrap table tr {
	height: 40px;
	line-height: 40px;
}

.review_wrap table th {
	background-color: #eee;
	text-align: center;
}

.review_wrap table td {
	text-align: center;
	padding: 5px;
	border-bottom: 1px solid #aaa;
}

.review_wrap table td:nth-child(2) {
	text-align: left;
}

.review_wrap table td a {
	color: #000;;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.review_wrap table tr.re td a {
	margin-left: 10px;
}

.review_wrap table tr.re td a:before {
	content: "RE";
	color: #fff;
	background-color: #aaa;
	font-weight: 700;
	padding: 0 4px
}

.review_wrap table th {
	border-bottom: 1px solid #aaa;
}

.review_wrap table tbody tr:first-child, .review_wrap table tbody tr:first-child td
	{
	border-top: none;
}
</style>
<!-- ���� CSS -->
<link rel="stylesheet" href="../css/styleHB.css">

<script>
// ����¡ ó��
function pageing(page) {
	document.readFrm.nowPage.value /*value ����������*/= page; // �Ű������� ���� page�� nowPage�� ������ ��û
	document.readFrm.submit();
}

// �� �̵�
function block(block) {
	document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1;
	// block=1 -> nowPage=0, block=2 -> nowPage=16, ...
	document.readFrm.submit();
}

// �� �������� �Խñ� ����
function numPerFn(numPerPage) {
	document.readFrm.numPerPage.value = numPerPage;
	document.readFrm.submit(); // ���ȣ�� �� ����� numPerPage ����
}

// (ó������ ��ư �����߸� ����Ǵ� �޼ҵ�) ��� �̵�
function list() {
	document.listFrm.action = "productDetail.jsp";
	document.listFrm.submit(); // reload�� nowPage VALUE�� POST������� �����Ͽ� ���ȣ��
}

// �˻�
function check() {
	if (document.searchFrm.keyWord.value == "") {
		alert("�˻�� �Է��ϼ���.");
		document.searchFrm.keyWord.focus();
		return;
	}
	document.searchFrm.submit();
}

// �Խñ� �б�
function read(i) {
	// document.readFrm.rnum.value = rnum;
	// document.readFrm.action = "reviewRead.jsp"; // JS���� action ���� ����
	// document.readFrm.submit(); // �� ����
	
	/*�׽�Ʈ : ��۽����� �����غ���*/
	if(document.getElementsByClassName('reviewDetail')[i].style.display = 'hidden'){
		document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block ��� table-row�ؾ� colspan ����
	}
}
</script>
<!-- ���� JS -->
<script src="../scriptHB.js"></script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
</head>
<body>
	<div sp-edit="text" style="padding: 1rem 0; text-align: center;"
		class="initialize" area="before"></div>
	<table width="75%" align="center">
		<form method="post" name="frmC" action="../cartInsertProc.jsp">
		<tr>
			<td align="center">
				<table width="95%" border="1">
					<tr>
						<td colspan="2" align="center"><font color="#FFFFFF"></font></td>
					</tr>
				</table>

				<div sp-edit="text" style="padding: 1rem 0; text-align: center;"
					class="initialize" area="before">
					<span sp-font="13" style="color: #333; margin-bottom: 20px;"><b>��ǰ
							�� ������&nbsp;</b></span></br>
				</div>

				<div class="shop_info">
					<div class="img_area">
						<img src="../image/<%=image%>" alt="#">
					</div>
				
						<dl class="info_list">

							<div class="category">
								<dt>ī�װ�</dt>
								<dd><%=mClass%>
									>
									<%=cClass%></dd>
							</div>
							<div class="name">
								<dt>�̸�</dt>
								<dd><%=pname%></dd>
							</div>
							<div class="price">
								<dt>����</dt>
								<dd class="cost"><%=price1%></dd>
								��
							</div>
							<div class="count">
								<dt>����</dt>
								<dd>
									<input onkeyup="costCount()" type="number" value="1"
										autocomplete="off" min="0" name="qty">
									<div class="num_">
										<div class="btn_ up"></div>
										<div class="btn_ down"></div>
									</div>
								</dd>
							</div>

							<div>
								<dt>�� ����</dt>
								<dd class="last_cost">
									<span></span>��
								</dd>
							</div>

						</dl>

						<div class="btn_wrap">
							<form name="cartFrm">
								<input type="button" class="side_btn" value="��ٱ���"
									onclick="javascript:cartInsert(this.form)"> <input
									type="button" class="side_btn" value="�����ϱ�"
									onclick="javascript:directOrder(this.form)"> <input
									type="hidden" name="flag" value="insert"> <input
									type="hidden" name="id" value="<%=id%>"> <input
									type="hidden" name="pnum" value="<%=pnum%>"> <input
									type="hidden" name="pname" value="<%=pname%>"> <input
									type="hidden" name="price1" value="<%=price1%>">
							</form>
						</div>
				</div>
				<div class="detail">
					<span>��ǰ �� �̹���</span> <img src="../image/<%=detail%>" alt="">
					<div class="show_btn show">������</div>
				</div>
				
				
				
				
				
				
				<!-- ���������� Start -->
				<div class="review">
					<div class="review_wrap">
<%-- 						<table>
							<thead>
							<colgroup>
								<col width="5%">
								<col width="72.5%">
								<col width="10%">
								<col width="12.5%">
							</colgroup>
							<tr>
								<th>��ȣ</th>
								<th>�����ı�</th>
								<th>�ۼ���</th>
								<th>�ۼ���</th>
							</tr>
							</thead>
							<tbody>

								<%
								/*  ��ǰ�� ���õ� ���� �����͵��� ��� �ҷ��´�. */
								Vector<ReviewBean> reviewList = pdMgr.getReviewListByPnum(pnum);

								/* ���� �����Ͱ� �����Ѵٸ� */
								if (!reviewList.isEmpty()) {
									for (int i = 0; i < reviewList.size(); i++) {

										/* ���� Bean�� ���� ��Ƽ� ȭ�鿡 �ѷ��ش� */
										ReviewBean bean = reviewList.get(i);

										int rnum = bean.getRnum();
										String rid = bean.getRid();
										String date = bean.getDate();
										String subject = bean.getSubject();
								%>
								<tr>
									<td><%=rnum%></td>
									<td><%=subject%></td>
									<td><%=rid%></td>
									<td><%=date%></td>
								</tr>

								<%
								}
								}
								%>
							</tbody>
						</table> --%> <!-- ��ȭ�԰� -->
						
						<!-- ����� -->
							<div align="center" id="review-board">
		<br />
		<h2 class="review-board-topic">����</h2> <!-- pnum�� ������ �ϰ�, ������ ��ǰ�󼼿��� pnum�޾ƿ� -->
		<label>�ش� ��ǰ�� �� <b><%=totalRecord%></b>���� ���䰡 �ֽ��ϴ�!</label>
		<br/>
		<table>
			<tr>
				<td>
					<!-- action �����̹Ƿ� ���ȣ�� -->
					<form name="npFrm" method="post">
						<!-- select�±��� size�Ӽ� : �ѹ��� ���� �ɼ��� ����, onchange() : ������ �ٲ� ������ -->
						<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)" class="npFrm-td form-select form-select-numPerPage">
							<!-- 5,10,15,20 �� �ϳ� -->
							<option value="5">5���� ����</option>
							<option value="10" selected>10���� ����</option>
							<option value="15">15���� ����</option>
							<option value="30">30���� ����</option>
						</select>
					</form> 
					<script>
						<!-- if) '20�� ����' ���� ��, �Խñ� �а� ����Ʈ�� ���ƿ͵� ���� numPerPage ������ ���·� list.jsp ȣ���ϱ� ����-->
						document.npFrm.numPerPage.value = <%=numPerPage%>;
					</script>
				</td>
				<td width="600" align="right" class="npFrm-td">
					���������� : <%=nowPage%> / ��ü ������ : <%=totalPage%>
				</td>
			</tr>
		</table>
		<!-- �Խù� ����Ʈ Start -->
		<table>
			<tr>
				<td align="center" colspan="2">
					<%
					// pnum�� �´� ���丸 ��������
					Vector<ReviewBean> vlist = rMgr.getReviewListByPnum(keyField, keyWord, start, cnt, pnum);
					int listSize = vlist.size(); // �� �������� ��� �� ���ڵ尹�� (�ִ� 10��, ������ �������� 10 ������ ���� ���� ���� ����)
					if (vlist.isEmpty()) {
						out.println("��ϵ� �Խù��� �����ϴ�.");
					} else {
					%>
					<table class="table table-hover">
						<tr align="center" class="table-column">
							<th width="100">�� ȣ</th>
							<th width="50">�� ��</th>
							<th width="100">�� ��</th>
							<th width="20">&nbsp;</th>
							<th width="100">���̵�</th>
							<th width="100">�� ¥</th>
							<th width="100">&nbsp;</th>
						</tr>
						<%
						/* for�� if���� ������ i==listSize�� listSize�� LIMIT �Լ��� �Խñ��� �ҷ��ͼ� ���� Vector�� ũ���̸�,
						(������������ ����) �� �������� listSize=10�̹Ƿ� ���� if�� ���ǿ� ������ ���� �� ������(i�� �ִ� 9��),
						�������������� 10�̸��� ���ڵ尳���� ���� �� �����Ƿ�, �׸�ŭ�� �ݺ��� ������ ���������ٴ� �ǹ� */
						for (int i = 0; i < numPerPage; /*10��*/ i++) {
							if (i == listSize)
								break;

							// vlist���� ���������� �����ͼ� bean ��ü ���� �� ��´�.
							ReviewBean bean = vlist.get(i);

							// bean���� �� get
							int rnum = bean.getRnum();
							int onum = bean.getOnum();
							String rid = bean.getRid();
							pnum = bean.getPnum();
							String date = bean.getDate();
							String subject = bean.getSubject();
							String content = bean.getContent();
							double score = bean.getScore();
							String filename = bean.getFilename(); // ���� ���ε� �� ��� ���� �� ������ �߰�
							int filesize = bean.getFilesize();

							// ���� ��� �� count
							int rCount = cMgr.getRCommentCount(rnum);
						%>
						<!-- �� ��(����)�� �´� �� �ݺ������� ���� -->
						<tr align="center">
							<td><a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=totalRecord - start - i%></a></td><!-- ������� : ���� �ֽű��� ���� ���� ���� -->
							<td><a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=score%></a></td>
							<td align="left">
								<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=subject%></a> <!-- �������� --> 
							</td>
							<td>								<%if (filename != null) {%>
									<img src="../img/file_icon1.png" width="15px" height="15px" align="middle"> <!-- ���������� �̸�Ƽ�� ���� -->
								<%}%>
								<%if (rCount > 0) {%> <!-- ����ִٸ� --> 
									<font color="red">(<%=rCount%>)</font> <!-- ���������� (��ۼ�) ���� --> 
									<%}%></td>
							<td><%=rid%></td><!-- �����ۼ��� -->
							<td><%=date%></td><!-- �����ۼ���¥ -->
							
							<td>
								<%if(id.equals(rid) || id==rid || id=="admin" || id.equals("admin")){
									if(id.equals(rid) || id==rid){%>
									<form name="deleteReviewFrm" action="../reviewDeleteProc.jsp" method="post">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="filename" value="<%=filename%>">
										<input type="hidden" name="pnum" value="<%=pnum%>">
										<input type="hidden" name="keyField" value="<%=keyField%>">
										<input type="hidden" name="keyWord" value="<%=keyWord%>">
										<input type="hidden" name="nowPage" value="<%=nowPage%>">
										<input type="submit" class="btn btn-primary submitBtn" value="����">
									</form>	
									<%} else if(id=="admin" || id.equals("admin")){%>
									<form name="deleteReviewFrm" action="../reviewDeleteProc.jsp" method="post">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="pnum" value="<%=pnum%>">
										<input type="hidden" name="filename" value="<%=filename%>">
										<input type="hidden" name="keyField" value="<%=keyField%>">
										<input type="hidden" name="keyWord" value="<%=keyWord%>">
										<input type="hidden" name="nowPage" value="<%=nowPage%>">
										<input type="submit" class="btn btn-primary submitBtn" value="����">
									</form>
								<%}%>
							<%} %>
							</td>
						</tr>
						
						
						<!-- ���䴩���� ������ �̵����� �Ʒ��� �ߵ��� -->
					
						<tr style="display:none;" class="reviewDetail">
							<td colspan="7" width="500" align="center" style="margin:0 auto;">
								<br><h3>[����]</h3><br>
								<form name="reviewDetailFrm" action="../reviewUpdate.jsp?rnum=<%=rnum%>" method="POST" class="reviewDetailFrm" style="text-align:left;">
									<input type="hidden" name="rnum" value="<%=rnum%>">
									<input type="hidden" name="onum" value="<%=onum%>">
									<input type="hidden" name="rid" value="<%=rid%>">
									<input type="hidden" name="pnum" value="<%=pnum%>">
									<input type="hidden" name="date" value="<%=date%>">
									<input type="hidden" name="subject" value="<%=subject%>">
									<input type="hidden" name="content" value="<%=content%>">
									<input type="hidden" name="score" value="<%=score%>">
									
									<br>�ۼ��� ID : <%=rid%><br>
									�ۼ���¥ : <%=date%><br>
									���� : <%=subject%><br>
									���� : <%=content%><br>
									���� : <%=score%><br><br><br>
									<%if(filename!=null){ %>
										<img src="../storage/<%=filename%>" width="800vw" height="400vw" style="display:block; margin: 0 auto; object-fit: cover;"><br>
										<input type="hidden" name="filename" value="<%=filename%>">
									<%} %>
									<%if(id.equals(rid) || id==rid) { /*���θ����� ������ư Ȱ��ȭ*/%>
										<input type="submit" class="btn btn-primary submitBtn" value="����"><br>
									<%}%>
									<hr>
								</form>
								<h3>[���]</h3><br>
									<%
									Vector<RCommentBean> cvlist = cMgr.listRComment(rnum);
									for(int j=0; j<cvlist.size(); j++){
										rcBean = cvlist.get(j);
										
										int rcNum = rcBean.getRcNum();
										String cid = rcBean.getCid();
										String rcDate = rcBean.getRcDate();
										String comment = rcBean.getComment();
										
										if(!cvlist.isEmpty()) {
									%>
										<form name="commentListFrm" action="../admin/commentDeleteProc.jsp" method="POST" style="text-align:left;">
											<br>���� : <%=j+1%><br>
											�ۼ��� ID : <%=cid %><br>
											�ۼ���¥ : <%=rcDate %><br>
											��۳��� : <%=comment%><br>
											<%if(id=="admin" || id.equals("admin")){%> <!-- �����ڸ� ��� ��� ���� ���� -->
											<input type="hidden" name="rcNum" value="<%=rcNum%>">
											<input type="submit" class="btn btn-primary submitBtn" value="����"><br>
											<%}%>
										</form>
									<%} %>
								<%} %>
									
							<%if(id.equals("admin")||id=="admin") {%>
								<form name="commentFrm" action="../admin/CommentInsertProc.jsp" method="post">
									<input type="hidden" name="rnum" value="<%=rnum%>">
									<input type="hidden" name="cid" value="<%=id%>">
									<input type="hidden" name="pnum" value="<%=pnum%>">
									<input type="text" name="comment">
									<input type="submit" class="btn btn-primary submitBtn" value="�ۼ�"><br>
								</form>
							<%}%>
							</td>
						</tr>
						<%} // --- for��%>
					</table> 
					<%} // ---if-else��%>
				</td>
			</tr>
			<tr>
				<td align="center" style="font-size:1em;">
					<!-- ����¡ �� �� Start --> 
					<!-- ������ �̵�(ù�������� ����� ��)--> 
					<%if (nowBlock > 1) {%>
						<a href="javascript:block('<%=nowBlock - 1/*������*/%>')" class="review-board-aTag">&nbsp;�� ��&nbsp;</a> 
					<%}%> <!-- ����¡(Ư����) --> 
					<%// �Ʒ������� for�� ������ ���� 1~16 -> 1~15���� �ݺ�
					int pageStart = (nowBlock - 1) * pagePerBlock + 1; /*����1, 16, 31, ...*/
					/*������ ���� 15�������� �ȵ� �� �����Ƿ� ���׿����� ���*/
					int pageEnd = (pageStart + pagePerBlock /*15*/) < totalPage ? pageStart + pagePerBlock : totalPage + 1; 

 					// �ݺ��� (15���� �ݺ�, ������ �������� 91~101������������ �ݺ���)
 					for (; pageStart < pageEnd; pageStart++) { // ����� ���� �ʱ����? pageStart = 1;���� ����%> 
 						<a href="javascript:pageing('<%=pageStart%>')" class="review-board-aTag"> 
 							<%if (pageStart == nowPage) {%>
 							<font color="#A13FFF"><%}%> [<%=pageStart%>] 
								<%if (pageStart == nowPage) {%>
									</font>
								<%}%> <!-- if�� �ΰ��� ����: ���ǿ� �¾ƾ߸� font �ڵ� ����ǵ���-->
						</a> 
					<%} // --- for%> 
				<!-- ������ �̵� ��� (���������� ���� ���)--> 
				<%if (totalBlock > nowBlock) {%>
					<a href="javascript:block('<%=nowBlock + 1%>')" class="review-board-aTag">&nbsp;�� ��&nbsp;</a> 
				<%}%> 
				<!-- ����¡ �� �� End -->
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div style="text-align:center; margin: 2vw;">
						<form name="searchFrm" class="searchFrm">
							<select name="keyField" size="1" class="form-select" style="display:inline">
								<option value="rid">�ۼ��� ID</option>
								<option value="subject">�� ��</option>
								<option value="content">�� ��</option>
							</select> <!-- ����Ʈ text type --> 
							<input name="keyWord" size="16" class="form-control" style="display:inline"> 
							<input type="hidden" name="nowPage" value="1"> <!-- �˻� �� �ʱ�ȭ : ���� �˻� ����� 1���������� �������Ƿ�-->
							<input type="hidden" name="pnum" value="<%=pnum%>">
							<input type="button" value="�˻�" onclick="check()" class="btn btn-primary reviewSearchBtn">
						</form>
					</div>
				</td>
			</tr>
			<tr>
				<!-- 'ó������' ��ư ������ �� list()�Լ� ȣ�� -> listFrm submut -> reload = true ���� -> keyField, keyWord �ʱ�ȭ�� -->
				<td style="text-align:right">
					<a href="javascript:list()" class="review-board-aTag"><button type="button" class="btn btn-primary" style="margin-bottom:1.5vh;">ó������</button></a> 
				</td>
			</tr>
		</table>
		<!-- �Խù� ����Ʈ End -->
		
		

		<!-- ó������ ��ư ������ list() �޼ҵ带 ���� post������� ���� (�ʱ�ȭ)-->
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
			<input type="hidden" name="pnum" value="<%=pnum%>">
		</form>

		<!-- �Ʒ� ������ GET������� �����ϸ�, 10�� 15�� �� ������ �ٲܶ����� ���ȣ�� -->
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
			<input type="hidden" name="rnum">
			<input type="hidden" name="pnum" value="<%=pnum%>">
		</form>
	</div>	
					</div>
					<!-- ���������� End -->		
					<input type="button" value="<BACK" onClick="history.go(-1)">
					<!-- ������������ ���ư��� -->
				</div>
			</td>
		</tr>
	</table>
	<script>
    window.onload = function () {
        costCount()

        const infoList = document.querySelector('.info_list');
        const btnU = document.querySelector('.up');
        const btnD = document.querySelector('.down');
        const btnS = document.querySelector('.show');
        const det = document.querySelector('.detail');
    	const basket = document.querySelector('#basket');
        const buyBtn = document.querySelector('#buyBtn');

        console.log(btnS.length)

        btnS.addEventListener('click', function(){
            if(det.classList.contains('on')){
                det.classList.remove('on');
                btnS.innerText = '������';
            }
            else{
                det.classList.add('on');
                btnS.innerText = '����';
            }
        })

        btnU.addEventListener('click', function () {
            infoList.querySelector('input').value++;
            costCount();
        })
        btnD.addEventListener('click', function () {
            if(infoList.querySelector('input').value > 0){
                infoList.querySelector('input').value--;
                costCount();
            }
            
        })

    }
        
    function costCount() {
        const infoList = document.querySelector('.info_list');
        const infoItem = infoList.querySelector('.cost');
        const infoCost = infoList.querySelector('.last_cost');
        
        var cost = infoItem.innerText // ��ǰ ����
        var count = infoList.querySelector('input').value; // ��ǰ ����
        infoCost.querySelector('span').innerText = count * cost;
    }


     //cart
     function cartDelete(form){
    		form.flag.value="delete";
    		form.submit();
    }

     function cartOrder(form){
    		form.flag.value="order";
    		form.submit();
    }
     
     function cartInsert(form){ // ��ٱ��� ��ư Ŭ��
    	const id = '<%=id%>';
    	if(<%=session.getAttribute("idKey")==null%>){ 
    		alert("�α��� �� �̿����ּ���.");
    		location.href="../login.jsp";
    	} else {
    		form.flag.value="insert";
    		form.submit();
    		location.href("../cartInsertProc.jsp"); // cartInsertProc.jsp -> OrderMgr
    	}
     }
     
    function directOrder(form){ // �ֹ��ϱ� ��ư Ŭ��
    	const id = '<%=id%>';
    	if(<%=session.getAttribute("idKey")==null%>){ 
    		alert("�α��� �� �̿����ּ���.");
    		location.href="../login.jsp";
    	} else {
    		form.flag.value = "direct";
    		form.submit();
    		location.href("../cartInsertProc.jsp");// cartInsertProc.jsp -> OrderMgr
    	}
    }
	</script>

</body>
</html>