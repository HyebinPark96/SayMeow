<!-- ����Ʈ �������ٸ� ����� �ٽ� ����Ʈ�ϸ� �ذ�� -->

<%@page import="saymeow.RCommentBean"%>
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<!-- ����� ��� mgr ��ü���� -->
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr" />
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr" />
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>

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
totalRecord = rMgr.getTotalCount(keyField, keyWord); // �˻��� ���� keyField, keyWord �� �����Ǿ� �ְ�, �ƴ� ���� "" �� ����

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
<!DOCTYPE html>
<html>
<head>
<title>SayMeow</title>
<!-- ���� CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<script type="text/javascript">
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
		document.listFrm.action = "reviewBoard.jsp";
		document.listFrm.submit(); // reload�� nowPage VALUE�� POST������� �����Ͽ� ���ȣ��
	}

	// �˻�
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("�˻�� �Է��ϼ���.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit(); // readFrm�� ���� ����
	}

	// �Խñ� �б�
	function read(i) {
		// document.readFrm.rnum.value = rnum;
		// document.readFrm.action = "reviewRead.jsp"; // JS���� action ���� ����
		// document.readFrm.submit(); // �� ����
		
		/*�׽�Ʈ : ��۽����� �����غ���*/
		if(document.getElementsByClassName('reviewDetail')[i].style.display = 'hidden'){
			document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:block");
		}
	}
</script>
<!-- ���� JS -->
<script src="scriptHB.js"></script>
<%@ include file="top.jsp"%>
<!-- �ܺ� CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- ��Ʈ��Ʈ�� CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
	<div align="center" id="review-board">
		<br />
		<h2 class="review-board-topic">����</h2>
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
					Vector<ReviewBean> vlist = rMgr.getReviewList(keyField, keyWord, start, cnt);
					int listSize = vlist.size(); // �� �������� ��� �� ���ڵ尹�� (�ִ� 10��, ������ �������� 10 ������ ���� ���� ���� ����)
					if (vlist.isEmpty()) {
						out.println("��ϵ� �Խù��� �����ϴ�.");
					} else {
					%>
					<table cellspacing="0" class="table table-hover">
						<tr align="center" class="table-column">
							<td width="200">�� ȣ</td>
							<td width="200">�� ��</td>
							<td width="200">�� ��</td>
							<td width="200">���̵�</td>
							<td width="200">�� ¥</td>
							<td width="100">&nbsp;</td>
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
							int pnum = bean.getPnum();
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
							<td><%=totalRecord - start - i%></td><!-- ������� : ���� �ֽű��� ���� ���� ���� -->
							<td><%=score%></td>
							<td align="left">
								<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=subject%></a> <!-- �������� --> 
								<%if (filename != null) {%>
									<img src="img/file_icon1.png" width="15px" height="15px" align="middle"> <!-- ���������� �̸�Ƽ�� ���� -->
								<%}%>
								<%if (rCount > 0) {%> <!-- ����ִٸ� --> 
									<font color="red">(<%=rCount%>)</font> <!-- ���������� (��ۼ�) ���� --> 
									<%}%>
							</td>
							<td><%=rid%></td><!-- �����ۼ��� -->
							<td><%=date%></td><!-- �����ۼ���¥ -->
							
							<td>
								<%if(id.equals(rid) || id==rid || id=="admin" || id.equals("admin")){%>
									<form name="deleteReviewFrm" action="reviewDeleteProc.jsp" method="post">
										<input type="hidden" name="rnum" value="<%=rnum%>">
										<input type="hidden" name="filename" value="<%=filename%>">
										<input type="submit" class="btn btn-primary submitBtn" value="����">
									</form>
								<%}%>
							</td>
						</tr>
						
						
						<!-- ���䴩���� ������ �̵����� �Ʒ��� �ߵ��� -->
					
						<tr style="display:none; text-align:left" class="reviewDetail">
							<td colspan="5" align="left" style="background-color:pink; width:200;">
								<form name="reviewDetailFrm" action="reviewUpdate.jsp?rnum=<%=rnum%>" method="POST" class="reviewDetailFrm">
									<input type="hidden" name="rnum" value="<%=rnum%>">
									<input type="hidden" name="onum" value="<%=onum%>">
									<input type="hidden" name="rid" value="<%=rid%>">
									<input type="hidden" name="pnum" value="<%=pnum%>">
									<input type="hidden" name="date" value="<%=date%>">
									<input type="hidden" name="subject" value="<%=subject%>">
									<input type="hidden" name="content" value="<%=content%>">
									<input type="hidden" name="score" value="<%=score%>">
									
									[�Խñ�]<br>
									�ۼ��� ID : <%=rid%><br>
									�ۼ���¥ : <%=date%><br>
									���� : <%=subject%><br>
									���� : <%=content%><br>
									���� : <%=score%><br>
									<%if(filename!=null){ %>
										<img src="storage/<%=filename%>" width="50px" height="50px"><br><br>
										<input type="hidden" name="filename" value="<%=filename%>">
									<%} %>
									<%if(id.equals(rid) || id==rid) { /*���θ����� ������ư Ȱ��ȭ*/%>
										<input type="submit" class="btn btn-primary submitBtn" value="����">
									<%}%>
									<hr>
								</form>
									[���]<br>
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
										<form name="commentListFrm" action="admin/commentDeleteProc.jsp" method="POST">
											���� : <%=j+1%><br>
											�ۼ��� ID : <%=cid %><br>
											�ۼ���¥ : <%=rcDate %><br>
											��۳��� : <%=comment%><br>
											<%if(id=="admin" || id.equals("admin")){%> <!-- �����ڸ� ��� ��� ���� ���� -->
											<input type="hidden" name="rcNum" value="<%=rcNum%>">
											<input type="submit" class="btn btn-primary submitBtn" value="����">
											<%}%>
											<br><br>
										</form>
									<%} %>
								<%} %>
									<hr>
							<%if(id=="admin") {%>
								<form name="commentFrm" action="admin/commentInsertProc.jsp" method="post">
									<input type="hidden" name="rnum" value="<%=rnum%>">
									<input type="hidden" name="cid" value="<%=id%>">
									<input type="hidden" name="pnum" value="<%=pnum%>">
									<input type="text" name="comment">
									<input type="submit" class="btn btn-primary submitBtn" value="�ۼ�">
								</form>
							<%}%>
							</td>
						</tr>
						
						
						
						
						
						
						
						
						<%} // --- for��%>
					</table> <%} // ---if-else��%>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br>
				<br>
			</tr>
			<tr>
				<td align="center">
					<!-- ����¡ �� �� Start --> 
					<!-- ������ �̵�(ù�������� ����� ��)--> 
					<%if (nowBlock > 1) {%>
						<a href="javascript:block('<%=nowBlock - 1/*������*/%>')" class="review-board-aTag">&nbsp����&nbsp</a> 
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
					<a href="javascript:block('<%=nowBlock + 1%>')" class="review-board-aTag">&nbsp����&nbsp</a> 
				<%}%> 
				<!-- ����¡ �� �� End -->
				</td>
				</tr>
				<tr>
				<!-- 'ó������' ��ư ������ �� list()�Լ� ȣ�� -> listFrm submut -> reload = true ���� -> keyField, keyWord �ʱ�ȭ�� -->
				<td align="right">
					<a href="javascript:list()" class="review-board-aTag"><button type="button" class="btn btn-outline-secondary">ó������</button></a> 
				</td>
			</tr>
		</table>
		<!-- �Խù� ����Ʈ End -->

		<form name="searchFrm" class="searchFrm">
			<table width="600" cellpadding="4" cellspacing="0">
				<tr>
					<td align="center" valign="bottom">
						<select name="keyField" size="1" class="form-select">
							<option value="rid">�ۼ��� ID</option>
							<option value="subject">�� ��</option>
							<option value="content">�� ��</option>
						</select> <!-- ����Ʈ text type --> 
						<input name="keyWord" size="16" class="form-control"> 
						<input type="hidden" name="nowPage" value="1"> <!-- �˻� �� �ʱ�ȭ : ���� �˻� ����� 1���������� �������Ƿ�-->
						<input type="button" value="Search" onclick="check()" class="btn btn-outline-secondary reviewSearchBtn">
					</td>
				</tr>
			</table>
		</form>

		<!-- ó������ ��ư ������ list() �޼ҵ带 ���� post������� ���� (�ʱ�ȭ)-->
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
		</form>

		<!-- �Ʒ� ������ GET������� �����ϸ�, 10�� 15�� �� ������ �ٲܶ����� ���ȣ�� -->
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
			<input type="hidden" name="keyField" value="<%=keyField%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
			<input type="hidden" name="rnum">
		</form>
	</div>

	<!-- ��Ʈ��Ʈ�� JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
	</script>
	<%@ include file="bottom.jsp"%>
</body>
</html>