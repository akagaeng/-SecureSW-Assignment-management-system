<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html><title>page5랑 6이랑 통합한거-경석</title>
<link rel="stylesheet" href="p5_Style.css">
<style type="text/css">
<!--
.style1 {
	font-size: 16px;
	font-weight: bold;
}
-->
</style>
<body>
<div id="container" style="width:100%">

<div id="header" style="width:100%">
	<div id="header_left" style="background-color:#FFFFFF; width:40%;height:91px; float:left">
	
    <img src="images/aj_logo.png" width="296" height="91"></div>
   	<div id="header_center" style="background-color:#FFFFFF; width:20%; height:91px;float:left">
	<h1 align="center" style="margin-bottom:0;"></h1>
    </div>
  	<div id="header_right" style="background-color:#FFFFFF; width:40%; height:91px;float:left">
  	  <div id="header_right_up" align="center">
  	    <p>Report registration site<br>
  	    </p>
      </div>
  	  <form action="" method="post"><div align="right" float="right">
	  <div align="center">
	    <input name="register" type="button" value="register">
	    <input name="logout" type="button" value="logout">
        </div>
	</div>
   </form>
	
    </div>
</div>

<div id="body" style="width:100%; float:left; text-align:left;">
	<div id="body_left" style="background-color:#FFFFFF;height:100px;width:30%;">
	  <ul>
	    <li>관리자</li>
        <li>소프트웨어특성화학과</li>
	    <li>담당교수: 박신혜</li>
	    <li>학생수: $$명</li>
	  </ul>
    </div> 

	<div id="body_center" style="background-color:#FFFFFF;height:;width:20%;float:left;"></div> 
    
   	<div id="body_right" style="background-color:#FFFFFF;height:;width:80%;float:right;">
		<strong>가입 승인 대기자 $명</strong><br>
		<br>
		
	  <form name="form1" method="post" action="">
		  <label>선택 멤버를 </label>
          <label>
          <input type="button" name="approve" id="approve" value="가입승인">
          </label>
          <label>
          <input type="button" name="decline" id="decline" value="가입거절">
          </label>
	  </form>
		
        <p></p><br>
      <table class="tableform" width="80%" border="0" cellspacing="0" cellpadding="0">
        <thead>
          <tr>
            <th scope="col"><form name="form2" method="post" action="">
              <label>
              <input type="checkbox" name="checkbox" id="checkbox">
              </label>
            </form>
            </th>
            <th scope="col">별명(아이디)</th>
            <th scope="col">가입신청일</th>
            <th scope="col">신분(학생/교수)</th>
            <th scope="col">비고</th>
            </tr>
                    </thead>
                    <tbody>
            <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">양갱(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">신분(학생/교수)</td>
            	<td scope="col">비고</td>
          	</tr>
            
                        <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">양갱(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">신분(학생/교수)</td>
            	<td scope="col">비고</td>
          	</tr>
            
                        <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">양갱(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">신분(학생/교수)</td>
            	<td scope="col">비고</td>
          	</tr>
            
                        <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">양갱(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">신분(학생/교수)</td>
            	<td scope="col">비고</td>
          	</tr>
            </tbody>
      </table>
   	    <br>
   	    <br>
   	    <label>선택 멤버를 </label>
        <label>
        <input type="button" name="approve2" id="approve2" value="가입승인">
        </label>
        <label>
        <input type="button" name="decline2" id="decline2" value="가입거절">
        </label>
        <br>
      <br> 
        <br>
   	
</div>

<div id="footer" style="width:100%; float:left; text-align:center;">
	<div id="footer_left" style="background-color:;height:100px;width:10%;float:left;"></div> 

    <div id="footer_center" style="background-color:;height:100px;width:80%;float:left;"></div> 

   	<div id="footer_right" style="background-color:;height:100px;width:10%;float:left;"></div> 
  </div> 
</div>
</body>
</html>
