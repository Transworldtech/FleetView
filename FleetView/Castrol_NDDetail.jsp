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
          document.CastrolNDdetail.action ="excel.jsp";
          document.forms["CastrolNDdetail"].submit();
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
	String category = request.getParameter("cat");
	String ndcat = request.getParameter("ndcat");
	String showtanker = request.getParameter("showtan");
	String sql = "";
	if(showtanker == "No" || showtanker.equalsIgnoreCase("No"))
	{
	if(Transporter == "All" || Transporter.equalsIgnoreCase("All"))
	{
		if(category == "All" || category.equalsIgnoreCase("All"))
		{
			sql = "select * from db_gps.t_castrolnd where TripStartDate >= '"+date1+" 00:00:00' and TripStartDate <= '"+date2+" 23:59:59' and Category in ('Primary','Secondary') order by TripStartDate ";
		}
		else
		{
			sql = "select * from db_gps.t_castrolnd where TripStartDate >= '"+date1+" 00:00:00' and TripStartDate <= '"+date2+" 23:59:59' and Category in ('"+category+"') and NDCategory = '"+ndcat+"' order by TripStartDate ";
		}
	}
	else
	{
		sql = "select * from db_gps.t_castrolnd where TripStartDate >= '"+date1+" 00:00:00' and TripStartDate <= '"+date2+" 23:59:59' and Transporter = '"+Transporter+"'  and Category in ('Primary','Secondary')  order by TripStartDate";
	}
	}
	else
	{
		if(Transporter == "All" || Transporter.equalsIgnoreCase("All"))
		{
			if(category == "All" || category.equalsIgnoreCase("All"))
			{
				sql = "select * from db_gps.t_castrolnd where NDStartDate >= '"+date1+"' and NDStartDate <= '"+date2+"' and Category in ('Tanker','-') order by NDStartDate,NDStartTime ";
			}
			else
			{
				sql = "select * from db_gps.t_castrolnd where NDStartDate >= '"+date1+"' and NDStartDate <= '"+date2+"' and Category in ('"+category+"') and NDCategory = '"+ndcat+"' order by NDStartDate,NDStartTime ";
			}
		}
		else
		{
			sql = "select * from db_gps.t_castrolnd where NDStartDate >= '"+date1+"' and NDStartDate <= '"+date2+"' and Transporter = '"+Transporter+"'  and Category in ('Tanker','-')  order by NDStartDate,NDStartTime";
		}
	}
	System.out.println("********    "+sql);
	%>
	<br>
	<form id="CastrolNDdetail" name="CastrolNDdetail" action="" method="post" >
	<div id="table1">
	<table border="0" width="100%" class="stats">
	<tr>
	<td colspan="27" align="center">
	<font size="4">Castrol Monthly ND Detail Report for <%=datenew %></font>
</td>
</tr></table>
<br>
<%
	 String exportFileName=session.getAttribute("user").toString()+"_Castrol_NDDetail.xls";  
	
	%>
	<br>
	<div class="bodyText"  style="text-align: right;">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
<br>
<div style="text-align: center;margin-left: 0.2em;margin-right: 1em;">
<table border="1" width="100%" class="sortable" align="center">
<tr>
<th>Sr No</th>
<th>ND Category</th>
<th>Trip ID</th>
<th>Driver ID</th>
<th>Driver Name</th>
<th>Vehicle Reg No</th>
<th>Transporter</th>
<th>ND Start Date Time</th>
<th>ND From Location</th>
<th>ND End Date Time</th>
<th>ND To Location</th>
<th>ND Dur</th>
<th>KM Travelled</th>
<th>ND Pre Authorised</th>
<th>Trip Start Date Time</th>
<th>Trip Start Location</th>
<th>Trip End Date Time</th>
<th>Trip End Location</th>
<th>Std Dist</th>
<th>Std Dur</th>
<th>Trip Category</th>
<th>Geofenced</th>
<th>Geofence Type</th>
<th>Trip Ended by</th>
</tr>

<%

ResultSet rs = st.executeQuery(sql);
while(rs.next())
{
	%>
	<tr>
	<td align="right"><div align="right"><%=++i%></div></td>
	<td align="left"><div align="left"><%=rs.getString("NDCategory") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("TripID") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("DriverID") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DriverName") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Vehregno") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Transporter") %></div></td>
	<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("NDStartDate")+" "+rs.getString("NDStartTime"))) %></div></td>
	<td align="left"><div align="left"><%=rs.getString("NDFromLocation") %></div></td>
	<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("NDEndDate")+" "+rs.getString("NDEndTime"))) %></div></td>
	<td align="left"><div align="left"><%=rs.getString("NDToLocation") %></div></td>
	<td align="right"><div align="right"><%=new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("Duration"))) %></div></td>
	<td align="right"><div align="right"><%=rs.getString("KmTravelled") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("NDPreauthorised") %></div></td>
	<%
	if(rs.getString("TripStartDate") == "-" || rs.getString("TripStartDate").equals("-"))
	{
		%>
		<td align="right"><div align="right"><%=rs.getString("TripStartDate")%></div></td>
		<%
	}
	else
	{
	%>
	<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TripStartDate"))) %></div></td>
	<%
	}
	%>
	<td align="left"><div align="left"><%=rs.getString("TripStartLocation") %></div></td>
	<%
	if(rs.getString("TripEndDate") == "-" || rs.getString("TripEndDate").equals("-"))
	{
		%>
		<td align="right"><div align="right"><%=rs.getString("TripEndDate") %></div></td>
		<%
	}
	else
	{
	%>
	<td align="right"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TripEndDate"))) %></div></td>
	<%
	}
	%>
	<td align="left"><div align="left"><%=rs.getString("TripEndLocation") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("StdDist") %></div></td>
	<td align="right"><div align="right"><%=rs.getString("StdDur") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Category") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Geofenced") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("TypeofGeofence") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("TripEndBy") %></div></td>
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