<!-- �� �� ���� �ҷ����� ������ -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="rBean" class="saymeow.ReviewBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum"); // GET������� rnum ���޹��� �� int����ȯ
	rBean = rMgr.getReview(rnum); // ��� �����ϱ�
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�����б�</title>
<!-- ž���� CSS -->
<link rel="stylesheet" href="css/style.css">
<!-- ���� CSS -->
<link rel="stylesheet" href="css/styleHB.css">
<script>
	function submitForDelete() { // ������ �� ����
		document.reviewReadFrm.action = "reviewDeleteProc.jsp"; // �׼� ����
		document.reviewReadFrm.submit(); // ����
	}
</script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="top.jsp" %>
</head>
<body>

	<div id="review-board-container" style="text-align:left;">
		<div class="review-section">
			<h3 class="title" style="text-align:center;">��ǰ���Ÿ���</h3>
			<!-- ���� �ۼ� �� -->
			<!-- GET��İ� multipart ���� ��� -->
			<form name="reviewReadFrm" method="post" 
			> <!-- ���Ͼ��ε� �� ���� �����Ƿ� post�� ������ -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">���� :&nbsp</label>
  					<input name="rnum" value="<%=rBean.getRnum()%>" readonly>
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">���� :&nbsp</label>
  					<input name="subject" value="<%=rBean.getSubject()%>" readonly>
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">���� :&nbsp</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content"
  					maxlength="500" style="width:30vw;"readonly><%=rBean.getContent()%></textarea>
				</div>
				<%if(rBean.getFilename()!=null && !rBean.getFilename().trim().equals("")){/*���Ͼ��ε�� ������*/%>
					<div class="mb-3">
  						<label for="exampleFormControlInput1" class="form-label">
  							���ε� ���ϸ� :&nbsp
  							<input name="filename" value="<%=rBean.getFilename()%>" readonly>
  						</label>
  						<label for="exampleFormControlInput1" class="form-label">
  							���ε� ����ũ�� :&nbsp
  							<input name="filesize" value="<%=rBean.getFilesize()%>" readonly>Byte
  						</label>
					</div>
				<%}else{%>
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">
							���ε� ������ �����ϴ�.
						</label>
					</div>
				<%}%>
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">
							���� :&nbsp
							<input name="score" value="<%=rBean.getScore()%>" readonly>
						</label>
					</div>
				<input type="hidden" name="pnum" value="<%=rBean.getPnum()%>" readonly>
				
				<%if(id == rBean.getRid()){ /*�α���id�� �����ۼ���id ���ٸ�*/%>
				<div class="d-grid gap-2 d-md-block" style="text-align:center;">
  					<input type="submit" class="btn btn-primary submitBtn" value="����" >
				</div>
				<div class="d-grid gap-2 d-md-block" style="text-align:center;">
  					<input type="submit" class="btn btn-primary submitBtn" value="����" >
				</div>
				<%} else if(id=="admin"){%>
				<div class="d-grid gap-2 d-md-block" style="text-align:center;">
  					<input type="submit" class="btn btn-primary submitBtn" onclick="submitForDelete()" value="[�����ڱ���] ����">
				</div>
				<%} else{%>
					
				<%} %>
			</form>
		</div>
	</div>
	<!-- ��Ʈ��Ʈ�� JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous">
</script>
<%@ include file="bottom.jsp"%>	
</body>
</html>