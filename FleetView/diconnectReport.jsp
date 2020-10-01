<%@page import="com.transworld.fleetview.framework.DisconnectionReport"
	import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
	import="com.transworld.fleetview.framework.DisconnectionReportViewData"
	import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="powerOnOffReport.ImplementationOfDisconnection"
	import="powerOnOffReport.DisconnectionData"%>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

<jsp:useBean id="disconnectionViewDataProvider"
	type="com.transworld.fleetview.framework.DisconnectionReportViewDataHelper"
	scope="application"></jsp:useBean>

<%@ include file="headernew.jsp"%>
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
<%!String data1, data2, showdate, showdate1;
	int total = 0;
	String VehicleRegNo = "";
	
	
	
	%>


<%

Connection conn1 = null;
Connection conn2=null;
Connection conn3 = null;
Connection conn4 = null;
Connection conn5 = null;
Statement st = null;
Statement st1 = null;
Statement st2 = null;
Statement st3 = null;
Statement st4 = null;
String prevDayDate = null;
String repDate =  null;
String ownerName;

int distanceDifference = 0;

String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
String MM_dbConn_USERNAME = "fleetview";
String MM_dbConn_PASSWORD = "1@flv";
String MM_dbConn_GPS = "jdbc:mysql://localhost/db_gps";
String MM_dbConn_AVLALLDATA = "jdbc:mysql://localhost/db_avlalldata";
Class.forName(MM_dbConn_DRIVER);
conn1 = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
conn2 = DriverManager.getConnection(MM_dbConn_AVLALLDATA,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);

st =  conn1.createStatement();
st1 = conn1.createStatement();
st2 = conn1.createStatement();
st3 = conn1.createStatement();
st4 = conn2.createStatement();


%>


<%
	String fromDate = "", toDate = "";
	String fromdate1 = "", todate1 = "";

	String dd = request.getQueryString();
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));
		todate1 = data2;

		cal.add(Calendar.DATE, -1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;
		fromdate1 = data1;
		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	} else {

		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));
		fromdate1 = request.getParameter("data");

		todate1 = request.getParameter("data1");

	} //end of else
	String user = session.getAttribute("usertypevalue").toString();
%>
<form name="dateform" action="" method="get"
	onsubmit="return validate();">
<table border="0" width="500" align="center">
	<tr>
		<td><b>From </b>&nbsp;&nbsp; <input type="text" id="data"
			name="data" value="<%=fromdate1%>" size="15" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td><b>To </b>&nbsp;&nbsp; <input type="text" id="data1"
			name="data1" value="<%=todate1%>" size="15" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		<td><input type="submit" name="submit" id="submit" value="submit"></td>
	</tr>
</table>
</form>
<table border="0" width="100%">
	<tr>
		<td colspan="5">
		<table border="0" width="100%">
			<tr>
				<th colspan="3" align="center">Fleet Disconnection Report for <%=user%>
				from <%
					java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy")
							.parse(data1);
					Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
					showdate = formatter2.format(ShowDate);
					out.print(showdate);
				%> to <%
					java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy")
							.parse(data2);
					Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
					showdate1 = formatter1.format(ShowDate1);
					out.print(showdate1);
				%>.
				<div align="right"><a href="#"
					onclick="javascript:window.open('DisconnectedPrint_report.jsp?userval=<%=user%>&data=<%=fromdate1%>&data1=<%=todate1%>');"
					title="Print Report"><img src="images/print.jpg" width="15px"
					height="15px"></a>&nbsp; &nbsp; <a
					href="exceldisconnected_rep.jsp?userval=<%=user%>&data=<%=data1%>&data1=<%=data2%>&Total=<%=total%>"
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
		<table border="1" width=500 class="sortable">
			<tr>
				<th>Sr.</th>
				<th>Veh.</th>
				<th>Count</th>

			</tr>
			<%
			String unitId="";
			String unitType = "";
			String vehicleCode="";
			String vehicleRegistrationNumber="";
			boolean notify;
			String sql="SELECT a.unitid AS unitid, a.vehicleregnumber AS VehicleRegNumber, a.vehiclecode AS VehicleCode, a.ownername AS ownername," +
			"b.unitid, b.typeunit AS typeunit " +
			"FROM (" +
			" SELECT unitid, vehiclecode, vehicleregnumber, ownername " +
			" FROM db_gps.t_vehicledetails " +
			" ) a  " +
			"LEFT OUTER JOIN db_gps.t_unitmaster b " +
			"ON (a.unitid=b.unitid) " +
			"WHERE a.vehiclecode in "+session.getAttribute("VehList").toString()+" ";
		//	"WHERE a.vehicleregnumber in ('TN 04 AB 4575','TN 04 AB 5352','MH 04 DS 5185','MH 04 DS 5186','MH 04 CP 9935','MH 04 DS 5200')";
		//		"WHERE a.vehicleregnumber in ('MH 04 DS 3047')";
			ResultSet rs1=st.executeQuery(sql);
			int i=0;
			while(rs1.next()){
			//	System.out.println(i++);
				unitId = rs1.getString("UnitID"); //"2377";//
				unitType = rs1.getString("typeunit"); 
			//	System.out.println(unitType);
				vehicleCode = rs1.getString("VehicleCode"); //"1890"; 
				vehicleRegistrationNumber =  rs1.getString("VehicleRegNumber"); //"abc";// 
				//System.out.println(vehicleRegistrationNumber);
				ownerName = rs1.getString("ownername"); 
				notify = true;
				int count=0;
				String fromDateTime = fromDate+" 00:00:00";
				String toDateTime = toDate+" 23:59:59";
				List<DisconnectionData> record = null;
				ImplementationOfDisconnection pwOnOff = new ImplementationOfDisconnection();
				try {
					record = pwOnOff.getDisconnectionData(ownerName,vehicleCode, fromDateTime,toDateTime, vehicleRegistrationNumber, unitId, unitType);
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (ParseException e) {
					e.printStackTrace();
				}
				int numRecords = record.size();
				
				
%>
				<tr>
					<td style="text-align: right"><%=i+1%></td>
					<td style="text-align: left"><%=vehicleRegistrationNumber%></td>
					<td style="text-align: right">&nbsp;&nbsp;&nbsp;
<%
				if(numRecords>0){ 
					String cnt="0";
					System.out.println("\n\ncnt--->>>"+cnt);
%>
					<a href="disconnectedDetailsReport.jsp?VehicleRegNo=<%=vehicleRegistrationNumber%>&vehicleCode=<%=vehicleCode%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>&unitId=<%=unitId%>&unitType=<%=unitType%>&ownerName=<%=ownerName%>"><%=numRecords%></a></td>
<%
				}
				else{
%>
					<%=numRecords%>
<%
				}
%>
				</tr>
				
<%
				
				//----------------------------------------------------------------------------------------
		
			}


			%>
		</table>
		</td>
	</tr>
</table>
<%@ include file="footernew.jsp"%>
