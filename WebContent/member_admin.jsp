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
<%
//userid 세션 없고 , 관리자가 아니면 index.jsp로 강제 리다이렉트
  
  String user_id= (String)session.getAttribute("userid");
  String posid= (String)session.getAttribute("position");
  /*if((user_id==null) || (!prof_id.equals("관리자")) {
    response.sendRedirect("index.jsp");
  }*/
  
  if(user_id==null) {
    response.sendRedirect("index.jsp");
  }
  if(!posid.equals("관리자")) {
  %><script>alert("비정상적인 접근 경로입니다.");history.go(-1);</script><%
    //response.sendRedirect("index.jsp");
  }
%>
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
 
<div id="body" style="width:100%; float:left; text-align:left;">
	<div id="body_upper_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>

        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: <%=(int)session.getAttribute("total_no")%>명</li>
	  </ul>
    </div> 


    <div id="body_left" style="height:500px;width:20%;float:left;"></div>
  <div id="body_right" style="background-color:#FFFFFF;height:;width:60%;float:left;">
				<table align="center"><tr><td><h3>회원정보 관리</h3></td></tr></table>
        <p></p><br>
<table class="tableform" align="center">
        <thead>
          <tr height="5">
            <th scope="col">순번</th>
            <th scope="col">아이디</th>
            <th scope="col">이름</th>
            <th scope="col">학번</th>
            <th scope="col">신분</th>
            <th scope="col" align="left">비고</th>
          </tr>
        </thead>
                    <tbody>

<%

    AES256Cipher a256 = AES256Cipher.getInstance();
//JDBC 드라이버 로딩
Class.forName("com.mysql.jdbc.Driver");   
%>
<script type="text/javascript"> 

function SetProfFlag() {
  //alert('아무것도 선택하지 않았습니다!');
  var list = document.getElementsByName("sel_chk[]");
  var strGrade="";
  var locURL="";
  if(SetProfFlag.arguments[0]==true) {
    strGrade = "y";
  } else {
    strGrade = "n";
  }
	locURL = "modify_process.jsp?strNum='" + SetProfFlag.arguments[1] + "'&setProf='" + strGrade + "'";

	location.href=locURL;
}
</script>
<%
//초기화
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ResultSet rs2 = null;

    try{
      String jdbcDriver = "jdbc:mysql://localhost:3306/secure";
      String dbUser = "root";
      String dbPass = "1";
      
      String query1 = "select * from member";
      
      //String query2= " where id='" + userid + "' and pw='" + passwd + "'";
      
    //데이터베이스 커넥션 생성
      conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

    //Statement 생성
    stmt = conn.createStatement();

    //쿼리 실행
      rs = stmt.executeQuery(query1);


      while (rs.next()) {  //아이디와 비밀번호 일치하는 경우: re.next()는 ResultSet에서 select의 값이 존재하는 경우 true를 리턴하고, 존재하지 않는 경우에는 false를 리턴한다.
                
          String no = rs.getString("no");
          String id = rs.getString("id");
          String name = rs.getString("name");
          String student_no = rs.getString("student_no");
          String prof = rs.getString("prof");
          String email=rs.getString("email");
          String phone=rs.getString("phone");

	  String desid = a256.AES_Decode(id);
	  String desname= a256.AES_Decode(name);
	  String desstudent_no = a256.AES_Decode(student_no);
	  String desemail = a256.AES_Decode(email);
	  String desphone = a256.AES_Decode(phone);

%>
<!--여기부터 -->
            <tr height="5">
              <td scope="col"><%=no%></td>
              <td scope="col"><%=desid %></td>
              <td scope="col"><%=desname%></td>
              <td scope="col"><%=desstudent_no%></td>

              <td scope="col">
             <%
              if(prof.equals("a")) {
               %>관리자<%
              } else if(prof.equals("y")) {
               %><input type="button" name="approve" id="approve" value="교수" onClick="SetProfFlag(false, <%=no%>)"><%
              } else  {
                %><input type="button" name="approve" id="approve" value="학생" onClick="SetProfFlag(true, <%=no%>)"><%
              }
              %>
              </td>
              <td scope="col" align="left"><%=desemail%></td>
            </tr>
<!--여기까지 -->
 
<%

      }
    }//try 종료
    
    catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}  //SQL 에러 발생시
      
    finally{
  
        //사용한 statement 종료
        if(rs!=null){ try{ rs.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}}
        if(stmt!=null){ try{ stmt.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}}
        //커넥션 종료
        if(conn!=null){ try{ conn.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}}
}
%>


            </tbody>
      </table>
 
   	      <br><br><br>
          <table align="center"><tr><td><input type="button" value="돌아가기" onClick="javascript:window.location='index.jsp'">
          </td>
          </tr>
          </table> 
        <br>
        <br>
      <br> 
        <br>
   	
</div>

<div id="footer" style="width:100%; float:left; text-align:center;">
	<div id="footer_left" style="background-color:;height:100px;width:10%;float:left;"></div> 

    <div id="footer_center" style="background-color:;height:100px;width:80%;float:left;"></div> 

   	<div id="footer_right" style="background-color:;height:100px;width:10%;float:left;"></div> 
  </div> 
</div>



</body>
</html>
