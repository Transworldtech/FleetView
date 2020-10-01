<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="Connections/conndriver.jsp" %>
<%! 
Connection con ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
final String tripid=request.getParameter("tripid");
final String startDate=request.getParameter("startDate");
final String endDate=request.getParameter("endDate");
int insert=0;
try{           
	System.out.println("nw in page reason of rejection");	
	Class.forName(MM_dbConn_DRIVER);
		con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt=con.createStatement();
		Statement st1=con.createStatement();
		String sql="select * from t_completedjourney where tripid='"+tripid+"'";
		ResultSet rs=stmt.executeQuery(sql);
		if(rs.next()){
			String vehicleCode=rs.getString("Vehid");
			
			String vehicleRegistrationNum=rs.getString("VehRegNo");
			String sqlVeh="select 	a.VehicleRegNumber as VehicleRegNumber,a.VehicleCode,a.UnitID ,b.Peripherals as Peripherals " +
							"FROM ( " +
							"		SELECT 	VehicleRegNumber,VehicleCode,UnitID,OwnerName	" +
							"	FROM t_vehicledetails " +
							")a " +
							"LEFT OUTER JOIN " +
							"	(" +
							"		SELECT Peripherals,unitid " +
							"	FROM db_gps.t_unitmasterhistory  " +
							"	WHERE concat(EntDate, EntTime) BETWEEN '"+startDate+"' AND '"+endDate+"'  " +
							"	)b ON (a.unitid=b.unitid) " +
							"   WHERE a.VehicleCode = '"+vehicleCode+"'";
			
			ResultSet rs1=st1.executeQuery(sqlVeh);
			if(rs1.next()){
				String unitType=rs1.getString("Peripherals");
				if(null==unitType || "null".equalsIgnoreCase(unitType) || "".equalsIgnoreCase(unitType)){
					unitType="-";
				}
				System.out.println(tripid+"---"+vehicleRegistrationNum+"---"+unitType);
				out.println(tripid+"#"+vehicleRegistrationNum+"#"+unitType);
			}
		}
		else{
			out.println("notinserted");
		}
		
	}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>