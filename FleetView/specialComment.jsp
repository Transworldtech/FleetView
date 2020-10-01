<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="headerprintnew.jsp"%>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="100%" align="center" class="stats" border="1">
<tr>
<th>Sr No.</th>
<th>VehRegNo</th>
<th>Transporter</th>
<th>EntDateTime</th>
<th>Comment Type</th>
<th>ActionToBeTakenBy</th>
<!--<th>Comments</th>-->
<th>Status</th>
</tr>
<%
Connection connCust=null,connGPS=null;
Statement stCust=null , stGPS=null;
try{
	Class.forName(MM_dbConn_DRIVER); 
	connGPS = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stGPS=connGPS.createStatement();

int i=1;
final String commaSeparatedVehicleList = session.getAttribute("VehList").toString();

String sqlveh = " SELECT EntDateTime,VehRegNo,Transp,SpComment,								 "+
				"	ActionToBeTakenBy,Extra_comment , 															 "+
				"   CASE WHEN Closed = 'Yes' THEN 'Closed'														 "+
				"		 WHEN Closed = 'No' THEN 'Open' 												 		 "+
				"		 ELSE '' END AS status	         														 "+
				"	FROM                                                                                         "+
				"	(                                                                                            "+
				"	SELECT EntDateTime,TechName,VehRegNo,Transp,SpComment,                                       "+
				"	ActionToBeTakenBy,Extra_comment,cmmt_type ,visibleInFleetview,Closed                         "+
				"	FROM db_CustomerComplaints.t_techspecialrep                                                  "+
				"	)  spcomnt                                                                                   "+
				"	LEFT OUTER JOIN                                                                              "+
				"	(                                                                                            "+
				"		SELECT vehicleregnumber,vehiclecode,ownername                                            "+
				"		FROM db_gps.t_vehicledetails                                                             "+
				"		WHERE vehiclecode in "+ commaSeparatedVehicleList +"									 "+
				"	) veh ON (veh.vehicleregnumber=spcomnt.VehRegNo)                                             "+
				"	WHERE spcomnt.visibleInFleetview='Yes'                                                       "+
				"		AND spcomnt.cmmt_type = 'vehicle'                                                        "+
				"	ORDER BY spcomnt.EntDateTime DESC ";        
//System.out.println("Special Comment===>\n"+sqlveh);
ResultSet rsveh = stGPS.executeQuery(sqlveh);
while (rsveh.next())
{
%>
<tr>
<td><%=i++ %></td>
<td><%=rsveh.getString("VehRegNo") %></td>
<td><%=rsveh.getString("Transp") %></td>
<td><%=rsveh.getString("EntDateTime") %></td>
<td><%=rsveh.getString("SpComment") %></td>
<td><%=rsveh.getString("ActionToBeTakenBy") %></td>
<!--<td>< %=rsveh.getString("Extra_comment") %></td>-->
<td><%=rsveh.getString("status") %></td>
</tr>
<%
}

}
catch(Exception e)
{
	e.printStackTrace();
}
finally{
	
	connGPS.close();
}
%>

</table>
</body>
</html>