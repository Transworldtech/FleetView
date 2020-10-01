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
	Statement st4,st8,st1,st2;
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
	driverid=request.getParameter("DriverID");
	drivernm=request.getParameter("DriverName");
	//String Transporter=session.getAttribute("usertypevalue").toString();
	
		
			if(thename.equals("started"))
			{
				%>
				<tr><td><div class="bodyText" align="left"> 
				<font size="2"><b>Report No : 6.2.2</b></font></div></td></tr>
				<tr align="center"><td><b>
				<font size="3">Driver <%=drivernm %>'s weekly hours Violation details from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate)) %></font></b></td></tr>
				<tr><td><div class="bodyText" align="left"> 
				 <font size="2"><b><I>NOTE :</b>Hours has been converted in decimal format for better understanding, read 5.50 hrs as 05 Hrs and 30 Minutes respectively.</I></font>
				 </div></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_weeklyhrsViolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%="started"%>&driverid=<%=driverid %>&drivernm=<%=drivernm %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_weeklyhrsViolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%="started"%>&driverid=<%=driverid %>&drivernm=<%=drivernm %>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
	</td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr align="center"><td><b><font size="3">Weekly Driving Hrs Violation Report For <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_drivingweekhrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_drivingweekhrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
	</td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr align="center"><td><b><font size="3">Weekly Driving Hrs Violation Report For <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_drivingweekhrs.jsp.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_drivingweekhrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
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
	st8=conn.createStatement();
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
			java.util.Date sevenday1=new java.util.Date();
		//	java.util.Date lastdate=new java.util.Date();
			String enddate,lastdate,lastdate1,nextday;
			String nexttwo,nextthree,nextfour,nextfive,nextsix,nextseven;
				%>
				<table border="1" width="100%" class="stats">
				<tr>
				<td class="hed" rowspan="2"><b>Sr.</b></td>
				<td  class="hed" rowspan="2"><b>DriverName </b></td>
				<td  class="hed" rowspan="2"><b>DriverID</b></td>
				<td  class="hed" rowspan="2"><b>From Date</b></td>
				<td  class="hed" rowspan="2"><b>To Date</b></td>
				<td  class="hed" rowspan="2"><b>Transporter</b></td>
				<td  class="hed" rowspan="2"><b>Vehicle</b></td>
				<td  class="hed" rowspan="2"><b>Km Travelled</b></td>
				<td  class="hed" rowspan="2"><b>Duration(Hrs)</b></td>
				<td  class="hed" rowspan="2"><b>CastrolTrip</b></td>
				<td  class="hed" colspan="3"><b>Previous Day</b></td>
				<td  class="hed" colspan="3"><b>First Day</b></td>
				<td  class="hed" colspan="3"><b>Second Day</b></td>
				<td  class="hed" colspan="3"><b>Third Day</b></td>
				<td  class="hed" colspan="3"><b>Fourth Day</b></td>
				<td  class="hed" colspan="3"><b>Fifth Day</b></td>
				<td  class="hed" colspan="3"><b>Sixth Day</b></td>
				<td  class="hed" colspan="3"><b>Seventh Day</b></td>
				<td  class="hed" colspan="3"><b>Next Day</b></td>
				<td  class="hed" rowspan="2"><b>Total Km Travelled</b></td>
				<td  class="hed" rowspan="2"><b>Total Duration(Hrs)</b></td>
				<td  class="hed" rowspan="2"><b>Castrol Days</b></td>
				</tr>
				<tr>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					<td  class="hed"> Km Traveled</td>
					<td  class="hed"> Duration(Hrs)</td>
					<td  class="hed"> CastrolTrip</td>
					
				</tr>
		<%
				int i1=1;
				int km=0;
				int nd=0;
				String PSvehlist="(";
				String sql="select * from t_CastrolDrivers6 where TheDte between '"+fromdate+"' and '"+todate+"' AND LastWeekRDurInHrs > 60 and DriverID='"+driverid+"' order by TheDte Asc";
					ResultSet rst=st4.executeQuery(sql);
					while(rst.next())
					{
						
						km=0;
						startdate=rst.getDate("TheDte");
						long todaymils = startdate.getTime();
						long lastseven=60*60*1000*24*6;
						lastseven=todaymils-lastseven;
						sevenday.setTime(lastseven);
						enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						lastdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						//System.out.println(lastdate);
						String sqlkm="select sum(Distance) as Distance from t_CastrolDrivers6 where TheDte between '"+lastdate+"' and '"+startdate+"' and DriverID='"+rst.getString("DriverID")+"'";
					//	System.out.println(sqlkm);
						ResultSet rstkm=st8.executeQuery(sqlkm);
						while(rstkm.next())
						{
							km=rstkm.getInt("Distance");
						}
						%>
							<tr>
							<td><%=i1%></td>
							<td><%=rst.getString("DriverName")%></td>
							<td><%=rst.getString("DriverID")%></td>
							<td><%=enddate%></td>
							<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDte")))%></td>
							<td><%=rst.getString("Transporter")%></td>
							<td><%=rst.getString("VehRegNo")%></td>
							<td><%=km%></td>
							<td><%=rst.getString("LastWeekRDurInHrs")%></td>
							<td><%=rst.getString("CastrolTrip")%></td>
							
							<%
							long previousday=60*60*1000*24*7;
							previousday=todaymils-previousday;
							sevenday.setTime(previousday);
							lastdate1=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("prevday::>>"+lastdate1);
							
							long nextday11=60*60*1000*24*6;
							nextday11=todaymils-nextday11;
							sevenday.setTime(nextday11);
							nextday=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("firstday::>>"+nextday);
							
							long nextday22=60*60*1000*24*5;
							nextday22=todaymils-nextday22;
							sevenday.setTime(nextday22);
							nexttwo=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("secondday::>>"+nexttwo);
							
							long nextday33=60*60*1000*24*4;
							nextday33=todaymils-nextday33;
							sevenday.setTime(nextday33);
							nextthree=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("thirdday::>>"+nextthree);
							
							long nextday44=60*60*1000*24*3;
							nextday44=todaymils-nextday44;
							sevenday.setTime(nextday44);
							nextfour=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("fourthday::>>"+nextfour);
							
							long nextday55=60*60*1000*24*2;
							nextday55=todaymils-nextday55;
							sevenday.setTime(nextday55);
							nextfive=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("fifthday::>>"+nextfive);
							
							long nextday66=60*60*1000*24*1;
							nextday66=todaymils-nextday66;
							sevenday.setTime(nextday66);
							nextsix=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("sixthday::>>"+nextsix);
							
							long nextday77=60*60*1000*24*1;
							nextday77=todaymils+nextday77;
							sevenday.setTime(nextday77);
							nextseven=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
							//System.out.println("seventhday::>>"+nextseven);
							
							//For previous day
							String sql1="select * from t_CastrolDrivers6 where TheDte = '"+lastdate1+"' and DriverID = '"+rst.getString("DriverID")+"'";
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
							
							//For First day
							String sql2="select * from t_CastrolDrivers6 where TheDte = '"+nextday+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst2=st1.executeQuery(sql2);
							if(rst2.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst2.getString("Distance")%></td>
								<td><%=rst2.getString("DrinHrs")%></td>
								<td><%=rst2.getString("CastrolTrip")%></td>
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
							
							//For second day
							
							String sql3="select * from t_CastrolDrivers6 where TheDte = '"+nexttwo+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst3=st1.executeQuery(sql3);
							if(rst3.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst3.getString("Distance")%></td>
								<td><%=rst3.getString("DrinHrs")%></td>
								<td><%=rst3.getString("CastrolTrip")%></td>
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
							
							//For third day
							String sql4="select * from t_CastrolDrivers6 where TheDte = '"+nextthree+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst4=st1.executeQuery(sql4);
							if(rst4.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst4.getString("Distance")%></td>
								<td><%=rst4.getString("DrinHrs")%></td>
								<td><%=rst4.getString("CastrolTrip")%></td>
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
							
							//For fourth day
								
							String sql5="select * from t_CastrolDrivers6 where TheDte = '"+nextfour+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst5=st1.executeQuery(sql5);
							if(rst5.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst5.getString("Distance")%></td>
								<td><%=rst5.getString("DrinHrs")%></td>
								<td><%=rst5.getString("CastrolTrip")%></td>
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
							
							//For fifth day
							
							String sql6="select * from t_CastrolDrivers6 where TheDte = '"+nextfive+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst6=st1.executeQuery(sql6);
							if(rst6.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst6.getString("Distance")%></td>
								<td><%=rst6.getString("DrinHrs")%></td>
								<td><%=rst6.getString("CastrolTrip")%></td>
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
							
							//For sixth day
							
							String sql7="select * from t_CastrolDrivers6 where TheDte = '"+nextsix+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst7=st1.executeQuery(sql7);
							if(rst7.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst7.getString("Distance")%></td>
								<td><%=rst7.getString("DrinHrs")%></td>
								<td><%=rst7.getString("CastrolTrip")%></td>
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
											
							//For seventh day
							
							/*String sql8="select * from t_CastrolDrivers6 where TheDte = '"+startdate+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst8=st1.executeQuery(sql8);
							if(rst8.next())
							{*/
								//prvkm=rst1.getInt("Distance");
								%>
								<!-- <td>< %=rst8.getString("Distance")%></td>
								<td>< %=rst8.getString("Duration")%></td>
								<td>< %=rst8.getString("CastrolTrip")%></td>-->
								<%
							//}
							//else
							//{
								//prvkm=0;
								%>
								<!-- <td>< %="NA"%></td>
								<td>< %="NA"%></td>
								<td>< %="NA"%></td> -->
								<%
							//}				
						
							//For seventh day
							
							String sql9="select * from t_CastrolDrivers6 where TheDte = '"+startdate+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql9);
							ResultSet rst9=st1.executeQuery(sql9);
							if(rst9.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst9.getString("Distance")%></td>
								<td><%=rst9.getString("DrinHrs")%></td>
								<td><%=rst9.getString("CastrolTrip")%></td>
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
							
						//For next day
							
							String sql8="select * from t_CastrolDrivers6 where TheDte = '"+nextseven+"' and DriverID = '"+rst.getString("DriverID")+"'";
							//System.out.println(sql1);
							ResultSet rst8=st1.executeQuery(sql8);
							if(rst8.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								 <td><%=rst8.getString("Distance")%></td>
								<td><%=rst8.getString("DrinHrs")%></td>
								<td><%=rst8.getString("CastrolTrip")%></td>
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
							
							String sql111="select sum(DrinHrs) as sumdur,sum(Distance) as Distance from t_CastrolDrivers6 where DriverID='"+rst.getString("DriverID")+"' and TheDte between '"+lastdate1+"' and  '"+nextseven+"'";
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
							
							String sql1111="select count(*) as count from t_CastrolDrivers6 where DriverID='"+rst.getString("DriverID")+"' and TheDte between '"+lastdate1+"' and  '"+nextseven+"' and CastrolTrip = 'Yes'";
							//"select * from t_CastrolDrivers6 where TheDte > '"+rst.getString("TheDte")+"' order by Thedte Asc limit 1";
							//System.out.println(sql1111);
								ResultSet rst1111=st1.executeQuery(sql1111);
							
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
