<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("usertypevalue").toString()+showdatex+"Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@include file="Connections/conn.jsp" %>
<%!
	Connection conn, conn1;
	Statement st, st1, st2, st3, st11, stt1, stt2, st12, st13, st14, st15;
	String fromdate, todate, sql, sql1, transporter, datenew1, datenew2,fromdatetime, todatetime, loctype;
	String LocationType;
%>
<%
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,
			MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,
			MM_dbConn_USERNAME, MM_dbConn_PASSWORD);

	//conn = fleetview.ReturnConnection();
	//conn1 = fleetview.ReturnConnection1();
	st = conn.createStatement();
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn1.createStatement();
	st11 = conn.createStatement();
	stt1 = conn.createStatement(); //  *********************************
	stt2 = conn.createStatement();
	st12 = conn.createStatement();
	st13 = conn.createStatement();
	st14 = conn.createStatement();
	st15 = conn.createStatement();
	if (!(null == request.getQueryString())) {
		fromdate = request.getParameter("data1");
		todate = request.getParameter("data2");
		transporter = request.getParameter("transporter");
		//datenew1 = request.getParameter("data1");
		//datenew2 = request.getParameter("data2");
		LocationType=request.getParameter("LocationType");
	} else {
		datenew1 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
		datenew2 = datenew1;

	}
%>
<form name="locationwisestop" action="" method="get"
	onsubmit="return validate();">
<table border="0" width="100%" align="center">
	<tr>
		<td align="center"><font size="2"><B>Location Wise
		Stoppage Report</B></font></td>
	</tr>
	<tr>
		<td>
	
		<%
		String sqlstop = "";
		try {
			
			if (LocationType.equals("All")) {
				sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
						+ "	count(distinct( tripid) ) AS Trips, concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
						+ "	FROM t_RoundTripStop WHERE LocationType in('Customer','Plant','Toll Naka') and fromdate >= '"
						+ fromdate
						+ " 00:00:00' AND todate <= '"
						+ todate
						+ " 23:59:59' and Transporter='"+session.getAttribute("usertypevalue").toString()+"'group by Location order by Location asc";
			}
			if (LocationType.equals("Customer")) {
				sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
						+ "	count(distinct( tripid) ) AS Trips, concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
						+ "	FROM t_RoundTripStop WHERE LocationType='Customer' and fromdate >= '"
						+ fromdate
						+ " 00:00:00' AND todate <= '"
						+ todate
						+ " 23:59:59' and Transporter='"+session.getAttribute("usertypevalue").toString()+"'  group by Location order by Location asc";
			}

			 if (LocationType.equals("Plant")) {
				sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
						+ "	count(distinct( tripid) ) AS Trips,concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
						+ "	FROM t_RoundTripStop WHERE LocationType='Plant' and fromdate >= '"
						+ fromdate
						+ " 00:00:00' AND todate <= '"
						+ todate
						+ " 23:59:59' and Transporter='"+session.getAttribute("usertypevalue").toString()+"' group by Location order by Location asc";
			}if (LocationType.equals("Tollnaka")) {
				sqlstop = "SELECT min( duration ) AS Min, max( duration ) AS Max, "
						+ "	count(distinct( tripid) ) AS Trips, concat('', SEC_TO_TIME( SUM( TIME_TO_SEC( duration ) ) / count( * ) )) AS Avg,Location,LocationType  "
						+ "	FROM t_RoundTripStop WHERE LocationType='Toll Naka' and fromdate >= '"
						+ fromdate
						+ " 00:00:00' AND todate <= '"
						+ todate
						+ " 23:59:59'  and Transporter='"+session.getAttribute("usertypevalue").toString()+"'group by Location order by Location asc";
			}
					int i = 0;
					System.out.println("Query---->" + sqlstop);
					ResultSet rststop = st.executeQuery(sqlstop);
					%>
					<table border="0" width="100%" align="center">
					<tr><td align="center">
					<font  size="3"><B>
					Report for <%=LocationType %> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
					</font>
					</td>
					</tr>
					</table>
					<table border="1" class="sortable" width="100%">
					<tr>
					
					<th>Sr.No</th>
					<th>Location</th>
					<th>No of Trips</th>
					<th>Min Time</th>
					<th>Max Time</th>
					<th>Average Time</th>
					</tr>
					
					<%
					
					while (rststop.next()) {
						i++;
				%>

			<tr>
				<td><%=i%></td>

	
				<td><%=rststop.getString("Location")%></td>

				<td align="right"><%=rststop.getString("Trips")%></td>

				<td align="right"><%=rststop.getString("Min")%></td>

				<td align="right"><%=rststop.getString("Max")%></td>

				<td align="right"><%=rststop.getString("Avg")%></td>
			
	<%
		}
%>
</tr>
	</table>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

	</td>
	</tr>
	</form>
</table>
<%@ include file="footernew.jsp"%>