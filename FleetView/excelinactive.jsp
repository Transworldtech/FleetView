<%@ include file="headerexcel.jsp" %> 
<% response.setContentType("application/vnd.ms-excel");
String filename="notactive.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %> 
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body>
<!-- body part come here -->
			<table width="100%" border="1" align="center">
			<tr>
			<td  colspan="4">
			
			<div id="report_heding"><font  size="2"> <b>Device Inactive Vehicle </b></font></div>
				
				&nbsp; &nbsp;&nbsp; &nbsp; 
				<%=fleetview.PrintDate() %>
				
			</td>
			</tr>
			</table>
			<br>
			
			<!-- the logic come Here --->
			<%!
Connection conn;
Statement st,st1,stx;
ResultSet rst;
String user,VehList1,aa,regno,sq,searchveh;
%>
<%
try{
	
	conn =fleetview.ReturnConnection();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}
%>
			<table width="100%" border="0" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Vehicle Reg.No.</th>
			<th class="hed"> Installed Date</th>
			<th class="hed"> Installed Location</th>
			</tr>	
			<%
			try
			{
			VehList1=(String)session.getValue("VehList");
			String sql="select * from t_vehicledetails where vehiclecode in "+VehList1+" and vehiclecode not in (select vehiclecode from t_onlinedata where vehiclecode in " + VehList1 +") and Status <> 'Removed'";  
				ResultSet rstremoved1=stx.executeQuery(sql);
				int i=1;
				while(rstremoved1.next())
				{
				%>
				<tr>
				<td ><%=i%></td>	
				<td><%=rstremoved1.getString("VehicleRegNumber")%></td>	
				<td >
				<%
					try{
					out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rstremoved1.getDate("InstalledDate")));
					}catch(Exception ee)
					{
					}				
				%>				
				</td>	
				<td ><%=rstremoved1.getString("InstalledPlace")%></td>	
					
				</tr>				
				<%
				i++;
				}
				%>
				
				<input type="hidden" name="cnt" id="cnt" value="<%=i%>">				
				<%
			}catch(Exception e)
			{
				out.print("Exception--->"+e);
			}
			%>
			
			</table>
			<!-- the logic ned here -->
			<%
			try{
			conn.close();
			}catch(Exception e)
			{
				out.print("Exception--->"+e);
			}			
			%>
			<% fleetview.closeConnection(); %>
	</jsp:useBean>
    <%@ include file="footernew.jsp" %>