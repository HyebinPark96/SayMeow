/*한글 에러나있어서 수정해야합니다!!!!*/
function loginCheck(){
	if(document.login.id.value==""){
		alert("���대��瑜� ���ν�� 二쇱�몄��.");
		document.login.id.focus();
		return;
	}
	if(document.login.pwd.value==""){
		alert("鍮�諛�踰��몃�� ���ν�� 二쇱�몄��.");
		document.login.pwd.focus();
		return;
	}
	document.login.submit();
}

function memberReg(){
	document.location="member.jsp";
}

function inputCheck(){
	if(document.regForm.id.value==""){
		alert("���대��瑜� ���ν�� 二쇱�몄��.");
		document.regForm.id.focus();
		return;
	}
	if(document.regForm.pwd.value==""){
		alert("鍮�諛�踰��몃�� ���ν�� 二쇱�몄��.");
		document.regForm.pwd.focus();
		return;
	}
	if(document.regForm.repwd.value==""){
		alert("鍮�諛�踰��몃�� ���명�� 二쇱�몄��");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.pwd.value != document.regForm.repwd.value){
		alert("鍮�諛�踰��멸� �쇱���吏� ���듬����.");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.name.value==""){
		alert("�대��� ���ν�� 二쇱�몄��.");
		document.regForm.name.focus();
		return;
	}
	
	
	if(document.regForm.birthday.value==""){
		alert("�������쇰�� ���ν�� 二쇱�몄��.");
		document.regForm.birthday.focus();
		return;
	}

	
	if(document.regForm.email.value==""){
		alert("�대��쇱�� ���ν�� 二쇱�몄��.");
		document.regForm.email.focus();
		return;
	}
		if(document.regForm.address.value==""){
		alert("二쇱��瑜� ���ν�� 二쇱�몄��.");
		document.regForm.address.focus();
		return;
	}
	if(document.regForm.petName.value==""){
		alert("怨����댁�대��� ���ν�� 二쇱�몄��.");
		document.regForm.petName.focus();
		return;
	}
	
	if(document.regForm.petAge.value==""){
		alert("怨����대���대�� ���ν�� 二쇱�몄��.");
		document.regForm.petAge.focus();
		return;
	}
	if(document.regForm.petGender.value==""){
		alert("怨����댁�깅��� ���ν�� 二쇱�몄��.");
		document.regForm.petGender.focus();
		return;
	}
	if(document.regForm.petBreed.value==""){
		alert("怨����댄��醫��� ���ν�� 二쇱�몄��.");
		document.regForm.petBreed.focus();
		return;
	}
    var str=document.regForm.email.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail二쇱�� ������ ��紐삳�����듬����.\n\r�ㅼ�� ���ν�� 二쇱�몄��!');
	      document.regForm.email.focus();
		  return;
    }

	
	document.regForm.submit();
}


function idCheck(id){
	if(id == ""){
		alert("���대��瑜� ���ν�� 二쇱�몄��.");
		document.regForm.id.focus();
	}else{
		url="idCheck.jsp?id=" + id;
		window.open(url,"post","width=300,height=150");
	}
}

function id_search() { 
	 	var frm = document.idfindscreen;

	 	if (frm.name.value.length < 1) {
		  alert("�대��� ���ν�댁＜�몄��");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("�몃���곕��몃�� ������寃� ���ν�댁＜�몄��");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "findIdResult.jsp"; //���닿���硫�
	 frm.submit();  
	 }
	  function pw_search(){

  var frm=document.pwfindscreen;

  if(frm.mid.value.length<1){
   alert("���대��瑜� �щ�瑜닿� ���ν�댁＜�몄��");
   return;
  }

   if (frm.phone.value.length != 11) {
			  alert("�몃���곕��몃�� ������寃� ���ν�댁＜�몄��");
			  return;
		 }
	
  frm.method="post";
  frm.action="findPwResult.jsp"; //���닿���硫�
  frm.submit(); 
  }


function win_close(){
	self.close();
}
