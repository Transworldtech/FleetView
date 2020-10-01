<%@ include file="header.jsp" %>

<%!
Connection con1;
%>

<form name="totvehsrepform" method="get" action="" onSubmit="return validate();" >

<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement();
ResultSet rs1=null,rs2=null, rs3=null, rs4=null, rs5=null, rs6=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="";

String transp=session.getAttribute("usertypevalue").toString();

java.util.Date tdydte = new java.util.Date();
long miliseconds=tdydte.getTime();
miliseconds=miliseconds - (1000 * 60 * 60 *24)*8;
tdydte.setTime(miliseconds);	
String sevendaysbfredte= new SimpleDateFormat("yyyy-MM-dd").format(tdydte);
%>
<table border="0" width="100%" bgcolor="white">
	<tr>
		<td align="center"> <font color="maroon" size="2"> <B> Device Disconnected Vehicles of <%=transp%> </B> </font> </td>
	</tr>
</table>

<table border="0" width="100%" bgcolor="white">
<tr>
<td align="center">
	<table class="stats">
	  <tr>		
		<th align="center" > <B> Sr. No.</B>  </th>
		<th align="center" > <B> Vehicle No. </B></th>
		<th align="center" > <B> Unit Id </B> </th> 
		<th align="center" > <B> Last Date of Data  </B> </th> 
		<th align="center" > <B> Last Location  </B> </th> 
	  </tr>

<%
int i=1;

sql1="select * from t_onlinedata where TheDate <= '"+sevendaysbfredte+"' and VehicleCode in (select VehCode from t_group where GPName='Castrol' and VehRegNo='"+transp+"')";
rs1=stmt1.executeQuery(sql1);
while(rs1.next())
{ 
	String unitid="";
	String vehcode=rs1.getString("VehicleCode");
	String lat=rs1.getString("LatitudePosition");
	String lon=rs1.getString("LongitudePosition");
	String loc=rs1.getString("Location");
	String vehno=rs1.getString("VehicleRegNo");

	sql2="select * from t_vehicledetails where VehicleCode='"+vehcode+"' ";
	rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{
		unitid=rs2.getString("UnitId");
	}
%>
	<tr>
		<td> <%=i%> </td>
		<td> <%=rs1.getString("VehicleRegNo")%> </td> 
		<td> <%=unitid%> </td>
		<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))%> <%=rs1.getString("TheTime")%> </td> 
		<td> <a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=loc%>','myWin','width=500,height=500');popWin.focus();return false"> <%=loc%> </a> </td>

	
	</tr>
<%
	i++;
}

%>
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
