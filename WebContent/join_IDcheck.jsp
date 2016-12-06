<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*,java.util.*,java.text.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@page import="ServiceManager.AES256Cipher"%> 
<jsp:scriptlet>
    request.setCharacterEncoding("UTF-8");
    String userid = request.getParameter("check_id").toString(); //input의 name에서 받아옴
    String joinFormFlag = request.getHeader("referer");          //Member Modify의 경우 

    AES256Cipher a256 = AES256Cipher.getInstance();
    String enId = a256.AES_Encode(userid);

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/secure?useUnicode=true&characterEncoding=UTF-8",// secure? 이후 문장은 한글 깨짐현상으로 추가(양)
            "root", "1");
    Statement st = con.createStatement();
    
    if(joinFormFlag.indexOf("join_form.jsp")>0)  { //이전페이지가 join_form 일경우 이거나 아니면 정상 회원가입 

        //초기화
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try{
            String jdbcDriver = "jdbc:mysql://localhost:3306/secure";
            String dbUser = "root";
            String dbPass = "1";

            String query1 = "select * from member where id='"+enId+"'";
           
            //데이터베이스 커넥션 생성
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

            //Statement 생성
            stmt = conn.createStatement();

            //쿼리 실행
            rs = stmt.executeQuery(query1);

            if(rs.next()) {     //중복 아이디가 있을 경우 
                </jsp:scriptlet><script type="text/javascript"> 
                //opener.document.getElementById("id_text").value="true";
                //opener.test_alert();
//                opener.document.all.test_alert();
                //alert("성공");
                //console.log(document.getElementById("id_text").value);
                //opener.document.join_form.id_text.value="true"; 
                console.log("중복있음 <%=userid%>");
                //parent.document.result_idcheck="false";
                //parent.document.getElementById("hidden_id").value = "false";
                parent.check_id_result(false);
                self.close();
                </script>
               <jsp:scriptlet>

            } else {        //중복 아이디가 없을 경우 
                </jsp:scriptlet><script type="text/javascript"> 

                //opener.test_alert();
                //opener.document.all.test_alert();
                //opener.document.join_form.id_text.value="false"; // <%=query1%>
                //alert("실패");
                /*console.log(document.get_id.value);
                console.log(opener.get_id.value);
                  console.log(document.getElementById("id_text").value);
                


                alert(parent.document.getElementById("id_text").value);
                parent.document.getElementById("hidden_id").value = "dsahdsad";
                */
                 console.log("중복없음 <%=userid%>");
                 //parent.document.getElementById("hidden_id").value = "true";
                 //parent.document.getElementById("hidden_id").value = "dsahdsad";
                 //parent.test_alert("개시발!");
                //parent.document.result_idcheck = "true";
                parent.check_id_result(true);
                self.close();
                </script>
                <jsp:scriptlet>
                //opener.document.get_id.value="false";

            }
        }

        catch(SQLException ex){</jsp:scriptlet><script>alert("SQL Exception occurred");history.go(-1);</script><jsp:scriptlet>}  //SQL 에러 발생시
          
        finally{
            //사용한 statement 종료
            if(rs!=null){ try{ rs.close(); } catch(SQLException ex){</jsp:scriptlet><script>alert("SQL Exception occurred:rs");history.go(-1);</script><jsp:scriptlet>}}
            if(stmt!=null){ try{ stmt.close(); } catch(SQLException ex){</jsp:scriptlet><script>alert("SQL Exception occurred:stmt");history.go(-1);</script><jsp:scriptlet>}}
            //커넥션 종료
            if(conn!=null){ try{ conn.close(); } catch(SQLException ex){</jsp:scriptlet><script>alert("SQL Exception occurred:conn");history.go(-1);</script><jsp:scriptlet>}}
        }
    }
    </jsp:scriptlet>
