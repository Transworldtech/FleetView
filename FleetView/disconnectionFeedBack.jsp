<%@page import="java.sql.*" import="java.sql.DriverManager"
	import="java.sql.ResultSet" import="java.sql.Statement"%>
	<%@ include file="Connections/conn.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
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
<script src="js/searchhi.js" type="text/javascript"></script>
<body>

<% 
	try{
		
	String user = session.getAttribute("usertypevalue").toString();
	Connection conn1 = null;
	Statement st = null;
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st =  conn1.createStatement();
	
	String vehicleCode = request.getParameter("vehicleCode");
	
	String fromDateTime = request.getParameter("fromDateTime");
	String toDateTime = request.getParameter("toDateTime");
	String tripId = request.getParameter("tripid");
	String ownerName = request.getParameter("ownername");

	SimpleDateFormat sd1 = new SimpleDateFormat("dd-MMM-yyyy");
	SimpleDateFormat sd2 = new SimpleDateFormat("dd-MMM-yyyy");
	%>
	<form name = "disconn" action="disconnectionFeedbackInsert.jsp" method="post">
	<%
			String msg="";
			try{
				msg=request.getParameter("msg");
			System.out.println(msg);
			}
			catch(Exception ee){
				//ee.printStackTrace();
			}
			if(null==msg||("null").equalsIgnoreCase(msg)||"".equalsIgnoreCase(msg)){
				
			}
			else if("inserted".equalsIgnoreCase(msg)){
				System.out.println(msg);
				%>
				<table align="center">
				<tr><td align="center" ><font color="maroon">Inserted Successfully</font></td></tr>
				</table>
				<%
			}
			%>
<table border="0" width="100%">
	<!--<tr>
		<th colspan="3" align="center"><font size="3">Fleet
		Disconnection Report for Trip< %=" "+tripId%> &nbsp;&nbsp; From:< %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime))%>&nbsp;To:< %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime))%></font></th>
		
	</tr>-->
	<tr>
		<th colspan="3" align="center"><font size="3">Fleet
		Disconnection Report for Trip<%=" "+tripId%> &nbsp;&nbsp; </font></th>
		
	</tr>
</table>
<table class="sortable">
	<tr>

		<td class="hed">
		<div class="bodyText"><b> Sr. </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> Transporter </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> VehicleRegNumber </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>OFF Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>From Location</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>ON Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>To Location</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Distance</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Duration (hh:mm)</b></div>
		</td>
		
		<td class="hed">
		<div class="bodyText"><b>Driver Feedback</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Trainer Feedback</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Status</b></div>
		</td>
		
		
	</tr>
	<%
			int i=0,cnt=0;
			String fromDate1="",toDate1="";
			String fromLocation="",toLocation="",distance="",duration="",tripid="",rowId="",VehicleRegNo="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;

			//String sql12="SELECT * FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vehicleCode+"' AND VehRegNo='"+VehicleRegNo+"' AND OffTimeTo>='"+fromDateTime+"' and OffTimeTo<='"+toDateTime+"'";
			String sql12="SELECT * FROM db_gps.t_disconnectionData WHERE TripId like '%"+tripId+"%' and reason='Disconnection' and ignoredstamp='No' and Duration>='0:30'";
			ResultSet rsSql=st.executeQuery(sql12);
			while(rsSql.next())
			{
				i++;
				rowId = rsSql.getString("rid");
				VehicleRegNo = rsSql.getString("VehRegNo");
				fromDate1 = rsSql.getString("OffTimeFrom");
				fromLocation = rsSql.getString("FromLocation");
				fromLatitude = rsSql.getDouble("FromLatitude");
				fromLongitude = rsSql.getDouble("FromLongitude");
				toDate1 = rsSql.getString("OffTimeTo");
				toLocation = rsSql.getString("ToLocation");
				toLatitude = rsSql.getDouble("ToLatitude");
				toLongitude = rsSql.getDouble("ToLongitude");
				distance = rsSql.getString("Distance");
				duration = rsSql.getString("Duration");
			
				int length=duration.length();
				String disconnectDuration="";
				if(duration.charAt(length-2)==':') //if duration is 1:6 then display as 1:06
				{
					disconnectDuration=duration.replace(":",":0");
				}
				else
				{
					disconnectDuration=duration;
				}
				
%>

	<tr>
		<td style="text-align: right"><%=i%><input type="hidden" name="rowid<%=i%>" id = "rowid<%=i%>" value="<%=rowId%>"></input></td>
		<td style="text-align: left"><%=ownerName%></td>
		<td style="text-align: left"><%=VehicleRegNo%></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1))%></td>
		<td style="text-align: right"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=fromLatitude%>&long=<%=fromLongitude%>&discription=<%=fromLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=fromLocation%>
		</a></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1))%></td>
		<td style="text-align: right"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=toLatitude%>&long=<%=toLongitude%>&discription=<%=toLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=toLocation%>
		</a></td>
		<td style="text-align: right"><%=distance%></td>
		<td style="text-align: right"><%=disconnectDuration%></td>
		
		<td><textarea id="driverfb<%=i%>" name="driverfb<%=i%>" rows="4" cols="25" class="formElement" /> </textarea></td>
		<td><textarea id="trainerfb<%=i%>" name="trainerfb<%=i%>" rows="4" cols="25" class="formElement"/> </textarea></td>
		<td>
			<select id="status<%=i%>" name="status<%=i%>">
				<option value="notconfirmed" selected>Not-confirmed</option>
				<option value="confirmed">Confirmed</option>
			</select>
		</td>

	</tr>
	
<%
			cnt=i;
		}
%>
	<tr>
		<td colspan="13" align="center"><input type="submit" id="sub" name="sub" value="Submit"></input>
		<input type="hidden" name="vehicleCode" value="<%=vehicleCode%>"></input>
		<input type="hidden" name="fromDateTime" value="<%=fromDateTime%>"></input>
		<input type="hidden" name="toDateTime" value="<%=toDateTime%>"></input>
		<input type="hidden" name="tripid" value="<%=tripId%>"></input>
		<input type="hidden" name="ownername" value="<%=ownerName%>"></input>
		<input type="hidden" name="cnt" value="<%=cnt%>"></input>
		</td>
	</tr>
			<%
			st.close();
			conn1.close();
	}
catch(Exception e)
{
	out.println("Exception---->"+e);
}
			
%>
</table>
</form>
<%@ include file="footernew.jsp"%>
</body>
</html>