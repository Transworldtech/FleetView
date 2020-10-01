<%@ include file="headernew.jsp"%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.TrainerSummary"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.TrainerSummaryForBothBriefDebrief"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<html>
<head>
<script language="javascript">
function validate()
{
	if(document.getElementById("data").value=="")
	{
	  		alert("Please select the from date");
			return false;
		}
		if(document.getElementById("data1").value=="")
		{
  		alert("Please select the to date");
			return false;
		}
		return datevalidate();
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
var date2=document.getElementById("data1").value;
var dm1,dd1,dy1,dm2,dd2,dy2;
dy1=date1.substring(0,4);
dy2=date2.substring(0,4);
dm1=date1.substring(5,7);
dm2=date2.substring(5,7);
dd1=date1.substring(8,10);
dd2=date2.substring(8,10);
var date=new Date();
var month=date.getMonth()+1;
var day=date.getDate();
var year=date.getFullYear();
if(dy1>year || dy2>year)
{
	alert("selected date should not be greater than todays date");
	document.getElementById("data").value="";
	document.getElementById("data1").value="";
	document.getElementById("data").focus;
	return false;
}
else if(year==dy1 && year==dy2)
{
		if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
}
if(dm1==month)
{
	if(dd1>day || dd2>day)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
}
if(dy1>dy2)
{
	alert("From date year is should not be greater than to date year");
	document.getElementById("data").value="";
	document.getElementById("data1").value="";
	document.getElementById("data").focus;
	return false;
}
else if(year==dy1 && year==dy2) if(dm1>dm2)
{
	alert("From date month is should not be greater than to date month 5");
	document.getElementById("data").value="";
	document.getElementById("data1").value="";
	document.getElementById("data").focus;
	return false;
}
if(dm1==dm2) 
{
	if(dd1 > dd2)
	{
		alert("From date should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
}
return true;
}

</script>
</head>
<body>
<form action="" method="get" name="trainerhistory" onSubmit="return validate();">
<%!
String oscount,racount,rdcount,cdcount,trname="";
%>
<%
String trname1=request.getParameter("trNm");
String trname=session.getAttribute("user").toString();
%>
<input type="hidden" name="trNm" value="<%=trname %>">
<%
try{
String fromDate, toDate, selectedDate1, datenew, selectedDate2;
String brfDate = "";
String trainername = "";
String brStatus = "";
String tripid=request.getParameter("tripid");
String pagefrom="";
pagefrom=request.getParameter("rdpassport");
selectedDate1=request.getParameter("data");
selectedDate2=request.getParameter("data1");
if(null==selectedDate1)
{
	selectedDate1=selectedDate2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(selectedDate1));
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(selectedDate2));

}
else
{
	fromDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(selectedDate1));
	toDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(selectedDate2));

}

	int numRecords = 0;
	int numRecordsForBoth = 0;
	List<TrainerSummary> data = null;
	List<TrainerSummaryForBothBriefDebrief> dataForBoth = null;
	try {
		if ("brif".equalsIgnoreCase(pagefrom)
				|| "debrif".equalsIgnoreCase(pagefrom)) {
			data = vehicleDao.getTrainerSummary(pagefrom,trname, fromDate, toDate);
			numRecords = data.size();
		} else {
			dataForBoth = vehicleDao.getTrainerSummaryForBothBriefDebrief(pagefrom,trname, fromDate, toDate);
			numRecords = dataForBoth.size();
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<table width="100%" align="center" class="sortable" border="1">
<tr>
<td width="100%" align="center">
	<font size="2" color="maroon"><b>&nbsp;&nbsp;&nbsp; Trainer History Report of <%=trname%></b></font>
</td>
</tr>
<tr>
<td  class="sorttable_nosort" >
	
	<table border="1" width="100%" align="center">
		<tr>
			
			<td align="center" colspan="2">
						<input type="radio" name="rdpassport" value="brif" CHECKED> <b>Briefing History</b>&nbsp;&nbsp;
						<input type="radio" name="rdpassport" value="debrif"><b>Debriefing History</b>
						<input type="radio" name="rdpassport" value="both"><b>Both(Briefing and Debriefing done)</b>
			</td>
		</tr>
		<tr>
			<td align="center"><b>From&nbsp;&nbsp;</b>
					<input type="text" id="data" name="data"  value="<%=selectedDate1%>"  size="15" readonly/>
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
  					Calendar.setup(
    				{
      				inputField  : "data1",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",    // the date format
      				button      : "data1"       // ID of the button
    				}
  					);
					</script>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
					<input type="submit" name="submit" id="submit" value="submit">
			</td>					
		</tr>	
	</table>   
 </td>
 </tr>
 </table>
 </form>
 <%
 if(!(null==request.getParameter("submit")))
 {
 %>
<table width="100%" align="center">
<tr>
<td  class="sorttable_nosort">
         <div id="report_heding" align="center"><b><font color="brown" size="2">
<% 		if(pagefrom.equals("brif")) 
		{
			out.print(" Briefing ");
		}else if(pagefrom.equals("debrif"))
		{
			out.print(" Debriefing ");
			}else
			{
				out.print(" Briefing Debriefing  ");
			} 
%> 
		Report for <%=trname %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>
		</font></b></div>
         <div align="right">
         <a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
         <a href="excel_brif_trinerbrifsum.jsp?data=<%=fromDate%>&data1=<%=toDate%>&trNm=<%=trname%>&pgFrom=<%=pagefrom%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
		 <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
		 </div>
</td>
</tr>
</table>
<table width="100%" border="1" align="center" class="sortable">
<tr>
	<th  rowspan="2" align="center" > Sr.</th>
<%		if(pagefrom.equals("brif"))
		{
%>
			<th class="hed" rowspan="2" colspan="3" align="center" > Briefing Date</th>
<%
		}
		else if((pagefrom.equals("debrif")))
		{
%>
			<th class="hed" rowspan="2" colspan="3" align="center" > Debriefing Date</th>
<%
		}
		else
		{
%>
			<th class="hed" rowspan="2" colspan="3" align="center" > Briefing Date</th>
			<th class="hed" rowspan="2"  colspan="3" align="center"> Debriefing Date</th>	
<%	
		}
%>
<%
		if(pagefrom.equals("both"))
		{
%>
				<th class="hed" rowspan="2" colspan="3" align="center">Briefing Trainer</th>
				<th class="hed" rowspan="2" colspan="3" align="center">Debriefing Trainer</th>
<%
		}
%>
			<th class="hed" rowspan="2" align="center">Vehicle No</th>
			<th class="hed" rowspan="2" align="center">Trip id</th>
			<th class="hed" colspan="2" align="center">Driver</th>
			<th class="hed" rowspan="2" align="center">Transporter</th>
			<th class="hed" colspan="4" align="center">Trip</th>
			<th class="hed" rowspan="2" align="center">GPS Working</th>
			<th class="hed" rowspan="2" align="center">JRM Brif</th>
			<th class="hed" colspan="7" align="center">Violations</th>
<%			if(pagefrom.equals("brif"))
			{
%>
			<th class="hed" rowspan="2" colspan="3" align="center">Briefing Remark</th>
<%
			}
			else if((pagefrom.equals("debrif")))
			{
%>
			<th class="hed" rowspan="2" colspan="3" align="center"> Debriefing Remark</th>
<%
			}
			else
			{
%>
			<th class="hed" rowspan="2" colspan="3" align="center"> Briefing Remark</th>
			<th class="hed" rowspan="2" colspan="3" align="center"> Debriefing Remark</th>	
<%	
			}
%>
			
			</tr>
			<tr>
				<th class="hed" align="center">Name</th>
				<th class="hed" align="center">Driver Id</th>
				<th class="hed" align="center"> Castrol/Non Castrol</th>		
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
<%
			if("brif".equalsIgnoreCase(pagefrom)
					|| "debrif".equalsIgnoreCase(pagefrom)){	
				for(int counter=0; counter<numRecords;counter++){
					final TrainerSummary currentRecord = data.get(counter);
					int i= counter +1;
				
%>			
						<tr>
						<td  style="text-align:right"><%=i%></td>
						<td colspan="3"  style="text-align:left"><%=currentRecord.getBriefingDebriefingDate()%></td>
						<td style="text-align:left"><%=currentRecord.getVehicleRegistrationNumber()%></td>
						<td style="text-align:right"><%=currentRecord.getTripId()%></td>
						<td style="text-align:left"><%=currentRecord.getDriverName()%></td>
						<td style="text-align:right"><%=currentRecord.getDriverId()%></td>
						<td style="text-align:left"><%=currentRecord.getTransporter()%></td>
						<td style="text-align: left">Castrol</td>
						<td style="text-align: left"><%=currentRecord.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecord.getEndPalce()%></td>
						<td style="text-align: right"><%=currentRecord.getDistance()%></td>
						<td style="text-align: left"><%=currentRecord.getGpsWorkingOInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getJrmBriefInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedCount()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedDuration()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidAccelerationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidDecelarationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getContinuousDrivingCount()%></td>
						<td style="text-align: right"><%=currentRecord.getNightDrivingCount()%></td>
						<td colspan="1" style="text-align: left"><%=currentRecord.getRating()%></td>
						<td colspan="1" style="text-align: left"><%=currentRecord.getRemark()%></td>
			</tr>		
<%
			}
			}
			else{
				for(int counter=0; counter<numRecords;counter++){
					final TrainerSummaryForBothBriefDebrief currentRecord = dataForBoth.get(counter);
					int i= counter +1;
%>
			<tr>
						<td  style="text-align:right"><%=i%></td>
						<td colspan="3"  style="text-align:left"><%=currentRecord.getBriefingDate()%></td>
						<td colspan="3"  style="text-align:left"><%=currentRecord.getDebriefingDate()%></td>
						<td colspan="3"  style="text-align:left"><%=currentRecord.getBriefingTrainer()%></td>
						<td colspan="3"  style="text-align:left"><%=currentRecord.getDebriefingTrainer()%></td>
						<td style="text-align:left"><%=currentRecord.getVehicleRegistrationNumber()%></td>
						<td style="text-align:right"><%=currentRecord.getTripId()%></td>
						<td style="text-align:left"><%=currentRecord.getDriverName()%></td>
						<td style="text-align:right"><%=currentRecord.getDriverId()%></td>
						<td style="text-align:left"><%=currentRecord.getTransporter()%></td>
						<td style="text-align: left">Castrol</td>
						<td style="text-align: left"><%=currentRecord.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecord.getEndPalce()%></td>
						<td style="text-align: right"><%=currentRecord.getDistance()%></td>
						<td style="text-align: left"><%=currentRecord.getGpsWorkingOInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getJrmBriefInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedCount()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedDuration()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidAccelerationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidDecelarationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getContinuousDrivingCount()%></td>
						<td style="text-align: right"><%=currentRecord.getNightDrivingCount()%></td>
						<td colspan="1" style="text-align: left"><%=currentRecord.getRating()%></td>
						<td colspan="3" style="text-align:left"><%=currentRecord.getBriefingRemark()%></td>
						<td colspan="3" style="text-align:left"><%=currentRecord.getDebriefingRemark()%></td>	
						
			</tr>		
<%					
					i++;
				}
			}
			%>
			</table>
			
 <%
  }
}
catch(Exception e){
	e.printStackTrace();
}
%>

<%@ include file="footernew.jsp" %>
</body>
</html>