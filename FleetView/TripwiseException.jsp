<%@ include file="headernew.jsp"%>

<%  System.out.println("Above Spring");%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
		import="com.transworld.fleetview.framework.GetTripDetails"
	
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
	
<%  System.out.println("Below Spring");%>

<%@page import="java.util.Date"%><html>
<head>

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
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;
    
    document.tripwise.action ="excel.jsp";
    document.forms["tripwise"].submit();
} 





</script>



</head>

<body>


<%

String vid="", sql="",sql1="",sql2="",runhr="", transporter="", vehregno="", thedate1="", thedate2="";
String showdate="",dateformat="";
Connection con ;
int ab=0;

%>

<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	Statement st4=con.createStatement();
	 Statement st5=con.createStatement();
	 Statement st41=con.createStatement();
	 Statement st42=con.createStatement();
	
	//dateformat = session.getAttribute("dateformat").toString();
	if(dateformat == null || dateformat.equalsIgnoreCase("null"))
	{
		sql = "select * from db_gps.t_defaultvals where ownername = 'Castrol' ";
		ResultSet rsdefault = st4.executeQuery(sql);
		if(rsdefault.next())
		{
		//	session.setAttribute("dateformat",rsdefault.getString("DateFormat"));
			dateformat = rsdefault.getString("DateFormat");
		}
		
	}
	//vid=request.getParameter("vid");
	java.util.Date NewDate= new java.util.Date();
	long dateMillis= NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	//thedate2=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	dayInMillis = 6000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	//thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	String trans=request.getParameter("trans");
	final String tripID, vehicleID;
	tripID = request.getParameter("tripid");
	final String startDate=request.getParameter("startDate").toString();
	final String endDate=request.getParameter("endDate").toString();
	vid=request.getParameter("vehcode");
	
	List<GetTripDetails> tripDetailsData = null;
	try {
		tripDetailsData = vehicleDao.getTripDetails(tripID);
	} catch (Exception e) {
		e.printStackTrace();
	}
	vehicleID=tripDetailsData.get(0).getVehicleCode();
	
	
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
		System.out.println("Transporter-"+transporter);
	}

%>
<%	   String exportFileName=trans.toString()+"_TripwiseExceptionReport.xls";
%>
<form id="tripwise" name="tripwise" action="" method="post">

    <table border="0" cellpadding="0" width="100%" align="center" class="stats">
		<tr>
		<td>
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=Utilities.printDate()%>
                           </div>
		</td>
		</tr>
		</table>
 <div id="table1">
<table width="100%" align="center" class="stats" >
			
			<tr>
			<td>
			<div align="center"><font face="Arial" size="3"><b>
Exception Report for the Trip :-<%=tripID%>,From <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startDate))%> To <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate))%> 
					
					</b></font></div>
									
			</td>
			</tr>
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
								<th><b>Zone</b></th>
								<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
				
			</tr>
			
			<%
		
			try{
				int os=1;
				String bgcolor="",zonecolor="",fromdate="",zoneval="";;
		//	String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vehicleID+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vehicleID+"  WHERE  TheFiledTextFileName= 'OS' GROUP BY TheFieldDataDate, TheFieldDataTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(FromDate,' ',FromTime) >='"+startDate+"' and concat(FromDate,' ',FromTime) <='"+endDate+"' ORDER BY concat(os.FromDate,os.FromTime)";
			String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vehicleID+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vehicleID+"  WHERE  TheFiledTextFileName= 'OS' and TheFieldDataDateTime >= '"+startDate+"' and TheFieldDataDateTime <= '"+endDate+"' GROUP BY TheFieldDataDateTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(os.FromDate,' ',os.FromTime) >='"+startDate+"' and concat(os.FromDate,' ',os.FromTime) <='"+endDate+"' ORDER BY concat(os.FromDate,os.FromTime)";
			System.out.println("Join query is"+sqloscalc);
			ResultSet rsoscalc=st4.executeQuery(sqloscalc);
			while(rsoscalc.next())
			{
				%>
				<tr>
				<%
				fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsoscalc.getString("FromDate")));
				
				zonecolor=rsoscalc.getString("Zone");
				if(zonecolor.equalsIgnoreCase("Red") || zonecolor=="Red")
				{
					bgcolor="background-color:#FC545F";
					zoneval="R";
				}
				else if(zonecolor.equalsIgnoreCase("Green") || zonecolor=="Green")
				{
					bgcolor="background-color:#B3FAB3";
					zoneval="G";

				}
				else if(zonecolor.equalsIgnoreCase("Yellow") || zonecolor=="Yellow")
				{
					bgcolor="background-color:#FDFD82";
					zoneval="Y";

				}
				else{
					bgcolor="background-color:#FFFFFF";
					zoneval="0";

					
				}
					 %>
			
			
			            <td style="text-align:right;<%=bgcolor%>"><%=os%></td>
						<td style="text-align:right;<%=bgcolor%>"><%=fromdate%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rsoscalc.getString("FromTime"))) %></td>
						<td style="text-align:right;<%=bgcolor%>"><%=rsoscalc.getString("Speed")%></td>
						<td style="text-align:right;<%=bgcolor%>"><%=rsoscalc.getString("Duration")%></td>
						<td style="text-align:left;<%=bgcolor%>">
						<%
						
						if(null!= rsoscalc.getString("TheFieldSubject") && !"null".equalsIgnoreCase(rsoscalc.getString("TheFieldSubject"))) 
						{
						
						%>
						<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=rsoscalc.getString("LatinDec")%>&long=<%=rsoscalc.getString("LonginDec")%>&discription=<%=rsoscalc.getString("TheFieldSubject")%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=os%>,false);">
		
					<%=rsoscalc.getString("TheFieldSubject")%></a>
					
					<%}else{ %>
						<%="NA" %>
						<%} %>
						</td>
			
			<td style="text-align:left;<%=bgcolor%>">
						<%=zoneval%></td>
						<%
			String sqlostodate="select DATE_ADD('"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"', INTERVAL '"+rsoscalc.getString("Duration")+"' second) datetim";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"' and snapdatetime<=DATE_ADD('"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"', INTERVAL '"+rsoscalc.getString("Duration")+"' second)  and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;<%=bgcolor%>"><a href="CameraImageReport.jsp?data=<%=rsoscalc.getString("FromDate") %> <%=rsoscalc.getString("FromTime") %>&data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{%>
			<td style="text-align:right;<%=bgcolor%>">0</a></td>
			<%}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"' and snapdatetime<=DATE_ADD('"+rsoscalc.getString("FromDate")+" "+rsoscalc.getString("FromTime")+"', INTERVAL '"+rsoscalc.getString("Duration")+"' second) and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;<%=bgcolor%>"><a href="CameraImageReport.jsp?data=<%=rsoscalc.getString("FromDate") %> <%=rsoscalc.getString("FromTime") %>&data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{%>
			<td style="text-align:right;<%=bgcolor%>">0</a></td>
			<%}
			}
			
			%>
			</tr>
			
			<%
			os++;
			}}catch(Exception e)
			{
				e.printStackTrace();
				
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
				<th><b>Cabin Images</b></th>
						<th><b>Road Images</b></th>
			</tr>
			<%try{
						List<RapidAccelerationDetailsData> data = null;
						int numRecords1 = 0;
						try {
							data = vehicleDao.getRapidAccelerationDetailsData(vehicleID,startDate, endDate, "RapidAcceleration");
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
				<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord1.getDate()))%><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord1.getTime()))%></div></td>
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
				<%
			String sqlostodate="select DATE_ADD('"+currentRecord1.getDate()+" "+currentRecord1.getTime()+"', INTERVAL 2 second) datetim,DATE_SUB('"+currentRecord1.getDate()+" "+currentRecord1.getTime()+"', INTERVAL 2 second) datetim1";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
			 }}catch(Exception e)
			 {
				 e.printStackTrace();
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
				<th><b>Cabin Images</b></th>
						<th><b>Road Images</b></th>
			</tr>
			<%
		try{
		List<RapidAccelerationDetailsData> data1 = null;
		int numRecords2 = 0;
		try {
			data1 = vehicleDao.getRapidAccelerationDetailsData(vehicleID,startDate, endDate, "RapidDecceleration");
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
				<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(currentRecord2.getDate()))%><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord2.getTime()))%></div></td>
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
				<%
			String sqlostodate="select DATE_ADD('"+currentRecord2.getDate()+" "+currentRecord2.getTime()+"', INTERVAL 2 second) datetim,DATE_SUB('"+currentRecord2.getDate()+" "+currentRecord2.getTime()+"', INTERVAL 2 second) datetim1";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim1") %> &data1=<%=rsostodate.getString("datetim") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
			 }}catch(Exception e)
			 {
				 e.printStackTrace();
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
			try{
		List<ContinuousDrivingDetailsData> data3 = null;
		int numRecords3 = 0;
		try {
			data3 = vehicleDao.getContinuousDrivingDetailsData(
					vehicleID,startDate, endDate, "Stops");
			numRecords3 = data3.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords3; counter++) {
			final ContinuousDrivingDetailsData currentRecord3 = data3
					.get(counter);
		
		%>
			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getStartDate()))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord3.getStartTime()))%></div>
				</td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getEndDate()))%> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord3.getEndTime()))%></div>
				</td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord3.getDuration()))%></div>
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
		}}catch(Exception e)
		 {
			 e.printStackTrace();
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
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
			</tr>
			<%
			try{
		    List<ContinuousDrivingDetailsData> data4 = null;
			int numRecords4 = 0;
			try {
				data4 = vehicleDao.getContinuousDrivingDetailsData(
						vehicleID,startDate, endDate, "NightDriving");
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
															.getStartDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord4.getStartTime()))%></div>
				</td>
				<td align="left">
				<div align="left">
				<%
				System.out.println("ND LOCATION="+currentRecord4.getStartLocation());
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
															.getEndDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord4.getEndTime()))%></div>
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
			
			try{
				
				String tripid="select JCode from db_gpsExceptions.t_veh"+vid+"_nd where concat(FromDate,' ',FromTime) between '"+currentRecord4.getStartDate()+" "+currentRecord4.getStartTime()+"' and  '"+currentRecord4.getEndDate()+" "+currentRecord4.getEndTime()+"'";
				ResultSet rs=st4.executeQuery(tripid);
				if(rs.next())
				{
					TripID=rs.getString("JCode");
					System.out.println("------------"+TripID);
				}
			}catch(Exception e)
			{
				e.printStackTrace();
			}
				if(TripID=="" || TripID.equals("null"))
				{
					TripID="NA";
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
			<%
			String sqlostodate="select concat('"+currentRecord4.getStartDate()+"',' ','"+currentRecord4.getStartTime()+"') datetim,concat('"+currentRecord4.getEndDate()+"',' ','"+currentRecord4.getEndTime()+"') datetim1";
			//out.println("Join query is"+sqloscount);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqloscount);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+currentRecord4.getStartDate()+" "+currentRecord4.getStartTime()+"' and snapdatetime<='"+currentRecord4.getEndDate()+" "+currentRecord4.getEndTime()+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim")+"' and snapdatetime<='"+rsostodate.getString("datetim1")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
			}}catch(Exception e)
			 {
				 e.printStackTrace();
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
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
			</tr>
			<%
			try{
		    List<ContinuousDrivingDetailsData> data5 = null;
			int numRecords5 = 0;
			try {
				data5 = vehicleDao.getContinuousDrivingDetailsData(
						vehicleID,startDate, endDate, "ContinuousDriving");
				numRecords5 = data5.size();
				//final ContinuousDrivingDetailsData currentRecord51 = data5.get(numRecords5);
				//String ddddd=currentRecord51.getEndDate()+" "+currentRecord51.getEndTime();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords5; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord5 = data5.get(counter);
				String ddddd=currentRecord5.getEndDate()+" "+currentRecord5.getEndTime();
				System.out.println("ddddd---->"+ddddd);
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
				Date EndDatetime1 = df.parse(ddddd);
				Date Enddate11=df.parse(endDate);
				
				if(EndDatetime1.before(Enddate11)){
				
%>
			<tr>
				<td align="right"><div align="right"><%=counter+1 %></div></td>
				<td align="right">
				<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getStartDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord5.getStartTime()))%></div>
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
															.getEndDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord5.getEndTime()))%></div>
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
				<%
			String sqlostodate="select concat('"+currentRecord5.getStartDate()+"',' ','"+currentRecord5.getStartTime()+"') datetim,concat('"+currentRecord5.getEndDate()+"',' ','"+currentRecord5.getEndTime()+"') datetim1";
			//out.println("Join query is"+sqlostodate);
			ResultSet rsostodate=st42.executeQuery(sqlostodate);
			//out.println("After Result is"+sqlostodate);
			if(rsostodate.next()){
			String sqloscount="select count(*) count,category from db_gps.t_jpgsnap where category='Cabin' and vehid="+vid+" and snapdatetime>='"+currentRecord5.getStartDate()+" "+currentRecord5.getStartTime()+"' and snapdatetime<='"+currentRecord5.getEndDate()+" "+currentRecord5.getEndTime()+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount=st41.executeQuery(sqloscount);
			//out.println("After Result is"+sqloscount);
			if(rsoscount.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount.getString("category")%>&type=Exception" target="_blank"><%=rsoscount.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim")+"' and snapdatetime<='"+rsostodate.getString("datetim1")+"' and type='Exception' group by category";
			//out.println("Join query is"+sqloscount);
			ResultSet rsoscount1=st41.executeQuery(sqloscount1);
			//out.println("After Result is"+sqloscount1);
			if(rsoscount1.next())
			{//out.println("inside===> "+rsoscount.getString("count"));
			ab=0;
				%>
				<td style="text-align:right;"><a href="CameraImageReport.jsp?data=<%=rsostodate.getString("datetim") %> &data1=<%=rsostodate.getString("datetim1") %>&VehNo1=<%= vehregno%>&category=<%=rsoscount1.getString("category")%>&type=Exception" target="_blank"><%=rsoscount1.getString("count")%></a></td>
				<%
			}else{
				%>
				<td style="text-align:right;">0</td>
				<%
			}
			}
			
			%>
			</tr>
			<%
				}}}catch(Exception e)
			 {
				 e.printStackTrace();
			 }
		    %>
		</table>
		</td>
	</tr>
		
				
		<tr>
		<td align="center"><font size="3"><b>Disconnection </b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Off TimeFrom</b></th>
				<th><b>From Location</b></th>
				<th><b>Off TimeTo</b></th>
				<th><b>To Location</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>TripID</b></th>
			</tr>
			
	
	<%
	try{
				String sqlDic="";
				String datedicvio="",datedicvios="",tripids="";

				double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;

	            int k=1;
				sqlDic="select TripId,OffTimeFrom,FromLocation,FromLatitude,FromLongitude,OffTimeTo,ToLocation,ToLatitude,ToLongitude,Distance,CAST(duration AS CHAR) as duration from db_gps.t_disconnectionData where vehicleCode='"+vehicleID+"' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30' and OffTimeFrom between '"+startDate+"' and  '"+endDate+"'";
				ResultSet rsdic=st4.executeQuery(sqlDic);
				while(rsdic.next())
				{
					%>
					
					<tr>
					<%
					fromLatitude = rsdic.getDouble("FromLatitude");
					fromLongitude = rsdic.getDouble("FromLongitude");
					toLatitude = rsdic.getDouble("ToLatitude");
					toLongitude = rsdic.getDouble("ToLongitude");
					
					datedicvio=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdic.getString("OffTimeFrom")));
					datedicvios=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsdic.getString("OffTimeTo")));
	                tripids=rsdic.getString("TripId");
					
					if(tripids.equals(""))
					{
						tripids="-";
					}
					
					%>
					<td style=" text-align: right"><%=k%></td>
					<td style=" text-align: right"><%=datedicvio%></td>
					
					<td style=" text-align: left">
					
					
					<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=fromLatitude%>&long=<%=fromLongitude%>&discription=<%=rsdic.getString("FromLocation") %>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=k%>,false);">
	
					
					<%=rsdic.getString("FromLocation") %>	</a>
					
					
					
					</td>
					
					<td style=" text-align: right"><%=datedicvios%></td>
					
					<td style=" text-align: left">
				
					<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=toLatitude%>&long=<%=toLongitude%>&discription=<%=rsdic.getString("ToLocation") %>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=k%>,false);">
		
					<%=rsdic.getString("ToLocation") %></a>
					</td>
					<td style=" text-align: left"><%=rsdic.getString("Distance")%></td>
					
					<td style=" text-align: right"><%=rsdic.getString("Duration")%></td>
					<td style=" text-align: right"><%=tripids%></td>
					
					
				</tr>
					
					
					<%
					
					k++;
					
				}
	}catch(Exception e)
	{
		e.printStackTrace();
	}
				%>
	
	
	</table>
	</td></tr>
	
	
	<tr>
		<td align="center"><font size="3"><b>Run Hour Violation </b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
                <th><b> Sr. </b></th>
				<th><b>Date</b></th>
				<th><b>Location</b></th>
				<th><b>Distance</b></th>
				<th><b>RDuration</b></th>
	</tr>
	<%
	String thedate11="",thedate12="";
	thedate11=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startDate));
	thedate12=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endDate));
	
	
	
	
	try{
		int km=1;
		String sqlrun="",daterhr="";
		String locdateremve="",newdate="",Distancenew="",rdurnew="";
		double latit=0.00,longit=0.00;

		String ssqlrun="Select * from db_gps.t_completedjourney where tripid='"+tripID+"' and Runhrviolastday='Yes'";		
		ResultSet rsrun1=st4.executeQuery(ssqlrun);
		System.out.println("Disconnetion query is>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " +ssqlrun);
		
		if(rsrun1.next())
		{
			
		}
		else{
			Calendar cal = Calendar.getInstance();
			cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(thedate12));
			cal.add(Calendar.DATE, -1);
			Date thedate121 = cal.getTime();
			thedate12=new SimpleDateFormat("yyyy-MM-dd").format(thedate121);
		}
		
		sqlrun="SELECT * FROM db_gpsExceptions.t_veh"+vehicleID+"_ds WHERE vehcode ='"+vehicleID+"' and RDuration > '10:00:00' and thedate >='"+thedate11+"' and thedate <='"+thedate12+"'";		
		ResultSet rsrun=st4.executeQuery(sqlrun);
		System.out.println("Disconnetion query is>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " +sqlrun);
		
		while(rsrun.next())
		{
			
			%>
			<tr>
			
			<%
			newdate=rsrun.getString("TheDate");
			Distancenew=rsrun.getString("Distance");
			rdurnew=rsrun.getString("RDuration");
			//out.println("rdurnew:---------------"+rdurnew);
			//String rd=rdurnew.l
			
			
			daterhr=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsrun.getString("TheDate")));

			String sqlloc="SELECT * FROM db_gps.t_veh"+vehicleID+" WHERE TheFieldDataDate = '"+newdate+"' ORDER BY concat(TheFieldDataDate,' ',TheFieldDataTime) DESC LIMIT 1";
			System.out.println("Location lat query" +sqlloc);

			ResultSet rsloc=st5.executeQuery(sqlloc);
			if(rsloc.next())
			{
				latit = rsloc.getDouble("LatinDec");
				longit = rsloc.getDouble("LonginDec");
				locdateremve=rsloc.getString("TheFieldSubject");


			}
			
			
			%>
			<td style=" text-align: right"><%=km%></td>
			<td style=" text-align: right"><%=daterhr%></td>
			
			<td style=" text-align: left">
			<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=latit%>&long=<%=longit%>&discription=<%=locdateremve%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=km%>,false);">
			<%=locdateremve %></a></td>
			
			
			<td style=" text-align: right"><%=Distancenew%></td>
			<%-- <td style=" text-align: right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rdurnew))%></td> --%>
			<td style=" text-align: center"><%=rdurnew%></td>
			
			</tr>
			<%
			
			km++;
			
		}
		
	
		
	}catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	%>

	
	
	</table>
	
	
	</td>
	</tr>
	
	

</table>
</div>
</form>
</body></html>
<%
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		
	%>



<%@ include file="footernew.jsp"%>