<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Show Reason Form</title>

</head>
<body>

<%
String Reason=request.getParameter("reason");

%>

<form name="veh_showreason" >
<h1 style="background-color:#6F9BEE;" align="center"><font size="4" face="Arial" color="white"><b>Night Driving Reason</b></font></h1>

<table border="0" align="left" style="font-family: arial;font-size:12;">

<tr>
<td><font size="2" face="Arial"></font></td>

<td>
<%=Reason %>
</td>
	 
</tr>



</table>



</form>


</body>
</html>