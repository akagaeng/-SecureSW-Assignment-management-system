<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*" %>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>  
<%@page import="Class.Assignment"%> 

<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css">
<title>학점 입력</title>
</head>

<body>


<%
	//로그인 안된 상태라면 접근금지 
	String user_id= (String)session.getAttribute("userid");
	if(user_id==null) {
		response.sendRedirect("index.jsp");
	}
	int assignment_no=0; //과제 넘버
	if(request.getParameter("assignment_no")!=null) { //받아온 과제 넘버가 있을때
		assignment_no = Integer.parseInt(request.getParameter("assignment_no")); // 과제 넘버값을 저장
	} else {
		response.sendRedirect("index.jsp");
	}
	
%>
<%
	String student_no="";
	if(request.getParameter("student_no")!=null) { 
		student_no = request.getParameter("student_no"); // 과제 넘버값을 저장
	}
	
%>


<br><br><br>
<table align="center"><tr><td align="center">
학점을 입력하신 후 "저장" 버튼을 눌러주세요.<br>
<br>
<form method="post" action="save_grading.jsp?assignment_no=<%=assignment_no%>&student_no=<%=student_no%>">
A<input type="radio" name="grade" value="A">
B<input type="radio" name="grade" value="B">
C<input type="radio" name="grade" value="C">
점수 삭제<input type="radio" name="grade" value="">
<br>
 <br>
 <script>
 function aftersaveFunc() {
    location.href="save_grading.jsp?assignment_no=<%=assignment_no%>&student_no=<%=student_no%>";
}
 </script>
	<input type="submit" value="저장" onClick="aftersaveFunc()"></td></tr></table>
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
</body>
</html>
