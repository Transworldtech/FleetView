<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=session.getAttribute("user").toString()+showdatex+"VehicleMentananceReport.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
Statement stmt2;
%>
<% 
try {
	System.out.println("<><><><#####1");
Class.forName(MM_dbConn_DRIVER); 
System.out.println("<><><><#####2");
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
System.out.println("<><><><#####3");
stmt2=con1.createStatement();
System.out.println("<><><><#####4");
String vehid=request.getParameter("veh");
String srvname1=request.getParameter("srvname");
String nxtsrvdate1=request.getParameter("nxtsrvdate");
String altdate1=request.getParameter("altdate");
String entdate1=request.getParameter("entdate");
String servicetype1=request.getParameter("servicetype");
String servicedate1=request.getParameter("servicedate");
String vehregno1=request.getParameter("vehregno");
String alertdays1=request.getParameter("alertdays");
String nextdate1=request.getParameter("nextdate");
String email1=request.getParameter("email");
System.out.println("<><><><#####5");
//System.out.println("vehid==>"+vehid);
String list="select * from t_lastservice where Vehid in "+session.getAttribute("VehList").toString()+" order by Vehid";
System.out.println("list==>"+list);
System.out.println("<><><><#####6");
String status="",vehcode="",servicetype="",servicedate=""; 
int k=1;
System.out.println("<><><><#####7");
%>
<br><br>

<br><br>
<table  bgcolor="#F5F5F5" width="100%" class="sortable"  border="1">
<tr>
<font size="3"><b>Vehicle Maintenance Report for:<%=session.getValue("user").toString()%> </b></font>
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
System.out.println("<><><><#####8");
ResultSet rs=stmt2.executeQuery(list);
System.out.println("<><><><#####9");
try
{
while(rs.next())
{
	System.out.println("<><><><#####10");
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
 System.out.println("<><><><#####11");
 System.out.println(rs.getString("VehRegNo"));
 System.out.println(rs.getString("Transporter"));
 System.out.println(rs.getString("SrviceName"));
 System.out.println(servicedate);
 System.out.println(rs.getString("ServiceKm"));
 System.out.println(rs.getString("NextServiceDate"));
 System.out.println(rs.getString("NextServiceAfterKm"));
 System.out.println(rs.getString("AlertBeforedays"));
 System.out.println(rs.getString("AlertAfterKm"));
 System.out.println(status);
 System.out.println(rs.getString("EmailTo"));
 System.out.println(rs.getString("EntDate"));
 System.out.println(rs.getString("EntBy"));
 System.out.println("<><><><#####12");
}
}catch(Exception e) {out.println("Exception----->" +e); }
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
