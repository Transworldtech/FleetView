<%@ include file="headernew.jsp"%>
<%! Connection conn;
    Statement st,st1;
    String sql,sql1;
  
    
    NumberFormat nf=DecimalFormat.getNumberInstance();
   %>
   
<% nf.setMaximumFractionDigits(2);
   nf.setMinimumFractionDigits(2);
   nf.setGroupingUsed(false);
   String fromdate="",todate="",triptype="",data1="",data2="",rng="";
   fromdate=request.getParameter("fromdate");
   todate=request.getParameter("todate");
   triptype=request.getParameter("thename");
   //System.out.println(fromdate);
  // System.out.println(todate);
   
   data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromdate")));
   data2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("todate")));
   
   rng=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromdate")));
   //System.out.println(data1);
   //System.out.println(data2);
   
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
		
try{
			%>
			<table border="0" width="100%">
			<!-- <tr style="border:none"><td><font color="block" size="3" >Report No: 10.5</font></td></tr>-->
			<tr><td>
			<font size="2"><b><center>Trips With Defective AVL For<%=rng%></center></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_faultyGPS.jsp?fromdate=<%=data1%>&todate=<%=data2%>&triptype=<%=triptype%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel_faultyGPS.jsp?fromdate=<%=data1%>&todate=<%=data2%>&triptype=<%=triptype%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
		<table border="1" width="100%" class="sortable">
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
		System.out.println(sql);
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
		ResultSet rst=st.executeQuery(sql);
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
	{
		/*
		//sql="Select distinct(TripID),VehNo,SPlace,EPlace,TripDate,Transporter from t_avlfaulty_trips where TripDate BETWEEN '"+fromdate+"' and '"+todate+"'";
		sql="select TripID,Vehid,StartPlace,vehregno,EndPlace,TripStartDate,TripEndDate,Transporter from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status='Faulty'";
		ResultSet rst=st.executeQuery(sql);
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
</div></td></tr></table>
<%@ include file="footernew.jsp"%>
		
  
  
  