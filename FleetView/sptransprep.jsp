<%@ include file="header.jsp" %>

<%!
Connection con1;
%>

<form name="sptransprepform" method="get" action="" onSubmit="return validate();" >
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt5=con1.createStatement(), stmt6=con1.createStatement();
ResultSet rs1=null,rs2=null, rs3=null, rs4=null, rs5=null, rs6=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="";

long miliseconds=0;

String transp=session.getAttribute("usertypevalue").toString();
int vehcnt=0, casttripcnt=0, noncasttripcnt=0, discvehs=0;

sql1="select count(*) as cnt1 from t_group where GPName='Castrol' and VehRegNo='"+transp+"'  ";
rs1=stmt1.executeQuery(sql1);
if(rs1.next())
{
	vehcnt=rs1.getInt("cnt1");
}

sql2="select count(*) as cnt2 from t_startedjourney where OwnerName='"+transp+"' and GPName='Castrol' and JStatus='Running' ";	
rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	casttripcnt=rs2.getInt("cnt2");	
}

noncasttripcnt=vehcnt-casttripcnt;

	java.util.Date tdydte = new java.util.Date();
	miliseconds=tdydte.getTime();
	miliseconds=miliseconds - (1000 * 60 * 60 *24)*8;
	tdydte.setTime(miliseconds);	
	String sevendaysbfredte= new SimpleDateFormat("yyyy-MM-dd").format(tdydte);
	
sql3="select count(*) as cnt3 from t_onlinedata where TheDate <= '"+sevendaysbfredte+"' and VehicleCode in (select VehCode from t_group where GPName='Castrol' and VehRegNo='"+transp+"')";
rs3=stmt1.executeQuery(sql3);
if(rs3.next())
{
	discvehs=rs3.getInt("cnt3");
}

int castdepo=0;	
sql4="select * from t_group where GPName='Castrol' and VehRegNo='"+transp+"' and VehCode not in (select VehId from t_startedjourney where OwnerName='"+transp+"' and GPName='Castrol' and JStatus='Running')";
rs4=stmt1.executeQuery(sql4);
while(rs4.next())
{
	String lat="", lon="";
	String vehcode=rs4.getString("VehCode");

	sql5="select * from t_onlinedata where VehicleCode='"+vehcode+"' ";
	rs5=stmt5.executeQuery(sql5);
	if(rs5.next())
	{
		lat=rs5.getString("LatitudePosition");
		lon=rs5.getString("LongitudePosition");
	}

	sql6="select WareHouseCode,WareHouse,(((ACOS(SIN('"+lat+"' * PI() / 180) * SIN(Latitude * PI() / 180) + COS('"+lat+"' * PI() / 180) * COS(Latitude * PI() / 180) * COS(('"+lon+"' - longitude) * PI() / 180)) * 180 / PI()) * 60 * 1.1515)*1.609344) AS distance  from t_warehousedata where owner = 'Castrol'  order by distance asc";
	rs6=stmt6.executeQuery(sql6);
	if(rs6.next())
	{
		double dist=rs6.getDouble("distance");
		if(dist <= 5)
		{
			castdepo++;
		}
	}
}

	
%>
	<center>
	<table border="0" width="100%" bgcolor="white">
		<tr>
			<td align="center"> <font color="maroon" size="2"> <B> <%=transp%> Details </B> </font> </td>
		</tr>
	</table>

<table border="0" width="100%" bgcolor="white">
<tr>
<td align="center">
	<table border="1" width="30%">
	  <tr>
		<td width="50%"> <font color="maroon"> <B> Total Vehicles </B> </font> </td>	
		<td> <a href="totvehsdesc.jsp"> <%=vehcnt%> </a> </td>
	  </tr>	
	   <tr>
		<td> <font color="maroon"> <B> Castrol Trips </B> </font> </td>	
		<td> <a href="sptranscasttrips.jsp">  <%=casttripcnt%> </a> </td>
	  </tr>			
	   <tr>
		<td> <font color="maroon"> <B> Non-Castrol Trips </B> </font> </td>	
		<td> <a href="sptransnoncastvehs.jsp"> <%=noncasttripcnt%> </a> </td>
	  </tr>	
	  
	   <tr>
		<td> <font color="maroon"> <B> Device Disconnected </B> </font> </td>	
		<td> <a href="sptransdevdiscon.jsp"> <%=discvehs%> </a> </td>
	  </tr>	
	   <tr>
		<td> <font color="maroon"> <B> In Castrol Depot </B> </font> </td>	
		<td> <a href="sptranscastdepo.jsp"> <%=castdepo%> </a> </td>
	  </tr>		
	</table>
</td>
</tr>
</table>

<%
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>


<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>
