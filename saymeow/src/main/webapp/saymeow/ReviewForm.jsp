<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%@ include file="top.jsp" %>
	<%if(id!=null){%>
	<div id="review-board-container">
		<div class="review-section">
			<h3 class="title">��ǰ���Ÿ���</h3>
			<!-- ���� �ۼ� �� -->
			<form class="review-form" action="ReviewFormProc.jsp" method="post" enctype="multipart/form-data"> <!-- ���Ͼ��ε� �� ���� �����Ƿ� post�� ������ -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">����</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="������ �Է��ϼ���.">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">����</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content"></textarea>
				</div>
				<div class="mb-3">
 					<input class="form-control" type="file" id="formFile" name="file">
				</div>
				<div class="d-grid gap-2 d-md-block">
  					<button class="btn btn-primary submitBtn" type="button" onclick="javascript:send();">�ۼ��ϱ�</button>
				</div>
			</form>
		</div>
	</div>
	
	<%} else {%>	
		<div id="review-board-container">
			<%out.println("�α����� ���� �������ּ���");%>
		</div>
	<%}%>
<%@ include file="bottom.jsp" %>