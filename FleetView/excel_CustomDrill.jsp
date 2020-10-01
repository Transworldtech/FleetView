<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_CustomReport.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn,conn1;
Statement st,st1,st2,st12,st4,st5;
ResultSet rst;
String vid,sql,sql1,sql2, transporter, vehregno, thedate1, thedate2, showdate,dateformat;
%>
<%
try
{
	dateformat = session.getAttribute("dateformat").toString();
	vid=request.getParameter("vid");
	java.util.Date NewDate= new java.util.Date();
	long dateMillis= NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate2=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	dayInMillis = 14000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn1.createStatement();
	st2=conn1.createStatement();
	st4=conn1.createStatement();
	st5=conn1.createStatement();
	st12=conn1.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+vid+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");		
		transporter=rst.getString("OwnerName");
		
	}
	String datat=request.getParameter("datat");
	String datat1=request.getParameter("datat1");
	int discounter=0;
    if(request.getParameter("counterv")!=null)
    {
	  String str=request.getParameter("counterv");
	  //System.out.println("\n\n\nstr---->>>>>-->>"+str);
      discounter=Integer.parseInt(str);
      //System.out.println("\n\n\n---->>>>>-->>"+discounter);
    }
%>
<table width="100%" align="center" >
			<tr>
			<td align="center">
			<div align="left"><font size="3" >Report No: 1.9</font></div>
			</tr>
			<tr>
			<td>
			<div align="center"><font  size="3"><b>Exception Report For <%=transporter%>, Vehicle <%=vehregno%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat))%> 00:00:00 to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat1))%> 23:59:59 </b></font></div>
				<div align="right">
				<%=fleetview.PrintDate()%>
				</div>
			</td>
			</tr>
			</table>
			<table border="0" align="center" width="100%">
			<tr><td align="center"><font size="3"><b>Over Speed</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>From-Date-Time</b></th>
			<th> <b>Speed</b></th>
			<th> <b>Duration in Sec.</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>	
			<%
			/*thedate1 = "2007-01-01";
			thedate2="2007-09-31";
			vid = "125";*/
			ResultSet rst1=fleetview.retunOverSpeed(vid,datat,datat1);
			int i=1;
			while(rst1.next())
			{
			%>	
				<tr>
			<td> <%=i %></td>
			<td><%=new SimpleDateFormat(dateformat).format(rst1.getDate("FromDate"))+" "+rst1.getString("FromTime") %></td>
			<td><div align="right"><%=rst1.getString("Speed")%></div></td>
			<td><div align="right"><%=rst1.getString("Duration")%></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst1.getString("FromDate"),rst1.getString("FromTime")) %></div></td>
			</tr>
			<%
			i++;
			}
			%>	
			</table>
			
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Rapid Acceleration</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Date-Time</b></th>
			<th> <b>From Speed</b></th>
			<th> <b>To Speed</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>		
			<%
			ResultSet rst2=fleetview.retunRA(vid,datat,datat1);
			int j=1;
			while(rst2.next())
			{
			%>
				<tr>
			<td> <%=j %></td>
			<td> <%=new SimpleDateFormat(dateformat).format(rst2.getDate("TheDate"))+" "+rst2.getString("TheTime") %></td>
			<td><div align="right"><%=rst2.getString("FromSpeed") %></div> </td>
			<td><div align="right"><%=rst2.getString("ToSpeed") %></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst2.getString("TheDate"),rst2.getString("TheTime")) %></div></td>
			</tr>	
			<%
			j++;
			}
			%>
			</table>
			
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Rapid Deceleration</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Date-Time</b></th>
			<th> <b>From Speed</b></th>
			<th> <b>To Speed</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>		
				<%
			ResultSet rst3=fleetview.retunRD(vid,datat,datat1);
			int k=1;
			while(rst3.next())
			{
			%>
				<tr>
			<td> <%=k %></td>
			<td> <%=new SimpleDateFormat(dateformat).format(rst3.getDate("TheDate"))+" "+rst3.getString("TheTime") %></td>
			<td><div align="right"><%=rst3.getString("FromSpeed") %></div> </td>
			<td><div align="right"><%=rst3.getString("ToSpeed") %></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst3.getString("TheDate"),rst3.getString("TheTime")) %></div></td>
			</tr>	
			<%
			k++;
			}
			%>
			</table>
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Stops</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Start Date-Time</b></th>
			<th> <b>End Date-Time</b></th>
			<th> <b>Duration</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>	
			
			<%				
		List<ContinuousDrivingDetailsData> data3 = null;
		int numRecords3 = 0;
		try {
			data3 = vehicleDao.getContinuousDrivingDetailsData(
					vid, datat+" 00:00:00", datat1+" 23:59:59", "Stops");
			numRecords3 = data3.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		for (int counter = 0; counter < numRecords3; counter++) {
			final ContinuousDrivingDetailsData currentRecord3 = data3
					.get(counter);
		
		%>
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getStartDate()))%> <%=currentRecord3.getStartTime()%></div>
				</td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord3
															.getEndDate()))%> <%=currentRecord3.getEndTime()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord3.getDuration()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord3.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord3
											.getStartLocation())
									&& null != currentRecord3.getStartLocationLatitude()) {
						String lat1=currentRecord3.getStartLocationLatitude();
						String lon1=currentRecord3.getStartLocationLongitude();
						String disc=currentRecord3.getStartLocation();
%>							 

						<%=disc%>  								 
<%
					} else if (null != currentRecord3.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord3
											.getStartLocation())) {
								out.println(currentRecord3.getStartLocation());
							}
				%>
				</div>
				</td>
			</tr>
			<%		
		}
		%>
		</table>
			</td>
			</tr>
				<tr>
		<td align="center"><font size="3"><b>Night Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
				<th><b>Trip ID</b></th>
				<th><b>Reason</b></th>
				
			</tr>
			<%
		    List<ContinuousDrivingDetailsData> data4 = null;
			int numRecords4 = 0;
			try {
				data4 = vehicleDao.getContinuousDrivingDetailsData(
						vid, datat+" 00:00:00", datat1+" 23:59:59", "NightDriving");
				numRecords4 = data4.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords4; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord4 = data4
				.get(counter);
%>
			
<%
String sd=currentRecord4.getStartDate();
String st=currentRecord4.getStartTime();


String ed=currentRecord4.getEndDate();
String et=currentRecord4.getEndTime();
%>					
			
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord4
															.getStartDate())) %> <%=currentRecord4.getStartTime()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord4.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getStartLocation())
									&& null != currentRecord4.getStartLocationLatitude()) {
						String lat1=currentRecord4.getStartLocationLatitude();
						String lon1=currentRecord4.getStartLocationLongitude();
						String disc=currentRecord4.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord4.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getStartLocation())) {
								out.println(currentRecord4.getStartLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord4
															.getEndDate())) %> <%=currentRecord4.getEndTime()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord4.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getEndLocation())
									&& null != currentRecord4.getEndLocationLatitude()) {
						String lat1=currentRecord4.getEndLocationLatitude();
						String lon1=currentRecord4.getEndLocationLongitude();
						String disc=currentRecord4.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord4.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord4
											.getEndLocation())) {
								out.println(currentRecord4.getEndLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="right"><%=currentRecord4.getDistancetravelled()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord4.getDuration()%></div>
				</td>
			
			<%
				String TripID="";
				String tripid="select JCode from db_gpsExceptions.t_veh"+vid+"_nd where concat(FromDate,' ',FromTime) between '"+currentRecord4.getStartDate()+" "+currentRecord4.getStartTime()+"' and  '"+currentRecord4.getEndDate()+" "+currentRecord4.getEndTime()+"'";
				ResultSet rs=st4.executeQuery(tripid);
				if(rs.next())
				{
					TripID=rs.getString("JCode");
					System.out.println("------------"+TripID);
				}
				
				%>
				
				<td>
				<div align="left"><%=TripID%></div> 
			   </td>
			
			
			<td>
			<%
			String reason="";
			    try{
			   String sqlreason="select reason from db_gpsExceptions.t_ndpostintimation where VehRegNo='"+vehregno+"' and NdStartDateTime='"+sd+" "+st+"' and NdEndDateTime='"+ed+" "+et+"'";
			   ResultSet rsreason=st5.executeQuery(sqlreason);
			   if(rsreason.next())
			   {
				   reason=rsreason.getString("reason");
				   
			   }
			    }catch(Exception e)
			    {
			    	System.out.println(">>>>>>>>e:"+e);
			    }
			
			if(reason.equals("-") || reason.equals(""))
			{
				%>
			<%="<a href=\"veh_report_ndfeedback.jsp?vehregno="+vehregno+"&vid="+vid+"&tripid="+TripID+"&startdatetime="+sd+" "+st+"&enddatetime="+ed+" "+et+"\"onclick=\"popWin=window.open('veh_report_ndfeedback.jsp?vehregno="+vehregno+"&vid="+vid+"&tripid="+TripID+"&startdatetime="+sd+" "+st+"&enddatetime="+ed+" "+et+"','ND Reason','width=400,height=350');popWin.focus();return false\">Add Reason</a>"%>
			<%
			}
			else
			{
				if(reason.length()>10)
				{
					%>
					<%="<a href=\"veh_showreason.jsp?reason="+reason+"\"onclick=\"popWin=window.open('veh_showreason.jsp?reason="+reason+"','ND Reason','width=400,height=300');popWin.focus();return false\">Show Reason</a>"%>
				<%}
				else
				{
				%>
				<%=reason %>
			<%}} %>  
			</td>
					
			</tr>
			<%
			}
		    %>
		</table>
		</td>
	</tr>
	
	
	
	<tr>
		<td align="center"><font size="3"><b>Continuous
		Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
			</tr>
			<%
		    List<ContinuousDrivingDetailsData> data5 = null;
			int numRecords5 = 0;
			try {
				data5 = vehicleDao.getContinuousDrivingDetailsData(
						vid, datat+" 00:00:00", datat1+" 23:59:59", "ContinuousDriving");
				numRecords5 = data5.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords5; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord5 = data5
				.get(counter);
%>
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getStartDate())) %> <%=currentRecord5.getStartTime()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())
									&& null != currentRecord5.getStartLocationLatitude()) {
						String lat1=currentRecord5.getStartLocationLatitude();
						String lon1=currentRecord5.getStartLocationLongitude();
						String disc=currentRecord5.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())) {
								out.println(currentRecord5.getStartLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getEndDate())) %> <%=currentRecord5.getEndTime()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())
									&& null != currentRecord5.getEndLocationLatitude()) {
						String lat1=currentRecord5.getEndLocationLatitude();
						String lon1=currentRecord5.getEndLocationLongitude();
						String disc=currentRecord5.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())) {
								out.println(currentRecord5.getEndLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="right"><%=currentRecord5.getDistancetravelled()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord5.getDuration()%></div>
				</td>
			</tr>
			<%
			}
		    %>
		    
		</table>
		</td>
	</tr>
	<tr><td align="center"><font size="3"><b>Disconnection</b></font></td></tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>

		<th>Sr.</th>
	    <th>OFF Date-Time</th>
	    <th>From Location</th>
		<th>ON Date-Time</th>
		<th>To Location</th>
		<th>Distance</th>
		<th>Duration (hh:mm)</th>
		<th>Trip ID</th>
		
	</tr>
		   <%
			int v=0;
			String fromDate1="",toDate1="";
			String fromLocation="",toLocation="",distance="",duration="",tripid="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;
            
			String sql12="SELECT * FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vid+"' AND  OffTimeFrom>='"+datat+" 00:00:00' and OffTimeFrom<='"+datat1+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		//	String sql12="Select * from db_gps.t_disconnectionData where vehicleCode='"+vehicleCode+"' AND  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeTo >='"+data1+" 00:00:00'";
			
	        System.out.println("\n\n-->>sqlllllllll----....>>>>"+sql12);		
	        ResultSet rsSql=st12.executeQuery(sql12);
			
			while(rsSql.next())
			{System.out.println("\n\n\nvishal rst--->>>"+rsSql);
				//System.out.println("\n\n\nvishal rst--->>>"+rsSql.next());
				v++;
				fromDate1 = rsSql.getString("OffTimeFrom");
				fromLocation = rsSql.getString("FromLocation");
				fromLatitude = rsSql.getDouble("FromLatitude");
				fromLongitude = rsSql.getDouble("FromLongitude");
				toDate1 = rsSql.getString("OffTimeTo");
				toLocation = rsSql.getString("ToLocation");
				toLatitude = rsSql.getDouble("ToLatitude");
				toLongitude = rsSql.getDouble("ToLongitude");
				distance = rsSql.getString("Distance");
				duration = rsSql.getString("Duration");
				if(discounter>0)
				{	
					String tripidv = request.getParameter("tripid");			
					tripid=tripidv;	
				}
				else
				{
				  tripid = rsSql.getString("TripId");
				}
				int length=duration.length();
				String disconnectDuration="";
				if(duration.charAt(length-2)==':') //if duration is 1:6 then display as 1:06
				{
					disconnectDuration=duration.replace(":",":0");
				}
				else
				{
					disconnectDuration=duration;
				}
				
%>

	<tr>
		<td style="text-align: right"><%=v%></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1))%></td>
		<td style="text-align: right"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=fromLatitude%>&long=<%=fromLongitude%>&discription=<%=fromLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=fromLocation%>
		</a></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1))%></td>
		<td style="text-align: right"><a href="javascript: flase;"
			onClick="window.open ('shownewmap.jsp?lat=<%=toLatitude%>&long=<%=toLongitude%>&discription=<%=toLocation%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=toLocation%>
		</a></td>
		<td style="text-align: right"><%=distance%></td>
		<td style="text-align: right"><%=disconnectDuration%></td>
		<td style="text-align: right"><%=tripid%></td>

	</tr>
<%		   }
			%>

</table>
</td>
</tr>
</table>
			<%
			
}catch(Exception e)
{
	out.print("Exception--->"+e);
}finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{}
	try
	{
		conn1.close();	
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection1();	
	}catch(Exception e)
	{}
	
}
			%>
<% //fleetview.closeConnection(); %>
<% //fleetview.closeConnection1(); %>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>
