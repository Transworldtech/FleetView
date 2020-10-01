<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
      <%@ include file="Connections/conndriver.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection con=null;
String VehRNo = request.getParameter("VehRNo");

String uid="",HODID="",GPName="",VehicleRegNumber="";

try{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
	Statement stmt2=con.createStatement();


String sql1 = "SELECT * FROM `t_reasonOfRejectionForDriver` WHERE VehRegNo='"+VehRNo+"' and ReasoneForRejection='Vehicle Rejection' ORDER BY `t_reasonOfRejectionForDriver`.`UpdatedDateTime` DESC";
ResultSet rst1 = stmt1.executeQuery(sql1);
if(rst1.next())
{
	
				
				String sql3 = "insert into db_gps.t_reasonOfRejectionForDriver (DriverId,VehRegNo,ReasoneForRejection,status) values (0,'"+VehRNo+"','Vehicle Rejection','No')";
				int i=0;
				i=stmt1.executeUpdate(sql3);
				if(i>=1)
				{
				
				response.sendRedirect("driver_briefing_Vehicle_Reject.jsp?msg=UP");
				}else
					{
					
						response.sendRedirect("driver_briefing_Vehicle_Reject.jsp?msg=NUP");

					}
				
				
				
}
else
{
		response.sendRedirect("driver_briefing_Vehicle_Reject.jsp?msg=NUP");

}

}
catch(Exception e){
	e.printStackTrace();
	response.sendRedirect("driver_briefing_Vehicle_Reject.jsp?msg=NUP");
}
finally
{
	con.close();
	}
%>
</body>
</html>