<%@ include file="headernew.jsp"%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.BriefingDebriefingSummary"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.BothBriefingDebriefingSummary"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<%!private String getDate(final String input) {
		String date = "";
		try {
			date = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(input));
		} catch (Exception e) {
			date = "-";
		}
		return date;
	}

	private String getRating(final String dist, final String rating) {
		String tripRating = "";
		NumberFormat nf1 = DecimalFormat.getNumberInstance();
		nf1.setMaximumFractionDigits(2);
		nf1.setMinimumFractionDigits(2);
		nf1.setGroupingUsed(false);
		if (Double.parseDouble(dist) == 0.0) {
			tripRating = "NA";
		} else {
			
			tripRating = nf1.format(Double.parseDouble(rating));
		}
		return rating;
	}%>
<%
	String drivername = request.getParameter("drvName");
	String driverid = request.getParameter("driverid");
%>
<form action="#" method="get" name="driverhistory">
<input type="hidden" name="drvName" value="<%=drivername%>" /> 
<input	type="hidden" name="driverid" value="<%=driverid%>" /> <%
 	String fromDate, toDate, selectedDate1, datenew, selectedDate2;
 	String brfDate = "";
 	String trainername = "";
 	String brStatus = "";
 	String pagefrom = "";

 	String tripid = request.getParameter("tripid");
 	pagefrom = request.getParameter("rdpassport");
 	selectedDate1 = request.getParameter("data");
 	selectedDate2 = request.getParameter("data1");
 	if (null == selectedDate1) {
 		selectedDate1 = selectedDate2 = new SimpleDateFormat(
 				"dd-MMM-yyyy").format(new java.util.Date());
 		fromDate = new SimpleDateFormat("yyyy-MM-dd")
 				.format(new SimpleDateFormat("dd-MMM-yyyy")
 						.parse(selectedDate1));
 		toDate = new SimpleDateFormat("yyyy-MM-dd")
 				.format(new SimpleDateFormat("dd-MMM-yyyy")
 						.parse(selectedDate2));
 	} else {
 		fromDate = new SimpleDateFormat("yyyy-MM-dd")
 				.format(new SimpleDateFormat("dd-MMM-yyyy")
 						.parse(selectedDate1));
 		toDate = new SimpleDateFormat("yyyy-MM-dd")
 				.format(new SimpleDateFormat("dd-MMM-yyyy")
 						.parse(selectedDate2));

 	}
 	int numRecords = 0;
 	int numRecordsForBoth = 0;
 	List<BriefingDebriefingSummary> data = null;
 	List<BothBriefingDebriefingSummary> dataForBoth = null;
 	try {
 		if ("brif".equalsIgnoreCase(pagefrom)
 				|| "debrif".equalsIgnoreCase(pagefrom)) {
 			System.out.println("group name--->"+session.getAttribute("usertypevaluemain").toString());
 			
 			data = vehicleDao.getBriefingDebriefingSummary(session
 					.getAttribute("usertypevaluemain").toString(),
 					pagefrom, fromDate, toDate, driverid);
 			numRecords = data.size();
 		} else {
 			dataForBoth = vehicleDao.getBothBriefingDebriefingSummary(
 					session.getAttribute("usertypevaluemain")
 							.toString(), pagefrom, fromDate, toDate,
 					driverid);
 			numRecords = dataForBoth.size();
 			System.out.println("numRecords--->"+numRecords);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %>

<table width="100%" align="center" class="stats" border="1">
	<tr>
		<td width="100%" align="center"><font size="2"><b>Driver History Report of <%=drivername%></b></font></td>
	</tr>
	<tr>
		<td class="sorttable_nosort">
		<table border="" width="100%" align="center" class="sortable_entry">
			<tr>
				<td align="left" colspan="3"><input type="radio"
					name="rdpassport" value="brif" CHECKED><b>BriefingHistory</b>&nbsp;&nbsp;
				<input type="radio" name="rdpassport" value="debrif"><b>Debriefing History </b> <input type="radio" name="rdpassport" value="both"><b>Both(Briefing
				and Debriefing done)</b></td>
			</tr>
			<tr>
				<td align="center"><B>Form&nbsp;&nbsp;</B> <input type="text"
					id="data" name="data" value="<%=selectedDate1%>" size="15" readonly />
				<script type="text/javascript">
		  					Calendar.setup(
		    				{
		      				inputField  : "data",         // ID of the input field
		      				ifFormat    : "%d-%b-%Y",     // the date format
		      				button      : "data"       // ID of the button
		    				}
					);
		  					</script>
		  					</td>
		  					<td align="center"><b>To&nbsp;&nbsp;</b>
		  							<input type="text" id="data1" name="data1"  value="<%=selectedDate2%>" size="15" readonly/>
		  							<script type="text/javascript">

							Calendar.setup( {
							inputField  : "data1",         // ID of the input field
		      				ifFormat    : "%d-%b-%Y",    // the date format
		      				button      : "data1"       // ID of the button
		    				}
		  					);
					</script></td>
				<td align="center"><input type="submit" name="submit"
					id="submit" value="submit"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
<%
	if (!(null == request.getParameter("submit"))) {
%>
<table width="100%" align="center" class="stats">
	<tr>
		<td class="sorttable_nosort">
		<div id="report_heding" align="center"><b><font
			size="2"> 
<%
 	if (pagefrom.equals("brif")) {
 			out.print(" Briefing ");
 		} else if (pagefrom.equals("debrif")) {
 			out.print(" Debriefing ");
 		} else {
 			out.print(" Briefing Debriefing  ");
 		}
 
 %> Report for <%=drivername%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate))%>
		to <%=new SimpleDateFormat("dd-MMM-yyyy")
								.format(new SimpleDateFormat("yyyy-MM-dd")
										.parse(toDate))%>
		</font></b></div>
		<div align="right">
		<a href="#"
			onclick="javascript:window.print();" title="Print Report"><img
			src="images/print.jpg" width="15px" height="15px"> </a>&nbsp;&nbsp; 
		<a href="Excel_DriverbrifHistory.jsp?data=<%=fromDate%>&data1=<%=toDate%>&driverNm=<%=drivername%>&driverid=<%=driverid%>&pgFrom=<%=pagefrom%>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"> </a>&nbsp;&nbsp;&nbsp; <%=Utilities.printDate()%></div>
		</td>
	</tr>
</table>
<table width="100%" border="1" align="center" class="stats">
	<tr>
		<th class="hed" rowspan="2" align="center">Sr.</th>
<%
			if (pagefrom.equals("brif")) {
%>
		<th class="hed" rowspan="2" colspan="3" align="center">Briefing
		Date</th>
<%
			} else if (pagefrom.equals("debrif")) {
%>
		<th class="hed" rowspan="2" colspan="3" align="center">Debriefing
		Date</th>
<%
			} else {
%>
		<th class="hed" rowspan="2" colspan="3" align="center">Briefing Date</th>
		<th class="hed" rowspan="2" colspan="3" align="center">Debriefing Date</th>
<%
			}
				if (pagefrom.equals("brif")) {
%>
		<th class="hed" colspan="" rowspan="2" align="center">Trainer Name</th>
<%
			} else if (pagefrom.equals("debrif")) {
%>
		<th class="hed" colspan="" rowspan="2" align="center">Trainer ID</th>
<%
			} else {
%>
		<th class="hed" rowspan="2" colspan="3" align="center">Briefing Trainer ID</th>
		<th class="hed" rowspan="2" colspan="3" align="center">Debriefing Trainer ID</th>
<%
			}
%>
		<th class="hed" rowspan="2" align="center">Vehicle No</th>
		<th class="hed" rowspan="2" align="center">Trip id</th>
		<th class="hed" rowspan="2" align="center">Transporter</th>
		<th class="hed" colspan="4" align="center">Trip</th>
		<th class="hed" rowspan="2" align="center">GPS Working</th>
		<th class="hed" rowspan="2" align="center">JRM Brif</th>
		<th class="hed" colspan="7" align="center">Violations</th>
<%
			if (pagefrom.equals("brif")) {
%>
		<th class="hed" rowspan="2" colspan="4" align="center">Briefing
		Remark</th>
<%
			} else if ((pagefrom.equals("debrif"))) {
%>
		<th class="hed" rowspan="2" colspan="4" align="center">Debriefing
		Remark</th>
<%
			} else {
%>
		<th class="hed" rowspan="2" colspan="4" align="center">Briefing Remark</th>
		<th class="hed" rowspan="2" colspan="4" align="center">Debriefing Remark</th>
<%
			}
%>
	</tr>
	<tr>
<%
			if (session.getAttribute("usertypevaluemain").toString()
						.equals("Castrol")) {
%>
		<th class="hed">Castrol/Non Castrol</th>
<%
			} else if (session.getAttribute("usertypevaluemain").toString()
						.equals("BS")) {
%>
		<th class="hed">Shell/Non Shell</th>
<%
			} else {
%>
		<th class="hed">Cas./N-Cas. OR Shell/N-Shell</th>
<%
			}
%>
		<th class="hed" align="center">From</th>
		<th class="hed" align="center">To</th>
		<th class="hed" align="center">Distance</th>
		<th class="hed" align="center">OS</th>
		<th class="hed" align="center">OS Dur.</th>
		<th class="hed" align="center">RA</th>
		<th class="hed" align="center">RD</th>
		<th class="hed" align="center">CD</th>
		<th class="hed" align="center">ND</th>
		<th class="hed" align="center">Rating</th>
	</tr>
<%try{
			if("brif".equalsIgnoreCase(pagefrom)
					|| "debrif".equalsIgnoreCase(pagefrom)){
				
				for (int counter = 0; counter < numRecords; counter++) {
					final BriefingDebriefingSummary currentRecord = data.get(counter);
					int i= counter + 1;
%>
					<tr>
						<td style="text-align: right"><%=i%></td>
						<td colspan="3" style="text-align: left"><%=getDate(currentRecord.getBriefDebriefDate())%></td>
						
						<td colspan="" style="text-align: left"><%=currentRecord.getTrainerName()%></td>
						<td style="text-align: left"><%=currentRecord.getVehicleRegistrationNumber()%></td>
						<td style="text-align: right"><%=currentRecord.getTripId()%></td>
						<td style="text-align: left"><%=currentRecord.getTransporter()%></td>
						<td style="text-align: left">Castrol</td>
						<td style="text-align: left"><%=currentRecord.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecord.getEndPlace()%></td>
						<td style="text-align: right"><%=currentRecord.getDistance()%></td>
						<td style="text-align: left"><%=currentRecord.getGpsWorkingInfo()%></td>
						<td style="text-align: left"><%=currentRecord.getJrmBriefInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedCount()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedDuration()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidAccelerationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidDecelarationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getContinuousDrivingCount()%></td>
						<td style="text-align: right"><%=currentRecord.getNightDrivingCount()%></td>
						<td colspan="1" style="text-align: left"><%=getRating(currentRecord.getDistance(),currentRecord.getRating())%></td>

						<td style="text-align: let"><a href="#"
							onclick="javascript:window.open('remarrk.jsp?remark=brief&driverid=<%=driverid%>&brdate=<%=currentRecord.getBriefDebriefDate()%>','','menubar=1,resizable=1,width=550,height=350,location=no');">
						<%=currentRecord.getRemark()%></a></td>
						
					</tr>
<%
						i++;
							
%>
<%				
				}
			}
			else{
				for (int counter = 0; counter < numRecords; counter++) {
					final BothBriefingDebriefingSummary currentRecordForBoth = dataForBoth.get(counter);
				int i=counter+1;
%>
					<tr>
						<td style="text-align: right"><%=i%></td>
						<td colspan="3" style="text-align: left"><%=getDate(currentRecordForBoth.getBriefDate())%></td>
						<td colspan="3" style="text-align: left"><%=getDate(currentRecordForBoth.getDebriefDate())%></td>
						<td colspan="3" style="text-align: left"><%=currentRecordForBoth.getBriefTrainerName()%></td>
						<td colspan="3" style="text-align: left"><%=currentRecordForBoth.getDebriefTrainerName()%></td>
						<td style="text-align: left"><%=currentRecordForBoth.getVehicleRegistrationNumber()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getTripId()%></td>
						<td style="text-align: left"><%=currentRecordForBoth.getTransporter()%></td>
						<td style="text-align: left">Castrol</td>
						<td style="text-align: left"><%=currentRecordForBoth.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecordForBoth.getEndPlace()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getDistance()%></td>
						
						<td style="text-align: left"><%=currentRecordForBoth.getGpsWorkingInfo()%></td>
						<td style="text-align: left"><%=currentRecordForBoth.getJrmBriefInfo()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getOverSpeedCount()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getOverSpeedDuration()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getRapidAccelerationCount()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getRapidDecelarationCount()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getContinuousDrivingCount()%></td>
						<td style="text-align: right"><%=currentRecordForBoth.getNightDrivingCount()%></td>
						<td colspan="1" style="text-align: left"><%=getRating(currentRecordForBoth.getDistance(),currentRecordForBoth.getRating())%></td>
						<td colspan="4" style="text-align: left"><a href="#"
							onclick="javascript:window.open('remarrk.jsp?remark=brief&driverid=<%=driverid%>&brdate=<%=currentRecordForBoth.getBriefDate()%>','','menubar=1,resizable=1,width=550,height=350,location=no');">
						<%=currentRecordForBoth.getBriefingRemark()%></a></td>
						<td colspan="4" style="text-align: left"><a href="#"
							onclick="javascript:window.open('remarrk.jsp?remark=debrief&driverid=<%=driverid%>&brdate=<%=currentRecordForBoth.getDebriefDate()%>','','menubar=1,resizable=1,width=550,height=350,location=no');">
						<%=currentRecordForBoth.getDebriefingRemark()%></a></td>
<%
				i++;
				}
			}
	}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</table>
<%
	}
%>
<%@ include file="footernew.jsp"%>