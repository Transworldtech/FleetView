<html>
<%
	String modelno="-";
	String id = request.getParameter("id");
	String vehcode=request.getParameter("vehcode");
	 modelno=request.getParameter("cranemodno");
	String Alarmdate=request.getParameter("Alarmdate");
	String Status="No";
%>
<head>
<script language="JavaScript">
</script>
</head>
<body>
<table width="100%">
<tr><td><font size="2"><b>Crane Code :<%=id%></font></td></tr>
<tr><td><font size="2"><b>Crane ModelNo :<%=modelno%></font></td></tr>
<tr><td><font size="2"><b>Event Time <%=Alarmdate%></font></td></tr>

<tr><td colspan="3" align="center">
		<input type="button" value="OK" onclick="document.location.href='bypassinsert.jsp?vehcode=<%=vehcode%>'",  ajax_hideTooltip()  class="formElement">
		
</td></tr>
</table>
</body>
</html>
