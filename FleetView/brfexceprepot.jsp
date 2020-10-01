
<%@ include file="headernew.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*" import=" java.text.*"
	errorPage=""%>

<%@page import="com.fleetview.beans.ZoneColorIdentificationImpl"
	import="com.transworld.fleetview.framework.GetTripDetails"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<table width="85%" align="center">
	<tr>
		<td>
<%
	final String tripID, vehicleID,routeID;
	tripID = request.getParameter("tripid");
	final String startDate=request.getParameter("startDate").toString();
	final String endDate=request.getParameter("endDate").toString();
	
	List<GetTripDetails> tripDetailsData = null;
	try {
		tripDetailsData = vehicleDao.getTripDetails(tripID);
	} catch (Exception e) {
		e.printStackTrace();
	}
	vehicleID=tripDetailsData.get(0).getVehicleCode();
	ZoneColorIdentificationImpl zoneColor = new ZoneColorIdentificationImpl();
	routeID = zoneColor.getRouteId(vehicleID);
	//System.out.println();
	%>
			<table border="0" class="stats">
				<tr>
					<td align="center"><font size="2">
					Exception Report for the trip :-<%=tripID%>, Driver Name :-<%=tripDetailsData.get(0).getDriverName()%><%=" (" + tripDetailsData.get(0).getDriverId() + ")"%>
					Start Place :-<%=tripDetailsData.get(0).getStartPlace()%> , End Place :-<%=tripDetailsData.get(0).getEndPlace()%>
					</font>
					<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
								.format(new java.util.Date())%></div>
					</td>
				</tr>
			</table>
	
	<table class="stats">
			<tr>
				<th colspan="4">Over Speed</th>
			</tr>
			</table>
				<table class="sortable" border="1" width="100%">
			<tr>
				<td class="hed">Date-Time</td>
				<td class="hed">Speed</td>
				<td class="hed">Duration</td>
				<td class="hed">Location</td>
			</tr>
			<%
				List<OverSpeedDetailsData> overSpeedData = null;
				String zoneColorOS = "";
				int numRecords = 0;
				int numRecordsOS=0;
				String bgColorOS="";
				
				try {
					overSpeedData = vehicleDao.getOverSpeedData(startDate, endDate , vehicleID);
					numRecords = overSpeedData.size();
				} catch (Exception e) {
					e.printStackTrace();
				}
				for (int counter = 0; counter < numRecords; counter++) {
					final OverSpeedDetailsData currentRecord = overSpeedData.get(counter);
					try{
						if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
						{
								
						}
						else{
							bgColorOS = zoneColor.getZoneColor(routeID,Double.parseDouble(currentRecord.getLatitude()),Double.parseDouble(currentRecord.getLongitude()));
						}
						
					}
					catch(Exception e){
						e.printStackTrace();
					}
					
			%>
			<tr>
				<td class="bodyText" style="<%=bgColorOS%>; text-align: left">
				<%
					java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd")
								.parse(currentRecord.getFromDate());
						Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
						String showdate1 = formatter1.format(ShowDate1);
						out.print(showdate1);
				%> <%=currentRecord.getFromTime()%></td>
				<td class="bodyText" style="<%=bgColorOS%>; text-align: right"><%=currentRecord.getSpeed()%></td>
				<td class="bodyText" style="<%=bgColorOS%>; text-align: right"><%=currentRecord.getDuration()%></td>
				<td class="bodyText" style="<%=bgColorOS%>">
				<div align="left"><%=currentRecord.getLocation()%></div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
<br></br>
		<table class="stats" border="1" width="100%">
			<tr>
				<th colspan="4">Rapid Acceleration</th>
			</tr>
			</table>
			<table class="sortable" border="1" width="100%">
			<tr>
				<td class="hed">Date-Time</td>
				<td class="hed">From Speed</td>
				<td class="hed">To Speed</td>
				<td class="hed">Location</td>
			</tr>
			<%
				List<RapidAccelerationDetailsData> RapidAccelerationData = null;
				String zoneColorRA = null;
				int RapidAccelerationNumRecords = 0;
				int numRecordsRA =0;
				String bgColorRA="";
				try {
					RapidAccelerationData = vehicleDao.getRapidAccelerationDetailsData(vehicleID,startDate, endDate,"RapidAcceleration");
					RapidAccelerationNumRecords = RapidAccelerationData.size();
				} catch (Exception e) {
					e.printStackTrace();
				}
				for (int counter = 0; counter < RapidAccelerationNumRecords; counter++) {
					final RapidAccelerationDetailsData currentRecord = RapidAccelerationData.get(counter);
						
						try{
							if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
							{
									
							}
							else{
							bgColorRA = zoneColor.getZoneColor(routeID,Double.parseDouble(currentRecord.getLatitude()),Double.parseDouble(currentRecord.getLongitude()));
							}
						}
						catch(Exception e){
							e.printStackTrace();
						}
			%>
			<tr>
				<td class="bodyText" style="<%=bgColorRA%>; text-align: left">
				<%
					java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd")
								.parse(currentRecord.getDate());
						Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
						String showdate1 = formatter1.format(ShowDate1);
						out.print(showdate1);
				%> <%=currentRecord.getTime()%></td>
				<td class="bodyText" style="<%=bgColorRA%>; text-align: right"><%=currentRecord.getFromSpeed()%></td>
				<td class="bodyText" style="<%=bgColorRA%>; text-align: right"><%=currentRecord.getToSpeed()%></td>
				<td class="bodyText" style="<%=bgColorRA%>; text-align: left">
				<div align="left">
				<%
					out.print(currentRecord.getLocation());
				%>
				</div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<br></br>
		<table class="stats" border="1" width="100%">
			<tr>
				<th colspan="4">Rapid Deceleration</th>
			</tr>
			</table>
			<table class="sortable" border="1" width="100%">
			<tr>
				<td class="hed">Date-Time</td>
				<td class="hed">From Speed</td>
				<td class="hed">To Speed</td>
				<td class="hed">Location</td>
			</tr>
			<%
				List<RapidAccelerationDetailsData> RapidDeccelerationdata = null;
				String zoneColorRD = null;
				int RapidDeccelerationNumRecords = 0;
				int numRecordsRD =0;
				String bgColorRD="";
				try {
					RapidDeccelerationdata = vehicleDao
							.getRapidAccelerationDetailsData(vehicleID, startDate, endDate,
									"RappidDecceleration");
					RapidDeccelerationNumRecords = RapidDeccelerationdata.size();
					//System.out.println("RapidDeccelerationdata====>"+RapidDeccelerationNumRecords);
				} catch (Exception e) {
					e.printStackTrace();
				}
				for (int counter = 0; counter < RapidDeccelerationNumRecords; counter++) {
					final RapidAccelerationDetailsData currentRecord = RapidDeccelerationdata
							.get(counter);
					
					try{
						if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
						{
								
						}
						else{
						bgColorRD = zoneColor.getZoneColor(routeID,Double.parseDouble(currentRecord.getLatitude()),Double.parseDouble(currentRecord.getLongitude()));
						}
					}
					catch(Exception e){
						e.printStackTrace();
					}
				
			%>
			<tr>
				<td class="bodyText" style="<%=bgColorRD%>; text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat(
				"yyyy-MM-dd")
				.parse(currentRecord
						.getDate()))%>
				<%=currentRecord.getTime()%></td>
				<td class="bodyText" style="<%=bgColorRD%>; text-align: right"><%=currentRecord.getFromSpeed()%></td>
				<td class="bodyText" style="<%=bgColorRD%>; text-align: right"><%=currentRecord.getToSpeed()%></td>
				<td class="bodyText" style="<%=bgColorRD%>">
				<div align="left">
				<%
					out.print(currentRecord.getLocation());
				%>
				</div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
<br></br>
		<table class="stats" border="1" width="100%">
			<tr>
				<th colspan="4">Stops</th>
			</tr>
			</table>
			<table class="sortable" border="1" width="100%">
			<tr>
				<td class="hed">Start Date-Time</td>
				<td class="hed">End Date-Time</td>
				<td class="hed">Duration</td>
				<td class="hed">Location</td>
			</tr>
			<%
				List<ContinuousDrivingDetailsData> Stopsdata = null;
				String zoneColorStops = null;
				int StopsNumRecords = 0;
				int num=0;
				String bgColor="";
				try {
					Stopsdata = vehicleDao.getContinuousDrivingDetailsData(
							vehicleID,
							startDate, endDate, "Stops");
					StopsNumRecords = Stopsdata.size();
					//System.out.println("StopsNumRecords====>"+StopsNumRecords);
				} catch (Exception e) {
					e.printStackTrace();
				}
				for (int counter = 0; counter < StopsNumRecords; counter++) {
					final ContinuousDrivingDetailsData currentRecord = Stopsdata
							.get(counter);
					try{
						if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
						{
								
						}
						else{
						bgColor =zoneColor.getZoneColor(routeID,Double.parseDouble(currentRecord.getStartLocationLatitude()),Double.parseDouble(currentRecord.getStartLocationLongitude()));
						}
					}
					catch(Exception e){
						e.printStackTrace();
					}
			%>
			<tr>
				<td style="<%=bgColor%>; text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat(
				"yyyy-MM-dd")
				.parse(currentRecord
						.getStartDate()))%>
				<%=currentRecord.getStartTime()%></td>
				<td style="<%=bgColor%>; text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat(
				"yyyy-MM-dd")
				.parse(currentRecord
						.getEndDate()))%>
				<%=currentRecord.getEndTime()%></td>
				<td style="<%=bgColor%>; text-align: right"><%=currentRecord.getDuration()%></td>
				<td style="<%=bgColor%>; text-align: left"><%=currentRecord.getStartLocation()%></td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div align="center"><input type="button" Name="Print Report"
			value="Print Report" onclick="javascript:window.print();"
			class="formElement"></div>
		</td>
	</tr>
</table>