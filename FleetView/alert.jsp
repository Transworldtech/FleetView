<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
<html>
<head>
</head>
<body>
 <br><br>
<div align="center">
 <font color="red" size="3"><b><blink>
!!! ERROR in inserting <%=request.getParameter("fromPage") %> Form. Click "Go Back" and try again"
</blink></b></font></div>
 
 <div align="center">
<INPUT TYPE="BUTTON" VALUE="Go Back" 
ONCLICK="history.go(-1)">
 </div>
</body>
</html>