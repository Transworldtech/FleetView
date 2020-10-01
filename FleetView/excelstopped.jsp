<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="headerexcel.jsp" %> 
<% response.setContentType("application/vnd.ms-excel");
String filename="stopped.xls";
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
			<th  colspan="11">
			
			<div id="report_heding"><font size="2"><b> Stopped Vehicle</b></font></div>
				&nbsp; &nbsp;
				&nbsp; &nbsp;<%=fleetview.PrintDate() %> 
				</div>
			</th>
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
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Vehicle Reg.No.</th>
			<th class="hed"> Updated</th>
			<th class="hed" id="tdd0"> Trip Id</th>
			<th class="hed" id="tde0"> Driver Name(Code)</th>
			<th class="hed" id="tda0"> Trip Origin</th>
			<th class="hed" id="tdb0"> Start Date</th>
			<th class="hed" id="tdc0"> Trip Destination</th>
			<th class="hed" > Location - Click To View On Map.</th>
			<th class="hed"> Fuel</th>
			<th class="hed"> Fuel Alert</th>
			<%
		if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
		{
		%>
		<th class="hed"> Sen1</th>
		<th class="hed"> Sen2</th>
		<th class="hed"> Sen3</th>
		<th class="hed"> Sen4</th>
		<%
		}
		%>
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
						<td><%="Blocked"%></td>
						<td id="tdd<%=i%>">-</td>
						<td id="tde<%=i%>">-</td>
						<td id="tda<%=i%>">-</td>
						<td id="tdb<%=i%>">-</td>
						<td id="tdc<%=i%>">-</td>
						<td><%="Access denied for "+rst.getString("Transporter")%></td>
						<td>-</td>
						<td>-</td>
						<%
						if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
						{
						%>
						<td> -</td>
						<td> -</td>
						<td> -</td>
						<td> -</td>
						<%
						}
						%>
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
						<%
						ResultSet rsttrip=fleetview.isInTrip(rst.getString("VehicleCode"),session.getAttribute("TypeofUser").toString());
						if(rsttrip.next())
						{
						%>
						<td  style="background-color:#FFFFCC;" class="bodyText"  id="tdd<%=i%>">
        		<%=rsttrip.getString("TripId")%>
        	
				</td>
				<td id="tde<%=i%>"  style="background-color:#FFFFCC;"><div align="left"><%=rsttrip.getString("DriverName")+"("+rsttrip.getString("DriverCode")+")"%></div></td>
				<td id="tda<%=i%>"  style="background-color:#FFFFCC;"><div align="left"><%=rsttrip.getString("StartPlace")%></div></td>
				<td id="tdb<%=i%>"  style="background-color:#FFFFCC;"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip.getDate("StartDate"))%></td>
				<td id="tdc<%=i%>"  style="background-color:#FFFFCC;"><div align="left"><%=rsttrip.getString("EndPlace")%></div></td>
				<%
				}
				else
				{
				%>
				<td  style="background-color:#FFFFCC;" id="tdd<%=i%>"><--Enter</td>
				<td  style="background-color:#FFFFCC;" id="tde<%=i%>">New</td>
				<td  style="background-color:#FFFFCC;" id="tda<%=i%>">Trip</td>
				<td  style="background-color:#FFFFCC;" id="tdb<%=i%>">Information</td>
				<td  style="background-color:#FFFFCC;" id="tdc<%=i%>">Here --></td>
				<%
				}
				%>
						<td  style="background-color:#FFFFCC;"> 
						<div align="left">
						<%=rst.getString("Location")%>
						</div>						
						</td>
						<%
						if(fleetview.getUnitDescription(rst.getString("VehicleCode")).equals("FUELFLOW"))
						{ 
						%>
						
						<td style="background-color:#FFFFCC;"><%=fleetview.getFuelLevel(rst.getString("VehicleCode"),i) %></td>
						<td style="background-color:#FFFFCC;"><%=fleetview.getFuelAlertToday(rst.getString("VehicleCode")) %></td>
						<%
						}else
						{
							%>
							<td style="background-color:#FFFFCC;">NA</td>
							<td style="background-color:#FFFFCC;">NA</td>
						
							<% 
						}
						%><%
						if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
						{
						ResultSet rsx=fleetview.getTempValue(rst.getString("VehicleCode"));
							if(rsx.next())
				{
					%>
					<td style="background-color:#FFFFCC;"><%
					try{
						if(rsx.getString("Sen1").equals("0"))
						{
							out.print("xxxx");
						}
						else
						{
							out.print(rsx.getDouble("Sen1"));
						}
					}catch(Exception e1)
					{
					try{
						out.print("xxxx");
						}catch(Exception e2)
						{
						}
					}
 					%>
 					</td>
					<td style="background-color:#FFFFCC;"><%
						try{
							if(rsx.getString("Sen2").equals("0"))
							{
							out.print("xxxx");
							}
							else
							{
								out.print(rsx.getDouble("Sen2"));
							}
							}
							catch(Exception e1)
							{
							try{
								out.print("xxxx");
							}
							catch(Exception e2)
							{
							}
						}
 						%>
 						</td>
						<td style="background-color:#FFFFCC;"><%
							out.print("xxxx");
						%>
						</td>
						<td style="background-color:#FFFFCC;"><%
						out.print("xxxx");
						 %>
						 </td>
						<%
					}
					else
					{
					%>
					<td style="background-color:#FFFFCC;">-</td>
					<td style="background-color:#FFFFCC;">-</td>
					<td style="background-color:#FFFFCC;">-</td>
					<td style="background-color:#FFFFCC;">-</td>
					<%
					}
						}
						%>
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
			<!-- body part come here -->
			<% fleetview.closeConnection(); %>
			</jsp:useBean>
    <%@ include file="footernew.jsp" %>