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
ResultSet rs1=null,rs2=null;
String sql1="", sql2="";

String transp=session.getAttribute("usertypevalue").toString();
%>
<table border="0" width="100%" bgcolor="white">
	<tr>
		<td align="center"> <font color="maroon" size="2"> <B> All Vehicles of <%=transp%> </B> </font> </td>
	</tr>
</table>

<table border="0" width="100%" bgcolor="white">
<tr>
<td align="center">
	<table class="stats">
	  <tr>		
		<th align="center" > <B> Sr. No.</B>  </th>
		<th align="center" > <B> Vehicle No. </B></th>
		<th align="center" > <B> Updated Date-Time </B></th>
		<th align="center" > <B> Location  </B> </th> 
	  </tr>

<%
int i=1;

sql1="select * from t_group where GPName='Castrol' and VehRegNo='"+transp+"' order by transporter asc ";
rs1=stmt1.executeQuery(sql1);
while(rs1.next())
{
	String loc="", lat="", lon="", vehno="", dte="", tme="";
	String vehcode=rs1.getString("VehCode");

	sql2="select * from t_onlinedata where VehicleCode='"+vehcode+"' ";
	rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{
		loc=rs2.getString("Location");	
		lat=rs2.getString("LatitudePosition");	
		lon=rs2.getString("LongitudePosition");	
		vehno=rs2.getString("VehicleRegNo");	
		dte=rs2.getString("TheDate");
		tme=rs2.getString("TheTime");
	}
%>
	<tr>
		<td> <%=i%> </td>
		<td> <%=rs1.getString("transporter")%> </td>
		<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(dte))%> <%=tme%> </td>

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
