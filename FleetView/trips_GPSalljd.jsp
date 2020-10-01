<%@ include file="headernew.jsp"%>
<form name="dateform" action="" method="post">
<table border="0" width="100%" class="stats">
<!-- <tr><td><font color="block" size="3" >Report No: 10.1</font></td></tr>--></table>
<table border="0" width="100%" class="sortable_entry">
	<tr align="center">
		<td><B>Trip categorization By : </b><select name="sortby"
			style="">
						<option value="totaltrips" selected="selected">Total Trips</option>
			
			<option value="trans" >Transporterwise</option>
			<option value="location">Start Locationwise</option>
			<option value="driver">Driverwise</option>
		</select> <input type="submit" name="submit" id="submit" value="submit"></td>
	</tr>
</table>
</form>

<%!Connection conn;
	Statement st, st1;
	String sql, sql1;
	String fromdate, todate, triptype, data1, data2;

	NumberFormat nf = DecimalFormat.getNumberInstance();%>

<%
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);

	fromdate = request.getParameter("fromdate");
	todate = request.getParameter("todate");
	//System.out.println(fromdate);
	//System.out.println(todate);

	data1 = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new SimpleDateFormat("yyyy-MM-dd").parse(request
					.getParameter("fromdate")));
	data2 = new SimpleDateFormat("dd-MMM-yyyy")
			.format(new SimpleDateFormat("yyyy-MM-dd").parse(request
					.getParameter("todate")));
	// System.out.println(data1);
	//  System.out.println(data2);

	String sortby = "totaltrips";
	if (!(null == request.getParameter("sortby"))) {
		sortby = triptype = request.getParameter("sortby");
		try {
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
			st = conn.createStatement();
			st1 = conn.createStatement();

		} catch (Exception e) {
			e.printStackTrace();
		}
%>

<%
	if ("trans".equalsIgnoreCase(sortby)) {
			try {
%>
<table border="0" width="60%">
	<tr align="center">
		<td><br>
		<font size="2" color="blue"><b>Transporter-wise All JDData With GPS
		Trips From <%=data1%> to <%=data2%></b></font>
		<div align="right"><br>
 
		<table border="1" width="100%" class="sortable">
			<tr>
				<th>Sr.</th>
				<th>Transporter</th>
				<th>Number of Trips</th>

			</tr>
			<%
				String tripid, owner;
							int i = 1, totalTrips = 0;
			%>
			<%
				sql = "Select distinct(Ownername),count(TripID) as TripID from t_alljddata where StartDate BETWEEN '"
									+ fromdate
									+ "' and '"
									+ todate
									+ "' and Status <>'NotProcessed' group by ownername order by ownername Asc";
							ResultSet rst = st.executeQuery(sql);
							while (rst.next()) {
								tripid = rst.getString("TripID");
								totalTrips += rst.getInt("TripID");
								owner = rst.getString("OwnerName");
			%>
			<tr>
				<td>
				<div align="left"><%=i%></div>
				</td>
				<td>
				<div align="left"><%=owner%></div>
				</td>
				<td align="right">
				<div align="right"><a
					href="trips_alljdLevel2.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&pageType=TransporterWise&ownerName=<%=owner%>"><%=tripid%></a></div>
				</td>

			</tr>
			<%
				i++;
							}
			%>
			<tr>
				<td colspan="2">Total:</td>
				<td>
				<div align="right"><%=totalTrips%></div>
				</td>
			</tr>
		</table>
		<%
			} catch (Exception e) {
						e.printStackTrace();
					} finally {
						conn.close();
					}
				}

				else if ("location".equalsIgnoreCase(sortby)) {

					try {
		%>
		<table border="0" width="60%">
			<tr align="center">
				<td><br>
					<font size="2" color="blue"><b>LocationWwise All JDData With GPS Trips
				From <%=data1%> to <%=data2%></b></font>
				<div align="right"><br>
 
				<table border="1" width="60%" class="sortable">
					<tr>
						<th>Sr.</th>
						<th>Start Place</th>
						<th>Number of Trips</th>
					</tr>
					<%
						String tripid, vehregno, stplace, endplace, stdate, drivernm, driverid, owner, category;
									int i = 1, totaltrips = 0;
					%>
					<%
						sql = "Select distinct(StartPlace),count(TripID) as TripID from t_alljddata where StartDate BETWEEN '"
											+ fromdate
											+ "' and '"
											+ todate
											+ "' and Status <>'NotProcessed' group by StartPlace order by StartPlace Asc";

									ResultSet rst = st.executeQuery(sql);
									while (rst.next()) {
										tripid = rst.getString("TripID");
										totaltrips = rst.getInt("TripID");
										stplace = rst.getString("StartPlace");
					%>
					<tr>
						<td>
						<div align="left"><%=i%></div>
						</td>
						<td>
						<div align="left"><%=stplace%></div>
						</td>
						<td align="right">
						<div align="right"><a
							href="trips_alljdLevel2.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&pageType=LocationWise&location=<%=stplace%>"><%=tripid%></a></div>
						</td>


						<%
							i++;
										}
						%>
						<tr>
							<td colspan="2">Total:</td>
							<td>
							<div align="right"><%=totaltrips%></div>
							</td>
						</tr>
				</table>
				<%
					} catch (Exception e) {
								e.printStackTrace();
							} finally {
								conn.close();
							}

						}

						else if ("driver".equalsIgnoreCase(sortby)) {

							try {
				%>
				<table border="0" width="60%">
					<tr align="center">
						<td><br>
							<font size="2" color="blue"><b>All JDData With GPS Trips From <%=data1%>
						to <%=data2%></b></font>
						<div align="right"><br>
 
						<table border="1" width="60%" class="sortable">
							<tr>
								<th>Sr.</th>
								<th>Driver ID</th>
								<th>Driver Name</th>
								<th>Number Of trips</th>
							</tr>
							<%
								String tripid, vehregno, stplace, endplace, stdate, drivernm, driverid, owner, category;
											int i = 1, totaltrips = 0;
							%>
							<%
								sql = "Select distinct(DriverCode),count(TripID) as TripiD,DriverName from t_alljddata where StartDate BETWEEN '"
													+ fromdate
													+ "' and '"
													+ todate
													+ "' and Status <>'NotProcessed' group by DriverCode order by DriverName Asc";

											ResultSet rst = st.executeQuery(sql);
											while (rst.next()) {
												tripid = rst.getString("TripID");
												driverid = rst.getString("DriverCode");
												drivernm = rst.getString("DriverName");
												totaltrips += rst.getInt("TripID");
							%>
							<tr>
								<td><%=i%></td>
								<td>
								<div align="left"><%=driverid%></div>
								</td>
								<td>
								<div align="left"><%=drivernm%></div>
								</td>
								<td align="right">
								<div align="right"><a
									href="trips_alljdLevel2.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&pageType=DriverWise&driverCode=<%=driverid%>"><%=tripid%></a></div>
								</td>

							</tr>

							<%
								i++;
											}
							%>
							<tr>
								<td colspan="3">Total:</td>
								<td>
								<div align="right"><%=totaltrips%></div>
								</td>
							</tr>
						</table>
						<%
							} catch (Exception e) {
										e.printStackTrace();
									} finally {
										conn.close();
									}

								}

								else {

									try {
						%>
						<table border="0" width="100%">
							
							<tr align="center">
								<td>	<font size="2" color="blue"><b>All JDData With GPS Trips
								From <%=data1%> to <%=data2%></b></font>
 
								<table border="1" width="100%" class="sortable">
									<tr>
										<th>Sr.</th>
										<th>Trip ID</th>
										<th>Vehicle</th>
										<th>Start Place</th>
										<th>Start Date</th>
										<th>End Place</th>
										<th>Driver ID</th>
										<th>Driver Name</th>
										<th>Transporter</th>
										<th>Category</th>
									</tr>
									<%
										String tripid, vehregno, stplace, endplace, stdate, drivernm, driverid, owner, category;
													int i = 1;
									%>
									<%
										sql = "Select TripID,VehRegNo,StartPlace,EndPlace,StartDate,DriverName,DriverCode,OwnerName,Category from t_alljddata where StartDate BETWEEN '"
															+ fromdate
															+ "' and '"
															+ todate
															+ "' and Status <>'NotProcessed' group by TripId order by StartDate Asc";

													ResultSet rst = st.executeQuery(sql);
													while (rst.next()) {
														tripid = rst.getString("TripID");
														vehregno = rst.getString("VehRegNo");
														stplace = rst.getString("StartPlace");
														stdate = rst.getString("StartDate");
														endplace = rst.getString("EndPlace");
														driverid = rst.getString("DriverCode");
														drivernm = rst.getString("DriverName");
														owner = rst.getString("OwnerName");
														category = rst.getString("Category");
									%>

									<td><%=i%></td>
									<td><%=tripid%></td>
									<td><%=vehregno%></td>
									<td><%=stplace%></td>
									<td><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd").parse(rst
													.getString("StartDate")))%></td>
									<td><%=endplace%></td>
									<td><%=driverid%></td>
									<td><%=drivernm%></td>
									<td><%=owner%></td>
									<td>
									<div align="right">
									<%
										if (category.equals("Primary")) {
															out.print("Primary");
														} else if ((category.equals("BPL") || (category
																.equals("Tanker")))) {
															out.print("Tanker");
														} else {
															out.print("Secondary");
														}
									%>
									</div>
									</td>
									</tr>
									<%
										i++;
													}
									%>
								</table>
								<%
									} catch (Exception e) {
												e.printStackTrace();
											} finally {
												conn.close();
											}

										}

									}
								%>
								</div>
								</td>
							</tr>
						</table>
						<%@ include file="footernew.jsp"%>