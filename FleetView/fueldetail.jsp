<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*"
    import=" java.util.regex.Matcher" import ="java.util.regex.Pattern"
        pageEncoding="UTF-8"%>
<%
try
{
	
	String datenew1=request.getParameter("datenew1");
	String firstodo=request.getParameter("firstodo");
	String firstgps=request.getParameter("firstgps");
	String datenew2=request.getParameter("datenew2");
	String lastodo=request.getParameter("lastodo");
	String lastgps=request.getParameter("lastgps");
	String finalodo=request.getParameter("finalodo");
	String finalgps=request.getParameter("finalgps");
	
	

%>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fuel Details</title>
</head>
<body

>
<style>td{font-family:Arial;font-size:15px;}

</style>
<div>
	
<table border=1 cellpadding=0 cellspacing=0 align=center style="background: #EFF5FB	;width: 100%">
<tr>
<td><b>Fuel</b></td>
<td><b>Date</b></td>
<td><b>Odo</b></td>
<td><b>GPS</b></td></tr>
<tr><td>Last</td><td align="right"><%=datenew2 %></td><td align="right"><%=lastodo %></td><td align="right"><%=lastgps %></td></tr>
<tr><td>First</td><td align="right"><%=datenew1 %></td><td align="right"><%=firstodo %></td><td align="right"><%=firstgps %></td></tr>

<tr><td>Difference</td><td>-</td><td align="right"><%=finalodo %></td><td align="right"><%=finalgps %></td></tr>
</table>

</div>	
</body>
<%
}catch(Exception e)
{
e.printStackTrace();
}
%>
</html>