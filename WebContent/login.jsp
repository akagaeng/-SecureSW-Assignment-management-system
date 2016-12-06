<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*,java.util.*,java.text.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@page import="ServiceManager.AES256Cipher"%> 
<%@page import="ServiceManager.SHA256"%>  
<%
    String userid = request.getParameter("id");    //login form의 input의 name으로부터 값을 받아옴
    String passwd = request.getParameter("pw");
    
    AES256Cipher a256 = AES256Cipher.getInstance();
    String enId = a256.AES_Encode(userid);
    SHA256 sha256 =  new SHA256();
    String enPw = sha256.testSHA256(passwd);
   	
  	//JDBC 드라이버 로딩
    Class.forName("com.mysql.jdbc.Driver");		
    
  	//초기화
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    int failFlag = 0;

    try{
       	String jdbcDriver = "jdbc:mysql://localhost:3306/secure";
    	String dbUser = "K2amNtg+kL5xK23g7H3Znw==";
    	String dbPass = "CPnv7eGM8oJo4GvYbu3ySQ==";
    	
    	//System.out.println();
    	//System.out.println("dbUser:"+ dbUser+", 암호화:"+ a256.AES_Encode(dbUser)+"");
    	//System.out.println("dbPass:"+ dbPass+", 암호화:"+ a256.AES_Encode(dbPass)+"");
    	
    	String query1 = "select * from member";
    	String query2= " where id='" + enId + "'";
    	String query3= "and pw='" + enPw + "'";
   	
		//데이터베이스 커넥션 생성
		//conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
    	conn = DriverManager.getConnection(jdbcDriver, a256.AES_Decode(dbUser), a256.AES_Decode(dbPass));

		//Statement 생성
		stmt = conn.createStatement();
	
		//쿼리 실행
	rs = stmt.executeQuery(query1+query2);
	if (rs.next()) {
		//String failFlag = rs.getString("fail_flag");
		failFlag = Integer.parseInt(rs.getString("fail_flag"));
		//아이디는 있지만 비번실패 횟수가 5번이 넘었을 경우 에러메시지 
		%>
			<script type="text/javascript"> 
			console.log("failFlag" + "<%=failFlag%>");
			</script>
		<%
		//if(failFlag.equals("5")) {
		if(failFlag>=5) {
			%>
			<script type="text/javascript"> 
			console.log("failFlag" + "<%=failFlag%>");
			console.log("비밀번호 인증 실패 횟수가 5번이 넘었습니다.");
			alert("비밀번호 인증 실패 횟수가 5번이 넘었습니다.\n관리자에게 연락하여 재인증 받으세요.\n관리자(홍명기)\n  - Mobile : 010-3333-3333\n  - email : hmk@gmail.com\n");
			history.go(-1);
			</script>
			<%
			return;
		}

	}
	
	

    	rs = stmt.executeQuery(query1+" where prof='n'");
		rs.last();
    	int total_no = rs.getRow();
		
    	rs = stmt.executeQuery(query1+query2+query3);
    	
    	if (rs.next()) {	//아이디와 비밀번호 일치하는 경우: re.next()는 ResultSet에서 select의 값이 존재하는 경우 true를 리턴하고, 존재하지 않는 경우에는 false를 리턴한다.
	        
		    //고유한 세션 객체의 ID를 되돌려준다.
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
		    //boolean b_new=session.isNew();
     
	    	    		
	        String no = rs.getString("no");
	        //String id = rs.getString("id");
	        String name = rs.getString("name");
	        String student_no = rs.getString("student_no");
	        char prof = rs.getString("prof").charAt(0);
	        String position = "";
	        if(prof=='n'){position = "학생";}
	        else if(prof=='y'){ position = "교수"; }
	        else if(prof=='a'){ position = "관리자"; }
	        else{ position = "N/A"; }
	        
	        String email=rs.getString("email");
	        String phone=rs.getString("phone");

	        String register_date=rs.getString("register_date"); //가입날짜
	        String password_changed_date=rs.getString("password_changed_date");//패스워드 수정일
	        
	        //현재 날짜를 string형으로 저장 YYYYMMDD
	        java.util.Date dt = new java.util.Date();

	        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
	        String dateString = dateFormatter.format(dt); 

	        //out.println(dateString);
	        
	        //request.setAttribute("name",name);

	        //디비 정보 복호화
	        String desname = a256.AES_Decode(name);
	        String desstudent_no = a256.AES_Decode(student_no);
	        String desemail = a256.AES_Decode(email);
	        String desphone = a256.AES_Decode(phone);
	        String desregister_date = a256.AES_Decode(register_date);
	        String despassword_changed_date = a256.AES_Decode(password_changed_date);
	        
	        session.setAttribute("id_str", id_str);
	        session.setAttribute("lasttime", lasttime);
	        session.setAttribute("createdtime", createdtime);
	        session.setAttribute("time_used", time_used);
	        session.setAttribute("inactive", inactive);
	        
	        session.setAttribute("total_no", total_no);
	        session.setAttribute("userid", userid);
	        session.setAttribute("name", desname);
	        session.setAttribute("student_no", desstudent_no);
	        session.setAttribute("prof", prof); //prof는 교수인지 여부 a: 관리자, y: 교수 ,n: 학생
	        session.setAttribute("position", position); //prof를 스트링으로 저장 "관리자", "교수" , "학생"
	        
	        session.setAttribute("email", desemail);
	        session.setAttribute("phone", desphone);
	        
	        session.setAttribute("register_date",desregister_date);
	        session.setAttribute("password_changed_date",despassword_changed_date);
	        
	        session.setAttribute("dateString", dateString);

	        //RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
	        //dispatcher.forward(request,response);
	  	stmt.executeUpdate("update member set fail_flag='0' where id ='"+enId+"'");
	        response.sendRedirect("index.jsp");
	    }
    	else {	//아이디와 비밀번호 일치하지 않는 경우.
    		if(failFlag<5) {


			failFlag++;
			stmt.executeUpdate("update member set fail_flag='"+failFlag+"' where id ='"+enId+"'");
		} 

			

    	%>
            <script>

                alert("아이디나 암호를 "+<%=failFlag%>+"회 잘못 입력하셨습니다.다시 입력해주세요.");
                history.go(-1);
            </script>
		<%
		}//else문 종료
    
    }//try 종료
    
    catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}	//SQL 에러 발생시
    	
    finally{
    		//사용한 statement 종료
    		if(rs!=null){ try{ rs.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}}
    		if(stmt!=null){ try{ stmt.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}}
    		//커넥션 종료
    		if(conn!=null){ try{ conn.close(); } catch(SQLException ex){%><script>alert("SQL Exception occurred");history.go(-1);</script><%}}
}
%>