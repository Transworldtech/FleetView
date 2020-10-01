<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn, conn1;
Statement st,st1,st2;
String sql,sql1,sdate,edate;
int ds;
double Lat1,Lat2,Lon1, Lon2;
String qd,sql2,location,locationcode,vehlist,locationlist;
%>
<%
java.util.Date NewDate=new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
String data1 = NewFormatter.format(NewDate);
try{
vehlist="(0";
ds=10;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
sql="select * from t_zonalid where UserName='"+session.getAttribute("user").toString()+"'";
out.print(sql);
ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
	location=rst.getString("Zone");
	locationcode=rst.getString("Vendor");
	session.setAttribute("Location",location);
	session.setAttribute("LocationCode",locationcode);
	locationlist="('"+locationcode+"'";

	sql="select distinct(a.Vehid) from t_startedjourney a,t_routedetails b where a.OwnerName ='Safe and Secure' and a.jstatus='Running' and a.startplace=b.Start and a.endplace=b.end and b.Zone='"+location+"' and a.vendor='"+locationcode+"' ";
	out.print(sql);
	ResultSet start_rst=st2.executeQuery(sql);
	while(start_rst.next())
	{
	System.out.print(start_rst.getString("vehid")+"</br>");
	vehlist=vehlist+","+start_rst.getString("vehid");
	}
	/******************** End of code ************************************************/
	vehlist=vehlist+")";
	session.setAttribute("vehlistnew",vehlist);
	session.setAttribute("VehList",vehlist);
	out.print(vehlist);
	
String sql11="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue").toString()+"'";
ResultSet rstx=st1.executeQuery(sql11);
if(rstx.next())
{	
	sql11="select * from t_defaultvals where OwnerName='"+session.getAttribute("usertypevalue").toString()+"'";
}
else
{
	sql11="select * from t_defaultvals where OwnerName='Default'";
	
}
ResultSet rst11=st1.executeQuery(sql11);
if(rst11.next())
{
	session.setAttribute("overspeed",rst11.getString("Overspeedlimit")+" kmph/"+rst11.getString(3)+" Secs");
	session.setAttribute("racc",rst11.getString("AccelerationSpeedVarLimit")+" kmph/Secs"); 
	session.setAttribute("rdcc",rst11.getString("DecelerationSpeedVarLimit")+" kmph/Secs");
	session.setAttribute("ndri","Beyond "+rst11.getString("NightDrivingFromTime")+" To "+rst11.getString("NightDrivingToTime"));
	session.setAttribute("stoptime",rst11.getString("NightDrivingFromTime"));
	session.setAttribute("starttime",rst11.getString("NightDrivingToTime"));
	session.setAttribute("cdri","> "+rst11.getString("ContinuousRunHrsLimit")+" Mins With Stoppages < "+rst11.getString("StopMinsAllowedInContRun"));
	session.setAttribute("stop","> "+rst11.getString("StoppagesGreaterThanInMins")+"Mins");
	session.setAttribute("stop11",rst11.getString("StoppagesGreaterThanInMins"));
session.setAttribute("desconnected",rst11.getString("DisconnectedPeriod"));
session.setAttribute("distformat",rst11.getString("DistFormat"));
session.setAttribute("fuelformat",rst11.getString("FuelFormat"));
session.setAttribute("dateformat",rst11.getString("DateFormat"));
}

response.sendRedirect("currentposition.jsp");

}
else
{
	out.print("Hello");
}
}catch(Exception e)
{
	response.sendRedirect("index.html");
}
finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{
		
	}
}
%>
