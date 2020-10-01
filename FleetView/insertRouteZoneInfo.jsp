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

int insert=0;
String sql="";
String msg="";
//System.out.println("i===>"+i);
try{           
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	

	String tripID=request.getParameter("tripid");
	String driverid=request.getParameter("tripid");
	String trans = request.getParameter("transporter");
	String vehid = request.getParameter("vehid");
	String lat = request.getParameter("lat");
	String lon = request.getParameter("lon");
	String location=request.getParameter("startplace");
	String distance = request.getParameter("dist");
	String duration=request.getParameter("duration");
	String roadCondtn =request.getParameter("roadcondt");
	String deviationType=request.getParameter("deviationType");
	
	
	
		sql="insert into t_routeZoneDetails (TripID,driverid,transporter,vehid,lat,lon,location,distance,duration,roadCondtnComm,typeOfDeviation) values ('"+tripID+"','"+driverid+"','"+trans+"','"+vehid+"','"+lat+"','"+lon+"','"+location+"','"+distance+"','"+duration+"','"+roadCondtn+"','"+deviationType+"')";
	insert=stmt.executeUpdate(sql);
	
if(insert>0){
	msg="inserted";
	//System.out.println("msg====>"+msg);
	
	response.sendRedirect("routeZoneFeedbackForm.jsp?ins="+msg+"&tripid="+tripID+"&driverid="+driverid+"&transporter="+trans+"&vehid="+vehid+"&lat="+lat+"&lon="+lon+"&startplace="+location+"&deviationType="+deviationType);
}

	}catch(Exception e){
	e.printStackTrace();
}
	finally{
		try
		{
			con.close();
		}catch(Exception ee)
		{
			
		}
	}
	
%>
</body>
</html>