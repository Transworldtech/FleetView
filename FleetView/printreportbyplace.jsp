
<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%! 
Connection conn;
Statement st;
String user, place1=null, Dist=null,sql1;
int Distance;
double Lat1, Lon1, Lat2, Lon2;

%>
<%
user=session.getAttribute("usertypevalue").toString();
try{
conn = fleetview.ReturnConnection();
Statement st=conn.createStatement();
%>
<table border="0" width="100%" bgcolor="white">
<tr><td align="center">
<div align="left"><font size="3">Report No:2.0</font></div>
<font size="3"><b>Vehicles In Depots</b></font>
<div align="right"><a href="#" onclick="javascript:window.print('');"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
	<%=fleetview.PrintDate()%></div>
		<font size="3"><b>The Vehicle <= <%=" "+session.getAttribute("distance").toString()+" "%>km. Around the Place <%=" "+session.getAttribute("Pname").toString()%></b></font>
	
</td></tr>
<tr><td>
<table width="100%" border="0" width="100%" align="center">
<tr><td>
<%
StringTokenizer sk = new StringTokenizer(session.getAttribute("placename").toString(),",");
Distance=Integer.parseInt(session.getAttribute("distance").toString());
Lat1=Double.parseDouble(sk.nextToken());
Lon1=Double.parseDouble(sk.nextToken());

/************code to check the login user is Group or Transporter **********************/

String sql10="select TypeofUser from t_security where TypeValue='"+session.getAttribute("usertypevalue").toString()+"'";
ResultSet rst11=st.executeQuery(sql10);
if(rst11.next())
{
	if(rst11.getString("TypeofUser").equals("GROUP"))
	{
	 sql1="select v.* from t_onlinedata v,t_group g where g.GPname='"+session.getAttribute("usertypevalue").toString()+"' and v.VehicleCode=g.VehCode order by v.TheDate desc";
	}
	else
	{
	sql1="select * from t_onlinedata where transporter='"+user+"' order by TheDate desc";
	}
}

/**********************************7 April 2008 *****************************************/

ResultSet rst1=st.executeQuery(sql1);
%>
<table class="stats">
<tr><td colspan="6" class="hed">The Vehicle <= <%=" "+session.getAttribute("distance").toString()+" "%>km. Around the Place <%=" "+session.getAttribute("Pname").toString()%></td></tr>
<tr>
<td>Sr.</td>
<td class="hed">Vehicle R.No.</td><td class="hed">Date</td><td class="hed">Time</td><td class="hed">Distance In Km.</td><td class="hed">Location</td></tr>

<%
int i=1;
while(rst1.next())
{
	
	java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheDate"));
	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
	String showdate1 = formatter1.format(ShowDate1);
	Lat2=rst1.getDouble("LatitudePosition");
	Lon2=rst1.getDouble("LongitudePosition");
	double theta = Lon1 - Lon2;
	double dist = Math.sin(Lat1* Math.PI / 180.0) * Math.sin(Lat2* Math.PI / 180.0) + Math.cos(Lat1* Math.PI / 180.0) * Math.cos(Lat2* Math.PI / 180.0) * Math.cos(theta* Math.PI / 180.0);
	dist = Math.acos(dist);
	dist = (dist* 180 / Math.PI);
	dist = dist * 60 * 1.1515;
	long dist1 = Math.round(dist * 1.609344);
	if(dist1<= Distance)
	{
		
%>
<tr>
<td><%=i%></td>
<td class="bodyText"><%=rst1.getString("VehicleRegNo")%></td>
<td class="bodyText"><%=rst1.getString("Transporter")%></td>
<td class="bodyText"><%=showdate1%></td>
<td class="bodyText"><%=showdate1%> <%=rst1.getString("TheTime")%>
</td>

<td class="bodyText"><%=rst1.getString("TheTime")%></td>

<td class="bodyText"><%=dist1%></td>

<td class="bodyText"><%=rst1.getString("Location")%></td></tr>

<%
i++;
	}

}
%>
</table>

</td></tr>
</table>
</td></tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e)
	{}

try
{
fleetview.closeConnection();
}
catch(Exception e){}
}
%>
</jsp:useBean>
<%@ include file="footernew.jsp" %>

