<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*,java.util.*,java.text.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>

<%

    ResultSet rs;
    //out.print("실행되는 쿼리문: insert into member(id, pw, name, student_no, email, phone) values ('"+userid+"','"+ passwd + "','" + name + "','" + student_no + "','" + email + "','" + phone + "')");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure?useUnicode=true&characterEncoding=UTF-8",// secure? 이후 문장은 한글 깨짐현상으로 추가(양)
            "root", "1");
    Statement st = con.createStatement();
    //st.executeUpdate("update member set email='abc@aaaa.com' where no='31'");
    //st.executeUpdate("update member set prof='y' where no in ('31', '32')");
    //st.executeUpdate("update member set prof='" + request.getParameter("setProf") + "' where no=" + request.getParameter("strNum") );
    String profNum = request.getParameter("setProf");

    String noNum = request.getParameter("strNum");
    st.executeUpdate("update member set prof="+profNum+" where no in ("+noNum+")");
    
    //학생수 변경시 다시 쿼리문 전송하여 학생수 세션에 업데이트
    rs=st.executeQuery("select * from member where prof='n'");
	rs.last();
	int total_no = rs.getRow();
	
	session.setAttribute("total_no",total_no);
	
%>
<script type="text/javascript"> 

//alert("어라!\r"+<%=request.getParameter("setProf")%> +"\r" +<%=request.getParameter("strNum")%>);
location.href="member_admin.jsp";
</script>
    


