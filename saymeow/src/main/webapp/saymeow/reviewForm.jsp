<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%@ include file="top.jsp" %>
<%
/* 	int onum = Integer.parseInt(request.getParameter("onum"));
	int pnum = Integer.parseInt(request.getParameter("pnum")); */
	
	// �׽�Ʈ
	int onum = 1;
	int pnum = 1; 
%>
	
	<%//if(id!=null){%> 
	<%if(true){%> <!-- �׽�Ʈ ������ �� �ڵ�� �����ϱ� -->
	<div id="review-board-container">
		<div class="review-section">
			<h3 class="title">��ǰ���Ÿ���</h3>
			<!-- ���� �ۼ� �� -->
			<!-- GET��İ� multipart ���� ��� -->
			<form class="review-form" action="ReviewFormProc.jsp?pnum=<%=pnum%>" method="post" 
			enctype="multipart/form-data"> <!-- ���Ͼ��ε� �� ���� �����Ƿ� post�� ������ -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">����</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="������ �Է��ϼ���.">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">����</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content" maxlength="500"></textarea>
				</div>
				<div class="mb-3">
 					<input type="file" class="form-control" id="formFile" name="filename">
				</div>
				<span class="star">
  					�ڡڡڡڡ� <!-- �� �� -->
  					<span>�ڡڡڡڡ�</span> <!-- ���� �ִ� �� -->
  					<!-- DB insert�Ҷ��� /2 �ؼ� insert -->
  					<input type="range" oninput="star(this)" value="1" step="1" min="0" max="10" name="score"> <!-- ���¼ҽ� ���� -->
				</span>
				<input type="hidden" name="onum" value="<%=onum%>"> <!-- �������������� ������ -->
				<input type="hidden" name="id" value="<%=id%>">
				<input type="hidden" name="pnum" value="<%=pnum%>">
				<div class="d-grid gap-2 d-md-block">
  					<input type="submit" class="btn btn-primary submitBtn" type="submit" value="�۾���">
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