/*�ѱ� �������־ �����ؾ��մϴ�!!!!*/
function loginCheck(){
	if(document.login.id.value==""){
		alert("???��??�? ???��?? 주�?��??.");
		document.login.id.focus();
		return;
	}
	if(document.login.pwd.value==""){
		alert("�?�?�??��?? ???��?? 주�?��??.");
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
		alert("???��??�? ???��?? 주�?��??.");
		document.regForm.id.focus();
		return;
	}
	if(document.regForm.pwd.value==""){
		alert("�?�?�??��?? ???��?? 주�?��??.");
		document.regForm.pwd.focus();
		return;
	}
	if(document.regForm.repwd.value==""){
		alert("�?�?�??��?? ???��?? 주�?��??");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.pwd.value != document.regForm.repwd.value){
		alert("�?�?�??��? ?��???�? ???��????.");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.name.value==""){
		alert("?��??? ???��?? 주�?��??.");
		document.regForm.name.focus();
		return;
	}
	
	
	if(document.regForm.birthday.value==""){
		alert("???????��?? ???��?? 주�?��??.");
		document.regForm.birthday.focus();
		return;
	}

	
	if(document.regForm.email.value==""){
		alert("?��??��?? ???��?? 주�?��??.");
		document.regForm.email.focus();
		return;
	}
		if(document.regForm.address.value==""){
		alert("주�??�? ???��?? 주�?��??.");
		document.regForm.address.focus();
		return;
	}
	if(document.regForm.petName.value==""){
		alert("�????��?��??? ???��?? 주�?��??.");
		document.regForm.petName.focus();
		return;
	}
	
	if(document.regForm.petAge.value==""){
		alert("�????��???��?? ???��?? 주�?��??.");
		document.regForm.petAge.focus();
		return;
	}
	if(document.regForm.petGender.value==""){
		alert("�????��?��??? ???��?? 주�?��??.");
		document.regForm.petGender.focus();
		return;
	}
	if(document.regForm.petBreed.value==""){
		alert("�????��??�??? ???��?? 주�?��??.");
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
          alert('E-mail주�?? ?????? ??못�?????��????.\n\r?��?? ???��?? 주�?��??!');
	      document.regForm.email.focus();
		  return;
    }

	
	document.regForm.submit();
}


function idCheck(id){
	if(id == ""){
		alert("???��??�? ???��?? 주�?��??.");
		document.regForm.id.focus();
	}else{
		url="idCheck.jsp?id=" + id;
		window.open(url,"post","width=300,height=150");
	}
}

function id_search() { 
	 	var frm = document.idfindscreen;

	 	if (frm.name.value.length < 1) {
		  alert("?��??? ???��?�주?��??");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("?��???��??��?? ??????�? ???��?�주?��??");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "findIdResult.jsp"; //???��???�?
	 frm.submit();  
	 }
	  function pw_search(){

  var frm=document.pwfindscreen;

  if(frm.mid.value.length<1){
   alert("???��??�? ?��?르�? ???��?�주?��??");
   return;
  }

   if (frm.phone.value.length != 11) {
			  alert("?��???��??��?? ??????�? ???��?�주?��??");
			  return;
		 }
	
  frm.method="post";
  frm.action="findPwResult.jsp"; //???��???�?
  frm.submit(); 
  }


function win_close(){
	self.close();
}
