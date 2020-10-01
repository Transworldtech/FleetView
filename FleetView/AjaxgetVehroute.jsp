<%@ include file="Connections/conn.jsp" %>


<%!
Connection con1;
%>

<%
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt1=con1.createStatement();
Statement st1=con1.createStatement();
Statement st2=con1.createStatement();
Statement st3=con1.createStatement();

ResultSet rs1=null;
String sql1="";

String sql2="";
String sql3="";


String Vehregno=request.getParameter("VehRegNo");
String token[] = Vehregno.split(",");

String routeID="";
String unitid="";

String str1="Route Name";
String routeName="";



sql1="select UnitID from t_vehicledetails where vehicleregnumber='"+token[0]+"'";
System.out.println(sql1);
rs1=stmt1.executeQuery(sql1);

while(rs1.next())
{
	unitid=rs1.getString("UnitID");
}

System.out.println("unit id=====>"+unitid);

if(unitid=="0" ||unitid== ""||unitid==null || unitid.equals("0")||unitid.equals("")||unitid.equalsIgnoreCase("null")||unitid.contains("-"))
{
	System.out.println("*********   "+unitid);
	out.print("No Route in device");

}
else
{
sql2="select routeid from t_ftplastdump where UnitID='"+unitid+"'";
ResultSet rs=st1.executeQuery(sql2);

while(rs.next())
{
	routeID=rs.getString("routeid");
}
}
System.out.println("route id=====>"+routeID);

if(routeID=="0" ||routeID== ""||routeID==null || routeID.equals("0")||routeID.equals("")||routeID.equalsIgnoreCase("null")||routeID.contains("-"))
{
	System.out.println("*********   "+routeID);
	out.print("No Route in device");

}
else
{
	sql3="select rname from jrmallroute where routeid='"+routeID+"'";
	ResultSet rs2=st2.executeQuery(sql3);
	while(rs2.next())
	{
		routeName=rs2.getString("rname");
	}
	
	System.out.println("route name=====>"+routeName);
	String Rname=str1+": "+routeName;
	StringBuffer str=new StringBuffer("");
	str.append("<table border='1' width='100px' class='sortable' style='width:100px;' align='left'><tr><th>Zone</th><th>ZoneCount</th><th>Zone Dist</th></tr>");
	String SqlRoute="select * from db_gps.t_jrmroutemaster where RouteID='"+routeID+"'";
	ResultSet rsRoute=st3.executeQuery(SqlRoute);
	if(rsRoute.next())
	{
		str.append("<tr><td align='left'><div align='left'>Red</div></td><td align='right'><div align='right'>"+rsRoute.getString("redzonecount")+"</div></td><td align='right'><div align='right'>"+rsRoute.getString("redzonedist")+"</div></td></tr> " );
		str.append("<tr><td align='left'><div align='left'>Yellow</div></td><td align='right'><div align='right'>"+rsRoute.getString("yellowzonecount")+"</div></td><td align='right'><div align='right'>"+rsRoute.getString("yellowzonedist")+"</div></td></tr> " );
		str.append("<tr><td align='left'><div align='left'>Green</div></td><td align='right'><div align='right'>"+rsRoute.getString("greenzonecount")+"</div></td><td align='right'><div align='right'>"+rsRoute.getString("greenzonedist")+"</div></td></tr> " );
	}
	str.append("</table>");
	Rname=Rname+"<br>"+str.toString();
	out.print(Rname);
}


} catch(Exception e) {out.println(e);}

finally
{
con1.close();
}

%>





