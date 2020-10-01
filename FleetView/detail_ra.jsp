<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
		import="com.transworld.fleetview.framework.Utilities" %>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
	
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

</script>

<%try{
	final String vehicleCode = request.getParameter("vid");
	final String vehicleRegistrationNumber = request.getParameter("vehno");
	final String fromDate = (null != request.getParameter("dd")) ? request
			.getParameter("dd")
			: session.getAttribute("data1").toString();
	final String toDate = (null != request.getParameter("dd")) ? request
			.getParameter("dd")
			: session.getAttribute("data2").toString();
	final String pageType = request.getParameter("pageType");
	
	session.setAttribute("data1",fromDate);
	session.setAttribute("data2",toDate);
%>
<table border="0" width="100%" class="stats">
	<tr>
		<td align="center">
<%
if (session.getAttribute("reportno").toString().equals(
"Report No:1.0")) {
%>
	<!-- <div align="left"><font size="3">
	Report No:1.9
	</font>
	</div>-->
	<font size="3" face="Arial"><b>Rapid Acceleration Report</b></font>
<%
}
	if (session.getAttribute("reportno").toString().equals(
			"Report No:3.0")) {
%>
				<!--<div align="left"><font size="3">
				Report No:3.9
				</font>
				</div>-->
				<font size="3" face="Arial"><b>Rapid Acceleration Report</b></font>
<%
	}
	if (session.getAttribute("reportno").toString().equals(
			"Report No:4.0")) {
%>
				<!--<div align="left"><font size="3">
				Report No:4.9
				</font>
				</div>-->
				<font size="3" face="Arial"><b>Rapid Acceleration Report</b></font>
<%
	}
	if (session.getAttribute("reportno").toString().equals(
			"Report No:5.0")) {
%>
				<!--<div align="left"><font size="3">
				Report No:5.9
				</font>
				</div>-->
				<font size="3" face="Arial"><b>Rapid Acceleration Report</b></font>
<%
	}
	if (session.getAttribute("reportno").toString().equals(
			"Report No:6.0")) {
%>
				<!--<div align="left"><font size="3">
				Report No:6.9
				</font>
				</div>-->
				<font size="3" face="Arial"><b>Rapid Acceleration Report</b></font>
<%
	}
%>
		</td>
	</tr>
<%
//	System.out.println("Page type value************ "+pageType);
	if (pageType.equalsIgnoreCase("RapidAcceleration")) {
%>
	<tr>
		<td align="center"><font size="3" face="Arial"> <b>RAPID
		ACCELERATION REPORT for Vehicle <%=vehicleRegistrationNumber%> From
		Date :<%
 	java.util.Date date = new SimpleDateFormat("yyyy-MM-dd")
 				.parse(fromDate);
 		Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
 		String fromdt = formatter.format(date);
 		out.print(fromdt);
 %> To Date :<%
 	java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd")
 				.parse(toDate);
 		Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
 		String todt = formatter1.format(date3);
 		out.print(todt);
 %> </b> </font>
		<div class="bodyText" align="right"><a href="#"
			onclick="javascript:window.open('print_detail_ra.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>');"
			title="Print Report"><img src="images/print.jpg" width="15px"
			height="15px"></a>&nbsp; &nbsp; <a
			href="Exportdetail_ra.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a>&nbsp;&nbsp;&nbsp; <%=Utilities.printDate()%></div>
		</td>
	</tr>
<%
		} else {
%>
	<tr>
		<td align="center"><font size="3"> <b>RAPID
		DE-ACCELERATION REPORT for Vehicle <%=vehicleRegistrationNumber%> From Date :<%
 	java.util.Date date = new SimpleDateFormat("yyyy-MM-dd")
 				.parse(fromDate);
 		Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
 		String fromdt = formatter.format(date);
 		out.print(fromdt);
 %> To Date :<%
 	java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd")
 				.parse(toDate);
 		Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
 		String todt = formatter1.format(date3);
 		out.print(todt);
 %> </b></font>
		<div class="bodyText" align="right"><a href="#"
			onclick="javascript:window.open('print_detail_rd.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>');"
			title="Print Report"><img src="images/print.jpg" width="15px"
			height="15px"></a>&nbsp; &nbsp; <a
			href="Exportdetail_rd.jsp?vid=<%=vehicleCode%>&vehno=<%=vehicleRegistrationNumber%>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a>&nbsp;&nbsp;&nbsp; <%=Utilities.printDate()%></div>
		</td>
	</tr>
<%
		}
%>
	<tr>
		<td>
			<table class="sortable">
			<tr>
			<th>Sr.</th>
			<th>Date </th>
			<th>Time </th>
			<th>From Speed</th>
			<th>To Speed</th>
			<th>Location </th>
			</tr>
<%
	try {
		List<RapidAccelerationDetailsData> data = null;
		int numRecords = 0;
		try {
			data = vehicleDao.getRapidAccelerationDetailsData(
						vehicleCode, fromDate+" 00:00:00", toDate+" 23:59:59", pageType);
			numRecords = data.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords; counter++) {
			final RapidAccelerationDetailsData currentRecord = data
					.get(counter);
%>
					<tr>
					<td style="text-align: right"><%=counter + 1%></td>
					<td style="text-align: left">
						<%=new SimpleDateFormat("dd-MMM-yyyy")
									.format(new SimpleDateFormat("yyyy-MM-dd")
											.parse(currentRecord.getDate()))%>
					</td>
					<td style="text-align: left"><%= new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord.getTime())) %></td>
					<td><div align="right"><%=currentRecord.getFromSpeed()%></div></td>
					<td><div align="right"><%=currentRecord.getToSpeed()%></div></td>
					<td><div align="left">
<%
	if (null != currentRecord.getLocation()
					&& !"null".equalsIgnoreCase(currentRecord
							.getLocation())
					&& null != currentRecord.getLatitude()) {
								String lat1=currentRecord.getLatitude();
								String lon1=currentRecord.getLongitude();
								String disc=currentRecord.getLocation();
%>							 
								<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
 	} else if (null != currentRecord.getLocation()
 					&& !"null".equalsIgnoreCase(currentRecord
 							.getLocation())) {
 				out.println(currentRecord.getLocation());
 			}
 %>
					</div></td>
					</tr>
<%
	}
	} catch (Exception e) {
		e.printStackTrace();
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>
			</table>
		</td>
	</tr>
</table>
 <%@ include file="footernew.jsp" %>