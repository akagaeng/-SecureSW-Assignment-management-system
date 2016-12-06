<%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css">
<title>Log Out</title>
</head>
<body>
<%
	session.setAttribute("userid", null);
	session.invalidate();	//모든 세션정보 삭제
	response.sendRedirect("index.jsp");	//index페이지로 돌아감
%>

</body>
</html>
