
<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Connection conn1;

%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/JavaScript">
		//alert("Data inserted successfully");
		redirectTime = "100";
		redirectURL = "castrolempmain.jsp";
		window.onload=function(){
			setTimeout("location.href = redirectURL;",redirectTime);
}

</script>

</head>
<body>

<%
String firstName="", lastName="";
firstName=request.getParameter("firstName");
firstName=Character.toString(firstName.charAt(0)).toUpperCase()+ firstName.substring(1); ;

 lastName=request.getParameter("lastName");
 lastName=Character.toString(lastName.charAt(0)).toUpperCase()+ lastName.substring(1); ;
 
String vehcode=request.getParameter("vehcode");

String name=firstName+" "+lastName;

String vehType=request.getParameter("vehType");
String empCode=request.getParameter("empCode");
String mobileNo=request.getParameter("mobileNo");


try
{
	Class.forName(MM_dbConn_DRIVER);
	Connection con1;
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con1.createStatement();
	Statement st2=con1.createStatement();
	ResultSet st;
	String empName="";
	
	String sql="update t_vehicledetails set Empname='"+name+"', vehtype='"+vehType+"', Empcode='"+empCode+"', MobilePhNo='"+mobileNo+"' where vehiclecode="+vehcode+"  limit 1 ";
	
	stmt.executeUpdate(sql);
	
	String sql2="update  db_gps.t_userdetails set  FirstName='"+firstName+"', LastName='"+lastName+"' where Vehid='"+vehcode+"'  limit 1";
	System.out.println(" sql2 "+sql2);
	st2.executeUpdate(sql2);
	
	out.println("<script>alert('Updated Successfully')</script>");
	
	
	
}catch(Exception e)
{
	
	System.out.println("Exception in upodate"+e.getMessage());
	
}
%>



</body>
</html>
</jsp:useBean>