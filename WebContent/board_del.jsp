<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding= "EUC-KR"%>
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
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date" %>

<%

// 작성자 : 이수훈
//FTP 관련 변수
String str_id= session.getId();
String FTPServer ="210.107.197.186";
int FTPport = 21;
String FTPid = "upload";
String FTPpw = "1";

FTPClient ftpClient = new FTPClient();
int reply;

String uploadPath = application.getRealPath("/upload");
out.println("uploadpath :"+uploadPath+"<br>");
int size = 50*1024*1024; // 업로드 파일 최대 크기 지정 : 50MB
int data_no=0;
int number_of_assignment=0;
String name=(String)session.getAttribute("name");
String user_id=(String)session.getAttribute("userid");
String user_no=(String)session.getAttribute("student_no");
String phone = (String)session.getAttribute("phone");
String email = (String)session.getAttribute("email");
String filename="";
String is_write=request.getParameter("is_write");
String board_no=request.getParameter("assignment_no");//넘어와야되는거
out.println("board_no : "+board_no+"<br>");
String board_title="";
String Filepath ="";
String newFileName ="";
Statement stmt;
String t_title="";
String content="";
String new_file_name="";
String is_prof="";

long currentTime = System.currentTimeMillis();
SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");

ServletContext context = getServletContext();
out.println("name : "+name+"<br>");
out.println("user_id : "+user_id+"<br>");
out.println("user_no : "+user_no+"<br>");

try{
// DB Connect
 Class.forName("com.mysql.jdbc.Driver");
 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure?useUnicode=true&characterEncoding=UTF-8",// secure? 이후 문장은 한글 깨짐현상으로 추가(양)
         "root", "1");
 stmt = con.createStatement();

  if(con != null)
  out.println("Mysqljdbctest: connect ok!!"+"<br/>");
// DB Connect 끝
String query = "select prof from member where student_no=?";
PreparedStatement pstmt=con.prepareStatement(query);
pstmt.setString(1,user_no);
ResultSet rs = stmt.executeQuery(query);
is_prof=rs.getString("prof");

if(is_prof.compareTo("n")==0){//학생이면
 query = "delete * from assignment where assignment_no=? and student_no=?";
pstmt=con.prepareStatement(query);
pstmt.setString(1,board_no);
pstmt.setString(2,user_no);
pstmt.execute(query);
query = "select new_file_name from data_list where board_no=? and user_no=?";
rs = stmt.executeQuery(query);
stmt=con.createStatement();
new_file_name = rs.getString("new_file_name");

ftpClient.connect(FTPServer, FTPport);
reply = ftpClient.getReplyCode();
ftpClient.setControlEncoding("euc-kr");
ftpClient.login(FTPid, FTPpw);

ftpClient.deleteFile("\\"+user_id+"\\"+new_file_name);

query = "delete from data_list where board_no=? and user_no=?";
pstmt=con.prepareStatement(query);
pstmt.setString(1,board_no);
pstmt.setString(2,user_no);
pstmt.executeUpdate(query);
}
else
{
	 query = "delete * from assignment where assignment_no=? and student_no=?";
	 pstmt=con.prepareStatement(query);
	 pstmt.setString(1,board_no);
	 pstmt.setString(2,user_no);
	 pstmt.executeUpdate(query);
	 
}

con.close();
}
catch(Exception e){
	out.println("exception 발생 <br>");
	  e.printStackTrace();
	  }

  //FTP Connect
  
  //FTP Login
  try{
	  ftpClient.login(FTPid, FTPpw);
  }
  catch(IOException ioe){
	  out.println("FTP 서버 로그인 실패"+"</br>");
  }

  try{
  } catch(Exception ex)
  {
	  out.println("FTP ERROR"+"<br/>");
	  ex.printStackTrace();
  } 
  try{
  ftpClient.logout();
  }
  catch(SocketException e)
  {
	  System.out.println("Socket"+e.getMessage());
  } catch(IOException e){
	  System.out.println("IO:"+e.getMessage());
  }finally
  {
	  if(ftpClient == null && ftpClient.isConnected())
	  {
		  try{
			  ftpClient.disconnect();
		  }catch(IOException e) {
			  
		  }
	  }
  }


%>

