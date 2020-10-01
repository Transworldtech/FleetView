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
String  showdate="",dateformat="",Head="";
String  thedate1="", thedate2="",currentDateTime="",twentyFourHoursPrevDatetime="",exportFileName="";
int ab=1;
Connection con=null ;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	 Statement st1=con.createStatement();
	 Statement st2=con.createStatement();
	 Statement st3=con.createStatement();

	 Statement st4=con.createStatement();
	 Statement st41=con.createStatement();
	 Statement st42=con.createStatement();
	 Statement st5=con.createStatement();
	 String Rpttype=request.getParameter("rpttime");
	 System.out.println("Rpttype is "+Rpttype);
	 
	 
	 if(Rpttype=="24hr" || Rpttype.equalsIgnoreCase("24hr"))
	 {
	 
	 Head="Last 24 Hours Report";
	 
	 
	 dateformat=session.getAttribute("dateformat").toString();
	vid=request.getParameter("vid");
	
	java.util.Date todaysDate =new java.util.Date();
	currentDateTime =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(todaysDate);
	
	long todaysDateMillis = todaysDate.getTime(); // todays date in millisecs
	long dayInMillis = 1000 * 60 * 60 *24; // 1 day in millisecs
	
	todaysDateMillis = todaysDateMillis - dayInMillis; // 24 hrs previous datetime from currentdatetime (in millisecs)
	todaysDate.setTime(todaysDateMillis);
	
	twentyFourHoursPrevDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(todaysDate);
	//thedate2=thedate1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(NewDate);
	out.println("Date is>>> " +twentyFourHoursPrevDatetime);
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
	exportFileName=session.getAttribute("user").toString()+"_"+vehregno+"_last24hrs_report.xls";
	 }

	 else if(Rpttype=="48hr" || Rpttype.equalsIgnoreCase("48hr"))

	 {
		 Head="Last 48 Hours Report";

			dateformat = session.getAttribute("dateformat").toString();
			vid=request.getParameter("vid");
			java.util.Date todaysDate =new java.util.Date();
			currentDateTime =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(todaysDate);
			
			long todaysDateMillis = todaysDate.getTime(); // todays date in millisecs
			long dayInMillis = 1000 * 60 * 60 * 48; // 2 days in millisecs
			
			todaysDateMillis = todaysDateMillis - dayInMillis; // 48 hrs previous datetime from currentdatetime (in millisecs)
			todaysDate.setTime(todaysDateMillis);
			
			twentyFourHoursPrevDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(todaysDate);
			
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
		exportFileName=session.getAttribute("user").toString()+"_"+vehregno+"_last48hrs_report.xls";
	 }

	 else if(Rpttype=="7day" || Rpttype.equalsIgnoreCase("7day"))

	 {
		 Head="Last 7 Days Report";
		 dateformat = session.getAttribute("dateformat").toString();
			vid=request.getParameter("vid");
			java.util.Date NewDate= new java.util.Date();
			long dateMillis= NewDate.getTime();
			long dayInMillis = 1000 * 60 * 60 *24;
			dateMillis = dateMillis - dayInMillis;
			NewDate.setTime(dateMillis);
			thedate2=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
			dayInMillis = 6000 * 60 * 60 *24;
			dateMillis = dateMillis - dayInMillis;
			NewDate.setTime(dateMillis);
			thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
			twentyFourHoursPrevDatetime=thedate1+" 00:00:00";
			currentDateTime=thedate2+" 23:59:59";
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
			  exportFileName=session.getAttribute("user").toString()+"_7DaysReport.xls";
	 }
	 else if(Rpttype=="15day" || Rpttype.equalsIgnoreCase("15day"))

	 {
		 Head="Last 15 Days Report";
		 dateformat = session.getAttribute("dateformat").toString();
			vid=request.getParameter("vid");
			java.util.Date NewDate= new java.util.Date();
			long dateMillis= NewDate.getTime();
			long dayInMillis = 1000 * 60 * 60 *24;
			dateMillis = dateMillis - dayInMillis;
			NewDate.setTime(dateMillis);
			thedate2=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
			dayInMillis = 14000 * 60 * 60 *24;
			dateMillis = dateMillis - dayInMillis;
			NewDate.setTime(dateMillis);
			thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
			twentyFourHoursPrevDatetime=thedate1+" 00:00:00";
			currentDateTime=thedate2+" 23:59:59";
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
		exportFileName=session.getAttribute("user").toString()+"_15DaysReport.xls";
	 
	 }else{}
%>
<form id="veh24hrs" name="veh24hrs" action="" method="post" >
<div id="mytable">
<table width="100%" align="center" class="stats">
	<tr>
		<td align="center">
		<!-- <div align="left"><font size="3">Report No: 1.6</font></div>-->
		<font size="3"><b><%=Head%></b></font></td>
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
				<th><b>Zone</b></th>
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
				
			</tr>
			<tr>
			<%
		
			try{
				int os=1;
				String bgcolor="",zonecolor="",fromdate="",zoneval="";
		//	String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vid+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vid+"  WHERE  TheFiledTextFileName= 'OS' GROUP BY TheFieldDataDate, TheFieldDataTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(FromDate,' ',FromTime) >='"+twentyFourHoursPrevDatetime+"' and concat(FromDate,' ',FromTime) <='"+currentDateTime+"' ORDER BY concat(os.FromDate,os.FromTime)";
			String sqloscalc="SELECT os.Duration, os.FromDate, os.FromTime, os.ToDate, os.ToTime,veh.LatinDec, veh.LonginDec, veh.TheFieldSubject, os.Speed, os.Zone FROM db_gpsExceptions.t_veh"+vid+"_overspeed os LEFT OUTER JOIN (SELECT TheFieldDataDate, TheFieldDataTime, MAX(LonginDec) AS LonginDec, MAX(LatinDec) AS LatinDec,MAX(TheFieldSubject) AS TheFieldSubject FROM  db_gps.t_veh"+vid+"  WHERE  TheFiledTextFileName= 'OS' and TheFieldDataDateTime >= '"+twentyFourHoursPrevDatetime+"' and TheFieldDataDateTime <= '"+currentDateTime+"' GROUP BY TheFieldDataDateTime) veh ON (veh.TheFieldDataDate = os.FromDate AND veh.TheFieldDataTime = os.FromTime) WHERE concat(FromDate,' ',FromTime) >='"+twentyFourHoursPrevDatetime+"' and concat(FromDate,' ',FromTime) <='"+currentDateTime+"' ORDER BY concat(os.FromDate,os.FromTime)";
			System.out.println("Join query is"+sqloscalc);
			ResultSet rsoscalc=st4.executeQuery(sqloscalc);
			while(rsoscalc.next())
			{
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
						<td style="text-align:right;<%=bgcolor%>"><%=fromdate%> <%=rsoscalc.getString("FromTime")%></td>
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
						
						<td style="text-align:right;<%=bgcolor%>">
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
				<th><b>Cabin Images</b></th>
				<th><b>Road Images</b></th>
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
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
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
			String sqloscount1="select count(*) count,category from db_gps.t_jpgsnap where category='Road' and vehid="+vid+" and snapdatetime>='"+rsostodate.getString("datetim1")+"' and snapdatetime<='"+rsostodate.getString("datetim")+"' and type='Exception' group by category";
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
			}
		    %>
		</table>
		</td>
	</tr>




	<tr>
		<td align="center"><font size="3"><b>Disconnection Data</b></font></td>
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
		   int dic=1;
			String datedicvio="",datedicvios="",tripids="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;

		String	sqlDic="select * from db_gps.t_disconnectionData where vehicleCode='"+vid+"' and Reason='Disconnection' and ignoredstamp='No' and Duration >= '0:30' and OffTimeFrom >='"+twentyFourHoursPrevDatetime+"' and OffTimeFrom <='"+currentDateTime+"'";
			ResultSet rsdic=st4.executeQuery(sqlDic);
			while(rsdic.next())
			{

				fromLatitude = rsdic.getDouble("FromLatitude");
				fromLongitude = rsdic.getDouble("FromLongitude");
				toLatitude = rsdic.getDouble("ToLatitude");
				toLongitude = rsdic.getDouble("ToLongitude");
				datedicvio=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsdic.getString("OffTimeFrom")));
				datedicvios=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rsdic.getString("OffTimeTo")));
				 
                           tripids=rsdic.getString("TripId");
				
				if(tripids.equals(""))
				{
					tripids="-";
				}
			%>
			<tr>
			<td align="right"><div align="right"><%=dic%></div></td>
					<td align="right"><div align="right"><%=datedicvio%></div></td>
					<td align="left"><div align="left">
					
					<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=fromLatitude%>&long=<%=fromLongitude%>&discription=<%=rsdic.getString("FromLocation") %>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=dic%>,false);">
	
					
					<%=rsdic.getString("FromLocation") %>	</a>
					
					</div></td>
					
					<td align="right"><div align="right"><%=datedicvios%></div></td> 
					<td align="left"><div align="left">
					
					<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=toLatitude%>&long=<%=toLongitude%>&discription=<%=rsdic.getString("ToLocation") %>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=dic%>,false);">
		
					<%=rsdic.getString("ToLocation") %></a>
					
					
					</div></td>
					
					<td align="right"><div align="right"><%=rsdic.getString("Distance") %></div></td>
					<td align="right"><div align="right"><%=rsdic.getString("Duration") %></div></td>
								<td align="right"><div align="right"><%=tripids%></div></td>
			
			
			</tr>
			
			<%
				
				
				
			}
			
		%>
		</table>
		</td>
	</tr>







<tr>
		<td align="center"><font size="3"><b>Run Hours </b></font></td>
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
			<tr>
			<%
			try{
		   int runhr=1;
			String locdateremve="",newdate="",Distancenew="",rdurnew="";
			double latit=0.00,longit=0.00;
			String daterhr="",twentyFourHoursPrevDatetime11="",currentDateTime12="";
			
			twentyFourHoursPrevDatetime11=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(twentyFourHoursPrevDatetime));
			currentDateTime12=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(currentDateTime));
			
			String	sqlRhr="SELECT * FROM db_gpsExceptions.t_vehall_ds WHERE vehcode ='"+vid+"' and RDuration > '10:00:00' and thedate >='"+twentyFourHoursPrevDatetime11+"' and thedate <='"+currentDateTime12+"'";
			System.out.println("Query of Run hrviolation " +sqlRhr);
			ResultSet rsRhr=st4.executeQuery(sqlRhr);
			
			while(rsRhr.next())
			{
				
				newdate=rsRhr.getString("TheDate");
				Distancenew=rsRhr.getString("Distance");
				rdurnew=rsRhr.getString("RDuration");
				daterhr=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsRhr.getString("TheDate")));
				
				System.out.println("Location after split " +locdateremve);
				
				String sqlloc="SELECT * FROM db_gps.t_veh"+vid+" WHERE TheFieldDataDate = '"+newdate+"' ORDER BY concat(TheFieldDataDate,' ',TheFieldDataTime) DESC LIMIT 1";
				System.out.println("Location lat query" +sqlloc);

				ResultSet rsloc=st5.executeQuery(sqlloc);
				if(rsloc.next())
				{
					latit = rsloc.getDouble("LatinDec");
					longit = rsloc.getDouble("LonginDec");
					locdateremve=rsloc.getString("TheFieldSubject");


				}
			
				
				 
			%>
			<td align="right"><div align="right"><%=runhr%></div></td>
					<td align="right"><div align="right"><%=daterhr%></div></td>
					<td align="left"><div align="left">
					
					
					<a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=latit%>&long=<%=longit%>&discription=<%=locdateremve%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=runhr%>,false);">
		
					
					
					
					<%=locdateremve %></a>
					
					
					
				
					</div></td>
					
					<td align="right"><div align="right"><%=Distancenew%></div></td>
					<td align="right"><div align="right"><%=rdurnew %></div></td>
					
					
			
					</tr>
			
			
			
			<%
				
			runhr++;
				
			}}catch(Exception e)
			{
				out.print(e);
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
			finally{
				con.close();
			}
		
	%>



<%@ include file="footernew.jsp"%>

