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
			<!-- <tr><td><font color="block" size="3" >Report No: 10.7</font></td></tr>-->
			<tr align="center"><td>
			<font size="2"><b>Report for Briefing from <%=data1%> to <%=data2%></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_totbriefing.jsp?fromdate=<%=data1%>&todate=<%=data2%>&triptype=<%=triptype%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel_totbriefing.jsp?fromdate=<%=data1%>&todate=<%=data2%>&triptype=<%=triptype%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
		<table border="1" width="100%" class="sortable">
			<tr>
			<th > Sr.</th>
			<th > Trip ID</th>
			<th> Driver Name</th>
			<th> Driver id</th>
			<th > Briefing Date</th>
			<th> Trainer Name</th>
			<th> Remark</th>
			</tr>	
		
	<%
		String tripid,prtripid,vehregno,stplace,endplace,stdate,drivernm,driverid,owner,category,remark;
		int i=1;
	%>
	<%
	if(triptype.equalsIgnoreCase("started"))
	{
		
		sql="SELECT TripID,DriverName,Driverid,brifdate,TrainerName,remarkcom FROM `t_briefing` WHERE brifdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:55:59' ";
//out.println(sql);
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("TripID");
			driverid=rst.getString("Driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("brifdate");
			//vehregno=rst.getString("DriverName");
			stplace=rst.getString("TrainerName");
			
			//endplace=rst.getString("EndPlace");
			
			//owner=rst.getString("OwnerName");
			category=rst.getString("remarkcom");
			
			/*if(rst.getString("TripID").length()>4)
			{
				if(prtripid.equals(tripid))
				{
					
				}
			}
			else
			{
				
			}*/
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
	//prtripid=tripid;
		}
		
	}
	else if(triptype.equalsIgnoreCase("ended"))
	{
		
		sql="SELECT TripID,DriverName,Driverid,brifdate,TrainerName,remarkcom FROM `t_briefing` WHERE brifdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("TripID");
			driverid=rst.getString("Driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("brifdate");
			//vehregno=rst.getString("DriverName");
			stplace=rst.getString("TrainerName");
			
			//endplace=rst.getString("EndPlace");
			
			//owner=rst.getString("OwnerName");
			category=rst.getString("remarkcom");
			
			/*if(rst.getString("TripID").length()>4)
			{
				if(prtripid.equals(tripid))
				{
					
				}
			}
			else
			{
				
			}*/
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
	//prtripid=tripid;
		}
		
	}
	else
	{
		
		sql="SELECT TripID,DriverName,Driverid,brifdate,TrainerName,remarkcom FROM `t_briefing` WHERE brifdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' ";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("TripID");
			driverid=rst.getString("Driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("brifdate");
			//vehregno=rst.getString("DriverName");
			stplace=rst.getString("TrainerName");
			
			//endplace=rst.getString("EndPlace");
			
			//owner=rst.getString("OwnerName");
			category=rst.getString("remarkcom");
			
			/*if(rst.getString("TripID").length()>4)
			{
				if(prtripid.equals(tripid))
				{
					
				}
			}
			else
			{
				
			}*/
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
	//prtripid=tripid;
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

		
  
  
  
