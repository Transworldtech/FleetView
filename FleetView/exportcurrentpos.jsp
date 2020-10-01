<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>


<% response.setContentType("application/vnd.ms-excel");
String filename=session.getAttribute("user").toString();
int cnt= 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_currentpos_report.xls";
}
else
{
	filename = filename=session.getAttribute("user").toString()+"_currentpos_report.xls";
}
System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
    %>
<%@page import="com.transworld.fleetview.framework.VehiclePositionData"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
		import="com.transworld.fleetview.framework.VehiclePositionsViewData"
		import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataResults" %>
		<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>

<jsp:useBean id="vehiclePositionsViewDataProvider" 
			 type="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
			 scope="application"></jsp:useBean>		
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">	 

  <%@ include file="Connections/conn.jsp" %>
  
 
<%!

	private String getFromDate() {
	
		String fromdate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate1));
		} catch (Exception e) {
			try{
				fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
								new SimpleDateFormat("yyyy-MM-dd").parse(sdate1));
			}catch(Exception e1){
			}
		}
		return fromdate;
	}

	private String getToDate() {

		String todate = "";
		final String sdate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd").format(
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate1));
		} catch (Exception e) {
			try{
				todate = new SimpleDateFormat("yyyy-MM-dd").format(
							new SimpleDateFormat("yyyy-MM-dd").parse(sdate1));
			}catch(Exception e1){				
			}
		}
		return todate;
	}

	private String getFromTimeHrs() {
		return "00";
	}

	private String getFromTimeMins() {
		return "00";
	}

	private String getToTimeHrs() {
		return "23";
	}

	private String getToTimeMins() {
		return "59";
	}

	private String getTripStartDate(final String datetime) {
		String fromdate="";
		//System.out.println("datetime--------->"+datetime);
		if("-".equalsIgnoreCase(datetime)){
			return datetime;
		}
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
						new SimpleDateFormat("dd-MMM-yyyy").parse(datetime));
		} catch (Exception e) {
			try{
				fromdate = new SimpleDateFormat("yyyy-MM-dd").format(
							new SimpleDateFormat("dd-MMM-yyyy").parse(datetime));
			}catch(Exception e1){
				e1.printStackTrace();
			}
		}
		return fromdate;
	}

	private String getTripEndDate(final String datetime) {
		String todate = "";
		if("-".equalsIgnoreCase(datetime)){
			return datetime;
		}
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		} catch (Exception e) {
		}
		return todate;
	}

	private String getTripStartTimeHrs(final String datetime) {
		String ftime1 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime);
			ftime1 = new SimpleDateFormat("HH").format(dt);
		} catch (Exception e) {
		}
		return ftime1;
	}

	private String getTripStartTimeMins(final String datetime) {
		String ftime2 = "00";
		try {
			java.util.Date dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime);
			ftime2 = new SimpleDateFormat("mm").format(dt);
		} catch (Exception e) {
		}
		return ftime2;
	}

	private String getTripEndTimeHrs(final String datetime) {
		String ttime1 = "23";
		try {
			ttime1 = new SimpleDateFormat("HH").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}

	private String getTripEndTimeMins(final String datetime) {
		String ttime1 = "59";
		try {
			ttime1 = new SimpleDateFormat("mm").format(new java.util.Date());
		} catch (Exception e) {
		}
		return ttime1;
	}

	private boolean isOSTodayZero(String osToday) {
		try{
			if (Integer.parseInt(osToday) > 0) {
				return true;
			}
		}catch(Exception e) {
		}
		return false;
	}

	private String getfuelAlert_AddedTodayDate() {
		String today = "", prevDay = "";
		Calendar cal;
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
		cal = Calendar.getInstance();
		today = dateFormat.format(cal.getTime());
		return today;

	}

	private String getfuelAlert_AddedPreviousDate() {
		String today = "", prevDay = "";
		Calendar cal;
		DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");

		cal = Calendar.getInstance();
		today = dateFormat.format(cal.getTime());

		cal.add(Calendar.DATE, -1);
		prevDay = dateFormat.format(cal.getTime());

		return prevDay;

	}
%>
    
  <%!Connection conn, conn1;
	Statement st, st1, st2, st3, st4;
	String sql, sql1, sql2, sql3, sql4, username, userrole, olddate, Svehlist;
	int total, updated, dealy, disconnected, notactive, transid;
	String vid, vehno;%>






<%
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_CustomerComplaints";
	String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";

	
	System.out.println("Creating Connection");
	Class.forName(MM_dbConn_DRIVER);
   // conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    System.out.println(">>>2222aaaaa ");
   conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
   
    System.out.println(">>>2222bbbb ");
    st=conn1.createStatement();
    System.out.println(">>>2222cccc ");
	st1=conn1.createStatement();
	
	   System.out.println(">>>2222ddd ");
    st2=conn1.createStatement();
    st3=conn1.createStatement();
    st4=conn1.createStatement();
    Statement stmt2 = conn1.createStatement();
    Statement stmt7 = conn1.createStatement();
    Statement stmt8 = conn1.createStatement();
	   

	 Statement stveh = conn1.createStatement();
    Statement st9 = conn1.createStatement();
    Statement st5 = conn1.createStatement();
    Statement st6 = conn1.createStatement();
    Statement st7 = conn1.createStatement();

	
	
	
	
	
    System.out.println(">>>2222 ");
	
	
	 %>

<%

	session.setAttribute("reportno","Report No:1.0");
	final String userTypeValue = session.getAttribute("usertypevalue").toString();
	System.out.println(">>>>>>>>>++ " +userTypeValue);
	final String typeOfUser = session.getAttribute("TypeofUser").toString();
	final String distanceFormat = session.getAttribute("distformat").toString();
	   String vehtype="";

String condi=request.getParameter("condition");
System.out.println(">>>>>>>>>++ " +condi);

final String typeOfUser1 = session.getAttribute("mainuser").toString();
	final String fuelFormat = session.getAttribute("fuelformat").toString();
	final String commaSeparatedVehicleList = session.getAttribute("VehList").toString();
	final int disConnected = Integer.parseInt(session.getAttribute("desconnected").toString());
	final String fromPage="currentPosition";
	String key="All";
	String requestParamSearchVeh = request.getParameter("searchveh");
	if (null == requestParamSearchVeh) {
		requestParamSearchVeh = "";
	}
	
	VehiclePositionsViewDataResults viewData = null;
	int numRecords = 0;
	try{
	
		final List<VehiclePositionData> list = vehicleDao.getVehiclePositions(
				typeOfUser, userTypeValue, commaSeparatedVehicleList, session.getId());
	
		 viewData = vehiclePositionsViewDataProvider.getVehiclePositionsView(
				 list, distanceFormat, disConnected, fuelFormat,
				 vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage));
		 numRecords = viewData.getCount();
		 
		 session.setAttribute("VehiclePositionsViewData", viewData);
		 
	} catch(Exception e){
		e.printStackTrace();
	}
	
%>


<jsp:include page="SubUserView.jsp">
	<jsp:param name="username" value="<%=requestParamSearchVeh%>"/>
</jsp:include>

	<form name="CountOfRecordsForm">
		<input type="hidden" name= "cnt" id="cnt" value=<%=numRecords%>></input>
	</form>
	<table  border="0" align="center">
	<tr><td><font face="Arial" size="3">Current Position of Vehicles</font></td></tr>
	
	</table>
	

	<table width="100%" border="1" align="center" class="sortable">
		<tr>
			<th>  Sr. </th>
			<th> Veh.</th>	
			<th> Veh Type.</th>			
			<th> Updated</th>
			<th> Transporter</th>
			<%
			if(condi.equals("12")){
				%>
				<th > Trip Id</th><%} 
			
			
			
			else if(condi.equals("1"))
			{
				%>
			<th > Trip Id</th>
			<%} %>
			<th> Trip Violation</th>
				<%
				
				if(condi.equals("12"))
				{
					%>
			<th >Driver Name(Code)</th>
			<th>Trip Origin</th>
			<th>Start Date</th>
			<th>Trip Destination</th>
						<th>ETA</th>
			
					<%
				}
				
				else if(condi.equals("1"))
			{
				%>
			<th >Driver Name(Code)</th>
			<th>Trip Origin</th>
			<th>Start Date</th>
			<th>Trip Destination</th>
			<th>ETA</th>
			
			<%} %>
			<th> Location</th>
			<th> Ignition</th>
			<th> Speed</th>
			<th> Stopped Since (HH:mm)</th>
			<th> OS Today</th>
			<th> RA Today</th>
			<th> RD Today</th>
			<th> Distance Today</th>
			<th> Distance This Month</th>
			<%
				
				if(condi.equals("12"))
				{
				%>
				<th >Previous Day Avg.</th>
			<th>Avg. This Month</th>
			<th >Fuel</th>
			<th> <b>Fuel Alert</th>
			<th>Yesterday's Fuel Added</th>
			<th>Day Shift Driver</th>
			<th>Night Shift Driver</th>
				<%
				}
				else if(condi.equals("0"))
			{
				%>
				<th >Previous Day Avg.</th>
			<th>Avg. This Month</th>
			<th >Fuel</th>
			<th> <b>Fuel Alert</th>
			<th>Yesterday's Fuel Added</th>
			<th>Day Shift Driver</th>
			<th>Night Shift Driver</th>
				<%
			}
			
			%>
			
<%
if(userTypeValue.equals("Croda Chemicals (India) Private Limited"))
		
{
	%>
	        <th>Engine Temp</th>
			<th>Product Temp</th>
			<th>RPM</th>
			<th>Driver Name</th>
			<th>Key Status</th>
	<%
	
}


else if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
%>
			<th>Sen1</th>
			<th>Sen2</th>
			<th>Sen3</th>
			<th>Sen4</th>
			<th>Engine Status</th>
<%
	}
else{}
System.out.println("hii");
%>
<th> Battery charging</th>
<th> Battery Date</th>
		</tr>	
<%
	try {
		for (int counter = 0; counter < numRecords; counter++) {
			final VehiclePositionsViewData currentRecord = viewData.getVehiclePositionViewDataAtIndex(counter);
			int i = counter+1;
		
%>	
		<tr>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=i%></td>
			<%
			if(currentRecord.isDataBlocked() || currentRecord.isDeviceInActive())
			{
				%>
				<td WIDTH="6%" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
				<font size="2"><%=currentRecord.getVehicleRegistrationNo()%></font>
				</td>
				<%
			}
			else
			{
			%>
			<td WIDTH="6%" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
			
			<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=currentRecord.getVehicleRegistrationNo()%></font></a>
			
								
			</td>		
			
			<%
			}
			%>	
			<%
			/*try
			{
				   System.out.println("enter>>>>>>>>>>>");

			   String SqlVehType="Select vehtype from db_gps.t_vehicledetails where VehicleRegNumber='"+currentRecord.getVehicleRegistrationNo()+"'";
			   
			   System.out.println("enter vehtype>>>>>>>>>>>"+SqlVehType);
ResultSet rsveh=stveh.executeQuery(SqlVehType);
System.out.println("vehtype"+rsveh);
if(rsveh.next())
{
	vehtype=rsveh.getString("vehtype");
	 System.out.println("enter vehtype>>>>>>>>>>>"+vehtype);
}
		   
			}
			catch(Exception e)
			{
				   System.out.println("enter catch>>>>>>>>>>>");

				e.printStackTrace();
			}*/
			try{
			String sqlvehtype="select * from db_gps.t_vehicledetails where VehicleRegNumber='"+currentRecord.getVehicleRegistrationNo()+"' ";
			 
			System.out.println("sqlvehtype above>>>>>>>>>"+sqlvehtype);

			ResultSet rsvehtype=stveh.executeQuery(sqlvehtype);
			 System.out.println("sqlvehtype>>>>>>>>>"+sqlvehtype);

			if(rsvehtype.next())
			{
				vehtype=rsvehtype.getString("vehtype");	
				 System.out.println("vehtype>>>>>>>>>"+vehtype);

			}	
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
				
			
			
			%>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=vehtype%></td>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getLastUpdatedDateTime()%></td>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getTransporter()%></td>
<%


	
			if ((currentRecord.isTripDataAvailable())) {
%>
<%
if(condi.equals("12"))
{
	%>
	<td WIDTH="6%" id="tdd<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
				<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><font size="2">
				<%=currentRecord.getTripID()%></font></a>
		
			</td>
	<%
}
else if(condi.equals("1"))
{
%>
			<td WIDTH="6%" id="tdd<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
				<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><font size="2">
				<%=currentRecord.getTripID()%></font></a>
		
			</td>
			<%} %>
				<%
			try{
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Calendar now123=Calendar.getInstance();
			
			String sysdate22 = dateFormat.format(now123.getTime());
			//System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);
			String tripstartdate ="";
			int racount=0,rdcount=0,cdcount=0,ndcount=0,oscount=0,osdur=0,sum=0;

			if(currentRecord.getTripStartDateTime().equals("-"))
			{
				tripstartdate = "-";
			}
			else
			{
				tripstartdate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(currentRecord.getTripStartDateTime()));
			}
			
			try{
				
				
				
				
				if(tripstartdate.equals("-"))
				{
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"> 0</td>
					<%
					
				}
				else{
					try{
					String sql2="select count( * ) as racount from db_gpsExceptions.t_vehall_ra where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND TheDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND TheDatetime <= '"+sysdate22+"'"; 
					ResultSet rs2=st9.executeQuery(sql2);
					//System.out.println(">>>>>>>rrrrrrrrr1" +sql2);
					if(rs2.next())
					{
						racount=rs2.getInt("racount");
					}
					
					String sql3="select count( * ) as rdcount from db_gpsExceptions.t_vehall_rd where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND TheDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND TheDatetime <= '"+sysdate22+"'"; 
					ResultSet rs3=st3.executeQuery(sql3);
					//System.out.println(">>>>>>>rrrrrrrr2" +sql3);
					if(rs3.next())
					{
						rdcount=rs3.getInt("rdcount");
					}
					
					

					String sql5="select count( * ) as cdcount from db_gpsExceptions.t_vehall_crcopy where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND FromDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND FromDatetime <= '"+sysdate22+"'"; 
					ResultSet rs5=st5.executeQuery(sql5);
					//System.out.println(">>>>>>>rrrrrrr3" +sql5);
					if(rs5.next())
					{
						cdcount=rs5.getInt("cdcount");
					}
					
					
					
					
					
					String sql6="select count( * ) as ndcount from db_gpsExceptions.t_vehall_nd where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND FromDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND FromDatetime <= '"+sysdate22+"'"; 
					ResultSet rs6=st6.executeQuery(sql6);
					//System.out.println(">>>>>>>rrrrrrrrr4" +sql6);
					if(rs6.next())
					{
						ndcount=rs6.getInt("ndcount");
					}
					
					
					String sql7="select count( * ) as oscount from db_gpsExceptions.t_vehall_overspeed where VehCode = '"+currentRecord.getVehicleCode()+"' AND violationstatus='Open' AND FromDatetime >= '"+tripstartdate+" "+currentRecord.getTripStartTime()+"' AND FromDatetime <= '"+sysdate22+"'"; 
					ResultSet rs7=st7.executeQuery(sql7);
					//System.out.println(">>>>>>>rrrrrrrrr5" +sql7);
					if(rs7.next())
					{
						oscount=rs7.getInt("oscount");
					}
					

					
					
					
			
					sum=racount+rdcount+cdcount+ndcount+oscount;	
					System.out.println(">>>>>>>rrrrrrrrr5" +sum);
					}catch(Exception e)
					{
						e.printStackTrace();
					}

				%>
				
	<%
	if(sum==0)
	{
		%>
							<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"> 0</td>
		
		<%
		
	}
	else{
		%>			

				
				<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=sum %></td>
				<%
					
				}}
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			}catch(Exception e){
				e.printStackTrace();
				
			}
			
			
			
			
			%>
			
			
			<%
			if(condi.equals("12"))
			{
				%>
				<td id="tde<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
				<%=currentRecord.getDriverNameCode()%>
			</td>
			<td id="tda<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left" >			
				<%=currentRecord.getTripOrigin()%>
			</td>
			<td id="tdb<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
				<%=currentRecord.getTripStartDateTime()%>
			</td>
			<td id="tdc<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
				<%=currentRecord.getTripDestination()%>
			</td>
						<%
String ETA="",ETA1="";
						try{
String sqlETA="select * from db_gps.t_startedjourney where TripID='"+currentRecord.getTripID()+"' and OwnerName='"+currentRecord.getTransporter()+"'";
System.out.println("ETA is " +sqlETA);
ResultSet rseta=st3.executeQuery(sqlETA);
if(rseta.next())
{
	ETA=rseta.getString("ETA");
}
if(!(null==ETA))	      {
    ETA=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));
   }
else{
	ETA="NA";
}
						}catch(Exception e)
						{
							e.printStackTrace();
						}

%>


<td id="eta<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=ETA %></td>s
				<%
			}
			else if(condi.equals("1"))
{
%>
			<td id="tde<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
				<%=currentRecord.getDriverNameCode()%>
			</td>
			<td id="tda<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">			
				<%=currentRecord.getTripOrigin()%>
			</td>
			<td id="tdb<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
				<%=currentRecord.getTripStartDateTime()%>
			</td>
			<td id="tdc<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
				<%=currentRecord.getTripDestination()%>
			</td>
						<%
String ETA="",ETA1="";
						try{
String sqlETA="select * from db_gps.t_startedjourney where TripID='"+currentRecord.getTripID()+"' and OwnerName='"+currentRecord.getTransporter()+"'";
System.out.println("ETA is " +sqlETA);
ResultSet rseta=st3.executeQuery(sqlETA);
if(rseta.next())
{
	ETA=rseta.getString("ETA");
}
if(!(null==ETA))	      {
    ETA=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));
   }
else{
	ETA="NA";
}
						}catch(Exception e)
						{
							e.printStackTrace();
						}

%>


<td id="eta<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=ETA %></td>
			
			
			
			
			
			
			
			
			
			<%} %>
<%
				} else {
					
					if(condi.equals("12"))
					{
						%>
						<td WIDTH="8%" id="tdd<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
			
				<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripID()%></a></td>
						<%
					}
					else if(condi.equals("1"))
		{
		%>
			<td WIDTH="8%" id="tdd<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
			
				<a href="tripstart.jsp?vehno=<%=currentRecord.getVehicleRegistrationNo()%>"><%=currentRecord.getTripID()%></a></td>
				<%} %>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"> 0</td>
							<%
							if(condi.equals("12"))
							{
								%>
									<td id="tde<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getDriverNameCode()%></a>-->
					<%=currentRecord.getDriverNameCode()%>
				</td>
				<td id="tda<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">			
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripOrigin()%></a>-->
					<%=currentRecord.getTripOrigin()%>
				</td>
				<td id="tdb<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripStartDateTime()%></a>-->
					<%=currentRecord.getTripStartDateTime()%>
				</td>
				<td id="tdc<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripDestination()%></a>-->
					<%=currentRecord.getTripDestination()%>
				</td>
								<td id="eta<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">NA</td>
				
								<%
							}
							else if(condi.equals("1"))
{
%>
				<td id="tde<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getDriverNameCode()%></a>-->
					<%=currentRecord.getDriverNameCode()%>
				</td>
				<td id="tda<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">			
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripOrigin()%></a>-->
					<%=currentRecord.getTripOrigin()%>
				</td>
				<td id="tdb<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripStartDateTime()%></a>-->
					<%=currentRecord.getTripStartDateTime()%>
				</td>
				<td id="tdc<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">
					<!--<a href="tripstart.jsp?vehno=< %=currentRecord.getVehicleRegistrationNo()%>">< %=currentRecord.getTripDestination()%></a>-->
					<%=currentRecord.getTripDestination()%>
				</td>
				
								<td id="eta<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>" align="left">NA</td>
				
				
				<%} %>
<%
				}
%>
			<td style="text-align:left; <%=currentRecord.getBgColor()%>" align="left">
<%
				if(currentRecord.isDataBlocked() || currentRecord.isDeviceInActive())
				{
%>
					<%=currentRecord.getLocationWithDeviceStatus() %>
<%				}
				else{
%>
			<a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=currentRecord.getLatitude()%>&long=<%=currentRecord.getLongitude()%>&discription=<%=currentRecord.getCurrentLocation()%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=currentRecord.getCurrentLocation()%> </a><%=currentRecord.getLocationWithDeviceStatus() %>
<%
				} 
%>
			
			</td>
			<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getIngnitionInfo()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSpeed()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getStoppedSince()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
<%
				if (isOSTodayZero(currentRecord.getOSToday())) {
%>
				<a href="newos.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&fromdate=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>&todate=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>"><%=currentRecord.getOSToday()%></a>
<%
				} else {
%>
			<%=currentRecord.getOSToday()%>
<%
				}
%>
			</td>
 			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
<%
				if (isOSTodayZero(currentRecord.getRAToday())) {
%>
				<a href="detail_ra.jsp?vid=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNo() %>&dd=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>&pageType=RapidAcceleration"><%=currentRecord.getRAToday()%></a>
<%
				} else {
%>
			<%=currentRecord.getRAToday()%>
<%
				}
%>
			</td>
			
			
			
									<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right">
<%
				if (isOSTodayZero(currentRecord.getRDToday())) {
%>
				<a href="detail_rd.jsp?vid=<%=currentRecord.getVehicleCode()%>&vehno=<%=currentRecord.getVehicleRegistrationNo() %>&dd=<%=new SimpleDateFormat("yyyy-MM-dd")
										.format(new java.util.Date())%>&pageType=RapidDecceleration"><%=currentRecord.getRDToday()%></a>
<%
				} else {
%>
			<%=currentRecord.getRDToday()%>
<%
				}
%>
			</td>
		
			
			
			
			
			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getDistanceToday()%></td>
			<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getDistanceThisMonth()%></td>
										<%
										
										if(condi.equals("12")){
											%>
											<td id="tdp<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getLastDayAVG()%></td>
			<td id="tdm<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getLastMonthAVG()%></td>
			<td id="tdf<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;" align="left"><%=currentRecord.getFuelLevel()%></td>
<%
				if ("FUELFLOW".equalsIgnoreCase(currentRecord.getUnitDescription())) {
%>
			<td id="tdl<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><a href="showfuelalert.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedTodayDate()%>&data1=<%=getfuelAlert_AddedTodayDate()%>"><%=currentRecord.getFuelAlert()%></a></td>
			<td id="tdy<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><a href="showfueladd.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedPreviousDate()%>&data1=<%=getfuelAlert_AddedPreviousDate()%>"><%=currentRecord.getFuelAdded()%></a></td>
<%
				} else {
%>
			<td id="tdl<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getFuelAlert()%></td>
			<td id="tdy<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getFuelAdded()%></td>
<% 
				}
%>
			<td id="tdr<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;" align="left"><%=currentRecord.getDayShiftDriver()%></td>
			<td id="tdn<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;" align="left"><%=currentRecord.getNightShiftDriver()%></td>
											<%
											
										}
if(condi.equals("0"))
{
%>
			<td id="tdp<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getLastDayAVG()%></td>
			<td id="tdm<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getLastMonthAVG()%></td>
			<td id="tdf<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;" align="left"><%=currentRecord.getFuelLevel()%></td>
<%
				if ("FUELFLOW".equalsIgnoreCase(currentRecord.getUnitDescription())) {
%>
			<td id="tdl<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><a href="showfuelalert.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedTodayDate()%>&data1=<%=getfuelAlert_AddedTodayDate()%>"><%=currentRecord.getFuelAlert()%></a></td>
			<td id="tdy<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><a href="showfueladd.jsp?vehcode=<%=currentRecord.getVehicleCode()%>&data=<%=getfuelAlert_AddedPreviousDate()%>&data1=<%=getfuelAlert_AddedPreviousDate()%>"><%=currentRecord.getFuelAdded()%></a></td>
<%
				} else {
%>
			<td id="tdl<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getFuelAlert()%></td>
			<td id="tdy<%=i%>" style="text-align:right;<%=currentRecord.getBgColor()%>;display:none;" align="right"><%=currentRecord.getFuelAdded()%></td>
<% 
				}
%>
			<td id="tdr<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;" align="left"><%=currentRecord.getDayShiftDriver()%></td>
			<td id="tdn<%=i%>" style="text-align:left;<%=currentRecord.getBgColor()%>;display:none;" align="left"><%=currentRecord.getNightShiftDriver()%></td>
<%}
			if (vehicleDao.isSensorDataDisplayed(userTypeValue,fromPage)) {
				
				//System.out.println((!(currentRecord.isDeviceInActive()) &&  (currentRecord.getSensor1().equals("xxxx"))));
				
				if(!(currentRecord.isDeviceInActive()) &&  (currentRecord.getSensor1().equals("xxxx")) && (userTypeValue.equals("Croda Chemicals (India) Private Limited")))
				{				
					String sqlsen1 = "select sen1,Thefielddatadatetime from db_gps.t_veh"+currentRecord.getVehicleCode()+" where thefielddatadatetime < '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getLastUpdatedDateTime())) +"' and sen1 <> '-' and sen1 <> ' '  and Thefiledtextfilename = 'SI' order by thefielddatadatetime desc limit 1";
					ResultSet rssen1 = st1.executeQuery(sqlsen1);
					if(rssen1.next())
					{
						System.out.println( "*********8     "+rssen1.getString("sen1"));
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><font color="red"><%=rssen1.getDouble("sen1") %><br>(<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rssen1.getString("thefielddatadatetime"))) %>)</font></td>
					<%
					}
					else
					{
						%>
						<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor1()%></td>
						<%
					}
				}
				else
				{
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor1()%></td>
					<%
				}
				
				if(!(currentRecord.isDeviceInActive()) &&  (currentRecord.getSensor2().equals("xxxx")) && (userTypeValue.equals("Croda Chemicals (India) Private Limited")))
				{				
					String sqlsen1 = "select sen2,Thefielddatadatetime from db_gps.t_veh"+currentRecord.getVehicleCode()+" where thefielddatadatetime < '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getLastUpdatedDateTime())) +"' and sen2 <> '-' and sen2 <> ' '  and Thefiledtextfilename = 'SI' order by thefielddatadatetime desc limit 1";
					ResultSet rssen1 = st1.executeQuery(sqlsen1);
					if(rssen1.next())
					{
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><font color="red"><%=rssen1.getDouble("sen2") %><br>(<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rssen1.getString("thefielddatadatetime"))) %>)</font></td>
					<%
					}
					else
					{
						%>
						<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor2()%></td>
						<%
					}
				}
				else
				{
					%>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor2()%></td>
					<%
				}
%>
<!--<td style="< %=currentRecord.getBgColor()%>">< %=currentRecord.getSensor1()%></td>-->
<!--	<td style="< %=currentRecord.getBgColor()%>">< %=currentRecord.getSensor2()%></td>-->
			
			<%
			if(userTypeValue.equals("Croda Chemicals (India) Private Limited"))
			{	
				String sqlsen1 = "select sen3,sen4 from db_gps.t_onlinedata where VehicleCode = '"+currentRecord.getVehicleCode()+"' ";
				ResultSet rssen1 = st1.executeQuery(sqlsen1);
				if(rssen1.next())
				{
					if(rssen1.getString("sen3").equals("-") || rssen1.getString("sen3").equals(" "))
					{
						%>
						<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="left">xxxx</td>
						<%
					}
					else
					{
						%>
						<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=rssen1.getString("sen3")%></td>
						<%
					}
					%>	
				<%
					if(rssen1.getString("sen4").equals("-") || rssen1.getString("sen4").equals(" ") || rssen1.getString("sen4").length() <= 2)
					{
						System.out.println(" in  if  ----------------------------------------------"+rssen1.getString("sen4"));
						%>
						<td style="text-align:left;<%=currentRecord.getBgColor()%>">xxxx</td>
						<%
					}
					else
					{
						System.out.println("in  if  ---------------------------------------------------------------"+rssen1.getString("sen4")+"--------------------");
						String sk  = rssen1.getString("sen4").replace("\n","");
					//	sk = sk.replace("\t","");
					//	sk = sk.replace(" ","");
					//	sk = sk.replaceAll("(\\t|\\r?\\n)","");
					
					sk = sk.substring(0,3);
						%>
						<script>

						
						</script>
						<%
						//System.out.println("in  if  ---------------------------------------------------------------"+sk+"--------------------");
						String sqlsk = "select DriverName from db_gps.t_drivers where SmartKey like  '"+sk+"' ";
						//System.out.println("in  driver  if  ----------------------------"+sqlsk);
						ResultSet rssk = st2.executeQuery(sqlsk);
						//System.out.println("in  driver  if  ----------------------------"+sqlsk);
						if(rssk.next())
						{
							System.out.println(" in  driver  if  -------------------------------------------"+rssk.getString("DriverName"));
							%>
							<td style="text-align:left;<%=currentRecord.getBgColor()%>"><%=rssk.getString("DriverName")%></td>
							<%
						}
						else
						{
							System.out.println(" in  else  if  ------------------------------"+rssen1.getString("sen4"));
							%>
							<td style="text-align:left;<%=currentRecord.getBgColor()%>">xxxx</td>
							<%
						}
						
					}
					%>
					
					<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getEnginestatus()%></td>									
		<%
				}
				else
				{
					%>		
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor3()%></td>
					<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor4()%></td>
					<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getEnginestatus()%></td>							
		<%
				}
			}
			else
			{
				%>		
				<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getSensor3()%></td>
				<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getSensor4()%></td>
				<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getEnginestatus()%></td>							
	<%
			}
			
			}
%>
<td style="text-align:left;<%=currentRecord.getBgColor()%>" align="left"><%=currentRecord.getBatterystatus()%></td>
<td style="text-align:right;<%=currentRecord.getBgColor()%>" align="right"><%=currentRecord.getBatterydate()%></td>
		</tr>
<%
		}
	} catch (Exception e) {
			out.println("<tr><td colspan=23>");
			out.println("Exception :" + e.getMessage());
			out.println("Cause : " + e.getCause());
			out.println("</td></tr>");
			//System.out.println("online time==");
			e.printStackTrace();
	}finally{
		try{
			conn.close();
			conn1.close();
		}catch(Exception e){}
	}
%>
	</table>
</body>
</jsp:useBean>
<%@ include file="footernew.jsp" %>