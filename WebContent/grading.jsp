<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*" %>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>  
<%@page import="Class.Assignment"%> 
<%@ page import="org.apache.commons.net.ftp.FTP"%>
<%@ page import="org.apache.commons.net.ftp.FTPClient"%>
<%@ page import="org.apache.commons.net.ftp.FTPReply"%>
<%@ page import="org.apache.commons.net.ftp.FTPFile"%>
<%@ page import="org.apache.commons.net.ftp.FTPListParseEngine"%>

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
		<a href="index.jsp"><img style="margin: 3px;" src="images/aj_logo.png" alt="아주대학교 소프트웨어 특성화대학원"></a>
  </div>	<!-- header_left div 종료-->

  <div id="header_center" style="background-color:#ffffff; width:40%; height:130px;float:left">
    <div align="center"><a href="index.jsp"><br>
      <img style="margin: 3px;" src="images/logo_right.png" alt="과제관리시스템" ></a>
      </div>
  </div>	<!-- header_center div 종료-->

  <div id="header_right" style="background-color:#ffffff; width:30%;height:120px; float:left"> <br>
    <table width="280" height="100" align="center" cellpadding="0" cellspacing="0">
 
  <tr>
    <td><p align="center">
      		
			<%=session.getAttribute("student_no")+" "%><%=session.getAttribute("name")%>(<%=session.getAttribute("userid")+"님"%>)<%=" ["+session.getAttribute("position")+"]"%><br>


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

<SCRIPT LANGUAGE="JavaScript">
<!--
function openPop(url)
{
    window.open(url, "startpop", "width=400, height=300, scrollbars=no, resizable=no ,status=no ,toolbar=no");
}
//-->
</SCRIPT>
<body>
<%
	String FTPServer ="210.107.197.133";
	int FTPport = 21;
	String FTPid = "upload";
	String FTPpw = "1";
	String id=(String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	char prof= (char)session.getAttribute("prof");
	FTPClient ftpClient = new FTPClient();
	ftpClient.connect(FTPServer, FTPport);
	ftpClient.login(FTPid, FTPpw);
%>
   

<%
	int assignment_no=0; //과제 넘버
	if(request.getParameter("assignment_no")!=null) { //받아온 과제 넘버가 있을때
		assignment_no = Integer.parseInt(request.getParameter("assignment_no")); // 과제 넘버값을 저장
	}
   
	ArrayList<Assignment> result = new ArrayList<Assignment>();
	result.clear();
	String user_id = (String)session.getAttribute("id");
	int sub_no = 0;
	String student_no= "";
	int assignment_page = 1;
    String title="";
    String grade="";
	String date="";
	String new_file_name="";
	String print_file_name="";
	String query="";
	Statement stmt;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from assignment where assignment_no= '" + assignment_no +"' and prof= 'n' ORDER BY submit_no ASC");

		while(rs.next()){
			sub_no++;
			student_no=Integer.toString(rs.getInt(2));
			title = rs.getString(4);
			grade = rs.getString(6);
			date = rs.getString(9);
			assignment_page = 1 + (sub_no-1)/5;
			//result.add(new Assignment(assignment_page, sub_no, student_no, title, date, ""));
			result.add(new Assignment(assignment_page, sub_no, student_no, title, date, grade));
		}	
    } catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	final int ROWSIZE = 5;  // 한페이지에 보일 게시물 수
	final int BLOCK = 10; // 아래에 보일 페이지 최대개수 

	int pg = 1; //기본 페이지값
			
	if(request.getParameter("pg")!=null) { //받아온 pg값이 있을때, 다른페이지일때
		pg = Integer.parseInt(request.getParameter("pg")); // pg값을 저장
	}
			
	int start = (pg*ROWSIZE) - (ROWSIZE-1); // 해당페이지에서 시작번호(step2)
	int end = (pg*ROWSIZE); // 해당페이지에서 끝번호(step2)
	
	int allPage = 0;
	if(result.size() > 0){
		
		allPage = result.get(result.size()-1).getPage(); // 전체 페이지수
	}	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1; // 시작블럭숫자 
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK; // 끝 블럭 숫자 
		
%>


<div id="body" style="width:100%;float:left;">
	<div id="body_upper_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>
        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: <%=(int)session.getAttribute("total_no")%>명</li>
	  </ul>
    </div> 

	<div id="body_left" style="height:500px;width:20%;float:left;"></div>
	<div id="body_center" style="background-color:#FFFFFF;height:;width:60%;float:left;">
		<table align="center"><tr><td><h3>제출된 과제 목록</h3></td></tr></table>
	  <!--					<form name="write" method="post" action="not_yet.jsp">
		  
          <input type="submit" name="write" id="approve" value="글쓰기" style="margin-left:735px">
          
	            </form>
		-->	
        <p></p><br>
      <table class="tableform" align="center">
	    <thead>
	    <tr background: #0080FF;>
	        <th scope="col">No.</th>
	        <th scope="col">과제명</th>
	        <th scope="col">제출자</th>
	        <th scope="col">작성일</th>
	        <th scope="col">파일첨부</th>
	        <th scope="col">점수</th>
	        <th scope="col">입력/수정</th>
	    </tr>
	    </thead>
	    <tbody>
	    <!--<tr>
	     	<td></td>실제로는 디비에 저장된 게시판 내용 읽어서 출력
	    </tr>-->
	    <% for(int i=0; result.size()>i; i++){
	    	if(pg==result.get(i).getPage()){
	    %>
	    <% 		if(i%2 == 0){ %>	
	    <tr>
	        <td scope="row"><%=result.get(i).getSubmit_no()%></td>
			<td><%=result.get(i).getTitle()%></td>
			<td><%=result.get(i).getStudent_name() %></td>
			<td><%=result.get(i).getContent()%></td>
			<%  
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
				Statement st = con.createStatement();
				query = "select * from data_list where user_no="+"'"+ result.get(i).getStudent_name()+"'"+" and board_no="+"'"+assignment_no+"'";
				//.println("result("+i+").getStudent_name() : "+result.get(i).getStudent_name());
				ResultSet rs;
				rs = st.executeQuery(query);
				if(rs.next()){
					print_file_name=rs.getString("file_name");
					new_file_name=rs.getString("new_file_name");
				}
		%>
			<!--<td><a href="ftp://210.107.197.133/=user_id%>/=new_file_name%>">= new_file_name %></td>임시로 아래와 같이 변경해둠 -양 -->
			<td><a href="http://210.107.197.133:8080/secure/upload/<%=new_file_name%>" target="_blank"><%=print_file_name%></a></td>
            <td>
            <%
            if(result.get(i).getGrade().equals("")){ out.print("-"); }
            else{out.print(result.get(i).getGrade());} 
            
            %>
            </td>
            <td><a href="javascript:openPop('sub_grading.jsp?student_no=<%=result.get(i).getStudent_name()%>&assignment_no=<%=assignment_no%>')">
            
            <form><input type="button" value="입력/수정" /></form></a>	
            
            </td>
            
	    </tr>
	    <% 		}
	    
	    		else{
	    %>
	    <tr>
	        <td scope="row" class="even"><%=result.get(i).getSubmit_no()%></td>
		  	<td class="even"><%=result.get(i).getTitle() %></td>
		  	<td class="even"><%=result.get(i).getStudent_name() %></td>
		  	<td class="even"><%=result.get(i).getContent()%></td>
		  	<%  query = "select * from data_list where user_no="+"'"+ result.get(i).getStudent_name()+"'"+" and board_no="+"'"+assignment_no+"'";
		  		Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
				Statement st = con.createStatement();
				ResultSet rs;
				rs = st.executeQuery(query);
				if(rs.next()){
				print_file_name=rs.getString("file_name");
				new_file_name=rs.getString("new_file_name");
				}
		    %>
			<!--<td><a href="ftp://210.107.197.133/=user_id%>/=new_file_name%>">= new_file_name %></td>임시로 아래와 같이 변경해둠 -양 -->
			<td class="even"><a href="http://210.107.197.133:8080/secure/upload/<%=new_file_name%>" target="_blank"><%=print_file_name%></a></td>
			<td class="even">
          	<%
          	if(result.get(i).getGrade().equals("")){ out.print("-");	}
            else{out.print(result.get(i).getGrade());} 
            %>
</td>
			<td class="even"><a href="javascript:openPop('sub_grading.jsp?student_no=<%=result.get(i).getStudent_name()%>&assignment_no=<%=assignment_no%>')"><form><input type="button" value="입력/수정" /></form></a></td>
	    </tr>
	   <%		}
	    	}
	    }%>
        
	    </tbody>
		</table>
        
           	    <br>
   	    <br>
        <table align="center" class="table_noline"><tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
        <td colspan="6"><td colspan="1" align="center"> <input type="button" value="돌아가기" onClick="javascript:history.back()">
      
     </td>
     </tr>
     </table>
     
	 
        <br>
      <br> 
        <br>
        	    	<!-- // NBoard Foot Button -->
	<div id="n-wrap">
	    <div class="n-paging"><ul>
	    <% 
	   		if(pg>BLOCK) {
		%>
	  
			<li><a href="grading.jsp?assignment_no=<%=assignment_no%>&pg=<%=startPage-1%>"><img src="images/btn_paging_prev.gif"><a><em>이전 10 페이지</em></a></li>
		<%
	   		}
	    	if(allPage > 0){
		    	for(int i=startPage; i<= endPage; i++){
		    		if(i==pg){
		%>
		    		<li><a href="grading.jsp?assignment_no=<%=assignment_no%>&pg=<%=i %>" class="selected"><%=i %></a></li>
		<%
		    		}else{
		    			if(i>allPage){
		    				break;
		    			}
		%>		
					<li><a href="grading.jsp?assignment_no=<%=assignment_no%>&pg=<%=i %>"><%=i %></a></li>
		<%
		    		}
		    	}
	    	}
	    	
	    	if(endPage<allPage){
		%>
			<li><a href="grading.jsp?assignment_no=<%=assignment_no%>&pg=<%=endPage+1%>"><img src="images/btn_paging_next.gif"><a><em>다음 10 페이지</em></a></li>
		<%
	    	}
	    	ftpClient.logout();
	    	ftpClient.disconnect();
		%>
			</ul></div>
        

  </div> 
    
</div>
</div>
<div id="footer" style="width:100%; float:left; text-align:center;">
	<div id="footer_left" style="background-color:#FFFFFF;height:100px;width:10%;float:left;">
    </div> 

    <div id="footer_center" style="background-color:#FFFFFF;height:100px;width:80%;float:left;">
    </div> 

   	<div id="footer_right" style="background-color:#FFFFFF;height:100px;width:10%;float:left;">
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
