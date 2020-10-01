
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"Castrol_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn,conn1;
Statement st1,st4,st8;
String fromdate, todate;
NumberFormat nf = DecimalFormat.getNumberInstance();
%>

<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);



try
{
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String thename,fromdate="", todate="";
	thename=request.getParameter("thename");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	String Transporter=session.getAttribute("usertypevalue").toString();
	
		
			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="2">ND Report For Started Primary Trips </font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">ND Report For Ended Primary Trips</font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">ND Report For Started And Ended Primary Trips</font></b></td></tr>
				<%
			}
		
	%>
	
	<%
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

	st1=conn.createStatement();
	st4=conn.createStatement();
	st8=conn.createStatement();
	
if(!(null==thename))
{ 
		//*********************************
	
	if(thename.equalsIgnoreCase("ended"))
	{}

///************************************************STARTED**********************************************************************************************	
	else if(thename.equalsIgnoreCase("started"))
	{
			
		//***************************************started all trips**************************************************
			
				%>
				<table border="1" width="100%" class="sortable">
				<tr>
				<td align="center"><b>Sr.</b></td>
				<td  align="center"><b>Transporter</b></td>
				<td  align="center"><b>Vehicle</b></td>
				<td  align="center"><b>NDStartDate</b></td>
				<td  align="center"><b>NDStartTime</b></td>
				<td  align="center"><b>NDEndDate</b></td>
				<td  align="center"><b>NDEndTime</b></td>
				<td  align="center"><b>Distance</b></td>
				<td  align="center"><b>Duration</b></td>
				</tr>
		<%
				int i1=1;
				double stdkm=0.00, ttime=0.00,ratinge=0.00;
				int nd=0,vehcodee=0;
				String vregn="",OwnerName="";
				
				String PSvehlist="(";
				String sqltrip="Select distinct(Vehid) as vehcodee from t_startedjourney where Tripid IN (Select distinct(TripId) from t_alljddata where Tripid Not in (SELECT Distinct(TripId) FROM t_avlfaulty_trips WHERE TripDate between '"+fromdate+"' and '"+todate+"') and StartDate between '"+fromdate+"' and '"+todate+"' and Category IN ('BPL','Tanker') and Status <> 'NotProcessed')";
							  //select Distinct(TripID) from t_startedjourney where TripID in (Select distinct(TripId) from t_alljddata where Tripid Not in (SELECT Distinct(TripId) FROM t_avlfaulty_trips WHERE TripDate between '"+fromdate+"' and '"+todate+"') and StartDate between '"+fromdate+"' and '"+todate+"' and Category in ('BPL','Tanker') and Status <> 'NotProcessed')";
					ResultSet rsttrip=st4.executeQuery(sqltrip);
					while(rsttrip.next())
					{
						vehcodee=rsttrip.getInt("vehcodee");
						String sql5="select * from  t_veh"+vehcodee+"_nd where FromDate between '"+fromdate+"' and '"+todate+"'";
						ResultSet rst16=st8.executeQuery(sql5);
						while(rst16.next())
						{
							//nd1+=rst16.getInt("NDCount");
						String sql="select * from vehicledetails where VehicleCode='"+vehcodee+"'";
						ResultSet rstt=st1.executeQuery(sql);
						if(rstt.next())
						{
							vregn=rstt.getString("VehicleRegNumber");
							OwnerName=rstt.getString("OwnerName");
						}
							%>
							<tr>
							<td><%=i1%></td>
							<td><%=OwnerName%></td>
							<td><%=vregn%></td>
							<td><%=rst16.getString("NDStartDate")%></td>
							<td><%=rst16.getString("NDStartTime")%></td>
							<td><%=rst16.getString("StartPlace")%></td>
							<td><%=rst16.getString("EndPlace")%></td>
							<td><%=rst16.getString("NDEndDate")%></td>
							<td><%=rst16.getString("NDEndTime")%></td>
							<td><%=rst16.getString("Distance")%></td>
							<td><%=rst16.getString("Duration")%></td>
							</tr>
							
							<%
							i1++;
						}
					}
			%>
			</table>
			<%
	
	//}
		
	
	}//end of else if started
	else if(thename.equalsIgnoreCase("both"))
	{}

//*********************************************************************************************
} //the name
}//try

	catch(Exception e)
	{
		e.printStackTrace();
	//	System.out.println("In side exception");	
	}
	finally
	{
		conn.close();
		conn1.close();
	}

	%>
	</table>
	</body>
	</html>
<%@ include file="footernew.jsp" %>
