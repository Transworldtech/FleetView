

<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.DriverDebriefingData"
		import="com.transworld.fleetview.framework.DriversLastTrip"%>
		
<%@ include file="headernew.jsp" %>		
<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>
			 
			
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<script language="javascript">

</script>

<%!
	 String driveridjsp = "";
%>

 
<form name="driverbriefingform" method="POST" action="" onSubmit="return validate();" >

<%
String vehfit="";
Connection con1;
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();  
Statement stmt2=con1.createStatement();  
	try {
		
		final String msg = (String) request.getParameter("msg");
		final String briefid = (String) request.getParameter("briefId");
		final String driver = (String) request
				.getParameter("drivername");

		final String srchval = request.getParameter("srchbx");
%>

<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table border="0" width="100%" class="stats">
			<tr>
				<td>
				<div align="center"><font size="2"> <B>
				Driver Briefing </B> </font></div>
				</td>
			</tr>
		</table>

		<%
			final String inserted = request.getParameter("inserted");
				if (inserted == null) {
				} else {
		%>
		<table border="0" width="100%" class="stats">
			<tr>
				<td align="center"><font color="green"><b><blink>
				Successfully Saved</blink></b> And the brief Id is : <%=briefid%> for <%=driver%>
				!!!!</font></td>
			</tr>
		</table>
		<%
			}
		%>
		<table class="stats">

			<tr>
				<td>
					<div align="left"> <B> Search </B> &nbsp;&nbsp;&nbsp; 
						<input type="text" name="srchbx" class="formElement"  /> &nbsp;&nbsp;&nbsp;
                         <input type="submit" value="Submit" name="btnSearch"  class="formElement" />
	                         	Please enter Driver Name or Driver Id. Matching values would come below in the table automatically .
		        	</div>
				</td>
			</tr>
		</table>

		<table class="stats">

			<tr>
				<td>
				<div id="driverinfo"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	String searchValue = request.getParameter("srchbx");
		if (null != searchValue) {
			int i = 1;
			searchValue = searchValue.replace(" ", "");

			List<DriverDebriefingData> data = null;
			int numRecords = 0;
			try {
				data = vehicleDao.getDebriefingData(session
						.getAttribute("usertypevaluemain").toString(),
						searchValue, session.getId());
				numRecords = data.size();
				//System.out.println("numrecs=="+numRecords);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			List<DriversLastTrip> tripData=null;
			int numOfTripRecords=0;
%>
<center>
<table border='1' width='50%' class='sortable'>
	<tr>
		<th>Sr.No.</th>
		<th>Driver Name</th>
		<th>Driver Id</th>
		<th>Transporter</th>
		<th>Last Trip DateTime</th>
		<th>Briefing/De-briefing Status</th>
		<th>Vehicle Fit Status</th>
	</tr>
	<%
	int Msgid = 0;
		for (int counter = 0; counter < numRecords; counter++) {
					final DriverDebriefingData currentRecord = data
							.get(counter);

	
		String sql3 = "select * from db_gps.t_usermessage where UserTypeValue  = '"+currentRecord.getDriverOwner()+"' ";
		ResultSet rs3 = stmt2.executeQuery(sql3);
		if(rs3.next())
		{
			Msgid = rs3.getInt("MessageID");
		}
		
		 if(Msgid == 4)
		 {
			 
			 %>
			 <tr>
			 <td style='text-align: right'><%=i%></td>
			 <td style='text-align: left'><%=currentRecord.getDriverName()%></td>
			 <td style='text-align: right'><%=currentRecord.getDriverID()%></td>
			  <td style='text-align: left'><%=currentRecord.getDriverOwner()%></td>
			<td style='text-align: left' colspan="3">Blocked</td>
			 <%
		 }
		 else
		 {
			%>
	<tr>
		<td style='text-align: right'><input type='hidden'
			name='drivid"+i+"' id='drivid"+i+"'
			value='<%=currentRecord.getDriverID()%>'> <input
			type='hidden' name='drvrname"+i+"' id='drvrname"+i+"'
			value='<%=currentRecord.getDriverName()%>'> <%=i%></td>
<%
		try{
			tripData=vehicleDao.getDriversLastTrip(currentRecord.getDriverID(),session.getAttribute("usertypevaluemain").toString());
			numOfTripRecords=tripData.size();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		
				if(null==currentRecord.getBriefStatus() || "null".equalsIgnoreCase(currentRecord.getBriefStatus()) || null==currentRecord.getDebriefStatus() ||"null".equalsIgnoreCase(currentRecord.getDebriefStatus()))
				{
%>
		<td style='text-align: left'><a href='brifsbmt.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>'>
		<%=currentRecord.getDriverName()%></a></td>
			
<%
		}
		else if(("briefed".equals(currentRecord.getBriefStatus())) && ("not debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus())))
		{
			
%>
		<td style='text-align: left'><a href="debrifsbmt.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>&briefid=<%="Briefid"%>">
			<%=currentRecord.getDriverName()%></a></td>
<%
		
		}
		else if(("debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus()) || ("debrifed".equalsIgnoreCase(currentRecord.getDebriefStatus())) ))
		{
%>
			
<%			
		}
%>

		<td style='text-align: right'><%=currentRecord.getDriverID()%></td>
		<td style='text-align: left'><%=currentRecord.getDriverOwner()%></td>
<%
			if(numOfTripRecords>0)
			{
				for(int c=0;c<numOfTripRecords;c++){
					DriversLastTrip tripRecord = tripData.get(c);
				if(null==tripRecord.getStartDate()||"null".equalsIgnoreCase(tripRecord.getStartDate()))
				{
%>
					<td style='text-align: left'><%="-"%></td>
<%			
				}
				else{
%>
					<td style='text-align: left'><%=tripRecord.getStartDate()%></td>	
<%			
					}
			}
		}
		else{
			%>
			<td style='text-align: left'><%="-"%></td>	
<%			
		}
%>
<%//System.out.println("STATUS : : :"+currentRecord.getBriefStatus()+"---"+currentRecord.getDebriefStatus());
		if(null==currentRecord.getBriefStatus() || "null".equalsIgnoreCase(currentRecord.getBriefStatus()) || null==currentRecord.getDebriefStatus() ||"null".equalsIgnoreCase(currentRecord.getDebriefStatus()))
		{
			%>
				<td style='text-align: left'><%="De-briefed"%></td>
			<%
		}
		else if(("briefed".equals(currentRecord.getBriefStatus())) && ("not debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus())))
		{
			
%>
			<td style='text-align: left'><%="Briefed"%></td>
<%			
		}
		else if(("debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus()) || ("debrifed".equalsIgnoreCase(currentRecord.getDebriefStatus())) ))
		{
%>
			
<%			
		}
		if(null==currentRecord.getBriefStatus() || "null".equalsIgnoreCase(currentRecord.getBriefStatus()) || null==currentRecord.getDebriefStatus() ||"null".equalsIgnoreCase(currentRecord.getDebriefStatus()))
		{
			String sql = "SELECT * from db_gps.t_debriefing where Briefid='"+currentRecord.getBriefId()+"' and driverid='"+currentRecord.getDriverID()+"'";
			ResultSet rs= stmt1.executeQuery(sql);
			
			if(rs.next()){
				if(null==rs.getString("vehfitnext")|| "null".equalsIgnoreCase(rs.getString("vehfitnext"))|| "No".equalsIgnoreCase(rs.getString("vehfitnext")) || "-".equalsIgnoreCase(rs.getString("vehfitnext"))|| "".equalsIgnoreCase(rs.getString("vehfitnext")))
				{
					vehfit = "No";
				}
				else if("Yes".equalsIgnoreCase(rs.getString("vehfitnext"))){
					vehfit = "Yes";
				}
			}
			else{
				vehfit = "No";
			}
			
		}
		else if(("briefed".equals(currentRecord.getBriefStatus())) && ("not debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus())))
		{
			String sql = "SELECT * from db_gps.t_briefing where Briefid='"+currentRecord.getBriefId()+"' and driverid='"+currentRecord.getDriverID()+"'";
			ResultSet rs= stmt1.executeQuery(sql);
			if(rs.next()){
				if(null==rs.getString("vehfit")|| "null".equalsIgnoreCase(rs.getString("vehfit"))|| "No".equalsIgnoreCase(rs.getString("vehfit")) || "-".equalsIgnoreCase(rs.getString("vehfit"))|| "".equalsIgnoreCase(rs.getString("vehfit")))
				{
					vehfit = "No";
				}
				else if("Yes".equalsIgnoreCase(rs.getString("vehfit"))){
					vehfit = "Yes";
				}
			}
			else{
				vehfit = "No";
			}
		}
		%>
		<td style='text-align: left'><%=vehfit%></td>
	<%
%>
	</tr>

<%
	i++;
		 }
			}

			if (i <= 1) {
				 if(Msgid == 4)
				 {
				 %>
				 
				 <%
				 }
				 else
				 {
%>
<center> 
	<table border='1' width='50%'>
		<tr> <th> Driver does not exist. </th> </tr>
	</table>
</center><%
				 }
%>

<!--<center> 
	<table border='1' width='50%'>
		<tr> <th> <a href='addDriver.jsp?frPg=Brief' >    Please Click here to add the driver.  </a> </th> </tr>
	</table>
</center>-->
<%
				
	}
		
		}
			%>
			</table>
		    </center>
		<%
		

	} catch (Exception e) {
		e.printStackTrace();
	}
	finally{
		stmt1.close();
		con1.close();
	}
%>
</form>

<%@ include file="footernew.jsp" %>
