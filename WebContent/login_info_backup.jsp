<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>
<%//우측상단에 로그인정보, 첫페이지로, 회원정보관리, 로그아웃 구현해둔것.반영하면 지워도 됨 %>


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



<%  if(session.getAttribute("userid") == null){         //로그인 안된경우******************************************%>
<script type="text/javascript"> 

  alert("잘못된 접근입니다."); 
  history.back();
</script>
<%} 
else 
{//로그인 된경우******************************************%>
 
<div id="body" style="width:100%; float:left; text-align:left;">
	<div id="body_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>

        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: <%=(int)session.getAttribute("total_no")%>명</li>
	  </ul>
    </div> 


    
   	<div id="body_right" style="background-color:#FFFFFF;height:;width:80%;float:right;">
				<h3>회원정보관리
	        </h3>
				<form name="form1" method="post" action="not_yet.jsp">
		  <label>선택 멤버를 </label>
          <label>
          <input type="submit" name="approve" id="approve" value="교수등록">
          </label>
          <label>
          <input type="button" name="decline" id="decline" value="교수해제" onClick="javascript:window.location='not_yet.jsp'">
          </label>
	            </form>
		
        <p></p><br>
      <table class="tableform">
        <thead>
          <tr>
            <th scope="col"><form name="form2" method="post" action="">
              <label>
              <input type="checkbox" name="checkbox" id="checkbox">
              </label>
            </form>
            </th>
            <th scope="col">별명(아이디)</th>
            <th scope="col">학번</th>
            <th scope="col">신분(학생/교수)</th>
            <th scope="col">비고</th>
          </tr>
        </thead>
                    <tbody>
<%
    //JDBC 드라이버 로딩
    Class.forName("com.mysql.jdbc.Driver");   
    
    //초기화
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
%>
<%
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
    
      int total_no = rs.getRow();
    
      //rs = stmt.executeQuery(query1+query2);
      rs = stmt.executeQuery(query1);      

      while (rs.next()) {  //아이디와 비밀번호 일치하는 경우: re.next()는 ResultSet에서 select의 값이 존재하는 경우 true를 리턴하고, 존재하지 않는 경우에는 false를 리턴한다.
          
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
         
                
          String no = rs.getString("no");
          //String id = rs.getString("id");
          String name = rs.getString("name");
          String student_no = rs.getString("student_no");
          String prof = rs.getString("prof");
          String email=rs.getString("email");
          String phone=rs.getString("phone");
 
%>
<!--여기부터 -->
            <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col"><%=name%></td>
                <td scope="col"><%=student_no%></td>

              <td scope="col">
             <%
              if(prof.equals("a")) {
               %>관리자<%
              } else if(prof.equals("y")) {
               %>교수<%
              } else  {
                %>학생<%
              }
              %>
              </td>
              <td scope="col"><%=email%></td>
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
   	    <br>
   	    <br>
				<form name="form1" method="post" action="not_yet.jsp">
		  <label>선택 멤버를 </label>
          <label>
          <input type="submit" name="approve" id="approve" value="교수등록">
          </label>
          <label>
          <input type="button" name="decline" id="decline" value="교수해제" onClick="javascript:window.location='not_yet.jsp'">
          </label>
	            </form>
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

<%}%>

</body>
</html>
