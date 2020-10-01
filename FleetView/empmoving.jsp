<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
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
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function showhide1()
{
	
	var cnt=document.getElementById("cnt").value;
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
			<table width="100%" align="center" class="stats">
			<tr>
			<td align="center">
			<div align="left"><font size="3">Report No:1.1</font></div>
			<div id="report_heding"><font size="3"><b> Moving Vehicle</b></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('printmoving.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelmoving.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=fleetview.PrintDate()%>
				</div>
			</td>
			</tr>
			</table>
			
			<!-- the logic come Here --->
			<table border="0" width="100%" align="center">
			<tr bgcolor="#F0E68C">
		<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :<a href="castrolempmain.jsp">Full Fleet</a></b></td >
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b><a href="empmoving.jsp">Moving</a></b></td>
		<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b><a href="empstopped.jsp">Stop</a></b></td>
		<td bgcolor="#DCDCDC" class="sorttable_nosort"><b><a href="empdisconnected.jsp">Disconnected</a></b></td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b><a href="removed.jsp">Removed</a></b></td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b><a href="notactive.jsp">Not Active</a></b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Hide Trip Info" onclick="showhide1();" class="formElement" id="tdx" ></td>
		</tr>			
			</table>
			<%!
Connection conn;
Statement st,st1,stx;
ResultSet rst;
String user,VehList1,aa,regno,sq,searchveh;
%>
<%
try{
	conn = fleetview.ReturnConnection();
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
			<th class="hed"> Speed Km/h</th>
			
			<th class="hed" > Location - Click To View On Map.</th>
			
			</tr>	
			<%
			try
		{
			VehList1=(String)session.getValue("VehList");
			String sql="select * from t_onlinedata where vehiclecode in " + VehList1 +" and TheSpeed > 0 order by concat(TheDate,TheTime) desc";
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
						<td>-</td>
						
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
						 
java.util.Date todaysDate =new java.util.Date();
						
						Format NewFormatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						Format NewFormatter2 = new SimpleDateFormat("yyyy-MM-dd");
						String currentDateTime = NewFormatter1.format(todaysDate);
						
						String d2=NewFormatter2.format(todaysDate);
						
						long todaysDateMillis = todaysDate.getTime(); // todays date in millisecs
						long dayInMillis = 1000 * 60 * 60 *24; // 1 day in millisecs
						
						todaysDateMillis = todaysDateMillis - dayInMillis; // 24 hrs previous datetime from currentdatetime (in millisecs)
						todaysDate.setTime(todaysDateMillis);
						
						String twentyFourHoursPrevDatetime = NewFormatter1.format(todaysDate);
						
						String d1=NewFormatter2.format(todaysDate);
						
						
						String twentyFourHoursPrevDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
						String currentDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
						String ftime1= new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
						String ftime2= new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(twentyFourHoursPrevDatetime));
						String ttime1= new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTime));
						String ttime2= new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentDateTime));
						
						
						session.setAttribute("hvid",rst.getString("VehicleCode"));
						session.setAttribute("fff",twentyFourHoursPrevDatetime);
						session.setAttribute("ttt",currentDateTime);
						session.setAttribute("hdate1",d1);
						session.setAttribute("hdate2",d2);
						
					%>
					<tr>
						<td style="background-color:#CCFFCC;"><%=i%></td>
						<td  style="background-color:#CCFFCC;"> 
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
		   		<td> <a href="ShowCustomReportonTWMap.jsp?tripid=''&vehcode=<%=rst.getString("VehicleCode")%>&data=<%=twentyFourHoursPrevDate%>&data1=<%=currentDate%>&ftime1=<%=ftime1%>&ftime2=<%=ftime2%>&ttime1=<%=ttime2%>&ttime2=<%=ttime2%>" onclick="toggleDetails(<%=i%>,false);">Last 24 Hours Journey On Map </a> 
				</td>
				<!--<td> <a href="veh_showhistory.jsp?vehcode=< %=rst.getString("VehicleCode")%>" onclick="toggleDetails(< %=i%>,false);">Last 24 Hours Journey On Map </a> 
		  		</td>-->
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
						<td  style="background-color:#CCFFCC;"> <%=showdate1%></td>
						<td  style="background-color:#CCFFCC;"> <%=rst.getString("TheSpeed")%></td>
						
						<td  style="background-color:#CCFFCC;"> 
						<div align="left">
						<%=fleetview.showNewMap(rst.getString("LatitudePosition"),rst.getString("LongitudePosition"),rst.getString("Location")) %>
						<% if(mins >mins2) out.print("<font color='red' size='2'> Device Disconnected</font>"); %>
						</div>						
						</td>
						
						
						
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
			<%@ include file="footernew.jsp" %>