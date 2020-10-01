
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
			<th > De-Briefing Date</th>
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
		
		sql="SELECT tripid,DriverName,driverid,Debriefdate,Trainername,remarkcom FROM t_debriefing WHERE Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("tripid");
			driverid=rst.getString("driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("Debriefdate");
			//vehregno=rst.getString("DriverName");
			stplace=rst.getString("Trainername");
			
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
		
		sql="SELECT tripid,DriverName,driverid,Debriefdate,Trainername,remarkcom FROM t_debriefing WHERE Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("tripid");
			driverid=rst.getString("driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("Debriefdate");
			//vehregno=rst.getString("DriverName");
			stplace=rst.getString("Trainername");
			
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
		
		sql="SELECT tripid,DriverName,driverid,Debriefdate,Trainername,remarkcom FROM t_debriefing WHERE Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			
			tripid=rst.getString("tripid");
			driverid=rst.getString("driverid");
			drivernm=rst.getString("DriverName");
			stdate=rst.getString("Debriefdate");
			//vehregno=rst.getString("DriverName");
			stplace=rst.getString("Trainername");
			
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
