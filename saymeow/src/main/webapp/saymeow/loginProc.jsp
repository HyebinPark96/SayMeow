<!-- ���տϷ� -->

<!-- �α��� ó�������� -->
<%@page contentType="text/html;charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	int mode = mMgr.loginMember(id, pwd);
	 
	if(mode==2){ // ��ȸ���� ���%>
	<script>
		alert('���̵�� ��й�ȣ�� ��Ȯ���� �ʽ��ϴ�!');
		history.back();
	</script>
	<%
	} else if(mode==0 || mode==1){ // ȸ���̰ų� �������ΰ��
		session.setAttribute("idKey",id); // �α��� ������ id�� ���ǿ� ����
		response.sendRedirect("index.jsp");
	}
	%>

