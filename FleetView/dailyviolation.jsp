<%@ include file="headernew.jsp" %>
<%
	response.setHeader("Cache-Control","no-cache");
  	response.setHeader("Pragma","no-cache");
  	response.setDateHeader ("Expires", 0);
 %>
 
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
</script>
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}
</style>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>castrolTotalTrips</title>
</head>
<body>
<%!
	Connection conn,conn1;
	Statement st4,st1,st2;
	String fromdate, todate,drivernm,driverid;
	NumberFormat nf = DecimalFormat.getNumberInstance();
%>


<table border="0" width="100%">
<%
//String sortby=request.getParameter("sortby");
//System.out.println("sortby--->"+sortby);

//out.println("\nsortby-===-->"+sortby);
if(!(null==request.getQueryString()))
{
try
{
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String thename,fromdate="", todate="";
	thename=request.getParameter("thename");
	fromdate=request.getParameter("data1");
	todate=request.getParameter("data2");
	drivernm=request.getParameter("DriverName");
	driverid=request.getParameter("DriverID");
	//String Transporter=session.getAttribute("usertypevalue").toString();
	
		
			if(thename.equals("started"))
			{
				%>
				<tr><td><div class="bodyText" align="left"> 
				<!-- <font size="2"><b>Report No : 6.2.1</b></font>--></div></td></tr>
				<tr align="center"><td><b>
				<font size="3">Driver <%=drivernm %>'s daily hours Violation details from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %> To <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate)) %></font></b></td></tr>
				 <tr><td><div class="bodyText" align="left"> 
				 <font size="2"><b><I>NOTE :</b>Hours has been converted in decimal format for better understanding, read 5.50 hrs as 05 Hrs and 30 Minutes respectively.</I></font>
				 </div></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_dailyviolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%="started"%>&driverid=<%=driverid %>&drivernm=<%=drivernm %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_dailyviolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%="started"%>&driverid=<%=driverid %>&drivernm=<%=drivernm %>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
	</td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr align="center"><td><b><font size="3">Daily Driving Hrs Violation Report For <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_drivinghrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_drivinghrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
	</td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr align="center"><td><b><font size="3">Daily Driving Hrs Violation Report For <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_drivinghrs.jsp.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_drivinghrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
	</td></tr>
				<%
			}
		
	%>
	</table>
	<%
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

	st4=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	
if(!(null==thename))
{ 
		//*********************************
	
	if(thename.equalsIgnoreCase("ended"))
	{}

///************************************************STARTED**********************************************************************************************	
	else if(thename.equalsIgnoreCase("started"))
	{
			
		//***************************************started all trips**************************************************
			java.util.Date startdate=new java.util.Date();
			java.util.Date sevenday=new java.util.Date();
		//	java.util.Date lastdate=new java.util.Date();
			String lastdate,nextday;
				%>
				<table border="1" width="100%" class=stats>
				<tr>
				<td class="hed" rowspan="2"><b>Sr.</b></td>
				<td class="hed" rowspan="2"><b>DriverName </b></td>
				<td class="hed" rowspan="2"><b>DriverID</b></td>
				<td class="hed" rowspan="2"><b>Date</b></td>
				<td class="hed" rowspan="2"><b>Transporter</b></td>
				<td class="hed" rowspan="2"><b>Vehicle</b></td>
				<td class="hed" rowspan="2"><b>Km Traveled</b></td>
				<td class="hed" rowspan="2"><b>Duration(Hrs)</b></td>
				<td class="hed" rowspan="2"><b>CastrolTrip</b></td>
				<td class="hed" colspan="3">Previous Day</td>
				<td class="hed" colspan="3">Next Day</td>
				<td class="hed" rowspan="2"><b>Total Km Traveled</b></td>
				<td class="hed" rowspan="2"><b>Total Duration(Hrs)</b></td>
				<td class="hed" rowspan="2"><b>Castrol Days</b></td>
				</tr>
				<tr>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
				</tr>
		<%
				int i1=1;
				double stdkm=0.00, ttime=0.00,ratinge=0.00;
				int nd=0;
				int totkm=0,totdur=0,totcastrol=0;
				int km=0,dur=0,castrol=0;
				int prvkm=0,prvdur=0,prvcastrol=0;
				int nxtkm=0,nxtdur=0,nxtcastrol=0;
				String PSvehlist="(";
				String sql="select * from t_CastrolDrivers6 where TheDte between '"+fromdate+"' and '"+todate+"' AND DrinHrs > 10 and DriverID ='"+driverid+"' order by TheDte Asc";
					ResultSet rst=st4.executeQuery(sql);
					while(rst.next())
					{
							//km=rst.getInt("Distance");
							%>
							<tr>
							<td><%=i1%></td>
							<td><%=rst.getString("DriverName")%></td>
							<td><%=rst.getString("DriverID")%></td>
							<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDte")))%></td>
							<td><%=rst.getString("Transporter")%></td>
							<td><%=rst.getString("VehRegNo")%></td>
							<td><%=rst.getString("Distance")%></td>
							<td><%=rst.getString("DrinHrs")%></td>
							<td><%=rst.getString("CastrolTrip")%></td>
							<%
							startdate=rst.getDate("TheDte");
							long todaymils = startdate.getTime();
							long previousday=60*60*1000*24*1;
							previousday=todaymils-previousday;
							sevenday.setTime(previousday);
							//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
							lastdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							long nextday1=60*60*1000*24*1;
							nextday1=todaymils+nextday1;
							sevenday.setTime(nextday1);
							//enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
							nextday=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							String sql1="select * from t_CastrolDrivers6 where TheDte = '"+lastdate+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst1=st1.executeQuery(sql1);
							if(rst1.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst1.getString("Distance")%></td>
								<td><%=rst1.getString("DrinHrs")%></td>
								<td><%=rst1.getString("CastrolTrip")%></td>
								<%
							}
							else
							{
								//prvkm=0;
								%>
								<td><%="NA"%></td>
								<td><%="NA"%></td>
								<td><%="NA"%></td>
								<%
							}
							String sql11="select * from t_CastrolDrivers6 where TheDte = '"+nextday+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//"select * from t_CastrolDrivers6 where TheDte > '"+rst.getString("TheDte")+"' order by Thedte Asc limit 1";
							ResultSet rst11=st1.executeQuery(sql11);
							//System.out.println(sql11);
							if(rst11.next())
							{
								//nxtkm=rst11.getInt("Distance");
								%>
								<td><%=rst11.getString("Distance")%></td>
								<td><%=rst11.getString("DrinHrs")%></td>
								<td><%=rst11.getString("CastrolTrip")%></td>
								<%
							}
							else
							{
								//nxtkm=0;
								%>
								<td><%="NA"%></td>
								<td><%="NA"%></td>
								<td><%="NA"%></td>
								<%
							}
							String sql111="select sum(DrinHrs) as sumdur,sum(Distance) as Distance from t_CastrolDrivers6 where DriverID='"+rst.getString("DriverID")+"' and TheDte between '"+lastdate+"' and  '"+nextday+"'";
							//"select * from t_CastrolDrivers6 where TheDte > '"+rst.getString("TheDte")+"' order by Thedte Asc limit 1";
							ResultSet rst111=st1.executeQuery(sql111);
							//System.out.println(sql11);
							if(rst111.next())
							{
								//nxtkm=rst111.getInt("Distance");
								String totdur11=rst111.getString("sumdur");
								//System.out.println("totaldur::>>"+totdur11);
								%>
								<td><%=rst111.getString("Distance")%></td>
								<td><%=rst111.getString("sumdur")%></td>
								<%
							}
							String sql1111="select count(*) as count from t_CastrolDrivers6 where DriverID='"+rst.getString("DriverID")+"' and TheDte between '"+lastdate+"' and  '"+nextday+"' and CastrolTrip = 'Yes'";
							//"select * from t_CastrolDrivers6 where TheDte > '"+rst.getString("TheDte")+"' order by Thedte Asc limit 1";
							ResultSet rst1111=st1.executeQuery(sql1111);
							//System.out.println(sql11);
							if(rst1111.next())
							{
								//nxtkm=rst111.getInt("Distance");
								%>
								<td><%=rst1111.getString("count")%></td>
								
								<%
							}
							else
							{
								%>
								<td><%=0%></td>
								
								<%	
							}
							//totkm=km+prvkm+nxtkm;
							%>
							
							</tr>
							<%
							i1++;
						}
				
			%>
			</table>
			<%
	
	}//end of else if started
	else if(thename.equalsIgnoreCase("both"))
	{}

//*********************************************************************************************
} //the name
} //try

	catch(Exception e)
	{
		e.printStackTrace();
	//	System.out.println("In side exception");	
	}
	finally
	{
		conn.close();
		conn1.close();
	}
}
	%>
	
	</body>
	</html>
<%@ include file="footernew.jsp" %>