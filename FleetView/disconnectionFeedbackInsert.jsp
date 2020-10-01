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

 

 String tripID="",driverFeedback="",trainerFeedback="",status="";
 String rowid="";
 String trans="";
 String gpName="";
int i=Integer.parseInt(count);
int insert=0;
String sql="";
String msg="";
System.out.println("i===>"+i);
try{           
String vehicleCode = request.getParameter("vehicleCode");
String fromDateTime = request.getParameter("fromDateTime");
String toDateTime = request.getParameter("toDateTime");
String tripId = request.getParameter("tripid");
String ownerName = request.getParameter("ownername");

	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con.createStatement();
	
for(int j=1;j<=i;j++){
	
	driverFeedback = request.getParameter("driverfb"+j);
	System.out.println("driverFeedback===>"+driverFeedback);
	trainerFeedback = request.getParameter("trainerfb"+j);
	status = request.getParameter("status"+j);
	//rowid = Double.valueOf(request.getParameter("rowid"+j)).intValue();
	rowid = request.getParameter("rowid"+j);
	System.out.println("rowid===>"+rowid);
		sql="update db_gps.t_disconnectionData set driverFeedback='"+driverFeedback+"' , trainerfeedBack='"+trainerFeedback+"' , status='"+status+"' where rid='"+rowid+"'";
		System.out.println("sql===>"+sql);
	insert=stmt.executeUpdate(sql);
	
	
}	
trans = request.getParameter("trans");
gpName = request.getParameter("gpname");
if(insert>0){
	msg="inserted";
	//System.out.println("msg====>"+msg);
	int c=0;
	
	response.sendRedirect("disconnectionFeedBack.jsp?msg=inserted&ownername="+ownerName+"&vehicleCode="+vehicleCode+"&tripid="+tripId+"&fromDateTime="+fromDateTime+"&toDateTime="+toDateTime);
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