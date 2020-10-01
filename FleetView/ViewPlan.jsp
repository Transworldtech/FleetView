<%@ include file="headerpopup.jsp"%>
<%@page import="java.util.Date"%>
<%!
Connection conn,con;
%>
<html>
<head>

<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
</head>
<body>
<script>
function gotoPrint(divName)  
{  
	  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}
</script>

<%
try
{

Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement s = con.createStatement();
Statement s1 = con.createStatement();
String tripid = "";
tripid = request.getParameter("tripid");
//tripid = "785023";
String driverid = "",transporter = "",startplace = "",endplace = "",drivername = "",vehregno = "";
String routeid = "",routename = "",totzone = "",redzone = "",redkm = "",yellowzone = "",yelllowkm = "",greenzone ="",greenkm = "";
int totkm = 0;
driverid = request.getParameter("driverid");
String briefid = request.getParameter("briefid");
//briefid = "67319";
//driverid = "91037256";
String date = "";
String sql2 = "select * from db_gps.t_jrnyplanning where tripid = '"+tripid+"'  and brifid = '"+briefid+"'  and start <> '-' order by Start asc" ;
System.out.println(sql2);
ResultSet rs2 = s.executeQuery(sql2);
if(rs2.next())
{
	date = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs2.getString("Start")+" "+rs2.getString("Start")));
}

 sql2 = "SELECT * FROM db_gps.t_briefing WHERE driverid = '"+driverid+"' and briefid = '"+briefid+"'  ORDER BY brifdate DESC";
 //sql2 = "SELECT * FROM db_gps.t_briefing WHERE driverid = '"+driverid+"'  ORDER BY brifdate DESC";
 System.out.println(sql2);
 rs2 = s.executeQuery(sql2);
if(rs2.next())
{
	tripid = rs2.getString("tripid");
	startplace = rs2.getString("startplace");
	endplace = rs2.getString("endplace");
	transporter = rs2.getString("Transporter");
	vehregno = rs2.getString("VehRegNo");
	drivername = rs2.getString("DriverName");
}



String sql4 = "select  *  from db_gps.t_jrmrouteadvancedmaster where StartPlace = '"+startplace+"' and EndPlace = '"+endplace+"'";
System.out.println("****   "+sql4);
ResultSet rs4 = s.executeQuery(sql4);
if(rs4.next())
{
	routeid = rs4.getString("routeid");
	totkm = rs4.getInt("totalkm");
}

System.out.println("****   "+routeid);
if(routeid == "" || routeid == null)
{
	
}
else
{
/*String sql5 = "select sum(legdist) totkm from db_gps.t_jrmrouteadvanceddetails where advancedrouteid = 1 ";
System.out.println("****   "+sql5);
ResultSet rs5 = s.executeQuery(sql5);
if(rs5.next())
{
	//routename = rs5.getString("RouteName");
	//totzone = rs5.getString("TotalZones");
	totkm = rs5.getInt("totkm");
	//redzone = rs5.getString("redzonecount");
	//redkm = rs5.getString("redzonedist");
	//yellowzone = rs5.getString("yellowzonecount");
	//yelllowkm = rs5.getString("yellowzonedist");
	//greenzone = rs5.getString("greenzonecount");
	//greenkm = rs5.getString("greenzonedist");	
}*/
}






%>


<div align="center" style="margin-left: 20px;margin-right: 20px;">
<form id="jrnyplan" name="jrnyplan" action="" method="post">
<div id="table1">
<%
String exportFileName=session.getAttribute("user").toString()+"_JourneyPlan.xls";  
%>
<h1  align="center"><font>Leg Summary</font></h1>
<br>
<table width="100%">
<tr>
<td style="width: 25%"><font color="black">  <b> Trip ID:</b> <%=tripid %></font></td>
<td><font color="black"><b>Driver ID: </b> <%=driverid %></font></td>
<td><font color="black"><b>Driver Name:</b> <%=drivername %> </font></td>
<td><font color="black"><b>Transporter: </b> <%=transporter %></font></td>
</tr>
<tr>
<td><font color="black"><b>Origin:</b> <%=startplace %></font></td>
<td><font color="black"><b>Destination:</b> <%=endplace %></font></td>
<td colspan="2"><font color="black"><b>Journey Start: </b> <%=date %></font></td>
</tr>
<tr>
<!--<td><font color="black"><b>Vehicle:</b> < %=vehregno %></font></td>-->
<td><font color="black" id="dist"><b>Journey Distance:</b> <%=totkm %></font></td>

</tr>
</table>
<br>
<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />
                            <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a>  
                           </div>
<table border="1" class="sortable">
<tr>
<th>Day</th>
<th>Event</th>
<th>Start</th>
<th>End</th>
<th>Duration</th>
<th>Origin</th>
<th>Destination</th>
<th>Leg Distance</th>
<th>Trip Distance</th>
<th>Distance To Go</th>
<th>Stop Duration</th>
<th>Stop Reason</th>
</tr>
<%
String sql = "select * from db_gps.t_jrnyplanning where tripid = '"+tripid+"'  and brifid = '"+briefid+"' order by start asc";
ResultSet rs = s.executeQuery(sql);
while(rs.next())
{
	String  lat1 = "",lon1 = "",lat2 = "",lon2 = "";
	
	 sql2 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rs.getString("Origin")+"'  and advancedrouteid = '"+routeid+"'";
	    //System.out.println("sql  ****************************************  "+sql1);
	     rs2 = s1.executeQuery(sql2);
		   if(rs2.next())
		   {
			   lat1 = rs2.getString("latitude");
			   lon1 = rs2.getString("longitude");
		   }
		   
		   sql2 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rs.getString("Destination")+"'  and advancedrouteid = '"+routeid+"'";
			  rs2 = s1.executeQuery(sql2);
		   if(rs2.next())
		   {
			   lat2 = rs2.getString("latitude");
			   lon2 = rs2.getString("longitude");
		   }
	
	%>
	<tr>
	<td align="right"><div align="right"><%=rs.getString("day") %></div></td>
	
	<td align="left"><div align="left"><%=rs.getString("Event") %></div></td>
	<%
	if(rs.getString("Start").equals("") || rs.getString("Start").equals("-"))
	{
		%>
		<td align="right"><div align="right"><%=rs.getString("Start") %></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse( rs.getString("Start"))) %></div></td>
		<%
	}
	%>
	<%
	if(rs.getString("End").equals("") || rs.getString("End").equals("-"))
	{
		%>
		<td align="right"><div align="right"><%=rs.getString("End") %></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse( rs.getString("End"))) %></div></td>
		<%
	}
	%>
	<%
	if(rs.getString("Duration").equals("") || rs.getString("Duration").equals("-"))
	{
		%>
		<td align="right"><div align="right"><%=rs.getString("Duration") %></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse( rs.getString("Duration"))) %></div></td>
		<%
	}
	%>
	<td align="left"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1 %>&long=<%=lon1%>&discription=<%=rs.getString("Origin")  %>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1 %>&long=<%=lon1%>&discription=<%=rs.getString("Origin")  %>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rs.getString("Origin")  %></a></div></td>
	<td align="left"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1 %>&long=<%=lon1%>&discription=<%=rs.getString("Destination")  %>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1 %>&long=<%=lon1%>&discription=<%=rs.getString("Destination")  %>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rs.getString("Destination")  %></a></div></td>
	<td align="right"><div align="right"><%=rs.getInt("LegDistance")/1000 %></div></td>
	<td align="right"><div align="right"><%=rs.getInt("Tripdist")/1000 %></div></td>
	<td align="right"><div align="right"><%=rs.getInt("kmtogo")/1000 %></div></td>
	<td align="right"><div align="right">
	<%
	if(rs.getString("StopDuration").equals("-"))
	{
		%>
		<%=rs.getString("StopDuration") %>
		<%
	}
	else
	{
		%>
		<%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("StopDuration"))) %>
		<%
	}
	%>
	</div></td>
	<td align="left"><div align="left"><%=rs.getString("StopReason") %></div></td>
	</tr>
	<%
}

%>
</table>
<%
if(date.equals(""))
{
	
}
else
{
	java.util.Date startdate = new SimpleDateFormat("dd-MMM-yyyy HH:mm").parse(date);
	long eta = 0;
	sql = "select sum(TIME_TO_SEC(Duration)) as eta from db_gps.t_jrnyplanning where tripid = '"+tripid+"'  and brifid = '"+briefid+"' ";
	System.out.println("****    "+sql);
 	rs = s.executeQuery(sql);
 	if(rs.next())
 	{
 		eta = rs.getLong("eta");
 	}
 	System.out.println("***   "+eta);
 	long min = 0,hrs = 0;
 	min = eta%60;
 	hrs = eta/60;
 	System.out.println("***   "+hrs+"  "+min);
}
%>
</div>
</form>
</div>
<br>
<br>
<%
    
}
catch(Exception e)
{
	System.out.println("%%%%    "+e);
}
%>