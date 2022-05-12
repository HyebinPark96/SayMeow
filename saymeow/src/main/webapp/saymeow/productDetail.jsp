<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="saymeow.ProductMgr"/>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	ProductBean pbean = pMgr.getProduct(pnum);

	int price1 = pbean.getPrice1();
	int 
	

%>
		
<!doctype html>
<html>
<head>
<script src="pscript.js"></script>
     <style>
		img { display : block;
		margin : auto;}
		table, tr, td{
		 border:none;}
		 td, th {
  	vertical-align : middle;}
    </style>
    
</head>
<main>
<%@ include file="top.jsp" %>

	<div sp-edit="text" style="padding:1rem 0;text-align:center;" 
		class="initialize" area="before"><span sp-font="13" style="color:#333;" 
		><b>상품 상세 페이지&nbsp;</b></span></div>
		<table width="75%" align="center">
		<tr> 
		<td align="center" >
		<table width="95%" border="1">
		<tr> 
		<td colspan="2" align="center">
			<font color="#FFFFFF"></font>
		</td>
		</tr>
		<tr> 
		<td width="20%">
			<img src="images/noimage.png">
	</td>
	<td width="30%" valign="top">
			<table>
			<tr>
				<td>상품이름 : </td>
			</tr>			
			<tr>
				<td>가    격 : </td> 
			</tr>
			<tr>
			<td>
				<form name="form" method="get" >
				구매수량 : <input type=hidden name="sell_price" value="500">
				<input type="text" name="amount" value="1" size="3" onchange="change();">
				<input type="button" value=" + " onclick="add();"><input type="button" value=" - " onclick="del();"><br>
				</td>
			</tr>
				<tr>
				<td>
				금액 : <input type="text" name="sum" size="11" readonly>원
				</form>
		
				</td>
				</tr>
				<tr>
				<td>
				<input id="cartBtn" type="button" class="btn" value="장바구니" onclick="addCart()"> 
				<input id="submit_btn" type="button" onclick="logincheck_goods()" class="btn" value="구매하기">
				</td>
				</tr>
			</table>		
			</td>
			</tr>
			</table>
			
		
		<div sp-edit="text" style="padding:1rem 0;text-align:center;" 
		class="initialize" area="before" ><span sp-font="13" style="color:#333;">
		<b>D E T A I L&nbsp;</b></span></div>

		<table width="75%" align="center" >
		<tr> 
		<td align="center" >
		<table width="95%" border="1">
		<tr> 
		<td rowspan="1" align="center">
			<font color="#FFFFFF"></font>
		</td>
		</tr>
		<tr> 
		<td width="50%">
		<!--  <div sp-edit="text" style="padding:0;text-align:center;" class="initialize" area="before" >
		<font color="#888888"><span style="font-size: 12.8px;">
		설명</span></font><br></div>-->
				<img id="detail_pht" src="images/noimage.png">
		</table>	
		</td>
		</tr>
		</table>
		</td>
		</tr>
		</table>

<%@ include file="bottom.jsp" %>			
</main>
</html>