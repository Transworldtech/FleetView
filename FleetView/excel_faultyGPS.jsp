
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"FaultyGPS_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn,conn1;
Statement st,st1;
String sql,sql1;
String triptype,data1,data2;
String fromdate, todate,datenew1,datenew2;

NumberFormat nf = DecimalFormat.getNumberInstance();



%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
String thename;

datenew1=request.getParameter("fromdate");
datenew2=request.getParameter("todate");
triptype=request.getParameter("triptype");
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
	
try{
	   Class.forName(MM_dbConn_DRIVER);
	   conn=DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	   st=conn.createStatement();
		st1=conn.createStatement();
		
}
catch(Exception e)
{
	   e.printStackTrace();
}
		
%>
	
	<%
		try{
			%>
			
<table border="0" width="100%" align="center" class="stats">
			<tr><td colspan="7">
			<font size="2"><b>Report for Trips With Faulty AVL from <%=datenew1%> to <%=datenew2%></b></font>
			</td>
			</tr>
			</table>
		<table border="1" width="100%" class="stats">
		<tr>
			<th > Sr.</th>
			<th > Trip ID</th>
			<th> Vehicle</th>
			<th>Transporter</th>
			<th> Start Place</th>
			<th > TripDate</th>
			<th> End Place</th>
			
			
			
			</tr>	
	<%
		String tripid,vehregno,startplace1,endplace,startdate,enddate,OwnerName;
		int i=1;
	%>
	<%
	if(triptype.equalsIgnoreCase("started"))
	{
		//sql="Select distinct(TripID),VehNo,SPlace,EPlace,TripDate,Transporter from t_avlfaulty_trips where TripDate BETWEEN '"+fromdate+"' and '"+todate+"'";
		sql="select TripID,Vehid,StartPlace,vehregno,EndPlace,TripStartDate,TripEndDate,Transporter from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status='Faulty'";
		//System.out.println(sql);
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			tripid=rst.getString("TripID");
			vehregno=rst.getString("vehregno");
			startplace1=rst.getString("StartPlace");
			startdate=rst.getString("TripStartDate");
			
			endplace=rst.getString("EndPlace");
			OwnerName=rst.getString("Transporter");
			
			
			%>	
			<tr>
			<td><%=i%></td>
			<td><%=tripid%></td>
			<td><%=vehregno%></td>
			<td><%=OwnerName%></td>
			<td><%=startplace1%></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate))%></td>
			<td><%=endplace%></td>
			
			
			</tr>
	<%	
	i++;
		}
		
	}
	else if(triptype.equalsIgnoreCase("ended"))
	{/*
		//sql="Select distinct(TripID),VehNo,SPlace,EPlace,TripDate,Transporter from t_avlfaulty_trips where TripDate BETWEEN '"+fromdate+"' and '"+todate+"'";
		sql="select TripID,Vehid,StartPlace,vehregno,EndPlace,TripStartDate,TripEndDate,Transporter from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status='Faulty'";
		//ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			tripid=rst.getString("TripID");
			vehregno=rst.getString("vehregno");
			startplace1=rst.getString("StartPlace");
			startdate=rst.getString("TripStartDate");
			enddate=rst.getString("TripEndDate");
			endplace=rst.getString("EndPlace");
			OwnerName=rst.getString("Transporter");*/
			
			
			%>	
		<!-- 	<tr>
			<td>< %=i%></td>
			<td>< %=tripid%></td>
			<td>< % =vehregno%></td>
			<td>< %=startplace1%></td>
			<td>< %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate))%></td>
			<td>< %=endplace%></td>
			<td><  %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate))%></td>
			<td>< %=OwnerName%></td>
			</tr> -->
	<%	
	/*i++;
		}*/
		
	}
	else
	{/*
		//sql="Select distinct(TripID),VehNo,SPlace,EPlace,TripDate,Transporter from t_avlfaulty_trips where TripDate BETWEEN '"+fromdate+"' and '"+todate+"'";
		sql="select TripID,Vehid,StartPlace,vehregno,EndPlace,TripStartDate,TripEndDate,Transporter from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status='Faulty'";
		//ResultSet rst=st.executeQuery(sql);
		//while(rst.next())
		{
			tripid=rst.getString("TripID");
			vehregno=rst.getString("vehregno");
			startplace1=rst.getString("StartPlace");
			startdate=rst.getString("TripStartDate");
			enddate=rst.getString("TripEndDate");
			endplace=rst.getString("EndPlace");
			OwnerName=rst.getString("Transporter");*/
			
			
			%>	
		<!-- 	<tr>
			<td>< %=i%></td>
			<td>< %=tripid%></td>
			<td>< % =vehregno%></td>
			<td>< %=startplace1%></td>
			<td>< %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate))%></td>
			<td>< %=endplace%></td>
			<td><  %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate))%></td>
			<td>< %=OwnerName%></td>
			</tr> -->
	<%	
	/*i++;
		}*/
		}
	%>		
			</table>
	<%
}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			conn.close();
		}
%>

<%@ include file="footernew.jsp"%>
	
