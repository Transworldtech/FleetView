<%@ include file="header.jsp" %>

<%!
Connection con1;
%>

<form name="totvehsrepform" method="get" action="" onSubmit="return validate();" >

<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(), stmt3=con1.createStatement();
ResultSet rs1=null, rs2=null, rs3=null;
String sql1="", sql2="", sql3="";

String transp=session.getAttribute("usertypevalue").toString();
%>
<table border="0" width="100%" bgcolor="white">
	<tr>
		<td align="center"> <font color="maroon" size="2"> <B> Non Castrol Trips of <%=transp%> </B> </font> </td>
	</tr>
</table>

<table border="0" width="100%" bgcolor="white">
<tr>
<td align="center">
	<table class="stats">
	  <tr>		
		<th align="center" > <B> Sr. No.</B>  </th>
		<th align="center" > <B> Vehicle No. </B></th>
		<th align="center" > <B> Updated Date-Time </B> </th> 
		<th align="center" > <B> Location  </B> </th> 

	  </tr>

<%
int i=1;

sql1="select * from t_group where GPName='Castrol' and VehRegNo='"+transp+"' and VehCode not in (select VehId from t_startedjourney where OwnerName='"+transp+"' and GPName='Castrol' and JStatus='Running')";
//out.print(sql1);
rs1=stmt1.executeQuery(sql1);
while(rs1.next())
{ 
	String unitid="", loc="", lat="", lon="", vehno="", dte="", tme="";
	String vehcode=rs1.getString("VehCode");
	
	/*sql2="select * from t_vehicledetails where VehicleCode='"+vehcode+"'";
	rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{
		unitid=rs2.getString("UnitId");
	}*/

	sql3="select * from allconnectedunits where VehNo='"+rs1.getString("Transporter")+"' ";
	rs3=stmt3.executeQuery(sql3);
	if(rs3.next())
	{
		loc=rs3.getString("Location");
		lat=rs3.getString("Latindec");
		lon=rs3.getString("LonginDec");
		vehno=rs3.getString("VehNo");
		dte=rs3.getString("TheDate");
		tme=rs3.getString("TheTime");
	}
%>
	<tr>
		<td> <%=i%> </td>
		<td> <%=rs1.getString("Transporter")%> </td>
		<td>  <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(dte))%> <%=tme%> </td>


		<td> <a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=loc%>','myWin','width=500,height=500');popWin.focus();return false"> <%=loc%> </a> 

		</td>
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
