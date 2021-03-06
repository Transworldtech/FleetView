<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">


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

fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");
triptype=request.getParameter("triptype");


   data1=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
//out.print("1");
	
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
			<tr align="center"><td>
			<font size="2"><b>Report for Trips Without GPS for <%=data1%></b></font>
		<table border="1" width="100%" class="sortable">
			<tr>
			<th > Sr.</th>
			<th > Trip ID</th>
			<th> Vehicle</th>
			<th> Start Place</th>
			<th > Start Date</th>
			<th> End Place</th>
			<th> Driver ID</th>
			<th> Driver Name</th>
			<th>Transporter</th>
			<th> Category</th>
			</tr>	
	<%
		String tripid,vehregno,stplace,endplace,stdate,drivernm,driverid,owner,category;
		int i=1;
	%>
	<%
	if(triptype.equalsIgnoreCase("started"))
	{
		sql="Select distinct(TripID),VehRegNo,StartPlace,EndPlace,StartDate,DriverName,DriverCode,OwnerName,Category from t_alljddata where StartDate BETWEEN '"+fromdate+"' and '"+todate+"' and Status = 'NotProcessed'";
		//out.print(sql);
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

<%@ include file="footernew.jsp"%>
	
