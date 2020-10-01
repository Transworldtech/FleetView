<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
ResultSet rs1=null;
String sql="";
String veh="",vehid="",transporter="",present="No",sertype="",distance="0",date="",nxtdate="",nxtdate1="";
veh=request.getParameter("veh");
sertype=request.getParameter("sertyp");
date=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("date")));

sql="select DATE_ADD('"+date+"' , INTERVAL 6 MONTH) As Date";
ResultSet rst3=stmt1.executeQuery(sql);
if(rst3.next())
{
	nxtdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst3.getString("Date")));
}
sql="select DATE_ADD('"+date+"' , INTERVAL 12 MONTH) As Date";
ResultSet rst4=stmt1.executeQuery(sql);
if(rst4.next())
{
	nxtdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst4.getString("Date")));
}


sql="select VehicleCode from t_vehicledetails where VehicleRegNumber ='"+veh+"'";
try
{
rs1=stmt1.executeQuery(sql);
if(rs1.next())
{
	vehid=rs1.getString("VehicleCode");
	//transporter=rs1.getString("OwnerName");
}
}
catch(Exception e)
{
	
}

sql="select Distance from t_veh"+vehid+" where TheFieldDataDate <= '"+date+"' and TheFiledTextFileName='SI' order by TheFieldDataDate desc limit 1";
System.out.println(sql);
try
{
ResultSet rs2=stmt1.executeQuery(sql);
if(rs2.next())
{
	 int dt =  Math.abs(rs2.getInt("Distance"));
	distance=""+dt;
	//transporter=rs1.getString("OwnerName");
}
}catch(Exception e)
{
	
}

sql="select * from t_lastservice where Vehid ='"+vehid+"' and ServiceType='"+sertype+"' and AlertStatus='Pending'";
ResultSet rst=stmt1.executeQuery(sql);
if(rst.next())
{
	present="Yes";
}
out.print(present+"#"+distance+"#"+nxtdate+"#"+nxtdate1);

} catch(Exception e) {out.println(e);}

finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
}

%>