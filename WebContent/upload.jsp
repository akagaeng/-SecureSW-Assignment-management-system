<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
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
String FTPServer ="210.107.197.133";
int FTPport = 21;
String FTPid = "upload";
String FTPpw = "1";
char prof= (char)session.getAttribute("prof");

FTPClient ftpClient = new FTPClient();
int reply;

String uploadPath = application.getRealPath("/upload/tmp");
out.println("uploadpath :"+uploadPath+"<br>");
int size = 50*1024*1024; // 업로드 파일 최대 크기 지정 : 50MB
int data_no=0;
int number_of_assignment=0;
String name=(String)session.getAttribute("name");
String user_id=(String)session.getAttribute("userid");
String user_no=(String)session.getAttribute("student_no");

//String name="이수훈";
//String user_id="scuniess21";
//String user_no="201524721";
String filename="";
String board_no=request.getParameter("assignment_no");//넘어와야되는거
//String board_no="372";
out.println("board_no : "+board_no+"<br>");
String board_title="";
String Filepath ="";
String newFileName ="";
Statement stmt;
String fne;
String t_title="";
String content="";
String is_write=request.getParameter("is_write");

out.println("is_write : "+is_write+"<br>");
String phone= (String)session.getAttribute("phone");
String email= (String)session.getAttribute("email");
String date_current=(String)session.getAttribute("dateString");

//String student_no="201524721";
//Statement stmt2;
long currentTime = System.currentTimeMillis();
SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");


ServletContext context = getServletContext();
out.println("name : "+name+"<br>");
out.println("user_id : "+user_id+"<br>");
out.println("user_no : "+user_no+"<br>");


  //FTP Connect
  try{
	  Class.forName("com.mysql.jdbc.Driver");
ftpClient.connect(FTPServer, FTPport);
  reply = ftpClient.getReplyCode();
  ftpClient.setControlEncoding("euc-kr");
  
  if (!FTPReply.isPositiveCompletion(reply)) {
	 ftpClient.disconnect();
	 out.println("FTP 연결 거부"+"<br/>");
	 
  }
  else {
	  out.println("FTP 연결 성공"+"<br/>");
  }
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
 
  }//FTP Connect

  //FTP Login
  try{
	  ftpClient.login(FTPid, FTPpw);
  }
  catch(IOException ioe){
	  out.println("FTP 서버 로그인 실패"+"</br>");
  }

  try{
	  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure?useUnicode=true&characterEncoding=UTF-8",// secure? 이후 문장은 한글 깨짐현상으로 추가(양)
	          "root", "1");
	  stmt = con.createStatement();
	  request.setCharacterEncoding("euc-kr");
	  out.println("uploadpath : "+uploadPath+"<br>");
	  MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "euc-kr", new DefaultFileRenamePolicy());
	  filename = multi.getFilesystemName("s_file");
	  out.println("file_name = "+filename+"<br>");
	  t_title=multi.getParameter("text_title");
	  

	  //xss 문자열 치환 -양
	  if(t_title!=null){
	  t_title=t_title.replaceAll("<","&lt;");
	  t_title=t_title.replaceAll(">","&gt;");
	  t_title=t_title.replaceAll("&","&amp;");
	  t_title=t_title.replaceAll("\"","&quot;");
	  t_title=t_title.replaceAll("\'","&#x27;");
	  t_title=t_title.replaceAll("/","&#x2F;");
	  }
	  
	  
	  out.println("t_title : "+t_title+"<br>");
	  content=multi.getParameter("text_content");
	  out.println("content :" +content+ "</br>");
	 
	  
	if(is_write.compareTo("0")==0){// 글 수정일 때
		  String query ="update assignment set title=?,content=? where student_no=? and assignment_no=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1,t_title);
			pstmt.setString(2,content);
			pstmt.setString(3,user_no);
			pstmt.setString(4,board_no);
			if(pstmt.executeUpdate()!=1)
				out.println("DB Query error"+"<br/>");
			out.println("제목, 글 내용 수정 완료! <br>");
			con.close();
			
			   if(filename != null){
						  newFileName = simDf.format(new Date(currentTime))+"."+filename.substring(filename.lastIndexOf(".")+1)+"_"+user_id;// 새로 쓸 파일 이름 생성
						  File oldFile = new File(uploadPath+"\\"+filename);
						  File newFile = new File(uploadPath+"\\"+newFileName);
						  
						  	if(!oldFile.renameTo(newFile)){
							  	out.println("이름 변경 실패 </br>");
						  	}
						  out.println(newFile.getName()+"</br>");
						  out.println(uploadPath+"\\"+filename+"</br>");
					  FileInputStream inputStream = new FileInputStream(newFile);
					  ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
					  ftpClient.storeFile("\\"+newFile.getName(),inputStream);
					  inputStream.close();
					  }
			
			//기존에 올려놓았던 파일 경로 산출 후 접근
			//기존의 파일 지우기
			//올려놓은 파일 올림
			//data_list의 board_no, user_id 를 기준으로 update 실시 
	  }
	  else{ // 글 새로 쓸 때 
		  if(filename != null){
			   newFileName = simDf.format(new Date(currentTime))+"."+filename.substring(filename.lastIndexOf(".")+1);// 새로 쓸 파일 이름 생성
				  File oldFile = new File(uploadPath+"\\"+filename);
				  File newFile = new File(uploadPath+"\\"+newFileName);
				  
	
				  
				  
				  	if(!oldFile.renameTo(newFile)){
					  	out.println("이름 변경 실패 </br>");
				  	}
				  out.println(newFile.getName()+"</br>");
				  out.println(uploadPath+"\\"+filename+"</br>");
				  FileInputStream inputStream = new FileInputStream(newFile);
				  ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
				  ftpClient.storeFile("\\"+newFile.getName(),inputStream);
				  inputStream.close();
				  
		  String query = "select * from data_list";
		  ResultSet rs = stmt.executeQuery(query);
		  ResultSet rs2 = null;
		  rs.last();
		  data_no=rs.getRow()+1;//총 데이터 숫자 구하기
		  out.println("data_no : "+data_no+"<br>");
		  
		  query="insert into data_list  values (?,?,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1,Integer.toString(data_no));
			out.println("data_no : "+data_no+"<br>");
			pstmt.setString(2,filename);
			out.println("filename : "+filename+"<br>");
			pstmt.setString(3,newFileName);
			out.println("newfilename : "+newFileName+"<br>");
			pstmt.setString(4,name);
			out.println("name : "+name+"<br>");
			pstmt.setString(5,board_no);
			out.println("board_no : "+board_no+"<br>");
			pstmt.setString(6,user_id);
			out.println("user_id : "+user_id+"<br>");
			pstmt.setString(7,user_no);
			out.println("user_no : "+user_no+"<br>");
			if(pstmt.executeUpdate()!=1)
				out.println("DB Query error"+"<br/>");
			
		  }
			
		  
		  String query ="insert into assignment(student_no, assignment_no, title, content, prof, submit_yesno,assignment_register_date) values (?,?,?,?,?,?,?)";
		  PreparedStatement pstmt = con.prepareStatement(query);
		   pstmt.setString(1,user_no);
		   out.println("user_no"+user_no+"<br>");
		   pstmt.setString(2,board_no);
		   out.println("board_no"+board_no+"<br>");
		   pstmt.setString(3,t_title);
		   out.println("t_title"+t_title+"<br>");
		   pstmt.setString(4,content);
		   out.println("content"+content+"<br>");
		   if(prof=='y')
		   	   pstmt.setString(5,"y");
		   else if(prof=='n')
			   pstmt.setString(5,"n");
		   else
			   pstmt.setString(5,"a");
		   pstmt.setString(6,"y");
		   pstmt.setString(7,date_current);

		   pstmt.executeUpdate();
		  
		   con.close();
		 
		   out.println("제목, 글 등록 완료! <br>");

	  }
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

response.sendRedirect("board_list.jsp");
//pageContext.forward("board_list.jsp");
%>

