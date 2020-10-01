<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ include file="Connections/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection con ;
String GPName="",Transporter="";
String zoomret= request.getParameter("zoom1");
String zoomlat = request.getParameter("zoomlat");
String zoomlon = request.getParameter("zoomlon");
System.out.println("Add zoom" +zoomret);
System.out.println("Add zoomlat" +zoomlat);
System.out.println("Add zoomlon" +zoomlon);
//String html1="";
//String Email=session.getAttribute("email").toString();
String mainuser=session.getAttribute("mainuser").toString();
System.out.println("Transporter000  "  +mainuser);
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("Gpname  "  +usertypevalue);
//String TypeofUser=session.getAttribute("TypeofUser").toString();
//System.out.println("TypeofUser  "  +TypeofUser);
/*if(TypeofUser.equalsIgnoreCase("Group"))
{
	GPName=usertypevalue;
	
	Transporter="-";
}
else
{
	GPName="-";
	Transporter=usertypevalue;
}*/

try{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
	Statement stmt6=con.createStatement();
	
	Statement stmt3=con.createStatement();
	Statement stmt2=con.createStatement();
	Statement st1=con.createStatement();
	
String sql1 ="",sql2 ="",sql3 ="",sql4 ="",sql5 ="",sql6=""; 
/*sql1 = "select * from db_gps.t_security where Mapzoomlevel='"+zoomret+"'and Mapceterlat='"+zoomlat+"'and Mapcenterlon='"+zoomlon+"' and Username='"+mainuser+"' ";
ResultSet rs1 =stmt.executeQuery(sql1);
System.out.println("Add Querry1111111111" +sql1);
if(rs1.next())
{	response.sendRedirect("home.jsp?&msg=alreadypresent");
}*/

//else{
	
sql2 = "update db_gps.t_security set Mapzoomlevel='"+zoomret+"',Mapceterlat='"+zoomlat+"',Mapcenterlon='"+zoomlon+"' where Username='"+mainuser+"' ";
System.out.println("Add Querry" +sql2);
st1.executeUpdate(sql2);
System.out.println("Add Querry1111111111111111111111111111111111" +sql2);


String add="yes";
response.sendRedirect("home.jsp?Parameter="+add);
//}
}
catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>