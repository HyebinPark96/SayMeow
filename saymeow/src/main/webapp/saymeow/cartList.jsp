<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<%
	

	int allTotal=0;
%>
<!DOCTYPE html>
<html>
<head>
<title>Cart List</title>
<script>
	function allChk() {
		c = document.cfrm;
		if(c.allCh.checked/*üũ�̺�Ʈ*/){
			for(i=1;i<c.cch.length;i++){
				c.cch[i].checked = true;
				if(c.cch[i].disabled)
					c.cch[i].checked = false;
			}
			c.btn.disabled = false;//��ư�� Ȱ��ȭ
			c.btn.style.color = "blue";
		} else {
			for(i=1;i<c.cch.length;i++){
				c.cch[i].checked = false;
			}
			c.btn.disabled = true;//��ư�� ��Ȱ��ȭ
			c.btn.style.color = "gray";
		}
	}
	function chk() {
		c = document.cfrm;
		for(i=1;i<c.cch.length;i++){
			if(c.cch[i].checked/*üũ�� �Ǿ�����*/){
				c.btn.disabled = false;//��ư�� Ȱ��ȭ
				c.btn.style.color = "blue";
				return;
			}//---if
		}//----for
		//for������ �ذ��� �� ������ �ؿ� 3���� ����.
		c.allCh.checked = false;
		c.btn.disabled = true;//��ư�� ��Ȱ��ȭ
		c.btn.style.color = "gray";
	}

</script>
</head>
<body>
<form name="cfrm" action="cartDeleteProc.jsp">
<input type="hidden" name="cch" value="0">
<h1>�� ��ٱ���</h1>
	<table>
		<tr>
		<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
		<td>NO</td>
		<td>��ǰ��</td>
		<td>�ǸŰ�</td>
		<td>����</td>
		<td>�ݾ�</td>
		</tr>
<!-- Is Empty Start -->
		<%
			Vector<CartBean> vlist = cMgr.getCartList("1");
			if(vlist.isEmpty()){
		%>
			<tr>
				<td colspan="6">��ٱ��Ͽ� �߰��� ��ǰ�� �����ϴ�.</td>
			</tr>
<!-- Is Empty End -->
<!-- Vector List Start -->
		<%}else{
			for(int i=0;i<vlist.size();i++){
			CartBean cart = vlist.get(i);
			int price = cart.getPrice1();
			int quantity = cart.getQty();
			int total = price*quantity;
			allTotal += total;
		%>
		<tr>
			<td><input type="checkbox" name="cch" value="<%=cart.getCnum()%>" onclick="chk()"></td>
			<td><%=i+1%></td>
			<td><%=cart.getPname()%></td>
			<td><%=price%></td>
			<td><%=quantity%></td>
			<td><%=total%></td>
		</tr>
		
			<%}
		}%>
	</table>
	<!-- Vector List End -->
	<table>
	<h1>��ٱ����� �� �ݾ��� <%=allTotal%>�� �Դϴ�</h1>
	</table>
	<table>
	<input type="submit" name="btn" value="����" disabled>
	<a href="orderProc.jsp"><input type="button" name="order" value="�ֹ��ϱ�"></a>
	</table>
	</form>
</body>
</html>



