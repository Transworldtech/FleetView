<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<html>

<head>

<title>Vehicle Tracking System</title>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/erratic.css" rel="StyleSheet" type="text/css">
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
          <table border="0" align="left" width="100%">
<tr>
<td>
<!-- unit logo comes here --->
<div align="left">
<img src="images/Transworld.jpeg"  border="0">
</div>
<!-- unit logo comes here --->
<div align="right">Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
</tr>
</table>
			<!-- header file -->
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<%!
			Connection conn,conn1;
			Statement st,st1,st2,st3,st4, st5, st6, st7, st8, st9, st10;
			String sql,sql1,vehicle,date1,date2, msg;
			int stopmimn,runmin,ndrunmin,daystopmin;
			int runtotal,stoptotal,nighttotal,totruninsecs,totnighttotal, totdaystoptotal;
			double totkmtrav=0, avgspeedoffleet=0, avgrunspeedoffleet=0;
			String dateformat;
			 %>
			<%
			dateformat=session.getAttribute("dateformat").toString();
			if(null==request.getQueryString())
			{
					vehicle="All";
					date2=date1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			
			}
			else
			{
					vehicle=request.getParameter("vehicle");
					date1=request.getParameter("data");
					date2=request.getParameter("data1");
			}
			try
			{
				Class.forName("org.gjt.mm.mysql.Driver"); 
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				st=conn.createStatement();
				st1=conn.createStatement();
				st2=conn1.createStatement();
				st3=conn1.createStatement();
				st4=conn1.createStatement();
				st5=conn1.createStatement();
				st6=conn1.createStatement();
				st7=conn1.createStatement();
				st8=conn1.createStatement();
				st9=conn1.createStatement();
				st10=conn1.createStatement();

									
			%>
			<table width="100%" align="center" class="sortable">
			<tr><td  class="sorttable_nosort">
			</td></tr>
			
			
			</table>
			<%
			if(!(null==request.getQueryString()))
			{			
			%>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Run Analysis Report for <% if(vehicle.equals("All")) {%>All Vehicles <%}else { out.print ("Vehicle "+vehicle); } %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></font></div>
				
			</td>
			</tr>			
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Date</th>
			<th class="hed"> Running Time </th>
			<th class="hed"> Night Stop Time</th>
			<th class="hed"> Day Stops Time</th>
			<th class="hed">
			<% 
				if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				{
			%> 		<br>Miles Travelled
			<%		}else { 
			%>	
				<br>Km Travelled
			<% } %>

			</th>
			<th class="hed"> Avg. Running Speed<br>(km/hr)</br></th> 
			<!-- <% 
				//if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				//{
			%> 		(Miles/hr)
			<%		//}else { 
			%>	
				<br>(km/hr)
			<% //} %>
			</th> -->
		
			<th class="hed"> Avg. Speed <br>(km/hr)</br></th>
			<!-- <% 
				//if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				//{
			%> 		(Mile/hr)
			<%		//}else { 
			%>	
				<br>(km/hr)
			<% //} %>
			</th> -->
			</tr>		
			<%
			String stoptime="2009-05-22 "+session.getAttribute("stoptime").toString();
			String starttime="2009-05-23 "+session.getAttribute("starttime").toString();
			sql="SELECT TIMESTAMPDIFF(MINUTE,'"+stoptime+"','"+starttime+"') as ss";
			//out.print(sql);
			ResultSet rststop=st.executeQuery(sql);
			if(rststop.next())
			{
				stopmimn=rststop.getInt("ss");
				
			}
			
			sql="select * from t_vehicledetails where VehicleRegNumber='"+vehicle+"'";
			ResultSet rst1=st.executeQuery(sql);
			if(rst1.next())
			{	
				
				sql="select distinct(TheDate) from t_veh"+rst1.getString("vehicleCode")+"_ds where TheDate >='"+date1+"' and TheDate <='"+date2+"' order by TheDate ";
				//out.print(sql);
				ResultSet rst0=st4.executeQuery(sql);
				int j=1;
				while(rst0.next())
				{
					runmin=0;
					ndrunmin=0;
					daystopmin=0;
					double kmtrav=0;
					double avgrunspeed=0, avgspeed=0;
					
					sql="select *,TIME_TO_SEC(RDuration)/60 as rd from t_veh"+rst1.getString("vehicleCode")+"_ds where TheDate ='"+rst0.getString("TheDate")+"' and (TIME_TO_SEC(RDuration)/60) < 1440 group by TheDate";
					//out.print(sql);
					ResultSet rstdayrun=st2.executeQuery(sql);
					if(rstdayrun.next())
					{
						runmin=rstdayrun.getInt("rd");
						kmtrav=rstdayrun.getInt("Distance");
						totkmtrav=totkmtrav+kmtrav;

						sql="select TIME_TO_SEC(Duration)/60 as ndduration, Distance from t_veh"+rst1.getString("vehicleCode")+"_nd where FromDate='"+rst0.getDate("TheDate")+"' group by FromDate";
						//out.print(sql);	
						ResultSet rstnightstop=st3.executeQuery(sql);
						if(rstnightstop.next())
						{
							ndrunmin=stopmimn-rstnightstop.getInt("ndduration");
						}
						else
						{
							ndrunmin=stopmimn;
						}
						daystopmin=1440-runmin-ndrunmin;
					}
					else
					{
						sql="SELECT TIMESTAMPDIFF(MINUTE,concat(FromDate,' ',FromTime),concat(Todate,' ',ToTime)) as ss from t_veh"+rst1.getString("vehicleCode")+"_stsp where FromDate='"+rst0.getDate("TheDate")+"'";
						ResultSet rststoptime=st2.executeQuery(sql);
						if(rststoptime.next())
						{
							daystopmin=rststoptime.getInt("ss");
						}
						sql="select TIME_TO_SEC(Duration)/60 as ndduration from t_veh"+rst1.getString("vehicleCode")+"_nd where FromDate='"+rst0.getDate("TheDate")+"'";
						ResultSet rstnightstop1=st2.executeQuery(sql);
						if(rstnightstop1.next())
						{
							ndrunmin=stopmimn-rstnightstop1.getInt("ndduration");
						}
						else
						{
							ndrunmin=stopmimn;
						}
						runmin=1440-daystopmin-ndrunmin;
					
					}
				
					int runsec=runmin*60;
					int ndrunsec=ndrunmin*60;
					int daystopsec=daystopmin*60;
		
					String rundur="", ndrundur="", daystopdur="";
					sql="select SEC_TO_TIME("+runsec+")";
					ResultSet rs5=st5.executeQuery(sql);
					if(rs5.next())	
					{
						rundur=rs5.getString(1);
					}
	
					sql="select SEC_TO_TIME("+ndrunsec+")";
					ResultSet rs6=st6.executeQuery(sql);
					if(rs6.next())	
					{
						ndrundur=rs6.getString(1);
					}

					sql="select SEC_TO_TIME("+daystopsec+")";
					ResultSet rs7=st7.executeQuery(sql);
					if(rs7.next())	
					{
						daystopdur=rs7.getString(1);
					}
				
				if(kmtrav>0 && runmin>0)
				{
					double c=(double)runmin/60;
				
					avgspeed=kmtrav/(24); //calculating avg speed
					avgrunspeed=(double)kmtrav/c;
				}
				
				NumberFormat nf = DecimalFormat.getNumberInstance();
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);	
				nf.setGroupingUsed(false);
		
				String avgrunspeedfrmtd=nf.format(avgrunspeed);
				String avgspeedfrmtd=nf.format(avgspeed);
				
				  
%>
					<tr>
					<td><%=j%></td>
					<td><a href="#" onClick="window.open('daydetails.jsp?vehid=<%=rst1.getString("vehicleCode")%>&ss1=<%=runmin%>&ss2=<%=ndrunmin%>&ss3=<%=daystopmin%>&vehreg=<%=vehicle%>&dd=<%=rst0.getString("TheDate")%>','win1','width=900,height=900,location=0,menubar=0,scrollbars=1,status=0,toolbar=0,resizable=0')"><%=new SimpleDateFormat(dateformat).format(rst0.getDate("TheDate"))%></a></td>
					<td><div align="right"><%=rundur%></div></td>
					<td><div align="right"><%=ndrundur%></div></td>
					<td><div align="right"><%=daystopdur%></div></td>
					<td><div align="right">
					<%
					if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
					{ %>
						<%= (int)fleetview.KM_TO_MILES1(kmtrav)%>
					<%}else{%>
						<%= kmtrav%>
					<% }%>
					</div></td>
					<td><div align="right"><%=avgrunspeedfrmtd%> </div></td>	
					<td><div align="right"><%=avgspeedfrmtd%></div></td>
					</tr>					
					<%
					j++;
					runtotal=(runtotal+runmin);
					stoptotal=(stoptotal+daystopmin);
					nighttotal=(nighttotal+ndrunmin);
	
/* ************************ Converting Total into seconds ******************************* */

					totruninsecs=runtotal*60;
					totnighttotal=nighttotal*60;
					totdaystoptotal=stoptotal*60;	
/*    ****************************************** */						

				} ;
/********************I have total in seconds. Below is formula to convert Running time that seconds into hours:minutes:seconds *************************************  */
				long totrunhours=totruninsecs/3600;
				long xtotrunhours=totruninsecs%3600;
				long totrunmins=xtotrunhours/60;
				long totrunsecs=xtotrunhours%60;
				
				String totrunhoursstr="", totrunsecsstr="", totrunminsstr="";

				if(totrunhours<10)
				{
					totrunhoursstr="0"+totrunhours;
				}
				else
				{
					totrunhoursstr=""+totrunhours;
				}

				if(totrunmins<10)
				{
					totrunminsstr="0"+totrunmins;
				}
				else
				{
					totrunminsstr=""+totrunmins;
				}		

				if(totrunsecs<10)
				{
					totrunsecsstr="0"+totrunsecs;
				}
				else
				{
					totrunsecsstr=""+totrunsecs;
				}
/**************************************************************************************  */


/********************Converting Night Stops time which is in seconds into hours:minutes:seconds *************************************  */
				long totnighthours=totnighttotal/3600;
				long xtotnighthours=totnighttotal%3600;
				long totnightmins=xtotnighthours/60;
				long totnightsecs=xtotnighthours%60;
				
				String totnighthoursstr="", totnightsecsstr="", totnightminsstr="";

				if(totnighthours<10)
				{
					totnighthoursstr="0"+totnighthours;
				}
				else
				{
					totnighthoursstr=""+totnighthours;
				}

				if(totnightmins<10)
				{
					totnightminsstr="0"+totnightmins;
				}
				else
				{
					totnightminsstr=""+totnightmins;
				}		

				if(totnightsecs<10)
				{
					totnightsecsstr="0"+totnightsecs;
				}
				else
				{
					totnightsecsstr=""+totnightsecs;
				}
/**************************************************************************************  */

/********************Converting Day Stops time which is in seconds into hours:minutes:seconds *************************************  */
				long totdaystopshours=totdaystoptotal/3600;
				long xtotdaystopshours=totdaystoptotal%3600;
				long totdaystopsmins=xtotdaystopshours/60;
				long totdaystopssecs=xtotdaystopshours%60;
				
				String totdaystopshoursstr="", totdaystopssecsstr="", totdaystopsminsstr="";

				if(totdaystopshours<10)
				{
					totdaystopshoursstr="0"+totdaystopshours;
				}
				else
				{
					totdaystopshoursstr=""+totdaystopshours;
				}

				if(totdaystopsmins<10)
				{
					totdaystopsminsstr="0"+totdaystopsmins;
				}
				else
				{
					totdaystopsminsstr=""+totdaystopsmins;
				}		

				if(totdaystopssecs<10)
				{
					totdaystopssecsstr="0"+totdaystopssecs;
				}
				else
				{
					totdaystopssecsstr=""+totdaystopssecs;
				}
/**************************************************************************************  */

/******************Calculating Average Running Speed of a Full Fleet****************  */

			if(totkmtrav>0 && runtotal>0)
			{
				double cc=(double)runtotal/60;

				avgspeedoffleet=totkmtrav/(24); //calculating avg speed of fleet
				avgrunspeedoffleet=(double)totkmtrav/cc;
			}

			NumberFormat nf1 = DecimalFormat.getNumberInstance();
			nf1.setMaximumFractionDigits(2);
			nf1.setMinimumFractionDigits(2);	
			nf1.setGroupingUsed(false);
		
			String avgrunspeedfleetfrmtd=nf1.format(avgrunspeedoffleet);
			String avgspeedfleetfrmtd=nf1.format(avgspeedoffleet);	
/**************************************************************************************  */

		%>
				<tr> 
				<th ><div align="right"><B>Tot<br>al :</B></div></th>
				<th ><div align="right"><b><%=j-1%> Days</b></div></th>
				<th ><div align="right"><b> <%=totrunhoursstr%>:<%=totrunminsstr%>:<%=totrunsecsstr%> </b></div></th>				
				<th ><div align="right"><b><%=totnighthoursstr%>:<%=totnightminsstr%>:<%=totnightsecsstr%></b></div></th>				
				<th ><div align="right"><b><%=totdaystopshoursstr%>:<%=totdaystopsminsstr%>:<%=totdaystopssecsstr%></b></div></th>				
				<th><div align="right">
				<%
				if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				{
				%>
				<b> <%= (int)fleetview.KM_TO_MILES1(totkmtrav)%> </b>
				<% }else{ %>
				<b> <%=totkmtrav%> </b>
				<%} %>	
				</div></th>				
				<th ><div align="right"><b><%=avgrunspeedfleetfrmtd%></b></div></td>				
				<th><div align="right"><b><%=avgspeedfleetfrmtd%></b></div></td>					
				</tr>	 	

				<tr class="sortbottom">
				<td colspan="8">
				
				<script type="text/javascript">
		   	  	// Load the Visualization API and the piechart package.
      			google.load('visualization', '1', {'packages':['piechart']});
            	// Set a callback to run when the API is loaded.
      			google.setOnLoadCallback(drawChart);
      	      // Callback that creates and populates a data table, 
      			// instantiates the pie chart, passes in the data and
      			// draws it.
      			function drawChart() {
        			var data = new google.visualization.DataTable();
        			data.addColumn('string', 'Task');
        			data.addColumn('number', 'Hours per Day');
        			data.addRows(3);
        			data.setValue(0, 0, 'Running Time In Min');
        			data.setValue(0, 1, <%=runtotal%>);
        			
        			data.setValue(1, 0, 'Day Stops In Min');
        			data.setValue(1, 1, <%=stoptotal%>);
				data.setValue(2, 0, 'Night Stop In Min');
        			data.setValue(2, 1, <%=nighttotal%>);
        			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        			chart.draw(data, {width: 700, height: 340, is3D: true, title: 'Time Statistics'});
      			}
    			</script>
				 <div id="chart_div" order="1"></div>
				</td>				
				</tr>
						
				<%
			}
			%>
			</table>
			</td><%
			}
			%>
			
			<!-- body part come here -->
				<%
				}catch(Exception e)
				{
					out.print("Exceptions--->"+e);
				}				
				finally
				{
					try{
						conn.close();
					}
					catch(Exception e)
					{}
					try{
						conn1.close();
					}
					catch(Exception e)
					{}
					try{
						fleetview.closeConnection();
					}
					catch(Exception e)
					{}
				}
				%>

			
	
			<!-- body part come here -->
				
			</td>
    <td class="fboxlowright">&nbsp;</td>
    
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
      <%@ include file="footernew.jsp" %>
    </body>
</html>
</jsp:useBean>
