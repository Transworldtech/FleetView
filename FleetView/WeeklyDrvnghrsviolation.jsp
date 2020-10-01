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
	Statement st4,st1,st8,st2,stv,std;
	String fromdate, todate;
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
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	//String Transporter=session.getAttribute("usertypevalue").toString();
	
		
			if(thename.equals("started"))
			{
				%>
				<!-- <tr style="border:none"><td><font color="block" size="3" >Report No: 10.14</font></td></tr>-->
				<tr align="center"><td><b><font size="3">Weekly Driving Hrs Violation Report For <%=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 <a href="excel_drivingweekhrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_drivingweekhrs.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
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
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

	
	st8=conn.createStatement();
	stv=conn1.createStatement();
	std=conn.createStatement();
	st4=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	
if(!(null==thename))
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
		double stdkm=0.00, ttime=0.00,ratinge=0.00;
		int nd=0;
		int totkm=0,totdur=0,totcastrol=0;
		int km=0,dur=0,castrol=0,vehid;
		int prvkm=0,prvdur=0,prvcastrol=0;
		int nxtkm=0,nxtdur=0,nxtcastrol=0;
		String drivernm="",drivernm1="",vehregno="";
				String PSvehlist="(";
				String sql="select * from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and Last7DayRDurationinHrs >= '60' and GPName='Castrol' order by TheDate Asc";
					ResultSet rst=st4.executeQuery(sql);
					while(rst.next())
					{
						
						km=0;
						startdate=rst.getDate("TheDate");
						long todaymils = startdate.getTime();
						long lastseven=60*60*1000*24*6;
						lastseven=todaymils-lastseven;
						sevenday.setTime(lastseven);
						enddate=new SimpleDateFormat("dd-MMM-yyyy").format(sevenday);
						lastdate=new SimpleDateFormat("yyyy-MM-dd").format(sevenday);
						String sqlkm="select sum(Distance) as Distance from t_driver_ds where TheDate between '"+lastdate+"' and '"+startdate+"' and DCode='"+rst.getString("DCode")+"'";
						ResultSet rstkm=st8.executeQuery(sqlkm);
						while(rstkm.next())
						{
							km=rstkm.getInt("Distance");
						}
						drivernm=rst.getString("DCode");
						String sqld="select DriverName from t_drivers where DriverID='"+drivernm+"'";
						System.out.println("sqld--->"+sqld);
						ResultSet rstd=stv.executeQuery(sqld);
						if(rstd.next())
						{
							drivernm1=rstd.getString("DriverName");
							System.out.println("drivernm1--->"+drivernm1);
						}
						vehid=rst.getInt("VehCode");
						String sqlv="select VehicleRegNumber from t_vehicledetails where VehicleCode='"+vehid+"'";
						System.out.println("sqlv--->"+sqlv);
						ResultSet rstv=stv.executeQuery(sqlv);
						if(rstv.next())
						{
							vehregno=rstv.getString("VehicleRegNumber");
							System.out.println("vehregno--->"+vehregno);
						}
						
						
						%>
							<tr>
							<td><%=i1%></td>
							<td><%=drivernm1%></td>
							<td><%=rst.getString("DCode")%></td>
							<td><%=enddate%></td>
							<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%></td>
							<td><%=rst.getString("Transporter")%></td>
							<td><%=vehregno%></td>
							<td><%=km%></td>
							<td><%=rst.getString("Last7DayRDurationinHrs")%></td>
							<td><%=rst.getString("JCode")%></td>
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
							String sql1="select * from t_driver_ds where TheDate = '"+lastdate1+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst1=st1.executeQuery(sql1);
							if(rst1.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst1.getString("Distance")%></td>
								<td><%=rst1.getString("RDurationinHrs")%></td>
								<td><%=rst1.getString("JCode")%></td>
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
							String sql2="select * from t_driver_ds where TheDate = '"+nextday+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst2=st1.executeQuery(sql2);
							if(rst2.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst2.getString("Distance")%></td>
								<td><%=rst2.getString("RDurationinHrs")%></td>
								<td><%=rst2.getString("JCode")%></td>
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
							
							String sql3="select * from t_driver_ds where TheDate = '"+nexttwo+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst3=st1.executeQuery(sql3);
							if(rst3.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst3.getString("Distance")%></td>
								<td><%=rst3.getString("RDurationinHrs")%></td>
								<td><%=rst3.getString("JCode")%></td>
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
							String sql4="select * from t_driver_ds where TheDate = '"+nextthree+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst4=st1.executeQuery(sql4);
							if(rst4.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst4.getString("Distance")%></td>
								<td><%=rst4.getString("RDurationinHrs")%></td>
								<td><%=rst4.getString("JCode")%></td>
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
								
							String sql5="select * from t_driver_ds where TheDate = '"+nextfour+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst5=st1.executeQuery(sql5);
							if(rst5.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst5.getString("Distance")%></td>
								<td><%=rst5.getString("RDurationinHrs")%></td>
								<td><%=rst5.getString("JCode")%></td>
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
							
							String sql6="select * from t_driver_ds where TheDate = '"+nextfive+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst6=st1.executeQuery(sql6);
							if(rst6.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst6.getString("Distance")%></td>
								<td><%=rst6.getString("RDurationinHrs")%></td>
								<td><%=rst6.getString("JCode")%></td>
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
							
							String sql7="select * from t_driver_ds where TheDate = '"+nextsix+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst7=st1.executeQuery(sql7);
							if(rst7.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst7.getString("Distance")%></td>
								<td><%=rst7.getString("RDurationinHrs")%></td>
								<td><%=rst7.getString("JCode")%></td>
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
							
							/*String sql8="select * from t_driver_ds where TheDate = '"+startdate+"' and DriverID = '"+rst.getString("DriverID")+"'";
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
							
							String sql9="select * from t_driver_ds where TheDate = '"+startdate+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql9);
							ResultSet rst9=st1.executeQuery(sql9);
							if(rst9.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								<td><%=rst9.getString("Distance")%></td>
								<td><%=rst9.getString("RDurationinHrs")%></td>
								<td><%=rst9.getString("JCode")%></td>
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
							
							String sql8="select * from t_driver_ds where TheDate = '"+nextseven+"' and DCode = '"+rst.getString("DCode")+"'";
							//System.out.println(sql1);
							ResultSet rst8=st1.executeQuery(sql8);
							if(rst8.next())
							{
								//prvkm=rst1.getInt("Distance");
								%>
								 <td><%=rst8.getString("Distance")%></td>
								<td><%=rst8.getString("RDurationinHrs")%></td>
								<td><%=rst8.getString("JCode")%></td>
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
%>
							
							</tr>
							<%
							
							i1++;
						}
				
			%>
			</table>
			<%
//*********************************************************************************************
} //the name
} //try

	catch(Exception e)
	{
		//e.printStackTrace();
		System.out.println("In side exception"+e);	
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
