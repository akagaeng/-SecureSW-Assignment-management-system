<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.*" %> <!-- ���� ���ε� ó���� ���� MultipartRequest ��ü�� ����Ʈ -->
<%@ page import="com.oreilly.servlet.multipart.*" %> <!-- ���� �ߺ�ó�� ��ü ����Ʈ -->
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
<%// �ۼ��� : �̼��� 
String str_id= session.getId();
String assignment_no= request.getParameter("assignment_no");
String is_write="1";

%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="style.css">
<title>���ִ��б� ����Ʈ���� Ư��ȭ���п� ���������ý���</title>
       
</head>
<body>
<div id="container" style="width:100%">

<div id="header" style="width:100%">
  <div id="header_left" style="background-color:#ffffff; width:30%;height:130px; float:left">
		<a href="index.jsp"><img style="margin: 3px;" src="images/aj_logo.png" alt="���ִ��б� ����Ʈ���� Ư��ȭ���п�"></a>
  </div>	<!-- header_left div ����-->

  <div id="header_center" style="background-color:#ffffff; width:40%; height:130px;float:left">
    <div align="center"><a href="index.jsp"><br>
      <img style="margin: 3px;" src="images/logo_right.png" alt="���������ý���" ></a>
      </div>
  </div>	<!-- header_center div ����-->

  <div id="header_right" style="background-color:#ffffff; width:30%;height:130px; float:left"> <br>
    <table width="280" height="100" align="center" cellpadding="0" cellspacing="0">
 
  <tr>
    <td><p align="center">
      		
			<%=session.getAttribute("student_no")+" "%><%=session.getAttribute("name")%>(<%=session.getAttribute("userid")%>)��<%=" ["+session.getAttribute("position")+"]"%><br>


      </td>
  </tr>
  <tr>
    <td>
    	<div align="center">
    	  <input type="button" value="ù��������" onClick="javascript:window.location='index.jsp'">
    	  <input type="button" value="ȸ����������" onClick="javascript:window.location='member_modify.jsp'">
    	  <input type="button" value="�α׾ƿ�" onClick="javascript:window.location='logout.jsp'">
  	  </div></td>
  </tr>
</table>
        

  </div>	
  <!-- header_right div ����-->
</div><!-- header div ����-->

<div id="body" style="width:100%;float:left;">
	<div id="body_upper_left" style="background-color:#FFFFFF;height:100px;width:100%; float:left; ">
	  <ul>

        <li>����Ʈ����Ư��ȭ�а�</li>
	    <li>��米��: �ڽ���</li>
	    <li>�л���: <%=(int)session.getAttribute("total_no")%>��</li>
	  </ul>
    </div> 


    <div id="body_left" style="height:500px;width:20%;float:left;"></div>

	<div id="body_center" style="height:500px;width:60%;float:left;">
       <script type="text/javascript">
       function fileCheck(fileValue)
       {
           //Ȯ���� üũ
           var src = getFileType(fileValue);
           if(!src){//������ ÷�ε��� ���� ���
        	   //alert("������ ÷�ε��� �ʾҽ��ϴ�.");
        	   document.frm.submit();//���� ���� ä�� �׳� submit
        	   }
           else{//������ ÷�ε� ���
	           if(!(src.toLowerCase() == "zip")){
	               alert("zip ���Ϸ� �����Ͽ� ÷�����ּ���.");
	               return;//����÷��ȭ������ ����
	           }
	           else{
	        	   //alert("zip������ �½��ϴ�.");
	        	   document.frm.submit();//������ �ִ� ��� zip������ ��쿡�� submit
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
        
		<%if(session.getAttribute("prof").equals('n')){
		%><table align="center"><tr><td><h3>[�л�] ���� ����</h3></td></tr></table><%}
		else{%><table align="center"><tr><td><h3>[����] ���� ���</h3></td></tr></table><%}%>
        
		<table class="table_noline" align="center">
        <tr>
        <td></td><td></td><td></td><td></td><td></td>
        </tr>
        <tr>
        <td colspan="5">

        <form name="frm" action="upload.jsp?assignment_no=<%=assignment_no%>&is_write=<%=is_write %>" method="POST" enctype="multipart/form-data" >

		<label>����: </label> <input type="text" name="text_title" style="height:20px;width:92%;text-align:left;"/>
		</td></tr>
        <tr>
        <td colspan="5">
	
		  <script src="./lib/ckeditor/ckeditor.js"></script>	  
            <textarea name="text_content"></textarea>            
            <script>
                CKEDITOR.replace('text_content',{toolbar : ''});
            </script>
        </td>
        </tr>
        <tr>
 

        		
        			 
        <td colspan="2">            <input type="file" name="s_file"/></td>
		<td colspan="2">
         <td align="center"><input type="button" value="�۾���" onclick="fileCheck(document.frm.s_file.value)"/> 
           <input type="button" value="���ư���" onClick="javascript:history.back()"></td>
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
   		 		    <%//���� �����ð� üũ
		    long lasttime=session.getLastAccessedTime();
		    session.setAttribute("lasttime", lasttime);
		    long createdtime=session.getCreationTime();
		    session.setAttribute("createdtime",createdtime);
		    long time_used=(lasttime-createdtime)/60000;///60000; /1000�ϸ� �ʴ����� ����. �׽�Ʈ���� 1000������ �ؼ� �׽�Ʈ 
		    session.setAttribute("time_used",time_used);
		    if(time_used>10){//�α������� 10���� ���� ���
		    %><script>alert("�α������� 10���� �������ϴ�.\n�ٽ� �α������ּ���.");
		    location.href="logout.jsp";</script><%}
		    else{%>
		    <!--���� ���� �ð�: <%=session.getAttribute("createdtime")%><br>
	 		���ǿ� ������ ������ �ð�: <%=session.getAttribute("lasttime")%>��<br>
	 		������Ʈ�� �ӹ� �ð�: <%=session.getAttribute("time_used")%>��<br>
	 		-->
	 		<%}%>
</body>
</html>
