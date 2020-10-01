<%@ include file="headernew.jsp" %>
<%//System.out.println("---------check1111111 "); %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%//System.out.println("-check "); %>
<%!
Connection conn, con1;
Statement st,st1, st2;
%>
<script type="text/javascript">

function gotoPrint(divName)  
{  
	  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.CastrolRundetail.action ="excel.jsp";
          document.forms["CastrolRundetail"].submit();
} 


</script>
<%
	
try{	
	
	//System.out.print(date1+"  "+ date2+"  "+ vehcode+"  "+ vehregno);
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1 = conn.createStatement();
	st2=conn.createStatement();
	String date1 = "";
	String date2 = "";
	int i =0;
	date1 = request.getParameter("fromdate");
	date2 = request.getParameter("todate");
	String datenew = new SimpleDateFormat("MMMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
	String Transporter = request.getParameter("transporter");
	String driver = request.getParameter("driver");
	String cat = request.getParameter("cat");
	String VioDay = request.getParameter("VioDay");
	String avg = request.getParameter("avg");
	System.out.println("Transporter   "+Transporter);
	System.out.println("driver   "+driver);
	System.out.println("VioDay   "+VioDay);
	System.out.println("avg   "+avg);
	System.out.println("cat   "+cat);
	
	
	String sql = "";
	if((Transporter == "All" || Transporter.equalsIgnoreCase("All")) && (driver == "All" || driver.equalsIgnoreCase("All")))
	{
		if(cat == "Tanker" || cat.equalsIgnoreCase("Tanker"))
		{
			if(VioDay == "All" || VioDay.equalsIgnoreCase("All"))
			{
				sql ="select * from db_gps.t_castrolrunhrs where TheDate between '"+date1+"' and '"+date2+"'  and Category not in ('Primary','Secondary') order by TheDate";
			}
			else
			{
		       sql ="select * from db_gps.t_castrolrunhrs where TheDate between '"+date1+"' and '"+date2+"' and Avgconsidered = '"+avg+"' and TripDay = '"+VioDay+"' and Category not in ('Primary','Secondary') order by TheDate";
			}
		}
		else
		{
			if(VioDay == "All" || VioDay.equalsIgnoreCase("All"))
			{
				sql ="select * from db_gps.t_castrolrunhrs where TripStartDate between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  and Category  in ('"+cat+"') order by TripStartDate";
			}
			else
			{
		       sql ="select * from db_gps.t_castrolrunhrs where TripStartDate between '"+date1+" 00:00:00' and '"+date2+" 23:59:59' and Avgconsidered = '"+avg+"' and TripDay = '"+VioDay+"' and Category  in ('"+cat+"') order by TripStartDate";
			}
		}
	}
	else
		if(driver == "All" || driver.equalsIgnoreCase("All"))
	{
			if(cat == "Tanker" || cat.equalsIgnoreCase("Tanker"))
			{
			    sql ="select * from db_gps.t_castrolrunhrs where TheDate between '"+date1+"' and '"+date2+"'  and Category not in ('Primary','Secondary') and Transporter = '"+Transporter+"' order by TheDate";
			}
			else
			{
			    sql ="select * from db_gps.t_castrolrunhrs where TripStartDate between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  and Category  in ('"+cat+"') and Transporter = '"+Transporter+"' order by TripStartDate";
			}
	}
		else
		{
			if(cat == "Tanker" || cat.equalsIgnoreCase("Tanker"))
			{
				sql ="select * from db_gps.t_castrolrunhrs where TheDate between '"+date1+"' and '"+date2+"'  and Category not in ('Primary','Secondary') and DriverID = '"+driver+"' order by TheDate";
			}
			else
			{
				sql ="select * from db_gps.t_castrolrunhrs where TripStartDate between '"+date1+" 00:00:00' and '"+date2+" 23:59:59'  and Category  in ('"+cat+"') and DriverID = '"+driver+"' order by TripStartDate";
			}
		}
	
	System.out.println("********    "+sql);
	%>
	<br>
	<form id="CastrolRundetail" name="CastrolRundetail" action="" method="post" >
	<div id="table1">
	<table border="0" width="100%" class="stats">
	<tr>
	<td colspan="27" align="center">
	<font size="4">Castrol Monthly Run Detail Report for <%=datenew %></font>
</td>
</tr></table>
<br>
<%
	 String exportFileName=session.getAttribute("user").toString()+"_Castrol_RunDetail.xls";  
	
	%>
	<br>
	<div class="bodyText"  style="text-align: right;">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="Excel_Castrolrunhrs.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=<%=Transporter %>&driver=<%=driver %>&VioDay=<%=VioDay %>&cat=<%=cat %>&avg=<%=avg %>" style="font-weight: bold; color: black; " >
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
<br>
<div style="text-align: center;margin-left: 0.2em;margin-right: 1em;">
<table border="1" width="100%" class="sortable" align="center">
<tr>
<th>Sr No</th>
<th>Violation Day</th>
<th>Trip ID</th>
<th>Driver ID</th>
<th>Driver Name</th>
<th>Vehicle Reg No</th>
<th>Transporter</th>
<th>The Date</th>
<th>Km Travelled</th>
<th>Run Duration</th>
<th>Avg Consd.</th>
<th>Trip Start Date Time</th>
<th>Trip Start Location</th>
<th>Trip End Date Time</th>
<th>Trip End Location</th>
<th>Std Dist</th>
<th>Std Dur</th>
<th>Category</th>
<th>Geofenced</th>
<th>Geofence Type</th>
<th>Trip Ended by</th>
<th>Pre Day Km</th>
<th>Pre Day Dur</th>
<th>Pre Avg Speed</th>
<th>Pre Castrol Trips</th>
<th>Nxt Day Km</th>
<th>Nxt Day Dur</th>
<th>Nxt Avg. Speed</th>
<th>Nxt Castrol Trips</th>
<th>Total Km</th>
<th>Total Dur</th>
<th>Duration 1</th>
<th>Day Start Place</th>
<th>Day End Place</th>
<th>Pre Avail. Date</th>
<th>Nxt Avail. Date</th>
<th>Castrol Days</th>
<th>Avg Consd RunHrs</th>
<th>Avg Consd Dist</th>
<th>Without Avg Consd Dist</th>
<th>Without Avg Consd Dist</th>
<th>Undefined Dist</th>
<th>Undefined  Dist</th>
</tr>

<%

ResultSet rs = st.executeQuery(sql);
while(rs.next())
{
	%>
	<tr>
	<td align="right"><div align="right"><%=++i%></div></td>
	<td align="left"><div align="left"><%=rs.getString("TripDay") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("TripID") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("DriverID") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DriverName") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Vehregno") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Transporter") %></div></td>	
	<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("TheDate"))) %></div></td>
	<td align="right"><div align="right"><%=rs.getString("KmTravelled") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("Duration") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Avgconsidered") %></div></td>
	<%
	if(rs.getString("TripStartDate") == "-" || rs.getString("TripStartDate").equalsIgnoreCase("-"))
	{
		
		%>
		<td align="right"><div align="right">-</div></td>
	    <td align="left"><div align="left"><%=rs.getString("TripStartLocation") %></div></td>
	    <td align="right"><div align="right">-</div></td>
	    <td align="left"><div align="left"><%=rs.getString("TripEndLocation") %></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TripStartDate"))) %></div></td>
		<td align="left"><div align="left"><%=rs.getString("TripStartLocation") %></div></td>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TripEndDate"))) %></div></td>
		<td align="left"><div align="left"><%=rs.getString("TripEndLocation") %></div></td>
		<%
	}
	%>
	<td align="right"><div align="right"><%=rs.getString("StdDist") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("StdDur") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Category") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Geofenced") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("TypeofGeofence") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("TripEndBy") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("PreDayKm") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("PreDayDur") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("AvgSpeedPre") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("PreCastrolTrip") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("NxtDayKm") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("NxtDayDur") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("AvgSpeedNxt") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("NxtCastrolTrip") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("TotalKm") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("TotalDur") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("Duration1") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DayStartPlace") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DayEndPlace") %></div></td>
	<%
	if(rs.getString("PreAvDate") == "-" || rs.getString("PreAvDate").equalsIgnoreCase("-"))
	{
		%>
		<td align="right"><div align="right">-</div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("PreAvDate"))) %></div></td>
		<%
	}
	
	if(rs.getString("NxtAvDate") == "-" || rs.getString("NxtAvDate").equalsIgnoreCase("-"))
	{
		%>
		<td align="right"><div align="right">-</div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("NxtAvDate"))) %></div></td>
		<%
	}
	%>
	<td align="right"><div align="right"><%=rs.getString("CastrolDays") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("AvgConsdRunHrs") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("AvgConsdDist") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("WithoutAvgConsdRunhr") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("WithoutAvgConsdDist") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("UndefinedRunHrs") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("UndefinedDist") %></div></td>
	</tr>
	<%
}
%>

	</table>
	</div>
	</div>
	</form>
	
	<%
	}

catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e){}
	try
	{
	con1.close();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection1();
	}
	catch(Exception e){}
	try
	{
	fleetview.closeConnection();
	}
	catch(Exception e){}
}

%>
</jsp:useBean>
<br>
<%@ include file="footernew.jsp"%>