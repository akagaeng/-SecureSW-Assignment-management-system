<%@ page contentType="text/html; charset=euc-kr" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html><title>page5�� 6�̶� �����Ѱ�-�漮</title>
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
	    <li>������</li>
        <li>����Ʈ����Ư��ȭ�а�</li>
	    <li>��米��: �ڽ���</li>
	    <li>�л���: $$��</li>
	  </ul>
    </div> 

	<div id="body_center" style="background-color:#FFFFFF;height:;width:20%;float:left;"></div> 
    
   	<div id="body_right" style="background-color:#FFFFFF;height:;width:80%;float:right;">
		<strong>���� ���� ����� $��</strong><br>
		<br>
		
	  <form name="form1" method="post" action="">
		  <label>���� ����� </label>
          <label>
          <input type="button" name="approve" id="approve" value="���Խ���">
          </label>
          <label>
          <input type="button" name="decline" id="decline" value="���԰���">
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
            <th scope="col">����(���̵�)</th>
            <th scope="col">���Խ�û��</th>
            <th scope="col">�ź�(�л�/����)</th>
            <th scope="col">���</th>
            </tr>
                    </thead>
                    <tbody>
            <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">�簻(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">�ź�(�л�/����)</td>
            	<td scope="col">���</td>
          	</tr>
            
                        <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">�簻(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">�ź�(�л�/����)</td>
            	<td scope="col">���</td>
          	</tr>
            
                        <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">�簻(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">�ź�(�л�/����)</td>
            	<td scope="col">���</td>
          	</tr>
            
                        <tr>
              <td scope="col"><form name="form2" method="post" action="">
              <label><input type="checkbox" name="checkbox" id="checkbox"></label>
            </form>
            </td>

              <td scope="col">�簻(aaa)</td>
                <td scope="col">2015.11.11</td>
             	<td scope="col">�ź�(�л�/����)</td>
            	<td scope="col">���</td>
          	</tr>
            </tbody>
      </table>
   	    <br>
   	    <br>
   	    <label>���� ����� </label>
        <label>
        <input type="button" name="approve2" id="approve2" value="���Խ���">
        </label>
        <label>
        <input type="button" name="decline2" id="decline2" value="���԰���">
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
