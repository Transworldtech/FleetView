
<%@page import="java.util.Date"%><%@ include file="Connections/conn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Close Satatus</title>
</head>
<body>
<form name="closeform" action="" method="post" >
<div align="center">
<table>
<tr><td><font size="3">Click to close</font></td></tr>
<tr><td><input type="Submit"  name="close" value="close"></td></tr>
</table>
</div>
<br><br><br><br>
<div align="center">
<table>
<tr>
<!-- <td colspan="2" align="center"><a href="javascript:window.close();">Close </a> </td></tr>-->
</table>
</div>
</form>

<%!
Connection con;
Statement st;
%>

<%
try{
String vehid="",vehcode="",servicetype="",servicedate="";
vehid=request.getParameter("VehicleRegNo");
vehcode=request.getParameter("vehcode");
servicetype=request.getParameter("servicetype");
servicedate=request.getParameter("servicedate");
String servicedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MM-yyyy").parse(servicedate));
//System.out.println("servicedate1==>"+servicedate1);
//out.println("\n vehcode=>"+vehcode);
//System.out.println("vehcode=>"+vehcode);
//out.println("\n vehicleregno==>"+vehid);
//out.println("\n servicetype=>"+servicetype);
//out.println("\n servicedate==>"+servicedate);
String closed=request.getParameter("close");
//out.println("\n closed==>"+closed);



Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con.createStatement();
String closesql="";
if(!(closed.equalsIgnoreCase(null)) || !(closed.equals("")) )
{
closesql="update t_lastservice set AlertStatus='closed' where Vehid='"+vehcode+"' and VehRegNo='"+vehid+"' and ServiceType='"+servicetype+"' and ServiceDate='"+servicedate1+"' ";
st.executeUpdate(closesql);
//out.println("\n updated");
//out.println("closesql==>"+closesql);
}		
}catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>
</html>