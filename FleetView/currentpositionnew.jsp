<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<style><!-- 
    SPAN.searchword { background-color:cyan; }
    // -->
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

function showhide1()
{
	var cnt=document.getElementById("cnt").value;
	//alert("Hi Atul !"+cnt);
	var tda, tdb,tdc,tdd,tde;
	var tdx=document.getElementById("tdx").value;
	
	if(tdx=="Hide Trip Info")
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='none';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='none';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='none';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='none';
			tde=document.getElementById("tde"+i);
			tde.style.display='none';
			document.getElementById("tdx").value="Show Trip Info";
		}
	}
	else
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tda=document.getElementById("tda"+i);
			tda.style.display='';
			tdb=document.getElementById("tdb"+i);
			tdb.style.display='';
			tdc=document.getElementById("tdc"+i);
			tdc.style.display='';
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='';
			tde=document.getElementById("tde"+i);
			tde.style.display='';
			document.getElementById("tdx").value="Hide Trip Info";
		}
	}
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
Connection conn;
Statement st,st1,stx;
ResultSet rst;
String user,VehList1,aa,regno,sq,searchveh;
%>

<%
try{
	conn=fleetview.ReturnConnection();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	%>
	<table border="0" width="100%" align="center"> 
	<tr><td align="center">
	<!-- <div align="left"><font color="block" size="3" >Report No: 1.0</font></div>-->
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
				%>
				<tr>
				<td><INPUT TYPE=CHECKBOX NAME="ch<%=j%>" value="<%=rstnew1.getString("VehicleCode")%>"></td>
				<td align="left"><%=rstnew1.getString("VehicleRegNo")%></td>
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
	<tr><td>
	<table border="0" widht="100%" align="center">
	<tr><td>
	<marquee><font color="red" size="2" >Note: </font><font color="green" size="2">To see Moving, Stopped, Device Disconnected, Device Removed, Device Inactive Vehicles Separately Please click the below links in color Code. To see all vehicles Click on Full Fleet Link.  </font></marquee>
	</td></tr>
	<tr><td>
	<table width="100%" border="0">
			<tr>
			<td align="right" class="bodyText">
			<a href="onlinedata.jsp" title="Slow Process" id="blinking">Click To View All Vehicle On Map.</a>
			</td>
			<td align="right" class="bodyText">
			<a href="#" onclick="javascript:window.open('printcurrentposition.jsp');" title="Print Current Position Report">
			<img src="images/print.jpg" width="15px" height="15px">
			</a>&nbsp; &nbsp; 
			<a href="excelcorrentposition.jsp"  title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px">
			</a>
			</td>
			<td align="right" class="bodyText">
			<form method="get" name="searchhi">
			<input type="text" name="h" class="formElement"/>
			<input type="submit" value="Search Any Text!" class="formElement"/> &nbsp;&nbsp;
			<%=fleetview.PrintDate()%>
			</form>
			</td>
			</tr>
		</table>
	</td></tr>
	<tr><td>
	<!--  Mian Code Comes Here -->
	<table border="0" width="100%">
		<tr bgcolor="#F0E68C">
		<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :<a href="currentposition.jsp"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full Fleet</b></a></td>
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="moving.jsp">Moving</a></b></td>
		<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="stopped.jsp">Stop</a></b></td>
		<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="disconnected.jsp">Disconnected</a></b></td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Hide Trip Info" onclick="showhide1();" class="formElement" id="tdx" ></td>
		</tr>

		</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Vehicle Reg.No.</b></th>
			<th> <b>Updated</b></th>
			<th id="tdd0"> <b>Trip Id</b></th>
			<th id="tde0"><b>Driver Name(Code)</b></th>
			<th id="tda0"><b>Trip Origin</b></th>
			<th id="tdb0"><b>Start Date</b></th>
			<th id="tdc0"><b>Trip Destination</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			<th> <b>Fuel</b></th>
			<th> <b>Fuel Alert</b></th>
			<%
			if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
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
			VehList1=session.getAttribute("VehList").toString();
			String sql="select * from t_onlinedata where vehiclecode in " + VehList1 +" order by concat(TheDate,TheTime) desc";
			rst=st.executeQuery(sql);
			int i=0;
			while(rst.next())
			{
				i++;
				int col=rst.getInt("TheSpeed");
				if(fleetview.checkUserBlocked(rst.getString("Transporter")).equals("Yes"))
				{
				%>
					<tr bgcolor="white">
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
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
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
					String bgcolor="";
					 if(col >0) 
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
					<td style="<%=bgcolor %>">
					<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
					</td>
					<%
					ResultSet rsttrip=fleetview.isInTrip(rst.getString("VehicleCode"),session.getAttribute("TypeofUser").toString());
					if(rsttrip.next())
					{
					%>
					<td style="<%=bgcolor %>" id="tdd<%=i%>">
					<a href="javascript:toggleDetails1(<%=i%>,true);" title="Click To See the Reports"><%=rsttrip.getString("TripId")%> </a>  <br />
        			<div class="popup" id="popupx<%=i%>">
					<table border="1" bgcolor="white">
		   			<tr>  
					<td> <a href="startedtrip.jsp?tripid=<%=rsttrip.getString("TripId")%>&vehcode=<%=rst.getString("VehicleCode")%>&sdate=<%=rsttrip.getString("StartDate")%>&vehregno=<%=rst.getString("VehicleRegNo")%>&ownername=<%=rsttrip.getString("OwnerName")%>&startplace=<%=rsttrip.getString("StartPlace")%>&endplace=<%=rsttrip.getString("EndPlace")%>&enddate=<%=new SimpleDateFormat("yyyy-DD-MM HH:mm:ss").format(new java.util.Date())%>&pg=st" onclick="toggleDetails1(<%=i%>,false);">Show Trip on Map </a>
					</td>
		   			</tr>
		   			<tr>
					<td><a href="javascript: flase" onClick="window.open ('endtrip.jsp?tripid=<%=rsttrip.getString("TripId")%>&vehcode=<%=rst.getString("VehicleCode")%>&vehno=<%=rst.getString("VehicleRegNo")%>', 'win1', 'width=400, height=250, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">End Trip </a>
					</td>
		   			</tr>
			  		 <tr>
					<td> <a href="javascript:toggleDetails1(<%=i%>,false);">Close </a>
					</td>
		   			</tr>
	   				</table>
					</div>
					</td>
					<td style="<%=bgcolor %>" id="tde<%=i%>"><div align="left"><%=rsttrip.getString("DriverName")+"("+rsttrip.getString("DriverCode")+")"%></div></td>
					<td style="<%=bgcolor %>" id="tda<%=i%>"><div align="left"><%=rsttrip.getString("StartPlace")%></div></td>
					<td style="<%=bgcolor %>" id="tdb<%=i%>"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip.getDate("StartDate"))%></td>
					<td style="<%=bgcolor %>" id="tdc<%=i%>"><div align="left"><%=rsttrip.getString("EndPlace")%></div></td>
					<%
					}
					else
					{
					%>
					<td style="<%=bgcolor %>" id="tdd<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>"><--Enter</a></td>
					<td style="<%=bgcolor %>" id="tde<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">New</a></td>
					<td style="<%=bgcolor %>" id="tda<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">Trip</a></td>
					<td style="<%=bgcolor %>" id="tdb<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">Information</a></td>
					<td style="<%=bgcolor %>" id="tdc<%=i%>"><a href="tripstart.jsp?vehno=<%=rst.getString("VehicleRegNo")%>">Here --></a></td>
				
					<%
					}
					%>
					<td style="<%=bgcolor %>" ><div align="left"> 
					
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
					%>
					</div> </td>
					<td style="<%=bgcolor %>">
					<%=fleetview.getFuelLevel(rst.getString("VehicleCode"),i) %>
					</td>
					<td style="<%=bgcolor %>">
					<%=fleetview.getFuelAlertToday(rst.getString("VehicleCode")) %>
					</td>
					<%
					if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
					{
						ResultSet rsttemp=fleetview.getTempValue(rst.getString("VehicleCode"));					
						if(rsttemp.next())
						{
						%>
						<td style="<%=bgcolor %>">
						<%
						try{
						if(rsttemp.getString("Sen1").equals("0"))
						{
							out.print("xxxx");
						}
						else
						{
							out.print(rsttemp.getDouble("Sen1"));
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
						<td style="<%=bgcolor %>">
						<%
						try{
							if(rsttemp.getString("Sen2").equals("0"))
							{
							out.print("xxxx");
							}
							else
							{
								out.print(rsttemp.getDouble("Sen2"));
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
						<td style="<%=bgcolor %>">XXXX</td>
						<td style="<%=bgcolor %>">XXXX</td>	
						<%
						}
						else
						{
						%>
							<td style="<%=bgcolor %>">-</td>
							<td style="<%=bgcolor %>">-</td>
							<td style="<%=bgcolor %>">-</td>
							<td style="<%=bgcolor %>">-</td>	
						<%
						}
					}
					%>				
					</tr>
					<%
				}
	
			}
			sql="select * from t_vehicledetails where vehiclecode in "+VehList1+" and vehiclecode not in (select vehiclecode from t_onlinedata where vehiclecode in " + VehList1 +") and Status <> 'Removed'";  
			ResultSet rstremoved1=st.executeQuery(sql);
			while(rstremoved1.next())
			{
				i++;
				%>
			<tr>
			<td><%=i%></td>
			<td><%=rstremoved1.getString("VehicleRegNumber") %></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstremoved1.getDate("InstalledDate")) %></td>
			<td id="tdd<%=i%>">-</td>
			<td id="tde<%=i%>">-</td>
			<td id="tda<%=i%>">-</td>
			<td id="tdb<%=i%>">-</td>
			<td id="tdc<%=i%>">-</td>
			<td><div align="left">Device Installed But Not Active
			<%
			if(fleetview.isUnitRemoved(rst.getString("VehicleCode")).equals("Yes"))
					{
						out.print("<font color='blue' size='2'> Device Removed</font>");
					}
			%>
			</div></td>
			<td>-</td>
			<td>-</td>
			<%
			if(session.getAttribute("usertypevalue").toString().equals("Foodland"))
			{
			%>
			<td class="hed" align="center">xxxx</td>
			<td class="hed" align="center">xxxx</td>
			<td class="hed" align="center">xxxx</td>
			<td class="hed" align="center">xxxx</td>
			<%
			}
			%>
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
