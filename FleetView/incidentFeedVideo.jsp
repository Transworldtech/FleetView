<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Incident Feedback Form Video</title>
</head>
<body>
<%
String vdo=request.getParameter("vdoFile");
System.out.println("Video File name==========>>"+vdo);
//vdo="Incident10.swf";
response.sendRedirect(vdo);
%>
</body>
</html>