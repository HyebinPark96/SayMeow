<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="aoMgr" class="saymeow.AdminOrderMgr"/>
<%
	request.setCharacterEncoding("EUC-KR"); // get��� �ѱ�ó��
	
	/* ����¡ ó���� �ʿ��� ���� ���� [����Ʈ�� �����ص�] */
	int totalRecord = 0; // �� �Խñ� ��
	int pagePerBlock = 15; // �� ���� ������ ��
	int numPerPage = 10; // �� �������� �Խñ� ��
	
	int nowPage = 1; // ���������� 
	int nowBlock = 1; // ����� 
	
	int totalPage = 0; // ��ü ������ ��
	int totalBlock = 1; // ��ü �� ��
	
	
	if(request.getParameter("numPerPage")!=null){
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	
	// ����Ʈ �˻� ����
	String keyField = "";
	String keyWord = "";
	
	// �˻��ߴٸ� 
	if(request.getParameter("keyWord")!=null) { // �׳� keyword !=null ���� ���� ����
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	// (���ñ�������) ���ϴ� �Ⱓ�� ����
	String interval = "";
	if(request.getParameter("interval")!=null){
		interval = request.getParameter("interval");
	}
	
	totalRecord = aoMgr.getCountRecord(keyField, keyWord);
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	// ���� �ֽű��� ù�������� ���̵��� Mgr�� ORDER BY onum DESC ���� -> ù �������� start�� �ݴ�� ���� ���� ���� �Ǿ�� onum ���� ������ �ҷ����� ������
	int start = (nowPage * numPerPage) - numPerPage; // 1�������϶� 0, 2�������϶� 10, 3�������϶� 20, ...
	int cnt = numPerPage;
	
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage); // �ø�
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); // �ø�
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock); // �ø�
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- ���� CSS -->
<link rel="stylesheet" href="../css/styleHB.css">
<!-- ���ν�ũ��Ʈ -->
<script>
	function search(){ // �˻����
		if (document.searchOrderFrm.keyWord.value == "") {
			alert("�˻�� �Է��ϼ���.");
			document.searchOrderFrm.keyWord.focus();
			return;
		}
		document.searchOrderFrm.submit();
	}
	
	function reset(){
		keyField = ""; // �ʱ�ȭ
		keyWord = ""; // �ʱ�ȭ
		document.resetOrderFrm.submit(); // ���ȣ��
	}
	
	
	function moveDate(interval){
		document.orderDateSearchFrm.interval.value = interval; // �Ű������� ���� ���� �Ⱓ ������ �����Ѵ�.
		document.orderDateSearchFrm.submit(); // ���ȣ��
	}
	
	function pageing(page){ // �������̵����
		document.readFrm.nowPage.value = page; // ������ a�±��� value���� nowPage�� ��
		document.readFrm.submit(); // ���ȣ��
	}
	
	function block(block){ // ����OR���� ���̵���� (1->16������->31������)
		document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1; // ���� OR ���� a�±��� ��(+1 OR -1)���� nowBlock�� ��
		document.readFrm.submit(); // ���ȣ��
	}
	
	
	function allCheck(){ // ��ü���ñ��
		if(document.getElementsByClassName('allCheckChb')[0].checked == true){
			for(var i=0;i<<%=numPerPage%>;i++) {
				document.getElementsByName("chb")[i].checked=true; //name �� ����Ͽ� �迭 ���·� ��� ȣ��
			}
		}
		if(document.getElementsByClassName('allCheckChb')[0].checked == false){
			for(var i=0;i<<%=numPerPage%>;i++){
				document.getElementsByName("chb")[i].checked=false; //name �� ����Ͽ� �迭 ���·� ��� ȣ��
			}
		}
	}
	
	// üũ�ڽ� ���ڵ� ������� 
	function deleteCheckedBox(){
		var checkedBox = new Array();
		for(var i=0;i<<%=numPerPage%>;i++){
			if(document.getElementsByName("chb")[i].checked){
				console.log("checkedBox �迭�� " + i + "��° �ε��� : " + checkedBox[i]);
				document.deleteFrm.onum.value += (document.getElementsByName("chb")[i].value+";");
			}
		}
		console.log(document.deleteFrm.onum.value);
		document.deleteFrm.action = "adminDeleteOrderProc.jsp";
		document.deleteFrm.submit();
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
<body id="adminOrder">
<!-- ���̵�� 40%, â 60% -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="adminOrder.jsp"><button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
		<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
		<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
		<a href="../sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
		<a href="#"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" style="margin:0 auto;">
		<h2 style="text-align: center; margin: 1.5vw; margin-bottom: 2vw;">�ֹ�����</h2>
		<table class="orderTable">
			<tr>
				<td align="center" colspan="2">
					<table class="table table-hover" >
						<tr class="table-column">
							<th width="100">����</th>
							<th width="100">�ֹ��� ID</th>
							<th width="100">��ǰ��ȣ</th>
							<th width="100">��ǰ��</th>
							<th width="100">�ֹ�����</th>
							<th width="100">���簡��</th>
							<th width="100">�Ѱ���</th>
							<th width="150">�ֹ���¥</th>
							<th width="100">�����</th>
							<th width="100">�ֹ�����</th>
							<th width="130"><input type="checkbox" class="allCheckChb" onclick="allCheck()">&nbsp;[��ü����]</th>
						</tr>
						<%
						Vector<OrderBean> vlist = aoMgr.getOrderList(keyField, keyWord, start, cnt, interval);
						if(vlist.size()==0){%>
							<tr>
								<td colspan="8" width="300" align="center">
									<br>
									<%out.println("�ֹ������� �����ϴ�."); %>
								</td>
							</tr>
							<tr>
								<td><br></td>
							</tr>
						<%} else {
							for(int i=0; i<vlist.size(); i++){
								OrderBean bean = vlist.get(i);
								int onum = bean.getOnum();
								int pnum = bean.getPnum();
								int qty = bean.getQty();
								int price1 = bean.getPrice1();
								String pname = bean.getPname();
								String oid = bean.getOid();
								String regdate = bean.getRegdate();
								String oaddress = bean.getOaddress();
								String state = bean.getState();
							%>
						<tr align="left">
							<td><%=onum%></td>
							<td><%=oid%></td>
							<td><%=pnum%></td>
							<td><%=pname%></td>
							<td><%=qty%></td>
							<td><%=price1%></td>
							<td><%=qty*price1%></td>
							<td><%=regdate%></td>
							<td><%=oaddress%></td>
							<td>
							<%if(state.equals("1")){%>
								���� ��
							<%} else if(state.equals("2")){%>
								�����Ϸ�(��ۿϷ�)
							<%} else if(state.equals("3")){%>
								�ֹ����
							<%} %>
							</td>
							<td><input type="checkbox" class="chb" name="chb" value="<%=onum%>"></td>
						</tr>
						<%} // -- �ݺ��� ��%>
					<%} // -- if-else�� ��%>
					</table>			
				</td>
			</tr>
			<tr>
				<td>
					<form name="orderDateSearchFrm">
						<a href="javascript:moveDate('12')"><input type="button" value="1���̳�" class="btn btn-primary dateSearchBtn"></a>
						<a href="javascript:moveDate('6')"><input type="button" value="6�����̳�" class="btn btn-primary dateSearchBtn"></a>
						<a href="javascript:moveDate('3')"><input type="button" value="3�����̳�" class="btn btn-primary dateSearchBtn"></a>
						<a href="javascript:moveDate('1')"><input type="button" value="1�����̳�" class="btn btn-primary dateSearchBtn"></a>
						<a href="javascript:moveDate('all')"><input type="button" value="��ü" class="btn btn-primary dateSearchBtn"></a>
						<input type="hidden" name="interval" value="">
					</form>
				</td>
			</tr>
			<tr>
				<td align="center" class="page" style="font-size:1em;">
					<%if(nowBlock > 1) {%>
						<a href="javascript:block('<%=nowBlock-1%>')">&nbsp;�� ��&nbsp;</a>
					<%}%>
					<%
					// �� ���� ù�������� ������ ������ ���
					int pageStart = (nowBlock - 1) * pagePerBlock + 1;
					int pageEnd = (pageStart + pagePerBlock) < totalPage ? pageStart + pagePerBlock : totalPage + 1; 
/*  					out.println("*totalPage : " + totalPage);
					out.println("*pageStart : " + pageStart);
					out.println("*pageEnd : " + pageEnd); */
					for(; pageStart<pageEnd; pageStart++){%>
						<a href="javascript:pageing('<%=pageStart%>')">
							<%if(pageStart == nowPage){%>
								<font color="#9598CA">[<%=pageStart%>]</font>
							<%}else { %>
								[<%=pageStart%>]
							<%} %>
						</a>
					<%}%>
					<%if(nowBlock < totalBlock) {%>
						<a href="javascript:block('<%=nowBlock+1%>')">&nbsp;�� ��&nbsp;</a>
					<%}%>
				</td>
			</tr>
		</table>
		
		<div style="text-align:right">
		<form name="deleteFrm" method="post">
			<input type="hidden" name="onum">
			<input type="button" name="deleteBtn" value="����" onclick="deleteCheckedBox()" class="btn btn-primary deleteBtn">
			<input type="button" name="deleteAllBtn" value="��ü����" class="btn btn-primary deleteAllBtn">
		</form>
		</div>
		
		<div style="text-align:center;">
		  	<!-- �˻� �� -->
  			<form name="searchOrderFrm"> <!-- ���ȣ��ǵ��� -->
				<select name="keyField" class="form-select"> <!-- ������ ���� keyField�� value�� ������? -->
					<option value="oid">�ֹ��� ID</option>
					<option value="pnum">��ǰ��ȣ</option>
					<option value="pname">��ǰ��</option>
					<option value="state">�ֹ�����</option>
				</select>
				<input type="text" name="keyWord" class="form-control form-text-input"> <!-- �Է��� ���� keyWord�� value�� ������? -->
				<input type="button" onclick="search()" value="�˻�" class="btn btn-primary orderSearchBtn">
		</form>
		</div>
		
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="interval" value="<%=interval%>">
		</form>
		
  		
  	</div> <!-- ���� ��-->
</div><!-- �׺���� ������ ���� ��-->
</body>
</html>