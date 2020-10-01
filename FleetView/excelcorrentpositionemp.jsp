<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"currentposition.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<%!
Connection conn,conn1;
Statement st,st1,stx,st2,stcommt;
String aa,regno,sq,searchveh;
%>

<%
try{
	conn=fleetview.ReturnConnection();
	conn1=fleetview.ReturnConnection1();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	stcommt=conn.createStatement();
	//out.print(session.getAttribute("VehList").toString());
	%>
	<table border="0" width="100%" align="center"> 
	<tr><td align="center">
	<font size="3" colspan="30" color="black"><b>Current Position Of Vehicles on <%=fleetview.PrintDate()%> </b></font>
	</td></tr>
	<tr><td>
	<table border="0" widht="100%" align="center">
	
	<tr><td>
	<!--  Mian Code Comes Here -->
	
			<table width="100%" border="1" align="center" class="sortable">
			<tr bgcolor="lightgrey">
			<th> <b> Sr. </b></th>
							<th> <b>Vehicle Reg.No.</b></th>
							<th> <b>Vehicle Type</b></th>
							<th> <b>Employee Name</b></th>
							<th> <b>Employee Code</b></th>
							<th> <b>Region</b></th>
							<th> <b>Updated</b></th>
							<th> <b>Location - Click To View On Map.</b></th>
							<th> <b>Distance Today</b></th>
							<th> <b>Distance This Month</b></th>
			<%
			if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
			{
			%>
			<th><b>Sen1</b></th>
			<th><b>Sen2</b></th>
			<th><b>Sen3</b></th>
			<th><b>Sen4</b></th>
			<%
			}
			%>
			</tr>	
			<%
			String empname="",empcode="",region="",vehtype="";
			final String  VehList1=session.getAttribute("VehList").toString();
			String specialcomment="-";
			String sql="select * from t_onlinedata where vehiclecode in "+ VehList1 +" order by concat(TheDate,TheTime) desc";
			ResultSet rst=st.executeQuery(sql);
			int i=0;
			while(rst.next())
			{
				i++;
				specialcomment="-";
				
				String sqlspcommt="SELECT spc.entdatetime,spc.vehregno,spc.spcomment as specialcomment		" +
				"       FROM db_CustomerComplaints.t_techspecialrep spc " +
				" 		INNER JOIN " +
				" 		( " +
				" 			SELECT Max(entdatetime) as entdatetime, spcomment,visibleInFleetview,cmmt_type,Closed, vehregno " + 
				" 			FROM db_CustomerComplaints.t_techspecialrep " +
				" 			WHERE visibleInFleetview='Yes'  " +
				" 			AND cmmt_type = 'vehicle' " +
				" 			AND Closed = 'No' " +
				" 			GROUP BY vehregno " +
				" 	) spcd ON (spc.VehRegNo= spcd.VehRegNo AND spc.entdatetime=spcd.entdatetime)" +
				"	where spc.VehRegNo='"+rst.getString("VehicleRegNo")+"'";
				ResultSet rscommt = stcommt.executeQuery(sqlspcommt);
				if(rscommt.next())
				{
					specialcomment = rscommt.getString("specialcomment");
				}
				String vehregno=rst.getString("VehicleRegNo");
				String sql3="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
				ResultSet rst3=st1.executeQuery(sql3);
				if(rst3.next())
				{
					empname=rst3.getString("Empname");
					empcode=rst3.getString("Empcode");
					vehtype=rst3.getString("vehtype");
				}
				region=rst.getString("Transporter");
				long ax=0, bx=12, cx=24, dx=36, ex=48, fx=60, gx=72, hx=84, ix=96, jx=108, kx=120, lx=132, mx=144, nx=156, ox=168, px=180, qx=192, rx=204, sx=216, tx=228, ux=240;
				int col=rst.getInt("TheSpeed");
				int kmtoday=0,kmlastday=0,kmthismonth=0,thedistance=0,ostoday;
				String fuelvalue="0";
				if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal") && !(rst.getString("FuelLevel").equalsIgnoreCase("NA")))
				{
					fuelvalue=""+fleetview.Liter_To_Gallan(rst.getInt("FuelLevel"));
				}
				else
				{
					fuelvalue=rst.getString("FuelLevel");
				}
				String vcode=rst.getString("VehicleCode");
				ostoday=rst.getInt("OSCount");
				if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
				{
					thedistance=(int)fleetview.KM_TO_MILES1(rst.getInt("TheDistance"));
					kmlastday=(int)fleetview.KM_TO_MILES1(rst.getInt("LastDayKm"));
					kmtoday=thedistance-kmlastday;
					if(kmtoday <0 || kmtoday >800)
					{
						kmtoday=0;
					}
					kmthismonth=(int)fleetview.KM_TO_MILES1(rst.getInt("KMMonth"))+kmtoday;
				}
				else
				{
					thedistance=rst.getInt("TheDistance");
					kmlastday=rst.getInt("LastDayKm");
					kmtoday=thedistance-kmlastday;
					if(kmtoday <0 || kmtoday >800)
					{
						kmtoday=0;
					}
					kmthismonth=rst.getInt("KMMonth")+kmtoday;
				}
				//out.print(kmtoday+"  "+kmthismonth+" ");
				if(fleetview.checkUserBlocked(rst.getString("Transporter")).equals("Yes"))
				{
		%>
			<tr bgcolor="white">
				<td><%=i%></td>
				<td><%=rst.getString("VehicleRegNo")%></td>
				<td><%=vehtype%></td>
				<td><%=empname%></td>
				<td><%=empcode%></td>
				<td><%=region%></td>
				<td><%="Blocked"%></td>
				
				<td><%="Access denied for "+rst.getString("Transporter")%></td>
				
				<td>-</td>
				<td>-</td>
				
		
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
				String bgcolor="";
				String igni="NA";
				igni=rst.getString("ignition");
				if(col > 0 && igni.equals("OFF"))
				{
					bgcolor="background-color:#FF6600";
				}
				else if(col >0) 
				{ 
					if(mins >mins2 )
				 	{
			 			bgcolor="background-color:#DCDCDC";
			 		}
			 		else 
				 	{
				 		bgcolor="background-color:#CCFFCC";
				 	}
		 		} 	
		 		else 
				{ 
					if(mins >mins2 )
					{
						bgcolor="background-color:#DCDCDC";
					}
					else
					{ 
						bgcolor="background-color:#FFFFCC";
					} 
				}	  					 
		%>
			<tr>
				<td style="<%=bgcolor %>"><%=i %></td>
				<td style="<%=bgcolor %>">
				<%=rst.getString("VehicleRegNo")%></td>
				<td style="<%=bgcolor%>"><%=vehtype%></td>
				<td style="<%=bgcolor%>"><%=empname %></td>
				<td style="<%=bgcolor%>"><%=empcode%></td>
				<td style="<%=bgcolor%>"><%=region%></td>
				<td style="<%=bgcolor%>">
					<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
				</td>
		
				<td style="<%=bgcolor %>" >
					<div align="left"> <a href="shownewmap.jsp?lat="+rst.getString("LatitudePosition")+"&long="+rst.getString("LongitudePosition")+"&discription="+rst.getString("Location")+" onclick="popWin=open('shownewmap.jsp?lat="+rst.getString("LatitudePosition")+"&long="+rst.getString("LongitudePosition")+"&discription="+rst.getString("Location")+"', 'myWin','width=500, height=500'); popWin.focus(); return false\"><%=rst.getString("Location") %></a>
					<!-- <%=fleetview.showNewMap(rst.getString("LatitudePosition"),rst.getString("LongitudePosition"),rst.getString("Location")) %> --> 
		<%
				if(fleetview.isUnitRemoved(rst.getString("VehicleCode")).equals("Yes"))
				{
					out.print("<font color='blue' size='2'> Device Removed</font>");
				}
				else
				{
					if(mins >mins2) 
					{
						out.print("<font color='red' size='2'> Device Disconnected</font>"); 
					}
				}
		if(!("-".equalsIgnoreCase(specialcomment) || "Other".equalsIgnoreCase(specialcomment)) && !((null == specialcomment) || "NULL".equalsIgnoreCase(specialcomment)))
			out.print("<br><font size='2' color='#000000'>"+specialcomment+"</font>");
		%>
					</div> 
				</td>
				
				
				
				<td style="<%=bgcolor %>"><div align="right"><%=kmtoday %></div></td>
				<td style="<%=bgcolor %>"><div align="right"><%=kmthismonth %></div></td>
		
</tr>	
<%
}
}
sql="select * from t_vehicledetails where vehiclecode in "+VehList1+" and vehiclecode not in (select vehiclecode from t_onlinedata where vehiclecode in " + VehList1 +") and Status <> 'Removed'";  
ResultSet rstremoved1=stx.executeQuery(sql);
while(rstremoved1.next())
{
	String vcode=rstremoved1.getString("VehicleCode");
	i++;
	specialcomment="-";
	String sqlspcommt="SELECT spc.entdatetime,spc.vehregno,spc.spcomment as specialcomment		" +
	"       FROM db_CustomerComplaints.t_techspecialrep spc " +
	" 		INNER JOIN " +
	" 		( " +
	" 			SELECT Max(entdatetime) as entdatetime, spcomment,visibleInFleetview,cmmt_type,Closed, vehregno " + 
	" 			FROM db_CustomerComplaints.t_techspecialrep " +
	" 			WHERE visibleInFleetview='Yes'  " +
	" 			AND cmmt_type = 'vehicle' " +
	" 			AND Closed = 'No' " +
	" 			GROUP BY vehregno " +
	" 	) spcd ON (spc.VehRegNo= spcd.VehRegNo AND spc.entdatetime=spcd.entdatetime)" +
	"where	spc.VehRegNo='"+rstremoved1.getString("VehicleRegNumber")+"'";
	ResultSet rscommt = stcommt.executeQuery(sqlspcommt);
	if(rscommt.next())
	{
		specialcomment = rstremoved1.getString("specialcomment");
	}
%>
<tr>
	<td><%=i%></td>
	<td><%=rstremoved1.getString("VehicleRegNumber") %></td>
	<td><%=rstremoved1.getString("vehtype") %></td>
	<td><%=empname %></td>
	<td><%=empcode %></td>
	<td><%=region%></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstremoved1.getDate("InstalledDate")) %></td>
	
	<td><div align="left">Device Installed But Not Active
<%
	if(fleetview.isUnitRemoved(rstremoved1.getString("VehicleCode")).equals("Yes"))
	{
		out.print("<font color='blue' size='2'> Device Removed</font>");
	}
	if(!("-".equalsIgnoreCase(specialcomment) || "Other".equalsIgnoreCase(specialcomment)) && !((null == specialcomment) || "NULL".equalsIgnoreCase(specialcomment)))
		out.print("<br><font size='2' color='#000000'>"+specialcomment+"</font>");
%>
	</div></td>
	
	<td>-</td>
	<td>-</td>
	
		
	</tr>		
<%
}
%>
	<input type="hidden" name="cnt" id="cnt" value="<%=i%>">
</table>
	
	<!--  Mian Code Comes Here -->
	</td></tr>
	</table>
	</td></tr>
	</table>
	
	
	
	
	<%
	}catch(Exception e)
	{
		System.out.print("Exception -->"+e);
	}
	%>

	<% fleetview.closeConnection(); %>
	
	</jsp:useBean>
	<%@ include file="footernew.jsp" %>