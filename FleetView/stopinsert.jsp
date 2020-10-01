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
String count=request.getParameter("cnt");
 String fromDateTime=request.getParameter("");
 String tripID=request.getParameter("");
String toDateTime=request.getParameter("");
 String duration=request.getParameter("");
 String location=request.getParameter("");
 String locationComment=request.getParameter("");
 
 String startDate=request.getParameter("startDate");
 String endDate=request.getParameter("endDate");
 String locality="",localityType="",stopReason="",startPlace="",endPlace="";
 String trans="";
 String gpName="";
int i=Integer.parseInt(count);
int insert=0;
String sql="";
String msg="";
//System.out.println("i===>"+i);
try{           
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	
for(int j=1;j<=i;j++){
	tripID=request.getParameter("tripid"+j);
	fromDateTime=request.getParameter("startdate"+j);
	//System.out.println(fromDateTime);
	toDateTime=request.getParameter("enddate"+j);
	duration=request.getParameter("duration"+j);
	location=request.getParameter("loc"+j);
	locality=request.getParameter("locality"+j);
	localityType=request.getParameter("localitytype"+j);
	stopReason=request.getParameter("stopreason"+j);
	locationComment=request.getParameter("comment"+j);
	startPlace=request.getParameter("startPlace"+j);
	endPlace=request.getParameter("endPlace"+j);
	trans = request.getParameter("trans"+j);
	gpName = request.getParameter("gpname"+j);
	if("".equalsIgnoreCase(stopReason)){
		
	}
	else{
		sql="insert into t_tripstopdetails (TripID,fromDateTime,toDateTime,Duration,Location,LocalityName,LocalityType,ReasonforStoppage,Remark) values ('"+tripID+"','"+fromDateTime+"','"+toDateTime+"','"+duration+"','"+location+"','"+locality+"','"+localityType+"','"+stopReason+"','"+locationComment+"')";
	insert=stmt.executeUpdate(sql);
	}
		
	
}	
trans = request.getParameter("trans");
gpName = request.getParameter("gpname");
if(insert>0){
	msg="inserted";
	//System.out.println("msg====>"+msg);
	int c=0;
	String sql1 = "insert into db_gps.t_stopReport (tripId,transporter,GPName,stopEntry) values ('"+tripID+"','"+trans+"','"+gpName+"','Yes')";
	c = stmt.executeUpdate(sql1);
	response.sendRedirect("stop.jsp?msg=inserted&tripid="+tripID+"&startDate="+startDate+"&endDate="+endDate+"&startPlace="+startPlace+"&endPlace="+endPlace+"&transporter="+trans+"");
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