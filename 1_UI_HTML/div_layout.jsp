<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html>
<html><title>div</title>
<body>
<div id="container" style="width:100%">

<div id="header" style="width:100%">
	<div id="header_left" style="background-color:#FFFF00; width:10%;height:100px; float:left">
	head_L
	</div>
   	<div id="header_center" style="background-color:#FF9900; width:80%; height:100px;float:left">
	<h1 align="center" style="margin-bottom:0;">head_C</h1>
    </div>
  	<div id="header_right" style="background-color:#FF3300; width:10%; height:100px;float:left">
	<h1 align="center" style="margin-bottom:0;">head_R</h1>
    </div>
</div>

<div id="body" style="width:100%;float:left;text-align:center;">
	<div id="body_left" style="background-color:#FFFFFF;height:100px;width:10%;float:left;">
		body_L
    </div> 

	<div id="body_center" style="background-color:#DDDDDD;height:100px;width:80%;float:left;">
		body_C
    </div> 
    
   	<div id="body_right" style="background-color:#BBBBBB;height:100px;width:10%;float:right;">
		body_R
    </div> 
</div>

<div id="footer" style="width:100%; float:left; text-align:center;">
	<div id="footer_left" style="background-color:#00CC00;height:100px;width:10%;float:left;">
    footer_L
    </div> 

    <div id="footer_center" style="background-color:#FF33FF;height:100px;width:80%;float:left;">
    footer_C
    </div> 

   	<div id="footer_right" style="background-color:#0099FF;height:100px;width:10%;float:left;">
    footer_R
    </div> 
    </div> 
</div>
</body>
</html>
