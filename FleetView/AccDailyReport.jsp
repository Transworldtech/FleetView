<%@ include file="headernew.jsp"%>
<%@page import="java.util.Date"%>


<script language="javascript">

function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}




///////by tejashri

////// by palash

function gotoExcel(elemId, frmFldId)  
{  
	
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;
    
    document.RoundTripReport.action ="excel.jsp";
    document.forms["RoundTripReport"].submit();
} 

  function validate()
  {
	  var myDate = new Date(document.getElementById("data1").value);
	  
  		if(document.getElementById("data1").value=="")
  		{
  
  			alert("Please select the from date");
  			return false;
  		}
  		if(document.getElementById("data2").value=="")
  		{
    	alert("Please select the to date");
  		return false;
  		}
  		return true;
  //return datevalidate();
  }
 function datevalidate()
{ 
	var date1=document.getElementById("data1").value;
	var date2=document.getElementById("data2").value;
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
	document.getElementById("data1").value="";
	document.getElementById("data2").value="";
	document.getElementById("data1").focus;

	return false;

	}
else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
{

	alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}

if(dm1==month){
if(dd1>day || dd2>day)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
}
if(dy1>dy2)
{
alert("From date year is should not be greater than to date year");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}

else if(year==dy1 && year==dy2) if(dm1>dm2)
{
alert("From date month is should not be greater than to date month");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
if(dm1==dm2) {
if(dd1 > dd2)
{
	alert("From date is should not be greater than to date");
	document.getElementById("data1").value="";
	document.getElementById("data2").value="";
	document.getElementById("data1").focus;
	return false;
}
}
return true;
}

  </script>
<script type="text/javascript">

function toggleDetails(id,show)
{
var popup = document.getElementById("popup"+id);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();

} else {
popup.style.visibility = "hidden";

 }
}
</script>
<style>
.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden; . popupnew { background-color : #98AFC7;
	position: absolute;
	visibility: visible;
}
</style>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn, conn1;
	Statement st, st1, st2, st3, st11,ststop,stowner;
	String fromdate, todate, sql, sql1, transporter, datenew1, datenew2,
			fromdatetime, todatetime;%>
<%
if(!(null==request.getQueryString()))
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
transporter=request.getParameter("transporter");
datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
String user=session.getValue("usertypevalue").toString();
//out.println(""+fromdate);
}
else
{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;

}

%>
<body>
<table border="0" width="100%" align="center" class="stats">
	<tr>
		<td align="center">
		<font size="3"><B>Trip Report</B></font></td>
	</tr>
	</table>
	<table border="0" width="100%" align="center">
	<tr>
		<td>
		<table border="0" width="500" align="center" class="sortable_entry">
			<form name="dateform" action="" method="get"
				onsubmit="return validate();">
			<tr>
				<td><b>From </b>&nbsp;&nbsp; <input type="text" id="data1"
					name="data1" value="<%=datenew1%>" size="15" readonly /></td>
				<td align="left"><!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
				<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>
				<td><b>To</b> &nbsp;&nbsp; <input type="text" id="data2"
					name="data2" value="<%=datenew2%>" size="15" readonly /></td>
				<td align="left"><!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
				<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script></td>

				<td><input type="hidden" name="transporter" id="transporter"
					value="<%=session.getAttribute("usertypevalue").toString()%>">
				<input type="submit" name="submit" id="submit" value="submit"></td>
			</tr>
			</form>
		</table>

		</td>
	</tr>
	<tr>
		<td>
		<%
if(!(null==request.getQueryString()))
{
	try
	{
		Class.forName(MM_dbConn_DRIVER); 
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn1.createStatement();
st11=conn.createStatement();
ststop=conn1.createStatement();
stowner=conn1.createStatement();
String exportFileName=session.getAttribute("user").toString()+"_RoundTripReport.xls"; 
%>
        <form id="RoundTripReport" name="RoundTripReport" action="" method="post" >
        <div id="table1">
		<table border="0" width="100%" align="center">
			<tr>
				<td align="center" colspan="16" width="100"><font size="3" color="blue"><B>Trip Report <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%>
				to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
				<div class="bodyText" align="right"></td>
				<td id="print" colspan="1" width="30">
<a href="#" onclick="javascript:window.open('print_AccDailyReport.jsp?tds=Hide Info&fromdate=<%=fromdate%>&todate=<%=todate%>&transporter=<%=transporter%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
</td>
<td id="excel" colspan="1" width="30">
<a href="Excel_AccDailyReport.jsp?tds=Hide Info&fromdate=<%=fromdate%>&todate=<%=todate%>&transporter=<%=transporter%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
<td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>

</td>
			</tr>
		</table>
		<table width="100%" border="1" align="center" class="sortable">

			<tr>
				<td class="hed" rowspan="2">Sr.</td>
				<td class="hed" rowspan="2">Trip ID</td>
				<td class="hed" rowspan="2">Veh.</td>
				<td class="hed" rowspan="2">Transporter</td>
				<td class="hed" rowspan="2">Customer</td>
				<td class="hed" rowspan="2">Destination</td>
				<td class="hed" rowspan="2">KmTravelled</td>
<!-- 				<td class="hed" rowspan="2">KM Travelled</td> -->
				<td class="hed" rowspan="2">Estimated Trip Time</td>
				<td class="hed" rowspan="2">Trip Start Time</td>
				<td class="hed" rowspan="2">Trip End Time</td>
				<td class="hed" rowspan="2">Actual Time Taken</td>
				<td class="hed" colspan="4">Stops at locations</td>
				<!--  <td class="hed" rowspan="2">Other Location Stoppages</td> -->
				<td class="hed" rowspan="2">Driving Time</td>
				
				<!-- <td class="hed" rowspan="2">Duty Time</td> -->
			</tr>
			<tr>
			  <td class="hed"></td><td class="hed"></td><td class="hed"></td><td class="hed"></td><td class="hed"></td><td class="hed"></td>
			<td class="hed"></td><td class="hed"></td><td class="hed"></td><td class="hed"></td>
			
				<td class="hed">Plant</td>
				<td class="hed">Toll Naka Etc</td>
				<td class="hed">Customer Site</td>
				<td class="hed">Other</td><td class="hed"></td><td class="hed"></td>
				
			</tr>
			<!-- th>% Diff in Distance</th> -->
			</tr>
			<%
//exactly date Record can be fetched

sql="select distinct(TripId) as TripId,TollNakaStop,RunningDuration,TripDuration,CustomerStop,PlantStop, Vehid,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,GPName,OtherStop,KmTravelled from db_gps.t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate  BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  order by StartDate ";
System.out.println("query=======>"+sql);
ResultSet rst=st.executeQuery(sql);
//System.out.println("\n\nqqqqqq-->>"+sql);
int i=1,dist1,dist2;
java.util.Date enddte1=null,strdte1=null;
double stdDist=0,capDist=0,stdTime=0;
String SDate,EDate,STime,ETime,tripid,StDate,EdDate,vehid;
long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0,etime,myhours=0;
String fromdate="",todate="";
int ftime1=0;
int ftime2=0;
int ttime1=0;
int ttime2=0;
String sdate,edate;
long actualTimeHrs=0,actualTimeMins=0;
long totalactualtimeHrs=0,totalactualtimeMins=0;
long dutyTimeHrs=0,dutyTimeMins=0;
long tolstop=0,totaltolstop=0;
long custstop=0,totalcuststop=0;
long otherstop=0,totalotherstop=0;
long plantstop=0,totalplantstop=0;
String tolstr="",plantstr="",custstr="",otherstr="";
long otlocstophh=0,otlocstopmm=0,otlocstopss=0;
long totalotlocstophh=0,totalotlocstopmm=0,totalotlocstopss=0;
long  drivinghh=0,drivingmm=0,drivingss=0;
long  totaldrivinghh=0,totaldrivingmm=0,totaldrivingss=0;
long dutyhh=0,dutymm=0;
long totaldutyhh=0,totaldutymm=0;


while(rst.next())
{ 
	//System.out.println("\n\nhhhhhhiiiiiiii");

	dutyhh=0;dutymm=0;

	drivinghh=0;drivingmm=0;drivingss=0;
	otlocstophh=0;otlocstopmm=0;otlocstopss=0;
	tolstop=0;

 custstop=0;
 plantstop=0;
 otherstop=0;
tolstr="";plantstr="";custstr="";
otherstr="";
	
	  actualTimeHrs=0;actualTimeMins=0;
	  dutyTimeHrs=0;dutyTimeMins=0;
 
//StDate=rst.getDate("StartDate");

	SDate=rst.getString("StartDate");
	
	try{
		StDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate));
	}catch(Exception e){
		StDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(SDate));
	}
	EDate=rst.getString("EndDate");
	try{
	EdDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate));
	}catch(Exception e){
		EdDate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(EDate));
	}
	
	STime=rst.getString("StartTime");
	ETime=rst.getString("EndTime");
	tripid=rst.getString("TripId");
	//System.out.println("\n\ntripid-->>"+tripid);

   vehid=rst.getString("Vehid");
//out.println(""+SDate);
	if(null==STime || STime.length()>8 || STime.equals("-"))
	{
	STime="00:00:00";
	}

	if(null==ETime || ETime.equals("-"))
	{	
		ETime="23:59:59";
	}

/*#################################change#############################*/

/*=====================================================
	parameters passed to show_custom_detail_rept_onMap.jsp
	start date
	Start time-> Hrs mins separate
	end date
	end time-> hrs mins separate
==============================================*/
	sdate=SDate;
	//System.out.println("sdate  "+sdate);
	try
	{
	  fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
	}
	catch(Exception e)
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
	}
	// System.out.println("StartDate--->>"+fromdate);
	try
	{
	java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
	 ftime1=dt.getHours();
	 ftime2=dt.getMinutes();
	}
	catch(Exception e)
  	{
  		ftime1=00;
  		ftime1=00;
  	}

	 edate=EDate;
	 //System.out.println("edate  "+edate);
	 try
	 {
	 	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
	 }
	 catch(Exception e)
	 {
		 
	 try{
		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
	 }
	 catch(Exception ee){
		 System.out.print(ee);
		 //ee.printStackTrace();
	 }
	 }
	try
	{
	java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
	 ttime1=edt.getHours();
	 ttime2=edt.getMinutes();
	}
	catch(Exception e)
  	{
  		ttime1=23;
  	 	ttime2=59;
  	}
	 /*#################################change#############################*/

	try{
	java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00
	miliseconds1=fd.getTime();
	}catch(Exception e1)
	{
		try{
				java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
				miliseconds1=fd.getTime();

			}catch(Exception e4)
			{
				try{
			
				java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
				miliseconds1=fd.getTime();
				}
				catch(Exception ee){
					System.out.println(ee);
				}

			}
	}
	try
	{
			java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
			miliseconds2=fd1.getTime();
	}catch(Exception e2)
	{
		try{
				java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
				miliseconds2=fd1.getTime();

			}catch(Exception e5)
			{
				try{
				java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
				miliseconds2=fd1.getTime();
			}
			catch(Exception ee){
				System.out.println(ee);
			}
			}
	}
	try{
			fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
		}catch(Exception e)
		 {
			try{
				fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
		 }
		catch(Exception ee){
			System.out.println(ee);
		}
		 }
		 try{
				todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
			}catch(Exception e)
			{
				try{
				todatetime=rst.getString(new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"))+" "+ETime));
			}
			catch(Exception ee){
				System.out.println(ee);
			}
			}
			%>
			<tr>
				<td style="text-align: right"><%=i%></td>
				<td>
				<div align="right"><font size="10"> <a
					href="javascript:toggleDetails(<%=i%>,true);"
					title="Click To See the Reports"><font size="2"><%=rst.getString("TripId")%></font></a>
				</font><br />
				<div class="popup" id="popup<%=i%>">
				<table border="1" bgcolor="white">
					<tr>
						<td>
						<%
						String briefid = "",rid = "",plannedstatus = "No";
						boolean flag = false;
						String sql1 = "select * from db_gps.t_briefing where tripid = '"+rst.getString("TripId")+"'";
						ResultSet rs1 = st1.executeQuery(sql1);
						if(rs1.next())
						{
							briefid = rs1.getString("Briefid");
						}

						sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rst.getString("TripId")+"' and briefid = '"+briefid+"' and driverid = '"+rst.getString("DriverID")+"'  order by advancedtrackid asc ,row asc limit 1 ";
						rs1 = st1.executeQuery(sql1);
						if(rs1.next())
						{
							rid = rs1.getString("advancedrouteid");
							plannedstatus = "Yes";
							flag = true;
						}
						%>
						<a
							href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rst.getString("TripId")%>&vehcode=<%=rst.getString("VehId")%>&data=<%=fromdate %>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=rst.getString("DriverID")%>"
							onclick="javascript:toggleDetails(<%=i%>,false);">Show Trip On Map</a>
						<!--<a href="startedtrip.jsp?tripid=<%//=rst.getString("TripId")%>&vehcode=<%//=rst.getString("VehId")%>&sdate=<%//=fromdatetime%>&vehregno=<%//=rst.getString("VehRegNo")%>&ownername=<%//=session.getAttribute("user").toString()%>&startplace=<%//=rst.getString("StartPlace")%>&endplace=<%//=rst.getString("EndPlace")%>&enddate=<%//=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%//=i%>,false);">Show On Map</a>-->
						</td>
						<tr>
							<td><a
								href="detailed_report.jsp?vehcode=<%=rst.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit"
								onclick="javascript:toggleDetails(<%=i%>,false);">Detail
							Report</a></td>
						</tr>
						<tr>
							<td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td>
						</tr>
				</table>
				</div>
				</div>
				</td>
				<td style="text-align: left"><%=rst.getString("VehRegNo")%></td>
				<%
				String sqlowner="select Location from db_gps.t_RoundTripStop where Duration>'00:30:00' and LocationType='Customer' and tripid='"+rst.getString("tripid")+"' order by  Duration desc";
				ResultSet rss=st1.executeQuery(sqlowner);
				%>
				<td style="text-align: left"><%=rst.getString("OwnerName")%></td>
				<%
				if(rss.next())
				{ 
				String Location=rss.getString("Location");
				System.out.println("location========>"+Location);
				
				%>
				<td style="text-align: left"><%=rss.getString("Location")%></td>
				<%}else { %>
				<td style="text-align: left">---</td>
				<%} %>
				<td style="text-align: left"><%=rst.getString("EndPlace")%></td>
				<td style="text-align: right"><%=rst.getString("KmTravelled")%></td>
				<%
				sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rst.getString("StartPlace")+"' and EndPlace = '"+rst.getString("EndPlace")+"'";
				ResultSet rstdist=st1.executeQuery(sql);
				if(rstdist.next())
				{ 
				stdDist=rstdist.getDouble("Km");
				stdTime=rstdist.getDouble("TTime");
				}
				
				if(stdTime==0)
				{
				%>
				<td style="text-align: left">NA</td>
				<%
				}
				else
				{
				%>
				<td style="text-align: right"><%=stdTime%></td>
				<%
				}
				%>
				<td style="text-align: right">
				<% 
try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
}catch(Exception ee)
{
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
}
%>
				</td>
				<td style="text-align: right">
				<%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));
}catch(Exception ee)
{
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);
}
%>
				</td>
				<%
//***************************************************************************************************************
%>
				<td style="text-align: right">
				<%
try{

	try{
		enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
	}
	catch(Exception e)
	{
		try{
			enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
		}
		catch(Exception ee){
			System.out.println(ee);
		}
	}

	/* 	Check the difference between two date time Date */
	long hrs=0,mins=0;
	double hrslong=0.00;
	java.util.Date enddte11=null;
	java.util.Date strdte11=null;
	try{
		enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
		strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
	}
	catch(Exception ee){
		System.out.println(ee);
	}
	long x=enddte11.getMinutes();
	long y=strdte11.getMinutes();
	long timediff=enddte11.getTime()-strdte11.getTime();//msec
	long mins11=timediff/1000/60;

	if(mins11>=60)
	{
		hrdiff=mins11/60;//2

		if((y>x)&&(x!=0))
		{
			mins=y-x;
			mins=60-mins;
			out.print(hrdiff+":"+mins);
		}
		else if((x>y)&&(y!=0))
		{
			mins=x-y;
			out.print(hrdiff+":"+mins);
		}else if(x==y)
		{
			mins=x-y;
			out.print(hrdiff+":"+mins);
		}
		 else if((x==0)&&(y>x))
 		{
	 		mins=60-y;
	 		out.print(hrdiff+":"+mins);
 			}else if(y==0)
 		{
	 		mins=x+y;
	 		out.print(hrdiff+":"+mins);
 		}
	}
	else
	{
		hrdiff=0;
		mins=mins11;
		out.print(hrdiff+":"+mins);
	}
	

	  actualTimeHrs=hrdiff;
	//  System.out.println("actualTimeHrs-->>"+actualTimeHrs);
	  actualTimeMins=mins;
	 // System.out.println("actualTimeMins-->>"+actualTimeMins);
		
	  totalactualtimeHrs=totalactualtimeHrs+actualTimeHrs;
	  totalactualtimeMins=totalactualtimeMins+actualTimeMins;
	  
	String enddte=enddte1+" "+ETime;
	String strtdte=strdte1+" "+STime;

	long tmeinmils=enddte1.getTime()-strdte1.getTime();
	//out.println(""+enddte1.getTime());
	long hours=tmeinmils/(1000*60*60);

	String extractstrtminutes=STime.substring(3,5);
	String extractendminutes=ETime.substring(3,5);
	//out.print(""+ETime);
	int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);

	if(totmins >= 60)
	{
		hrdiff=hrdiff+1;
		totmins=totmins-60;
	}
	
	
}	
catch(Exception e)
{
		
}

%>
				</td>
				<td style="text-align: right"> <a href="#" onclick="javascript:window.open('stop_geofence.jsp?tripid=<%=rst.getString("Tripid")%>&vehregno=<%=rst.getString("Vehregno") %>&vehcode=<%=rst.getString("vehid")%>&data=<%=StDate%>&frmtime=<%=rst.getString("Starttime")%>&data1=<%=EdDate%>&ttime=<%=rst.getString("Endtime") %>&stopType=Plant_Stop');">
				<%
				
				
                String plantstrHH="",tolstrHH="",custstrHH="",otherstrHH="";
				plantstr="";tolstr="";custstr="";otherstr="";
				plantstr=rst.getString("PlantStop");
				tolstr=rst.getString("TollNakaStop");
				custstr=rst.getString("CustomerStop");
				otherstr=rst.getString("OtherStop");
			//	System.out.println("otherstr "+otherstr);
				plantstrHH=new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(plantstr));
				plantstr=new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(plantstr));
			//	System.out.println("HH:mm-->>"+plantstrHH+":"+plantstr);
				plantstop=0;
				plantstop=Long.parseLong(plantstrHH);
				myhours=myhours+plantstop;
				plantstop=plantstop*60;
				plantstop=plantstop+(Long.parseLong(plantstr));
				//System.out.println("munutes******-->>"+plantstop);
				totalplantstop=totalplantstop+plantstop;
				//System.out.println(" added munutes******-->>"+totalplantstop);
				
				
				
				
				tolstrHH=new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(tolstr));
				tolstr=new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(tolstr));
				tolstop=0;
				tolstop=(Long.parseLong(tolstrHH))*60;
				tolstop=tolstop+(Long.parseLong(tolstr));
				totaltolstop=totaltolstop+tolstop;
				
				
				custstrHH=new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(custstr));
				custstr=new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(custstr));
				
				custstop=0;
				custstop=(Long.parseLong(custstrHH))*60;
				custstop=custstop+(Long.parseLong(custstr));
				totalcuststop=totalcuststop+custstop;
				
				otherstrHH=new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(otherstr));
				otherstr=new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(otherstr));
				
				otherstop = 0;
				otherstop=(Long.parseLong(otherstrHH))*60;
				otherstop=otherstop+(Long.parseLong(otherstr));
				totalotherstop=totalotherstop+otherstop;
				
//out.print(finaltime);
				if(rst.getString("PlantStop").length()>6){  %>
					  <%=rst.getString("PlantStop").substring(0,2)+" : "+rst.getString("PlantStop").substring(3,5) %> 
			<%}else{ 
				out.println("---");
				} %>
<!--  Plant --></a></td>
				<td style="text-align: right"> <a href="#"
					onclick="javascript:window.open('stop_geofence.jsp?tripid=<%=rst.getString("Tripid")%>&vehregno=<%=rst.getString("Vehregno") %>&vehcode=<%=rst.getString("vehid")%>&data=<%=StDate%>&frmtime=<%=rst.getString("Starttime")%>&data1=<%=EdDate%>&ttime=<%=rst.getString("Endtime") %>&stopType=TollNaka_Stop');">
		<%	
				if(rst.getString("TollNakaStop").length()>6){
%>  				<%=rst.getString("TollNakaStop").substring(0,2)+" : "+rst.getString("TollNakaStop").substring(3,5) %> 
				<%}else{ 
					out.println("---");
				} %></a></td>
				<!-- Toll Naka ETC. -->
			<td style="text-align: right"> <a href="#"
					onclick="javascript:window.open('stop_geofence.jsp?tripid=<%=rst.getString("Tripid")%>&vehregno=<%=rst.getString("Vehregno") %>&vehcode=<%=rst.getString("vehid")%>&data=<%=StDate%>&frmtime=<%=rst.getString("Starttime")%>&data1=<%=EdDate%>&ttime=<%=rst.getString("Endtime") %>&stopType=Customer_Stop');">
		<%
					String mCustomerStop[] = rst.getString("CustomerStop").split(":");
					if(rst.getString("CustomerStop").length()>6){
%>  						<%=mCustomerStop[0]+" : "+mCustomerStop[1] %> 
					<%}else{ 
							out.println("---");
					} %></a>
 		</td>
 		<td style="text-align: right"> <a href="#"
					onclick="javascript:window.open('stop_geofence.jsp?tripid=<%=rst.getString("Tripid")%>&vehregno=<%=rst.getString("Vehregno") %>&vehcode=<%=rst.getString("vehid")%>&data=<%=StDate%>&frmtime=<%=rst.getString("Starttime")%>&data1=<%=EdDate%>&ttime=<%=rst.getString("Endtime") %>&stopType=Other_Stop');">
		<%
					String mOtherStop[] = rst.getString("OtherStop").split(":");
					if(rst.getString("OtherStop").length()>6){
%>  						<%=mOtherStop[0]+" : "+mOtherStop[1] %> 
					<%}else{ 
							out.println("---");
					} %></a>
 		</td>
				<!-- CUSTOMER SITE -->
			
				<% 
int hrs=0,mins=0,secs=0,total=0,actualTimeTotal;
String hhh="",mmm="",sss="",dduration="",tot1="";
long  hhh1,hhhr,mmm1,mmmr,sss1,sssr;
String sqlstop1="select distinct a.FromDate ,a.FromTime ,a.ToDate ,a.ToTime ,a.Location ,a.Duration from db_gpsExceptions.t_veh"+vehid+"_stsp a where concat(a.FromDate,' ',a.fromtime)>='"+StDate+" "+STime+"' and concat(a.ToDate,' ',a.Totime)<='"+EdDate+" "+ETime+"' and concat(a.FromDate,' ',a.fromtime)  not in(select distinct concat(a.FromDate,' ',a.fromtime) from db_gpsExceptions.t_veh"+vehid+"_stsp a, db_gps.t_warehousedata b where concat(a.FromDate,' ',a.fromtime)>='"+StDate+" "+STime+"' and a.location like 'In %' and b.owner='"+session.getAttribute("usertypevalue").toString()+"' and a.location like concat('%',b.warehouse,'%'))";
System.out.println("query12====>"+sqlstop1);
ResultSet rststop1 = ststop.executeQuery(sqlstop1);
while(rststop1.next())
{
 	total=0;
	dduration=rststop1.getString("Duration");
	hhh = dduration.substring(0,2);
	hrs=hrs+Integer.parseInt(hhh)*3600;
	mmm =dduration.substring(3,5);
	mins=mins+Integer.parseInt(mmm)*60;
	sss= dduration.substring(6,8);
	secs=Integer.parseInt(sss);
	total=total+hrs+mins+secs;
}

hhh1= total/3600;
hhhr=total%3600;
mmm1=hhhr/60;
mmmr=hhhr%60;
sss1=mmmr;
String finaltime1="";
otlocstophh=hhh1*60*60;
otlocstopmm=mmm1*60;
otlocstopmm=otlocstophh+otlocstopmm+sss1;
totalotlocstophh=totalotlocstophh+otlocstopmm;

%>
 
				<td style="text-align: right">
				
				<% 
 
			    drivinghh=Long.parseLong(new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("RunningDuration"))));
				drivingmm=Long.parseLong(new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("RunningDuration"))));
				drivingss=Long.parseLong(new SimpleDateFormat("ss").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("RunningDuration"))));
				drivingss=drivingmm*60+drivinghh*3600;
				totaldrivingss=totaldrivingss+drivingss;
				
				dutyTimeHrs=dutyTimeMins=0;
				//out.println("CustomerStop"+(rst.getString("CustomerStop")));
				hrs=0;
				mins=0;
				if(rst.getString("PlantStop").length() > 6 && rst.getString("TollNakaStop").length() > 6 && rst.getString("CustomerStop").length() > 6 && rst.getString("OtherStop").length() > 6)
				{
				//out.println("CustomerStop"+(mCustomerStop[0]));
				
				
				hrs = (Integer.parseInt(rst.getString("TollNakaStop").substring(0,2))*3600)
							+(Integer.parseInt(mCustomerStop[0])*3600) ; 
			//	System.out.println("hrs-->"+hrs);
				//out.println("hrs:---->"+hrs);
			 
				mins=(Integer.parseInt(rst.getString("TollNakaStop").substring(3,5))*60) 
				+(Integer.parseInt(mCustomerStop[1])*60);
			//	System.out.println("mins-->"+mins);
				//out.println("mins:---->"+mins);
				}
				
				
				
				actualTimeTotal=((int)actualTimeHrs*3600)+((int)actualTimeMins*60);
				//System.out.println("actualTimeTotal-->"+actualTimeTotal);
				total=actualTimeTotal-(hrs+mins);
			//	System.out.println("total-->"+total);
				//out.println("---->>>"+actualTimeTotal+"hrs"+hrs+"mins"+mins);
				hhh1= total/3600;
				//out.println("hhh1---->>>"+hhh1);
				hhhr=total%3600;
				//out.println("hhhr---->>>"+hhhr);
				mmm1=hhhr/60;
				//out.println("mmm1---->>>"+mmm1);
				mmmr=hhhr%60;
				//out.println("mmmr---->>>"+mmmr);
				
				//out.print(hhh1+" :"+mmm1);
				%>
				
				<div align="right"><%=hhh1 %>:<%=mmm1 %> </div>
				
				<%
				dutyhh=hhh1*60;
				dutymm=mmm1+dutyhh;
				totaldutymm=totaldutymm+dutymm;
				%></td></tr>
				<!-- DUTY TIME -->
				<%
i++;
}
//System.out.println("\n\n i--->>"+i);
if(i!=1)
{
//System.out.println("\n\n\n totalactualtimeHrs--->>>"+totalactualtimeHrs);
totalactualtimeHrs=totalactualtimeHrs*60;  // convert time to minutes
//System.out.println("\n\n\n totalactualtimeMins--->>>"+totalactualtimeMins);
totalactualtimeMins=totalactualtimeMins+totalactualtimeHrs;
//System.out.println("\n\n\n Now total minutes--->>>"+totalactualtimeMins);
totalactualtimeMins=totalactualtimeMins/(i-1);
//System.out.println("\n\n\n Average minutes minutes--->>>"+totalactualtimeMins);
int hrs=(int)totalactualtimeMins/60;
int min=(int)totalactualtimeMins%60;
//System.out.println("\n\n\n final Actual time avg.--->>>"+hrs+":"+min);
String hrsstr="",minstr="";
minstr=""+min;
hrsstr=""+hrs;
if(hrs<10)
{
	hrsstr="0"+hrsstr;
}
if(min<10)
{
	minstr="0"+minstr;
}

//System.out.println("\n\n\nmy houres--->>"+myhours);
//System.out.println("\n\n\n Total plant stop minutes--->>>"+totalplantstop);
double duty5=(double)totalplantstop/(i-1);
//System.out.println("\n\n\naverage plant stop minutes--->>>"+duty5);
totalplantstop=Math.round(duty5);

//System.out.println("\n\n\n average 1 plant stop minutes--->>>"+totalplantstop);

int planthrs=(int)totalplantstop/60;
int plantmin=(int)totalplantstop%60;
//System.out.println("\n\n\n final plant time avg.--->>>"+planthrs+":"+plantmin);
String planthrsstr="",plantminstr="";
planthrsstr=""+planthrs;
plantminstr=""+plantmin;
if(planthrs<10)
{
	planthrsstr="0"+planthrsstr;
}
if(plantmin<10)
{
	plantminstr="0"+plantminstr;
}



//System.out.println("\n\n\n Total tol stop minutes--->>>"+totaltolstop);
double duty4=(double)totaltolstop/(i-1);
totaltolstop=Math.round(duty4);

int tolhrs=(int)totaltolstop/60;
int tolmin=(int)totaltolstop%60;
//System.out.println("\n\n\n final plant time avg.--->>>"+tolhrs+":"+tolmin);

String tolhrsstr="",tolminstr="";
tolhrsstr=""+tolhrs;
tolminstr=""+tolmin;
if(tolhrs<10)
{
	tolhrsstr="0"+tolhrsstr;
}
if(tolmin<10)
{
	tolminstr="0"+tolminstr;
}


//System.out.println("\n\n\n Total cust stop minutes--->>>"+totalcuststop);

double duty3=(double)totalcuststop/(i-1);
totalcuststop=Math.round(duty3);


int custhrs=(int)totalcuststop/60;
int custmin=(int)totalcuststop%60;
//System.out.println("\n\n\n final plant time avg.--->>>"+custhrs+":"+custmin);


String custhrsstr="",custminstr="";
custhrsstr=""+custhrs;
custminstr=""+custmin;
if(custhrs<10)
{
	custhrsstr="0"+custhrsstr;
}
if(custmin<10)
{
	custminstr="0"+custminstr;
}

System.out.println("*******    "+totalotherstop);
double duty0=(double)totalotherstop/(i-1);
totalotherstop=Math.round(duty0);


int otherhrs=(int)totalotherstop/60;
int othermin=(int)totalotherstop%60;
System.out.println("\n\n\n final plant time avg.--->>>"+otherhrs+":"+othermin);


String otherhrsstr="",otherminstr="";
otherhrsstr=""+otherhrs;
otherminstr=""+othermin;
if(otherhrs<10)
{
	otherhrsstr="0"+otherhrsstr;
}
if(othermin<10)
{
	otherminstr="0"+otherminstr;
}

// Other Location Stoppages calculations
double duty2=(double)totalotlocstophh/(i-1);
totalotlocstophh=Math.round(duty2);





int hours = (int)totalotlocstophh / 3600;
int remainder = (int)totalotlocstophh % 3600;
int minutes = remainder / 60;
int seconds = remainder % 60;



String hoursstr="",minutesstr="",secondsstr="";
hoursstr=""+hours;
minutesstr=""+minutes;
secondsstr=""+seconds;

if(hours < 10)
{
	hoursstr="0"+hoursstr;
}
if(minutes < 10)
{
	minutesstr="0"+minutesstr;
}
if(seconds < 10)
{
	secondsstr="0"+secondsstr;
}

//driving time....

double duty1=(double)totaldrivingss/(i-1);
totaldrivingss=Math.round(duty1);



int hours1 = (int)totaldrivingss / 3600;
int remainder1 = (int)totaldrivingss % 3600;
int minutes1 = remainder1 / 60;
int seconds1 = remainder1 % 60;


String hoursstr1="",minutesstr1="",secondsstr1="";
hoursstr1=""+hours1;
minutesstr1=""+minutes1;
secondsstr1=""+seconds1;

if(hours1 < 10)
{
	hoursstr1="0"+hoursstr1;
}
if(minutes1 < 10)
{
	minutesstr1="0"+minutesstr1;
}
if(seconds1 < 10)
{
	secondsstr1="0"+secondsstr1;
}


// duty time calculations...


double duty=(double)totaldutymm/(i-1);
totaldutymm=Math.round(duty);

totaldutyhh=(int)totaldutymm/60;
totaldutymm=(int)totaldutymm%60;

String totaldutyhhstr="",totaldutymmstr="";
totaldutyhhstr=""+totaldutyhh;
totaldutymmstr=""+totaldutymm;
if(totaldutyhh<10)
{
	totaldutyhhstr="0"+totaldutyhhstr;
}
if(totaldutymm<10)
{
	totaldutymmstr="0"+totaldutymmstr;
}
%>
<tr class="sortbottom">
<td colspan="9" class="hed">Average</td>
<td class="hed">
					<div align="right"><%=hrsstr %>:<%=minstr %> </div>
					</td>
					<td class="hed">
					<div align="right"><%=planthrsstr %>:<%=plantminstr %> </div>
					</td>
					<td class="hed">
					<div align="right"><%=tolhrsstr %>:<%=tolminstr %> </div>
					</td>
					<td class="hed">
					<div align="right"><%=custhrsstr %>:<%=custminstr %> </div>
					</td>
					<td class="hed">
					<div align="right"><%=otherhrsstr %>:<%=otherminstr %> </div>
					</td>
					<td class="hed">
					<div align="right"><%=totaldutyhhstr %>:<%=totaldutymmstr %> </div>
					</td></tr>
					

<%}
else
{%>
<tr class="sortbottom">
<td colspan="16" class="hed">No Record Available</td>
	<%} %>		
		</table>
		</div>
		
		</form>
		
		<%
}
catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{
conn.close();
conn1.close();
}
}
%>
		</td>
	</tr>
</table>
</body>

<%@ include file="footernew.jsp"%>
