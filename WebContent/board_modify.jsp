<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.*" %> <!-- 파일 업로드 처리를 위한 MultipartRequest 객체를 임포트 -->
<%@ page import="com.oreilly.servlet.multipart.*" %> <!-- 파일 중복처리 객체 임포트 -->
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.File, java.io.FileInputStream, java.io.IOException"%>
<%@ page import="java.net.SocketException"%>
<%@ page import="org.apache.commons.net.ftp.FTP"%>
<%@ page import="org.apache.commons.net.ftp.FTPClient"%>
<%@ page import="org.apache.commons.net.ftp.FTPReply"%>
<%@ page import="org.apache.commons.net.ftp.FTPFile"%>
<%@ page import="org.apache.commons.net.ftp.FTPListParseEngine"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.InputStream"%>
<%// 작성자 : 이수훈 
String str_id= session.getId();
String FTPServer ="210.107.197.133";
String FTPid = "upload";
String FTPpw = "1";
String user_id= (String)session.getAttribute("userid");
int FTPport = 21;
int reply;
FTPClient ftpClient = new FTPClient();
int size = 50*1024*1024; // 업로드 파일 최대 크기 지정 : 50MB
Statement stmt;
Statement stmt_down;
ServletContext context = getServletContext();
ResultSet rs = null;
ResultSet rs_down=null;
ResultSet new_down=null;
String is_write="0";


String title="";
String content="";
String assignment_no=request.getParameter("assignment_no");
String student_no=(String)session.getAttribute("student_no");
String down_file[];
String new_down_file[];
int down_num;

%>

<% try{
	ftpClient.connect(FTPServer, FTPport);
	  reply = ftpClient.getReplyCode();
	  ftpClient.setControlEncoding("euc-kr");
	  }
	  catch (IOException ioe) {
		  if(ftpClient.isConnected()){
			  try {
				  ftpClient.disconnect();
		      }
			  catch(IOException f){
				  
			  }
	      }
		  out.println("FTP 서버 연결 실패"+"</br>");
	 
	  }//FTP Connect %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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
request.setCharacterEncoding("euc-kr");
	// DB Connect
 Class.forName("com.mysql.jdbc.Driver");
 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure?useUnicode=true&characterEncoding=UTF-8",// secure? 이후 문장은 한글 깨짐현상으로 추가(양)
         "root", "1");//db명: secure, db 아이디 root, db 비밀번호 root
 stmt = con.createStatement();
 
// DB Connect 끝
String query = "select * from assignment where assignment_no="+"'"+assignment_no+"'"+" and student_no="+"'"+student_no+"'";
rs = stmt.executeQuery(query);

if(rs.next())
{
content = rs.getString("content");
title = rs.getString("title");
}

query = "select file_name from data_list where user_no="+"'"+student_no+"'"+" and board_no="+"'"+assignment_no+"'";
rs_down = stmt.executeQuery(query);
rs_down.last();
down_num = rs_down.getRow();
down_file = new String[down_num];
new_down_file = new String[down_num];
rs_down.first();
for(int i =0; i<down_num; i++){
	down_file[i]= rs_down.getString("file_name"); 
	rs_down.next();
	
}
for(int i=0; i<down_num; i++){
	query = "select new_file_name from data_list where file_name="+"'"+down_file[i]+"'";
	new_down = stmt.executeQuery(query);
	new_down.next();
	new_down_file[i] = new_down.getString("new_file_name");
}

con.close();


%>
      <script type="text/javascript">
       function fileCheck(fileValue)
       {
           //확장자 체크
           var src = getFileType(fileValue);
           if(!src){//파일이 첨부되지 않은 경우
        	   //alert("파일이 첨부되지 않았습니다.");
        	   document.frm.submit();//파일 업는 채로 그냥 submit
        	   }
           else{//파일이 첨부된 경우
	           if(!(src.toLowerCase() == "zip")){
	               alert("zip 파일로 압축하여 첨부해주세요.");
	               return;//파일첨부화면으로 유지
	           }
	           else{
	        	   //alert("zip파일이 맞습니다.");
	        	   document.frm.submit();//파일이 있는 경우 zip파일인 경우에만 submit
	        	   }
           }
       }
           
       function getFileType(filePath)
       {
           var index = -1;
               index = filePath.lastIndexOf('.');
           var type = "";
           if(index != -1)
           {
               type = filePath.substring(index+1, filePath.len);
           }
           else
           {
               type = "";
           }
           return type;
       }
   </script>
   
<div id="body" style="width:100%; float:left; text-align:left;">
	<div id="body_upper_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>

        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: <%=(int)session.getAttribute("total_no")%>명</li>
	  </ul>
    </div> 
 
<div id="body_left" style="height:500px;width:20%;float:left;"></div>
	<div id="body_center" style="background-color:#FFFFFF;height:500px;width:60%;float:left;">
    <table align="center"><tr><td><h3>과제 내용 수정</h3></td></tr></table>
	<table class="table_noline" align="center">
        <tr>
        <td></td><td></td><td></td><td></td><td></td>
        </tr>
        <tr>
        <td colspan="5">
        <form name="frm" action="upload.jsp?is_write=<%=is_write %>&assignment_no=<%=assignment_no %>" method="POST" enctype="multipart/form-data" >

		<label>제목: </label><input type="text" name="text_title" value="<%=title %>" style="height:20px;width:92%;text-align:left;"/>
		</td></tr>
        <tr>
        <td colspan="5">
	
		  <script src="./lib/ckeditor/ckeditor.js"></script>	  
            <textarea name="text_content"><%=content %></textarea>            
            <script>
                CKEDITOR.replace('text_content');
            </script>
        </td>
        </tr>
        <tr>
        <td colspan="2">            <input type="file" name="s_file"/></td>
		<td colspan="2">
        
         <td align="center"><input type="button" value="글쓰기" onclick="fileCheck(document.frm.s_file.value)"/> 
           <input type="button" value="돌아가기" onClick="javascript:history.back()"></td>
					</form>
                    </td>
                    </tr>
                    </table>
    </div> 
   
</div>


<div id="footer" style="width:100%; float:left; text-align:center;">
	<div id="footer_left" style="background-color:#FFFFFF;height:100px;width:30%;float:left;">
    </div> 

    <div id="footer_center" style="background-color:#FFFFFF;height:100px;width:30%;float:left;">
    <table align="center">
    </table>
    </div> 

   	<div id="footer_right" style="background-color:#FFFFFF;width:40%;float:left;">
	
    </div> 
</div>
</body>
</html>
