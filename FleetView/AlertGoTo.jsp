<%@page import="java.util.Date"%>
<html>
<head>
<script language="JavaScript">
function loadalert (msg,gotoPage) 
{
	alert(msg);
	window.location = gotoPage;
	window.opener.location.reload();
	window.close();
}

</script>
</head>
<body onLoad="loadalert('<%=request.getParameter("msg") %>','<%=request.getParameter("goto") %>')">
<table>
<tr><td>.</td></tr>
</table>
<% 
String msg="";
%>
<%
msg=request.getParameter("msg");
%>
</body>
</html>