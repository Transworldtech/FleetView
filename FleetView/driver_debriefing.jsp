<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.DriverDebriefingData"
		import="com.transworld.fleetview.framework.DriversLastTrip"%>

<%@ include file="headernew.jsp" %>

<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>
<script LANGUAGE="JavaScript1.2" SRC="js/graph.js"></script>

<script language="javascript">

function GetDrivers()
{	
	var count=(document.driverbriefingform.srchbx.value).length+1;
	if(count>2)
	{
		var srchval=document.driverbriefingform.srchbx.value;
		var ajaxRequest = null;
		try
		{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		}  
		catch (e)
		{
			// Internet Explorer Browsers
			try
			{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e)
			{
				try
				{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} 
				catch (e)
				{
					// Something went wrong
					alert("Your browser apparently does not support AJAX."+
							"\nKindly contact technical support for further information.");
					return false;
		        }
			}
		}

		if(null==ajaxRequest) 
		{
			alert("Your browser apparently does not support AJAX."+
			"\nKindly contact technical support for further information.");
			return false;			
		}

        // Create a function that will receive data sent from the server
        ajaxRequest.onreadystatechange = function()
        {
            if(ajaxRequest.readyState == 4)
            {
                var reslt=ajaxRequest.responseText;
                document.getElementById("driverinfo").innerHTML=reslt;
		    }
        };
        
        var queryString = "?srchval=" +srchval;
        ajaxRequest.open("GET", "Ajaxgetdriversde.jsp" + queryString, true);
        ajaxRequest.send(null);
	}
}

function showtable(i)
{
	document.getElementById("drvrbriefrep").style.display="";
	document.driverbriefingform.drvrname.value=document.getElementById("drvrname"+i).value;	
	document.driverbriefingform.drvrid.value=document.getElementById("drivid"+i).value;
}
</script>

<form name="driverbriefingform" method="get" action="" onSubmit="return validate();">

<%
	try {
		final String briefId = (String) request.getParameter("briefId");
%>

<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table border="0" width="100%">
			<tr>
<%
		if (null == briefId) {
%>

				<td>
				<div align="center"><font color="maroon" size="2"> <b>
				Driver De-Briefing </b> </font></div>
				</td>
<%
		} else {
%>
				<td>
				<div align="center"><font color="maroon" size="2"> <b>
				Driver De-Briefing and Brief Id is <%=briefId%> </b> </font></div>
				</td>
<%
		}
%>
			</tr>
		</table>

<%
		final String inserted = request.getParameter("inserted");
		final String debriefId = (String) request.getParameter("debriefId");
		if (null != inserted) {
%>
		<table border="0" width="100%">
			<tr>
				<td align="center"><font color="maroon" size="1"><b>
				Successfully Saved deBrief Id:<%=debriefId%></b></font></td>
			</tr>
		</table>
<%
		}
%>
		<table class="stats">
			<tr>
				<td>
				<div align="left"><B> Search </B> &nbsp;&nbsp;&nbsp; 
				<input type="text" name="srchbx" class="formElement" />&nbsp;&nbsp;&nbsp;
				<input type="submit" value="submit"	name="btnSearch" />
				Please enter Driver Name or Drive Id. Matching
				names would come below in the table automatically .</div>
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
		if (null!=searchValue) {
			int i = 1;
			searchValue = searchValue.replace(" ", "");

			List<DriverDebriefingData> data = null;
			int numRecords = 0;
			try {
				data = vehicleDao.getDebriefingData(
						session.getAttribute("usertypevaluemain").toString(),
						searchValue, session.getId());
				numRecords = data.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			List<DriversLastTrip> tripData=null;
			int numOfTripRecords=0;
%>
<center> 
<table border='1' width='50%' class='stats'>
	<tr> 
		<th> Sr.No.</th> 
		<th> Driver Name</th> 
		<th> Driver Id </th> 
		<th> Transporter </th> 
		<th>Last Trip DateTime</th>
		<th>Briefing/De-briefing Status</th>
	</tr>
<%
			for (int counter = 0; counter < numRecords; counter++) {
				final DriverDebriefingData currentRecord = data.get(counter);
%>
	<tr> 
		<td style='text-align:right'>
			<input type='hidden' name='drivid"+i+"' id='drivid"+i+"' value='<%=currentRecord.getDriverID()%>'>
			<input type='hidden' name='drvrname"+i+"' id='drvrname"+i+"' value='<%=currentRecord.getDriverName()%>'>
			<%=i%>
		</td >
		<td style='text-align:left'> 
			<a href='debrifsbmt.jsp?driverid=<%=currentRecord.getDriverID()%>&drivername=<%=currentRecord.getDriverName()%>&trans=<%=currentRecord.getDriverOwner()%>'> <%=currentRecord.getDriverName()%></a> 
		</td> 
		<td style='text-align:right'><%=currentRecord.getDriverID()%></td> 
		<td style='text-align:left'><%=currentRecord.getDriverOwner()%></td> 
<%
		try{
			tripData=vehicleDao.getDriversLastTrip(currentRecord.getDriverID(),session.getAttribute("usertypevaluemain").toString());
			numOfTripRecords=tripData.size();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		if(numOfTripRecords>0)
		{
			for(int c=0;c<numOfTripRecords;c++){
				DriversLastTrip tripRecord = tripData.get(c);
				if(null==tripRecord.getStartDate()||"null".equalsIgnoreCase(tripRecord.getStartPlace()))
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
		
<%
if(null==currentRecord.getBriefStatus() || "null".equalsIgnoreCase(currentRecord.getBriefStatus()) || null==currentRecord.getDebriefStatus() ||"null".equalsIgnoreCase(currentRecord.getDebriefStatus()))
		{
			%>
				<td style='text-align: left'><%="De-briefed"%></td>
			<%
		}
		else if(("briefed".equalsIgnoreCase(currentRecord.getBriefStatus())) && ("not debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus())))
		{
%>
			<td style='text-align: left'><%="Briefed"%></td>
<%			
		}
		else if(("briefed".equalsIgnoreCase(currentRecord.getBriefStatus())) && ("debriefed".equalsIgnoreCase(currentRecord.getDebriefStatus()) || ("debrifed".equalsIgnoreCase(currentRecord.getDebriefStatus())) ))
		{
%>
			<!--<td style='text-align: left'>< %="De-briefed"%></td>-->
<%			
		}
%>
	</tr>

<%
				i++;
			}

			if (i <= 1) {
%>
<tr>
<center> 
	<table border='1' width='50%'>
		<tr> <th> Driver does not exist. </th> </tr>
	</table>
</center>
<!--  
<center> 
	<table border='1' width='50%'>
		<tr> <th> <a href='addDriver.jsp?frPg=deBrief'>    Please Click here to add the driver.  </a> </th> </tr>
	</table>
</center>
-->
</tr>

<%
			}
			%>
			</table>
		    </center>
		<%
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</form>
