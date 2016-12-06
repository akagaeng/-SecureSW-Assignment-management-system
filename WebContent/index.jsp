<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*,java.util.*,java.text.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>

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
<div id="body_center">
			<div align="center"><img src="images/main_image.jpg" align="middle" width="800"></div>
			<div id="login" align="center">
            
            <p></p>
            
<!-- 로그인폼 시작-->
        <div>
        
<%	if(session.getAttribute("userid") == null){ //numm: 로그인 안된경우 
%>

<script type="text/javascript">	
var reg_id = /^[a-zA-Z0-9_]{1,15}$/; //아이디: 5~15자 영문소문자, 숫자, 특수문자 _ 사용가능
var reg_pw = /^[a-zA-Z0-9_!@#$%^*+=-]{1,15}$/; //아이디: 5~15자 영문소문자, 숫자, 특수문자 _ 사용가능
//var reg_pw = /^[a-zA-Z0-9!@#$%^*+=-].{1,20}$/; //비밀번호: 5~20자 

function focusIt(){	document.inform.id.focus();	}
	
function checkIt()
{
	var failmsg="";
	inputForm=eval("document.inform");	//아이디 또는 비밀번호가 입력되지 않은 경우
	if(!inputForm.id.value || !inputForm.pw.value){
		alert("아이디 또는 비밀번호가 입력되지 않았습니다.");
		inputForm.id.focus();
		return false;
	}
	
	if(!reg_id.test(inputForm.id.value)) {
		alert("유효한 아이디 문자만 입력하세요.");
		inputForm.id.focus();
		return false;
	} 
	if(!reg_pw.test(inputForm.pw.value)) {
		alert("유효한 비밀번호 문자만 입력하세요.");
		inputForm.id.focus();
		return false;
	} 

}


</script>

<center><body onLoad="focusIt()">
 
        <Form method="POST" name="inform" AUTOCOMPLETE="off" action="login.jsp" onSubmit="return checkIt();">
        <p>&nbsp;</p>
        <table>
        <tr>
            <td>학번 (ID) :</td>
            <td><input type="text" name="id"></td>
        </tr>
        <tr>
        	<td>비밀번호 :</td> 
            <td><input type="password" name="pw"></td>
		</tr>
        </table>
        <br />
        
              <input type="submit" value="로그인">
         	  <input type="button" value="회원가입" onClick="javascript:window.location='terms.jsp'">
        </form></center>
        
<%	}	//로그인 안된경우 종료

	else{ //로그인이 된 경우 
	
		 
		//String id = (String)request.getAttribute("id");
		//request.setAttribute("id",id);
        
		%>
		
		<%=session.getAttribute("student_no")+" "%><%=session.getAttribute("name")%>(<%=session.getAttribute("userid")%>) [<%=session.getAttribute("position")%>]님 로그인되었습니다.<br>
		<!-- 
		총 학생 수(total_no): <%=session.getAttribute("total_no")%><br>
		학번(student_no): <%=session.getAttribute("student_no")%><br>
		교수인지(prof): <%=session.getAttribute("prof")%><br>
		지위(position): <%=session.getAttribute("position")%><br>
		이메일(email): <%=session.getAttribute("email")%><br>
		전화번호(phone): <%=session.getAttribute("phone")%><br>
		
		가입날짜: <%=session.getAttribute("register_date")%><br>
		패스워드 수정 날짜: <%=session.getAttribute("password_changed_date")%><br>
				
		오늘날짜: <%=session.getAttribute("dateString")%><br><br>
		
		세션 ID: <%=session.getAttribute("id_str")%><br>
 		웹사이트에 머문 시간: <%=session.getAttribute("time_used")%>분<br>
 		세션의 유효시간: <%=session.getAttribute("inactive")%>분<br><br>
 		 -->
 

<%		
		String now=(String)session.getAttribute("dateString");
		String pwc=(String)session.getAttribute("password_changed_date");
		
		int year_now, month_now, day_now;
		int year_chg, month_chg, day_chg;
		int cha;
		year_now=Integer.parseInt(now.substring(0,4));
		year_chg=Integer.parseInt(pwc.substring(0,4));

		month_now=Integer.parseInt(now.substring(4,6));
		month_chg=Integer.parseInt(pwc.substring(4,6));

		day_now=Integer.parseInt(now.substring(6));
		day_chg=Integer.parseInt(pwc.substring(6));

		
		//총 날 년도 차이*365+월차이*30+일 차이
		cha = (year_now-year_chg)*365+(month_now-month_chg)*30+(day_now-day_chg);
			
		%>
		
		비밀번호 변경한지 <%out.print(cha); %>일 지났습니다.<br><br>
		

		
		 
 
    <form method="post" action="logout.jsp">
        <input type="submit" value="로그아웃">
                <input type="button" value="본인정보관리" onClick="javascript:window.location='member_modify.jsp'"> 
        	        
        <input type="button" value="과제정보관리" onClick="javascript:window.location='board_list.jsp'">
	<%
	   String profSession = session.getAttribute("prof").toString() ;

	   if(profSession.equals("a")) { 
	      //response.sendRedirect("member_admin.jsp");
        	        %><input type="button" value="회원관리" onClick="javascript:window.location='member_admin.jsp'"> <%
	    } else  {
	      //response.sendRedirect("member_modify.jsp");
	    }
        %>
        		<%
		if(cha>=30){
		%>
		<script>alert('비밀번호를 변경한지 30일이 지났습니다.\n비밀번호를 변경하여주세요')</script>
		<%}%>
    </form>
    
    		 		    <%//세션 생성시간 체크
		    long lasttime=session.getLastAccessedTime();
		    session.setAttribute("lasttime", lasttime);
		    long createdtime=session.getCreationTime();
		    session.setAttribute("createdtime",createdtime);
		    long time_used=(lasttime-createdtime)/60000;///60000; /1000하면 초단위로 나옴. 테스트때는 1000정도로 해서 테스트 
		    session.setAttribute("time_used",time_used);
		    if(time_used>10){//로그인한지 10분이 지난 경우
		    %><script>alert("로그인한지 10분이 지났습니다.\n다시 로그인해주세요.");
		    location.href="logout.jsp";</script><%}
		    else{%>
		    <!--세션 생성 시간: <%=session.getAttribute("createdtime")%><br>
	 		세션에 마지막 접근한 시간: <%=session.getAttribute("lasttime")%>분<br>
	 		웹사이트에 머문 시간: <%=session.getAttribute("time_used")%>분<br>
	 		-->
	 		<%}%>
	 		
       
   
       
   
	  </div>
    </div>
</div>
<!-- 로그인폼 끝-->

    <div id="footer_left" style="background-color:#FFFFFF;height:100px;width:50%;float:left;">
    </div> 


   	<div id="footer_right" style="background-color:#FFFFFF;height:100px;width:50%;float:left;">
    </div> 
</div>
</body>
</html>

		    
<%}%>