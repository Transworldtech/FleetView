<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
			<table width="100%" align="center">
			<tr>
			<td align="center">
			<div align="left"><font size="3">Report No:1.7</font></div>			
			<div><font size="3"> <b>Device Inactive Vehicle</b></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<%=fleetview.PrintDate() %>
				</div>
			</td>
			</tr>
			</table>
			
			<!-- the logic come Here --->
			
			<%!
Connection conn;
Statement st,st1,stx;
ResultSet rst;
String user,VehList1,aa,regno,sq,searchveh;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	}catch(Exception e)
	{
		out.print("Exception -->"+e);
	}
%>
			<table width="100%" border="1" align="center" class="sortable">
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
			 <%@ include file="footerprintnew.jsp" %>