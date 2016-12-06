<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@page import="ServiceManager.AES256Cipher"%> 
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
		<a href="index.jsp"><img style="margin: 3px;" src="images/aj_logo.png" alt="아주대학교 소프트웨어 특성화대학원"></a>
  </div>	<!-- header_left div 종료-->

  <div id="header_center" style="background-color:#ffffff; width:40%; height:130px;float:left">
    <div align="center"><a href="index.jsp"><br>
      <img style="margin: 3px;" src="images/logo_right.png" alt="과제관리시스템" ></a>
      </div>
  </div>	<!-- header_center div 종료-->

  <div id="header_right" style="background-color:#ffffff; width:30%;height:130px; float:left"> <br>
    <table width="280" height="100" align="center" cellpadding="0" cellspacing="0">
 
  <tr>
    <td><p align="center">
      		
			<%=session.getAttribute("student_no")+" "%><%=session.getAttribute("name")%>(<%=session.getAttribute("userid")%>)님<%=" ["+session.getAttribute("position")+"]"%><br>


      </td>
  </tr>
  <tr>
    <td>
    	<div align="center">
    	  <input type="button" value="첫페이지로" onClick="javascript:window.location='index.jsp'">
    	  <input type="button" value="회원정보관리" onClick="javascript:window.location='member_modify.jsp'">
    	  <input type="button" value="로그아웃" onClick="javascript:window.location='logout.jsp'">
  	  </div></td>
  </tr>
</table>
        
       
  </div>	
  <!-- header_right div 종료-->
</div><!-- header div 종료-->

<%

    	AES256Cipher a256 = AES256Cipher.getInstance();
	//JDBC 드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");   

	//초기화
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;

	String cur_id="";
	String cur_no="";
	//String id = rs.getString("id");
	String cur_name="";
	String cur_student_no="";
	String cur_prof="";
	String cur_email="";
	String cur_phone="";
	String array_phone[]={"","",""};
	
	String enuserid="";
	String descur_id="";
	String descur_name="";
	String descur_student_no="";
	String descur_email="";
	String descur_phone="";

	

    try{
      String jdbcDriver = "jdbc:mysql://localhost:3306/secure";
      String dbUser = "root";
      String dbPass = "1";
      
      String query1 = "select * from member";
      String userid  = session.getAttribute("userid").toString();
      enuserid=a256.AES_Encode(userid);
      String query2= " where id='" + enuserid  + "'";
      //String query2= " where id='" + enuserid + "' and pw='" + passwd + "'";

    //데이터베이스 커넥션 생성
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

    //Statement 생성
    stmt = conn.createStatement();

    //쿼리 실행
      rs = stmt.executeQuery(query1);
    
      int total_no = rs.getRow();
    
      rs = stmt.executeQuery(query1+query2);
      //rs = stmt.executeQuery(query1);      

      //if (rs!=null) {  //아이디와 비밀번호 일치하는 경우: re.next()는 ResultSet에서 select의 값이 존재하는 경우 true를 리턴하고, 존재하지 않는 경우에는 false를 리턴한다.
      while(rs.next()) {
        String id_str=session.getId();
         //세션에 마지막으로 엑세스한 시간을 되돌려준다.
        long lasttime=session.getLastAccessedTime();
         //세션이 생성된 시간을 되돌려 준다.
        long createdtime=session.getCreationTime();
         //세션에 마지막으로 엑세스한 시간에서 세션이  생성된 시간을 빼면
        //웹사이트에 머문시간이 계산된다.
        long time_used=(lasttime-createdtime)/60000;
         //세션의 유효시간 얻어오기
        int inactive=session.getMaxInactiveInterval()/60;
         //세션이 새로 만들어졌는지 알려 준다.
        boolean b_new=session.isNew();
         
                
          cur_id = rs.getString("id");
          cur_no = rs.getString("no");
          //String id = rs.getString("id");
          cur_name = rs.getString("name");
          cur_student_no = rs.getString("student_no");
          cur_prof = rs.getString("prof");
          cur_email=rs.getString("email");
          cur_phone=rs.getString("phone");
          


	  descur_id = a256.AES_Decode(cur_id);
	  descur_name= a256.AES_Decode(cur_name);
	  descur_student_no = a256.AES_Decode(cur_student_no);
	  descur_email = a256.AES_Decode(cur_email);
	  descur_phone = a256.AES_Decode(cur_phone);
	  array_phone= descur_phone.split("-");
/*
	out.print("cur_id=("+descur_id+")\n");
	out.print("cur_name=("+descur_name+")\n");
	out.print("cur_email=("+descur_email+")\n");
	out.print("cur_phone=("+descur_phone+")\n"+array_phone[0]+array_phone[1]+array_phone[2]);
	out.print("query2=("+query2+")\n");
*/	
      }
    }//try 종료
    
    catch(SQLException ex){%><script>alert("SQL Exception occurred"+query2);history.go(-1);</script><%}  //SQL 에러 발생시
      
    finally{
  
        //사용한 statement 종료
        if(rs!=null){ try{ rs.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred"+query2);history.go(-1);</script><%}}
        if(stmt!=null){ try{ stmt.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred"+query2);history.go(-1);</script><%}}
        //커넥션 종료
        if(conn!=null){ try{ conn.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred"+query2);history.go(-1);</script><%}}
    }
%>



<script type="text/javascript">	

function check_joinform()
{
	inputJoinform=eval("document.join_form");	
	if(!inputJoinform.id_text.value 					//빈칸이 있는지 체크
	   || !inputJoinform.mem_pass.value 
	   || !inputJoinform.mem_passChk.value 
	   || !inputJoinform.mem_name.value 
	   || !inputJoinform.mem_number.value 
	   || !inputJoinform.mem_email.value
	   || !inputJoinform.mem_phone01.value
	   || !inputJoinform.mem_phone02.value
	   || !inputJoinform.mem_phone03.value)
	{
		alert("입력되지 않은 항목이 있습니다.");
		return false;
	}
	
	else{	//모든 항목이 입력된 경우
		if(inputJoinform.mem_pass.value !=	inputJoinform.mem_passChk.value) //비밀번호 입력한 내용과 비밀번호Chk에 입력한 내용이 같은지 체크
		{
			alert("비밀번호와 비밀번호 확인의 내용이 다릅니다.");
		return false;
		}
		else{}	//모든 항목 체크 완료. join_process.jsp로 이동.
	
	}
}
</script>



<div id="body" style="width:100%;float:left;">
  <div id="body_left" style="background-color:#FFFFFF;height:400px;width:20%;float:left; text-align:left;"> </div> 
  <!-- body_left 비율 20->10%로 조정 / body_center 비율 70 ->80%로 조정_Hyesun -->

	<div id="body_center" style="background-color:#FFFFFF;height:400px;width:60%;float:left;">
	            <div class="content">
				<div class="sub_title">
					<table align="center"><tr><td><h3>회원정보 관리</h3></td></tr></table>
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
		<td width="116" height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>아이디</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>

					<td width="200"><input type="text" name="id_text" style="width:150; height:19px; border:1px solid #ddd;"  value=<%out.print(descur_id);%>                    onblur='CheckID(this);' readonly="readonly"></td>
					<td><span id="join_id_result">[영문/숫자 5자이상 15자이하입니다]</span></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="#EBEBEB"><td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>성명</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
					<input type="text" name="mem_name" value=<%out.print(descur_name);%> style="width:150; height:19px; border:1px solid #ddd;" onBlur="fill_nickname(this.value);" readonly="readonly">
					</td>
	</tr>
   <!-- 학번추가_Hyesun-->  
    <tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>학번</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
		<input type="text" name="mem_number" value=<%out.print(descur_student_no);%> style="width:150; height:19px; border:1px solid #ddd;" onBlur="fill_hakbun(this.value);" readonly="readonly">
		</td>
	</tr>  <!-- 학번추가_Hyesun-->
    
    
	<tr bgcolor="#EBEBEB"><td height="1" colspan="2"></td></tr>
	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>비밀번호</strong> <span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
			<input type="password" name="mem_pass" style="width:50%; height:19px; background-color:#ffffff; border:1px solid #ddd; margin-top:5px;" maxlength="20" onChange="CheckPASS(this);"> 
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
				<td width="320"><input type="text" name="mem_email" value=<%out.print(descur_email);%> style="width:300px;  height:19px; background-color:#ffffff; border:1px solid #ddd;" onBlur="desCheckEmail(this);"></td>
				<td><span id="join_email_result"></span></td>
			</tr>
		</table></td>
	</tr>
	<tr bgcolor="#EBEBEB"> <td height="1" colspan="2"></td></tr>

	<tr>
		<td height="40" bgcolor="#f1f1f1" style="padding-left:20px; color:#444;"><strong>휴대폰</strong><span style="color:#ff0000">*</span></td>
		<td bgcolor="#FFFFFF" style="padding-left:10px;">
			<input type="text" name="mem_phone01" value=<%out.print(array_phone[0]);%>  style="width:30;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength=3> -
			<input type="text" name="mem_phone02" value=<%out.print(array_phone[1]);%>  style="width:30;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength=4> -
			<input type="text" name="mem_phone03" value=<%out.print(array_phone[2]);%>  style="width:30;  height:19px; background-color:#ffffff; border:1px solid #ddd;" maxlength=4>
		</td>
	</tr>
    
    
</table>



<table align="center">
	<tr>
		<!--<td height=50>
			<input type=image src="/btn/btn_ok.gif" border=0 style="border:0px;">
            
		</td> -->
          <td><div align="center">
          	<input type="submit" value="확인" font width="63" height="25" border="0">
 		<input type="button" value="돌아가기" onClick="javascript:window.location='index.jsp'">
          </div></td>
	</tr>
</table>

</form>

      <!-- 위의 form 추가_끝_Hyesun -->        
                
	  
    </div> 
    
</div>
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

</body>
</html>
