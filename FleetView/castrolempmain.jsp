<%@ include file="headernew.jsp"%>

<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	


<%@page import="java.util.Date"%>
<%@page import="com.fleetview.beans.classes"%><style>
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

var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}  
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");} 
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
}


    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;     
    }
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
	Statement st,st1,stx,st2,stcommt, stComment;
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
	stComment=conn.createStatement();
	//out.print(session.getAttribute("usertypevalue").toString());
%>
	<table border="0" width="100%" align="center" class="stats"> 
		<tr><td align="center">
			<!-- <div align="left"><font color="block" size="3" >Report No: 1.0</font></div>-->
				<font size="3" ><b>Current Position Of Vehicles </b></font>
		</td></tr>
		</table>
		<%
		
		
		
		
		if(session.getAttribute("TypeofUser").toString().equals("SUBUSER"))
		{
			out.print("<br><font size='2'>You are viewing vehicles which are in 10 km. range from your location and vehicles which are going from your location and coming to your location.</font>");
			/* code to search and add vehicle which is not in the list */
		%>
		
			<table class="stats">
				<form name="searchform" action="" method="get">
				<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  
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
							
							String empname1="",empcode="";
							String vehregno=rstnew1.getString("VehicleRegNo");
							String sql3="select * from t_vehicledetails where VehicleRegNumber='"+vehregno+"'";
							ResultSet rst3=st1.executeQuery(sql3);
							if(rst3.next())
							{
								 empname1=rst3.getString("Empname");
								 empcode=rst3.getString("Empcode");
							}	
						
			%>
			
					<tr>
						<td><INPUT TYPE=CHECKBOX NAME="ch<%=j%>" value="<%=rstnew1.getString("VehicleCode")%>"></td>
						<td align="left"><%=rstnew1.getString("VehicleRegNo")%></td>
						<td align="left"><%=empname1%></td>
						<td align="left"><%=empcode%></td>
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
		
			<table border="0" widht="100%" align="center">
				<!--<tr><td><font color="red" size="2"><B> Kind Attention : Due to server maintainance the website will be unavailable from 06.30 p.m to 08.00 p.m. on 23rd Jan 2010. Sorry for the inconvenience. </blink></I> </B> 
				</font>		</td></tr>-->
				
				<tr><td align="left">
					<font color="green" size="3"><B>  </B><a href="#" onclick="javascript:window.open('generateSecurityCode.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');"> <font size="2"> <u>Security Code </u></font> </a></font>
				</td></tr>
				<tr><td>
					<table width="100%" border="0">
					<tr>
					
<!--						<td align="left"" class="bodyText">-->
<!--							<a href="onlinedataemp.jsp" title="Slow Process" id="blinking">Click To View All Vehicle On Map.</a>-->
<!--						</td>-->
						<td align="right" class="bodyText">
							&nbsp;
						</td>
						<td align="right" class="bodyText">
							<form method="get" name="searchhi">
								<input type="text" name="h" class="formElement"/>
								<input type="submit" value="Search Any Text!" class="formElement"/> &nbsp;&nbsp;
								&nbsp;&nbsp;
								<a href="#" onclick="javascript:window.open('printcastrolempmain.jsp');" title="Print Current Position Report">
								<img src="images/print.jpg" width="15px" height="15px">
								</a>&nbsp; &nbsp; 
								<a href="excelcorrentpositionemp.jsp"  title="Export to Excel">
									<img src="images/excel.jpg" width="15px" height="15px">
								</a>
								&nbsp;&nbsp;
								<%=fleetview.PrintDate()%>
							</form>
						</td>
					</tr>
					</table>
				</td></tr>
				</table>
			
				<table border="0" width="100%">
				<tr><td>
					<!--  Mian Code Comes Here -->
					<table border="0" width="100%">
						<tr bgcolor="#F0E68C">
							<td ><b class="bodyText">Color Code Indications :<a href="castrolempmain.jsp"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full Fleet</b></a></td>
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
							<th> <b>Veh.</b></th>
							<th> <b>Veh. Type</b></th>
							<th> <b>Employee Name</b></th>
							<th> <b>Employee Code</b></th>
							<th> <b>Mobile No</b></th>
							<th> <b>Region</b></th>
							<th> <b>Updated</b></th>
							<th> <b>Location</b></th>
							<th> <b>Distance Today</b></th>
							<th> <b>Distance This Month</b></th>
							
							
						</tr>	
						
			<%
			
		
						String empname="",empcode="",region="",mobno="",vehtype="";
							
						final String  VehList1=session.getAttribute("VehList").toString();
						String specialcomment="-";
//out.print("vehicle list"+VehList1);
						String sql="select * from t_onlinedata where vehiclecode in "+ VehList1 +" order by concat(TheDate,TheTime) desc";
									
						ResultSet rst=st.executeQuery(sql);
						int i=0;
						while(rst.next())
						{
							i++;
							System.out.println("*****   "+i);
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
								mobno = rst3.getString("MobilePhNo");
							    vehtype = rst3.getString("vehtype");
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
							<td style="text-align: right"><%=i%></td>
							<td style="text-align: left"><%=rst.getString("VehicleRegNo")%></td>
							<td style="text-align: left"><%=vehtype%></td>
							<td style="text-align: left"><%=empname%></td>
							<td style="text-align: right"><%=empcode%></td>
							<td style="text-align: right"><%=mobno %></td>
							<td style="text-align: left"><%=region%></td>
							<td style="text-align: left"><%="Blocked"%></td>
							
							<td style="text-align: left"><%="Access denied for "+rst.getString("Transporter")%></td>
							
							<td style="text-align: right">-</td>
							<td style="text-align: right">-</td>
							
							
					
						</tr>	
					<%
							}
						else
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
							
							String VehicleCode=rst.getString("VehicleCode");
							
							session.setAttribute("hvid",rst.getString("VehicleCode"));
							session.setAttribute("fff",twentyFourHoursPrevDatetime);
							session.setAttribute("ttt",currentDateTime);
							session.setAttribute("hdate1",d1);
							session.setAttribute("hdate2",d2);	
							
							
						
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
							<td style="<%=bgcolor %>; text-align: right"><%=i %></td>
							<td style="<%=bgcolor %>; text-align: left">
								<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=rst.getString("VehicleRegNo")%> </a>  <br />
        						<div class="popup" id="popup<%=i%>">
								<table border="1" bgcolor="#9db5e5" cellpadding="1px" cellspacing="1px">
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
										<td> <a href="EmpNameEditNew.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Edit User Details </a>
										</td>
								   	</tr>
									
									<!--<tr>
										<td> <a href="VehicleIdleEntry.jsp?vehcode=<%=rst.getString("VehicleCode")%>" onclick="toggleDetails(<%=i%>,false);">Enter Vehicle Idle Status </a>
										</td>
								   	</tr>
									
									--><tr>
										<td> <a href="javascript:toggleDetails(<%=i%>,false);">Close </a>
										</td>
								   	</tr>
	   							</table>
								</div>
							</td>
							<td style="<%=bgcolor %>; text-align: left"><%=vehtype%></td>
							<td style="<%=bgcolor%>; text-align: left"><%=empname %></td>
							<td style="<%=bgcolor%>; text-align: right"><%=empcode%></td>
							<td style="<%=bgcolor %>; text-align: right"><div align="right"><%=mobno %></div></td>
							<td style="<%=bgcolor%>; text-align: left"><%=region%></td>
							<td style="<%=bgcolor%>; text-align: left">
								<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
							</td>
					
							<td style="<%=bgcolor %>; text-align: left">
								<div align="left">
								<a href="shownewmap.jsp?lat=lat=<%=rst.getString("LatitudePosition") %>&long=<%=rst.getString("LongitudePosition")%>&discription=<%=empname+"<br>"+rst.getString("Location")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst.getString("LatitudePosition") %>&long=<%=rst.getString("LongitudePosition")%>&discription=<%=empname+"<br>"+rst.getString("Location")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%=rst.getString("Location") %></a>
								
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
					
						
						// Added here veh specail comment
						String sqlCommet, VehComment, otherComment, currentDate2;
						Date date = new Date();
						currentDate2=new SimpleDateFormat("yyyy-MM-dd").format(date);
						sqlCommet="select VehComment, otherComment from  db_gps.t_VehicleIdleEntry   where ActiveStatus='-' and  VehCode='"+VehicleCode+"' and toDate>='"+currentDate2+"'  and  fromDate<='"+currentDate2+"'";
						System.out.println(" comment sql "+sqlCommet);
						ResultSet rstComment=stComment.executeQuery(sqlCommet);
						while(rstComment.next())
						{
							VehComment=rstComment.getString("VehComment");
							otherComment=rstComment.getString("otherComment"); 
							if(!VehComment.equals("Other"))
							{
							out.print("<br><font size='2' color='red'><b>"+VehComment+"</b></font>");
							}
							else
							{
								out.print("<br><font size='2' color='red'><b>"+otherComment+"</b></font>");
							}
						}
						
					%>
						
					
								</div> 
							</td>
							
							
							
							<td style="<%=bgcolor %>; text-align: right"><div align="right"><%=kmtoday %></div></td>
							<td style="<%=bgcolor %>; text-align: right"><div align="right"><%=kmthismonth %></div></td>
							
					
			</tr>	
		<%
	}
}
sql="select * from t_vehicledetails where vehiclecode in "+VehList1+" and vehiclecode not in (select vehiclecode from t_onlinedata where vehiclecode in " + VehList1 +") and Status <> 'Removed'";  
ResultSet rstremoved1=stx.executeQuery(sql);
System.out.println("********  "+sql);
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
	<td style="text-align: right"><%=i%></td>
	<td style="text-align: left"><%=rstremoved1.getString("VehicleRegNumber") %></td>
	<td style="text-align: left"><%=rstremoved1.getString("vehtype") %></td>
	<td style="text-align: left">-</td>
	<td style="text-align: right">-</td>
	<td style="text-align: left">-</td>
	<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstremoved1.getDate("InstalledDate")) %></td>
	
	<td style="text-align: left"><div align="left">Device Installed But Not Active
<%
	if(fleetview.isUnitRemoved(rstremoved1.getString("VehicleCode")).equals("Yes"))
	{
		out.print("<font color='blue' size='2'> Device Removed</font>");
	}
	if(!("-".equalsIgnoreCase(specialcomment) || "Other".equalsIgnoreCase(specialcomment)) && !((null == specialcomment) || "NULL".equalsIgnoreCase(specialcomment)))
		out.print("<br><font size='2' color='blue'>"+specialcomment+"</font>");
	
	
	
%>
	</div></td>
	
	<td style="text-align: right">-</td>
	<td style="text-align: right">-</td>
	<td style="text-align: right"><%=rstremoved1.getString("MobilePhNo") %></td>
	
		
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

	<% fleetview.closeConnection();
	fleetview.closeConnection1();%>
	
	
	<%@ include file="footernew.jsp" %>
