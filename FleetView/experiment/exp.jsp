<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="java.sql.Timestamp"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%Timestamp startTime = null;
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("2009-08-01"+" "+"11:11:11");
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				startTime = new Timestamp(ShowDate1.getTime());
				 %>
				 <%=startTime %>
</body>
</html>