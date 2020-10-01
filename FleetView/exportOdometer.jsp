 <%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
    response.addHeader("Content-Disposition", "attachment;filename=\"odometer.xls\"");
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<%!Connection conn, conn1;
	Statement st0, st, st1, st2, st3, st4, st11;%>
<%
	String user, sql = "", sql1 = null, sql2 = null, sql3 = null, transporter = null, ndcnt = null;
	String fidDate = null, data1 = null, data2 = null, showdate = null, showdate1 = null, trips = null, counDriveYesNo = null, ntDriveYesNo = null;
	String ownerNm = "", DriverName = "";
	double Accelaration1 = 0.00, Decelaration1 = 0.00, OverSpeed1 = 0.00;
	int odofirst = 0, odolast = 0, Odometer = 0;
	double gpsfirst = 0,gpslast = 0;
	String odoLastDateTime="",odoFirstDateTime="";
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);

	String StartDate = "", EndDate = "", EndTime = "", StartTime = "", fromdate = "", todate = "", thedate = "", thedate1 = "";
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
<table border="1" width="100%" bgcolor="white">
	<tr>
		<td align="center" class="sorttable_nosort">
		<div align="left"><font color="block" size="3">Report No:
		5.5</font></div>
		<font color="block" size="3"><b>Monthly Odometer Report</b></font></td>
	</tr>
	
			<tr>
				<td colspan="5">
				<%
					
						data1 = request.getParameter("data");
						data2 = request.getParameter("data1");

						user = session.getAttribute("usertypevaluemain").toString();
						final String typeOfUser = session.getAttribute("TypeofUser")
								.toString();
					//	System.out.println(typeOfUser);
				%>
				<table class="stats">
					<th colspan="13"><font size="3">Odometer Report for <%=user%>
					transporters from <%
						java.util.Date ShowDate = new SimpleDateFormat("dd-MMM-yyyy")
									.parse(data1);
							Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
							showdate = formatter2.format(ShowDate);
							out.print(showdate);
					%> to <%
						java.util.Date ShowDate1 = new SimpleDateFormat("dd-MMM-yyyy")
									.parse(data2);
							Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
							showdate1 = formatter1.format(ShowDate1);
							out.print(showdate1);
					%>. </font>
					&nbsp;&nbsp;&nbsp;Date	: <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 		String sdt = fmt.format(new java.util.Date());
 		out.print(sdt);
 %>
					</div>
					</th>
					</tr>
					<tr>

						<!--<td class="hed"><div class="bodyText"><b>Driver</b></div></td>-->
						<td class="hed">
						<div class="bodyText"><b>Sr No.</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Customer</b></div>
						</td>
						<td class="hed">
						<div class="bodyText"><b>Employee(EmployeeCode)</b></div>
						</td>

						<td class="hed">
						<div class="bodyText"><b>Vehicle</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Odo From</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Odo To</b></div>
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
						<div class="bodyText"><b>Total GPS Km</b></div>
						</td>
						
						<td class="hed">
						<div class="bodyText"><b>Difference</b></div>
						</td>
						
					</tr>
					<%
						int i = 1;
					int count=0;
							String vehregno = "";
							String trans = "";
							String sql11 = "";
							String employeeName="";
							String employeeCode="";
							String vehicleCode="";
							try {

								Class.forName(MM_dbConn_DRIVER);
								conn = DriverManager.getConnection(MM_dbConn_STRING,
										MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
								conn1 = fleetview.ReturnConnection1();
								st = conn.createStatement();
								st0 = conn.createStatement();
								st11 = conn.createStatement();
								st1 = conn.createStatement();
								int ododiff = 0;
								double gpsdiff =0,totaldistanceBetweenSelectedDates=0;
								boolean flagFirst=true;
								boolean flag=true;
								
								if ("GROUP".equalsIgnoreCase(typeOfUser)) {
									sql11 = "select * from t_group where GPName='"
											+ session.getAttribute("usertypevalue")
													.toString() + "'";

								}

								else {
									sql11 = "select * from db_gps.t_vehicledetails where OwnerName='"
											+ session.getAttribute("usertypevalue")
													.toString() + "'";
									//System.out.println(sql);
									//ResultSet rst=st0.executeQuery(sql);
									//
								}
						//		System.out.println("Query11---->" + sql11);
								ResultSet rst11 = st11.executeQuery(sql11);
								while (rst11.next()) {
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
									ododiff = 0;
									gpsdiff = 0;
									odofirst = 0;
									gpsfirst = 0;
									odolast = 0;
									gpslast = 0;
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
										System.out.println("veh===> "+rstlast.getString("VehNo")+"   count====>"+count);
										// totalCount=totalCount+count;
									}
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime from t_fuelinfo where VehNo='"
											+ vehregno
											+ "' and TheDateTime  >= '"+ fromdate+ " 00:00:00' and '"+ todate+ " 23:59:59' AND Odometer IS NOT NULL AND Odometer <> '' AND Odometer <> ' ' AND Odometer <> '-' order by thedatetime ASC LIMIT 1";
									//System.out.println("Query---->" + sql);
									ResultSet rst = st0.executeQuery(sql);
									if(rst.next()){
										odofirst = rst.getInt("Odometer");
										odoFirstDateTime=rst.getString("TheDateTime");
										//System.out.println("odoFirstDateTime=" + odoFirstDateTime+"----odofirst"+odofirst);
										flagFirst=false;
										
										
										String sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+odoFirstDateTime+"' AND '"+odoLastDateTime+"' " +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"LIMIT 1";
										//System.out.println("first rec gps==>"+sqlGps);
										ResultSet rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpsfirst = rstgps1.getDouble("Distance");
										}
									}
									/*******************************************************/
									sql = "select Transporter,Driver,VehNo,Odometer,TheDateTime from t_fuelinfo where VehNo='"
										+ vehregno
										+ "' and TheDateTime  >= '"+ fromdate+ " 00:00:00' and TheDateTime  <= '"+ todate+ " 23:59:59' AND Odometer IS NOT NULL AND Odometer <> ''   AND Odometer <> ' ' AND Odometer <> '-' order by thedatetime DESC LIMIT 1";
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
										"LIMIT 1";
										//System.out.println("first rec gps==>"+sqlGps);
										ResultSet rstgps1=st1.executeQuery(sqlGps);
										if(rstgps1.next())
										{
											gpsfirst = rstgps1.getDouble("Distance");
										}
										
										sqlGps="SELECT Distance, TheFieldDataDate, TheFieldDataTime " +
										"FROM t_veh"+vehicleCode+" " +
										"WHERE TheFieldDataDateTime BETWEEN '"+odoFirstDateTime+"' AND  '"+odoLastDateTime+"'" +
										"AND TheFiledTextFileName in ('SI','ON','OF') " +
										"ORDER BY TheFieldDataDateTime " +
										"DESC LIMIT 1";
										//System.out.println("first rec gps==>"+sqlGps);
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
					%>
					<tr>

						<td class="bodyText">
						<div align="right"><%=i++%></div>
						</td>
						<td class="bodyText" width="">
						<div align="left"><%=trans%></div>
						</td>
						<td class="bodyText" width="">
						<div align="left"><%=employeeName%></div>
						</td>
						<td class="bodyText">
						<div align="left"><%=vehregno%></div>
						</td>
						<%if("".equalsIgnoreCase(odoFirstDateTime)){ odoFirstDateTime="-";} else{}%>
						<td class="bodyText">
						<div align="left"><%=odoFirstDateTime%></div>
						</td>
						<%if("".equalsIgnoreCase(odoLastDateTime)){ odoLastDateTime="-";} else{}%>
						<td class="bodyText">
						<div align="left"><%=odoLastDateTime%></div>
						</td>
						<%						if(count!=0)
						{ 
%>
						<td class="bodyText">
						<div align="right"><%=count%></a></div>
						</td>
						<%}
						else{ 
%>
						<td class="bodyText"><div align="right"><%=count%></div></td>
<%
						} 
%>
<%
				if(ododiff!=0){
%>
						<td class="bodyText">
						<div align="right"><%=ododiff%></a></div>
						</td>
<%
				}
				else{
%>
					<td class="bodyText">
						<div align="right"><%=ododiff%></div>
						</td>
<%
				}
%>
						<td class="bodyText">
						<div align="right"><%=Double.valueOf(gpsdiff).intValue()%></div>
						</td>
						<td class="bodyText">
						<div align="right"><%=Double.valueOf(totaldistanceBetweenSelectedDates).intValue()%></div>
						</td>
						
						<td class="bodyText">
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
					</tr>
					
					
					<%
						}//group

								/*	if(rst.last())
									{
										odolast=rst.getDouble("Odometer");
										System.out.println("odolast-"+odolast);
									}	//i++;*/

							} catch (Exception e) {
								System.out.println("Exception-->" + e);
							}
							finally{
								try{
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
						
					%>
					</td>
					</tr>
					</form>
				</table>
				<!-- footer start here -->
				<table border="1" width="100%">
					<tr>
						<td bgcolor="white" class="copyright" width="100%">
						<center>Copyright &copy; 2008 by Transworld Compressor
						Technologies Ltd. All Rights Reserved.</center>
						</td>
					</tr>
				</table>
				<P></P>
				</body>
				</html>