<%@page import="com.transworld.fleetview.framework.VehiclePositionData"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
		import="com.transworld.fleetview.framework.VehiclePositionsViewData"
		import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.Utilities"
		import="com.transworld.fleetview.framework.VehiclePositionsViewDataResults"%>		

<%@ include file="headernew.jsp"%>

<link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>

<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>

<jsp:useBean id="vehiclePositionsViewDataProvider" 
			 type="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
			 scope="application"></jsp:useBean>	

<script type="text/javascript">
function toggleDetails(id, show)
{
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
			} else {
		popup.style.visibility = "hidden";
	}
}

function toggleDetails1(id, show)
{
	var popupx = document.getElementById("popupx"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
		
	} else {
		popupx.style.visibility = "hidden";
	}
}
</script>

<%
	final String userTypeValue = session.getAttribute("usertypevalue").toString();
	final String typeOfUser = session.getAttribute("TypeofUser").toString();
	final String distanceFormat = session.getAttribute("distformat").toString();
	final String fuelFormat = session.getAttribute("fuelformat").toString();
	final String commaSeparatedVehicleList = session.getAttribute("VehList").toString();
	final int disConnected = Integer.parseInt(session.getAttribute("desconnected").toString());

	String requestParamSearchVeh = request.getParameter("searchveh");
	if (null == requestParamSearchVeh) {
		requestParamSearchVeh = "";
	}
	
	@SuppressWarnings("unchecked")
	final VehiclePositionsViewDataResults viewData = 
		(VehiclePositionsViewDataResults) session.getAttribute("VehiclePositionsViewData");
	int numRecords = 0;
	try{
		 numRecords = viewData.getCount();
	} catch(Exception e){
		e.printStackTrace();
	}	
	
	
	session.setAttribute("viewdata",viewData);
	
%>
<form name="CountOfRecordsForm">
		<input type="hidden" name= "cnt" id="cnt" value=<%=numRecords%>></input>
	</form>
			<table width="100%" align="center" class="stats" >
			<tr>
			<td align="center">
			<!-- <div align="left"><font size="3">Report No:1.7</font></div>-->
			<div><font size="3"> <b>Device Not Active Vehicle </b></font></div>
			
			<!--<div align="right">
				<a href="#" onclick="javascript:window.open('printinactive.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelinactive.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%//=Utilities.printDate() %>
				</div>-->
				
				<div align="right">
				<a href="#" onclick="javascript:window.open('GenericPrint.jsp?&sessiondata=VehiclePositionsViewData&key=Device Installed But Inactive&condition=ShowTripInfo');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="GenericExportExcel.jsp?&sessiondata=VehiclePositionsViewData&key=Device Installed But Inactive&condition=ShowTripInfo"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=Utilities.printDate() %>
				</div>
			</td>
			</tr>
			</table>
			
			<!-- the logic come Here --->
			<table border="0" width="100%" align="center">
			
			<%
			//out.print(session.getAttribute("usertypevalue"));
			if(session.getAttribute("usertypevalue").equals("Castrol EMP VEH"))
			{	
			%>
			<tr bgcolor="#F0E68C">
		<td class="sorttable_nosort" width="15%"><b class="bodyText">Color Code Indications :<a href="castrolempmain.jsp">Full Fleet</a></b></td >
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="empmoving.jsp">Moving</a></b></td>
		<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="empstopped.jsp">Stop</a></b></td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="activeTrips.jsp">ActiveTrips</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
		
		
		<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="empdisconnected.jsp">Disconnected</a></b></td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
		<td bgcolor="#EEC5C8" class="sorttable_nosort" ><b><a href="disconnected.jsp">Deactivated</a></b></td>
		<td bgcolor="#D4C0F0" class="sorttable_nosort" ><b><a href="missing.jsp">Missing</a></b></td>
							<td bgcolor="#FFC475" class="sorttable_nosort"><b><a href="maindisconnected.jsp">Mains Disconnection</a></b></td>
		
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="activeTrips.jsp">ActiveTrips</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
		</tr>	
		<% 
			}
			else
			{	
		%>	
			<tr bgcolor="#F0E68C">
		<td class="sorttable_nosort" width="15%"><b>Color Code Indications :&nbsp;&nbsp;<a href="currentposition.jsp">Full Fleet</a></b></td>
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="moving.jsp">Moving</a></b></td>
		<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="stopped.jsp">Stop</a></b></td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="activeTrips.jsp">ActiveTrips</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
		
		
		
		<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="disconnected.jsp">Disconnected</a></b></td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
	<td bgcolor="#EEC5C8" class="sorttable_nosort" ><b><a href="deactivate.jsp">Deactivated</a></b></td>
		<td bgcolor="#D4C0F0" class="sorttable_nosort" ><b><a href="missing.jsp">Missing</a></b></td>
							<td bgcolor="#FFC475" class="sorttable_nosort"><b><a href="maindisconnected.jsp">Mains Disconnection</a></b></td>
		
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>	
		<%} %>
			</table>
		
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Vehicle Reg.No.</th>
			<th class="hed"> Installed Date</th>
			<th class="hed"> Installed Location</th>
			</tr>	
<%
			try {
					int i = 1;
					for (int counter = 0; counter < numRecords; counter++) {
					final VehiclePositionsViewData currentRecord = viewData.getVehiclePositionViewDataAtIndex(counter);
					
					
					if(currentRecord.getDeviceStatus().equalsIgnoreCase("Device Installed But Inactive"))
					{
%>
					<tr>
						<td><%=i++%></td>	
						<td><%=currentRecord.getVehicleRegistrationNo()%></td>	
						<td><%=currentRecord.getLastUpdatedDateTime() %></td>
						<td><%=currentRecord.getInstalledPlace()%></td>	
<%
					}
					}
			}
			catch(Exception e)
			{
				out.println("<tr><td colspan=23>");
				out.println("Exception :" + e.getMessage());
				out.println("Cause : " + e.getCause());
				out.println("</td></tr>");
				e.printStackTrace();
			}
%>			
			</table>
			<%@ include file="footernew.jsp" %>