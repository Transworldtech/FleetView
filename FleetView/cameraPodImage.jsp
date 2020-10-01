<%@ page language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
String s1=request.getParameter("imageName");
/*
System.out.println(s1);
System.out.println(s1+"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+s1.replace("%"," ")); 
s1=s1.replace("%"," ");
*/
System.out.println(s1);

%>
<img src="http://myfleetview.com/images1/ProcessedCameraAndPodImages/<%=s1%>"></img> 

</body>
</html>