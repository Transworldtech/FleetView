
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
Connection conn;
Statement st,st1;
String sql,sql1;
String fromdate,todate,triptype,data1,data2;

NumberFormat nf=DecimalFormat.getNumberInstance();
%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);

data1=request.getParameter("fromdate");
data2=request.getParameter("todate");
triptype=request.getParameter("triptype");
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));
	
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
		
		String PSvehlist="(";
		String sqltrip="select distinct(tripid) from t_startedjourney where tripid IN (SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed')";
		//	String sqltrip="SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed'";
			ResultSet rsttrip=st.executeQuery(sqltrip);
			while(rsttrip.next())
			{
				 PSvehlist=PSvehlist+rsttrip.getString("TripID")+",";
			}
			 PSvehlist=PSvehlist+")";
			 PSvehlist=PSvehlist.replace(",)",")");
		//	System.out.println(PSvehlist);
		sql="SELECT TripID,DriverName,Driverid,Debriefdate,TrainerName,Remark FROM `t_debriefing` WHERE tripid not in "+PSvehlist+" and Debriefdate between '"+fromdate+"' and '"+todate+"'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("TripID");
			driverid=rst.getString("Driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("Debriefdate");
			stplace=rst.getString("TrainerName");
			category=rst.getString("Remark");
			
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
