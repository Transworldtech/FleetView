<%@page import="java.sql.*" import="java.sql.DriverManager" import="java.sql.ResultSet" import="java.sql.Statement" %>
<%@ include file="headernew.jsp"%>
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
	Class.forName("org.gjt.mm.mysql.Driver");
	conn1 = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
	st =  conn1.createStatement();
	
	String VehicleRegNo = request.getParameter("VehicleRegNo");
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	String ownerName = request.getParameter("ownerName");

	SimpleDateFormat sd1 = new SimpleDateFormat("dd-MMM-yyyy");
	SimpleDateFormat sd2 = new SimpleDateFormat("dd-MMM-yyyy");
	
	String dtt1=sd2.format(sd1.parse(fromDate));
	String dtt2=sd2.format(sd1.parse(toDate));
//	out.println("------"+VehicleRegNo+"-----"+fromDate+"-----"+toDate+"------"+ownerName+"-------"+user+"------");
	%>
	<table border="0" width="100%">
	<th colspan="3" align="center"><font size="3">Fleet Disconnection Report for <%=user%> &nbsp;&nbsp;  Vehicle Registration No.: <%=VehicleRegNo%>&nbsp;&nbsp;Date: From:<%=dtt1%>&nbsp;To:<%=dtt2%>
	</table>
	<table class="sortable">
	<tr>	
		
			<td class="hed"><div class="bodyText"><b> Sr. </b></div></td>
			<td class="hed"><div class="bodyText" ><b>OFF Date-Time</b></div></td>
			<td class="hed"><div class="bodyText"><b>From Location</b></div></td>
			<td class="hed"><div class="bodyText" ><b>ON Date-Time</b></div></td>
			<td class="hed"><div class="bodyText"><b>To Location</b></div></td>
			<td class="hed"><div class="bodyText"><b></b>Distance</div></td>
			<td class="hed"><div class="bodyText" ><b>Duration (hh:mm)</b></div></td>
			<td class="hed"><div class="bodyText" ><b>Trip ID</b></div></td>
			</tr>	
<%
			int i=0;
			
			String fromDate1="",toDate1="";
			String f1=dtt1+" "+"00:00:00";
			String f2=dtt2+" "+"23:59:59";
	//		out.println("---------"+f1+"-----------------"+f2+"--------------");
			
			String sql12="select * from t_disConData where VehRegNo='"+VehicleRegNo+"' and OffTimeTo>='"+f1+"' and OffTimeTo<='"+f2+"'";
	//		out.println(sql12);
			ResultSet rsSql=st.executeQuery(sql12);
			while(rsSql.next())
			{
				i++;
				fromDate1 = rsSql.getString("OffTimeFrom");
				String frmLoc=rsSql.getString("FromLocation");
				double frmLat=rsSql.getDouble("FromLatitude");
				double frmLng=rsSql.getDouble("FromLongitude");
				toDate1 =rsSql.getString("OffTimeTo");
				String toLoc=rsSql.getString("ToLocation");
				double toLat=rsSql.getDouble("ToLatitude");
				double toLng=rsSql.getDouble("ToLongitude");
				String dist=rsSql.getString("Distance");
				String duration=rsSql.getString("Duration");
				int c1=duration.length();
				String u2="";
				if(duration.charAt(c1-2)==':')
				{
					u2=duration.replace(":",":0");
				}
				else
				{
					u2=duration;
				}
				String trp=rsSql.getString("TripId");
				String u1=trp.replace("-", "");
				String trpid=u1.replace(",","");
		//		out.println("-"+i+"--"+VehicleRegNo+"-----"+frmLoc+"----"+toLoc+"----"+dist+"-----"+duration+"------"+trpid+"-----");
%>

				<tr>
						<td style="text-align: right"><%=i%></td>
						<td style="text-align: right"><%=fromDate1%></td>
						<td style="text-align: right"><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=frmLat%>&long=<%=frmLng%>&discription=<%=frmLoc%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=frmLoc%> </a></td>
						<td style="text-align: right"><%=toDate1%></td>
						<td style="text-align: right"><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=toLat%>&long=<%=toLng%>&discription=<%=toLoc%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=toLoc%> </a></td>
						<td style="text-align: right"><%=dist%></td>
						<td style="text-align: right"><%=u2%></td>
						<td style="text-align: right"><%=trpid%></td>
						
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