<%@ include file="headernew.jsp"%>               

<%@page import="org.apache.naming.java.javaURLContextFactory"%><jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	%>
	<%!Connection con1;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vehicle Master Entry</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<style>
.clear1:after {
content:".";
height:0;
clear:both;
visibility: visible;
}
</style>

<script type="text/javascript">
function gotoPrint(divName)  
{  

	  //alert("in the  goto print function") ;
	  try
	  {
		  var printContents = document.getElementById(divName).innerHTML;
	  //alert("A") ; 
	  	var originalContents = document.body.innerHTML; 
	  //alert("B") ;	
	  document.body.innerHTML = printContents;  
	  //alert("C") ;	
	  window.print();
	  //alert("D") ;	
	  document.body.innerHTML = originalContents;  
	  }catch(e){alert(e);}
	  //alert("E") ;	
}
</script>

</head>

<body id="main_body" >

<script src="includes/vehiclevalidate.js" type="text/javascript"></script>
<script src="includes/drivervalidate.js" type="text/javascript"></script>
<script src="includes/journeyvalidate.js" type="text/javascript"></script>
<script src="includes/processvalidate.js" type="text/javascript"></script>



<!--</html>-->
</jsp:useBean>
<%
	try {
		//System.out.println("$$$$$$$$$   ");
		Class.forName(MM_dbConn_DRIVER);
		con1 = fleetview.ReturnConnection();
		Statement st = con1.createStatement();
		Statement st1 = con1.createStatement();
		Statement st2 = con1.createStatement();
		String quarter = request.getParameter("quarter");
		String year = request.getParameter("year");
		String monthquarter = "";
		System.out.println("quarter bvfhdgfdmn  "+quarter);
		int VehicleFTPRate = 0,VehicleFTPRRecord = 0,VehiclespresentSheet =0,SectionScore =0,Completedscore =0;
		int ToverDue = 0,MoverDue = 0,DriverReject = 0,Cleanerabsent = 0,DPS = 0,DecLetter = 0,DUR = 0,Dsectionscore = 0;
		int medicalcheck = 0,basic =0,cap1 = 0,cap2 = 0,cap3 =0,Rcap = 0;
		int JRMAdh = 0,ZeroDVI = 0,JRMDoc = 0,DevApproval = 0,VioMonitor = 0,MJSectionScore = 0;
		int LoadSecure = 0,UnwarrantedStops = 0,LAClosure = 0,Psectionscore = 0,PolicyDocument = 0;
		String transporter = session.getAttribute("usertypevalue").toString();
		String vehlist =  session.getAttribute("VehList").toString();
		NumberFormat nfrating=NumberFormat.getInstance();
		nfrating.setMaximumFractionDigits(2);
		nfrating.setMinimumFractionDigits(2);	
		String todaydate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	
		%>
		<img id="top" src="newimages/top.png" alt="" style="width: 850px;">
		<div id="form_container" style="width: 850px;">
		
		<h1 align="center">Contractor Incentive</h1>
		<form method="get" action="" class="appnitro" onsubmit="return checkfilter();">
			<div  align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff;" >
		<table align="center" border="0"  style='width: 500px' >
		<tr>
		<td><label class="description" for="element_9" ><font size="2"><b>Quarter : </b><select name="quarter" id="quarter" style='width: 100px' >
					  <option value="1" <%if(quarter!=null && quarter.equals("1")){%>selected="selected"<%}else{%> selected="selected"<%} %>>Jan-Mar</option>
				      <option value="2" <%if(quarter!=null && quarter.equals("2")){%>selected="selected"<%}else{} %>>Apr-Jun</option>
				      <option value="3" <%if(quarter!=null && quarter.equals("3")){%>selected="selected"<%}else{} %>>Jul-Sept</option>
				      <option value="4" <%if(quarter!=null && quarter.equals("4")){%>selected="selected"<%}else{} %>>Oct-Dec</option>
					  </select></font></label></td>
		 <td><label class="description" for="element_9" ><font size="2"><b>Year : </b><select name="year" id="year" style='width: 100px' >
					  <option value="2013" <%if(year!=null && year.equals("2013")){%>selected="selected"<%}else{%> selected="selected"<%} %>>2013</option>
				      <option value="2014" <%if(year!=null && year.equals("2014")){%>selected="selected"<%}else{} %>>2014</option>
				      <option value="2015" <%if(year!=null && year.equals("2015")){%>selected="selected"<%}else{} %>>2015</option>
				      <option value="2016" <%if(year!=null && year.equals("2016")){%>selected="selected"<%}else{} %>>2016</option>
				      <option value="2017" <%if(year!=null && year.equals("2017")){%>selected="selected"<%}else{} %>>2017</option>
				      <option value="2018" <%if(year!=null && year.equals("2018")){%>selected="selected"<%}else{} %>>2018</option>
				      <option value="2019" <%if(year!=null && year.equals("2019")){%>selected="selected"<%}else{} %>>2019</option>
				      <option value="2020" <%if(year!=null && year.equals("2020")){%>selected="selected"<%}else{} %>>2020</option>
		 </select></font></label></td>
		 <td><font size="2"> 
		 <input id= "Trans" name = "Trans" value="<%=transporter %>" type="hidden"></input>
		 <input id="saveForm" class="button_text" type="submit" name="submit" value="Submit" style="border-style: outset; border-color: black"  />
		 </font></td>
		</tr>
				</table>
		</div>
		</form>
		
		<%
		if(quarter!=null)
		{
			monthquarter = "";
			if(quarter.equals("1"))
			{
				monthquarter = "Jan-Mar";
			}
			else
				if(quarter.equals("2"))
				{
					monthquarter = "Apr-Jun";
				}
				else
					if(quarter.equals("3"))
					{
						monthquarter = "Jul-Sept";
					}
					else
						if(quarter.equals("4"))
						{
							monthquarter = "Oct-Dec";
						}
			String sql = "SELECT * FROM db_gps.t_DriverIncentive where activestatus = 'Yes' and Module in ('Vehicle','Driver','Journey','Process')";
			ResultSet rspoints = st.executeQuery(sql);
			while(rspoints.next())
			{
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("VehicleFTPRate"))
				{
					VehicleFTPRate = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("VehicleFTPRRecord"))
				{
					VehicleFTPRRecord = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("VehiclespresentSheet"))
				{
					VehiclespresentSheet = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("SectionScore"))
				{
					SectionScore = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Completedscore"))
				{
					Completedscore = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("TrainingOverdue"))
				{
					ToverDue = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("MedicalOverdue"))
				{
					MoverDue = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverRejected"))
				{
					DriverReject = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("CleanerAbsent"))
				{
					Cleanerabsent = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverPresentSheet"))
				{
					DPS = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DeclarationLetter"))
				{
					DecLetter = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverUpdatedRegister"))
				{
					DUR = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DriverSectionScore"))
				{
					Dsectionscore = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("MedicalCheck"))
				{
					medicalcheck = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Basic"))
				{
					basic = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Capsule1"))
				{
					cap1 = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Capsule2"))
				{
					cap2 = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("Capsule3"))
				{
					cap3 = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("RefresherCapsule"))
				{
					Rcap = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("JRMAdherence"))
				{
					JRMAdh = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("ZeroDVI"))
				{
					ZeroDVI = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("JRMDocument"))
				{
					JRMDoc = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("DevApprovalSheet"))
				{
					DevApproval = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("ViolationMonitorSheet"))
				{
					VioMonitor = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("JSectionScore"))
				{
					MJSectionScore = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("LoadSecuring"))
				{
					LoadSecure = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("UnwarrentedStops"))
				{
					UnwarrantedStops = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("LeadingAlertClosure"))
				{
					LAClosure = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("PolicyDocument"))
				{
					PolicyDocument = rspoints.getInt("Points");
				}
				if(rspoints.getString("ScoreCategory").equalsIgnoreCase("PSectionScore"))
				{
					Psectionscore = rspoints.getInt("Points");
				}
			}
			
			  String Name = "",location = "",auditby = "",Reviewby = "",auditdate = "",comment = "",feedback = "",suggest = "";
			  double bonus = 0,total = 0;
			  sql = "select * from db_gps.t_auditsummary where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
			  ResultSet rs = st.executeQuery(sql);
			  if(rs.next())
			  {
				  Name = rs.getString("Name");location = rs.getString("Location");auditby = rs.getString("AuditBy");Reviewby = rs.getString("Reviewby");
				  if(rs.getString("AuditDate") == null || rs.getString("AuditDate").equals("-") || rs.getString("AuditDate").equals("") || rs.getString("AuditDate").equals("null"))
				  {
					  auditdate = todaydate;
				  }
				  else
				  {
					  auditdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("AuditDate")));
				  }
				
				  bonus = rs.getDouble("Bonus");comment = rs.getString("Comment");feedback = rs.getString("FeedBack");suggest = rs.getString("Suggestion");
			  }
			  else
			  {
				  Name = session.getAttribute("fname").toString()+" "+session.getAttribute("lname").toString();location = "";auditby = transporter;Reviewby = "Castrol";
				  auditdate = todaydate;
			  }
			  
			
			  int totvehicles = 0,tottrips = 0,FTPTrips = 0,VFTPRRScore = 0,UFTPRRScore = 0,YD1 = 0,QD1 = 0,QC1 = 0,O1 = 0,YC1 = 0;
			  int YD2 = 0,QD2 = 0,QC2 = 0,O2 = 0,YC2 = 0,YD3 = 0,QD3 = 0,QC3 = 0,O3 = 0,YC3 = 0,YD4 = 0,QD4 = 0,QC4 = 0,O4 = 0,YC4 = 0,YD5 = 0,QD5 = 0,QC5 = 0,O5 = 0,YC5 = 0;
			  int YD6 = 0,QD6 = 0,QC6 = 0,O6 = 0,YC6 = 0,YD7 = 0,QD7 = 0,QC7 = 0,O7 = 0,YC7 = 0,YD8 = 0,QD8 = 0,QC8 = 0,O8 = 0,YC8 = 0;
			  double VFTPRate = 0,Vsectionscore = 0,Cscore = 0,VFTPRateScore= 0;
			  String VFTPRR = "No",UFTPRR = "No";
			  sql = "select * from db_gps.t_vehicleaudit where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
			   rs = st.executeQuery(sql);
			  
			  if(rs.next())
			  {
				  totvehicles = rs.getInt("Vehciles");tottrips = rs.getInt("Trips"); FTPTrips = rs.getInt("FTPTrips"); VFTPRate = rs.getDouble("VFTPRate"); VFTPRR = rs.getString("VFTPRR");Cscore = rs.getDouble("CompletedScore");
				  UFTPRR = rs.getString("UFTPRR");VFTPRateScore = rs.getDouble("VFTPRateScore");  VFTPRRScore = rs.getInt("VFTPRRScore");UFTPRRScore = rs.getInt("UFTPRRScore"); Vsectionscore = rs.getDouble("SectionScore");
				  YD1 = rs.getInt("YearDue1");QD1 = rs.getInt("QuarterDue1"); QC1 = rs.getInt("QuarterCompleted1");O1 = rs.getInt("Overdue1");YC1 = rs.getInt("YearCompleted1");
				  YD2 = rs.getInt("YearDue2");QD2 = rs.getInt("QuarterDue2"); QC2 = rs.getInt("QuarterCompleted2");O2 = rs.getInt("Overdue2");YC2 = rs.getInt("YearCompleted2");
				  YD3 = rs.getInt("YearDue3");QD3= rs.getInt("QuarterDue3"); QC3 = rs.getInt("QuarterCompleted3");O3 = rs.getInt("Overdue3");YC3 = rs.getInt("YearCompleted3");
				  YD4 = rs.getInt("YearDue4");QD4 = rs.getInt("QuarterDue4"); QC4 = rs.getInt("QuarterCompleted4");O4 = rs.getInt("Overdue4");YC4 = rs.getInt("YearCompleted4");
				  YD5 = rs.getInt("YearDue5");QD5 = rs.getInt("QuarterDue5"); QC5 = rs.getInt("QuarterCompleted5");O5 = rs.getInt("Overdue5");YC5 = rs.getInt("YearCompleted5");
				  YD6 = rs.getInt("YearDue6");QD6 = rs.getInt("QuarterDue6"); QC6 = rs.getInt("QuarterCompleted6");O6 = rs.getInt("Overdue6");YC6 = rs.getInt("YearCompleted6");
				  YD7 = rs.getInt("YearDue7");QD7 = rs.getInt("QuarterDue7"); QC7 = rs.getInt("QuarterCompleted7");O7 = rs.getInt("Overdue7");YC7 = rs.getInt("YearCompleted7");
				  YD8 = rs.getInt("YearDue8");QD8 = rs.getInt("QuarterDue8"); QC8 = rs.getInt("QuarterCompleted8");O8 = rs.getInt("Overdue8");YC8 = rs.getInt("YearCompleted8");
			  }
			  
			  int Drivers = 0,tottrips1 = 0,Qdrivers = 0,Abdrivers= 0,Toverdue = 0,Moverdue = 0,RejectedDriver = 0,Abcleaner = 0,DPRSScore = 0;
			  int DecLetterScore = 0,DURSScore = 0,drivblacklist = 0,inducteddrivers = 0;
			  int DYD1 = 0,DQD1 = 0,DQC1 = 0,DO1 = 0,DYC1 = 0,DYD2 = 0,DQD2 = 0,DQC2 = 0,DO2 = 0,DYC2 = 0,DYD3 = 0,DQD3 = 0,DQC3 = 0,DO3 = 0,DYC3 = 0;
			  int DYD4 = 0,DQD4 = 0,DQC4 = 0,DO4 = 0,DYC4 = 0,DYD5 = 0,DQD5 = 0,DQC5 = 0,DO5 = 0,DYC5 = 0,DYD6 = 0,DQD6 = 0,DQC6 = 0,DO6 = 0,DYC6 = 0;
			  double ToverdueScore = 0,MoverdueScore = 0,DRejectScore = 0,AbclenerScore = 0,DSectionScore = 0,MCheckScore = 0,BasicScore = 0,Cap1Score = 0,Caps2Score = 0,Cap3Score = 0,RcapScore = 0;
			  String DPRS = "No",Decletter = "No",DURS = "No";
			  sql = "select * from db_gps.t_driveraudit where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
			   rs = st.executeQuery(sql);
			  if(rs.next())
			  {
				  Drivers = rs.getInt("Drivers");tottrips1 = rs.getInt("Trips"); Qdrivers = rs.getInt("Qdrivers");Abdrivers = rs.getInt("Abdriver");  Toverdue = rs.getInt("Toverdue");Moverdue = rs.getInt("Moverdue");  
				  RejectedDriver = rs.getInt("RejectedDriver");Abcleaner = rs.getInt("Abcleaner"); DPRSScore = rs.getInt("DPRSScore");DecLetterScore = rs.getInt("DecLetterScore");  DURSScore = rs.getInt("DURSScore");
				  ToverdueScore = rs.getDouble("ToverdueScore");MoverdueScore = rs.getDouble("MoverdueScore");DRejectScore = rs.getDouble("DRejectScore");AbclenerScore=rs.getDouble("AbclenerScore");DSectionScore=rs.getDouble("DSectionScore");
				  MCheckScore = rs.getDouble("MCheckScore");BasicScore = rs.getDouble("BasicScore");Cap1Score = rs.getDouble("Cap1Score");Caps2Score=rs.getDouble("Caps2Score");Cap3Score=rs.getDouble("Cap3Score");RcapScore=rs.getDouble("RcapScore");
				  DPRS = rs.getString("DPRS"); Decletter = rs.getString("Decletter");DURS = rs.getString("DURS");drivblacklist= rs.getInt("DriverBalcklist");inducteddrivers = rs.getInt("QIDriver");
				  DYD1 = rs.getInt("YearDue1");DQD1 = rs.getInt("QuarterDue1"); DQC1 = rs.getInt("QuarterCompleted1");DO1 = rs.getInt("Overdue1");DYC1 = rs.getInt("YearCompleted1");
				  DYD2 = rs.getInt("YearDue2");DQD2 = rs.getInt("QuarterDue2"); DQC2 = rs.getInt("QuarterCompleted2");DO2 = rs.getInt("Overdue2");DYC2 = rs.getInt("YearCompleted2");
				  DYD3 = rs.getInt("YearDue3");DQD3= rs.getInt("QuarterDue3"); DQC3 = rs.getInt("QuarterCompleted3");DO3 = rs.getInt("Overdue3");DYC3 = rs.getInt("YearCompleted3");
				  DYD4 = rs.getInt("YearDue4");DQD4 = rs.getInt("QuarterDue4"); DQC4 = rs.getInt("QuarterCompleted4");DO4 = rs.getInt("Overdue4");DYC4 = rs.getInt("YearCompleted4");
				  DYD5 = rs.getInt("YearDue5");DQD5 = rs.getInt("QuarterDue5"); DQC5 = rs.getInt("QuarterCompleted5");DO5 = rs.getInt("Overdue5");DYC5 = rs.getInt("YearCompleted5");
				  DYD6 = rs.getInt("YearDue6");DQD6 = rs.getInt("QuarterDue6"); DQC6 = rs.getInt("QuarterCompleted6");DO6 = rs.getInt("Overdue6");DYC6 = rs.getInt("YearCompleted6");
			  }
			  
			  int Routes = 0,tottrips2 = 0,JRMroute = 0,AdhToJRM= 0,ZeroDVITrips = 0,VioInstances = 0,JRMReview = 0,requestDMC = 0;
			  int JRMDScore = 0,DevApprScore = 0,VioMonitorScore = 0;
			  double AvgDDVI = 0,AdhToJRMScore = 0,ZeroDVIScore = 0,JSectionScore = 0;
			  String JRMDS = "No",DevAppr = "No",VioMonitorS = "No";
			  sql = "select * from db_gps.t_journeyevaluate where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
			   rs = st.executeQuery(sql);
			  if(rs.next())
			  {
				  Routes = rs.getInt("Routes");tottrips2 = rs.getInt("Trips"); JRMroute = rs.getInt("JRMroute");AdhToJRM = rs.getInt("AdhToJRM");  ZeroDVITrips = rs.getInt("ZeroDVITrips");VioInstances = rs.getInt("VioInstances");  
				  JRMReview = rs.getInt("JRMReview");requestDMC = rs.getInt("requestDMC"); 
				  AvgDDVI = rs.getDouble("AvgDDVI");AdhToJRMScore = rs.getDouble("AdhToJRMScore");ZeroDVIScore = rs.getDouble("ZeroDVIScore");JRMDScore=rs.getInt("JRMDScore");DevApprScore=rs.getInt("DevApprScore");
				  VioMonitorScore = rs.getInt("VioMonitorScore");JSectionScore = rs.getDouble("JSectionScore");
				  JRMDS = rs.getString("JRMDS"); DevAppr = rs.getString("DevAppr");VioMonitorS = rs.getString("VioMonitorS");
			  }
			  
			  int tottrips3 = 0,NoDamageTrips = 0,DamageGoods= 0,Stoppage = 0,VioAlert = 0,VioClosed = 0,QIncident = 0,PolicyDocScore = 0;
			  double NoDamageScore = 0,StopScore = 0,LAClosureScore = 0,PSectionScore = 0;
			  String PolicyDoc = "No";
			  sql = "select * from db_gps.t_processevaluate where Transporter = '"+transporter+"' and Quarter = '"+quarter+"'  and  AuditYear = '"+year+"' ";
			   rs = st.executeQuery(sql);
			  if(rs.next())
			  {
				  tottrips3 = rs.getInt("Trips"); NoDamageTrips = rs.getInt("NoDamageTrips");DamageGoods = rs.getInt("DamageGoods");Stoppage = rs.getInt("Stoppage");VioAlert = rs.getInt("VioAlert");  
				  VioClosed = rs.getInt("VioClosed");QIncident = rs.getInt("QIncident");PolicyDocScore = rs.getInt("PolicyDocScore");PolicyDoc = rs.getString("PolicyDoc"); 
				  NoDamageScore = rs.getDouble("NoDamageScore");StopScore = rs.getDouble("StopScore");LAClosureScore = rs.getDouble("LAClosureScore");PSectionScore=rs.getDouble("PSectionScore");
			  }
			  %>
		<div id="mytable">
		<table>
		<tr align="right">
			<td colspan="3" align="right">
				<a href="#" style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> 
				<img src="images/print.jpg" width="15px" height="15px" style="border-style: none">
				</a>		
			</td>
		
		</tr>
		</table>	  
		<form  enctype="multipart/form-data" method="get" style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
			  <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" style="cursor:pointer;"  onclick="javascript: try{showtab('1');}catch(e){alert(e);}" ><font  color="#025570" style="font-size: 15px;"> <b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;" id="summinus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;display: none;" id="sumplus">
			   
			   Summary</b></font></td>
			  </tr>
			  <tr id="summary">
			  
			  <td align="center" valign="top">
			  <input id= "showsummary" value="1" type="hidden"></input>
			  <table border="0" width="50%" align="center" style="margin-left: 15px;">
			  <tr>
			  <td  align="left" > <label class="description" for="element_9"><font size="2"><b>Name :</b></font></label></td>
			  <td  align="left" > <font size="2">
			   <input id="Name" name="Name" class="element text medium" type="text"  value="<%=Name%>" style="width: 150px;" onblur="checkvalidity4('Name','1')"></input>
			 </font></td>
			  </tr>
			  <tr>
			  <td  align="left" > <label class="description" for="element_9"><font size="2"><b>Location :</b></font></label></td>
			  <td  align="left" > <font size="2">
 			 <input id="location" name="location" class="element text medium" type="text"  value="<%=location%>" style="width: 150px;"  onblur="checkvalidity4('location','1')"></input>
			</font></td>
			  </tr>
			  <tr>
			  <td  align="left" > <label class="description" for="element_9"><font size="2"><b>Quarter :</b></font></label></td>
			  <td  align="left" > <label class="description" for="element_9"><font size="2"><%=monthquarter %></font></label></td>
			  </tr>
			  <tr>
			  <td  align="left" ><label class="description" for="element_9"> <font size="2"><b>Date of Audit :</b></font></label></td>
			  <td  align="left" > <font size="2">
			 <input id="data1" name="data1" class="element text medium" type="text"  value="<%=auditdate %>" style="width: 150px;"></input>
			 <script type="text/javascript">
  			Calendar.setup(
    		{
      			inputField  : "data1",         // ID of the input field
     			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    		}
 			 );
		</script>
			 </font></td>
			  </tr>
			  <tr>
			  <td  align="left" > <label class="description" for="element_9"><font size="2"><b>Audit Done by :</b></font></label></td>
			  <td  align="left" > <font size="2">
				<input id="auditby" name="auditby" class="element text medium" type="text"  value="<%=auditby %>" style="width: 150px;" onblur="checkvalidity4('auditby','1')"></input>
				</font></td>
			  </tr>
			   <tr>
			  <td  align="left" > <label class="description" for="element_9"><font size="2"><b>Reviewed by :</b></font></label></td>
			  <td  align="left" > <font size="2">
			  <input id="reviewby" name="reviewby" class="element text medium" type="text"  value="<%=Reviewby %>" style="width: 150px;" onblur="checkvalidity4('reviewby','1')"></input>
			  </font></td>
			  </tr>
			  </table>
			  </td>
			  </tr>
			  <tr  id="totincenscore"  align="center">
			   <td colspan="2" align="center"><br>
			    <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black" onclick="savesummary();"/>
			   </td>
			   </tr>
			  </table>
			  </td></tr>
			  </table></div></form>
			  <br>
			  <form   enctype="multipart/form-data" method="get"  style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
			  <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" onclick="showtab('2');" style="cursor:pointer;"> <font  color="#025570" style="font-size: 15px;"><b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;display: none;" id="vehminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;" id="vehplus">
			   
			   Vehicle Assess</b></font></td>
			  </tr>
			  <tr id="vehicleaccess" style="display: none;">
			  <td align="center" colspan="2">
			    <input id= "showvehicle" value="0" type="hidden"></input>
			   <table border="0" width="100%" align="center" cellpadding="0" cellspacing="0"  style="width: 780px;">
		  <tr> 
		   <td  align="center" valign="middle" style="width: 500px;">
		   <br>
		  <table border="1" width="100%" align="center" cellpadding="0" cellspacing="0"  style="width: 350px;">
		  <tr> 
		  <td  align="center" valign="middle">
			  <table border="0" width="100%" align="center" style="width: 390px;">
			  <tr>
			  <td  align="center"><label class="description" for="element_9"><font size="2"><b>VEHICLE</b></font></label></td>
			  <td></td>
			  </tr>
				   <tr>
					  <td style="width: 260px;">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"> 1) Total no. of vehicles in the<br>&nbsp;&nbsp;&nbsp;&nbsp;Castrol system for the quarter </font></label>
					 </td><td  align="left" valign="top">
					   
						 <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="totvehicle"><%=totvehicles %></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 260px;">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">2) Total no. of trips in the quarter</font></label>
					   </td><td align="left" valign="top">
					   		 <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="tottrips"><%=tottrips%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 260px;">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">3) Total no. of trips with First<br>&nbsp;&nbsp;&nbsp;&nbsp;Time Pass in the quarter</font></label>
					   </td><td  align="left" valign="top">
					    
					   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="vehftpass"><%=FTPTrips %></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 260px;">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">4) Total Vehicle First Time Pass<br>&nbsp;&nbsp;&nbsp;&nbsp;Rate (%)</font></label>
					   </td><td  align="left" valign="top">
					   <%
					
					   if(tottrips > 0)
					   {
						   VFTPRate = (FTPTrips/(double)tottrips)*100;
						   String VFTPRate1 = VFTPRate+"";
							 System.out.println("VFTPRateScore1  "+VFTPRate1);
							 if(VFTPRate1.contains("."))
							 {
								String token1 = VFTPRate1.substring(0,VFTPRate1.indexOf("."));
								String token2 = VFTPRate1.substring(VFTPRate1.indexOf(".")+1,VFTPRate1.length());
								//System.out.println("token[0]  "+token1);
								// System.out.println("token[1]  "+token2);
								if(token2.length() > 2)
								{
									// System.out.println("token[0]  "+token1);
									// System.out.println("token[1]  "+token1);
									VFTPRate = Double.parseDouble(token1+"."+token2.substring(0,2));
								}
							 }
					   }
					   %>
					   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"  id="vehftpassrate"><%=VFTPRate %>%</font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 260px;">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">5) Vehicle FTPR Record (Register /<br>&nbsp;&nbsp;&nbsp;&nbsp;Excel Sheet) present?</font></label>
					   </td><td  align="left" valign="top">
					<font size="2" face="Arial"><select name="FTPR" id="FTPR" style='width: 100px;' onchange="getScore(1);">
				<option value="No" <% if(VFTPRR.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				<option value="Yes" <% if(VFTPRR.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{} %>>Yes</option>
				</select>
				</font>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 260px;">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">6) Updated Register / Excel sheet<br>&nbsp;&nbsp;&nbsp;&nbsp;of Vehicles present?</font></label>
					   </td><td  align="left" valign="top">
					   <font size="2" face="Arial"><select name="UFTPR" id="UFTPR" style='width: 100px;' onchange="getScore(2);">
				<option value="No" <% if(UFTPRR.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				<option value="Yes" <% if(UFTPRR.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{} %> >Yes</option>
				</select>
				</font>
					</td>
				  </tr>
			  </table>
			  <br>
			  </td> </tr></table>
			 </td>
			  <td valign="middle" align="center" style="width: 260px;">
			  <br>
			   <table border="1"  align="center" cellpadding="0" cellspacing="0"  style="width: 240px;">
			  <tr>
			  <td align="center"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Parameter</b></font></label></td>
				<td align="center"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Quarter Score</b></font></label></td>
				<td align="center"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Max Score</b></font></label></td>
			  </tr>
			  <tr>
			  <td align="left"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Vehicle FTP Rate</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="VFTPRate">
			  <%
			  VFTPRateScore= (VFTPRate/(double)100)*VehicleFTPRate;
			  String VFTPRateScore1 = VFTPRateScore+"";
			 // System.out.println("VFTPRateScore1  "+VFTPRateScore1);
			 if(VFTPRateScore1.contains("."))
			 {
				String token1 = VFTPRateScore1.substring(0,VFTPRateScore1.indexOf("."));
				String token2 = VFTPRateScore1.substring(VFTPRateScore1.indexOf(".")+1,VFTPRateScore1.length());
				//System.out.println("token[0]  "+token1);
				// System.out.println("token[1]  "+token2);
				if(token2.length() > 2)
				{
					// System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token1);
					VFTPRateScore = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			  %>
			  <%=VFTPRateScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><%=VehicleFTPRate %></font></label>
			  </td>
			  </tr>
			    <tr>
			    <td align="left"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Vehicle FTPR Record Register Present</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="VFTPRR"><%=VFTPRRScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MVFTPRR"><%=VehicleFTPRRecord %></font></label></td>
			  </tr>
			    <tr>
			    <td align="left"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Updated Vehicle Register Present</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Vpresent"><%=UFTPRRScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MVpresent"><%=VehiclespresentSheet %></font></label></td>
			  </tr>
			  <tr>
			    <td align="left"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Vehicle Maintenance, Installations and Documents Renewal</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Vcompletedscore"><%=Completedscore%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Mcompletedscore"><%=Completedscore%></font></label></td>
			  </tr>
			   </table>
			   <br>
			  </td>
			  </tr>
			  <tr>
			  <td align="center" style="width: 500px;" valign="middle" colspan="2">
			  <br>
			  <table border="1"  align="center" cellpadding="0" cellspacing="0" style="width: 500px;">
			  <tr>
				<td rowspan="2" align="center" style="width: 130px;"><label class="description" for="element_9" ><font size="2"><b>Parameter</b></font></label></td>
			  	<td colspan="5" align="center"><label class="description" for="element_9" ><font size="2"><b>Count of Vehicles </b></font></label></td>
			  </tr>
			  <tr>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Due in the year</b></font></label></td>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Due in this quarter</b></font></label></td>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Completed in this quarter</b></font></label></td>
			  <td  style="width: 50px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Overdue</b></font></label></td>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Total Completed YTD</b></font></label></td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Vehicle Maintenance service as per AMC or equivalent</font>
			   </label>
			   </td>
			   <td align="center">
			    <input id="YD1" name="YD1" class="element text medium" type="text"  value="<%=YD1%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD1','1')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD1" name="QD1" class="element text medium" type="text"  value="<%=QD1%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD1','1')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC1" name="QC1" class="element text medium" type="text"  value="<%=QC1%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC1','1')"></input> 
			   </td >
			      <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O1"><%=O1%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O1" name="O1" class="element text medium" type="text"  value="< %=O1%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O1','1')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC1" name="YC1" class="element text medium" type="text"  value="<%=YC1%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC1','1')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Vehicle Documents Renewal (PUC, Goods Carrier, RTO Docs)</font>
			   </label>
			   </td>
			    <td align="center">
			    <input id="YD2" name="YD2" class="element text medium" type="text"  value="<%=YD2%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD2','2')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD2" name="QD2" class="element text medium" type="text"  value="<%=QD2%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD2','2')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC2" name="QC2" class="element text medium" type="text"  value="<%=QC2%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC2','2')"></input> 
			   </td >
			     <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O2" ><%=O2%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O2" name="O2" class="element text medium" type="text"  value="< %=O2%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O2','2')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC2" name="YC2" class="element text medium" type="text"  value="<%=YC2%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC2','2')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td valign="top">
			  
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Vehicle PIMC </font>
			   </label>
			   <br></br>
			   </td>
			  <td align="center">
			    <input id="YD3" name="YD2" class="element text medium" type="text"  value="<%=YD3%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD3','3')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD3" name="QD3" class="element text medium" type="text"  value="<%=QD3%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD3','3')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC3" name="QC3" class="element text medium" type="text"  value="<%=QC3%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC3','3')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O3" ><%=O3%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O3" name="O3" class="element text medium" type="text"  value="< %=O3%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O3','3')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC3" name="YC3" class="element text medium" type="text"  value="<%=YC3%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC3','3')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Bulk Tanker Maintenance </font>
			   </label>
			   <br></br>
			   </td>
			   <td align="center">
			    <input id="YD4" name="YD4" class="element text medium" type="text"  value="<%=YD4%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD4','4')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD4" name="QD4" class="element text medium" type="text"  value="<%=QD4%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD4','4')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC4" name="QC4" class="element text medium" type="text"  value="<%=QC4%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC4','4')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O4" ><%=O4%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O4" name="O4" class="element text medium" type="text"  value="< %=O4%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O4','4')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC4" name="YC4" class="element text medium" type="text"  value="<%=YC4%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC4','4')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">ABS installations</font>
			   </label>
			   <br></br>
			   </td>
			   <td align="center">
			    <input id="YD5" name="YD5" class="element text medium" type="text"  value="<%=YD5%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD5','5')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD5" name="QD5" class="element text medium" type="text"  value="<%=QD5%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD5','5')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC5" name="QC5" class="element text medium" type="text"  value="<%=QC5%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC5','5')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O5" ><%=O5%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O5" name="O5" class="element text medium" type="text"  value="< %=O5%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O5','5')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC5" name="YC5" class="element text medium" type="text"  value="<%=YC5%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC5','5')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Camera installations</font>
			   </label>
			   <br></br>
			   </td>
			  <td align="center">
			    <input id="YD6" name="YD6" class="element text medium" type="text"  value="<%=YD6%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD6','6')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD6" name="QD6" class="element text medium" type="text"  value="<%=QD6%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD6','6')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC6" name="QC6" class="element text medium" type="text"  value="<%=QC6%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC6','6')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O6" ><%=O6%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O6" name="O6" class="element text medium" type="text"  value="< %=O6%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O6','6')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC6" name="YC6" class="element text medium" type="text"  value="<%=YC6%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC6','6')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">JRM Device installations</font>
			   </label>
			   <br></br>
			   </td>
			  <td align="center">
			    <input id="YD7" name="YD7" class="element text medium" type="text"  value="<%=YD7%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD7','7')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD7" name="QD7" class="element text medium" type="text"  value="<%=QD7%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD7','7')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC7" name="QC7" class="element text medium" type="text"  value="<%=QC7%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC7','7')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O7" ><%=O7%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O7" name="O7" class="element text medium" type="text"  value="< %=O7%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O7','7')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="YC7" name="YC7" class="element text medium" type="text"  value="<%=YC7%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC7','7')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td >
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Vehicle Maintenance required after any incident/s</font>
			   </label>
			   </td>
			   <td align="center">
			    <input id="YD8" name="YD8" class="element text medium" type="text"  value="<%=YD8%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YD8','8')"></input> 
			   </td>
			   <td align="center">
			    <input id="QD8" name="QD8" class="element text medium" type="text"  value="<%=QD8%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QD8','8')"></input> 
			   </td >
			   <td align="center">
			    <input id="QC8" name="QC8" class="element text medium" type="text"  value="<%=QC8%>" style="width: 50px;text-align: right;" onblur="checkvalidity('QC8','8')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "O8" ><%=O8%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="O8" name="O8" class="element text medium" type="text"  value="< %=O8%>" style="width: 50px;text-align: right;" onblur="checkvalidity('O8','8')"></input> -->
<!--			   </td>-->
			   <td align="center">
			   <input id="YC8" name="YD7" class="element text medium" type="text"  value="<%=YD7%>" style="width: 50px;text-align: right;" onblur="checkvalidity('YC8','8')"></input> 
			   </td>
			  </tr>
			  </table>
			  <br>
			  </td>
			  </tr>
			  <tr>
			  <td valign="top" align="center" style="width: 150px;" colspan="2">
			  <br>
			   <table border="1"  align="center" cellpadding="0" cellspacing="0" style="width: 200px;">
			  <tr>
				<td align="center" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Section Score</b></font></label></td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Vsectionscore"><%=Vsectionscore%></font></label>
				</td>
			  </tr>
			  <tr>
				<td align="center"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Max Score</b></font></label></td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><%=SectionScore%></font></label></td>
			  </tr>
			  </table>
			  <br>
			  </td>
			  </tr>
			  </table>
			  <table border="0" width="100%" align="center" >
		  	  <tr> 
			  <td  align="center">
			  <br>
			  <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black" onclick="savevehicle();"/>
			  </td>
			  </tr>
			  </table>
			  <script type="text/javascript">
			  calculatepoints();
			  </script>
			  </td>
			  </tr>
			  </table>		  
		  </td>
		  </tr>
		  </table>
		  </div>
		  </form>
		  <br>
		  <form   enctype="multipart/form-data" method="get"  style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
			  <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" onclick="showtab('3');" style="cursor:pointer;"> <font  color="#025570" style="font-size: 15px;"><b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;display: none;" id="drivminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;" id="drivplus">
			   
			   Driver Assess</b></font></td>
			  </tr>
			  <tr id="driveraccess" style="display: none;">
			  <td align="center" colspan="2">
			    <input id= "showdriver" value="0" type="hidden"></input>
			   <table border="0"  align="center" cellpadding="0" cellspacing="0" style="width: 780px;">
		  <tr> 
		  <td  align="center" valign="middle" style="width: 500px;">
		   <br>
		  <table border="1" width="100%" align="center" cellpadding="0" cellspacing="0" >
		  <tr> 
		  <td  align="center" valign="middle">
			  <table border="0" width="100%" align="center" style="width: 500px;">
			  <tr>
		  <td  align="center"> <label class="description" for="element_9"><font size="2"><b>DRIVER</b></font></label></td>
		   <td></td>
		   </tr>
		   <tr>
					  <td style="width: 310px;" valign="top">
					  <input id="quarter" name="quarter"  type="hidden"  value="1"  ></input> 
					  <input id="audityear" name="audityear"  type="hidden"  value="2013"  ></input> 
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">1) &nbsp;Total no. of drivers in the Castrol system</font></label>
					   </td><td  align="left" valign="top">
						 <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="totdrivers"><%=Drivers %></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">2)  &nbsp;No. of Drivers inducted in this quarter</font></label>
					   </td><td  align="left" valign="top">
						 <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="qdrivers"><%=inducteddrivers %></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">3) &nbsp;No. of Drivers absent in the system<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for > 6months</font></label>
					   </td><td  align="left" valign="top">
					   
						 <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Adrivers"><%=Abdrivers%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">4) &nbsp;No. of instances of Driver training overdue<br>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;in this quarter</font></label>
					   </td><td  align="left" valign="top">
						 <input id="Toverdue" name="Toverdue"  class="element text medium" type="text"  value="<%=Toverdue %>" style="width: 100px;text-align: right;" onblur="checkvalidity1('Toverdue','7')"></input> 
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">5) &nbsp;No. of instances of Driver medical overdue<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in this quarter</font></label>
					   </td><td  align="left" valign="top">
						 <input id="Moverdue" name="Moverdue"  class="element text medium" type="text"  value="<%=Moverdue %>" style="width: 100px;text-align: right;" onblur="checkvalidity1('Moverdue','8')"></input> 
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;height: 35px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">6) &nbsp;No. of instances of Driver rejection at location<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in this quarter</font></label>
					   </td><td  align="left" valign="top" style="height: 35px;">
					 
						 <label class="description" for="element_9" id="Rdrivers" style="margin-left: 2px;margin-right: 2px;"><font size="2"><%=RejectedDriver%></font></label>
						
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">7) &nbsp;No. of instances of Cleaner absence</font></label>
					   </td><td  align="left" valign="top">
						 <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="cleanerabsent"><%=Abcleaner%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">8) &nbsp;Total instances of driver blacklisting, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;counselling or suspension</font></label>
					   </td><td  align="left" valign="top">
						<input id="Drivblacklist" name="Drivblacklist"  class="element text medium" type="text"  value="<%=drivblacklist%>" style="width: 100px;text-align: right;" onblur="checkvalidity1('Drivblacklist','8')"></input> 
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">9) &nbsp;Updated Register / Excel sheet of<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Drivers present?</font></label>
					   </td><td  align="left" valign="top">
					  <font size="2" face="Arial"><select name="DPS" id="DPS" style='width: 100px;' onchange="getScore1(1);">
					  <option value="No" <% if(DPRS.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %> >No</option>
				      <option value="Yes"  <% if(DPRS.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{ } %> >Yes</option>
					  </select>
					  </font>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">10) &nbsp;Have all drivers inducted in the quarter come<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;with declaration letter?</font></label>
					   </td><td  align="left" valign="top">
					   <font size="2" face="Arial"><select name="Decletter" id="Decletter" style='width: 100px;' onchange="getScore1(2);">
				<option value="No" <% if(Decletter.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %> >No</option>
				<option value="Yes" <% if(Decletter.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{ } %>  >Yes</option>
				</select>
				</font>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">11) Updated Register / Excel sheet of PPEs<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;issued to Tanker Drivers present with<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;maintenance and replacement schedules?</font></label>
					   </td><td  align="left" valign="top">
					   <font size="2" face="Arial"><select name="DUR" id="DUR" style='width: 100px;' onchange="getScore1(3);">
				<option value="No" <% if(DURS.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				<option value="Yes" <% if(DURS.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{ } %> >Yes</option>
				</select>
				</font>
					</td>
				  </tr>
		  </table>
		  </td></tr></table>
		  </td>
		  <td valign="middle" align="center" style="width: 260px;">
		  <br>
		  <table border="1"  align="center" cellpadding="0" cellspacing="0"  style="width: 220px;">
			  <tr>
			  <td align="center"><label class="description" for="element_9" ><font size="2"><b>Parameter</b></font></label></td>
				<td align="center"><label class="description" for="element_9" ><font size="2"><b>Quarter Score</b></font></label></td>
				<td align="center"><label class="description" for="element_9" ><font size="2"><b>Max Score</b></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Training OverDue </font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="DTO"><%=Toverdue %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MDTO"><%= ToverDue%></font></label>
			  </td>
			  </tr>
			    <tr>
			    <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Medical OverDue </font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="DMO"><%=Moverdue %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MDMO"><%=MoverDue %></font></label></td>
			  </tr>
			    <tr>
			    <td align="left"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Driver Rejection </font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="driverreject"><%=DRejectScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Mdriverreject"><%=DriverReject %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Cleaner Absent </font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Acleaner">
			  <%
			
			  if(tottrips1 > 0)
			  {
				  AbclenerScore = ((tottrips1 - Abcleaner)/(double)tottrips1)*Cleanerabsent;
				  String AbclenerScore1 = AbclenerScore+"";
				//  System.out.println("AbclenerScore1  "+AbclenerScore1);
				 if(AbclenerScore1.contains("."))
				 {
					String token1 = AbclenerScore1.substring(0,AbclenerScore1.indexOf("."));
					String token2 = AbclenerScore1.substring(AbclenerScore1.indexOf(".")+1,AbclenerScore1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						AbclenerScore = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
			  }
			  %>
			  <%=AbclenerScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MAcleaner"><%=Cleanerabsent %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Updated Register of Driver Present </font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="drivpresent"><%=DPRSScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MDPS"><%=DPS %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Driver Inducted with Declaration Letter</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="letter"><%=DecLetterScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MDecletter"><%=DecLetter %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Updated Register Present </font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="UpdatedRegister"><%=DURSScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MDUR"><%=DUR %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Medical Check</font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "MCheck"><%=MCheckScore%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "MMCheck"><%=medicalcheck%></font></label></td>
			  </tr>
			   <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Basic Module</font></label>
			  </td>
			 <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Basic"><%=BasicScore%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "MBasic"><%=basic%></font></label></td>
			  </tr>
			   <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Capsule 1</font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "cap1"><%=Cap1Score%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Mcap1"><%=cap1%></font></label></td>
			  </tr>
			   <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Capsule 2</font></label>
			  </td>
			  <td align="right" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "cap2"><%=Caps2Score%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Mcap2"><%=cap2%></font></label></td>
			  </tr>
			   <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Capsule 3</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "cap3"><%=Cap3Score%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Mcap3"><%=cap3%></font></label></td>
			  </tr>
			   <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Refresher Capsule</font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "Rcap"><%=RcapScore%></font></label>
				</td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "MRcap"><%=Rcap%></font></label></td>
			  </tr>
			   </table>
			    <br>
			
		  </td>
		  </tr>
		  <tr>
			  <td align="center" style="width: 500px;" valign="middle" colspan="2">
			  <br>
			   <table border="1"  align="center" cellpadding="0" cellspacing="0" style="width: 500px;">
			  <tr>
				<td rowspan="2" align="center" style="width: 130px;"><label class="description" for="element_9" ><font size="2"><b>Parameter</b></font></label></td>
			  	<td colspan="5" align="center"><label class="description" for="element_9" ><font size="2"><b>Count of Drivers </b></font></label></td>
			  </tr>
			  <tr>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Due in the year</b></font></label></td>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Due in this quarter</b></font></label></td>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Completed in this quarter</b></font></label></td>
			  <td  style="width: 50px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Overdue</b></font></label></td>
			  <td  style="width: 70px;" align="center"><label class="description" for="element_9" ><font size="2"><b>Total Completed YTD</b></font></label></td>
			  </tr>
			  <tr>
			   <td style="height: 35px;">
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Driver Medical Check</font>
			   </label>
			   
			   </td>
			   <td align="center">
			    <input id="DYD1" name="DYD1" class="element text medium" type="text"  value="<%=DYD1 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYD1','1')"></input> 
			   </td>
			   <td align="center">
			    <input id="DQD1" name="DQD1" class="element text medium" type="text"  value="<%=DQD1 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQD1','1')"></input> 
			   </td >
			   <td align="center">
			    <input id="DQC1" name="DQC1" class="element text medium" type="text"  value="<%=DQC1 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQC1','1')"></input> 
			   </td >
			    <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "DO1" ><%=DO1%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="DO1" name="DO1" class="element text medium" type="text"  value="< %=DO1 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DO1','1')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="DYC1" name="DYC1" class="element text medium" type="text"  value="<%=DYC1 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYC1','1')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td style="height: 35px;">
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Driver Training Basic Module</font>
			   </label>
			   </td>
			  <td align="center">
			    <input id="DYD2" name="DYD2" class="element text medium" type="text"  value="<%=DYD2 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYD2','2')"></input> 
			   </td>
			   <td align="center">
			    <input id="DQD2" name="DQD2" class="element text medium" type="text"  value="<%=DQD2 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQD2','2')"></input> 
			   </td >
			   <td align="center">
			    <input id="DQC2" name="DQC2" class="element text medium" type="text"  value="<%=DQC2 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQC2','2')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "DO2" ><%=DO2%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="DO2" name="DO2" class="element text medium" type="text"  value="< %=DO2 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DO2','2')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="DYC2" name="DYC2" class="element text medium" type="text"  value="<%=DYC2 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYC2','2')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td style="height: 35px;">
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Driver Training Capsule 1</font>
			   </label>
			   </td>
			  <td align="center">
			    <input id="DYD3" name="DYD3" class="element text medium" type="text"  value="<%=DYD3 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYD3','3')"></input> 
			   </td>
			   <td align="center">
			    <input id="DQD3" name="DQD3" class="element text medium" type="text"  value="<%=DQD3 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQD3','3')"></input> 
			   </td >
			   <td align="center">
			    <input id="DQC3" name="DQC3" class="element text medium" type="text"  value="<%=DQC3 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQC3','3')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "DO3" ><%=DO3%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="DO3" name="DO3" class="element text medium" type="text"  value="< %=DO3 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DO3','3')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="DYC3" name="DYC3" class="element text medium" type="text"  value="<%=DYC3 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYC3','3')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td style="height: 35px;">
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Driver Training Capsule 2</font>
			   </label>
			   </td>
			    <td align="center">
			    <input id="DYD4" name="DYD4" class="element text medium" type="text"  value="<%=DYD4 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYD4','4')"></input> 
			   </td>
			   <td align="center">
			    <input id="DQD4" name="DQD4" class="element text medium" type="text"  value="<%=DQD4 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQD4','4')"></input> 
			   </td >
			   <td align="center">
			    <input id="DQC4" name="DQC4" class="element text medium" type="text"  value="<%=DQC4 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQC4','4')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "DO4" ><%=DO4%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="DO4" name="DO4" class="element text medium" type="text"  value="< %=DO4 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DO4','4')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="DYC4" name="DYC4" class="element text medium" type="text"  value="<%=DYC4 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYC4','4')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td style="height: 35px;">
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Driver Training Capsule 3</font>
			   </label>
			   </td>
			   <td align="center">
			    <input id="DYD5" name="DYD5" class="element text medium" type="text"  value="<%=DYD5 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYD5','5')"></input> 
			   </td>
			   <td align="center">
			    <input id="DQD5" name="DQD5" class="element text medium" type="text"  value="<%=DQD5 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQD5','5')"></input> 
			   </td >
			   <td align="center">
			    <input id="DQC5" name="DQC5" class="element text medium" type="text"  value="<%=DQC5 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQC5','5')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "DO5" ><%=DO5%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="DO5" name="DO5" class="element text medium" type="text"  value="< %=DO5 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DO5','5')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="DYC5" name="DYC5" class="element text medium" type="text"  value="<%=DYC5 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYC5','5')"></input> 
			   </td>
			  </tr>
			  <tr>
			   <td style="height: 35px;">
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;">
			   <font size="2">Driver Training Refresher Capsule</font>
			   </label>
			   </td>
			   <td align="center">
			    <input id="DYD6" name="DYD6" class="element text medium" type="text"  value="<%=DYD6 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYD6','6')"></input> 
			   </td>
			   <td align="center">
			    <input id="DQD6" name="DQD6" class="element text medium" type="text"  value="<%=DQD6 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQD6','6')"></input> 
			   </td >
			   <td align="center">
			    <input id="DQC6" name="DQC6" class="element text medium" type="text"  value="<%=DQC6 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DQC6','6')"></input> 
			   </td >
			   <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id = "DO6" ><%=DO6%></font></label>
				</td>
<!--			   <td align="center">-->
<!--			    <input id="DO6" name="DO6" class="element text medium" type="text"  value="< %=DO6 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DO6','6')"></input> -->
<!--			   </td>-->
			   <td align="center">
			    <input id="DYC6" name="DYC6" class="element text medium" type="text"  value="<%=DYC6 %>" style="width: 50px;text-align: right;" onblur="checkvalidity1('DYC6','6')"></input> 
			   </td>
			  </tr>
			  </table>
			  <br>
		  	  </td>
		  </tr>
		   <tr>
			  <td valign="middle" align="center" style="width: 150px;" colspan="2">
			  <br>
			   <table border="1"  align="center" cellpadding="0" cellspacing="0" style="width: 200px;">
			  <tr>
				<td align="center"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Section Score</b></font></label></td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Dsectionscore"><%=DSectionScore %></font></label>
				</td>
			  </tr>
			  <tr>
				<td align="center" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Max Score</b></font></label></td>
				<td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><%=Dsectionscore%></font></label></td>
			  </tr>
			  </table>
			  <br>
			  </td>
			  </tr>
			  </table>
			  <table border="0" width="100%" align="center" >
		  	  <tr> 
			  <td  align="center">
			  <br>
			  <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black"  onclick="savedriver();" />
			  </td>
			  </tr>
			  </table>
		  </tr>
		  </table>
		  </td>
		  </tr>
		  </table>
		  <script type="text/javascript">
		  calculatepoints1();
		  </script>
		  </div></form>
		  <br>
		  <form   enctype="multipart/form-data" method="get"  style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
			  <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" onclick="showtab('4');" style="cursor:pointer;"> <font  color="#025570" style="font-size: 15px;"><b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;display: none;" id="jrnyminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;" id="jrnyplus">
			   
			   Journey Assess</b></font></td>
			  </tr>
			  <tr id="journeyaccess" style="display: none;">
			  <td align="center" colspan="2">
			    <input id= "showjourney" value="0" type="hidden"></input>
			   <table border="0" width="100%" align="center" cellpadding="0" cellspacing="0" style=" width: 780px;">
		  <tr> 
		   <td style="width: 500px;" valign="middle" align="center">
		   <br>
		  <table border="1" width="100%" align="center" cellpadding="0" cellspacing="0"  style="width: 480px;">
			  <tr>
		  <td  valign="middle" align="center">
		  
		  <table border="0" width="100%" align="center" style="width: 430px;">
			  <tr>
		  <td  align="center" style="height: 20px;"><label class="description" for="element_9" > <font size="2"><b>JOURNEY</b></font></label></td>
		   <td></td>
		   </tr>
		   <tr>
					  <td style="width: 310px;" valign="top">
					  <input id="quarter" name="quarter"  type="hidden"  value="1"  ></input> 
					  <input id="audityear" name="audityear"  type="hidden"  value="2013"  ></input> 
					  <label class="description" for="element_9" ><font size="2">&nbsp;1) &nbsp;Total no. of Unique Routes for Castrol</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2" id="totroutes"><%=Routes %></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;2) &nbsp;No. of routes for which JRM is present</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2" id="JRMroute" ><%=JRMroute %></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;3) &nbsp;No. of trips in the quarter</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2" id="tottrips2" ><%=tottrips2%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;4) &nbsp;No. of trips where the JRM route was<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adhered to in this quarter</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
							 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2"  id="AdhJRM"><%=AdhToJRM%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;5) &nbsp;No. of trips where the DVI = 0</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2" id="DVI0trip"><%=ZeroDVITrips%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;6) &nbsp;Total instances of Driving Hours violation,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Night Driving violation, Route Deviation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;& Continuous Driving in the quarter</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2"  id="Vioinst"><%=VioInstances %></font></label>
						 </td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;7) &nbsp;Average Driver DVI for this quarter</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 5px;"><font size="2" id="avgDDVI"><%=AvgDDVI%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;8) &nbsp;No. of routes for which JRM is to be<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reviewed</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					<input id="JRMReview" name="JRMReview"  class="element text medium" type="text"  value="<%=JRMReview %>" style="width: 100px;text-align: right;margin-left: 5px;" onblur="checkvalidity2('JRMReview','7')"></input> 
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;9) &nbsp;No. of routes for which JRM review<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;request was sent to DMC</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						<input id="requestDMC" name="requestDMC"  class="element text medium" type="text"  value="<%=requestDMC %>" style="width: 100px;text-align: right;margin-left: 5px;" onblur="checkvalidity2('requestDMC','7')"></input> 
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">10)&nbsp;Excel sheet of all routes with latest<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;JRM / Lane-wise JRM documents present?</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					  <font size="2" face="Arial"><select name="JRMDS" id="JRMDS" style='width: 100px;margin-left: 5px;' onchange="getScore2(1);">
					  <option value="No" <% if(JRMDS.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				      <option value="Yes" <% if(JRMDS.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{ } %>>Yes</option>
					  </select>
					  </font>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">11)&nbsp;Excel sheet / Register to maintain<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;approval for any deviation to route<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;with reasons present?</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					   <font size="2" face="Arial"><select name="DevAppr" id="DevAppr" style='width: 100px;margin-left: 5px;' onchange="getScore2(2);">
				<option value="No" <% if(DevAppr.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				<option value="Yes" <% if(DevAppr.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{} %>>Yes</option>
				</select>
				</font>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">12)&nbsp;Excel sheet / Register to monitor ND , CD,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DH, OS, RA, RD & Route Deviation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;instances, repitition, actions taken, disciplinary<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;measures present?</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					   <font size="2" face="Arial"><select name="VioMonitorS" id="VioMonitorS" style='width: 100px;margin-left: 5px;' onchange="getScore2(3);">
				<option value="No" <% if(VioMonitorS.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				<option value="Yes" <% if(VioMonitorS.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{} %>>Yes</option>
				</select>
				</font>
					</td>
				  </tr>
		  </table>
		 </td></tr></table>
		  </td>
		  <td valign="middle" align="center" style="width: 230px;">
		  <br>
		  <table border="1"  align="center" cellpadding="0" cellspacing="0"  style="margin-left: 5px;">
			  <tr>
			  <td align="center" style="height: 20px;"><label class="description" for="element_9" ><font size="2"><b>Parameter</b></font></label></td>
				<td align="center" style="height: 20px;"><label class="description" for="element_9" ><font size="2"><b>Quarter Score</b></font></label></td>
				<td align="center" style="height: 20px;"><label class="description" for="element_9" ><font size="2"><b>Max Score</b></font></label></td>
			  </tr>
			  <tr>
			   <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Total Trips with Adherence to JRM</font></label></td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="JRMAdh">
			  <%
			  if(tottrips2 > 0)
			  {
				  AdhToJRMScore = (AdhToJRM/(double)tottrips2)*JRMAdh;
				  String AdhToJRMScore1 = AdhToJRMScore+"";
				//  System.out.println("AdhToJRMScore1  "+AdhToJRMScore1);
				 if(AdhToJRMScore1.contains("."))
				 {
					String token1 = AdhToJRMScore1.substring(0,AdhToJRMScore1.indexOf("."));
					String token2 = AdhToJRMScore1.substring(AdhToJRMScore1.indexOf(".")+1,AdhToJRMScore1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						AdhToJRMScore = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
			  }
			  %>
			  <%=AdhToJRMScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MJRMAdh" ><%= JRMAdh%></font></label>
			  </td>
			  </tr>
			    <tr>
			    <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Zero DVI Trips</font></label></td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="zerodvi" >
			  <%
			  if(tottrips2 > 0)
			  {
				  ZeroDVIScore = (ZeroDVITrips/(double)tottrips2)*ZeroDVI;
				  String ZeroDVIScore1 = ZeroDVIScore+"";
				//  System.out.println("ZeroDVIScore1  "+ZeroDVIScore1);
				 if(ZeroDVIScore1.contains("."))
				 {
					String token1 = ZeroDVIScore1.substring(0,ZeroDVIScore1.indexOf("."));
					String token2 = ZeroDVIScore1.substring(ZeroDVIScore1.indexOf(".")+1,ZeroDVIScore1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						ZeroDVIScore = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }
			  }
			  %>
			  <%=ZeroDVIScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Mzerodvi" ><%=ZeroDVI %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >JRM Document Sheet Present</font></label></td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="JRMD" ><%=JRMDScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MJRMD" ><%=JRMDoc%></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Sheet of approval of deviation to route present</font></label></td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="DevApprovalS" ><%=DevApprScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MDevApprovalS" ><%=DevApproval %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Sheet to monitor Violations and action taken on it present</font></label></td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="VioMonitor" ><%=VioMonitorScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MVioMonitor" ><%=VioMonitor %></font></label></td>
			  </tr>
			   </table>
			   <br>
		  </td>
		  </tr>
		  <tr>
		  <td valign="middle" align="center" style="width: 150px;" colspan="2">
		  <br>
			   <table border="1"  align="center" cellpadding="0" cellspacing="0" style="width: 200px;">
			  <tr>
				<td align="center" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Section Score</b></font></label></td>
				<td align="right" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Jsectionscore"><%=JSectionScore %></font></label>
				</td>
			  </tr>
			  <tr>
				<td align="center" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Max Score</b></font></label></td>
				<td align="right" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><%=MJSectionScore%></font></label></td>
			  </tr>
			  </table>
			   <br>
			  </td>
			 
		  </tr>
		  </table>
		    <table border="0" width="100%" align="center" >
		 <tr>
			  <td colspan="3" align="center">
			  <br>
			  <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black"   onclick="savejourney();"  />
			  </td>
		  </tr>
		  </table>
		  </td>
		 </tr>
		 </table>
		 </td>
		 </tr>
		 </table>
		  <script type="text/javascript">
		  calculatepoints2();
		  </script>
		 </div>
		 </form>
		  <br>
		 <form   enctype="multipart/form-data" method="get"  style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
			  <table border="0" width="100%" align="center"  >
			  <tr>
			   <td  align="left" colspan="2" onclick="showtab('5');" style="cursor:pointer;"> <font  color="#025570" style="font-size: 15px;"><b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;display: none;" id="procminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;" id="procplus">
			   
			   Process Assess</b></font></td>
			  </tr>
			  <tr id="processaccess" style="display: none;">
			  <td align="center" colspan="2">
			    <input id= "showprocess" value="0" type="hidden"></input>
			   <table border="0" width="100%" align="center" cellpadding="0" cellspacing="0" style="width: 780px;">
		  <tr> 
		  <td style="width: 500px;" valign="middle" align="center">
		  <br>
		  <table border="1" width="100%" align="center" cellpadding="0" cellspacing="0" style="width: 480px;">
		  <tr> 
		  <td  valign="top" align="center">
		  <table border="0"  align="center"  style="width: 410px;">
			  <tr>
		  <td  align="center" > <label class="description" for="element_9" ><font size="2"><b>PROCESS</b></font></label></td>
		   <td></td>
		   </tr>
		   <tr>
		  <td  align="left" colspan="2"> <label class="description" for="element_9" ><font size="2"><b>1) Load Securing</b></font></label></td>
		   </tr>
		   <tr>
					  <td style="width: 310px;" valign="top">
					  <input id="quarter" name="quarter"  type="hidden"  value="1"  ></input> 
					  <input id="audityear" name="audityear"  type="hidden"  value="2013"  ></input> 
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;a) Total no. of Trips for Castrol</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
							 <label class="description" for="element_9" style="margin-left: 3px;"><font size="2" id="tottrips3"><%=tottrips3%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;b) Total no. of no-damage Trips</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					  <input id="NoDamage" name="NoDamage"  class="element text medium" type="text"  value="<%=NoDamageTrips %>" style="width: 100px;text-align: right;margin-left: 3px;" onblur="checkvalidity3('NoDamage','1')"></input> 
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;c) Total no. of Trips with damaged goods</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					  <input id="DamageGoods" name="DamageGoods"  class="element text medium" type="text"  value="<%=DamageGoods %>" style="width: 100px;text-align: right;margin-left: 3px;" onblur="checkvalidity3('DamageGoods','1')"></input> 
					</td>
				  </tr>
				   <tr>
		  <td  align="left" colspan="2" style="height: 30px;" valign="bottom"><label class="description" for="element_9" > <font size="2"><b>2) Unwarranted Stoppages</b></font></label></td>
		   </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;a) Total no. of Trips with unwarranted<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;stoppages (> 4hours)</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
							 <label class="description" for="element_9" style="margin-left: 3px;"><font size="2" id="Stoppage"><%=Stoppage%></font></label>
					</td>
				  </tr>
				  <tr>
		  <td  align="left" colspan="2" style="height: 30px;" valign="bottom"><label class="description" for="element_9" > <font size="2"><b>3) Closure of Leading Alerts/Triggers on Transworld</b></font></label></td>
		   </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;a) Total Violation Alerts on Transworld<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Intervention Report</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 3px;"><font size="2"  id="VioAlert"><%=VioAlert%></font></label>
					</td>
				  </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;b) Total Violation Alerts Closed on Time</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
						 <label class="description" for="element_9" style="margin-left: 3px;"><font size="2" id="VioClosed"><%=VioClosed %></font></label>
					</td>
				  </tr>
				  <tr>
		  <td  align="left" colspan="2" style="height: 30px;" valign="bottom"><label class="description" for="element_9" > <font size="2"><b>4) Incidents in the Quarter</b></font></label></td>
		   </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;a) Total no. of Incidents in the Quarter</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					     <input id="QIncident" name="QIncident"  class="element text medium" type="text"  value="<%=QIncident %>" style="width: 100px;text-align: right;margin-left: 3px;" onblur="checkvalidity3('QIncident','1')"></input> 
					</td>
				  </tr>
				  <tr>
		  <td  align="left" colspan="2" style="height: 30px;" valign="bottom"><label class="description" for="element_9" > <font size="2"><b>5) Policy Documents</b></font></label></td>
		   </tr>
				  <tr>
					  <td style="width: 310px;" valign="top">
					  <label class="description" for="element_9" ><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;a) Night Driving, SeatBelts, Mobile Phone<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and Alcohol & Drug Policy Document -<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Understood & Signed by Drivers?</font></label>
					   </td><td  align="left" valign="top" style="width: 120px;">
					  <font size="2" face="Arial"><select name="PolicyDoc" id="PolicyDoc" style='width: 100px;margin-left: 3px;' onchange="getScore3(1);">
					  <option value="No" <% if(PolicyDoc.equalsIgnoreCase("No")){%>selected="selected"<%}else{%>selected="selected"<% } %>>No</option>
				      <option value="Yes" <% if(PolicyDoc.equalsIgnoreCase("Yes")){%>selected="selected"<%}else{} %> >Yes</option>
					  </select>
					  </font>
					</td>
				  </tr>
		  </table>
		  <br>
		    </td></tr></table>
		  </td>
		  <td valign="middle" align="center"  style="width: 230px;">
		    <br>
		  <table border="1"  align="center" cellpadding="0" cellspacing="0"   style="width: 200px;">
			  <tr>
			  <td align="center" style="height: 20px;width: 100px;"><label class="description" for="element_9" ><font size="2"><b>Parameter</b></font></label></td>
				<td align="center" style="height: 20px;width: 50px;"><label class="description" for="element_9" ><font size="2"><b>Quarter Score</b></font></label></td>
				<td align="center" style="height: 20px;width: 50px;"><label class="description" for="element_9" ><font size="2"><b>Max Score</b></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Load Securing</font></label></td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="NoDamageScore" >
			  <%
			 if(tottrips3 > 0)
			  {
				 NoDamageScore = (NoDamageTrips/(double)tottrips3)*LoadSecure;
			//	 NoDamageScore = Double.parseDouble(nfrating.format(NoDamageScore));
			 String NoDamageScore1 = NoDamageScore+"";
			//  System.out.println("NoDamageScore1  "+NoDamageScore1);
			 if(NoDamageScore1.contains("."))
			 {
				String token1 = NoDamageScore1.substring(0,NoDamageScore1.indexOf("."));
				String token2 = NoDamageScore1.substring(NoDamageScore1.indexOf(".")+1,NoDamageScore1.length());
				//System.out.println("token[0]  "+token1);
				// System.out.println("token[1]  "+token2);
				if(token2.length() > 2)
				{
					// System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token1);
					NoDamageScore = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			 }
			  %>
			  <%=NoDamageScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MNoDamageScore" ><%= LoadSecure%></font></label>
			  </td>
			  </tr>
			    <tr>
			     <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Unwarranted Stoppage</font></label></td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="StopScore" >
			  <%
			  if(tottrips3 > 0)
			  {
				  StopScore = ((tottrips3-Stoppage)/(double)tottrips3)*UnwarrantedStops;
				 // StopScore = Double.parseDouble(nfrating.format(StopScore));
				  String StopScore1 = StopScore+"";
		//	  System.out.println("StopScore1  "+StopScore1);
			 if(StopScore1.contains("."))
			 {
				String token1 = StopScore1.substring(0,StopScore1.indexOf("."));
				String token2 = StopScore1.substring(StopScore1.indexOf(".")+1,StopScore1.length());
				//System.out.println("token[0]  "+token1);
				// System.out.println("token[1]  "+token2);
				if(token2.length() > 2)
				{
					// System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token1);
					StopScore = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			  }
			  %>
			  <%=StopScore %></font></label>
			  </td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MStopScore" ><%=UnwarrantedStops %></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Leading Alerts Closure</font></label></td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="LAClosureScore" >
			  <%
			  if(VioAlert > 0)
			  {
				  LAClosureScore = (VioClosed/(double)VioAlert)*LAClosure;
				 // LAClosureScore = Double.parseDouble(nfrating.format(LAClosureScore));
				  String LAClosureScore1 = LAClosureScore+"";
			//  System.out.println("totscore1  "+LAClosureScore1);
			 if(LAClosureScore1.contains("."))
			 {
				String token1 = LAClosureScore1.substring(0,LAClosureScore1.indexOf("."));
				String token2 = LAClosureScore1.substring(LAClosureScore1.indexOf(".")+1,LAClosureScore1.length());
				//System.out.println("token[0]  "+token1);
				// System.out.println("token[1]  "+token2);
				if(token2.length() > 2)
				{
					// System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token1);
					LAClosureScore = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			  }
			  %>
			  <%=LAClosureScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MLAClosureScore" ><%=LAClosure%></font></label></td>
			  </tr>
			  <tr>
			  <td align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Policy Documents</font></label></td>
			  <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="PolicyDocScore" ><%=PolicyDocScore %></font></label>
			  </td>
			  <td align="right"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="MPolicyDocScore" ><%= PolicyDocument %></font></label></td>
			  </tr>
			   </table>
			     <br>
		  </td>
		  </tr>
		  <tr>
		  <td valign="middle" align="center" style="width: 170px;" colspan="2">
		    <br>
			   <table border="1"  align="center" cellpadding="0" cellspacing="0" style="width: 200px;">
			  <tr>
				<td align="center" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Section Score</b></font></label></td>
				<td align="right" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Psectionscore"><%=PSectionScore %></font></label>
				</td>
			  </tr>
			  <tr>
				<td align="center" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Max Score</b></font></label></td>
				<td align="right" style="width: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><%=Psectionscore%></font></label></td>
			  </tr>
			  </table>
			    <br>
			  </td>
		  </tr>
		  </table>
		  <table border="0" width="100%" align="center" >
		 <tr>
			  <td colspan="3" align="center">
			  <br>
			  <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black"  onclick="saveprocess();"  />
		  </td>
		  </tr>
		  </table>
		  </td>
		  </tr>
		  </table>
		  </td>
		  </tr>
		  </table>
		  
		  </div>
		  </form>
		  <br>
		  <form  enctype="multipart/form-data" method="get" style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
		   <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" style="cursor:pointer;"  onclick="javascript: try{showtab('6');}catch(e){alert(e);}" ><font  color="#025570" style="font-size: 15px;"> <b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;display: none;" id="conminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;" id="conplus">
			   
			   Contractor Self Audit Score</b></font></td>
			  </tr>
			  <tr id="conselfauditscore" style="display: none;">
			  <td align="center">
			  <input id= "consummary" value="0" type="hidden"></input>
			  <table border="0" align="center" width="60%" cellpadding="0" cellspacing="0">
			   <tr>
			    <td  align="center" style="width: 40px;height: 20px;"> <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>AUDIT SUMMARY</b></font></label></td>
			   </tr>
			   <tr>
			   <td align="center">
			     <table border="1" align="center" cellpadding="0" cellspacing="0" style="width: 200px;">
			     <tr>
			    <th style="width: 80px;" align="center"><label class="description" for="element_9" >
			    <font size="2"><b>Parameter</b></font></label>
			    </th>
			    <th  style="width: 80px;" align="center"> <label class="description" for="element_9" >
			    <font size="2"><b>Score</b></font></label>
			    </th>
			     </tr>
			     <tr>
			       <td  align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" >Vehicle</font></label></td>
			 	   <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="vehiclescore" > <%=Vsectionscore %></font></label></td>
			     </tr>
			     <tr>
			       <td  align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" >Driver</font></label></td>
			 	   <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" id="driverscore" ><%=DSectionScore %></font></label></td>
			     </tr>
			     <tr>
			       <td  align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" >Journey</font></label></td>
			 	   <td  align="right" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="journeyscore" ><%=JSectionScore %></font></label></td>
			     </tr>
			     <tr>
			       <td  align="left" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" >Process</font></label></td>
			 	   <td  align="right" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="processscore" ><%=PSectionScore %></font></label></td>
			     </tr>
			     <tr>
			       <td  align="left" style="height: 30px;"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" >Bonus</font></label></td>
			 	   <td  align="center" style="margin-left: 2px;margin-right: 2px;"> <font size="2" >
			 	   <input id="bonusscore" name="bonusscore" class="element text medium" type="text"  value="<%=bonus %>" style="width: 60px;text-align: right;" onblur="checkvalidity4('bonusscore','1')"></input>
					</font></td>
			     </tr>
			     </table>
			   </td>
			   </tr>
			   <tr align="center">
			  <td>
			   <table border="0" align="center" cellpadding="0" cellspacing="0">
			     <tr>
			  <td  align="right" style="height: 30px;" valign="bottom"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Contractor Self Audit Score : </b></font></label></td>
			  <td  align="left" style="height: 30px;" valign="bottom"><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><b><font size="2" id="selfauditscore">&nbsp;
			  <%
			  double totscore = Vsectionscore+DSectionScore+JSectionScore+PSectionScore+bonus;
			  String totscore1 = totscore+"";
			//  System.out.println("totscore1  "+totscore1);
			 if(totscore1.contains("."))
			 {
				String token1 = totscore1.substring(0,totscore1.indexOf("."));
				String token2 = totscore1.substring(totscore1.indexOf(".")+1,totscore1.length());
				//System.out.println("token[0]  "+token1);
				// System.out.println("token[1]  "+token2);
				if(token2.length() > 2)
				{
					// System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token1);
					totscore = Double.parseDouble(token1+"."+token2.substring(0,2));
				}
			 }
			  %>
			  <%=totscore %></font></b></label></td>
			  </tr></table>
			  </td></tr>
			  <tr  align="center">
			   <td  align="center"><br>
			    <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black" onclick="savesummary();"/>
			    </td></tr>
			   </table>
			   
			   </td>
			  </tr>
			  </table>
		  </td>
		  </tr>
		  </table>
		  </div>
		
		  </form>
		  <br>
		   <form  enctype="multipart/form-data" method="get" style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
		   <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" style="cursor:pointer;"  onclick="javascript: try{showtab('7');}catch(e){alert(e);}" ><font  color="#025570" style="font-size: 15px;"> <b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;display: none;" id="feedminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;" id="feedplus">
			   Comments,Feedback and Suggestions</b></font></td>
			  </tr>
			  <tr id="feedbackcom" style="display: none;">
			  <td align="center">
			  <input id= "commentsug" value="0" type="hidden"></input>
			 
			  <table border="0" align="center" width="80%" cellpadding="0" cellspacing="0">
			   <tr>
			   <td  align="center" style="height: 20px;width: 20%;">
			    <br>
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Comments :</b></font>
			   </label>
			   </td>
			    <td  align="center" style="width: 80%;">
			     <br>
			    <textarea  name="comment"  id="comment"  class="element text medium"  style='text-align: right;width: 100%;text-align: left;' onblur="checkvalidity5('comment','1')"><%=comment %></textarea>
			   </td>
			   </tr>
			   <tr>
			   <td  align="center" style="height: 20px;width: 30%;">
			    <br>
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>FeedBack :</b></font>
			   </label>
			   </td>
			    <td  align="center" style="width: 70%;">
			     <br>
			    <textarea  name="FeedBack"  id="FeedBack"  class="element text medium"  style='text-align: right;width: 100%;text-align: left;' onblur="checkvalidity5('FeedBack','1')"><%=feedback %></textarea>
			   </td>
			   </tr>
			   <tr>
			   <td  align="center" style="height: 20px;width: 30%;">
			    <br>
			   <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Suggestions :</b></font>
			   </label>
			   </td>
			    <td  align="center" style="width: 70%;">
			     <br>
			    <textarea  name="suggestions"  id="suggestions"  class="element text medium"  style='text-align: right;width: 100%;text-align: left;' onblur="checkvalidity5('suggestions','1')"><%=suggest %></textarea>
			   </td>
			   </tr>
			   </table>
			  </td>
			  </tr>
			   <tr  align="center" id="feedbacksave" style="display: none;">
			   <td  align="center"><br>
			    <input id="saveForm" class="button_text" type="button" name="Save" value="Save" style="border-style: outset; border-color: black" onclick="savefeed('<%=quarter %>','<%=year %>');"/>
			    </td></tr>
			  </table>
			  <script type="text/javascript">
		  calculatepoints3();
		  </script>
			  </td></tr></table></div></form>
			  <br>
			   <form  enctype="multipart/form-data" method="get" style="margin-left: 20px;margin-right: 20px;">
		   <div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		     <table border="0" width="100%" align="center" >
		  <tr> 
		  <td style="width: 600px;" valign="top">
		   <table border="0" width="100%" align="center" >
			  <tr>
			   <td  align="left" colspan="2" style="cursor:pointer;"  onclick="javascript: try{showtab('8');}catch(e){alert(e);}" ><font  color="#025570" style="font-size: 15px;"> <b>
			  <img alt="" src="newimages/minusicon.jpeg" style="width: 12px;height: 12px;" id="totalminus">
			    <img alt="" src="newimages/plusicon1.jpeg" style="width: 12px;height: 12px;display: none;" id="totalplus">
			   Contractor Total Incentive Score</b></font></td>
			  </tr>
			  <tr id="totalincentive" >
			  <td align="center">
			  <input id= "totalscore" value="1" type="hidden"></input>
			  <br>
			  	<table border="1" align="center" cellpadding="0" cellspacing="0">
			     <tr>
			     <th style="width: 200px;"><label class="description" for="element_9" >
			    <font size="2"><b>Parameter</b></font></label>
			     </th>
			     <th style="width: 60px;"><label class="description" for="element_9" >
			    <font size="2"><b>Value</b></font></label>
			     </th>
			     <th style="width: 60px;"><label class="description" for="element_9" >
			    <font size="2"><b>Score</b></font></label>
			     </th>
			     </tr>
			     <tr>
			    <td  align="left" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Journey & Process Adherance</font></label></td>
			 	 <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="JPHvalue">
			 	 <%
			 	/* double JPHValue = 0;
			 	 JPHValue = (1-(VioInstances/(double)tottrips2))*100;
			 	 String JPHValue1 = JPHValue+"";
				  System.out.println("JPHValue1  "+JPHValue1);
				 if(JPHValue1.contains("."))
				 {
					String token1 = JPHValue1.substring(0,JPHValue1.indexOf("."));
					String token2 = JPHValue1.substring(JPHValue1.indexOf(".")+1,JPHValue1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						JPHValue = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }*/
			 	 %>
			 	 0</font></label></td>
			 	 <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" id="JPHscore">0</font></label></td>
			     </tr>
			     <tr>
			    <td  align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2">Driver DVI Score</font></label></td>
			 	 <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="DDvalue">
			 	0</font></label></td>
			 	 <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" id="DDscore">0</font></label></td>
			     </tr>
			     <tr>
			    <td  align="left" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Vehicle FTPR</font></label></td>
			 	 <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="VFTPRvalue">
			 	 0</font></label></td>
			 	 <td align="right" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="VFTPRscore">0</font></label></td>
			     </tr>
			     <tr>
			    <td  align="left" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Contractor Self Audit</font></label></td>
			 	 <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="CSAvalue">
			 	 0</font></label></td>
			 	 <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" id="CSAscore">0</font></label></td>
			     </tr>
			     <tr>
			    <td  align="left" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2">Closure of Leading Indicators</font></label></td>
			 	 <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="CLIvalue">
			 	 <%
			 	 /*double CLIvalue = 0;
			 	CLIvalue =LAClosureScore*10;
			 	 String CLIvalu1 = CLIvalue+"";
				  System.out.println("CLIvalue  "+CLIvalue);
				 if(CLIvalu1.contains("."))
				 {
					String token1 = CLIvalu1.substring(0,CLIvalu1.indexOf("."));
					String token2 = CLIvalu1.substring(CLIvalu1.indexOf(".")+1,CLIvalu1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						CLIvalue = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }*/
			 	 %>
			 	 0</font></label></td>
			 	 <td align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2" id="CLIscore">0</font></label></td>
			     </tr>
			     <tr>
			    <td  align="left" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"> <font size="2">Violations</font></label></td>
			 	 <td  align="right" ><label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Viovalue">
			 	 <%
			 /*	 double Viovalue = 0;
			 	Viovalue = (RejectedDriver/(double)totvehicles)*100;
			 	 String Viovalue1 = Viovalue+"";
				  System.out.println("Viovalue1  "+Viovalue1);
				 if(Viovalue1.contains("."))
				 {
					String token1 = Viovalue1.substring(0,Viovalue1.indexOf("."));
					String token2 = Viovalue1.substring(Viovalue1.indexOf(".")+1,Viovalue1.length());
					//System.out.println("token[0]  "+token1);
					// System.out.println("token[1]  "+token2);
					if(token2.length() > 2)
					{
						// System.out.println("token[0]  "+token1);
						// System.out.println("token[1]  "+token1);
						Viovalue = Double.parseDouble(token1+"."+token2.substring(0,2));
					}
				 }*/
			 	 %>
			 	 0</font></label></td>
			 	 <td align="right" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2" id="Vioscore">0</font></label></td>
			     </tr>
			     <tr>
			    <td  align="left" > <label class="description" for="element_9" style="margin-left: 2px;margin-right: 2px;"><font size="2"><b>Total Incentive Score</b></font></label></td>
			 	 <td  align="center" colspan="2"><label class="description" for="element_9" ><font size="2" id="TIscore"><b>0</b></font></label></td>
			
			     </tr>
			     </table>
			  
			  </td>
			  </tr>
			  </table>
			  <script>
			  document.getElementById("totalscore").value = "1";
			  calculatepoints4(1);
			  </script>
			  </td></tr></table>
			  </div></form>
			  <br>
		  <%
		}
		  %>
		  
		  
		  
		  </div>
		  </div>
		  
		    
		<%
		}
		catch(Exception e)
		{
			e.printStackTrace();
			%>
			<center>
			<%
			out.println("Please select the Transporter");
			%>
			</center>
			<%
			
		}
		%>
		<br>
		</body>
		</html>
		<%@ include file="footernew.jsp" %>