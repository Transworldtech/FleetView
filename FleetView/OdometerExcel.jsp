<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"SecondaryAutoTrips_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>


<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%!Connection conn, conn1;
	Statement st0, st, st1, st2, st3, st4, st11,stlast,st5,st6,st7,stRSM,stRSM1,stRSM2;%>
<%
String uservalue=session.getAttribute("usertypevalue").toString();
	String user, sql = "",first="",fulltank="No",last="", sql1 = null, sql2 = null, sql3 = null, transporter = null, ndcnt = null;
	String fidDate = null, data1 = null, data2 = null, showdate = null, showdate1 = null, trips = null, counDriveYesNo = null, ntDriveYesNo = null;
	String ownerNm = "", DriverName = "";
	double Accelaration1 = 0.00, Decelaration1 = 0.00, OverSpeed1 = 0.00;
	int odofirst = 0, odolast = 0, Odometer = 0;
	double gpsfirst = 0,gpslast = 0,gpsavg=0;
	double gpsfirst1 = 0,gpslast1 = 0,gpsdiff1=0;
	String odoLastDateTime="",odoFirstDateTime="";

	float totalfuel=0,odoavg=0;

	String StartDate = "", EndDate = "", EndTime = "", StartTime = "", fromdate = "", todate = "", thedate = "", thedate1 = "",showhide="";
	String fromdate1 = "", todate1 = "";
	if (!(null == request.getParameter("data"))) {
		fromdate1 = request.getParameter("data");
		fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(fromdate1));
		todate1 = request.getParameter("data1");
		todate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(todate1));
		//out.print(fromdate);
	} else {
		fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new java.util.Date());
		todate = fromdate;
		fromdate1 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
		todate1 = fromdate1;
		//out.print(todate);
	}
%>
			
				<%
						showhide = request.getParameter("newvalue");
						System.out.println(showhide);
						 
						String dd = request.getQueryString();
					
						data1 = request.getParameter("data");
						data2 = request.getParameter("data1");

						user = session.getAttribute("usertypevaluemain").toString();
						final String typeOfUser = session.getAttribute("TypeofUser")
								.toString();
						//System.out.println(typeOfUser);
				%>
				
				<form id="MonthlyOdometerReport" name="MonthlyOdometerReport" action="" method="post" >
			    <div id="table1">				
					<table width="100%" border="1" align="center" class="sortable">
					<tr>

						<!--<td class="hed"><div class="bodyText"><b>Driver</b></div></td>-->
						<td class="hed">
						<div class="bodyText"><b>Sr No.</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Vehicle</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>User</b></div>
						</td>
                        <td class="hed">
						<div class="bodyText"><b>Transporter</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>RSM Name</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Odo Count</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Odo Km.</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>GPS Km</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Difference</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Fuel Added</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Total GPS Km</b></div>
						</td>
						<%
							if(showhide.equalsIgnoreCase("Hide Avg")) {
						
						%>
						
						<td class="hed" id="1">
						<div class="bodyText"><b>Full tank >1</b></div>
						</td>
						<td class="hed" id="2">
						<div class="bodyText"><b>Odo Avg</b></div>
						</td>
						<td class="hed" id="3">
						<div class="bodyText"><b>gps Avg</b></div>
						</td>
						<td class="hed" id="4">
						<div class="bodyText"><b>Manager</b></div>
						</td>
						<%}else{}%>
						 
						
						
					</tr>
					<%System.out.println("hiiiiihihihi---->");
						int i = 1;
					int count=0;
					int totalCount=0;
							String vehregno = "";
							String trans = "";
							String sql11 = "";
							String employeeName="";
							String employeeCode="";
							String vehicleCode="";
							String totalfuel1="",RSMName="-",Manager="-";
							DecimalFormat df = new DecimalFormat("#.##");
							NumberFormat nf = NumberFormat.getNumberInstance();
							nf.setMaximumFractionDigits(2) ;
							try {

								Class.forName(MM_dbConn_DRIVER);
								conn = DriverManager.getConnection(MM_dbConn_STRING,
										MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
								
								conn1 = fleetview.ReturnConnection1();

								st = conn.createStatement();
								st0 = conn.createStatement();
								st11 = conn.createStatement();
								st1 = conn.createStatement();
								st4 = conn.createStatement();
								st5 = conn.createStatement();
								st6 = conn.createStatement();
								st7 = conn.createStatement();
								stRSM = conn.createStatement();
								stRSM1 = conn.createStatement();
								stRSM2 = conn.createStatement();
								int ododiff = 0;
								double gpsdiff =0,totaldistanceBetweenSelectedDates=0;
								boolean flagFirst=true;
								boolean flag=true;
								System.out.println("hiiiiihihihi---->11112");
								if ("GROUP".equalsIgnoreCase(typeOfUser)) {
									sql11 = "select DISTINCT transporter,VehCode,VehRegNo from t_group where GPName='"
											+ session.getAttribute("usertypevalue")
													.toString() + "'";

								}

								else {
									sql11 = "select DISTINCT VehicleRegNumber,VehicleCode from db_gps.t_vehicledetails where OwnerName='"
											+ session.getAttribute("usertypevalue")
													.toString() + "'";
							
								}
								System.out.println("hiiiiihihihi----query>"+sql11);
								ResultSet rst11 = st11.executeQuery(sql11);
								while (rst11.next()) {
									System.out.println("hiiiiihihihi---->332");
									if ("GROUP".equalsIgnoreCase(typeOfUser)) {
										trans = rst11.getString("VehRegNo");
										vehregno = rst11.getString("transporter");
										System.out.println(trans+"--"+vehregno);
										vehicleCode = rst11.getString("VehCode");
									} else {
										vehregno = rst11.getString("VehicleRegNumber");
										trans = session.getAttribute("usertypevalue").toString();
										vehicleCode = rst11.getString("VehicleCode");
									}
									totalfuel=0;
									ododiff = 0;
									gpsdiff = 0;
									gpsdiff1 = 0;
									odofirst = 0;
									gpsfirst = 0;
									gpsfirst1 = 0;
									odolast = 0;
									gpslast = 0;
									gpslast1 = 0;
									odoavg=0;
									gpsavg=0;
									totalfuel1="";
									odoFirstDateTime="";
									odoLastDateTime="";
									employeeName="";
									employeeCode="";
									flagFirst=true;
									flag=true;
									count=0;
									totaldistanceBetweenSelectedDates=0;
									String query="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
									ResultSet rs=st.executeQuery(query);
									if(rs.next()){
										employeeName=rs.getString("Empname");
										//employeeCode=rs.getString("Empcode");
									}
									
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime,count(*) AS entries from t_fuelinfo where VehNo='"
										+ vehregno
										+ "' and TheDateTime  between '"
										+ fromdate
										+ " 00:00:00' and '"
										+ todate
										+ " 23:59:59' order by thedatetime";
									ResultSet rstlast = st.executeQuery(sql);
									if(rstlast.next()){
										count = rstlast.getInt("entries");
										totalCount=totalCount+count;
									}
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime from t_fuelinfo where VehNo='"
											+ vehregno
											+ "' and TheDateTime  >= '"+ fromdate+ " 00:00:00' and '"+ todate+ " 23:59:59' AND Odometer IS NOT NULL AND Odometer <> '' AND Odometer <> ' '  AND Odometer <> '-' order by thedatetime ASC LIMIT 1";
									//System.out.println("Query---->" + sql);
									ResultSet rst = st0.executeQuery(sql);
									if(rst.next()){
										odofirst = rst.getInt("Odometer");
										odoFirstDateTime=rst.getString("TheDateTime");
										//System.out.println("odoFirstDateTime=" + odoFirstDateTime+"----odofirst"+odofirst);
										flagFirst=false;
									}
									/*******************************************************/
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime from t_fuelinfo where VehNo='"
										+ vehregno
										+ "' and TheDateTime  >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59' AND Odometer IS NOT NULL AND Odometer <> ''   AND Odometer <> ' ' AND Odometer <> '-'  order by thedatetime DESC LIMIT 1";
									ResultSet rst1 = st0.executeQuery(sql);
								
									if(rst1.next()){
										odolast = rst1.getInt("Odometer");
										odoLastDateTime=rst1.getString("TheDateTime");
										//System.out.println("odoLastDateTime=" + odoLastDateTime+"----odolast"+odolast);
										flagFirst=false;
										
										String sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+odoFirstDateTime+"' AND '"+odoLastDateTime+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"ASC LIMIT 1";
										System.out.println("first rec gps==>"+sqlGps);
										ResultSet rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpsfirst = rstgps1.getDouble("Distance");
										}
										
										sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+odoFirstDateTime+"' AND '"+odoLastDateTime+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"DESC LIMIT 1";
										System.out.println("last rec gps==>"+sqlGps);
										rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpslast = rstgps1.getDouble("Distance");
										}
									}
									
									ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(vehicleCode,fromdate,todate);
									if(rstcounts.next())
									{
										totaldistanceBetweenSelectedDates = rstcounts.getDouble(5);
									}
									
			////////////////////////////////////////////////////////////////////////////////////////////////////						
									if(count>1){
									ododiff = odolast - odofirst;
									gpsdiff = gpslast - gpsfirst;
									}
									else{
										ododiff =0;
										gpsdiff=0;
									}
									//System.out.println("diff===>" + ododiff);
									if(ododiff==0){
										gpsdiff=0;
									}
									System.out.println("\n\n The vehicle code is:"+vehicleCode);
									String eny="select FirstName,LastName from db_gps.t_userdetails where HODID <>'-' AND SrNo=(select HODID from db_gps.t_userdetails where HODID <>'-' AND SrNo=(select HODID from db_gps.t_userdetails where HODID <>'-' AND Vehid='"+vehicleCode+"' limit 1))";									
									ResultSet rste=st1.executeQuery(eny);
									System.out.println("\n\n username query-->>"+eny);
									if(rste.next())
									{
										System.out.println("\n\n in if");
										String First=rste.getString("FirstName");
										String Last=rste.getString("LastName");
										String FullName = First+" "+Last;
										RSMName=FullName;
										System.out.println("\n\n name of Hod's HOD id-->>"+FullName);
										
										
										
									}else
										{
										RSMName="-";
										}
									
							//***********************************************for manager		
									String eny1="select FirstName,LastName from db_gps.t_userdetails where HODID <>'-' AND SrNo=(select HODID from db_gps.t_userdetails where HODID <>'-' AND Vehid='"+vehicleCode+"' limit 1)";									
									ResultSet rste1=st1.executeQuery(eny1);
									System.out.println("\n\n username query1-->>"+eny1);
									if(rste1.next())
									{
										System.out.println("\n\n in if2");
										String First=rste1.getString("FirstName");
										String Last=rste1.getString("LastName");
										String FullName = First+" "+Last;
										Manager=FullName;
										System.out.println("\n\n name of manager-->>"+Manager);
										
										
										
									}else
										{
										Manager="-";
										System.out.println("The name of manager is :"+Manager);
										}
									
									
									
			//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++						
									
									String fuelInfoQuery="SELECT Litres FROM db_gps.t_fuelinfo WHERE vehno='"+vehregno+"' and" +
									"   TheDateTime >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59'" +
									"	ORDER BY Thedatetime desc";
									System.out.println("\n\n fuel query-->>"+fuelInfoQuery);
									ResultSet rstfuel=st1.executeQuery(fuelInfoQuery);
									while(rstfuel.next())
									{
										String fueltot=rstfuel.getString("Litres");
										if(fueltot.equals(""))
										{}else
										{
										totalfuel=totalfuel+Float.parseFloat(fueltot);
									    System.out.println("total fuel decimal-->>"+totalfuel);
										totalfuel1=nf.format(totalfuel);
										System.out.println("after total fuel decimal-->>"+totalfuel1);

										
										
										}
								
									}
									
									// for full tank logic
									
									int fullcount=0;
									int fullcounta=0;
									float lastfuel=0,prvfuel=0,lastOdo=0,prvOdo=0,infuel=0;
									float lastfuel1=0,prvfuel1=0,lastOdo1=0,prvOdo1=0;
									float finalfuel=0,finalOdo=0;
									fulltank="No";
									String lastfull="",lastodo="",prvfull="",prvodo="",timefrom="",timeto="",infuelstr="";
									
									System.out.println("\n\n full count-->>"+fullcount);
									String fulltankquery="select *  from db_gps.t_fuelinfo where vehno='"+vehregno+"' and FullTank='Yes' AND TheDateTime >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59' order by TheDateTime desc";
									System.out.println("\n\n full count query-->>"+fulltankquery);
									ResultSet fullrs=st5.executeQuery(fulltankquery);
								    if(fullrs.next())
									{
										fullcount++;
										lastfull=fullrs.getString("Litres");
										lastodo=fullrs.getString("Odometer");
										timefrom=fullrs.getString("TheDateTime");
										if(timefrom==null || timefrom.equals("") || timefrom.equals(" "))
										{
											timefrom=todate+" 23:59:59";
										}
										
										if(lastfull.equals(""))
										{}else
											{										
											lastfuel=Float.parseFloat(lastfull);
											}
										 if(lastodo.equals("") || lastodo.equals("-"))
										{}else
											{										
											lastOdo=Float.parseFloat(lastodo);
											}
							
										
										
									
										System.out.println("last liters-->>"+lastfull);
										System.out.println("last Odo-->>"+lastodo);
									}
									while(fullrs.next())
									{
										fullcount++;
										prvfull=fullrs.getString("Litres");
										prvodo=fullrs.getString("Odometer");
									//	System.out.println("prv liters-->>"+fullrs.getString("Litres"));
									//	System.out.println("prv Odo-->>"+fullrs.getString("Odometer"));
							            timeto=fullrs.getString("TheDateTime");
							            if(timeto==null || timeto.equals("") || timeto.equals(" "))
										{
							            	timeto=fromdate+" 00:00:00";
										}
							            if(prvfull.equals(""))
										{}else
											{										
										        prvfuel=Float.parseFloat(prvfull);
											}
										 if(prvodo.equals(""))
										{}else
											{										
												prvOdo=Float.parseFloat(prvodo);
											}
							
									
										System.out.println("prv liters-->>"+prvfull);
										System.out.println("prv Odo-->>"+prvodo);
							
									
										
									}
									if(fullcount==1)
									{
									   String fulltankquery1="select * from db_gps.t_fuelinfo where vehno='"+vehregno+"' and FullTank='Yes' AND TheDateTime < '"+ fromdate+ " 00:00:00' order by TheDateTime desc";
									   System.out.println("\n\n full count query back-->>"+fulltankquery1);
									   ResultSet fullrs1=st6.executeQuery(fulltankquery1);
									   try
										{
									   if(fullrs1.next())
									   {
										fullcounta++;
										
										prvfull=fullrs1.getString("Litres");
										prvodo=fullrs1.getString("Odometer");
										 timeto=fullrs1.getString("TheDateTime");
											System.out.println("prv liters-->>"+fullrs1.getString("Litres"));
											System.out.println("prv Odo-->>"+prvodo);
										
										 if(prvfull=="" || (prvfull== null) || prvfull==" " || prvfull.equals("") || prvfull.equals("null") || prvfull.equals(" "))
										{}else 
											{	
											System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$->>"+prvfull);
											System.out.print("<<->>"+prvfull);
										        prvfuel=Float.parseFloat(prvfull);
											}
										 if(prvodo.equals(""))
										{}else
											{										
												prvOdo=Float.parseFloat(prvodo);
											}
							
										   
										
									
									
										
									   }
									   else
									   {
										   fullcounta=0;
									   }
										}
										catch(Exception e)
										{
											e.printStackTrace();
										}
									 }
									   
								
									
									
									System.out.println("\n\n full count-->>"+fullcount);
									System.out.println("\n\n full count back-->>"+fullcounta);
									if(fullcount>1 || fullcounta>0)
									{
										fulltank="Yes";
									// now calculate fuel consume....
									 String infuelquery="select * from db_gps.t_fuelinfo where vehno='"+vehregno+"'  AND TheDateTime > '"+timeto+"' and TheDateTime  < '"+timefrom+"' order by TheDateTime desc";
									 System.out.println("in No full query-->>"+infuelquery);
									 ResultSet infl=st7.executeQuery(infuelquery);	
										while(infl.next())
										{
											
											infuelstr=infl.getString("Litres");
											if(infuelstr.equals(""))
											{}else
																	
											   infuel=infuel+Float.parseFloat(infuelstr);
											
										}
										
										prvfuel=prvfuel+infuel;
										
										  finalfuel=prvfuel;
									
										
										  finalOdo=lastOdo-prvOdo;
										
										System.out.println("\n\n fuel consume-->>"+finalfuel);
										System.out.println("\n\n odometer count -->>"+finalOdo);
									
										
										// calculate gps km ..
										
										
										String sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+timeto+"' AND '"+timefrom+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"ASC LIMIT 1";
										System.out.println("first rec gps query==>"+sqlGps);
										ResultSet rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpsfirst1 = rstgps1.getDouble("Distance");
										}
										
										sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+timeto+"' AND '"+timefrom+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"DESC LIMIT 1";
										System.out.println("last rec gps query==>"+sqlGps);
										rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpslast1 = rstgps1.getDouble("Distance");
										}
										
										if(gpslast1>gpsfirst1)
										{
											gpsdiff1=gpslast1-gpsfirst1;
											System.out.println("gps in if diff==>"+gpsdiff1);
										}
										else
										{
											gpsdiff1=gpsfirst1-gpslast1;
											System.out.println("gps diff in else==>"+gpsdiff1);
										}
										
										if(finalfuel>0)
										{
											odoavg=(finalOdo/finalfuel);
											gpsavg=(gpsdiff1/finalfuel);
											System.out.println("avg odo==>"+odoavg);
											System.out.println("gps avg==>"+gpsavg);
										}
										
										
									}
									
									
									
					%>
					<tr>

						<td class="bodyText" align="right">
						<div align="right"><%=i++%></div>
						</td>
						<td class="bodyText" align="left">
						<div align="left"><%=vehregno%></div>
						</td>
						
						<td class="bodyText" align="left">
						<div align="left"><%=employeeName%></div>
						</td>
						<td class="bodyText" align="left">
						<div align="left"><%=trans%></div>
						</td>
						<td class="bodyText" align="left">
						<div align="left"><%=RSMName%></div>
						</td>
						<%						if(count!=0)
						{ 
%>
						<td class="bodyText" align="right">
					<!--  	<div align="right"><a href="odometerEntries.jsp?vehcode=<%=vehicleCode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&ownername=<%=trans%>&vehregnumber=<%=vehregno%>&employeeName=<%=employeeName%>"><%=count%></a></div>
						-->
						<div align="right"><a
							href="detail_odomter_transporter.jsp?data1=<%=fromdate%>&data2=<%=todate%>&Oname=<%=trans%>&odometer=<%=ododiff%>&vehregno=<%=vehregno%>&vehicleCode=<%=vehicleCode%>&employeeName=<%=employeeName%>"><%=count%></a></div>
					
						</td>
						<%}
						else{ 
%>
						<td class="bodyText" align="right"><div align="right"><%=count%></div></td>
<%
						} 
%>
<%
				if(ododiff!=0){
%>
						<td class="bodyText" align="right">
						<div align="right"><a
							href="detail_odomter_transporter.jsp?data1=<%=fromdate%>&data2=<%=todate%>&Oname=<%=trans%>&odometer=<%=ododiff%>&vehregno=<%=vehregno%>&vehicleCode=<%=vehicleCode%>&employeeName=<%=employeeName%>"><%=ododiff%></a></div>
						</td>
<%
				}
				else{
%>
					<td class="bodyText" align="right">
						<div align="right"><%=ododiff%></div>
						</td>
<%
				}
%>
						<td class="bodyText" align="right">
						<div align="right"><%=Double.valueOf(gpsdiff).intValue()%></div>
						</td>
						<td class="bodyText" align="right">
						<%
						int odomdiff=ododiff;
						int gps1diff = Double.valueOf(gpsdiff).intValue();
						int diff=0;
						diff= odomdiff - gps1diff;
						String diffstr= "";
						diffstr = ""+diff;
						if(diffstr.startsWith("-")){
							diffstr = diffstr.replace("-","");
						}
						%>
						<div align="right"><%=diffstr%></div>
						</td>
						<%						if(totalfuel!=0)
						{ //custfuelfillreport.jsp?vehicleRegistrationNumber=MH+11+Y+5465&data=03-Jan-2012&data1=03-Feb-2012&submit=submit
                          String datefrom=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
                          String dateto=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
%>
						<td class="bodyText" align="right">
						<div align="right"><a href="custfuelfillreport.jsp?vehicleRegistrationNumber=<%=vehregno%>&data=<%=datefrom%>&data1=<%=dateto%>"><%=totalfuel1%></a></div>
						</td>
						<%}
						else{ 
%>
						<td class="bodyText" align="right"><div align="right">0.00</div></td>
<%
						} 
%>
						
						<td class="bodyText" align="right">
						<div align="right"><%=Double.valueOf(totaldistanceBetweenSelectedDates).intValue()%></div>
						</td>
						
						<input type ="hidden" name="fullcount" id ="fullcount<%=i-1 %>" value="<%=fullcount%>"></input>
					<input type ="hidden" name="fullcounta" id ="fullcounta<%=i-1 %>" value="<%=fullcounta%>"></input>
						
						<%
						
						if(showhide.equalsIgnoreCase("Hide Avg")) {
					
					
						
						
						if(fullcount>1 || fullcounta>0)
						{
							String odoavgdis="",gpsavgdis="";
							
							odoavgdis=df.format(odoavg);
							gpsavgdis=df.format(gpsavg);
						
						%><%System.out.println("tda is :"+(i-1)); %>
						<td class="bodyText" id="tda<%=i-1%>" align="right">
						<div align ="right"></div><a href="fuelfulltankreport.jsp?vehcode=<%=vehicleCode%>&fromdate=<%=timeto%>&todate=<%=timefrom%>&ownername=<%=trans%>&vehregnumber=<%=vehregno%>&firstodo=<%=prvOdo%>&lastodo=<%=lastOdo%>&firstgps=<%=gpsfirst1%>&lastgps=<%=gpslast1%>&firstfuel=<%=prvfuel%>&lastfuel=<%=lastfuel%>&betweenfuel=<%=infuel%>&finalgps=<%=gpsdiff1%>&finalfuel=<%=finalfuel%>&finalodo=<%=finalOdo%>&odoavg=<%=odoavg%>&gpsavg=<%=gpsavg%>"><%=fulltank%></a>
						
						</td>
						<td class="bodyText" id="tdb<%=i-1%>" align="right">
						<div align="right"><%=odoavgdis%></div>
						</td>
						<td class="bodyText" id="tdc<%=i-1%>" align="right">
						<div align="right"><%=gpsavgdis%></div>
						</td>
						<%}
						else
						{%>
						<%System.out.println("tdp is :"+(i-1)); %>
						<td class="bodyText" id="tdp<%=i-1%>" align="left">
						<div align="left"><%=fulltank%></div>
						</td>
						<td class="bodyText" id="tdq<%=i-1%>" align="left">
						<div align="left">NA</div>
						</td>
						<td class="bodyText" id="tdr<%=i-1%>" align="left">
						<div align="left">NA</div>
						</td>						
						<%} %>
						
						
						<td class="bodyText" id="manager<%=i-1%>" align="left">
						<div align="left"><%=Manager%></div>
						
						<%}else{} %>
						
					</tr>
					
					
					<%
					System.out.println("fullcount is :"+fullcount);
					System.out.println("fullcounta is :"+fullcounta);
						} //end of rst while

								//group

	                    
							} catch (Exception e) {
								System.out.println("Exception-->" + e);
							}
							finally{
								try{
									st.close();
									st0.close();
									st1.close();
									st11.close();
									conn.close();
								}
								catch(Exception e){
									e.printStackTrace();
								}
								try{
									conn1.close();
								}
								catch(Exception ee){
									ee.printStackTrace();
								}
							}
							%>	<input type="hidden" name= "cnt" id="cnt" value=<%=i-1%>></input>	<%
							System.out.println("i is "+(i-1));
							%>
							</table>
				</div>
				</form>			
				
			
				
				
				
				
				
				
