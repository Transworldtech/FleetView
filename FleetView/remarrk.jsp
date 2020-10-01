 <%@ include file="Connections/conn.jsp" %>

<%@ page buffer="16kb" %>
<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<script src="js/sorttable.js" type="text/javascript"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<script src="js/searchhi.js" type="text/javascript"></script>

<%!
Connection con1;
%>

<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
ResultSet rs1=null,rs2=null,rs=null;
Statement stmt=con1.createStatement(),stmt1=con1.createStatement(), stmt2=con1.createStatement();
String sql1="";
String user=session.getAttribute("dispalyname").toString();

String bdate=request.getParameter("brdate");
String driverid=request.getParameter("driverid");
String remark="-";
String mark=request.getParameter("remark");
//out.print(mark);
String sql="";
%>
<table class="sortable" width="100%" border="1">
<tr>
<%
if(mark.equals("brief"))
{	 %>
<th class="hed" align="center">Briefid</th>
<th class="hed" align="center">DriverName</th>
<th class="hed" align="center">Driverid</th>
<th class="hed" align="center">brifdate</th>
<th class="hed" align="center">VehRegNo</th>
<th class="hed" align="center">Transporter</th>
<th class="hed" align="center">TrainerName</th>
<th class="hed" align="center">Pre Induction and Maintainance check (PIMC) Ok</th>
<th class="hed" align="center">gpscaptured (in %)</th>
<th class="hed" align="center">Driver Response</th>
<th class="hed" align="center">Veh -Documents</th>
<th class="hed" align="center">Route Familiarization</th>
<th class="hed" align="center">Remark</th>
<%
}
if(mark.equals("debrief"))
{	 %>
<th class="hed" align="center">Debriefid</th>
<th class="hed" align="center">DriverName</th>
<th class="hed" align="center">Driverid</th>
<th class="hed" align="center">Debriefdate</th>
<th class="hed" align="center">Transporter</th>
<th class="hed" align="center">TrainerName</th>
<th class="hed" align="center">gpscaptured (in %)</th>
<th class="hed" align="center">deviation of route comment</th>
<th class="hed" align="center">Route feedback comment</th>
<th class="hed" align="center">Zone feedBack comment </th>
<th class="hed" align="center">Driver Response</th>
<th class="hed" align="center">Remark</th>
<%
}
%>
</tr>
<%
if(mark.equals("brief"))
{
 sql = "select * from t_briefing where Driverid='"+driverid+"' and brifdate = '"+bdate+"'";
 //out.print(sql);
}
else
	if(mark.equals("debrief"))
{
	 sql = "select * from t_debriefing where Driverid='"+driverid+"' and Debriefdate = '"+bdate+"'";
	//out.print(sql);
}
rs=stmt1.executeQuery(sql);
//out.print(sql);
if(rs.next())
{
	remark=rs.getString("remarkcom");
	remark.split(",");
%>
<%if(mark.equals("brief"))
{ %>
<tr>
<td><%=rs.getString("Briefid") %></td>
<td><%=rs.getString("DriverName") %></td>
<td><%=rs.getString("Driverid") %></td>
<td><%=rs.getString("brifdate") %></td>
<td><%=rs.getString("VehRegNo") %></td>
<td><%=rs.getString("Transporter") %></td>
<td><%=rs.getString("TrainerName") %></td>
<td><%=rs.getString("pimc") %></td>
<td><%=rs.getString("gpscaptured") %></td>
<td><%=rs.getString("Drivresp") %></td>
<td><%=rs.getString("vehdoc") %></td>
<td><%=rs.getString("RootFam") %></td>
<td><%=rs.getString("remarkcom")%></td>
</tr>
<%} %>
<%if(mark.equals("debrief"))
{%>
<tr>
<td><%=rs.getString("debriefid") %></td>
<td><%=rs.getString("DriverName") %></td>
<td><%=rs.getString("driverid") %></td>
<td><%=rs.getString("Debriefdate") %></td>
<td><%=rs.getString("transporter") %></td>
<td><%=rs.getString("Trainername") %></td>
<td><%=rs.getString("gpscapture") %></td>
<td><%=rs.getString("jrmdevirootcom") %></td>
<td><%=rs.getString("jrmriskcom") %></td>
<td><%=rs.getString("otherFeedBackCom") %></td>
<td><%=rs.getString("driverresponce") %></td>
<td><%=rs.getString("remarkcom")%></td>
</tr>

<%} %>
}
<%	
}
boolean flag=true;
String date=new SimpleDateFormat("yyMMdd").format(new java.util.Date());
String securecode="";

%>

</table>
<%

} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
} 

  
%>
