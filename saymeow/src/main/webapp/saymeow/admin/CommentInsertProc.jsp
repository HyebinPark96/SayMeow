<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>
<jsp:setProperty property="*" name="rcBean"/>
<%
	String comment = request.getParameter("comment"); // ��۳���
	if(comment.trim().equals("")||comment==null){%>
		<script>
			alert('(��������) 1�� �̻� ����� �Է����ּ���.');
			history.back();
		</script>
	<%} else {%>
		<script>
			alert('����� �߰��߽��ϴ�.');
			location.href = "adminReviewBoard.jsp" // ../ : ������� �̵�
		</script>
<%
		cMgr.insertRComment(rcBean); // ��� �߰� �޼ҵ�
	}
%>

