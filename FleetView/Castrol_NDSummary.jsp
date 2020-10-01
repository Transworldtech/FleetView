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
          document.CastrolND.action ="excel.jsp";
          document.forms["CastrolND"].submit();
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
	//date1 = "2012-06-01";
	//date2 = "2012-06-30";
	System.out.println("Date1    "+date1+ "  Date2     "+date2);
	String datenew = new SimpleDateFormat("MMMM yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1));
	%>
	<br>
	<form id="CastrolND" name="CastrolND" action="" method="post" >
<div id="table1">
	<table border="0" width="100%" class="stats">
		<tr>
		<td colspan="8" align="center">
		<font size="4">Castrol Monthly ND Summary Report for <%=datenew %></font>
	</td>
	</tr></table>
	<%
	 String exportFileName=session.getAttribute("user").toString()+"_Castrol_NDSummary.xls";  
	
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
                           
	<table border="1"  class="sortable"  style="width: 50em;text-align: center;margin-left: 36em;">
	<tr>
	<th>Sr.No.</th>
	<th>Transporter</th>
	<th colspan="2">C1(23:00-23:29)</th>
	<th colspan="2">C2(23:30-04:29)</th>
	<th colspan="2">C3(04:30-05:00)</th>
	<th>Total Result</th>
	</tr>
	<tr>
	<th></th>
	<th></th>
	<th>Primary</th>
	<th>Secondary</th>
	<th>Primary</th>
	<th>Secondary</th>
	<th>Primary</th>
	<th>Secondary</th>
	<th></th>
	</tr>
	<%
	int i = 1;
	int totc1pri= 0,totc1sec = 0,totc2pri = 0,totc2sec = 0,totc3pri = 0,totc3sec = 0,totcnt = 0;
	String sql = "select distinct(Transporter) from db_gps.t_castrolnd where TripStartDate >= '"+date1+" 00:00:00' and TripStartDate <= '"+date2+" 23:59:59' and Category in ('Primary','Secondary') order by Transporter";
	ResultSet rs = st.executeQuery(sql);
	while(rs.next())
	{
		String transporter = rs.getString("Transporter");
		int ndc1pri = 0,ndc1sec = 0,ndc2pri = 0,ndc2sec = 0,ndc3pri =0,ndc3sec = 0,ndcnt = 0;
		String sql1 = "select * from db_gps.t_castrolnd where TripStartDate >= '"+date1+" 00:00:00' and TripStartDate <= '"+date2+" 23:59:59' and Transporter = '"+transporter+"' and Category in ('Primary','Secondary')";   
		ResultSet rs1 = st1.executeQuery(sql1);
		while(rs1.next())
		{
			String ndcategory  = rs1.getString("NDCategory");
			String category = rs1.getString("Category");
			if(category == "Primary" || category.equalsIgnoreCase("Primary"))
			{
				if(ndcategory == "C1" || ndcategory.equalsIgnoreCase("C1"))
				{
					ndc1pri ++;
				}
				else
					if(ndcategory == "C2" || ndcategory.equalsIgnoreCase("C2"))
					{
						ndc2pri++;
					}
					else
						if(ndcategory == "C3" || ndcategory.equalsIgnoreCase("C3"))
						{
							ndc3pri++;
						}
			}
			else
				if(category == "Secondary" || category.equalsIgnoreCase("Secondary"))
				{
					if(ndcategory == "C1" || ndcategory.equalsIgnoreCase("C1"))
					{
						ndc1sec ++;
					}
					else
						if(ndcategory == "C2" || ndcategory.equalsIgnoreCase("C2"))
						{
							ndc2sec++;
						}
						else
							if(ndcategory == "C3" || ndcategory.equalsIgnoreCase("C3"))
							{
								ndc3sec++;
							}
				}
			
		}
		ndcnt = ndc1pri + ndc2pri + ndc3pri + ndc1sec + ndc2sec + ndc3sec;
		totc1pri = totc1pri + ndc1pri;
		totc1sec = totc1sec + ndc1sec;
		totc2pri = totc2pri + ndc2pri;
		totc2sec = totc2sec + ndc2sec;
		totc3pri = totc3pri + ndc3pri;
		totc3sec = totc3sec + ndc3sec;
		%>
		<tr>
		<td align="right"><div align="right"><%=i %></div></td>
	<td align="left"><div align="left"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=<%=transporter %>&cat=All&ndcat=All&showtan=No"><%=transporter %></a></div></td>
<!--		<td align="left"><div align="left">< %=transporter %></div></td>-->
		<td align="right"><div align="right"><%=ndc1pri %></div></td>
		<td align="right"><div align="right"><%=ndc1sec %></div></td>
		<td align="right"><div align="right"><%=ndc2pri %></div></td>
		<td align="right"><div align="right"><%=ndc2sec %></div></td>
		<td align="right"><div align="right"><%=ndc3pri %></div></td>
		<td align="right"><div align="right"><%=ndc3sec %></div></td>
		<td align="right"><div align="right"><%=ndcnt %></div></td>
		</tr>
		<%
		i++;
	}
	totcnt = totc1pri + totc1sec + totc2pri + totc2sec + totc3pri + totc3sec ;
	%>
	<tr>
	<td align="left" colspan="2"><div align="left">Total Result</div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Primary&ndcat=C1&showtan=No"><%=totc1pri%></a></div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Secondary&ndcat=C1&showtan=No"><%=totc1sec%></a></div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Primary&ndcat=C2&showtan=No"><%=totc2pri%></a></div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Secondary&ndcat=C2&showtan=No"><%=totc2sec%></a></div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Primary&ndcat=C3&showtan=No"><%=totc3pri%></a></div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Secondary&ndcat=C3&showtan=No"><%=totc3sec%></a></div></td>
	<td align="right"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=All&ndcat=All&showtan=No"><%=totcnt%></a></div></td>
	</tr>
	</table>
	<br></br>
	<br></br>
	<table border="1"  class="sortable"  style="width: 50em;text-align: center;margin-left: 36em;">
	<tr>
	<th>Sr.No.</th>
	<th>Transporter</th>
	<th colspan="2">C1(23:00-23:29)</th>
	<th colspan="2">C2(23:30-04:29)</th>
	<th colspan="2">C3(04:30-05:00)</th>
	<th>Total Result</th>
	</tr>
	<tr>
	<th></th>
	<th></th>
	<th>Non Trip</th>
	<th>Trip</th>
	<th>Non Trip</th>
	<th>Trip</th>
	<th>Non Trip</th>
	<th>Trip</th>
	<th></th>
	</tr>
	<%
	i = 1;
	int totc1ntrip = 0 ,totc1trip = 0,totc2ntrip = 0,totc2trip = 0,totc3ntrip = 0,totc3trip = 0,totancnt = 0;
	sql = "select distinct(Transporter) from db_gps.t_castrolnd where TheDate >= '"+date1+"' and TheDate <= '"+date2+"' and Category  in ('Tanker','-') order by Transporter";
	 rs = st.executeQuery(sql);
	 while(rs.next())
	 {
		 String transporter = rs.getString("Transporter");
		 int ndc1ntrip = 0,ndc1trip = 0,ndc2ntrip = 0,ndc2trip = 0,ndc3ntrip =0,ndc3trip = 0,ndtancnt = 0;
		 String sql1 = "select * from db_gps.t_castrolnd where TheDate >= '"+date1+"' and TheDate <= '"+date2+"' and Transporter = '"+transporter+"' and Category  in ('Tanker','-')";   
		 ResultSet rs1 = st1.executeQuery(sql1);
		 while(rs1.next())
		 {
			
				// System.out.println("******   ");
			 String ndcategory  = rs1.getString("NDCategory");
			 String category = rs1.getString("Category");
		//	 System.out.println("*****8    "+category);
			 String tripid =  rs1.getString("tripid");
			 if(tripid == "-" || tripid.equals("-"))
			 {
				 if(ndcategory == "C1" || ndcategory.equalsIgnoreCase("C1"))
					{
					 ndc1ntrip ++;
					}
					else
						if(ndcategory == "C2" || ndcategory.equalsIgnoreCase("C2"))
						{
							ndc2ntrip++;
						}
						else
							if(ndcategory == "C3" || ndcategory.equalsIgnoreCase("C3"))
							{
								ndc3ntrip++;
							}
			 }
			 else
			 {
				 
				 if(ndcategory == "C1" || ndcategory.equalsIgnoreCase("C1"))
					{
					 ndc1trip ++;
					}
					else
						if(ndcategory == "C2" || ndcategory.equalsIgnoreCase("C2"))
						{
							ndc2trip++;
						}
						else
							if(ndcategory == "C3" || ndcategory.equalsIgnoreCase("C3"))
							{
								ndc3trip++;
							}
			
			
		 }
		 }
		   ndtancnt = ndc1ntrip + ndc2ntrip + ndc3ntrip + ndc1trip + ndc2trip + ndc3trip;
		   totc1ntrip = totc1ntrip + ndc1ntrip;
		   totc1trip = totc1trip + ndc1trip;
		   totc2ntrip = totc2ntrip + ndc2ntrip;
		   totc2trip = totc2trip + ndc2trip;
		   totc3ntrip = totc3ntrip + ndc3ntrip;
		   totc3trip = totc3trip + ndc3trip;
		   %>
			<tr>
			<td align="right"><div align="right"><%=i %></div></td>
		<td align="left"><div align="left"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=<%=transporter %>&cat=All&ndcat=All&showtan=Yes"><%=transporter %></a></div></td>
<!--			<td align="left"><div align="left">< %=transporter %></div></td>-->
			<td align="right"><div align="right"><%=ndc1ntrip %></div></td>
			<td align="right"><div align="right"><%=ndc1trip %></div></td>
			<td align="right"><div align="right"><%=ndc2ntrip %></div></td>
			<td align="right"><div align="right"><%=ndc2trip %></div></td>
			<td align="right"><div align="right"><%=ndc3ntrip %></div></td>
			<td align="right"><div align="right"><%=ndc3trip %></div></td>
			<td align="right"><div align="right"><%=ndtancnt %></div></td>
			</tr>
			<%
			i++;
	 }
	 totancnt = totc1ntrip + totc1trip + totc2ntrip + totc2trip + totc3ntrip + totc3trip ;
		%>
		<tr>
		<td align="left" colspan="2"><div align="left">Total Result</div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=-&ndcat=C1&showtan=Yes"><%=totc1ntrip%></a></div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Tanker&ndcat=C1&showtan=Yes"><%=totc1trip%></a></div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=-&ndcat=C2&showtan=Yes"><%=totc2ntrip%></a></div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Tanker&ndcat=C2&showtan=Yes"><%=totc2trip%></a></div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=-&ndcat=C3&showtan=Yes"><%=totc3ntrip%></a></div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=Tanker&ndcat=C3&showtan=Yes"><%=totc3trip%></a></div></td>
		<td align="left"><div align="right"><a href= "Castrol_NDDetail.jsp?fromdate=<%=date1 %>&todate=<%=date2 %>&transporter=All&cat=All&ndcat=All&showtan=Yes"><%=totancnt%></a></div></td>
		</tr>
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