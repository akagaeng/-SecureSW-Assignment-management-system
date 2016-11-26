<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>

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
  </div>	<!-- header_center div 종료-->

  <div id="header_right" style="background-color:#ffffff; width:30%;height:130px; float:left">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="85%"><div align="right"><a href="index.jsp"><img style="margin: 3px;" src="images/logo_right.png" alt="과제관리시스템" ></a></div></td>
            <td width="15%"></td>
          </tr>
          <tr>
            <td><div align="right">
            	<input type="button" value="로그인 페이지로" style="margin-right:25px;" onClick="javascript:window.location='index.jsp'">
            </div></td>
            <td></td>
          </tr>
    </table>
        
       
  </div>	
  	<!-- header_right div 종료-->
</div><!-- header div 종료-->


<div id="body" style="width:100%;float:left;">
	<div id="body_left" style="background-color:#FFFFFF;height:100px;width:100%; ">
	  <ul>
	    <li>관리자</li>
        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: $$명</li>
	  </ul>
    </div> 

	<div id="body_right" style="background-color:#FFFFFF;height:;width:80%;float:right;">
		<h3> 과제 관리: 명기가 수정예정.</h3>
		<table class="tableform">
	    <thead>
	    <tr>
	        <th scope="col">No.</th>
	        <th scope="col">제목</th>
	        <th scope="col">작성자</th>
	        <th scope="col">작성일</th>
	        <th scope="col">점수확인</th>
	    </tr>
	    </thead>

	    <tbody>
	    <tr>
	        <td scope="row">1</th>
			<td scope="row">Secure s/w 용어정리</td>
			<td scope="row">조인성</td>
			<td scope="row"></td>
			<td scope="row">
				<form action="" method="POST">
				<input type="submit" value="check" />
				</form>
			</td>
	    </tr>
        </tbody>

		<tr>
			<td colspan="5" height="200px">
            	<div id="content">
                    <p>내용이 들어가야할 자리<br>
                    div로 처리하여 왼쪽정렬<br>
                     나중에 DB에서 뽑아와서 내용 출력..AND grading.jsp로 이동하도록하여 교수님이 점수부여 가능하도록 하여야함. 학생은 그냥 학점 볼수있고 입력전에는 "미입력"으로 노출되도록</p>
                    <p>&nbsp;</p>
				</div>
            </td>
		</tr>

		<td colspan="3" height=""></td>
		<td>첨부파일
			<img id="download_img" src="images/file.gif" alt="file">
        </td>
		<td>
        	점수: A
		</td>
        </tr>
        </table>
        
  	    <br>
   	    <br>
	  <form name="list" method="post" action="board_list.jsp">

          <input type="submit" name="list" value="목록" style="margin-left:750px">
          		<input type="button" value="수정" onClick="javascript:window.location='board_modify.jsp'">
      </form>
      
        </td>
        </tr>


      </table>
       
		
		
    </div> 
    
</div>