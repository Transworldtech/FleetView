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
 String TripId=request.getParameter("TripId");
	String  driverid=request.getParameter("driverid");

%>
'<%=TripId%>' Trip Id is already register for '<%=driverid %>' Driver.



</blink></b></font></div>
 
 <div align="center">
<INPUT TYPE="BUTTON" VALUE="Ok" 
ONCLICK="history.go(-1)">
 </div>
</body>
</html>