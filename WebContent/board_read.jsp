<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css">
<title>아주대학교 소프트웨어 특성화대학원 과제관리시스템</title>
</head>


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
	String id=(String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String student_no = (String)session.getAttribute("student_no");
	String professor_no ="201599901";
	char prof= (char)session.getAttribute("prof");

	int assignment_no=0; //과제 넘버
    String assignment_writer = "박신혜";
	if(request.getParameter("assignment_no")!=null) { //받아온 과제 넘버가 있을때
		assignment_no = Integer.parseInt(request.getParameter("assignment_no")); // 과제 넘버값을 저장
	}

	//과제 넘버에 해당하는 내용 db에서 읽어오기
	String title="";
	String content="";
	String date="";
	String real_file_name="";
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from assignment where assignment_no= '" + assignment_no +"' and prof= 'y'");
		
		while(rs.next()){
			
			title = rs.getString(4);
			content = rs.getString(5);
			date = rs.getString(9);
		}
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	String prof_fileName="";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st2 = con2.createStatement();
		ResultSet rs2;
		rs2 = st2.executeQuery("select * from data_list where board_no='"+ assignment_no+"'"+" and user_no='" + professor_no + "'");
	
		if(rs2.next()){	prof_fileName=rs2.getString(3);	}
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	

	String submit_title="null";
	String submit_content="";
	String submit_date="";
	String grade="";
	

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from assignment where assignment_no= '" + assignment_no +"' and student_no= '" + student_no + "'");
	
		if(rs.next()){
			
			submit_title = rs.getString(4);
			submit_content = rs.getString(5);
			grade = rs.getString(6);
			submit_date = rs.getString(9);
		}
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	String student_fileName="";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st2 = con2.createStatement();
		ResultSet rs2;
		rs2 = st2.executeQuery("select * from data_list where board_no='" + assignment_no +"' and user_no='" + student_no + "'");
	
		if(rs2.next()){	
			student_fileName=rs2.getString(2);
			real_file_name=rs2.getString(3);
		}
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	



%>          



<div id="body" style="width:100%;float:left;">
	<div id="body_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>
        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: <%=(int)session.getAttribute("total_no")%>명</li>
	  </ul>
    </div> 
	<div id="body_left" style="height:500px;width:20%;float:left;"></div>
	<div id="body_right" style="background-color:#FFFFFF;height:500px;width:60%;float:left;">
		<table align="center"><tr><td><h3> 과제 내용</h3></td></tr></table><br />
		<table align="center" class="tableform">
	    <thead>
	    <tr>
	        <th scope="col">과제 No.</th>
	        <th scope="col">제목</th>
	        <th scope="col">작성자</th>
	        <th scope="col">작성일</th>
	        <th scope="col">파일</th>
	    </tr>
	    </thead>

	    <tbody>
	    <tr>
	        <td scope="row"><%=assignment_no%></th>
			<td scope="row"><%=title%></td>
			<td scope="row"><%=assignment_writer%></td>
			<td scope="row"><%=date%></td>
			<td scope="row"><a href="http://210.107.197.133:8080/secure/upload/<%=prof_fileName%>" target="_blank"><%=prof_fileName%></td>
				
			
	    </tr>
        </tbody>

		<tr>
			<td colspan="5" height="200px">
            	<div id="content">
                    <p><%=content%></p>
                    <p>&nbsp;</p>
				</div>
            </td>
		</tr>

<%
//조건문 이미 제출했을 때 기존 파일 뜨게하고 옆에 삭제버튼
//아직 제출 안했을 때 버튼 누르면 첨부 제출되게

%>
<%
	if(prof == 'n'){	//학생인 경우 시작
	//제출 누르면 파일 디비에 저장(업데이트)
	//취소 누르면 저장 없이 본래 화면으로 
	//제출 내용 제출한거 있을때만 읽어오기 시작
	if(submit_title.equals("null")){}
	else{%>
		<table align="center"><tr><td><h3> 제출한 과제</h3></td></tr></table><br />

		<table align="center" class="tableform_blue">
	    <thead>
	    <tr>
	        <th scope="col">No.</th>
	        <th scope="col">과제명</th>
	        <th scope="col">제출자</th>
	        <th scope="col">작성일</th>
	        <th scope="col">파일</th>
	    </tr>
	    </thead>


	    <tbody>
	    <tr>
	        <td><%=assignment_no%></td>
	        <td><%=submit_title%></td>
			<td><%=name%></td>
			<td><%=submit_date%></td>
			<td><a href="http://210.107.197.133:8080/secure/upload/<%=real_file_name%>" target="_blank"><%=student_fileName%></td>
		</tr>
        </tbody>

		<tr>
			<td colspan="5">
            	<div id="content">
                    <p><%=submit_content%></p>
                    <p></p>
				</div>
            </td>
		</tr>	
        </table>
        
        <%}//제출 내용 제출한거 있을때만 읽어오기 종료
		//제출 내용 없을 때에도 기본적으로 출력할 부분
		%>

		<table align="center" class="table_noline">
        <tr>
		<td></td><td></td><td></td><td></td>
        </tr>

        <tr>
        <td colspan="2">
        	점수: 
			<%
				if(grade.equals("")){%>미입력<%}
				else{%> <%=grade%> <%
						}%>

		</td>
		
        <td colspan="2">

        <form>
		<input type="button" value="과제 목록으로" onClick="javascript:window.location='board_list.jsp'">
		<%if(prof == 'y' || prof == 'a'){%>
		<input type="button" value="과제 수정" onClick="javascript:window.location='board_modify.jsp?assignment_no=<%=assignment_no%>'">
		 <%}%>
		<input type="button" value="과제 제출하기" onClick="parent.location.href='write_index.jsp?assignment_no=<%=assignment_no%>'">
		</form><br /><br /><br /><br />
		</td>
        </tr><br /><br /><br /><br />
        <%//학생인 경우 종료
		
	}
	
	else if(prof == 'y' || prof == 'a'){//교수 또는 관리자인 경우 시작
%>
	    <table align="center" class="table_noline">
        <tr>
		<td></td><td></td><td></td><td></td>
        </tr>

        <tr>
        <td colspan="2"></td>
        <td colspan="2">
        <form >
		<input type="button" value="과제 목록으로" onClick="javascript:window.location='board_list.jsp'">
        <input type="button" value="내용 수정" onClick="javascript:window.location='board_modify.jsp?assignment_no=<%=assignment_no%>'">
        <input type="button" value="제출된 과제 확인" onClick="parent.location.href='grading.jsp?assignment_no=<%=assignment_no%>'">
    	</form>
        </td>
        </tr>
        </table>
        

  	    <br>
   	    <br>

<%
	}
	
%>
	
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