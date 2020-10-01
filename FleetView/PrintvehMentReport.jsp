<%@ include file="headerprintnew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">

	<%!
Connection con1;
Statement stmt2;
%>
<% 
try {
Class.forName(MM_dbConn_DRIVER); 
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
stmt2=con1.createStatement();
String vehid=request.getParameter("vehicle");
System.out.println("vehid==>"+vehid);
String list="select * from t_lastservice where VehRegNo='"+vehid+"'";
System.out.println("list==>"+list);
String status="",vehcode="",servicetype="",servicedate=""; 
int k=1;
%>
<br><br>

<br><br>
<table width="100%" border="1" align="center" class="sortable">
<tr>
<font size="3"><b>Vehicle Maintenance Report for:<%=vehid%> </b></font>
</tr>
<tr>
<td>SerNo</td>
<td>VehRegNo</td>
<td>Transporter</td>
<td>ServiceDate</td>
<td>SrviceName</td>
<td>ServiceKm</td>
<td>NextServiceDate</td>
<td>NextServiceAfterKm</td>
<td>AlertBeforedays</td>
<td>Alertdate</td>
<td>AlertKm</td>
<td>AlertAfterKm</td>
<td>AlertStatus</td>
<td>EmailTo</td>
<td>EntDate</td>
<td>EntBy</td>
</tr>
<%
ResultSet rs=stmt2.executeQuery(list);
while(rs.next())
{
	status=rs.getString("AlertStatus");
	vehcode=rs.getString("Vehid");
	servicetype=rs.getString("ServiceType");
	servicedate=rs.getString("ServiceDate"); 
%>
 <tr>
 <td><%=k++%></td> 
 <td><%=rs.getString("VehRegNo") %></td>
 <td><%=rs.getString("Transporter") %></td>
 <td><%=servicedate%></td>
 <td><%=rs.getString("SrviceName") %></td> 
 <td><%=rs.getInt("ServiceKm") %></td> 
 <td><%=rs.getString("NextServiceDate") %></td>
 <td><%=rs.getInt("NextServiceAfterKm") %></td> 
 <td><%=rs.getInt("AlertBeforedays") %></td>
 <td><%=rs.getString("Alertdate") %></td>
 <td><%=rs.getInt("AlertKm") %></td>
 <td><%=rs.getInt("AlertAfterKm") %></td> 
 <td><%=status%></td> 
 <td><%=rs.getString("EmailTo") %></td> 
 <td><%=rs.getString("EntDate") %></td> 
 <td><%=rs.getString("EntBy") %></td> 
 </tr> 
 </tr> 
 <%    
}
%>
</table>
<%
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{
		e.printStackTrace();
	}
}
%>
<%@ include file="footernew.jsp" %>