<!-- ������ ��� �� �� ���� ���� -->
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rcNum = UtilMgr.parseInt(request, "rcNum"); // rcNum ���޹ޱ�
	cMgr.deleteRComment(rcNum);
	
%>
<script>
	alert('<%=rcNum%>���ڵ尡 �����Ǿ����ϴ�!');
	location.href = "../reviewBoard.jsp";
</script>