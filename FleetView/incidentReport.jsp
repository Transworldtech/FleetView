<%@page import="com.transworld.fleetview.framework.DisconnectionReport"
	import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
	import="com.transworld.fleetview.framework.DisconnectionReportViewData"
	import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="powerOnOffReport.ImplementationOfDisconnection"
	import="powerOnOffReport.DisconnectionData"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="java.util.*"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

<jsp:useBean id="disconnectionViewDataProvider"
	type="com.transworld.fleetview.framework.DisconnectionReportViewDataHelper"
	scope="application"></jsp:useBean>

<%@ include file="headernew.jsp"%>
<script language="javascript">
var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};




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
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;

			dd11=date1.substring(0,2);
			dd22=date2.substring(0,2);

			mm1=date1.substring(3,6);
			mm2=date2.substring(3,6);

			mm11=dateformat(mm1);
			mm22=dateformat(mm2);
			
			yy11=date1.substring(7,11);
			yy22=date2.substring(7,11);
			
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			
			if(yy11>year || yy22>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
	  			if(mm11>month || mm22>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(mm11==month && mm22==month)
			{
				if(dd11>day || dd22>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}

			
			if(yy11 > yy22)
			{
				alert("From date year should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
				 if(mm11>mm22)
			{
				alert("From date month should not be greater than to date month");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			if(mm11==month && mm22==month) 
			{
				if(yy11==yy22)
				{
				if(dd11 > dd22)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
				}
			}
			else
				if(yy11<yy22)
				{
					return true;
				}
			else
				if(dd11 > dd22)
			{
					if(mm11<mm22)
					{
						return true;
					}
					
				alert("From date should not be greater than to date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			
			return true;
		}
 </script>
<%!
String data1, data2, showdate, showdate1;
	int total = 0;
	String VehicleRegNo = "";%>


<%
Connection conn1 = null;

Statement st = null;

try{
	
	String prevDayDate = null;
	String repDate = null;
	String ownerName = null;

	int distanceDifference = 0;

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();

	
%>


<%
		System.out.println("in the incident report jsp page ");
		String fromDate = "", toDate = "";
		java.util.Date today = new java.util.Date();	
		String user = session.getAttribute("usertypevalue").toString();
		String Todays = (new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date())).toString();

%>
<form name="dateform" action="" method="get" onsubmit="return validate();">
<table border="0" width="100%" align="center" class="sortable_entry">
	<tr>

		<td><b><font size="2">From : </font></b>&nbsp;&nbsp; 
		<input type="text" id="data" name="data"
			 size="15" value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date()) %>" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td><b><font size="2">To : </font></b>&nbsp;&nbsp; <input
			type="text" id="data1" name="data1"
			 size="15" value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date()) %>" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td align="left"><input type="submit" name="submit" id="submit"
			value="submit"></td>
	</tr>
</table>
</form>
<%
//value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate))
//value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))
	 fromDate = request.getParameter("data");
	 toDate   = request.getParameter("data1");
	 
	 String data = "", data1 = "", vehicleCode = "", vehicleRegistrationNumber = "",sumOfDist="",intripCount="";
	
	 System.out.println("the fromdate is :- "+fromDate+" toDate is :- "+toDate);
	 
	 if((!(fromDate == null)) || (!(toDate == null)))// || )//(!(fromDate.equalsIgnoreCase("null"))) || (!(fromDate == null)) ) 
	 {
		System.out.println("in here means there is not null value in the fromdate ");
		
		System.out.println("fromDate:- "+fromDate+" toDate :-  "+toDate);	 	
	 
	 }
	 else
	 {
		 
		 System.out.println("in the else  block that means the from date is null  ");
		 Calendar c = Calendar.getInstance();   // this takes current date
		 c.set(Calendar.DAY_OF_MONTH, 1);
		    
		 System.out.println("this is c.gettime():- "+c.getTime());
	 
	 	 fromDate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	 	 
	 	 toDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	 
	 }	 	
			
		
		
		
	 	
%>
<table border="0" width="100%" class="stats">
	<tr>
		<td colspan="5">
		<table border="0" width="100%">
			<tr>
				<th colspan="3" align="center"><font size="3">Vehicle 
				Incident Report for <%=user%> from <%=fromDate%>
				to <%=toDate%>. </font>
				<div align="right"><a href="#"
					onclick="javascript:window.open('DisconnectedPrint_report.jsp?user=<%=user%>&data=<%=fromDate%>&data1=<%=toDate%>');"
					title="Print Report"><img src="images/print.jpg" width="15px"
					height="15px"></a>&nbsp; &nbsp; <a
					href="exceldisconnected_rep.jsp?user=<%=user%>&data=<%=fromDate%>&data1=<%=toDate%>"
					title="Export to Excel"> <img src="images/excel.jpg"
					width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%
 		Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 		String sdt = fmt.format(new java.util.Date());
 		out.print(sdt);
 		String fromtime, totime;
 %>
				</div>
				</th>
			</tr>
		</table>
		<table border="1" width="60%" class="sortable" align="center">
			<tr>
				<th>Incident ID</th>
				<th>Transporter</th>
				<th>Vehicle Code</th>
				<th>UnitID</th>
				<th>Entry By</th>
				<th>Trip ID</th>
				<th>Trip Start Place</th>
				<th>Trip End Place</th>
				<th>Trip Start Date</th>
				<th>Trip Start Time</th>
				<th>Driver Code</th>
				<th>Driver Name</th>
				<th>Distance Travelled</th>
				<th>Reported Location</th>
				<th>Reported Date Time</th>
				<th>Reported Incident Date</th>
			</tr>
<%
/*Incident ID,Transporter,Vehicle Code,UnitID,Entry By,Trip ID,Trip Start Place,Trip End Place,Trip Start Date,Trip Start Time
Driver Code,Driver Name,Distance Travelled,Reported Location,Reported Date Time,Reported Incident Date */

					String IncidentID="",Transporter="",VehicleCode="",UnitID="",EntryBy="",TripID="",TripStartPlace="";
					String TripEndPlace="",TripStartDate="",TripStartTime="",DriverCode="",DriverName="",DistanceTravelled="";
					String ReportedLocation="",ReportedDateTime="",ReportedIncidentDate="";	

					String unitId = "";
					String unitType = "";
					String dt1 = "", dt2 = "", chdt1 = "", chdt2 = "";
					boolean notify;
					String fromDateTime = fromDate + " " + "00:00:00";
					String toDateTime = toDate + " " + "23:59:59";
					System.out.println("user=" + user);
					int disconnectionCount = 0;
					String commaSeparatedVehicleList = session.getAttribute(
							"VehList").toString();
					System.out.println("veh list :- "+commaSeparatedVehicleList);
					
					String sql = "select * from db_gps.t_incidentreport where Vehcode in "+commaSeparatedVehicleList;
					
					System.out.println("sql=" + sql);
					
					ResultSet rs1 = st.executeQuery(sql);
					int i = 0;
					while (rs1.next()) 
					{
/*Incident ID,Transporter,Vehicle Code,UnitID,Entry By,Trip ID,Trip Start Place,Trip End Place,Trip Start Date,Trip Start Time
Driver Code,Driver Name,Distance Travelled,Reported Location,Reported Date Time,Reported Incident Date */						
						i = i + 1;
						IncidentID = rs1.getString("IncidentID");
						
						Transporter = rs1.getString("Transporter");
						VehicleCode = rs1.getString("Vehcode");
						UnitID = rs1.getString("UnitID");
						EntryBy = rs1.getString("EntBy");
						TripID = rs1.getString("TripID");
						
						TripStartPlace = rs1.getString("TripStartPlace");
						TripEndPlace = rs1.getString("TripEndPlace");
						TripStartDate = rs1.getString("TripStartDate");
						TripStartTime = rs1.getString("TripStartTime");
						
						DriverCode = rs1.getString("DriverCode");
						DriverName = rs1.getString("DriverName");
						ReportedLocation = rs1.getString("ReportedLocation");
						DistanceTravelled = rs1.getString("DistanceTravelled");
						ReportedDateTime = rs1.getString("ReportedDateTime");
						ReportedIncidentDate = rs1.getString("ReportedInciDate");
						//ReportedIncidentDate = rs1.getString("ReportedIncidentDate");
						
/*Incident ID,Transporter,Vehicle Code,UnitID,Entry By,Trip ID,Trip Start Place,Trip End Place,Trip Start Date,Trip Start Time
Driver Code,Driver Name,Distance Travelled,Reported Location,Reported Date Time,Reported Incident Date */

%>		
			<tr>
				<td style="text-align: right"><%=IncidentID%></td>
				<td style="text-align: left"><%=Transporter%></td>
				<td style="text-align: left"><%=VehicleCode%></td>
				<td style="text-align: right">&nbsp;&nbsp;&nbsp; <%
 	//if (disconnectionCount > 0) {
 %> 
 		<a href="disconnectedDetailsReport.jsp?vehicleCode=<%=vehicleCode%>&VehicleRegNo=<%=vehicleRegistrationNumber%>&fromDateTime=<%=fromDateTime%>&toDateTime=<%=toDateTime%>&ownerName=<%=rs1.getString("Transporter")%>"><%=UnitID%></a></td>
<%
		//			} //else {
%>
		
<%
					//}
%>
			<td style="text-align: right"><%=EntryBy%></td>
			<td style="text-align: right"><%=TripID%></td>
			<td style="text-align: right"><%=TripStartPlace%></td>
			<td style="text-align: right"><%=TripEndPlace%></td>
			<td style="text-align: right"><%=TripStartDate%></td>
			<td style="text-align: right"><%=TripStartTime%></td>
			<td style="text-align: right"><%=DriverCode %></td>
			<td style="text-align: right"><%=DriverName%></td>
			<td style="text-align: right"><%=DistanceTravelled%></td>
			<td style="text-align: right"><%=ReportedLocation%></td>
			<td style="text-align: right"><%=ReportedDateTime%></td>
			<td style="text-align: right"><%=ReportedIncidentDate%></td>
			</tr>
<%
				}
%>
		</table>
		</td>
	</tr>
</table>
<%
	
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	st.close();
	conn1.close();
	try
	{
	fleetview.closeConnection();
	}catch(Exception e)
	{
	}
}
%>
<%@ include file="footernew.jsp"%>
</jsp:useBean>