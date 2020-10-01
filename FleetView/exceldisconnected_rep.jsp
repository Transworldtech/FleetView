<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>
<%@page import="com.transworld.fleetview.framework.DisconnectionReport"
	import="com.transworld.fleetview.framework.VehiclePositionsViewDataHelper"
	import="com.transworld.fleetview.framework.DisconnectionReportViewData"
	import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.Utilities"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
	import="java.text.*"
	import="java.util.List"%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>

<jsp:useBean id="disconnectionViewDataProvider"
	type="com.transworld.fleetview.framework.DisconnectionReportViewDataHelper"
	scope="application"></jsp:useBean>
	
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"exceldisconnected_rep.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
 %>
 
<%!String data1, data2, showdate, showdate1;
	int total = 0;
	String VehicleRegNo = "";%>


<%
	Connection conn1 = null;
	
	Statement st = null;
	try{
	String prevDayDate = null;
	String repDate = null;
	String ownerName = null;

	int distanceDifference = 0;

	conn1 = DriverManager.getConnection(MM_dbConn_STRING,
			MM_dbConn_USERNAME, MM_dbConn_PASSWORD);

	st = conn1.createStatement();
%>


<%
	String fromDate = "", toDate = "";

	String dd = request.getQueryString();
	if (dd == null) {
		

	} else {

		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MM-yyyy")
						.parse(request.getParameter("data")));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MM-yyyy")
						.parse(request.getParameter("data1")));

	} //end of else
	String user = session.getAttribute("usertypevalue").toString();
%>

<%
	if (!(null == request.getQueryString())) {
		String data = "", data1 = "", vehicleCode = "", vehicleRegistrationNumber = "",sumOfDist="",intripCount="";
		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(request.getParameter("data")));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(request.getParameter("data1")));
		System.out.println(fromDate +"======"+toDate);
%>
<table border="0" width="100%">
	<tr>
		<td colspan="5">
		<table border="0" width="100%">
			<tr>
				<th colspan="3" align="center"><font size="3">Fleet
				Disconnection Report for <%=user%> from <%=request.getParameter("data")%>
				to <%=request.getParameter("data1")%>. </font>
				<div align="right">Date : <%
 	Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 		String sdt = fmt.format(new java.util.Date());
 		out.print(sdt);
 		String fromtime, totime;
 %>
				</div>
				</th>
			</tr>
		</table>
		<table border="1" width="60%" class="sortable" align="center">
			<tr>
				<th>Sr.</th>
				<th>Transporter</th>
				<th>Vehicle</th>
				<th>Count</th>
				<th>Km. during disconn</th>

			</tr>
<%
				String unitId = "";
					String unitType = "";
					String dt1 = "", dt2 = "", chdt1 = "", chdt2 = "";
					boolean notify;
					String fromDateTime = fromDate + " " + "00:00:00";
					String toDateTime = toDate + " " + "23:59:59";
					System.out.println("user=" + user);
					int disconnectionCount = 0;
					String commaSeparatedVehicleList = session.getAttribute(
							"VehList").toString();
					System.out.println(fromDateTime +"-----"+toDateTime);
					String sql = "SELECT distinct(VehRegNo),Transporter,vehicleCode, count(*) as disconnectionCount, sum(Distance) as sumOfDistance FROM  db_gps.t_disconnectionData WHERE vehicleCode in "
							+ commaSeparatedVehicleList
							+ " and OffTimeTo>='"
							+ fromDateTime
							+ "' and OffTimeTo<='"
							+ toDateTime
							+ "'  and Duration >= '0:30'"
							+" and Reason = 'Disconnection' and ignoredstamp='No' group by VehRegNo";
					System.out.println("sql=" + sql);
					ResultSet rs1 = st.executeQuery(sql);
					int i = 0;

					while (rs1.next()) {
						i = i + 1;
						vehicleCode = rs1.getString("vehicleCode");
						vehicleRegistrationNumber = rs1.getString("VehRegNo");
						disconnectionCount = rs1.getInt("disconnectionCount");
						sumOfDist = rs1.getString("sumOfDistance");
%>
			<tr>
				<td style="text-align: right"><%=i%></td>
				<td style="text-align: left"><%=rs1.getString("Transporter")%></td>
				<td style="text-align: left"><%=vehicleRegistrationNumber%></td>
				<td style="text-align: right"><%=disconnectionCount%></td>
				<td style="text-align: right"><%=sumOfDist%></td>
			</tr>
<%
				}
%>
		</table>
		</td>
	</tr>
</table>
<%
	}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		st.close();
		conn1.close();
	}
%>
<%@ include file="footernew.jsp"%>
 