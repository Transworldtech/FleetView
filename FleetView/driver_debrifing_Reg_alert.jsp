<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
<html>
<head>
</head>
<body>
 <br><br>
<div align="center">
 <font color="red" size="3"><b><blink>
 <%
 String veh=request.getParameter("veh");
	String  driverid=request.getParameter("driverid");

if(veh.equalsIgnoreCase("-"))
{
%>
!!! Can not Register "<%=driverid %>"  Driver, As it is Rejected . Click "Go Back" and Pass the driver"
<%
}
if(driverid.equalsIgnoreCase("-"))
{
%>
!!! Can not Register "<%=veh %>"  Vehicle , As it is Rejected . Click "Go Back" and Pass the Vehicle"
<%
}



%>



</blink></b></font></div>
 
 <div align="center">
<INPUT TYPE="BUTTON" VALUE="Go Back" 
ONCLICK="history.go(-1)">
 </div>
</body>
</html>