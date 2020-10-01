<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>


<% response.setContentType("application/vnd.ms-excel");
String filename=session.getAttribute("user").toString();
int cnt= 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_currentposStop_report.xls";
}
else
{
	filename = filename=session.getAttribute("user").toString()+"_currentposStop_report.xls";
}
System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
    %>
<%@page import="com.transworld.fleetview.framework.VehiclePositionData"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
		import="com.transworld.fleetview.framework.VehiclePositionsViewData"
		import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataResults" %>
		<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>

<jsp:useBean id="vehiclePositionsViewDataProvider" 
			 type="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
			 scope="application"></jsp:useBean>		

  <%@ include file="Connections/conn.jsp" %>

	<table border="0" width="100%" align="center"> 
 	
	<tr></tr>
	</table>
<%!private String getFromDate() {

		String fromdate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new java.util.Date());
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(sdate1));
		} catch (Exception e) {
			try {
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
								.parse(sdate1));
			} catch (Exception e1) {
			}
		}
		return fromdate;
	}

	private String getToDate() {

		String todate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new java.util.Date());
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(sdate1));
		} catch (Exception e) {
			try {
				todate = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
								.parse(sdate1));
			} catch (Exception e1) {
			}
		}
		return todate;
	}

	private int getFromTimeHrs() {
		return 0;
	}

	private int getFromTimeMins() {
		return 0;
	}

	private int getToTimeHrs() {
		return 23;
	}

	private int getToTimeMins() {
		return 59;
	}

	private String getTripStartDate(final String datetime) {
		String fromdate = "";
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(datetime));
		} catch (Exception e) {
			try {
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
								.parse(datetime));
			} catch (Exception e1) {
			}
		}
		return fromdate;
	}

	private String getTripEndDate(final String datetime) {
		String todate = "";
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new java.util.Date());
		} catch (Exception e) {
		}
		return todate;
	}

	private String getTripStartTimeHrs(final String datetime) {
		String ftime1 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(datetime);
			ftime1 = new SimpleDateFormat("HH").format(dt);
		} catch (Exception e) {
		}
		return ftime1;
	}

	private String getTripStartTimeMins(final String datetime) {
		String ftime2 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(datetime);
			ftime2 = new SimpleDateFormat("mm").format(dt);
		} catch (Exception e) {
		}
		return ftime2;
	}

	private String getTripEndTimeHrs(final String datetime) {
		String ttime1 = "23";
		try {
			ttime1 = new SimpleDateFormat("HH").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}

	private String getTripEndTimeMins(final String datetime) {
		String ttime1 = "59";
		try {
			ttime1 = new SimpleDateFormat("mm").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}

	private boolean isOSTodayZero(String osToday) {
		try {
			if (Integer.parseInt(osToday) > 0) {
				return true;
			}
		} catch (Exception e) {
		}
		return false;
	}

	private String getfuelAlert_AddedTodayDate() {
		String today = "", prevDay = "";
		Calendar cal;
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		cal = Calendar.getInstance();
		today = dateFormat.format(cal.getTime());
		return today;

	}

	private String getfuelAlert_AddedPreviousDate() {
		String today = "", prevDay = "";
		Calendar cal;
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");

		cal = Calendar.getInstance();
		today = dateFormat.format(cal.getTime());

		cal.add(Calendar.DATE, -1);
		prevDay = dateFormat.format(cal.getTime());

		return prevDay;

	}%>
<%
	final String userTypeValue = session.getAttribute("usertypevalue").toString();
	final String typeOfUser = session.getAttribute("TypeofUser").toString();
	final String distanceFormat = session.getAttribute("distformat").toString();
	final String fuelFormat = session.getAttribute("fuelformat").toString();
	final String commaSeparatedVehicleList = session.getAttribute("VehList").toString();
	final int disConnected = Integer.parseInt(session.getAttribute("desconnected").toString());
	String condi=request.getParameter("condition");
	System.out.println(">>>>>>>>>++ " +condi);
	final String fromPage="currentPosition";
	String requestParamSearchVeh = request.getParameter("searchveh");
	if (null == requestParamSearchVeh) {
		requestParamSearchVeh = "";
	}

	@SuppressWarnings("unchecked")
	final VehiclePositionsViewDataResults viewData = 
		(VehiclePositionsViewDataResults) session.getAttribute("VehiclePositionsViewData");
	int numRecords = 0;
	try{
		 numRecords = viewData.getCount();
	} catch(Exception e){
		e.printStackTrace();
	}
	
%>


<jsp:include page="SubUserView.jsp">
	<jsp:param name="username" value="<%=requestParamSearchVeh%>"/>
</jsp:include>

	<form name="CountOfRecordsForm">
		<input type="hidden" name= "cnt" id="cnt" value=<%=numRecords%>></input>
	</form>
<table width="100%" align="center">
	<tr>
		<td align="center">
		<!-- <div align="left"><font size="3">Report No:1.2</font></div>-->
		<div id="report_heding"><font size="3"> <b>Mains Disconnected Vehicle</b></font></div>
		<!--<div align="right"><a href="#"
			onclick="javascript:window.open('printstopped.jsp?tdx=show');"
			title="Print Report"><img src="images/print.jpg" width="15px"
			height="15px"></a>&nbsp; &nbsp; <a href="excelstopped.jsp?tdx=show"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a><%//=Utilities.printDate()%></div>-->
		
		</td>
	</tr>
</table>


	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Vehicle Reg.No.</th>
			<th class="hed"> Updated</th>
			<%if(condi.equals("2")){ %>
			<th class="hed" id="tdd0"> Trip Id</th>
			<th class="hed" id="tde0"> Driver Name(Code)</th>
			<th class="hed" id="tda0"> Trip Origin</th>
			<th class="hed" id="tdb0"> Start Date</th>
			<th class="hed" id="tdc0"> Trip Destination</th>
			<%} %>
			<th class="hed" > Location - Click To View On Map.</th>
			<th class="hed"> Fuel</th>
			<th class="hed"> Fuel Alert</th>
<%
	if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
%>
			<th><b>Sen1</b></th>
			<th><b>Sen2</b></th>
			<th><b>Sen3</b></th>
			<th><b>Sen4</b></th>
<%
	}
%>
		</tr>	
<%
try {
	int i = 1;
 	String bgcolor="background-color:#FFC475";

	for (int counter = 0; counter < numRecords; counter++) {
		final VehiclePositionsViewData currentRecord = viewData.getVehiclePositionViewDataAtIndex(counter);
		if (bgcolor.equals(currentRecord.getBgColor())) {
	%>	
		<tr>
			<td align="right" style="<%=currentRecord.getBgColor()%>"><%=i%></td>
			<td align="left" style=" <%=currentRecord.getBgColor()%>">
<%
	if (currentRecord.isDataBlocked()) {
%>
		<%=currentRecord.getVehicleRegistrationNo()%>
<%
	} else {
%>
			<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=currentRecord.getVehicleRegistrationNo()%></font></a>
			
				
<%
	}
%>						
			</td>			
			<td align="left" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getLastUpdatedDateTime()%></td>
			
<%

if(condi.equals("2")){
	if ((currentRecord.isTripDataAvailable())) {
%>
			<td id="tdd<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
				<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><font size="2">
				<%=currentRecord.getTripID()%></font></a>
		
			</td>
			<td id="tde<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
				<%=currentRecord.getDriverNameCode()%>
			</td>
			<td id="tda<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">			
				<%=currentRecord.getTripOrigin()%>
			</td>
			<td id="tdb<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
				<%=currentRecord.getTripStartDateTime()%>
			</td>
			<td id="tdc<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
				<%=currentRecord.getTripDestination()%>
			</td>
<%
	} else {
%>
			<td id="tdd<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
				<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>">
				<%=currentRecord.getTripID()%></a></td>
				<td id="tde<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getDriverNameCode()%></a>
				</td>
				<td id="tda<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">			
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripOrigin()%></a>
				</td>
				<td id="tdb<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord
													.getTripStartDateTime()%></a>
				</td>
				<td id="tdc<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>">
					<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripDestination()%></a>
				</td>
<%
	}}
%>






			<td align="left" style=" <%=currentRecord.getBgColor()%>">
<%
	if (currentRecord.isDataBlocked()|| currentRecord.isDeviceInActive()) {
%>
					<%=currentRecord.getLocationWithDeviceStatus()%>
<%
	} else {			
%>
			<a href="shownewmap.jsp?lat=<%=currentRecord.getLatitude()%>&long=<%=currentRecord.getLongitude()%>&discription=<%=currentRecord.getCurrentLocation()%>" onclick="popWin=open('shownewmap.jsp?lat=<%=currentRecord.getLatitude()%>&long=<%=currentRecord.getLongitude()%>&discription=<%=currentRecord.getCurrentLocation()%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%=currentRecord.getCurrentLocation()%></a><%=currentRecord.getLocationWithDeviceStatus()%>
<%
	}
%>
			
			</td>
			<td id="tdf<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getFuelLevel()%></td>
<%
	if ("FUELFLOW".equalsIgnoreCase(currentRecord.getUnitDescription())) {
%>
			<td id="tdl<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>"><a href="showfuelalert.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedTodayDate()%>&data1=<%=getfuelAlert_AddedTodayDate()%>"><%=currentRecord.getFuelAlert()%></a></td>
			
<%
	} else {
%>
			<td id="tdl<%=i%>" align="left" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getFuelAlert()%></td>
			
<%
	}

	if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
%>
			<td align="right" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor1()%></td>
			<td align="right" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor2()%></td>
			<td align="right" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor3()%></td>
			<td align="right" style="<%=currentRecord.getBgColor()%>"><%=currentRecord.getSensor4()%></td>	
<%			}
	i++;
				}
		
			%>
		</tr>
<%
		}
	} catch (Exception e) {
		out.println("<tr><td colspan=23>");
		out.println("Exception :" + e.getMessage());
		out.println("Cause : " + e.getCause());
		out.println("</td></tr>");
		e.printStackTrace();
	}
%>
	</table>
</body>

<%@ include file="footernew.jsp" %>
  
 