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
          document.CastrolCD.action ="excel.jsp";
          document.forms["CastrolCD"].submit();
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
	date1 = request.getParameter("fromdate");
	date2 = request.getParameter("todate");
	String date3 = date1;
	String date4 = date2;
	date1 = date1+" 00:00:00";
	date2 = date2+" 23:59:59";
	//date1 = "2012-06-01";
	//date2 = "2012-06-30";
	System.out.println("Date1    "+date1+ "  Date2     "+date2);
	String datenew = new SimpleDateFormat("MMMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
	%>
	<br>
	<form id="CastrolCD" name="CastrolCD" action="" method="post" >
<div id="table1">
	<table border="0" width="100%" class="stats">
		<tr>
		<td colspan="8" align="center">
		<font size="4">Castrol Monthly CD Summary Report for <%=datenew %></font>
	</td>
	</tr></table>
	<%
	 String exportFileName=session.getAttribute("user").toString()+"_Castrol_CDSummary.xls";  
	
	%>
	<br>
	<div class="bodyText"  style="width: 50em;text-align: right;margin-left: 23em;">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=fleetview.PrintDate() %>
                           </div>
	
	
	
	<table border="0"  class="sortable"  style="width: 50em;text-align: center;margin-left: 36em;">
	<tr><th colspan="9">Primary/Secondary</th></tr>
	<tr>
	<th>Sr.No.</th>
	<th>Transporter</th>
	<th colspan="2">Start Day</th>
	<th colspan="2">In Transit</th>
	<th colspan="2">End Day</th>
	<th>Total Result</th>
	</tr>
	<tr>
	<th></th>
	<th></th>
	<th>No</th>
	<th>Yes</th>
	<th>No</th>
	<th>Yes</th>
	<th>No</th>
	<th>Yes</th>
	<th></th>
	</tr>
	<% 
	int i =1;
	int totendno = 0,totendyes = 0,tottransno = 0,tottransyes = 0,totstrtno = 0,totstrtyes = 0,totcnt = 0;
	String sql = "select distinct(Transporter) from db_gps.t_castrolcd where TripStartDate between '"+date1+"' and  '"+date2+"'  and Category in ('Primary','Secondary')";
	ResultSet rs = st.executeQuery(sql);
	while(rs.next())
	{
		String transporter = rs.getString("Transporter");
		
		int cdendno = 0,cdendyes = 0,cdtransitno = 0,cdtransityes = 0,cdstartno =0,cdstartyes = 0,cdcnt = 0;
		String sql1 = "select * from db_gps.t_castrolcd where TripStartDate between '"+date1+"' and  '"+date2+"' and Transporter = '"+transporter+"' and Category in ('Primary','Secondary') and (CDStartDay <> 0 or CDEndDay <> 0 or CDTransitDay <> 0)";   
		ResultSet rs1 = st1.executeQuery(sql1);
		while(rs1.next())
		{
			String avg = rs1.getString("Avgconsidered");
			if(avg == "Yes" || avg.equalsIgnoreCase("Yes"))
			{
				cdendyes = cdendyes + rs1.getInt("CDEndDay");
				cdtransityes = cdtransityes + rs1.getInt("CDTransitDay");
				cdstartyes = cdstartyes + rs1.getInt("CDStartDay");
				
			}
			else
			{
				cdendno = cdendno + rs1.getInt("CDEndDay");
				cdtransitno = cdtransitno + rs1.getInt("CDTransitDay");
				cdstartno = cdstartno + rs1.getInt("CDStartDay");
			}	
		}
		
		cdcnt = cdendyes + cdtransityes + cdstartyes + cdendno + cdtransitno + cdstartno;
		totendno = totendno + cdendno;
		totendyes = totendyes + cdendyes;
		tottransno = tottransno + cdtransitno;
		tottransyes = tottransyes + cdtransityes;
		totstrtno = totstrtno + cdstartno;
		totstrtyes = totstrtyes + cdstartyes;
	%>
	<tr>
	<td align="right"><div align="right"><%=i %></div></td>
	<td align="left"><div align="left"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=<%=transporter %>&cnt=All&cat=prisec&avg=All"><%=transporter %></a></div></td>
	<td align="right"><div align="right"><%=cdstartno %></div></td>
	<td align="right"><div align="right"><%=cdstartyes %></div></td>
	<td align="right"><div align="right"><%=cdtransitno %></div></td>
	<td align="right"><div align="right"><%=cdtransityes %></div></td>
	<td align="right"><div align="right"><%=cdendno %></div></td>
	<td align="right"><div align="right"><%=cdendyes %></div></td>
	<td align="right"><div align="right"><%=cdcnt %></div></td>
	</tr>
	<%
	i++;
	}
	
	totcnt = totstrtno + totstrtyes + tottransno + tottransyes + totendno + totendyes;
	%>
	<tr>
	<td align="left" colspan="2"><div align="left">Total Result</div></td>
	<%
	if(totstrtno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=Start&cat=prisec&avg=No"><%=totstrtno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totstrtno %></div></td>
		<%
	}
	%>
	<%
	if(totstrtyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=Start&cat=prisec&avg=Yes"><%=totstrtyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totstrtyes %></div></td>
		<%
	}
	%>
	<%
	if(tottransno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=Transit&cat=prisec&avg=No"><%=tottransno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=tottransno %></div></td>
		<%
	}
	%>
	<%
	if(tottransyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=Transit&cat=prisec&avg=Yes"><%=tottransyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=tottransyes %></div></td>
		<%
	}
	%>
	<%
	if(totendno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=End&cat=prisec&avg=No"><%=totendno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totendno %></div></td>
		<%
	}
	%>
	<%
	if(totendyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=End&cat=prisec&avg=Yes"><%=totendyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totendyes %></div></td>
		<%
	}
	%>
	<%
	if(totcnt>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cnt=All&cat=prisec&avg=All"><%=totcnt %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totcnt %></div></td>
		<%
	}
	%>
	
	</tr>
	</table>
	<br>
	<table border="0"  class="sortable"  style="width: 50em;text-align: center;margin-left: 36em;">
	<tr><th colspan="11">Tanker</th></tr>
	<tr>
	<th>Sr.No.</th>
	<th>Transporter</th>
	<th colspan="2">Start Day</th>
	<th colspan="2">In Transit</th>
	<th colspan="2">End Day</th>
	<th colspan="2">No Trip</th>
	<th>Total Result</th>
	</tr>
	<tr>
	<th></th>
	<th></th>
	<th>No</th>
	<th>Yes</th>
	<th>No</th>
	<th>Yes</th>
	<th>No</th>
	<th>Yes</th>
	<th>No</th>
	<th>Yes</th>
	<th></th>
	</tr>
	
	<%
	i = 1;
	totendno = 0;totendyes = 0;tottransno = 0;tottransyes = 0;totstrtno = 0;totstrtyes = 0;totcnt = 0;
	int totntripno = 0,totntripyes = 0;
	 sql = "select distinct(Transporter) from db_gps.t_castrolcd where TheDate >= '"+date3+"' and TheDate <= '"+date4+"'  and Category in ('Tanker','-')";
	rs = st.executeQuery(sql);
	while(rs.next())
	{
		String transporter = rs.getString("Transporter");
		
		int cdendno = 0,cdendyes = 0,cdtransitno = 0,cdtransityes = 0,cdstartno =0,cdstartyes = 0,cdcnt = 0,cdntripno = 0,cdntripyes = 0;
		String sql1 = "select * from db_gps.t_castrolcd where TheDate >= '"+date3+"' and TheDate <= '"+date4+"' and Transporter = '"+transporter+"' and Category in ('Tanker','-')";   
		ResultSet rs1 = st1.executeQuery(sql1);
		while(rs1.next())
		{
			String avg = rs1.getString("Avgconsidered");
			if(avg == "Yes" || avg.equalsIgnoreCase("Yes"))
			{
				if(rs1.getString("Tripid") == "-" || rs1.getString("Tripid").equals("-"))
				{
					cdntripyes = cdntripyes + 1;
				}
				else
				{
						cdendyes = cdendyes + rs1.getInt("CDEndDay");
						cdtransityes = cdtransityes + rs1.getInt("CDTransitDay");
						cdstartyes = cdstartyes + rs1.getInt("CDStartDay");
				}
			}
			else
			{
				if(rs1.getString("Tripid") == "-" || rs1.getString("Tripid").equals("-"))
				{
					cdntripno = cdntripno + 1;
				}
				else
				{
				cdendno = cdendno + rs1.getInt("CDEndDay");
				cdtransitno = cdtransitno + rs1.getInt("CDTransitDay");
				cdstartno = cdstartno + rs1.getInt("CDStartDay");
				}
			}	
		}
		
		cdcnt = cdendyes + cdtransityes + cdstartyes + cdendno + cdtransitno + cdstartno + cdntripyes + cdntripno;
		totendno = totendno + cdendno;
		totendyes = totendyes + cdendyes;
		tottransno = tottransno + cdtransitno;
		tottransyes = tottransyes + cdtransityes;
		totstrtno = totstrtno + cdstartno;
		totstrtyes = totstrtyes + cdstartyes;
		totntripno = totntripno +cdntripno;
		totntripyes = totntripyes + cdntripyes;
	%>
	<tr>
	<td align="right"><div align="right"><%=i %></div></td>
	<td align="left"><div align="left"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=<%=transporter %>&cnt=All&cat=tank&avg=All"><%=transporter %></a></div></td>
	<td align="right"><div align="right"><%=cdstartno %></div></td>
	<td align="right"><div align="right"><%=cdstartyes %></div></td>
	<td align="right"><div align="right"><%=cdtransitno %></div></td>
	<td align="right"><div align="right"><%=cdtransityes %></div></td>
	<td align="right"><div align="right"><%=cdendno %></div></td>
	<td align="right"><div align="right"><%=cdendyes %></div></td>
	<td align="right"><div align="right"><%=cdntripno %></div></td>
	<td align="right"><div align="right"><%=cdntripyes %></div></td>
	<td align="right"><div align="right"><%=cdcnt %></div></td>
	</tr>
	<%
	i++;
	}
	
	totcnt = totstrtno + totstrtyes + tottransno + tottransyes + totendno + totendyes + totntripno + totntripyes;
	%>
	<tr>
	<td align="left" colspan="2"><div align="left">Total Result</div></td>
	<%
	if(totstrtno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=Start&cat=tank&avg=No"><%=totstrtno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totstrtno %></div></td>
		<%
	}
	%>
	<%
	if(totstrtyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=Start&cat=tank&avg=Yes"><%=totstrtyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totstrtyes %></div></td>
		<%
	}
	%>
	<%
	if(tottransno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=Transit&cat=tank&avg=No"><%=tottransno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=tottransno %></div></td>
		<%
	}
	%>
	<%
	if(tottransyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=TransitYes&cat=tank&avg=Yes"><%=tottransyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=tottransyes %></div></td>
		<%
	}
	%>
	<%
	if(totendno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=End&cat=tank&avg=No"><%=totendno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totendno %></div></td>
		<%
	}
	%>
	<%
	if(totendyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=End&cat=tank&avg=Yes"><%=totendyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totendyes %></div></td>
		<%
	}
	%>
	<%
	if(totntripno>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=Ntrip&cat=tank&avg=No"><%=totntripno %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totntripno %></div></td>
		<%
	}
	%>
	<%
	if(totntripyes>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=NTrip&cat=tank&avg=Yes"><%=totntripyes %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totntripyes %></div></td>
		<%
	}
	%>
	<%
	if(totcnt>0)
	{
		%>
		<td align="right"><div align="right"><a href= "Castrol_CDDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&cnt=All&cat=tank&avg=All"><%=totcnt %></a></div></td>
		<%
	}
	else
	{
		%>
		<td align="right"><div align="right"><%=totcnt %></div></td>
		<%
	}
	%>
	</table>
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