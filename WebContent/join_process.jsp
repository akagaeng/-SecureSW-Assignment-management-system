<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*,java.util.*,java.text.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@page import="ServiceManager.AES256Cipher"%> 
<%@page import="ServiceManager.SHA256"%> 

<%
    
    String userid = request.getParameter("id_text"); //input의 name에서 받아옴
    String name = request.getParameter("mem_name");    
    String student_no = request.getParameter("mem_number");
    String passwd = request.getParameter("mem_pass");
    String passwd_chk = request.getParameter("mem_passChk");
    String email = request.getParameter("mem_email");
    String phone = request.getParameter("mem_phone01")+"-"+request.getParameter("mem_phone02")+"-"+request.getParameter("mem_phone03");
    String modifyFlag = request.getHeader("referer");          //Member Modify의 경우 
    
    AES256Cipher a256 = AES256Cipher.getInstance();

	System.out.println("회원가입"+userid);
    String enuserid = a256.AES_Encode(userid);
    String enname = a256.AES_Encode(name);
    String enstudent_no = a256.AES_Encode(student_no);

    SHA256 sha256 =  new SHA256();
    String enpasswd = sha256.testSHA256(passwd);
    String enpasswd_chk = sha256.testSHA256(passwd_chk);

    String enemail = a256.AES_Encode(email);
    String enphone = a256.AES_Encode(phone);

    
    
    //현재 날짜를 string 형으로 저장 YYYYMMDD
    java.util.Date dt = new java.util.Date();

    SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
    String dateString = dateFormatter.format(dt); 
    
    String register_date= dateString;
    String password_changed_date=dateString;
    
    String enregister_date = a256.AES_Encode(register_date);
    String enpassword_changed_date = a256.AES_Encode(password_changed_date);
    
    //out.print("실행되는 쿼리문: insert into member(id, pw, name, student_no, email, phone) values ('"+userid+"','"+ passwd + "','" + name + "','" + student_no + "','" + email + "','" + phone + "')");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure?useUnicode=true&characterEncoding=UTF-8",// secure? 이후 문장은 한글 깨짐현상으로 추가(양)
            "root", "1");
    Statement st = con.createStatement();
    
    if(modifyFlag.indexOf("member_modify.jsp")>0)  { //이전페이지가 member_modify 일경우 이거나 아니면 정상 회원가입 
        int a=st.executeUpdate("update member set pw='"+enpasswd+"',email='"+enemail+"',phone='"+enphone+"',password_changed_date='"+enpassword_changed_date+"' where id='"+enuserid+"'");//비밀번호 수정날짜도 저장하도록 수정하였습니다.
    	
        if(a>0){
	        session.setAttribute("password_changed_date", password_changed_date);

/*out.println(userid);
out.println(passwd);
out.println(student_no);
out.println(email);
out.println(phone);
*/
				
				%> 

                <script type="text/javascript"> 
                    alert("회원정보 수정이 완료되었습니다.");
                    
                    <%
                    
                    	//회원 정보 수정한 경우 세션정보도 업데이트하도록 했어요(양)
                    	//아이디,성명,학번은 수정 안되게 하는건가요?
                    	//session.setAttribute("userid", userid);
	        			//session.setAttribute("name", name);
	        			//session.setAttribute("student_no", student_no);
	        			//session.setAttribute("prof", prof); //prof는 교수인지 여부 a: 관리자, y: 교수 ,n: 학생
	        			//session.setAttribute("position", position); //prof를 스트링으로 저장 "관리자", "교수" , "학생"
	        
				        session.setAttribute("email", email);
				        session.setAttribute("phone", phone);
                    
        }
                    %>
                    
                    location.href="index.jsp";
                </script>
<%
    } else {    //회원 가입 
          int i = st.executeUpdate("insert into member(id, pw, name, student_no, email, phone, register_date, password_changed_date) values ('"+enuserid+"','"+ enpasswd + "','" + enname + "','" + enstudent_no + "','" + enemail + "','" + enphone + "','" + enregister_date + "','" + enpassword_changed_date + "')");
          //가입날짜,비밀번호 수정날짜도 저장하도록 수정하였습니다.
        if (i > 0) {
%>

                <script type="text/javascript"> 
                    alert("회원가입이 완료되었습니다.");
                    location.href="index.jsp";
                </script>
<%
         } else {
%>         
                <script type="text/javascript"> 
                    alert("회원가입이 비정상 적으로 완료되었습니다.");
                    location.href="index.jsp";
                </script>
<%
        }
    }
    //response.sendRedirect("index.jsp");
%>
