<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%
//원래 이거 써있었는데 위의 걸로 바꿔서 넣었습니다.
//@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding= "EUC-KR"
%>
<%@page import="java.util.*" %>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>  
<%@page import="Class.Assignment"%> 
<%@page import="ServiceManager.AES256Cipher"%> 


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css">
<title>grade</title>
</head>

<body>

<%
	int assignment_no=0; //과제 넘버
	System.out.println("첫번째 assignment_no"+assignment_no);//이거 찍어놨는데 로그에안보임
	
	if(request.getParameter("assignment_no")!=null) { //받아온 과제 넘버가 있을때
		assignment_no = Integer.parseInt(request.getParameter("assignment_no")); // 과제 넘버값을 저장
		System.out.println("두번째 assignment_no"+assignment_no);
	}

	String student_no="";
	if(request.getParameter("student_no")!=null) { 
		student_no = request.getParameter("student_no"); // 과제 넘버값을 저장
	}

	String grade="";
	if(request.getParameter("grade")!=null) { 
		grade = request.getParameter("grade"); // 과제 넘버값을 저장
	}


	int rowCount = 0;
	
	System.out.println("rowCount:" + rowCount);
	
	try {
		
		String jdbcDriver = "jdbc:mysql://localhost:3306/secure";
		String dbUser = "K2amNtg+kL5xK23g7H3Znw==";
		String dbPass = "CPnv7eGM8oJo4GvYbu3ySQ==";
		AES256Cipher a256 = AES256Cipher.getInstance();
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(jdbcDriver, a256.AES_Decode(dbUser), a256.AES_Decode(dbPass));
		Statement st = con.createStatement();
		rowCount = st.executeUpdate("update assignment set grade = '" + grade +"'where assignment_no= '" + assignment_no +"'and student_no = '"+ student_no +"'");

		System.out.println("rowCount:" + rowCount);

    } catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();

	}
	
	System.out.print(rowCount);
	
%>

<script>
 
 setTimeout('exit()',1000);
 function exit() {
    alert('입력되었습니다.');    
    window.opener.location.reload();
    self.close();
}
</script>

</body>
</html>
