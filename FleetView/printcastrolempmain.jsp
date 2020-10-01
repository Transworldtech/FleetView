<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<style>
<!-- 
    SPAN.searchword { background-color:cyan; }
    
// -->
</style>

<style>

SPAN.super 
{
	text-decoration: blink;
	text-align: center; 
}

</style>

<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">
<script language="JavaScript">
<!--
    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;     
    }
    // -->
</script>
<script type="text/javascript">
function toggleDetails(id, show)
{
	var popup = document.getElementById("popup"+id);
	if (show) {
		popup.style.visibility = "visible";
		popup.setfocus();
			} else {
		popup.style.visibility = "hidden";
	}
}

function toggleDetails1(id, show)
{
	var popupx = document.getElementById("popupx"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
		
	} else {
		popupx.style.visibility = "hidden";
	}
}
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function article(programName,width,height)
{

	var temp = "menubar=yes,toolbar=no,location=no,status=yes,scrollbars=yes,resizable=yes,width="+width+",height="+height; displayWindow=window.open(programName,"displayWindow",temp) ;
}
function fun(aa)
{
	//alert(aa.value);
	document.searchform.h.value=aa.value;
}


</script>

<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;

.popupx {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>
<%!
	Connection conn,conn1;
	Statement st,st1,stx,st2,stcommt;
	String aa,regno,sq,searchveh;
%>
<%
try
{
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
			<div align="left"><font color="block" size="3" >Report No: 1.0</font></div>
				<font size="3" ><b>Current Position Of Vehicles </b></font>
		</td></tr>
		<tr><td align="center">
		<%
		if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
		{
			out.print("<br><font size='2'>You are viewing vehicles which are in 10 km. range from your location and vehicles which are going from your location and coming to your location.</font>");
			/* code to search and add vehicle which is not in the list */
		%>
		<p></p>
			<table class="stats">
				<form name="searchform" action="" method="get">
					<tr><th  colspan="5">Search and add the vehicle in the list.</th></tr>
					<tr><td class="bodyText" colspan="5"><div align="right">Vehicle is not in the list, please enter the Vehicle registration number to search.</div><div align="right"><input type="hidden" name="h" id="h" class="formElement"><input type="text" name="searchveh" class="formElement" onChange="fun(this);">&nbsp;&nbsp;&nbsp; <input type="submit" name="Search!" value="Search!" class="formElement"></div></td></tr>
				</form>
 
			<%
			searchveh=request.getParameter("searchveh");
			if(!(null==searchveh))
			{
				String sql="select * from t_group where transporter like '%"+searchveh+"%' and GPName='"+session.getAttribute("usertypevalue").toString()+"' and vehCode not in "+session.getAttribute("VehList").toString();
				//out.print(sql);
				ResultSet rstnew=st.executeQuery(sql);
			%>
				<form name="addveh" method="get" action="addveh.jsp">	
					<tr><td class="bodyText" colspan="5">Please check Vehicle to add in the list</td></tr>
					<tr>
						<td class="hed">Check<input type="hidden" name="hh" value="<%=searchveh%>"></td>
						<td class="hed">Vehicle Reg. No</td>
						<td class="hed">Vehicle Type</td>
						<td class="hed">Employee Name</td>
						<td class="hed">Employee Code</td>
						<td class="hed">Transporter</td>
						<td class="hed">Updated</td>
						<td class="hed">Location</td>
					</tr>	
			<%
					int j=1;
			     
					while(rstnew.next())
					{
						sql="select * from t_onlinedata where VehicleCode='"+rstnew.getString("VehCode")+"'";
						ResultSet rstnew1=st1.executeQuery(sql);
						if(rstnew1.next())
						{
							
							String empname1="",empcode="",vehtype="";
							String vehregno=rstnew1.getString("VehicleRegNo");
							String sql3="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
							ResultSet rst3=st1.executeQuery(sql3);
							if(rst3.next())
							{
								 empname1=rst3.getString("Empname");
								 vehtype=rst3.getString("vehtype");
								//empcode=rst3.getString("Empcode");
							}	
						
			%>
					<tr>
						<td><INPUT TYPE=CHECKBOX NAME="ch<%=j%>" value="<%=rstnew1.getString("VehicleCode")%>"></td>
						<td align="left"><%=rstnew1.getString("VehicleRegNo")%></td>
						<td align="left"><%=vehtype%></td>
						<td align="left"><%=empname1%></td>
						<td align="left">-</td>
						<td align="left"><%=rstnew1.getString("Transporter")%></td>
						<td align="left"><%= new SimpleDateFormat("dd-MMM-yyyy").format(rstnew1.getDate("TheDate"))%><%=rstnew1.getString("TheTime")%></td>
						<td align="left"><div align="left"><%=rstnew1.getString("Location")%> </div></td>
					</tr>			
			<%
						j++;
						}
					}
			%>
					<input type="hidden" name="count" value="<%=j%>">
					<tr><td colspan="5" align="center"><input type="submit" value="Add Vehicle" Name="Add_Vehicle" class="formElement"></td></tr>
				</form>
			<%
			}
			%>
		</table>
		<%
		/* code end added by Atul Kalaskar on Date 11-11-09 */

		}
		%>
		</td></tr>
		<tr><td align="right">
			
							<a href="#" onclick="javascript:window.print()" title="Print Current Position Report">
								<img src="images/print.jpg" width="15px" height="15px">
							</a>
			&nbsp;&nbsp;
								<%=fleetview.PrintDate()%>
						
			</td></tr>
			<tr><td>	
				<table border="0" width="100%">
				<tr><td>
					<!--  Mian Code Comes Here -->
					<table border="0" width="100%">
						<tr bgcolor="#F0E68C">
							<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :<a href="castrolempmain.jsp"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full Fleet</b></a></td>
							<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="empmoving.jsp">Moving</a></b></td>
							<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="empstopped.jsp">Stop</a></b></td>
							<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="empdisconnected.jsp">Disconnected</a></b></td>
							<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
							<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						</tr>
					</table>
					<table width="100%" border="1" align="center" class="sortable">
						<tr>
							<th> <b> Sr. </b></th>
							<th> <b>Vehicle Reg.No.</b></th>
							<th> <b>Vehicle Type</b></th>
							<th> <b>Employee Name</b></th>
							<th> <b>Employee Code</b></th>
							<th> <b>Updated</b></th>
							<th> <b>Location - Click To View On Map.</b></th>
							<th> <b>Distance Today</b></th>
							<th> <b>Distance This Month</b></th>
						</tr>	
			<%
						final String  VehList1=session.getAttribute("VehList").toString();
			String specialcomment="-";
						String empname="",empcode="",vehtype="";
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
								<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=rst.getString("VehicleRegNo")%> </a>  <br />
        						<div class="popup" id="popup<%=i%>">
								<table border="1" bgcolor="white">
		   							<tr>  
										<td> <a href="veh_report_24h.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 24 Hours </a>
										</td>
		   							</tr>
		   							<tr>
		   								<td> <a href="veh_report_48h.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 48 Hours </a>
										</td>
								   	</tr>
		   							<tr>
										<td> <a href="veh_report_7d.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 7 Days </a>
										</td>
		   							</tr>
		   							<tr>
										<td> <a href="veh_report_15d.jsp?vid=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Report For Last 15 Days </a>
										</td>
		   							</tr>
		   							<tr>
										<td> <a href="veh_showhistory.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Last 24 Hours Journey On Map </a> 
		  								</td>
		  						 	</tr>
		   							<tr>
										<td> <a href="hourly_detail_report.jsp?vehcode=<%=rst.getString("VehicleCode")%>&h1=no" onclick="toggleDetails(<%=i%>,false);">Detail Report </a>
										</td>
								   	</tr>
		   							<tr>
										<td> <a href="detail_custom_report.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Custom Detail Report </a>
										</td>
								   	</tr>
									<tr>
										<td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
										</td>
								   	</tr>
	   							</table>
								</div>
							</td>
							<td style="<%=bgcolor%>"><%=vehtype%></td>
							<td style="<%=bgcolor%>"><%=empname %></td>
							<td style="<%=bgcolor%>"><%=empcode %></td>
							<td style="<%=bgcolor%>">
								<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
							</td>
					
							<td style="<%=bgcolor %>" >
								<div align="left"> 
								<%=fleetview.showNewMap(rst.getString("LatitudePosition"),rst.getString("LongitudePosition"),rst.getString("Location")) %> 
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
	"where	spc.VehRegNo='"+rst.getString("VehicleRegNumber")+"'";
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
		out.print("Exception -->"+e);
	}
	%>

	<% fleetview.closeConnection(); %>
	
	</jsp:useBean>
	<%@ include file="footernew.jsp" %>
