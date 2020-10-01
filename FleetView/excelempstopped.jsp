 <%@ include file="headerprintnew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
 			<table width="100%" align="center" >
			<tr>
			<td  align="center">
			<div align="left"><font size="3">Report No:1.2 </font></div>
			<div id="report_heding"><font size="3"><b> Stopped Vehicle </b></font></div>
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

	conn =fleetview.ReturnConnection();
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
			<th class="hed"> Updated</th>
			
			<th class="hed" > Location - Click To View On Map.</th>
			
			</tr>	
			<%
			try
		{
			VehList1=(String)session.getValue("VehList");
			String sql="select * from t_onlinedata where vehiclecode in " + VehList1 +" and TheSpeed = 0 order by concat(TheDate,TheTime) desc";
			rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{	
				
				if(fleetview.checkUserBlocked(rst.getString("Transporter")).equals("Yes"))
				{
					%>
					<tr>
						<td><%=i%></td>
						<td><%=rst.getString("VehicleRegNo")%></td>
						
						<td><%="Access denied for "+rst.getString("Transporter")%></td>
						
					</tr>
					<%
					}
					else
					{
					java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDate")+" "+rst.getString("TheTime"));
					Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
					String showdate1 = formatter1.format(ShowDate1);
					java.util.Date ddd= new java.util.Date();
					long dt1=ShowDate1.getTime();
					long dt2=ddd.getTime();
					long days=((dt2-dt1)/(60 * 60 * 1000L* 24));
					long mins=((dt2-dt1)/60000);
					long mins2=Integer.parseInt(session.getAttribute("desconnected").toString());
					if(mins < mins2)
					{
					%>
					<tr>
						<td style="background-color:#FFFFCC;"><%=i%></td>
						<td  style="background-color:#FFFFCC;"> 
						<%=rst.getString("VehicleRegNo")%>
       					
						</td>
						<td  style="background-color:#FFFFCC;"> <%=showdate1%></td>
						
					</tr>
					<%
					}
				i++;
				}
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