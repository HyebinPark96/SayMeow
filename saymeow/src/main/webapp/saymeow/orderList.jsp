<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<%
	//if(session.getAttribute("idKey")==null){
	//	response.sendRedirect("");
	//	return;
	//}
	int price = 0;
	int quantity = 0;
	int totalPrice = 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title>�ֹ� ���� ��ȸ</title>
<script>
	function allChk() {
		o = document.ofrm;
		if(o.allCh.checked/*üũ�̺�Ʈ*/){
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = true;
				if(o.och[i].disabled)
					o.och[i].checked = false;
			}
			o.btn.disabled = false;//��ư�� Ȱ��ȭ
			o.btn.style.color = "blue";
		} else {
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = false;
			}
			o.btn.disabled = true;//��ư�� ��Ȱ��ȭ
			o.btn.style.color = "gray";
		}
	}
	function chk() {
		o = document.ofrm;
		for(i=1;i<o.och.length;i++){
			if(o.och[i].checked/*üũ�� �Ǿ�����*/){
				o.btn.disabled = false;//��ư�� Ȱ��ȭ
				o.btn.style.color = "blue";
				return;
			}//---if
		}//----for
		//for������ �ذ��� �� ������ �ؿ� 3���� ����.
		o.allCh.checked = false;
		o.btn.disabled = true;//��ư�� ��Ȱ��ȭ
		o.btn.style.color = "gray";
	}

</script>
</head>
	<body>
<!-- include top Start -->

<!-- include top End -->
<table>
<ul>
<ol><a href="orderList.jsp">�ֹ� ���� ��ȸ</a></ol>
<ol><a href="">ȸ�� ���� ����</a></ol>
<ol><a href="">�� ���� ���</a></ol>
<ol><a href="">ȸ�� Ż��</a></ol>
</ul>
<form name="ofrm" action="orderCancleProc.jsp">
<input type="hidden" name="och" value="0">
<h1>�ֹ� ���� ��ȸ</h1>
</table>
		<table border="1" >
			<tr>
				<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
				<td>�ֹ� ��ȣ</td>
				<td>�ֹ� ����</td>
				<td>��ǰ��</td>
				<td>�ֹ� ����</td>
				<td>�ֹ� �ݾ�</td>
				<td>�ֹ� ����</td>
			</tr>
<!-- Is Empty Start -->
		<%
			Vector<OrderBean> vlist = oMgr.getOrderList("1");
			if(vlist.isEmpty()){
		%>
			<tr>
				<td colspan="5">�ֹ��Ͻ� ��ǰ�� �����ϴ�.</td>
			</tr>
<!-- Is Empty End -->
<!-- Vector List Start -->
		<%}else{
				for(int i=0;i<vlist.size();i++){
				OrderBean order = vlist.get(i);
				
				
				quantity = order.getQty();
				%>
			<tr>
				<td>
				<%if(order.getState().equals("5") || order.getState().equals("6")){ %>
				<input type="checkbox" name="och" value="<%=order.getOnum()%>" onclick="chk()" disabled>
				<%}else{ %>
				<input type="checkbox" name="och" value="<%=order.getOnum()%>" onclick="chk()">
				<%}%>
				</td>
				<td><%=order.getOnum()%></td>
				<td><%=order.getRegdate()%></td>
				<td><a href=""><%=order.getPname()%></a></td>
				<td><%=quantity%></td>
				<td>�ӽ�1</td>
				<td>
				<%
					switch(order.getState()){
						case"1": out.print("������");break;
						case"2": out.print("����");break;
						case"3": out.print("����غ�");break;
						case"4": out.print("�����");break;
						case"5": out.print("��ۿϷ�");break;
						case"6": out.print("�ֹ����");break;
					}
				%>
				</td>
			</tr>
				<%}//--for
		}//--else-if %>
<!-- Vector List End -->
		</table>
		<table>
		<input type="submit" name="btn" value="�ֹ����" disabled>
		</table>
		</form>
<!-- include bottom Start -->

<!-- include bottom End -->
	<form name="oDetail" method="post" action="">
		<input type="hidden" name="onum">
	</form>
</body>
</html>	 