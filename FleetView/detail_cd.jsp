<%@ include file="headernew.jsp"%>

<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.Utilities"%>

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
	
<%
	final String vehicleRegistrationNumber = request.getParameter("vehno");
	final String vehicleCode = request.getParameter("vid");
	
	String fromDate="";
	String toDate="";
	
	String Frmdate11="";
	String Todate22="";
	fromDate=request.getParameter("data1");
	
	toDate=request.getParameter("data2");
	
	if(fromDate==null || fromDate.equals("null"))
	{
	 //System.out.println("----------fromdate is------------>>"+fromDate);
	  String fromDate1 = (null != request.getParameter("dd")) ? 
			request.getParameter("dd") : session.getAttribute("data1").toString();
	  String toDate1 = (null != request.getParameter("dd")) ? 
		request.getParameter("dd") : session.getAttribute("data2").toString();
		
		
		fromDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1+" 00:00:00"));
		toDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1+" 23:59:59"));
	}
		
	
	//Frmdate11=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate));
	//Todate22=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate));
	
	 session.setAttribute("data1",fromDate);
     session.setAttribute("data2",toDate);
		/*try
		{
			fromDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1));
			toDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1));

			
		}
		catch(Exception e)
		{
			
			fromDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate1+" 00:00:00"));
			toDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate1+" 23:59:59"));
			
		}*/
		
		
	final String tbname = "t_veh" + vehicleCode + "_cr";
	
	final String pageType=request.getParameter("pageType");
   
	
	
	
%>

<table border="1" width="100%" class="stats">
<%
	if(pageType.equalsIgnoreCase("ContinuousDriving"))
	{
%>
	<tr>
		<td colspan="6">
		<div align="left"><a href="javascript: history.go(-1)">Back</a>
		</div>
		<font size="3" face="Arial"><b>CONTINUOUS DRIVING for Vehicle <%=vehicleRegistrationNumber%>
		From Date:- <%
			java.util.Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(fromDate);
			Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
			String fromdt = formatter.format(date);
			out.print(fromdt);
		%> To Date:- <%
			java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(toDate);
			Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
			String todt = formatter1.format(date3);
			out.print(todt);
		%> </b></font>
		<div class="bodyText" align="right">&nbsp; &nbsp;<a
			href="excel_cddetails.jsp?vid=<%=vehicleCode%>&datat=<%=fromDate %>&datat1=<%=toDate %>"
			title="Export to Excel"><img src="images/excel.jpg" width="15px"
			height="15px"></a>&nbsp;&nbsp;&nbsp; Date : <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 	String curdate = fmt.format(new java.util.Date());
 	out.print(curdate);
 %>
		</div>
		</td>
	</tr>
<%
	}
	else 
	{
%>

	<tr><td colspan="2" align="center">
<%
if(session.getAttribute("reportno").toString().equals("Report No:3.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:3.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:4.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:4.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:5.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:5.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
if(session.getAttribute("reportno").toString().equals("Report No:6.0"))
{
	%>
	<div align="left"><font size="3">
	Report No:6.12
	</font>
	</div>
	<font size="3" face="Arial"><b>Night Driving Report</b></font>
	<%
}
%>
</td></tr>
<tr><td align="center"><font size="3">
 <b>NIGHT DRIVING REPORT for Vehicle <%=vehicleRegistrationNumber %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(toDate);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>
</b></font>
<div align="right">
<a href="#" onclick="javascript:window.open('Print_detail_nd.jsp?vid=<%=vehicleCode %>&vehno=<%=vehicleRegistrationNumber%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Export_detail_nd.jsp?vid=<%=vehicleCode %>&vehno=<%=vehicleRegistrationNumber%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

<%=Utilities.printDate() %>
</div>
</td></tr>
	
<%
	}
%>
	<tr>
		<td>
		<table class="sortable">
			<tr>
				<th><b>Sr. No.</b></th>
				<th><b>Start Date-Time </b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
			</tr>
			<%
				try {
					List<ContinuousDrivingDetailsData> data = null;
					int numRecords = 0;
					try {
						data = vehicleDao.getContinuousDrivingDetailsData(
								vehicleCode, fromDate, toDate, pageType);
						numRecords = data.size();
					} catch (Exception e) {
						e.printStackTrace();
					}
					for (int counter = 0; counter < numRecords; counter++) {
						final ContinuousDrivingDetailsData currentRecord = data
								.get(counter);
			%>
			<tr>
				<td style="text-align: right"><%=counter + 1%></td>
				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord
															.getStartDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord.getStartTime()))%></td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord
											.getStartLocation())
									&& null != currentRecord.getStartLocationLatitude()) {
				%> <a
					href="shownewmap.jsp?lat=<%=currentRecord
												.getStartLocationLatitude()%>&long=<%=currentRecord.getStartLocationLongitude()%>
								&discription=<%=currentRecord.getStartLocation()%>"
					onclick="popWin=open('shownewmap.jsp?lat=<%=currentRecord
												.getStartLocationLatitude()%>
													&long=<%=currentRecord
												.getStartLocationLatitude()%>
													&discription=<%=currentRecord.getStartLocation()%>', 
													'myWin','width=500, height=500'); 
													popWin.focus(); return false;"><%=currentRecord.getStartLocation()%></a>
				<%
					} else if (null != currentRecord.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord
											.getStartLocation())) {
								out.println(currentRecord.getStartLocation());
							}
				%>
				</div>
				</td>
															
				<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord
															.getEndDate())) %> <%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(currentRecord.getEndTime()))%></td>												
				<td>
				<div align="left">
				<%
					if (null != currentRecord.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord
											.getEndLocation())
									&& null != currentRecord.getEndLocationLatitude()) {
				%> <a
					href="shownewmap.jsp?lat=<%=currentRecord.getEndLocationLatitude()%>&long=<%=currentRecord.getEndLocationLongitude()%>
								&discription=<%=currentRecord.getEndLocation()%>"
					onclick="popWin=open('shownewmap.jsp?lat=<%=currentRecord.getEndLocationLatitude()%>
													&long=<%=currentRecord.getEndLocationLongitude()%>
													&discription=<%=currentRecord.getEndLocation()%>', 
													'myWin','width=500, height=500'); 
													popWin.focus(); return false;"><%=currentRecord.getEndLocation()%></a>
				<%
					} else if (null != currentRecord.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord
											.getEndLocation())) {
								out.println(currentRecord.getEndLocation());
							}
				%>
				</div>
				</td>

				<td>
				<div align="right"><%=currentRecord.getDistancetravelled()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord.getDuration()%></div>
				</td>

			</tr>
			<%
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</table>
		</td>
	</tr>
</table>
<%@ include file="footernew.jsp"%>
