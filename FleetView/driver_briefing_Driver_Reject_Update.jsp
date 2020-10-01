<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
Connection con=null ;
String driverid = request.getParameter("driverid");

//String VehName=request.getParameter("oldVeh");

System.out.println("driverid  "+driverid);
String uid="",HODID="",GPName="",VehicleRegNumber="";

try{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	Statement stmt1=con.createStatement();
	Statement stmt2=con.createStatement();


String sql1 = "SELECT * FROM `t_reasonOfRejectionForDriver` WHERE DriverId='"+driverid+"' and ReasoneForRejection='Driver Rejection' ORDER BY `t_reasonOfRejectionForDriver`.`UpdatedDateTime` DESC";
ResultSet rst1 = stmt1.executeQuery(sql1);
System.out.println("**   "+sql1);

if(rst1.next())
{
	
				
				String sql3 = "insert into db_gps.t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,status) values ('"+driverid+"','Driver Rejection','No')";
				System.out.println(sql3);
				int i=0;
				i=stmt1.executeUpdate(sql3);
				if(i>=1)
				{
					System.out.println("Pass1");
				response.sendRedirect("driver_briefing_Driver_Reject.jsp?msg=UP");
				}else
					{
					System.out.println("Pass2");
						response.sendRedirect("driver_briefing_Driver_Reject.jsp?msg=NUP");

					}
				
				/*
				//Set Active Status is No
				String sql11 = "Update db_gps.t_group Set Active='No' where VehCode='"+NewVehId+"'";
				//System.out.println(sql11);
				int i1=0;
				i1=stmt1.executeUpdate(sql11);
				
								
							
				// To Insert in t_group
				
				String sql12 = "insert into db_gps.t_group (GPName,VehRegno,transporter,VehCode,SepReport,Active) values ('"+GPName+"','"+GPName+"','"+VehicleRegNumber+"','"+NewVehId+"','Yes','Yes')";
				//System.out.println(sql12);
				int i2=0;
				i2=stmt2.executeUpdate(sql12);
				
							
				
				//To Update in Vehiclew Details
				
				String sql13 = "Update db_gps.t_vehicledetails Set Empname='"+uname+"' where VehicleCode='"+NewVehId+"'";
				//System.out.println(sql13);
				int i3=0;
				i3=stmt3.executeUpdate(sql13);
								
				
				//Top Insert in t_empallocationhistory
				
				String sql14 = "insert into db_gps.t_empAllocationHistory (VehNo,VehicleCode,EmpName) values ('"+VehicleRegNumber+"','"+NewVehId+"','"+uname+"')";
				//System.out.println(sql14);
				int i4=0;
				i4=stmt4.executeUpdate(sql14);
				
				
				
				
				
				//to Insert in t_gGroupHistory
			
				String sql16 = "Update db_gps.t_grouphistory Set Active='No' where VehCode='"+NewVehId+"'";
				System.out.println(sql16);
				int i6=0;
				i6=stmt6.executeUpdate(sql16);
				
				
				
				
				String sql15 = "insert into db_gps.t_grouphistory (GPName,VehRegno,transporter,VehCode,Active) values ('"+GPName+"','"+VehicleRegNumber+"','"+GPName+"','"+NewVehId+"','Yes')";
				System.out.println("SQL 5 : "+sql15);
				int i5=0;
				i5=stmt5.executeUpdate(sql15);
				*/
				
				
				
				
				
}
else
{
	System.out.println("Pass3");
	response.sendRedirect("driver_briefing_Driver_Reject.jsp?msg=NUP");

}

}
catch(Exception e){
	e.printStackTrace();
	//System.out.print(e);
	System.out.println("Pass4");
	response.sendRedirect("driver_briefing_Driver_Reject.jsp?msg=NUP");
}
finally
{
	con.close();
	}
%>
</body>
</html>