<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*,java.util.*,java.text.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
//String id_checked = request.getParameter("get_id");
String get_id="";
%>

<%
	//로그인 된 상태라면 접근금지 
	String user_id= (String)session.getAttribute("userid");
	if(user_id!=null) {
		response.sendRedirect("index.jsp");
	}
	String term_val= (String)session.getAttribute("term");
	if(term_val == null) {
		response.sendRedirect("index.jsp");
	}
%>

<script type="text/javascript">	
//정규표현식
var reg_id = /^[a-z0-9_]{5,15}$/; //아이디: 5~15자 영문소문자, 숫자, 특수문자 _ 사용가능
var reg_pw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,20}$/; //비밀번호: 5~20자 영문대소문자, 숫자, 특수문자 혼합하여 사용
var reg_number = /^[0-9]{4,10}$/; //학번: 숫자 4~10자 사용가능.
var reg_email = /^[0-9a-zA-Z_\-]+@[0-9a-zA-Z_-]+(\.[0-9a-zA-Z_\-]+)*$/; //이메일: 유효한 이메일주소를 넣어주세요.
var reg_phone = /^\d{2,3}\-\d{3,4}\-\d{4}$/; //전화번호: 유효한 전화번호를 넣어주세요.

var var_id="";
//var flag_idcheck=false;
var result_idcheck=false;
var retString="";

function check_joinform()
{
	inputJoinform=eval("document.join_form");	
	var failmsg="";
	retString = validId(inputJoinform.id_text.value) + validpw(inputJoinform.mem_pass.value, inputJoinform.mem_passChk.value) +
		validnumber(inputJoinform.mem_number.value) + validemail(inputJoinform.mem_email.value) + 
		validphone(inputJoinform.mem_phone01.value, inputJoinform.mem_phone02.value, inputJoinform.mem_phone03.value);

/*	if(!inputJoinform.id.value 					//빈칸이 있는지 체크
	   || !inputJoinform.mem_pass.value 
	   || !inputJoinform.mem_passChk.value 
	   || !inputJoinform.mem_name.value 
	   || !inputJoinform.mem_number.value 
	   || !inputJoinform.mem_email.value
	   || !inputJoinform.mem_phone01.value
	   || !inputJoinform.mem_phone02.value
	   || !inputJoinform.mem_phone03.value)
*/
	if(retString=="") { //모든 항목이 입력된 경우
		if(result_idcheck==false) {
			alert("아이디 중복확인을 수행해주세요.");
		}
		else{
			return true;
		}	//모든 항목 체크 완료. join_process.jsp로 이동.

		return false;
	}
	else {
		alert(retString);
		return false;
	}
}
function check_id() {
	//alert("중복아이디 체크.");
	var_id = document.getElementById("id_text").value;
	
	//if(var_id==""){ //id값이 없을 경우
	retString = validId(var_id);
	if(retString == "") {
		document.getElementById("hidden_id").value= var_id;
		frm.target = "por"; // iframe의 이름
		frm.action = "join_IDcheck.jsp";
		frm.submit();		
	} else {
		//alert(retString);         //메세지 경고창을 띄운 후
		document.getElementById("id_text").focus();     // id 텍스트박스에 커서를 위치
		return retString;
	}
	return "";
}
function check_id_result(result) {
	//ID Check 결과가 저장됨
	result_idcheck = result;
	if(result_idcheck==true) {	//아이디 중복 
		alert("사용 가능한 아이디입니다.");
	} else {
		alert("이미 중복된 아이디가 존재합니다.");
	}
}

function validId(field) {
	if(!reg_id.test(field)) {
		return "아이디: 5~15자 영문소문자, 숫자, 특수문자 _ 사용가능\n\r";
	}
	return "";
}
function validpw(field1, field2) {
	if(field1 != field2) { //비밀번호 입력한 내용과 비밀번호Chk에 입력한 내용이 같은지 체크
		return "비밀번호와 비밀번호 확인의 내용이 다릅니다.\n\r";
	} else if(!reg_pw.test(field1)) {
		return "비밀번호: 5~20자 영문대소문자, 숫자, 특수문자 혼합하여 사용\n\r";
	}
	return "";
}
function validnumber(field) {
	if(!reg_number.test(field)) {
		return "학번: 숫자 4~10자 사용가능.\n\r";
	}
	return "";
}
function validemail(field) {
	if(!reg_email.test(field)) {
		return "이메일: 유효한 이메일주소를 넣어주세요..\n\r";
	}
	return "";
}
function validphone(field1, field2, field3) {
	if(!reg_phone.test(field1+'-'+field2+'-'+field3)) {
		return "전화번호: 유효한 전화번호를 넣어주세요.\n\r";
	}
	return "";
}

</script>


<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css">
<title>아주대학교 소프트웨어 특성화대학원 과제관리시스템</title>
</head>

<body>
<div id="container" style="width:100%">

<div id="header" style="width:100%">
	<div id="header_left" style="background-color:#ffffff; width:30%;height:130px; float:left">
		<div align="left"><a href="index.jsp"><img style="margin: 3px;" src="images/aj_logo.png" alt="아주대학교 소프트웨어 특성화대학원"></a>
	  </div>
	</div>	<!-- header_left div 종료-->

   	<div id="header_center" style="background-color:#ffffff; width:40%; height:130px;float:left">
    </div>	<!-- header_center div 종료-->

  	<div id="header_right" style="background-color:#ffffff; width:30%;height:130px; float:left">
		<div align="center"><a href="index.jsp"><img style="margin: 3px;" src="images/logo_right.png" alt="과제관리시스템"></a>
	      </div>
  	</div>	<!-- header_right div 종료-->
</div><!-- header div 종료-->

<div id="body" style="width:100%;float:left;">
  <div id="body_left" style="background-color:#FFFFFF;height:400px;width:20%;float:left; text-align:left;"> </div> 
  <!-- body_left 비율 20->10%로 조정 / body_center 비율 70 ->80%로 조정_Hyesun -->

	<div id="body_center" style="background-color:#FFFFFF;height:400px;width:60%;float:left;">
	            <div class="content">
				<div class="sub_title">
					<h3>회원가입</h3>
				</div>
				</div>
                
 <!-- 아래 form 추가_시작_Hyesun -->              
 
                
<form method="post" action="join_process.jsp" name="join_form" autocomplete="off" onSubmit="return check_joinform()">	<!-- enctype="multipart/form-data" 이 옵션 있어서 db에 자료가 null로 꼐속 들어갔었다는 ㅠㅠ(gaeng) -->

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="right" colspan="2" style="padding:5px;"><span style="font-weight:bold;">별표시(<span style="color:#ff0000">*</span>)는 필수 입력사항입니다.</td>
	</tr>
	<tr bgcolor="#444;"><td height="2" colspan="2"></td></tr>
	<tr>
		<td width="210" height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>아이디</strong> <span style="color:#ff0000">*</span></td>
		<td width="923" bgcolor="#FFFFFF" style="padding-left:10px;">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<!--<form name="idCheck" method="post"action="join_IDcheck.jsp">-->
					<td width="160"><input type="text" name="id_text" id="id_text" style="width:150; height:19px; border:1px solid #ddd;"  value=""></td>
					<!--</form>-->
					<td width="100"><div align="left"><input type="button" value="중복확인" onClick="check_id();"></div></td>
					<!--"javascript:window.location='join_IDcheck.jsp'"-->
					<td><span id="join_id_result">[영문/숫자 5자이상 15자이하입니다]</span></td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr bgcolor="#EBEBEB"><td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>성명</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
					<input type="text" name="mem_name" value="" style="width:150; height:19px; border:1px solid #ddd;">
					<!--onBlur="fill_nickname(this.value);">-->
					</td>
	</tr>
   <!-- 학번추가_Hyesun-->  
    <tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>학번</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
		<input type="text" name="mem_number" value="" style="width:150; height:19px; border:1px solid #ddd;" >
		<!--onBlur="fill_hakbun(this.value);">-->
		</td>
                    
	</tr>  <!-- 학번추가_Hyesun-->
    
    
	<tr bgcolor="#EBEBEB"><td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>비밀번호</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
			<input type="password" name="mem_pass" style="width:50%; height:19px; background-color:#ffffff; border:1px solid #ddd; margin-top:5px;" maxlength="20">
			<!-- onBlur="CheckPASS(this);"> -->
			<br><span id="join_pass_result">[영문+숫자+특수문자 5자 이상 ~ 20자 이하입니다]</span>
		</td>
	</tr>
	<tr bgcolor="#EBEBEB"><td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>비밀번호 확인</span> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;"><input type="password" name="mem_passChk" style="width:50%;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength="20">
		</td>
	</tr>
	<tr bgcolor="#EBEBEB"><td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>이메일</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;"><table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td width="320"><input type="text" name="mem_email" value="" style="width:300px;  height:19px; background-color:#ffffff; border:1px solid #ddd;">
				<!-- onBlur="CheckEmail(this);">-->
				</td>
				<td><span id="join_email_result"></span></td>
			</tr>
		</table></td>
	</tr>
	<tr bgcolor="#EBEBEB"> <td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>휴대폰</strong><span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
			<input type="text" name="mem_phone01" value="" style="width:30;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength=3> -
			<input type="text" name="mem_phone02" value="" style="width:30;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength=4> -
			<input type="text" name="mem_phone03" value="" style="width:30;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength=4>
		</td>
	</tr>
    
 
</table>
<table align="center">
	<tr>
		<!--<td height=50>
			<input type=image src="/btn/btn_ok.gif" border=0 style="border:0px;">
            
		</td> -->
          <td><div align="center"><input type="submit" value="확인" font width="63" height="25" border="0"> <input type="button" value="돌아가기" onClick="javascript:window.location='terms.jsp'"></div></td>
	</tr>
</table>

</form>

      <!-- 위의 form 추가_끝_Hyesun -->        
                
	  
    </div> 
    
</div>


<!--POST로 중복ID를 체크하기 위한 숨은 IFrame-->
<iframe width=800 name="por" width="0" height="0" frameborder="0" scrolling="no"></iframe>
<form name="frm" method="post" action="">
<script type="text/javascript">	
</script>
<input type="hidden" name="check_id" id="hidden_id" value="ttest">

</form>

    <!-- 아래 footer 제거_끝_Hyesun -->  

<!--<div id="footer" style="width:100%; float:left; text-align:center;">
	<div id="footer_left" style="background-color:#FFFFFF;height:100px;width:10%;float:left;">
    	학생용
    </div> 

    <div id="footer_center" style="background-color:#FFFFFF;height:100px;width:80%;float:left;">
    </div> 

   	<div id="footer_right" style="background-color:#FFFFFF;height:100px;width:10%;float:left;">
    </div> 
</div>  -->
</body>
</html>


