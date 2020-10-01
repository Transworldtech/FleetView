<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<%

	final String vehicleRegistrationNumber = request
			.getParameter("vehno");
	final String vehicleCode = request.getParameter("vid");
	 String fromDate = (null != request.getParameter("dd")) ? request
			.getParameter("dd")
			: session.getAttribute("data1").toString();
	 String toDate = (null != request.getParameter("dd")) ? request
			.getParameter("dd")
			: session.getAttribute("data2").toString();

	final String tbname = "t_veh" + vehicleCode + "_stsp";
	
%>
<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">
		<%
			if (session.getAttribute("reportno").toString().equals(
					"Report No:3.0")) {
		%>
		<!-- <div align="left"><font size="3"> Report No:3.11 </font></div>-->
		<font size="3" face="Arial"><b>Stops Report</b></font> <%
 	}
 	if (session.getAttribute("reportno").toString().equals(
 			"Report No:4.0")) {
 %>
		<!--<div align="left"><font size="3"> Report No:4.11 </font></div>-->
		<font size="3" face="Arial"><b>Stops Report</b></font> <%
 	}
 	if (session.getAttribute("reportno").toString().equals(
 			"Report No:5.0")) {
 %>
		<!--<div align="left"><font size="3"> Report No:5.11 </font></div>-->
		<font size="3" face="Arial"><b>Stops Report</b></font> <%
 	}
 	if (session.getAttribute("reportno").toString().equals(
 			"Report No:6.0")) {
 %>
		<!--<div align="left"><font size="3"> Report No:6.11 </font></div>-->
		<font size="3" face="Arial"><b>Stops Report</b></font> <%
 	}
 %>
		</td>
	</tr>

	<tr>
		<td align="center"><font size="3"> <b>STOP REPORT for
		Vehicle <%=vehicleRegistrationNumber%> From Date :<%
 	java.util.Date date = new SimpleDateFormat("yyyy-MM-dd")
 			.parse(fromDate);
 	Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
 	String fromdt = formatter.format(date);
 	out.print(fromdt);
 %> To Date :<%
 	java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd")
 			.parse(toDate);
 	Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
 	String todt = formatter1.format(date3);
 	out.print(todt);
 %> </b></font>
		<div class="bodyText" align="right"><a href="#"
			onclick="javascript:window.open('print_detail_stops.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>');"
			title="Print Report"><img src="images/print.jpg" width="15px"
			height="15px"></a>&nbsp; &nbsp; <a
			href="Exportdetail_stops.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a>&nbsp;&nbsp;&nbsp; <%=Utilities.printDate()%></div>
		</td>
	</tr>
	<tr>
		<td>
		<table class="sortable">
			<tr>
				<th>Sr.</th>
				<th>From Date-Time</th>
				<th>To Date-Time</th>
				<th>Duration</th>
				<th>Location</th>
			</tr>

			<%
				try {
					List<ContinuousDrivingDetailsData> data = null;
					int numRecords = 0;
					try {
						data = vehicleDao.getContinuousDrivingDetailsData(
							vehicleCode, fromDate+" 00:00:00", toDate+" 23:59:59", "Stops");
						numRecords = data.size();
					} catch (Exception e) {
						e.printStackTrace();
					}
					for (int counter = 0; counter < numRecords; counter++) {
						final ContinuousDrivingDetailsData currentRecord = data
								.get(counter);
			%>
			<tr>

				<td style="text-align: right"><%=counter + 1%></td>
				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord
															.getStartDate()))%> <%= new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord.getStartTime())) %></td>

				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord
															.getEndDate()))%> <%= new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord.getEndTime()))%></td>

				<td style="text-align: left"><%= new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord.getDuration()))%></td>

				<td>
				<div align="left">
				<%
					if (null != currentRecord.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord
											.getStartLocation())
									&& null != currentRecord.getStartLocationLatitude()) {
						String lat1=currentRecord.getStartLocationLatitude();
						String lon1=currentRecord.getStartLocationLongitude();
						String disc=currentRecord.getStartLocation();
%>							 
						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord
											.getStartLocation())) {
								out.println(currentRecord.getStartLocation());
							}
				%>
				</div>
				</td>

			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</table>
		</td>
	</tr>
</table>

<%@ include file="footernew.jsp"%>