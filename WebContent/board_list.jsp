<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*" %>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>   
<%@page import="Class.Assignment"%> 

<%request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<head>
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

  <div id="header_right" style="background-color:#ffffff; width:30%;height:120px; float:left"> <br>
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
<body>

<%
	//세션에서 값 가져오기
	String id=(String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	char prof= (char)session.getAttribute("prof");
	String student_no = (String)session.getAttribute("student_no");
	int total_no =(int)session.getAttribute("total_no");
%>

<%	
	//과제 목록 가져오기
   
	ArrayList<Assignment> result = new ArrayList<Assignment>();
	result.clear();
	int assignment_page = 1;
    int assignment_no=0;
	int write_assignment_no=1;
    String assignment_name = "박신혜";
    String title="";
	String date="";
	int count = 0; //제출한 학생수 및 과제 단위 수 카운트
    String tempsubmityn="";//제출여부
    
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from assignment where prof= 'y' ORDER BY submit_no ASC");

		while(rs.next()){
			
			assignment_no=rs.getInt(3);
			title = rs.getString(4);
			date = rs.getString(9);
			assignment_page = count/5 +1;
			result.add(new Assignment(assignment_page, assignment_no, assignment_name, title, date, ""));
			count++;
		}
    } catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    
    
    //학생수 세기 위해 제출 여부 알기위해
	
    ArrayList<Assignment> check = new ArrayList<Assignment>();
	check.clear();
	int submit_assignment_no = 0;
	String submit_stu_num = ""; 
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure", "root", "1");
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("select * from assignment where submit_yesno= 'y' and prof= 'n'");

		while(rs.next()){
			submit_assignment_no=rs.getInt(3);
			submit_stu_num=rs.getString(2);
			assignment_page = assignment_page + (assignment_no-1)/5;
			check.add(new Assignment(0, submit_assignment_no, submit_stu_num, "", "", ""));
		}
    } catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
%>

<%
	//페이징
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

<div id="body" style="width:100%; float:left; text-align:left;">
	<div id="body_top_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>
        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: <%=(int)session.getAttribute("total_no")%>명</li>
	  </ul>

    </div> 
	<div id="body_left" style="height:500px;width:20%;float:left;"></div>
	<div id="body_right" style="height:;width:60%;float:left;">
		<table align="center"><tr><td><h3> 과제 목록</h3></td></tr></table>
	  <!--					<form name="write" method="post" action="not_yet.jsp">
		  
          <input type="submit" name="write" id="approve" value="글쓰기" style="margin-left:735px">
          
	            </form>
		-->	
        <p></p><br>
      <table align="center" class="tableform">
	    <thead>
	    <tr>
	        <th scope="col">No.</th>
	        <th scope="col">제목</th>
	        <th scope="col">작성자</th>
	        <th scope="col">작성일</th>
	    <% 
	    	if(prof=='y' || prof == 'a'){
	    %>
	        <th scope="col">제출 학생 수</th>
	    <%
	    	}else if(prof=='n'){
	    %>
	    	<th scope="col">제출 여부</th>
	    <%
	    	}
	    %>
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
			<td><a href="board_read.jsp?assignment_no=<%=result.get(i).getSubmit_no()%>"><%=result.get(i).getTitle() %></td>
			<td><%=result.get(i).getStudent_name()%></td>
			<td><%=result.get(i).getContent()%></td>
			<td>
		<% 
			if(prof=='y' || prof == 'a'){	
			count = 0;
			for(int j=0; check.size()>j; j++){
				if(result.get(i).getSubmit_no() == check.get(j).getSubmit_no()){
					count++;
				}
			}
				
	    %>
	     	<%=count%>/<%=total_no%>명
	    <%
	    	}else if(prof=='n'){
	    	tempsubmityn="미제출";
	    	for(int j=0; check.size()>j; j++){
				if(result.get(i).getSubmit_no() == check.get(j).getSubmit_no()){
					if(check.get(j).getStudent_name().equals(student_no)){
						tempsubmityn = "제출";
					}
				}
			}
	    
	    	}
	    %>
	    	<%=tempsubmityn%>
			</td>
	    </tr>
	    <% 		}
	    
	    		else{
	    %>
	    <tr>
	        <td scope="row" class="even"><%=result.get(i).getSubmit_no()%></td>
		  	<td class="even"><a href="board_read.jsp?assignment_no=<%=result.get(i).getSubmit_no()%>"><%=result.get(i).getTitle() %></td>
			<td class="even"><%=result.get(i).getStudent_name()%></td>
			<td class="even"><%=result.get(i).getContent()%></td>
			<td class="even">
    	<% 
			if(prof=='y' || prof == 'a'){	
			count = 0;
			for(int j=0; check.size()>j; j++){
				if(result.get(i).getSubmit_no() == check.get(j).getSubmit_no()){
					count++;
				}
			}
				
	    %>
	     	<%=count%>/<%=total_no%>명
	    <%
	    	}else if(prof=='n'){
	    	tempsubmityn="미제출";
	    	for(int j=0; check.size()>j; j++){
				if(result.get(i).getSubmit_no() == check.get(j).getSubmit_no()){
					if(check.get(j).getStudent_name().equals(student_no)){
						tempsubmityn = "제출";
					}
				}
			}
	    
	    	}
	    %>
	    	<%=tempsubmityn%>
             </td>
	    </tr>

	   <%		}
	    	}
	    }%>
        
	    </tbody>
		</table>
        
           	    <br>
   	    <br>
	  
<%
	if(prof == 'y' || prof == 'a'){
		if(result.size()>0){
			write_assignment_no = result.get(result.size()-1).getSubmit_no()+1;
		}
%>

<table align="center" class="table_noline"><tr><td></td><td></td><td></td><td></td><td></td></tr>
<td  colspan="4"><td colspan="1" align="center"><form name="write" method="post" action="write_index.jsp?assignment_no=<%=write_assignment_no%>">
          <input type="submit" name="write" id="approve" value="과제 등록">
     </form>
     </td>
     </tr>
     </table>
     
<%
	}
	
%>
        <br>
      <br> 
        <br>
        	    	<!-- // NBoard Foot Button -->
	<div id="n-wrap">
	    <div class="n-paging"><ul>
	    <% 
	   		if(pg>BLOCK) {
		%>
	  
			<li><a href="board_list.jsp?pg=<%=startPage-1%>"><img src="images/btn_paging_prev.gif"><a><em>이전 10 페이지</em></a></li>
		<%
	   		}
	    	if(allPage > 0){
		    	for(int i=startPage; i<= endPage; i++){
		    		if(i==pg){
		%>
		    		<li><a href="board_list.jsp?pg=<%=i %>" class="selected"><%=i %></a></li>
		<%
		    		}else{
		    			if(i>allPage){
		    				break;
		    			}
		%>		
					<li><a href="board_list.jsp?pg=<%=i %>"><%=i %></a></li>
		<%
		    		}
		    	}
	    	}
	    	
	    	if(endPage<allPage){
		%>
			<li><a href="board_list.jsp?pg=<%=endPage+1%>"><img src="images/btn_paging_next.gif"><a><em>다음 10 페이지</em></a></li>
		<%
	    	}
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
