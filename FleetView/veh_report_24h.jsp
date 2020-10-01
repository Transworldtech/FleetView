
<%@ include file="headernew.jsp"%>


<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
	<script type="text/javascript">  
function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)
{  
	try{
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.veh24hrs.action ="excel.jsp";
          document.forms["veh24hrs"].submit();
	}
	catch(e){
		alert(e);
	}
 }  


//function openFeedback()
//{ 

//window.open("veh_report_ndfeedback.jsp",'jav','width=500,height=500,resizable=yes,scrollbars=yes');
//}






</script>  
<%
String vid="",sql="",sql1="",sql2="", transporter="", vehregno="";
String  showdate="",dateformat="";
Connection con ;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	 Statement st4=con.createStatement();
	 Statement st5=con.createStatement();
	 
	 dateformat=session.getAttribute("dateformat").toString();
	vid=request.getParameter("vid");
	
	java.util.Date todaysDate =new java.util.Date();
	String currentDateTime =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(todaysDate);
	
	long todaysDateMillis = todaysDate.getTime(); // todays date in millisecs
	long dayInMillis = 1000 * 60 * 60 *24; // 1 day in millisecs
	
	todaysDateMillis = todaysDateMillis - dayInMillis; // 24 hrs previous datetime from currentdatetime (in millisecs)
	todaysDate.setTime(todaysDateMillis);
	
	String twentyFourHoursPrevDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(todaysDate);
	//thedate2=thedate1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(NewDate);
	
	List<GetVehicleDetails> currRecord=null;
	int numRecords11 = 0;
	try {
		currRecord = vehicleDao.getVehicleDetails(vid);
		numRecords11 = currRecord.size();
	} catch (Exception e) {
		e.printStackTrace();
	}
	for (int counter = 0; counter < numRecords11; counter++)
	{
		vehregno=currRecord.get(counter).getVehicleRegistrationNumber();
		transporter=currRecord.get(counter).getOwnerNAme();
	}
	String  exportFileName=session.getAttribute("user").toString()+"_"+vehregno+"_last24hrs_report.xls";
%>
<form id="veh24hrs" name="veh24hrs" action="" method="post" >
<div id="mytable">
<table width="100%" align="center" class="stats">
	<tr>
		<td align="center">
		<!-- <div align="left"><font size="3">Report No: 1.6</font></div>-->
		<font size="3"><b>Last 24 Hours Report</b></font></td>
	</tr>
	<tr>
		<td>
		<div align="center"><font size="3"><b>Exception
		Report For <%=transporter%>, Vehicle <%=vehregno%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime))%>
		 to <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTime))%>
		 </b></font></div>
		<div align="right">&nbsp; &nbsp;<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
		<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
		
		<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('mytable');">    
 			<img src="images/print.jpg"  width="15px" height="15px" style="border-style: none"></img>
		</a>
 		<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('mytable', 'tableHTML');">
 			<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
 		</a>
 		  <%=Utilities.printDate()%>
		</div>
		</td>
	</tr>


<tr>

	
</table>
<table border="0" align="center" width="100%" class="stats">
	<tr>
		<td align="center"><font size="3"><b>Over Speed</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>From-Date-Time</b></th>
				<th><b>Speed</b></th>
				<th><b>Duration in Sec.</b></th>
				<th><b>Location - Click To View On Map.</b></th>
			</tr>
			<%
		
			
				List<OverSpeedDetailsData> currentRecord = null;
				int numRecords = 0;
				try {
					currentRecord = vehicleDao.getOverSpeedData(twentyFourHoursPrevDatetime, currentDateTime, vid);
					numRecords = currentRecord.size();
				} catch (Exception e) {
					e.printStackTrace();
				}
				 for (int counter = 0; counter < numRecords; counter++)
				 {
					 %>
			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format((new SimpleDateFormat("yyyy-MM-dd")).parse(currentRecord.get(counter).getFromDate())) %>
				<%=currentRecord.get(counter).getFromTime() %></div></td>
				<td align="right">
				<div align="right"><%=currentRecord.get(counter).getSpeed()%></div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord.get(counter).getDuration()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
							if(null!= currentRecord.get(counter).getLocation() && 
									!"null".equalsIgnoreCase(currentRecord.get(counter).getLocation()) &&
									null != currentRecord.get(counter).getLatitude()
									) 
							{
						String lat1=currentRecord.get(counter).getLatitude();
						String lon1=currentRecord.get(counter).getLongitude();
						String disc=currentRecord.get(counter).getLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
							} else if(null!= currentRecord.get(counter).getLocation() && 
									!"null".equalsIgnoreCase(currentRecord.get(counter).getLocation())){
								out.println(currentRecord.get(counter).getLocation());
							}
%>
				</div>
				</td>
			</tr>
			<%
						 }
						%>
		</table>

		</td>
	</tr>
	<tr>
		<td align="center"><font size="3"><b>Rapid
		Acceleration</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Location - Click To View On Map.</b></th>
			</tr>
			<%
						List<RapidAccelerationDetailsData> data = null;
						int numRecords1 = 0;
						try {
							data = vehicleDao.getRapidAccelerationDetailsData(vid, twentyFourHoursPrevDatetime, currentDateTime, "RapidAcceleration");
							numRecords1 = data.size();
						} catch (Exception e) {
							e.printStackTrace();
						}
						for (int counter = 0; counter < numRecords1; counter++)
						{
							final RapidAccelerationDetailsData currentRecord1 = data.get(counter);
							%>
			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord1.getDate()))%>
				<%=currentRecord1.getTime()%></div></td>
				<td align="right">
				<div align="right"><%=currentRecord1.getFromSpeed()%></div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord1.getToSpeed()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
	if (null != currentRecord1.getLocation()
					&& !"null".equalsIgnoreCase(currentRecord1
							.getLocation())
					&& null != currentRecord1.getLatitude()) {
						String lat1=currentRecord1.getLatitude();
						String lon1=currentRecord1.getLongitude();
						String disc=currentRecord1.getLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
 	} else if (null != currentRecord1.getLocation()
 					&& !"null".equalsIgnoreCase(currentRecord1
 							.getLocation())) {
 				out.println(currentRecord1.getLocation());
 			}
 %>
				</div>
				</td>
			</tr>
			<%
			 }
						%>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><font size="3"><b>Rapid
		Deceleration</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Date-Time</b></th>
				<th><b>From Speed</b></th>
				<th><b>To Speed</b></th>
				<th><b>Location - Click To View On Map.</b></th>
			</tr>
			<%
		
		List<RapidAccelerationDetailsData> data1 = null;
		int numRecords2 = 0;
		try {
			data1 = vehicleDao.getRapidAccelerationDetailsData(vid, twentyFourHoursPrevDatetime, currentDateTime, "RapidDecceleration");
			numRecords2 = data1.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords2; counter++)
		{
			final RapidAccelerationDetailsData currentRecord2 = data1.get(counter);
			%>
			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord2.getDate()))%> <%=currentRecord2.getTime()%></div></td>
				<td align="right">
				<div align="right"><%=currentRecord2.getFromSpeed()%></div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord2.getToSpeed()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
if (null != currentRecord2.getLocation()
	&& !"null".equalsIgnoreCase(currentRecord2
			.getLocation())
	&& null != currentRecord2.getLatitude()) {
						String lat1=currentRecord2.getLatitude();
						String lon1=currentRecord2.getLongitude();
						String disc=currentRecord2.getLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
} else if (null != currentRecord2.getLocation()
		&& !"null".equalsIgnoreCase(currentRecord2
				.getLocation())) {
	out.println(currentRecord2.getLocation());
}
%>
				</div>
				</td>
			</tr>
			<%
			 }
						%>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><font size="3"><b>Stops</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>Duration</b></th>
				<th><b>Location - Click To View On Map.</b></th>
			</tr>
			<%				
		List<ContinuousDrivingDetailsData> data3 = null;
		int numRecords3 = 0;
		try {
			data3 = vehicleDao.getContinuousDrivingDetailsData(
					vid, twentyFourHoursPrevDatetime, currentDateTime, "Stops");
			numRecords3 = data3.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords3; counter++) {
			final ContinuousDrivingDetailsData currentRecord3 = data3
					.get(counter);
		
		%>
			<tr>
				<td align="right"><div align="center"><%=counter+1 %></div></td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getStartDate()))%> <%=currentRecord3.getStartTime()%></div>
				</td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getEndDate()))%> <%=currentRecord3.getEndTime()%></div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord3.getDuration()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
					if (null != currentRecord3.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord3
											.getStartLocation())
									&& null != currentRecord3.getStartLocationLatitude()) {
						String lat1=currentRecord3.getStartLocationLatitude();
						String lon1=currentRecord3.getStartLocationLongitude();
						String disc=currentRecord3.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord3.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord3
											.getStartLocation())) {
								out.println(currentRecord3.getStartLocation());
							}
				%>
				</div>
				</td>
			</tr>
			<%		
		}
		%>
		</table>
		</td>
	</tr>
	
	
	<tr>
		<td align="center"><font size="3"><b>Night Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Trip ID</b></th>
				<th><b>Reason</b></th>
			</tr>
			
			
			<%
		    List<ContinuousDrivingDetailsData> data4 = null;
			int numRecords4 = 0;
			try {
				data4 = vehicleDao.getContinuousDrivingDetailsData(
						vid, twentyFourHoursPrevDatetime, currentDateTime, "NightDriving");
				numRecords4 = data4.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords4; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord4 = data4
				.get(counter);
%>

<%
String sd=currentRecord4.getStartDate();
String st=currentRecord4.getStartTime();


String ed=currentRecord4.getEndDate();
String et=currentRecord4.getEndTime();
%>


			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord4
															.getStartDate())) %> <%=currentRecord4.getStartTime()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
					if (null != currentRecord4.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getStartLocation())
									&& null != currentRecord4.getStartLocationLatitude()) {
						String lat1=currentRecord4.getStartLocationLatitude();
						String lon1=currentRecord4.getStartLocationLongitude();
						String disc=currentRecord4.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
                        
                             

<%
					} else if (null != currentRecord4.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getStartLocation())) {
								out.println(currentRecord4.getStartLocation());
							}
				%>
				</div>
				</td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord4
															.getEndDate())) %> <%=currentRecord4.getEndTime()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
					if (null != currentRecord4.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getEndLocation())
									&& null != currentRecord4.getEndLocationLatitude()) {
						String lat1=currentRecord4.getEndLocationLatitude();
						String lon1=currentRecord4.getEndLocationLongitude();
						String disc=currentRecord4.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord4.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getEndLocation())) {
								out.println(currentRecord4.getEndLocation());
							}
				%>
				</div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord4.getDistancetravelled()%></div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord4.getDuration()%></div>
				</td>
				
			
			
			
				<%
				String TripID="";
				String tripid="select JCode from db_gpsExceptions.t_veh"+vid+"_nd where concat(FromDate,' ',FromTime) between '"+currentRecord4.getStartDate()+" "+currentRecord4.getStartTime()+"' and  '"+currentRecord4.getEndDate()+" "+currentRecord4.getEndTime()+"'";
				ResultSet rs=st4.executeQuery(tripid);
				if(rs.next())
				{
					TripID=rs.getString("JCode");
					System.out.println("------------"+TripID);
				}
				
				%>
				
				<td align="right">
				<div align="right"><%=TripID%></div> 
			   </td>
			
			
			<td>
			<%
			String reason="";
			    try{
			   String sqlreason="select reason from db_gpsExceptions.t_ndpostintimation where VehRegNo='"+vehregno+"' and NdStartDateTime='"+sd+" "+st+"' and NdEndDateTime='"+ed+" "+et+"'";
			   ResultSet rsreason=st5.executeQuery(sqlreason);
			   if(rsreason.next())
			   {
				   reason=rsreason.getString("reason");
				   
			   }
			    }catch(Exception e)
			    {
			    	System.out.println(">>>>>>>>e:"+e);
			    }
			
			if(reason.equals("-") || reason.equals(""))
			{
				%>
			<%="<a href=\"veh_report_ndfeedback.jsp?vehregno="+vehregno+"&vid="+vid+"&tripid="+TripID+"&startdatetime="+sd+" "+st+"&enddatetime="+ed+" "+et+"\"onclick=\"popWin=window.open('veh_report_ndfeedback.jsp?vehregno="+vehregno+"&vid="+vid+"&tripid="+TripID+"&startdatetime="+sd+" "+st+"&enddatetime="+ed+" "+et+"','ND Reason','width=400,height=350');popWin.focus();return false\">Add Reason</a>"%>
			<%
			}
			else
			{
				if(reason.length()>10)
				{
					%>
					<%="<a href=\"veh_showreason.jsp?reason="+reason+"\"onclick=\"popWin=window.open('veh_showreason.jsp?reason="+reason+"','ND Reason','width=400,height=300');popWin.focus();return false\">Show Reason</a>"%>
				<%}
				else
				{
				%>
				<%=reason %>
			<%}} %>  
			</td>
			</tr>
			
			
			<%
			}
		    %>
		</table>
		</td>
	</tr>
	
	
	
	
	<tr>
		<td align="center"><font size="3"><b>Continuous
		Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
			</tr>
			<%
		    List<ContinuousDrivingDetailsData> data5 = null;
			int numRecords5 = 0;
			try {
				data5 = vehicleDao.getContinuousDrivingDetailsData(
						vid, twentyFourHoursPrevDatetime, currentDateTime, "ContinuousDriving");
				numRecords5 = data5.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords5; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord5 = data5
				.get(counter);
%>
			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getStartDate())) %> <%=currentRecord5.getStartTime()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
					if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())
									&& null != currentRecord5.getStartLocationLatitude()) {
						String lat1=currentRecord5.getStartLocationLatitude();
						String lon1=currentRecord5.getStartLocationLongitude();
						String disc=currentRecord5.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())) {
								out.println(currentRecord5.getStartLocation());
							}
				%>
				</div>
				</td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getEndDate())) %> <%=currentRecord5.getEndTime()%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
					if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())
									&& null != currentRecord5.getEndLocationLatitude()) {
						String lat1=currentRecord5.getEndLocationLatitude();
						String lon1=currentRecord5.getEndLocationLongitude();
						String disc=currentRecord5.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())) {
								out.println(currentRecord5.getEndLocation());
							}
				%>
				</div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord5.getDistancetravelled()%></div>
				</td>
				<td align="right">
				<div align="right"><%=currentRecord5.getDuration()%></div>
				</td>
			</tr>
			<%
			}
		    %>
		</table>
		</td>
	</tr>

</table>
</div>
</form>
<%
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		
	%>



<%@ include file="footernew.jsp"%>
