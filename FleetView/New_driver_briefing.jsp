

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
Statement stmt4=con1.createStatement(); 
Statement stmt41=con1.createStatement(); 
	try {
		
		final String msg = (String) request.getParameter("msg");
		final String briefid = (String) request.getParameter("briefId");
		System.out.println("***************"+briefid);
;
		final String driver = (String) request.getParameter("drivername");
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
		<tr>
				<td align="left"><div align="left">If you want to see all pending Briefing \ De-briefing <a href= "driver_briefing_open.jsp" target="_blank" >click here</a></div></td>
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
String S1= "";
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

<table border='1' width='50%' class='sortable'>
	<tr>
		<th>Sr.No.</th>
		<th>Driver Name</th>
		<th>Driver Id</th>
		<th>Status</th>
		<th>Transporter</th>
		<th>Last Trip DateTime</th>
		<th>Briefing/De-briefing Status</th>
		<th>Vehicle Fit Status</th>
	</tr>
	<%
	String RejectStatus="",BrifingStatus="",DebriefingStatus="",BriefidN="",tripid="",brifdate="",startplace="",VehType="",endplace="",VehRegNo="",probenddate="",CleanerName="",CleanerId="",Transporter="",StatDrv="";
	
	
	int Msgid = 0;
		for (int counter = 0; counter < numRecords; counter++) {
					final DriverDebriefingData currentRecord = data
							.get(counter);

		Msgid = 0;	    
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
			 <td><%=RejectStatus %></td>
			  <td style='text-align: left'><%=currentRecord.getDriverOwner()%></td>
			<td style='text-align: left' colspan="5">Blocked</td>
			 <%
		 }
		 else
		 {
			 S1="-";
				BrifingStatus="Open";
				DebriefingStatus="-";
				
			%>
	<tr>
		<td style='text-align: right'><input type='hidden'
			name='drivid"+i+"' id='drivid"+i+"'
			value='<%=currentRecord.getDriverID()%>'> <input
			type='hidden' name='drvrname"+i+"' id='drvrname"+i+"'
			value='<%=currentRecord.getDriverName()%>'> <%=i%></td>
	
<%		
				String sql4 = "SELECT * from db_gps.t_briefing where Briefid='"+currentRecord.getBriefId()+"' and driverid='"+currentRecord.getDriverID()+"'";
				ResultSet rs4= stmt4.executeQuery(sql4);
				System.out.println("My Query : "+sql4);
				
				System.out.println("1111111111"+currentRecord.getBriefId());
				if(rs4.next()){
					
					BrifingStatus=rs4.getString("Status");
					DebriefingStatus=rs4.getString("DeBrifingStatus");
					probenddate=rs4.getString("probenddate");
					BriefidN=rs4.getString("Briefid");
					tripid=rs4.getString("tripid");
					brifdate=rs4.getString("brifdate");
					startplace=rs4.getString("startplace");
					endplace=rs4.getString("endplace");
					VehType=rs4.getString("VehType");

					VehRegNo=rs4.getString("VehRegNo");
					Transporter=rs4.getString("Transporter");
					CleanerName=rs4.getString("CleanerName");
					CleanerId=rs4.getString("CleanerId");

				}



		try{
			tripData=vehicleDao.getDriversLastTrip(currentRecord.getDriverID(),session.getAttribute("usertypevaluemain").toString());
			numOfTripRecords=tripData.size();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		System.out.println(currentRecord.getDriverID()+"1111111111"+currentRecord.getBriefStatus()+" 2222222 "+currentRecord.getDebriefStatus());
		System.out.println("1111111111"+DebriefingStatus+"  333333 "+BrifingStatus);
		
		
		RejectStatus="-";
		String sql41 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver WHERE ReasoneForRejection='Driver Rejection'  and DriverId ='"+currentRecord.getDriverID()+"' ORDER BY UpdatedDateTime DESC";
		ResultSet rs41= stmt41.executeQuery(sql41);
		System.out.println("Loop 1 :"+sql41);
		if(rs41.next()){
		if(rs41.getString("Status").equalsIgnoreCase("Yes"))
			{RejectStatus="Rejected";				
			}
		else 
			{
				RejectStatus="Pass";					
			}
		
			}else
			{
				RejectStatus="-";	
			}
		
		
		
		
		
		if(RejectStatus.equalsIgnoreCase("Rejected"))
		{
		%>
		<td style='text-align: left'>		
		<a href="#" onclick="javascript:window.open('driver_briefing_Driver_Reject.jsp?driverid=<%=currentRecord.getDriverID()%>','','menubar=1,resizable=1,scrollbars=1,width=800,height=200');"><%=currentRecord.getDriverName() %> </a>
		</td>
		
	<%	
		
		}
		else{
			
			
		if(null==currentRecord.getBriefStatus() || "null".equalsIgnoreCase(currentRecord.getBriefStatus()) || null==currentRecord.getDebriefStatus() ||"null".equalsIgnoreCase(currentRecord.getDebriefStatus()))
		{
	
				%>
			<td style='text-align: left'><a href='BrifReg.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>'>
			<%=currentRecord.getDriverName()%> </a></td>
			
		<%	
		S1="DeBriefed";
		%>
	
<%	
		}else if(("briefed".equals(currentRecord.getBriefStatus())) && ("not debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus())))
		{
			if(DebriefingStatus.equalsIgnoreCase("-") && BrifingStatus.equalsIgnoreCase("Close"))
			{	
%>
		<td style='text-align: left'><a target="_blank"  href="driver_debrifing_Reg_New.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>&briefid=<%=currentRecord.getBriefId() %>">
			<%=currentRecord.getDriverName()%></a></td>
<%
			S1="Briefed";
			}
			else if(DebriefingStatus.equalsIgnoreCase("Open") && BrifingStatus.equalsIgnoreCase("Close"))			
			{			
			%>
			<td style='text-align: left'><a  target="_blank" href= "driver_debriefing_Update.jsp?driverid=<%=currentRecord.getDriverID()%>&briefid=<%=BriefidN%>&drivername=<%=currentRecord.getDriverName()%>&TripId=<%=tripid %>&PDate=<%=probenddate %>&veh=<%=VehRegNo %>&transporter=<%=Transporter %>" target="_blank" >
					<%=currentRecord.getDriverName()%></a></td>
			<%
			S1="Open Debriefing";
			}
			else if(DebriefingStatus.equalsIgnoreCase("-") && BrifingStatus.equalsIgnoreCase("Open"))
			{
				if(i==270)
				{System.out.println("asassas");}
				%>
				<td style='text-align: left'><a  target="_blank" href="briefing_page.jsp?driverid=<%=currentRecord.getDriverID()%>&transporter=<%=currentRecord.getDriverOwner() %>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>&briefId=<%=BriefidN %>&TripId=<%=tripid %>&BrifDate=<%=brifdate %>&startP=<%=startplace %>&endP11=<%=endplace %>&veh=<%=VehRegNo %>&VehType=<%=VehType %>&CleanerId=<%=CleanerId %>&CleanerName=<%=CleanerName %>">	
						<%=currentRecord.getDriverName()%></a></td>
						
						
			<%
			S1="Open Briefing";
			
			}else
			{
		
			
				%>
				<td style='text-align: left'><a  target="_blank" href='BrifReg.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>'>
				<%=currentRecord.getDriverName()%> </a></td>
			<%	
			S1="DeBriefed";
						
		
		%>		
	<%}
			%>
			
			<%
			}
		else if(("debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus()) || ("debrifed".equalsIgnoreCase(currentRecord.getDebriefStatus())) ))
	{			%>
				<td style='text-align: left'><a  target="_blank" href='BrifReg.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>'>
				<%=currentRecord.getDriverName()%> </a></td>
			<%	
			S1="DeBriefed";
						
		
		%>
		
		
				
	<%
			
			}
		
		 }
%>
	
	
		<td style='text-align: right'><%=currentRecord.getDriverID()%></td>
				<td><%=RejectStatus %></td>
		<td style='text-align: left'><%=currentRecord.getDriverOwner()%></td>
		
<%
RejectStatus="-";
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
<%System.out.println("STATUS : : :"+currentRecord.getBriefStatus()+"---"+currentRecord.getDebriefStatus());
		if(null==currentRecord.getBriefStatus() || "null".equalsIgnoreCase(currentRecord.getBriefStatus()) || null==currentRecord.getDebriefStatus() ||"null".equalsIgnoreCase(currentRecord.getDebriefStatus()))
		{
			%>
				<td style='text-align: left'><%=S1%></td>
			<%
		}
		else if(("briefed".equals(currentRecord.getBriefStatus())) && ("not debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus())))
		{
			
%>
			<td style='text-align: left'><%=S1%></td>
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
	
		 }
		 i++;
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
