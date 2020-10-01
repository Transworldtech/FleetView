<%@ include file="headernew.jsp"%>
<%! Connection conn;
    Statement st,st1;
    String sql,sql1;
    String fromdate,todate,triptype,data1,data2;
    
    NumberFormat nf=DecimalFormat.getNumberInstance();
   %>
  
<% nf.setMaximumFractionDigits(2);
   nf.setMinimumFractionDigits(2);
   nf.setGroupingUsed(false);
   
   fromdate=request.getParameter("fromdate");
   todate=request.getParameter("todate");
   triptype=request.getParameter("thename");
   //System.out.println(fromdate);
   //System.out.println(todate);
   
   data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromdate")));
   data2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("todate")));
  // System.out.println(data1);
 //  System.out.println(data2);
   
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
			<table border="0" width="100%">
			<!-- <tr><td><font color="block" size="3" >Report No: 10.11</font></td></tr>-->
			<tr align="center"><td>
			<font size="2"><b>Report for De-Briefing from <%=data1%> to <%=data2%></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_dbriefing.jsp?fromdate=<%=data1%>&todate=<%=data2%>&triptype=<%=triptype%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel_dbriefing.jsp?fromdate=<%=data1%>&todate=<%=data2%>&triptype=<%=triptype%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
		<table border="1" width="100%" class="sortable">
			<tr>
			<th > Sr.</th>
			<th > Trip ID</th>
			<th> Driver Name</th>
			<th> Driver id</th>
			<th > De-briefing date</th>
			<th> Trainer Name</th>
			<th> Remark</th>
			</tr>	
		
	<%
		String tripid,prtripid,vehregno,stplace,endplace,stdate,drivernm,driverid,owner,category;
		int i=1;
	%>
	<%
	if(triptype.equalsIgnoreCase("started"))
	{
		
		/*String PSvehlist="(";
		String sqltrip="select distinct(tripid) from t_startedjourney where tripid IN (SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed')";
		//	String sqltrip="SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed'";
			ResultSet rsttrip=st.executeQuery(sqltrip);
			while(rsttrip.next())
			{
				 PSvehlist=PSvehlist+rsttrip.getString("TripID")+",";
			}
			 PSvehlist=PSvehlist+")";
			 PSvehlist=PSvehlist.replace(",)",")");
			System.out.println(PSvehlist);*/
		sql="SELECT TripID,DriverName,Driverid,Debriefdate,TrainerName,Remark FROM `t_debriefing` WHERE Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("TripID");
			driverid=rst.getString("Driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("Debriefdate");
			stplace=rst.getString("TrainerName");
			category=rst.getString("Remark");
			String sqltrip="select TripID from t_CastrolTripsStarted where TripID='"+tripid+"' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and Debriefing='Yes'";
			//out.println(sqltrip);
			ResultSet rsttrip=st1.executeQuery(sqltrip);
			if(rsttrip.next())
			{
				// out.print("1");
			}
			else
			{
			%>	
				<tr>
			<td><%=i%></td>
			<td><%=tripid%></td>
			<td><%=drivernm%></td>
			<td><%=driverid%></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stdate))%></td>
			<td><%=stplace%></td>
			<td><%=category%></td>
			</tr>
	<%	
	i++;
			}
		}
		
	}
	else if(triptype.equalsIgnoreCase("ended"))
	{
		sql="Select distinct(TripID),VehRegNo,StartPlace,EndPlace,StartDate,DriverName,DriverCode,OwnerName,Category from t_alljddata where StartDate BETWEEN '"+fromdate+"' and '"+todate+"' and Status = 'NotProcessed'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			tripid=rst.getString("TripID");
			vehregno=rst.getString("VehRegNo");
			stplace=rst.getString("StartPlace");
			stdate=rst.getString("StartDate");
			endplace=rst.getString("EndPlace");
			driverid=rst.getString("DriverCode");
			drivernm=rst.getString("DriverName");
			owner=rst.getString("OwnerName");
			category=rst.getString("Category");
			
			%>	
			<tr>
			<td><%=i%></td>
			<td><%=tripid%></td>
			<td><%=vehregno%></td>
			<td><%=stplace%></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))%></td>
			<td><%=endplace%></td>
			<td><%=driverid%></td>
			<td><%=drivernm%></td>
			<td><%=owner%></td>
			<td><div align="right">
				<%
				if(category.equals("Primary"))
				{
					out.print("Primary");
				}
				else if((category.equals("BPL") || (category.equals("Tanker"))))
				{
					out.print("Tanker");
				}
				else 
				{
					out.print("Secondary");
				}	
				
				%>
				</div></td></tr>
	<%		
	i++;
		}
	}
	else
	{
		sql="Select distinct(TripID),VehRegNo,StartPlace,EndPlace,StartDate,DriverName,DriverCode,OwnerName,Category from t_alljddata where StartDate BETWEEN '"+fromdate+"' and '"+todate+"' and Status = 'NotProcessed'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			tripid=rst.getString("TripID");
			vehregno=rst.getString("VehRegNo");
			stplace=rst.getString("StartPlace");
			stdate=rst.getString("StartDate");
			endplace=rst.getString("EndPlace");
			driverid=rst.getString("DriverCode");
			drivernm=rst.getString("DriverName");
			owner=rst.getString("OwnerName");
			category=rst.getString("Category");
			
			%>	
			<tr>
			<td><%=i%></td>
			<td><%=tripid%></td>
			<td><%=vehregno%></td>
			<td><%=stplace%></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))%></td>
			<td><%=endplace%></td>
			<td><%=driverid%></td>
			<td><%=drivernm%></td>
			<td><%=owner%></td>
			<td><div align="right">
				<%
				if(category.equals("Primary"))
				{
					out.print("Primary");
				}
				else if((category.equals("BPL") || (category.equals("Tanker"))))
				{
					out.print("Tanker");
				}
				else 
				{
					out.print("Secondary");
				}	
				%>
				</div></td></tr>
	          <%
	          i++;
		}
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
  