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
String Cat = request.getParameter("addcat");
String SubCat = request.getParameter("addsubcat");
String Option = request.getParameter("addoptions");
System.out.println("Add CAtegory" +Cat);
System.out.println("Add CAtegory" +SubCat);
System.out.println("Add CAtegory" +Option);
String html1="";
String Email=session.getAttribute("email").toString();
String RejectedBy=session.getAttribute("mainuser").toString();
System.out.println("Transporter000  "  +RejectedBy);
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("Gpname  "  +usertypevalue);
String TypeofUser=session.getAttribute("TypeofUser").toString();
System.out.println("TypeofUser  "  +TypeofUser);
if(TypeofUser.equalsIgnoreCase("Group"))
{
	GPName=usertypevalue;
	
	Transporter="-";
}
else
{
	GPName="-";
	Transporter=usertypevalue;
}

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
sql1 = "select * from db_gps.t_JourneyGoals where Categoery='"+Cat+"'and Categoery1='"+SubCat+"'and Options='"+Option+"' ";
ResultSet rs1 =stmt.executeQuery(sql1);

if(rs1.next())
{	response.sendRedirect("Standardadddemo.jsp?&msg=alreadypresent");
}

else{
	int a=0;
	String sql=" select max(srno) from db_gps.t_JourneyGoals";
	ResultSet rs3=stmt.executeQuery(sql);
	rs3.next();
	a=rs3.getInt(1);
	a++;

sql2 = "INSERT INTO db_gps.t_JourneyGoals (srno,Categoery,Categoery1,Options,GPName,Transporter,EntryBy) VALUES ('"+a+"','"+Cat+"', '"+SubCat+"', '"+Option+"','"+GPName+"','"+Transporter+"','"+RejectedBy+"')";
//System.out.println("Add Querry" +sql2);
st1.executeUpdate(sql2);
System.out.println("Add Querry1111111111111111111111111111111111" +sql2);


String add="yes";
response.sendRedirect("Standardadddemo.jsp?Parameter="+add);
}
}
catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>