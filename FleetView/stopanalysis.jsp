<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.StopAnalysisData"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

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
		return true;
	}
	
	function birt(){
			
			//alert("Hi");
			
			//var date1= document.getElementById("date3").value;
			//alert(document.getElementById("data").value);
			//alert(document.getElementById("data1").value);
			var a=validate();
	//alert("GetValidate------->"+a);
	if(a==true)
		{
		
			var fromDateTime1= document.getElementById("data").value;
			
			//alert("datebefore"+fromDateTime);
			
			var newdate = fromDateTime1.split("-").reverse().join("-"); 
			var date = fromDateTime1.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++){
			    if(date[1]==months[j]){
			         date[1]=months.indexOf(months[j])+1;
			     }                      
			} 
			if(date[1]<10){
			    date[1]='0'+date[1];
			}                        
			var fromDateTime = date[2]+"-"+date[1]+"-"+date[0];
		//	alert("datebefore"+fromDateTime);
			
			//data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDateTime));
			//var fromDateTime= document.getElementById("datann").value;
			
			/* var fromDateTime= data; */
			//alert("dateafter----==>>"+fromDateTime);
			//var date2= document.getElementById("date4").value;
			var toDateTime1= document.getElementById("data1").value;
			//alert("dateafter--->"+toDateTime);
			var newdate1 = toDateTime1.split("-").reverse().join("-"); 
			var date1 = toDateTime1.split("-");
			var months1 = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months1.length;j++){
			    if(date1[1]==months1[j]){
			         date1[1]=months1.indexOf(months1[j])+1;
			     }                      
			} 
			if(date1[1]<10){
			    date1[1]='0'+date1[1];
			}                        
			var toDateTime = date1[2]+"-"+date1[1]+"-"+date1[0];
			//alert("date"+toDateTime);
			//var owner=document.getElementById("owner").value;
			//alert("own"+owner);
			//alert("all ok");
			var Vehno1=document.getElementById("vehicleCode").value;
			//alert(Vehno1);
			var Vehno11 = Vehno1.split("*");
			var Vehno=Vehno11[0];
			//alert(Vehno);
			var vehRegis=Vehno11[1];
			//alert(vehRegis);
			
		//	alert(vehicle);
			//alert(fromDateTime1);
			//alert(toDateTime1);
			//alert(owner);
		//	alert(location1);
		//	alert(routeid1);
		//	alert(status);
		//	alert(warehousecode1);
			
		//	alert(vehicle);
		//	alert(date1);
			//alert("http://myfleetview.com:8080/birttest/frameset?__report=stopanalysis.rptdesign&dt="+fromDateTime+"&dt1="+toDateTime+"&vehreg="+vehRegis+"&vehid="+Vehno+"&date="+fromDateTime1+"&date1="+toDateTime1+"&__showtitle=false");

			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=SensorDetailReport.rptdesign&vehicle="+vehicle+"&date1="+date1+"&date2="+date2+"&__showtitle=false";
			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=geofence_report.rptdesign&vehicle="+vehicle+"&fromDateTime="+fromDateTime+"&toDateTime="+toDateTime+"&owner="+owner+"&location1="+location1+"&status="+status+"&routeid1="+routeid1+"&warehousecode1="+warehousecode1+"&trans="+trans+"&sort="+sort+"&__showtitle=false";
//			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
			document.getElementById("myIframe").src="http://myfleetview.com:8080/birttest/frameset?__report=stopanalysis.rptdesign&dt="+fromDateTime1+"&dt1="+toDateTime1+"&vehreg="+vehRegis+"&vehid="+Vehno+"&date="+fromDateTime+"&date1="+toDateTime+"&__showtitle=false";
			//alert("sss1");
			document.getElementById("reportData").style.display="";
			//alert("ffff2");
			document.getElementById("footer").style.display="none";
			//alert("after frame");
			return true;
		}
	else
		{
		//alert("Flase");
			return false;
		}
		}
	
	function dateformat(days)
	{
		if(days=='Jan')
			return(1);
		else
			if(days=='Feb')
				return(2);
			else
				if(days=='Mar')
					return(3);
				else
					if(days=='Apr')
						return(4);
					else
						if(days=='May')
							return(5);
						else
							if(days=='Jun')
								return(6);
							else
								if(days=='Jul')
									return(7);
								else
									if(days=='Aug')
										return(8);
									else
										if(days=='Sep')
											return(9);
										else
											if(days=='Oct')
												return(10);
											else
												if(days=='Nov')
													return(11);
												else
													if(days=='Dec')
														return(12);
	}
	
	function datevalidate()
	{	//alert("IN Validation");
		var date1=document.getElementById("data").value;
		//alert("IN Validation data1");
		var date2=document.getElementById("data1").value;
		//alert("IN Validation data2");
		var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
		dy1=date1.substring(0,2);
		dy2=date2.substring(0,2);
		dm1=date1.substring(3,6);
		dm2=date2.substring(3,6);

		//alert("IN Validation 123");
		dm11=dateformat(dm1);
		//alert("IN Validation ssss");
		dm22=dateformat(dm2);	
		//alert("IN Validation dddd");
		dd1=date1.substring(7,11);
		//alert("IN Validation dd1");
		dd2=date2.substring(7,11);
		//alert("IN Validation dd2");
		//alert("IN Validation456");
		var date=new Date();
		var month=date.getMonth()+1;
		//var month1=date2.getMonth();
		var day=date.getDate();
		var year=date.getFullYear();
		
		//alert("dy1="+dy1+" dy2="+dy2+" dm1="+dm1+" dm2="+dm1+" dm11="+dm11+" dm22="+dm22+" dd1="+dd1+" dd2="+dd1+" month="+month+" day="+day+" year="+year);
		
		
		if(dd1>dd2)
		{  
			
			
			
			alert("From date should not be greater than to date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
			
		}
		
		else if(year==dd1 && year==dd2) 
			if(dm11>dm22)
		{
			
			alert("From date should not be greater than to date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
		if(dd1==dd2){
			if(dm11>dm22)
			{
							alert("From date should not be greater than to date");
							//document.getElementById("data").value="";
							//document.getElementById("data1").value="";
							document.getElementById("data").focus;
							return false;
			}
			}
		
		 if(dm1==dm2 && dd1==dd2) {
		if(dy1 > dy2)
		{
			alert("From date should not be greater than to date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
		}
		return true;
	}  		
</script>

<%! /// Only Class Level Declarations here
	final NumberFormat numberformat = new DecimalFormat("#0.00");
	final SimpleDateFormat yyyy_MM_ddFormatter  = new SimpleDateFormat("yyyy-MM-dd");
	final SimpleDateFormat dd_MMM_yyyyParser = new SimpleDateFormat("dd-MMM-yyyy");
%>

<%	
	final StringBuffer vehicleCodeBuffer = new StringBuffer(); 
	final StringBuffer fromDateBuffer = new StringBuffer(); 
	final StringBuffer toDateBuffer= new StringBuffer();
	final StringBuffer fromDateCalendarBuffer = new StringBuffer();
	final StringBuffer toDateCalendarBuffer = new StringBuffer();
	final StringBuffer fromDateHumanBuffer = new StringBuffer();
	final StringBuffer toDateHumanBuffer = new StringBuffer();	

	final boolean isShowDistanceInMiles =  "ML".equalsIgnoreCase(session.getAttribute("distformat").toString());
	final String dateformatSession = session.getAttribute("dateformat").toString();
	double totalRunningTimeInSeconds=0,totalNightStopInSeconds=0,totalDayStopInSeconds=0;
	final StringBuffer dateFormatBuffer = new StringBuffer();	
	if(null == dateformatSession) {
		dateFormatBuffer.append("dd-MMM-yyyy");
	} else {
		dateFormatBuffer.append(dateformatSession);
	}
	final SimpleDateFormat userPreferredDateFormat = new SimpleDateFormat(dateFormatBuffer.toString());
	final String fromDateRequest = request.getParameter("data");
	final String toDateRequest = request.getParameter("data1");
	
	final boolean isRequestQueryStringEmpty = (null == request.getQueryString());
	boolean showDataTable = false;
	if(isRequestQueryStringEmpty)  {
		vehicleCodeBuffer.append("All");

		final java.util.Date now = new java.util.Date();
		final String calendarCurrentDate = dd_MMM_yyyyParser.format(now);
		
		fromDateCalendarBuffer.append(calendarCurrentDate);
		toDateCalendarBuffer.append(calendarCurrentDate);
		
		fromDateBuffer.append(yyyy_MM_ddFormatter.format(now));
		toDateBuffer.append(yyyy_MM_ddFormatter.format(now));
		
		fromDateHumanBuffer.append(userPreferredDateFormat.format(now));
		toDateHumanBuffer.append(userPreferredDateFormat.format(now));		
	} else {
		showDataTable = true;
		vehicleCodeBuffer.append(request.getParameter("vehicleCode"));
		
		fromDateCalendarBuffer.append(fromDateRequest);
		toDateCalendarBuffer.append(toDateRequest);
		
		fromDateBuffer.append(yyyy_MM_ddFormatter.format(dd_MMM_yyyyParser.parse(fromDateRequest)));
		toDateBuffer.append(yyyy_MM_ddFormatter.format(dd_MMM_yyyyParser.parse(toDateRequest)));
		
		fromDateHumanBuffer.append(userPreferredDateFormat.format(dd_MMM_yyyyParser.parse(fromDateRequest)));
		toDateHumanBuffer.append(userPreferredDateFormat.format(dd_MMM_yyyyParser.parse(toDateRequest)));		
	}
	
	final String vehicleCode = vehicleCodeBuffer.toString();
	final String fromDate = fromDateBuffer.toString();  /// For Database
	final String toDate = toDateBuffer.toString();      /// For Database
	final String fromDateCalendar=fromDateCalendarBuffer.toString();
	final String toDateCalendar = toDateCalendarBuffer.toString();
	final String fromDateHuman = fromDateHumanBuffer.toString();
	final String toDateHuman = toDateHumanBuffer.toString();
	int[] totalRunningDuration = new int[3];
	int[] totalDayStopDuration = new int[3];
	int[] totalNightStopDuration = new int[3];
	double averageDaySpeed=0;
	int totalDays=0;
	
	double totalDistanceTravelled=0,totalAverageRunningspeed=0,totalAverageDaySpeed=0;
	try {
%>
<!-- <form action="" method="get" onsubmit="return validate();"> -->
<table width="100%" align="center" class="sortable_entry">
	<tr>
		<td class="sorttable_nosort">		
		<table border="0" width="90%">
			<tr bgcolor="#87CEFA">
				<td><b>Vehicle :</b> <select name="vehicleCode"	id="vehicleCode">
<%
		List<VehicleRegistrationNumberList> data = null;
		int numRecords = 0;
		try {
			data = vehicleDao.getVehicleRegistrationNumberList(
					session.getAttribute("VehList").toString());
			numRecords = data.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String vehicleRegistrationNumberOfSelectedVehicle = "";
		for (int counter = 0; counter < numRecords; counter++) {
			final VehicleRegistrationNumberList currentRecord = data.get(counter);		
			final String displayValue = currentRecord.getVehicleRegistrationNumber();
			final String internalId = currentRecord.getVehicleCode();
			String isSelected = "";
			if (vehicleCode.equals(internalId)) {
				isSelected = "Selected";
				vehicleRegistrationNumberOfSelectedVehicle = displayValue;
			}
%>
					<option value="<%=internalId%>*<%=displayValue%>" <%=isSelected%>><%=displayValue%></option>
					<%-- <input type="hidden" id="VehReg" name="VehReg" value="<%=vehicleRegistrationNumberOfSelectedVehicle%>"></input> --%>
<%
		}
%>
				</select></td>
				
				<td align="right"><b>From&nbsp;&nbsp;</b> <input type="text"
					id="data" name="data" value="<%=fromDateCalendar%>" size="15" readonly />
				<script type="text/javascript">
  				Calendar.setup({
	      			inputField  : "data",         // ID of the input field
	      			ifFormat    : "%d-%b-%Y",     // the date format
	      			button      : "data"       // ID of the button
    			});	
				</script></td>
				<td align="right"><b>To&nbsp;&nbsp;</b> <input type="text"
					id="data1" name="data1" value="<%=toDateCalendar%>" size="15" readonly />

				<script type="text/javascript">
  				Calendar.setup({
	      			inputField  : "data1",         // ID of the input field
	      			ifFormat    : "%d-%b-%Y",    // the date format
	      			button      : "data1"       // ID of the button
    			});
				</script></td>
				<!-- <td><input type="submit" name="submit" id="submit"
					value="submit"></td> -->
			<td>
				<input type="submit" name="submit" id="submit" onclick="birt();" value="submit" >
			</td>
			</tr>
		</table>	
		
	

		</td>
	</tr>
</table>

<div id="reportData" >
<iframe id="myIframe" width="100%" height="850px" src=""> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> -->
</iframe> 


 
<!-- </form> -->
<br></br>
<%-- <%
		if (showDataTable) {
			final String distanceTravelledColumnHeader = (isShowDistanceInMiles) ? "Miles Travelled" : "Km Travelled";
			List<StopAnalysisData> stopAnalysisData = null;
			numRecords = 0;
			try {
				stopAnalysisData = vehicleDao.getStopAnalysisData(vehicleCode,fromDate, toDate);
				numRecords = stopAnalysisData.size();
			} catch (Exception e) {
				e.printStackTrace();
			}			
%> --%>
<%-- <table width="100%" border="1" align="center" class="sortable">
	<tr>
		<td class="sorttable_nosort">
		<div id="report_heding"><font size="3"><b>The
		Run Analysis Report for <%
			if (vehicleCode.equals("All")) {
		%>All Vehicles <%
			} else {
				out.print("Vehicle " + vehicleRegistrationNumberOfSelectedVehicle);
			}
		%> from <%=fromDateHuman%> to <%=toDateHuman%></b></font></div>
		<div align="right"><a href="#"
			onclick="javascript:window.open('printstopanalysis.jsp?vehicle=<%=vehicleRegistrationNumberOfSelectedVehicle%>&data=<%=fromDate%>&data1=<%=toDate%>');"
			title="Print Report"><img src="images/print.jpg" width="15px"
			height="15px"></a>&nbsp; &nbsp; <a
			href="excelstopanalysis.jsp?vehicle=<%=vehicleRegistrationNumberOfSelectedVehicle%>&data=<%=fromDate%>&data1=<%=toDate%>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a> <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm")
									.format(new java.util.Date())%></div>
		</td>
	</tr>
</table> --%>
<%-- <table width="100%" border="1" align="center" class="sortable">
	<tr>
		<th class="hed">Sr.</th>
		<th class="hed">Date</th>
		<th class="hed">Running Time</th>
		<th class="hed">Night Stop Time</th>
		<th class="hed">Day Stops Time</th>
		<th class="hed"><%=distanceTravelledColumnHeader%></th>
		<th class="hed">Avg. Running Speed<br>(Km/hr)</th>
		<th class="hed">Avg. Speed<br>(Km/hr)</th>
	</tr>
<%		try{
			for (int counter = 0; counter < numRecords; counter++) {
				final StopAnalysisData currentRecord = stopAnalysisData.get(counter);
				String currentRecordDate = "";
				try{
					currentRecordDate = userPreferredDateFormat.format(yyyy_MM_ddFormatter.parse(currentRecord.getDate()));
				} catch(Exception e){
					currentRecordDate = "";
				}
				final String runTimeInMinutes = currentRecord.getRunTimeInMinutes();
				final String nightStopInMinutes = currentRecord.getNightStopTimeInMinutes();
				final String dayStopInMinutes = currentRecord.getDayStopTimeInMinutes();
				
				totalRunningTimeInSeconds += Double.parseDouble(runTimeInMinutes);
				totalNightStopInSeconds += Double.parseDouble(nightStopInMinutes);
				totalDayStopInSeconds += Double.parseDouble(dayStopInMinutes);
%>
	<tr>
		<td style="text-align: right"><%=counter+1%></td>
		
		<td style="text-align: right"><a href="#" onClick="window.open('detail_custom_report.jsp?vehcode=<%=vehicleCode%>&ss1=<%=runTimeInMinutes%>&ss2=<%=nightStopInMinutes%>&ss3=<%=dayStopInMinutes%>&vehreg=<%=vehicleRegistrationNumberOfSelectedVehicle%>&dd=<%=currentRecord.getDate()%>&fromPage=runAnalysis','win1','width=900,height=900,location=0,menubar=0,scrollbars=1,status=0,toolbar=0,resizable=0')"><%=currentRecordDate%></a></td>
		<td><div align="right"><%=currentRecord.getRunningDuration()%></div></td>
<%
				StringTokenizer tokenizerForRunningDuration= new StringTokenizer(currentRecord.getRunningDuration(),":");
				if(tokenizerForRunningDuration.hasMoreTokens()){
					try{
						totalRunningDuration[0] += Integer.parseInt(tokenizerForRunningDuration.nextToken());
						totalRunningDuration[1] +=  Integer.parseInt(tokenizerForRunningDuration.nextToken());
						totalRunningDuration[2] +=  Integer.parseInt(tokenizerForRunningDuration.nextToken());
						if(totalRunningDuration[0] > 60)
						{
							totalRunningDuration[0] = totalRunningDuration[0] % 60;
							totalRunningDuration[1]++;
						}
						if(totalRunningDuration[1] > 60)
						{
							totalRunningDuration[1] = totalRunningDuration[1] % 60;
							totalRunningDuration[2]++;
						}
					} catch(Exception e){
						/// Ignore
					}
				}					
%>
		<td><div align="right"><%=currentRecord.getNightStopDuration()%></div></td>
		<%
				StringTokenizer tokenizerForNightStopDuration = new StringTokenizer(currentRecord.getNightStopDuration(),":");
				if(tokenizerForNightStopDuration.hasMoreTokens()){
					try{
						totalNightStopDuration[0] += Integer.parseInt(tokenizerForNightStopDuration.nextToken());
						totalNightStopDuration[1] +=  Integer.parseInt(tokenizerForNightStopDuration.nextToken());
						totalNightStopDuration[2] +=  Integer.parseInt(tokenizerForNightStopDuration.nextToken());
						if(totalNightStopDuration[0] > 60)
						{
							totalNightStopDuration[0] = totalNightStopDuration[0] % 60;
							totalNightStopDuration[1]++;
						}
						if(totalNightStopDuration[1] > 60)
						{
							totalNightStopDuration[1] = totalNightStopDuration[1] % 60;
							totalNightStopDuration[2]++;
						}
					} catch(Exception e){
						/// Ignore
					}
				}					
%>
		<td><div align="right"><%=currentRecord.getDayStopsDuration()%></div></td>	
		<%
				StringTokenizer tokenizerForDayStopDuration = new StringTokenizer(currentRecord.getDayStopsDuration(),":");
				if(tokenizerForDayStopDuration.hasMoreTokens()){
					try{
						totalDayStopDuration[0] += Integer.parseInt(tokenizerForDayStopDuration.nextToken());
						totalDayStopDuration[1] +=  Integer.parseInt(tokenizerForDayStopDuration.nextToken());
						totalDayStopDuration[2] +=  Integer.parseInt(tokenizerForDayStopDuration.nextToken());
						if(totalDayStopDuration[0] > 60)
						{
							totalDayStopDuration[0] = totalDayStopDuration[0] % 60;
							totalDayStopDuration[1]++;
						}
						if(totalDayStopDuration[1] > 60)
						{
							totalDayStopDuration[1] = totalDayStopDuration[1] % 60;
							totalDayStopDuration[2]++;
						}
					} catch(Exception e){
						/// Ignore
					}
				}					

				double distanceTravelled = 0;
				try
				{
					distanceTravelled = Double.parseDouble(currentRecord.getDistanceTravelled());
				}
				
				catch(Exception e)
				{
					distanceTravelled = 0;
				}
				
				if (isShowDistanceInMiles) 
				{
 					distanceTravelled = distanceTravelled/1.609344;
				}
				totalDistanceTravelled += distanceTravelled;
%>
		<td><div align="right"><%=numberformat.format(distanceTravelled)%></div></td>
<%
				double averageDaySpeedForCurrentRecord = 0;
				if (null != currentRecord.getRunningDuration()
						|| !currentRecord.getRunningDuration().startsWith("0")) {
					try{
						averageDaySpeedForCurrentRecord = Double.parseDouble(currentRecord.getDistanceTravelled())
									/ 24;
					}catch(Exception e){
						averageDaySpeedForCurrentRecord = 0;
					}
				}
%>
		<td><div align="right"><%=numberformat.format(Double.parseDouble(currentRecord.getRunningAverage()))%></div></td>
		<td><div align="right"><%=numberformat.format(averageDaySpeedForCurrentRecord)%></div></td>
<%
			totalAverageRunningspeed+=Double.parseDouble(currentRecord.getRunningAverage());
			totalAverageDaySpeed+= averageDaySpeedForCurrentRecord;
%>		
	</tr>
<%	
		totalDays++;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>
		
		
		
			<tr class="sortbottom"> 
				<td  class="hed"><div align="right"><b>Total :</b></div></td>
				<td  class="hed"><div align="right"><b> <%=totalDays%> Days</b></div></td>
				<td  class="hed"><div align="right"><b> <%=totalRunningDuration[0]%>:<%=totalRunningDuration[1]%>:<%=totalRunningDuration[2]%> </b></div></td>				
				<td  class="hed"><div align="right"><b><%=totalNightStopDuration[0]%>:<%=totalNightStopDuration[1]%>:<%=totalNightStopDuration[2]%></b></div></td>				
				<td  class="hed"><div align="right"><b><%=totalDayStopDuration[0]%>:<%=totalDayStopDuration[1]%>:<%=totalDayStopDuration[2]%></b></div></td>				
				<td  class="hed"><div align="right">
<%
				if (isShowDistanceInMiles) 
				{
 					totalDistanceTravelled = totalDistanceTravelled/1.609344;
				}
%>
				<b> <%=numberformat.format(totalDistanceTravelled)%> </b>
				<% %>	
				</div></td>		
				<td class="hed"><div align="right"><b><%=numberformat.format(totalAverageRunningspeed/totalDays)%></b></div></td>				
				<td class="hed"><div align="right"><b><%=numberformat.format(totalAverageDaySpeed/totalDays)%></b></div></td>					
			</tr>
				 	
</table>  --%>
                                   
<%                                          
		//}                                    
	} 
	catch (Exception e) 
	{
		out.print("Exceptions--->" + e);
	}
%>
<%@ include file="footernew.jsp"%>
