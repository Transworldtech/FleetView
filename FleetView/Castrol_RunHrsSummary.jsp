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
          document.CastrolRun.action ="excel.jsp";
          document.forms["CastrolRun"].submit();
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
	date1 = request.getParameter("date1");
	date2 = request.getParameter("date2");
	String datenew = new SimpleDateFormat("MMMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
	//date1 = "2012-06-01";
	//date2 = "2012-06-30";
	String date3 = date1;
	String date4 = date2;
	int i = 0;
	date1 = date1+" 00:00:00";
	date2 = date2+" 23:59:59";
	//date1 = "2012-06-01 00:00:00";
	//date2 = "2012-06-30 23:59:59";
	
	String category = request.getParameter("cg");
	//category = "Secondary";
	String type = request.getParameter("type");
	
	if(type == null || type.equalsIgnoreCase("null"))
	{
		type = "Transporter";
	}

	
	System.out.println("Type    "+type);
	System.out.println("Date1    "+date1+ "  Date2     "+date2);
	
	%>
	
	<form id="CastrolRunhr" name="CastrolRunhr" method="get" action= "">
	<div align="center">
	<table border="0" width="30%" align="center">
		<tr align="center">
		<td  align="center">
		<font size="2" color="black">Summary Type&nbsp;&nbsp;
				<select name="type" id="type" 
				style="width: 100px; height:23px; border: 2px solid black; font: normal 12px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
			 		<option value="Transporter">Transporter</option>
			 		<option value="Driver">Driver</option></select>
			 		</font>
			 		<input type="hidden" name="date1" value="<%=date1%>">
			 		<input type="hidden" name="date2" value="<%=date2%>">
			 		<input type="hidden" name="cg" value="<%=category%>">
			 		
	</td>
	
				<td><input type="submit" name="button" value="Go" ></td>
	</tr>
	</table>
	</div>
	</form>

	<br>
	<form id="CastrolRun" name="CastrolRun" action="" method="post" >
<div id="table1">
	<table border="0" width="100%" class="stats">
		<tr>
		<td colspan="8" align="center">
		<font size="4">Castrol Monthly RunHrs Summary Report for <%=datenew %></font>
	</td>
	</tr>
	</table>
	
	
	<%
	 String exportFileName=session.getAttribute("user").toString()+"_Castrol_RunHrSummary.xls";  
	
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
                           
                          
                           <%
                       
	if(type == "Transporter" || type.equalsIgnoreCase("Transporter"))
	{
		if(category == "Tanker" || category.equalsIgnoreCase("Tanker"))
		{
			%>
			 <table border="1"  class="sortable"  style="width: 50em;text-align: center;margin-left: 36em;">
                       	<tr>
            <th>Sr.No</th>        	
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
			int totendno = 0,totendyes = 0,tottransno = 0,tottransyes = 0,totstrtno = 0,totstrtyes = 0,totnotripno = 0,totnotripyes = 0,totcnt = 0;
			String sql = "select distinct(Transporter) from db_gps.t_castrolrunhrs where TheDate >= '"+date3+"' and TheDate <= '"+date4+"' and Category in ('Tanker','-') order by Transporter";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				String transporter = rs.getString("Transporter");
				int endno = 0,endyes = 0,transitno = 0,transityes = 0,startno =0,startyes = 0,notripno = 0,notripyes = 0,cnt = 0;
				
				String sql1 = "select * from db_gps.t_castrolrunhrs where TheDate >= '"+date3+"' and TheDate <= '"+date4+"' and Transporter = '"+transporter+"' and Category in ('Tanker','-')";   
				ResultSet rs1 = st1.executeQuery(sql1);
				while(rs1.next())
				{
					String avg = rs1.getString("Avgconsidered");
					String tripday = rs1.getString("TripDay");
					if(avg == "Yes" || avg.equalsIgnoreCase("Yes"))
					{
						if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
						{
							startyes++;
						}
						else
						if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
						{
							endyes++;
						}
						else
						if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
						{
							transityes++;
						}
						else
						{
							notripyes++;
						}
					}
					else
					{
						
							if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
							{
								startno++;
							}
							else
							if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
							{
								endno++;
							}
							else
							if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
							{
								transitno++;
							}
							else
							{
								notripno++;
							}
						
					}
				}
					cnt = endyes + transityes + startyes + endno + transitno + startno + notripno + notripyes;
					totendno = totendno + endno;
					totendyes = totendyes + endyes;
					tottransno = tottransno + transitno;
					tottransyes = tottransyes + transityes;
					totstrtno = totstrtno + startno;
					totstrtyes = totstrtyes + startyes;
					totnotripno = totnotripno + notripno;
					totnotripyes = totnotripyes + notripyes;
					
					%>
					<tr>
<!--					<td align="left"><div align="left"><a href= "Castrol_CDDetail.jsp?fromdate=< %=date1 %>&todate=< %=date2 %>&transporter=< %=transporter %>&cnt=All">< %=transporter %></a></div></td>-->
				<td align="right"><div align="right"><%=i %></div></td>
<%

				if(cnt > 0)
				{
					%>
					<td align="left"><div align="left"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=<%=transporter %>&driver=All&VioDay=All&cat=<%=category %>&avg=All"><%=transporter %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="left"><div align="left"><%=transporter %></div></td>
					<%
			   	}
%>
					
					<td align="right"><div align="right"><%=startno %></div></td>
					<td align="right"><div align="right"><%=startyes %></div></td>
					<td align="right"><div align="right"><%=transitno %></div></td>
					<td align="right"><div align="right"><%=transityes %></div></td>
					<td align="right"><div align="right"><%=endno %></div></td>
					<td align="right"><div align="right"><%=endyes %></div></td>
					<td align="right"><div align="right"><%=notripno %></div></td>
					<td align="right"><div align="right"><%=notripyes %></div></td>
					<td align="right"><div align="right"><%=cnt %></div></td>
					</tr>
					<%
				i++;
			}
				totcnt = totstrtno + totstrtyes + tottransno + tottransyes + totendno + totendyes + totnotripno + totnotripyes;
				%>
				<tr>
				<td align="left" colspan="2"><div align="left">Total Result</div></td>
				<%
				if(totstrtno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=No"><%=totstrtno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtno %></div></td>
					<%
					
				}
				
				if(totstrtyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=Yes"><%=totstrtyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtyes %></div></td>
					<%
					
				}
				
				if(tottransno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=No"><%=tottransno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransno %></div></td>
					<%
					
				}
				
				if(tottransyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=Yes"><%=tottransyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransyes %></div></td>
					<%
					
				}
				
				if(totendno > 0 )
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=No"><%=totendno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendno %></div></td>
					<%
					
				}
				
				if(totendyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=Yes"><%=totendyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendyes %></div></td>
					<%
					
				}
				
				if(totnotripno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=No Trip&cat=<%=category %>&avg=No"><%=totnotripno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totnotripno %></div></td>
					<%
					
				}
				
				if(totnotripyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=No Trip&cat=<%=category %>&avg=Yes"><%=totnotripyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totnotripyes %></div></td>
					<%
					
				}
				
				if(totcnt > 0)
				{
					%>
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=All&cat=<%=category %>&avg=All"><%=totcnt %></a></div></td>
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
				<%
			%>
			
			 
                       </table>
			<%
		}
		else
		{
			%>
			<table border="1"  class="sortable"  style="width: 50em;text-align: center;margin-left: 36em;">
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
			i = 1;
			int totendno = 0,totendyes = 0,tottransno = 0,tottransyes = 0,totstrtno = 0,totstrtyes = 0,totnotripno = 0,totnotripyes = 0,totcnt = 0;
			String sql = "select distinct(Transporter) from db_gps.t_castrolrunhrs where TripStartDate >= '"+date1+"' and TripStartDate <= '"+date2+"' and Category in ('"+category+"') order by Transporter";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				String transporter = rs.getString("Transporter");
				int endno = 0,endyes = 0,transitno = 0,transityes = 0,startno =0,startyes = 0,notripno = 0,notripyes = 0,cnt = 0;
				
				String sql1 = "select * from db_gps.t_castrolrunhrs where TripStartDate >= '"+date1+"' and TripStartDate <= '"+date2+"' and Transporter = '"+transporter+"' and Category in ('"+category+"')";   
			//	System.out.println("***   "+sql1);
			 	ResultSet rs1 = st1.executeQuery(sql1);
				while(rs1.next())
				{
					String avg = rs1.getString("Avgconsidered");
					String tripday = rs1.getString("TripDay");
					if(avg == "Yes" || avg.equalsIgnoreCase("Yes"))
					{
						if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
						{
							startyes++;
						}
						else
						if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
						{
							endyes++;
						}
						else
						if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
						{
							transityes++;
						}
						else
						{
							notripyes++;
						}
					}
					else
					{
						
							if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
							{
								startno++;
							}
							else
							if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
							{
								endno++;
							}
							else
							if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
							{
								transitno++;
							}
							else
							{
								notripno++;
							}
						
					}
				}
					cnt = endyes + transityes + startyes + endno + transitno + startno ;
					totendno = totendno + endno;
					totendyes = totendyes + endyes;
					tottransno = tottransno + transitno;
					tottransyes = tottransyes + transityes;
					totstrtno = totstrtno + startno;
					totstrtyes = totstrtyes + startyes;
					totnotripno = totnotripno + notripno;
					totnotripyes = totnotripyes + notripyes;
					
					%>
					<tr>
<!--					<td align="left"><div align="left"><a href= "Castrol_CDDetail.jsp?fromdate=< %=date1 %>&todate=< %=date2 %>&transporter=< %=transporter %>&cnt=All">< %=transporter %></a></div></td>-->
					<td align="right"><div align="right"><%=i %></div></td>
					<%
				if(cnt > 0)
				{
					%>
					<td align="left"><div align="left"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=<%=transporter %>&driver=All&VioDay=All&cat=<%=category %>&avg=All"><%=transporter %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="left"><div align="left"><%=transporter %></div></td>
					<%
				}
					%>
					<td align="right"><div align="right"><%=startno %></div></td>
					<td align="right"><div align="right"><%=startyes %></div></td>
					<td align="right"><div align="right"><%=transitno %></div></td>
					<td align="right"><div align="right"><%=transityes %></div></td>
					<td align="right"><div align="right"><%=endno %></div></td>
					<td align="right"><div align="right"><%=endyes %></div></td>
<!--					<td align="right"><div align="right">< %=notripno %></div></td>-->
<!--					<td align="right"><div align="right">< %=notripno %></div></td>-->
					<td align="right"><div align="right"><%=cnt %></div></td>
					</tr>
					<%
				i++;
			}
				totcnt = totstrtno + totstrtyes + tottransno + tottransyes + totendno + totendyes;
				%>
				<tr>
				<td align="left" colspan="2"><div align="left">Total Result</div></td>
				<%
				if(totstrtno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=No"><%=totstrtno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtno %></div></td>
					<%
					
				}
				
				if(totstrtyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=Yes"><%=totstrtyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtyes %></div></td>
					<%
					
				}
				
				if(tottransno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=No"><%=tottransno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransno %></div></td>
					<%
					
				}
				
				if(tottransyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=Yes"><%=tottransyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransyes %></div></td>
					<%
					
				}
				
				if(totendno > 0 )
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=No"><%=totendno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendno %></div></td>
					<%
					
				}
				
				if(totendyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=Yes"><%=totendyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendyes %></div></td>
					<%
				}
				if(totcnt > 0)
				{
					%>
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=All&cat=<%=category %>&avg=All"><%=totcnt %></a></div></td>
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
				<%
			
			%>
			
			 
                       </table>
			<%
			
		}
		
	}
	else
	{
		if(category == "Tanker"  || category.equalsIgnoreCase("Tanker"))
		{
			%>
			<table border="1"  class="sortable"  style="width: 60em;text-align: center;margin-left: 30em;">
                       	<tr>
                       	<th>Sr.No.</th>
			<th>Driver ID</th>
			<th>Driver Name</th>
			<th style="width: 30em;">Transporter</th>
			<th colspan="2">Start Day</th>
			<th colspan="2">In Transit</th>
			<th colspan="2">End Day</th>
			<th colspan="2">No Trip</th>
			<th>Total Result</th>
			</tr>
			<tr>
			<th></th>
			<th></th>
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
			i =1;
			int totendno = 0,totendyes = 0,tottransno = 0,tottransyes = 0,totstrtno = 0,totstrtyes = 0,totnotripno = 0,totnotripyes = 0,totcnt = 0;
			String sql = "select distinct(DriverName) ,Transporter,DriverID from db_gps.t_castrolrunhrs where TheDate >= '"+date3+"' and TheDate <= '"+date4+"' and Category in ('Tanker','-') order by DriverName";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				String transporter = rs.getString("Transporter");
				String DriverName = rs.getString("DriverName");
				String DriverID = rs.getString("DriverID");
				int endno = 0,endyes = 0,transitno = 0,transityes = 0,startno =0,startyes = 0,notripno = 0,notripyes = 0,cnt = 0;
				
				String sql1 = "select * from db_gps.t_castrolrunhrs where TheDate >= '"+date3+"' and TheDate <= '"+date4+"' and DriverID = '"+DriverID+"'  and Category in ('Tanker','-')";   
				ResultSet rs1 = st1.executeQuery(sql1);
				while(rs1.next())
				{
					String avg = rs1.getString("Avgconsidered");
					String tripday = rs1.getString("TripDay");
					if(avg == "Yes" || avg.equalsIgnoreCase("Yes"))
					{
						if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
						{
							startyes++;
						}
						else
						if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
						{
							endyes++;
						}
						else
						if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
						{
							transityes++;
						}
						else
						{
							notripyes++;
						}
					}
					else
					{
						
							if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
							{
								startno++;
							}
							else
							if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
							{
								endno++;
							}
							else
							if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
							{
								transitno++;
							}
							else
							{
								notripno++;
							}
						
					}
				}
					cnt = endyes + transityes + startyes + endno + transitno + startno + notripno + notripyes;
					totendno = totendno + endno;
					totendyes = totendyes + endyes;
					tottransno = tottransno + transitno;
					tottransyes = tottransyes + transityes;
					totstrtno = totstrtno + startno;
					totstrtyes = totstrtyes + startyes;
					totnotripno = totnotripno + notripno;
					totnotripyes = totnotripyes + notripyes;
					
					%>
					<tr>
<!--					<td align="left"><div align="left"><a href= "Castrol_CDDetail.jsp?fromdate=< %=date1 %>&todate=< %=date2 %>&transporter=< %=transporter %>&cnt=All">< %=transporter %></a></div></td>-->
					<td align="right"><div align="right"><%=i %></div></td>
					<td align="right"><div align="right"><%=DriverID %></div></td>
					<%
					if(cnt > 0)
					{
						%>
						   <td align="left"><div align="left"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=<%=DriverID %>&VioDay=All&cat=<%=category %>&avg=All"><%=DriverName %></a></div></td>
						<%
					}
					else
					{
						%>
						    <td align="left"><div align="left"><%=DriverName %></div></td>
						<%
					}
					%>
					<td align="left" style="width: 30em;"><div align="left"><%=transporter %></div></td>
					<td align="right"><div align="right"><%=startno %></div></td>
					<td align="right"><div align="right"><%=startyes %></div></td>
					<td align="right"><div align="right"><%=transitno %></div></td>
					<td align="right"><div align="right"><%=transityes %></div></td>
					<td align="right"><div align="right"><%=endno %></div></td>
					<td align="right"><div align="right"><%=endyes %></div></td>
					<td align="right"><div align="right"><%=notripno %></div></td>
					<td align="right"><div align="right"><%=notripyes %></div></td>
					<td align="right"><div align="right"><%=cnt %></div></td>
					</tr>
					<%
				i++;
			}
				totcnt = totstrtno + totstrtyes + tottransno + tottransyes + totendno + totendyes + totnotripno + totnotripyes;
				%>
				<tr>
				<td align="left" colspan="4"><div align="left">Total Result</div></td>
				<%
				if(totstrtno > 0)
				{
					%>
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=No"><%=totstrtno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtno %></div></td>
					<%
					
				}
				
				if(totstrtyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=Yes"><%=totstrtyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtyes %></div></td>
					<%
					
				}
				
				if(tottransno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=No"><%=tottransno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransno %></div></td>
					<%
					
				}
				
				if(tottransyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=Yes"><%=tottransyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransyes %></div></td>
					<%
					
				}
				
				if(totendno > 0 )
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=No"><%=totendno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendno %></div></td>
					<%
					
				}
				
				if(totendyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=Yes"><%=totendyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendyes %></div></td>
					<%
					
				}
				
				if(totnotripno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=No Trip&cat=<%=category %>&avg=No"><%=totnotripno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totnotripno %></div></td>
					<%
					
				}
				
				if(totnotripyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=No Trip&cat=<%=category %>&avg=Yes"><%=totnotripyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totnotripyes %></div></td>
					<%
					
				}
				
				if(totcnt > 0)
				{
					%>
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=All&cat=<%=category %>&avg=All"><%=totcnt %></a></div></td>
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
				<%
			
			%>
			
                       </table>
			<%
		}
		else
		{
			%>
			<table border="1"  class="sortable"  style="width: 60em;text-align: center;margin-left: 30em;">
                       	<tr>
                       	<th>Sr.No.</th>
			<th>Driver ID</th>
			<th>Driver Name</th>
			<th style="width: 30em;">Transporter</th>
			<th colspan="2">Start Day</th>
			<th colspan="2">In Transit</th>
			<th colspan="2">End Day</th>
			<th>Total Result</th>
			</tr>
			<tr>
			<th></th>
			<th></th>
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
		    i = 1;
			int totendno = 0,totendyes = 0,tottransno = 0,tottransyes = 0,totstrtno = 0,totstrtyes = 0,totnotripno = 0,totnotripyes = 0,totcnt = 0;
			String sql = "select distinct(DriverName) ,Transporter,DriverID from db_gps.t_castrolrunhrs where TripStartDate >= '"+date1+"' and TripStartDate <= '"+date2+"' and Category in ('"+category+"') order by DriverName";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				String transporter = rs.getString("Transporter");
				String DriverName = rs.getString("DriverName");
				String DriverID = rs.getString("DriverID");
				int endno = 0,endyes = 0,transitno = 0,transityes = 0,startno =0,startyes = 0,notripno = 0,notripyes = 0,cnt = 0;
				
				String sql1 = "select * from db_gps.t_castrolrunhrs where TripStartDate >= '"+date1+"' and TripStartDate <= '"+date2+"' and DriverID = '"+DriverID+"' and Category in ('"+category+"')";   
				ResultSet rs1 = st1.executeQuery(sql1);
				while(rs1.next())
				{
					String avg = rs1.getString("Avgconsidered");
					String tripday = rs1.getString("TripDay");
					if(avg == "Yes" || avg.equalsIgnoreCase("Yes"))
					{
						if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
						{
							startyes++;
						}
						else
						if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
						{
							endyes++;
						}
						else
						if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
						{
							transityes++;
						}
						else
						{
							notripyes++;
						}
					}
					else
					{
						
							if(tripday == "Start Day" || tripday.equalsIgnoreCase("Start Day"))
							{
								startno++;
							}
							else
							if(tripday == "Last Day" || tripday.equalsIgnoreCase("Last Day"))
							{
								endno++;
							}
							else
							if(tripday == "In-Transit" || tripday.equalsIgnoreCase("In-Transit"))
							{
								transitno++;
							}
							else
							{
								notripno++;
							}
						
					}
				}
					cnt = endyes + transityes + startyes + endno + transitno + startno;
					totendno = totendno + endno;
					totendyes = totendyes + endyes;
					tottransno = tottransno + transitno;
					tottransyes = tottransyes + transityes;
					totstrtno = totstrtno + startno;
					totstrtyes = totstrtyes + startyes;
					totnotripno = totnotripno + notripno;
					totnotripyes = totnotripyes + notripyes;
					
					%>
					<tr>
<!--					<td align="left"><div align="left"><a href= "Castrol_CDDetail.jsp?fromdate=< %=date1 %>&todate=< %=date2 %>&transporter=< %=transporter %>&cnt=All">< %=transporter %></a></div></td>-->
					<td align="right"><div align="right"><%=i %></div></td>
					<td align="right"><div align="right"><%=DriverID %></div></td>
					<%
					if(cnt > 0)
					{
						%>
						   <td align="left"><div align="left"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=<%=DriverID %>&VioDay=All&cat=<%=category %>&avg=All"><%=DriverName %></a></div></td>
						<%
					}
					else
					{
						%>
						    <td align="left"><div align="left"><%=DriverName %></div></td>
						<%
					}
					%>
					<td align="left" style="width: 30em;"><div align="left"><%=transporter %></div></td>
					<td align="right"><div align="right"><%=startno %></div></td>
					<td align="right"><div align="right"><%=startyes %></div></td>
					<td align="right"><div align="right"><%=transitno %></div></td>
					<td align="right"><div align="right"><%=transityes %></div></td>
					<td align="right"><div align="right"><%=endno %></div></td>
					<td align="right"><div align="right"><%=endyes %></div></td>
<!--					<td align="right"><div align="right">< %=notripno %></div></td>-->
<!--					<td align="right"><div align="right">< %=notripno %></div></td>-->
					<td align="right"><div align="right"><%=cnt %></div></td>
					</tr>
					<%
				i++;
			}
				totcnt = totstrtno + totstrtyes + tottransno + tottransyes + totendno + totendyes;
				%>
				<tr>
				<td align="left" colspan="4"><div align="left">Total Result</div></td>
				<%
				if(totstrtno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=No"><%=totstrtno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtno %></div></td>
					<%
					
				}
				
				if(totstrtyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Start Day&cat=<%=category %>&avg=Yes"><%=totstrtyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totstrtyes %></div></td>
					<%
					
				}
				
				if(tottransno > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=No"><%=tottransno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransno %></div></td>
					<%
					
				}
				
				if(tottransyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=In-Transit&cat=<%=category %>&avg=Yes"><%=tottransyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=tottransyes %></div></td>
					<%
					
				}
				
				if(totendno > 0 )
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=No"><%=totendno %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendno %></div></td>
					<%
					
				}
				
				if(totendyes > 0)
				{
					%>
					
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=Last Day&cat=<%=category %>&avg=Yes"><%=totendyes %></a></div></td>
					<%
				}
				else
				{
					%>
					<td align="right"><div align="right"><%=totendyes %></div></td>
					<%
				}
				if(totcnt > 0)
				{
					%>
					<td align="right"><div align="right"><a href= "Castrol_RunHrsDetail.jsp?fromdate=<%=date3 %>&todate=<%=date4 %>&transporter=All&driver=All&VioDay=All&cat=<%=category %>&avg=All"><%=totcnt %></a></div></td>
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
			<%
}
	}
                       %>
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