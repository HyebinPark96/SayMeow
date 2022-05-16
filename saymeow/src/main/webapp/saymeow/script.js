/*ÇÑ±Û ¿¡·¯³ªÀÖ¾î¼­ ¼öÁ¤ÇØ¾ßÇÕ´Ï´Ù!!!!*/
function loginCheck(){
	if(document.login.id.value==""){
		alert("???´ë??ë¥? ???¥í?? ì£¼ì?¸ì??.");
		document.login.id.focus();
		return;
	}
	if(document.login.pwd.value==""){
		alert("ë¹?ë°?ë²??¸ë?? ???¥í?? ì£¼ì?¸ì??.");
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
		alert("???´ë??ë¥? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.id.focus();
		return;
	}
	if(document.regForm.pwd.value==""){
		alert("ë¹?ë°?ë²??¸ë?? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.pwd.focus();
		return;
	}
	if(document.regForm.repwd.value==""){
		alert("ë¹?ë°?ë²??¸ë?? ???¸í?? ì£¼ì?¸ì??");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.pwd.value != document.regForm.repwd.value){
		alert("ë¹?ë°?ë²??¸ê? ?¼ì???ì§? ???µë????.");
		document.regForm.repwd.focus();
		return;
	}
	if(document.regForm.name.value==""){
		alert("?´ë??? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.name.focus();
		return;
	}
	
	
	if(document.regForm.birthday.value==""){
		alert("???????¼ë?? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.birthday.focus();
		return;
	}

	
	if(document.regForm.email.value==""){
		alert("?´ë??¼ì?? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.email.focus();
		return;
	}
		if(document.regForm.address.value==""){
		alert("ì£¼ì??ë¥? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.address.focus();
		return;
	}
	if(document.regForm.petName.value==""){
		alert("ê³????´ì?´ë??? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.petName.focus();
		return;
	}
	
	if(document.regForm.petAge.value==""){
		alert("ê³????´ë???´ë?? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.petAge.focus();
		return;
	}
	if(document.regForm.petGender.value==""){
		alert("ê³????´ì?±ë??? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.petGender.focus();
		return;
	}
	if(document.regForm.petBreed.value==""){
		alert("ê³????´í??ì¢??? ???¥í?? ì£¼ì?¸ì??.");
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
          alert('E-mailì£¼ì?? ?????? ??ëª»ë?????µë????.\n\r?¤ì?? ???¥í?? ì£¼ì?¸ì??!');
	      document.regForm.email.focus();
		  return;
    }

	
	document.regForm.submit();
}


function idCheck(id){
	if(id == ""){
		alert("???´ë??ë¥? ???¥í?? ì£¼ì?¸ì??.");
		document.regForm.id.focus();
	}else{
		url="idCheck.jsp?id=" + id;
		window.open(url,"post","width=300,height=150");
	}
}

function id_search() { 
	 	var frm = document.idfindscreen;

	 	if (frm.name.value.length < 1) {
		  alert("?´ë??? ???¥í?´ì£¼?¸ì??");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("?¸ë???°ë??¸ë?? ??????ê²? ???¥í?´ì£¼?¸ì??");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "findIdResult.jsp"; //???´ê???ë©?
	 frm.submit();  
	 }
	  function pw_search(){

  var frm=document.pwfindscreen;

  if(frm.mid.value.length<1){
   alert("???´ë??ë¥? ?¬ë?ë¥´ê? ???¥í?´ì£¼?¸ì??");
   return;
  }

   if (frm.phone.value.length != 11) {
			  alert("?¸ë???°ë??¸ë?? ??????ê²? ???¥í?´ì£¼?¸ì??");
			  return;
		 }
	
  frm.method="post";
  frm.action="findPwResult.jsp"; //???´ê???ë©?
  frm.submit(); 
  }


function win_close(){
	self.close();
}
