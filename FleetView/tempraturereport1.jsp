<%@ include file="header.jsp" %>
<table border="1" width="100%" bgcolor="white"><tr><td>
<%!
String VehicleCode, fromdate, todate, desc,fff,ttt;
Connection conn;
Statement st1,st2,st3;
ResultSet rst1, rst2, rst3;
int dist, fuel;
boolean flag=true;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1=conn.createStatement();
	
VehicleCode=session.getAttribute("hvid").toString();
fff=session.getAttribute("fff").toString();
ttt=session.getAttribute("ttt").toString();	
fromdate=session.getAttribute("hdate1").toString();
	
todate=session.getAttribute("hdate2").toString();
	
String sql1="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	rst2=st1.executeQuery(sql1);
	if(rst2.next())
	{
		desc=rst2.getString("Description");
	}
	String sql="select * from t_veh"+VehicleCode+" where TheFieldDataDate>='"+fromdate+"' and TheFieldDataTime >='"+fff+"' and TheFieldDataDate<='"+todate+"' and TheFieldDataTime<='"+ttt+"' and TheFiledTextFileName in('SI','DO','DS') order by concat(TheFieldDataDate,TheFieldDataTime) asc";
rst1=st1.executeQuery(sql);
%>
<table border="1" width="100%" class="stats">
<tr><td class="hed">Date Time</td><td class="hed">Speed</td><td class="hed">Distance</td><td class="hed">Location</td>

<%
if(null!=desc && desc.equals("TEMPSENSOR"))
{
%>
<td class="hed">Sen1</td><td class="hed">Sen2</td><td class="hed">Sen3</td><td class="hed">Sen4</td>

<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
%>
<td class="hed">Ltrs.</td>
<%
}
%>
</tr>
<%
int cnt=1;
int cnt2=1;
while(rst1.next())
{
	if(cnt==1)
	{
		dist=Integer.parseInt(rst1.getString("Distance"));
		
		cnt=2;
	}



%>
<tr>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>

<%
if(null!=desc && desc.equals("TEMPSENSOR"))
{
%>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
	}
%>
<td class="bodyText"></td>
<%
}
}
%>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}
%>
</td></tr><!-- footer starts here-->
<table border="1" width="100%" bgcolor="white">
<tr ><td class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
 
