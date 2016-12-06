<%@ page language="java" contentType="text/html; charset=EUC-KR" import="java.sql.*,java.util.*,java.text.*"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
java.util.Date dt = new java.util.Date();

SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
String dateString = dateFormatter.format(dt); 

//out.println(dateString);

//String pwc=(String)session.getAttribute("register_date");
String pwc="20151001";
String now=(String)session.getAttribute("dateString");

int year_now, month_now, day_now;
int year_reg, month_reg, day_reg;
int cha;
year_now=Integer.parseInt(now.substring(0,4));
year_reg=Integer.parseInt(pwc.substring(0,4));

month_now=Integer.parseInt(now.substring(4,6));
month_reg=Integer.parseInt(pwc.substring(4,6));

day_now=Integer.parseInt(now.substring(6));
day_reg=Integer.parseInt(pwc.substring(6));

//총 날 년도 차이*365+월차이*30+일 차이
cha = (year_now-year_reg)*365+(month_now-month_reg)*30+(day_now-day_reg);
out.println(cha);

%>

</body>
</html>