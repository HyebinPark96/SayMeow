<!-- �������� �����ϸ� ����Ʈ ������ ���ɼ������Ƿ�, �������� ����� �ٽ� ����Ʈ�ؿ��� -->
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int totalRecord = 0; // �� �Խù� ��
	int numPerPage = 10; // �� �������� �ҷ��� ���ڵ� ���� (�����ؼ� 5,10,15,30 ��� �߰� ����)
	int pagePerBlock = 15; // �� ���� �� 15�� ������ �ҷ����� (Ex. �� ���� 1~15������ ����)
	int totalPage = 0; // �� ������ ����
	int totalBlock = 0; // �� �� ���� (15�������� �� ���� �ִ°�?)
	int nowPage = 1; // ���� ������
	int nowBlock = 1; // ���� ��
	
	if(request.getParameter("numPerPage")!=null) { // x�������� �ɼ� �ٲٸ� ���ȣ��Ǹ鼭 �ٽ� numPerPage ����
		numPerPage = UtilMgr.parseInt(request, "numPerPage"); 
	}
	
	// �˻��� �ʿ��� ���� 
	String keyField = "", keyWord = ""; // �˻� �� ����Ʈ
	if(request.getParameter("keyWord")!=null){ // �˻��ߴٸ�
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	// �˻� �� 'ó������' ��ư �����߸� reload���� ���޵Ǹ鼭 �˻� �ʱ�ȭ�� ���·� ���ȣ��
	if(request.getParameter("reload")!=null&&request.getParameter("reload").equals("true")){
		keyField = "";
		keyWord = "";
	}
	
	// mgr getTotalCount �޼ҵ� : �˻��� �� �ƴ� �� �����Ͽ� SQL�� �޸� �ۼ��Ǿ� ���� 
	totalRecord = rMgr.getTotalCount(keyField, keyWord); // �˻��� ���� keyField, keyWord �� �����Ǿ� �ְ�, �ƴ� ���� "" �� ����
	// out.println(totalRecord); // (�׽�Ʈ��) 1000 ����
	
	// ������ Ŭ�� OR �Խñ� �а� '����Ʈ��' Ŭ�� -> GET������� ��ġ���ִ� nowPage ���� (+keyField, keyWord�� ������)
	if(request.getParameter("nowPage")!=null){ 
		nowPage = UtilMgr.parseInt(request, "nowPage"); 
	}
	
	// sql�� LIMIT�� ���� ���� ���� 
	int start = (nowPage * numPerPage) - numPerPage; // 1�������϶� 0, 2�������϶� 10, 3�������϶� 20, ...
	int cnt =  numPerPage; // ����Ʈ 10�� (�� �������� �������� ���ڵ� ����)
	
	// ��ü ������ ����
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage); // Ex. �Խù� 663�� -> ���ڵ尳��/10(66������) + 1(�ø� : �������������� 10���� ���� �� ������ �Խñ� ��(3��) ���� �ϹǷ�)
	
	// ��ü �� ����
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock); // Ex. �� 67������ / �� ���� 15������ = 4.47 -> +1 (�ø�) �ؼ� 5��
	
	// ���� ���° ������ 
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); // Ex. ���� 1������ / �� ���� 15������
	
	// �׽�Ʈ��
	// out.println("totalPage : "+ totalPage + "<br>");
	// out.println("totalBlock : "+ totalBlock + "<br>");
	// out.println("nowBlock : "+ nowBlock + "<br>");
	
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
		document.readFrm.nowPage.value /*value ����������*/ = page; // �Ű������� ���� page�� nowPage�� ������ ��û
		document.readFrm.submit();
	}

	// �� �̵�
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
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
		document.listFrm.submit(); // reload�� nowPage post������� �����Ͽ� ���ȣ��
	}
	
	// �˻�
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("�˻�� �Է��ϼ���.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit(); // readFrm�� ���� ����
	}
	
	// �Խñ� �б�
	function read(rnum) {
		document.readFrm.rnum.value = rnum;
		document.readFrm.action = "#";
		document.readFrm.submit();
	}
	
</script>
<!-- ���� JS -->
<script src="scriptHB.js"></script>
<%@ include file="top.jsp" %>
<!-- �ܺ� CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
<div align="center"><br/>
<h2>���亸��</h2><br/>
<table>
	<tr>
		<td width="600">
		Total : <%=totalRecord%>Articles(<font color="red">
		<%=nowPage + "/" + totalPage%> Pages</font>)
		</td>
		<td align="right">
		<!-- action �����̹Ƿ� ���ȣ�� -->
			<form name="npFrm" method="post">
			<!-- select�±��� size�Ӽ� : �ѹ��� ���� �ɼ��� ����, onchange() : ������ �ٲ� ������ -->
				<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)"> <!-- 5,10,15,20 �� �ϳ� -->
    				<option value="5">5�� ����</option>
    				<option value="10" selected>10�� ����</option>
    				<option value="15">15�� ����</option>
    				<option value="30">30�� ����</option>
   				</select>
   			</form>
   			<script>
   			<!-- if) '20�� ����' ���� ��, �Խñ� �а� ����Ʈ�� ���ƿ͵� ���� numPerPage ������ ���·� list.jsp ȣ���ϱ� ����-->
   				document.npFrm.numPerPage.value = <%=numPerPage%>;
   			</script>
		</td>
	</tr>
</table>
<!-- �Խù� ����Ʈ Start -->
<table>
	<tr>
		<td align="center" colspan="2">
			<%
				Vector<ReviewBean> vlist = rMgr.getBoardList(keyField, keyWord, start, cnt);
				int listSize = vlist.size(); // �� �������� ��� �� ���ڵ尹�� (�ִ� 10��, ������ �������� 10 ������ ���� ���� ���� ����)
				
				if(vlist.isEmpty()) {
					out.println("��ϵ� �Խù��� �����ϴ�."); 
				} else {
			%>
					<table cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0">
						<td width="100">�� ȣ</td>
						<td width="250">�� ��</td>
						<td width="100">���̵�</td>
						<td width="150">�� ¥</td>
					</tr>	
				<% 
				/* for�� if���� ������ i==listSize�� listSize�� LIMIT �Լ��� �Խñ��� �ҷ��ͼ� ���� Vector�� ũ���̸�,
				(������������ ����) �� �������� listSize=10�̹Ƿ� ���� if�� ���ǿ� ������ ���� �� ������(i�� �ִ� 9��),
				�������������� 10�̸��� ���ڵ尳���� ���� �� �����Ƿ�, �׸�ŭ�� �ݺ��� ������ ���������ٴ� �ǹ� */
					for(int i=0; i<numPerPage;/*10��*/ i++){
						if(i==listSize)
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
						int score = bean.getScore();
						String filename = bean.getFilename(); // ���� ���ε� �� ��� ���� �� ������ �߰�
						int filesize=  bean.getFilesize();
						
						// ���� ��� �� count
						int rCount = cMgr.getRCommentCount(rnum);
				%>
				<!-- �� ��(����)�� �´� �� �ݺ������� ���� -->
					<tr align="center">
						<td><%=totalRecord-start-i%></td> <!-- ������� -->
						<td align="left">
							<a href="javascript:read('<%=rnum%>')">
							<%=subject%></a> <!-- �������� -->
							<%if(filename!=null&&!filename.equals("")){ %>
								<img src="img/file_icon1.png" align="middle"> <!-- ���������� �̸�Ƽ�� ���� -->
							<%}%>
							<%if(rCount>0){%> <!-- ����ִٸ� -->
								<font color="red">(<%=rnum%>)</font> <!-- ���������� (��ۼ�) ���� -->
							<%}%>
						</td>
						<td><%=rid%></td> <!-- �����ۼ��� -->
						<td><%=date%></td> <!-- �����ۼ���¥ -->
					</tr>
				<%} // --- for��%>
			</table>					
			<%} // ---if-else�� %>
		</td>
	</tr>
	<tr>
		<td colspan="2"><br><br>
	</tr>
	<tr>
		<td>
			<!-- ����¡ �� �� Start -->
			<!-- ������ �̵�(ù�������� ����� ��)-->
			<% if(nowBlock>1){%>
				<a href="javascript:block('<%=nowBlock-1/*������*/%>')">prev...</a>
			<%}%>
		
			<!-- ����¡(Ư����) -->
			<%
			// �Ʒ������� for�� ������ ���� 1~16 -> 1~15���� �ݺ�
				int pageStart = (nowBlock - 1) * pagePerBlock + 1; /*����1���ͽ��� */
				int pageEnd = (pageStart + pagePerBlock /*15*/) < totalPage?pageStart+pagePerBlock:totalPage+1; /*������ ���� 15�������� �ȵ� �� �����Ƿ� ���׿����� ���*/
			
				// �ݺ���
				for(;pageStart<pageEnd;pageStart++){ // ����� ���� �ʱ����? pageStart = 1;���� ����
			%>
				<a href="javascript:pageing('<%=pageStart%>')">
					<%if(pageStart==nowPage){%><font color="blue"><%}%>
						[<%=pageStart%>]
					<%if(pageStart==nowPage){%></font><%}%>	<!-- if�� �ΰ��� ����: ���ǿ� �¾ƾ߸� font �ڵ� ����ǵ���-->
				</a>
			<%} // --- for%>
		
			<!-- ������ �̵�(�������������� ����� ��)-->
			<%if(totalBlock>nowBlock){%>
				<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
			<%}%>
			<!-- ����¡ �� �� End -->
		</td>
		<td align="right">
			<a href="javascript:list()">[ó������]</a> <!-- ó������ ��ư ������ �� list()�Լ� ȣ��-> -->
		</td>
	</tr>
</table>
<!-- �Խù� ����Ʈ End -->
<hr width="750">
<form name="searchFrm">
	<table width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
  				<select name="keyField" size="1">
  					<option value="name">�� ��</option>
  					<option value="subject">�� ��</option>
  					<option value="content">�� ��</option>
  				</select> 
  				<!-- ����Ʈ text type -->
  				<input name="keyWord" size="16">
  				<input type="hidden" name="nowPage" value="1"> <!-- �˻� �� �ʱ�ȭ : ���� �˻� ����� 1���������� �������Ƿ�-->
  				<input type="button" value="ã��" onclick="check()"> 
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
<%@ include file="bottom.jsp" %>
</body>
</html>