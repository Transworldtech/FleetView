<%@ page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=session.getAttribute("usertypevalue").toString()+showdatex+"exceldisconnected_rep.xls";
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
 %>
<%@include file="Connections/conn.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
	try{
		
	String user = session.getAttribute("usertypevalue").toString();
	Connection conn1 = null;
	Statement st = null;
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	st =  conn1.createStatement();
	
	String vehicleCode = request.getParameter("vehicleCode");
	String VehicleRegNo = request.getParameter("VehicleRegNo");
	String fromDateTime = request.getParameter("fromDateTime");
	String toDateTime = request.getParameter("toDateTime");
	String ownerName = request.getParameter("ownerName");

	SimpleDateFormat sd1 = new SimpleDateFormat("dd-MMM-yyyy");
	SimpleDateFormat sd2 = new SimpleDateFormat("dd-MMM-yyyy");
	%>
<table border="0" width="100%">
	<tr>
		<th colspan="3" align="center"><font size="3">Fleet
		Disconnection Report for <%=user%> &nbsp;&nbsp; Vehicle Registration
		No.: <%=VehicleRegNo%>&nbsp;&nbsp; From:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime))%>&nbsp;To:<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime))%></font></th>
	</tr>
</table>
<table class="sortable">
	<tr>

		<td class="hed">
		<div class="bodyText"><b> Sr. </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> Transporter </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b> VehicleRegNumber </b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>OFF Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>From Location</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>ON Date-Time</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>To Location</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Distance</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Duration (hh:mm)</b></div>
		</td>
		<td class="hed">
		<div class="bodyText"><b>Trip ID</b></div>
		</td>
	</tr>
	<%
			int i=0;
			String fromDate1="",toDate1="";
			String fromLocation="",toLocation="",distance="",duration="",tripid="";
			double fromLatitude=0.00,toLatitude=0.00,fromLongitude=0.00,toLongitude=0.00;

			String sql12="SELECT * FROM db_gps.t_disconnectionData WHERE vehicleCode= '"+vehicleCode+"' AND VehRegNo='"+VehicleRegNo+"' AND OffTimeTo>='"+fromDateTime+"' and OffTimeTo<='"+toDateTime+"' and Duration >= '0:30'";
			ResultSet rsSql=st.executeQuery(sql12);
			while(rsSql.next())
			{
				i++;
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
				tripid = rsSql.getString("TripId");
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
		<td style="text-align: right"><%=i%></td>
		<td style="text-align: left"><%=ownerName%></td>
		<td style="text-align: left"><%=VehicleRegNo%></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDate1))%></td>
		<td style="text-align: right"><%=fromLocation%></td>
		<td style="text-align: right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDate1))%></td>
		<td style="text-align: right"><%=toLocation%></td>
		<td style="text-align: right"><%=distance%></td>
		<td style="text-align: right"><%=disconnectDuration%></td>
		<td style="text-align: right"><%=tripid%></td>

	</tr>
<%		   }
			st.close();
			conn1.close();
	}
catch(Exception e)
{
	out.println("Exception---->"+e);
}
			
%>
</table>
<%@ include file="footernew.jsp"%>
</body>
</html>