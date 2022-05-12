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
	// pnum �� �޾ƿ��� 
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	
	
	// id�� �޾ƿ���
	String id = request.getParameter("id"); // product.jsp���� �޾ƿ���
	if(session.getAttribute("idKey")!=null){ // id���� �������� ����Ǿ� �ִٸ�
		id = (String) session.getAttribute("idKey");
	} 
	
	// �� �޾ƿԴ��� Ȯ��
	System.out.println("pnum:"+pnum+"   id:"+id);
	
	
	// �׽�Ʈ�� ���Ǽ��� 
	//int pnum = 2;
	//id = "aaa";
	
	
	ProductBean pbean = pdMgr.getProduct(pnum);


	int price1 = pbean.getPrice1();
	String image = pbean.getImage();
	String detail = pbean.getDetail();
	String mClass = pbean.getMclass();
	String cClass = pbean.getSclass();
	String pName = pbean.getPname();

%>

<!doctype html>
<html>
<head>
<script src="pscript.js"></script>
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
</style>
<style>
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
<script>
        window.onload = function () {
    costCount()

    const infoList = document.querySelector('.info_list')
    const btnU = document.querySelector('.up')
    const btnD = document.querySelector('.down')
    const btnS = document.querySelector('.show')
    const det = document.querySelector('.detail')



    console.log(btnS.length)

    btnS.addEventListener('click', function(){
        if(det.classList.contains('on')){
            det.classList.remove('on')
            btnS.innerText = '������'
        }
        else{
            det.classList.add('on')
            btnS.innerText = '����'
        }
    })

    btnU.addEventListener('click', function () {
        infoList.querySelector('input').value++
        costCount()
    })
    btnD.addEventListener('click', function () {
        if(infoList.querySelector('input').value > 0){
            infoList.querySelector('input').value--
            costCount()
        }
        
    })

}
function costCount() {
    const infoList = document.querySelector('.info_list')
    const infoItem = infoList.querySelector('.cost')
    const infoCost = infoList.querySelector('.last_cost')
    
    var cost = infoItem.innerText // ��ǰ ����
    var count = infoList.querySelector('input').value // ��ǰ ����
    infoCost.querySelector('span').innerText = count * cost

    
}
    </script>
</head>
<jsp:include page = "../top2.jsp"/>

<div sp-edit="text" style="padding: 1rem 0; text-align: center;"
	class="initialize" area="before">
	
</div>
<table width="75%" align="center">
	<tr>
		<td align="center">
			<table width="95%" border="1">
				<tr>
					<td colspan="2" align="center"><font color="#FFFFFF"></font></td>
				</tr>
			</table>

			<div sp-edit="text" style="padding: 1rem 0; text-align: center;"
				class="initialize" area="before">
				<span sp-font="13" style="color: #333; margin-bottom : 20px;"><b>��ǰ �� ������&nbsp;</b></span></br>
			</div>

			<div class="shop_info">
				<div class="img_area">
					<img src="<%=image%>" alt="#">
				</div>

				<dl class="info_list">
				
					<div class="category">
						<dt>ī�װ� </dt>
						<dd><%=mClass%> > <%=cClass%></dd>
					</div>
					<div class="name">
						<dt>�̸�</dt>
						<dd><%=pName%></dd>
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
								autocomplete="off" min="0">
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
					<a href="#" class="side_btn">�ٷα���</a> <a href="#" class="side_btn">��ٱ���</a>
				</div>
			</div>
			<div class="detail">
				<span>��ǰ �� �̹���</span> <img
					src="<%=detail%>" alt="">
				<div class="show_btn show">������</div>
			</div>
			<div class="review">
				<span>��ǰ ����</span>
				<div class="review_wrap">
					<table>
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
							if(! reviewList.isEmpty()){
								for(int i=0; i < reviewList.size(); i++){
								
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
					</table>
				</div>
				<%@ include file="../bottom.jsp"%>
				</main>
				</html>