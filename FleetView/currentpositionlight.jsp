<%@ include file="headernewlight.jsp"%>
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
//*********************Code for Hide Fuel INfo Button***********************************************************
function showhide2()
{
	var cnt=document.getElementById("cnt").value;
	//alert("Hi Atul !"+cnt);
	var tdp, tdm,tdf,tdl,tdy,tdr,tdn;
	var tds=document.getElementById("tds").value;
	
	if(tds=="Hide Fuel Info")
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tdp=document.getElementById("tdp"+i);
			tdp.style.display='none';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='none';
			tdf=document.getElementById("tdf"+i);
			tdf.style.display='none';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='none';
			tdy=document.getElementById("tdy"+i);
			tdy.style.display='none';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='none';
			tdn=document.getElementById("tdn"+i);
			tdn.style.display='none';
			document.getElementById("tds").value="Show Fuel Info";
		}
	}
	else
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tdp=document.getElementById("tdp"+i);
			tdp.style.display='';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='';
			tdf=document.getElementById("tdf"+i);
			tdf.style.display='';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='';
			tdy=document.getElementById("tdy"+i);
			tdy.style.display='';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='';
			tdn=document.getElementById("tdn"+i);
			tdn.style.display='';
			document.getElementById("tds").value="Hide Fuel Info";
		}
	}
}
//*************************************End of Hide Fuel INfo Button**********************************************
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
	Statement st,st1,stx,st2;
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
	//out.print(session.getAttribute("VehList").toString());
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
	
	<!-- *************************************Modifications done *************************************************-->
	<!-- The following four rows are excluded -->
	
		<!--<tr><td><font color="red" size="2"><B> Kind Attention : Due to server maintainance the website will be unavailable from 06.30 p.m to 08.00 p.m. on 23rd Jan 2010. Sorry for the inconvenience. </blink></I> </B> 
		</font>		</td></tr>-->
		<!-- 
		<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 
		<a href="imeimessage.jsp">
		<font color="lightred" size="2"><B> <I> <blink>IMPORTANT NOTICE: IMEI NUMBER </blink></I> </B> 
		</font>	
			</td></tr>
		<tr><td>
		<blink>
		<font color="maroon" size="3"><B> <I> Note: </I> </B>Please upload Fuel Fill-Up data for all Vehicles to get correct average. Click <a href="fuelentry.jsp"> Here </a> to insert Fuel data.  </font>
		
		</blink>
		</td></tr>
		 -->
	<!-- ********************************end of modifications done*************************************************** -->
		<tr><td>
		<font color="green" size="3"><B> <I> Note: </I> </B>Please Click <a href="#" onclick="javascript:window.open('generateSecurityCode.jsp','','menubar=1,resizable=1,width=550,height=350,location=no');"> Here </a> to generate your security code for login.</font>
		
		</td></tr>
		
		
		
			 
		 
	<tr><td>
	<table width="100%" border="0">
			<tr>
			<td align="right" class="bodyText">
		<!-- ************************Row is excluded**********************-->
			<!-- 
			<a href="onlinedata.jsp" title="Slow Process" id="blinking">Click To View All Vehicle On Map.</a>
			 -->
	  <!-- ******************end of modification************************** -->
	 
			</td>
			<td align="right" class="bodyText">
			&nbsp;
			</td>
			<td align="right" class="bodyText">
			<form method="get" name="searchhi">
			<!-- 
			<input type="text" name="h" class="formElement"/>
			<input type="submit" value="Search Any Text!" class="formElement"/>
			 -->
			 &nbsp;&nbsp;
			&nbsp;&nbsp;
			<a href="#" onclick="javascript:window.open('printcurrentpositionlite.jsp');" title="Print Current Position Report">
			<img src="images/print.jpg" width="15px" height="15px">
			</a>&nbsp; &nbsp; 
			<a href="excelcurrentpositionlite.jsp"  title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px">
			</a>
			&nbsp;&nbsp;
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
		<td class="sorttable_nosort"><b class="bodyText">Color Code Indications :<a href="currentpositionlight.jsp"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Full Fleet</b></a></td>
		<td bgcolor="#CCFFCC" class="sorttable_nosort"><b>Moving</b></td>
		<td bgcolor="#FFFFCC" class="sorttable_nosort" ><b>Stop</b></td>
		<td bgcolor="#DCDCDC" class="sorttable_nosort"><b>Disconnected</b></td>
		<td bgcolor="#BDEDFF" class="sorttable_nosort"><b>Removed</b></td>
		<td bgcolor="#FFFFFF" class="sorttable_nosort"><b>Not Active</b>
		</tr>

		</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Vehicle Reg.No.</b></th>
			
			<th> <b>Updated</b></th>
			<!-- ***************** new Column added************************** -->
			<th> <b>Transporter</b></th>
			<!-- ***************** end ************************** -->
			
			<th> <b>Location - Click To View On Map.</b></th>
			<th> <b>Ignition</b></th>
			<th> <b>Speed</b></th>
			<th> <b>OS Today</b></th>
			<th> <b>Distance Today</b></th>
			<th> <b>Distance This Month</b></th>
			<!-- *****************Changes done************************** -->
			<th id="tdp0" style="display: none;"> <b>Previous Day Avg.</b></th>
			<th id="tdm0" style="display: none;"> <b>Avg. This Month</b></th>
			<th id="tdf0" style="display: none;"> <b>Fuel</b></th>
			<th id="tdl0" style="display: none;"> <b>Fuel Alert</b></th>
			<th id="tdy0" style="display: none;"> <b>Yesterday's Fuel Added</b></th>
			<th id="tdr0" style="display: none;"> <b>Day Shift Driver</b></th>
			<th id="tdn0" style="display: none;"> <b>Night Shift Driver</b></th>
			<!-- *********************End of changes done******************* -->
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
			final String  VehList1=session.getAttribute("VehList").toString();
			String sql="select * from t_onlinedata where vehiclecode in "+ VehList1 +" order by concat(TheDate,TheTime) desc";
			ResultSet rst=st.executeQuery(sql);
			int i=0;
			while(rst.next())
			{
				i++;
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
					<td><%="Blocked"%></td>
					<!-- *****************Changes done************************** -->
					<td><%=rst.getString("Transporter")%></td>
					<!-- ***************** end of Changes done************************** -->
					<td><%="Access denied for "+rst.getString("Transporter")%></td>
					
					<!-- *********************Changes done**************************** -->
					<td id="tdp<%=i%>" style="display: none;">-</td>
					<td id="tdm<%=i%>" style="display: none;">-</td>
					<td id="tdf<%=i%>" style="display: none;">-</td>
					<td id="tdl<%=i%>" style="display: none;">-</td>
					<td id="tdy<%=i%>" style="display: none;">-</td>
					<td id="tdr<%=i%>" style="display: none;">-</td>
					<td id="tdn<%=i%>" style="display: none;">-</td>
					<!-- ***********************End of changes done********************* -->
					<%
					if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
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
					<%=rst.getString("VehicleRegNo")%> 
        		
					</td>
					<td style="<%=bgcolor %>">
					<%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
					</td>
					<!-- *****************Changes done************************** -->
					<td style="<%=bgcolor %>"><%=rst.getString("Transporter") %></td>
					<!-- *****************end of Changes done************************** -->
					
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
					</div> 
					</td>
					<td style="<%=bgcolor %>">
					<%
							out.print(igni);
					
					%>
					</td>
					<td style="<%=bgcolor %>"><div align="right"><%=rst.getInt("TheSpeed") %></div></td>
					<td style="<%=bgcolor %>"><div align="right">
					<% 
					if(ostoday >0)
					{
						%>
						<%=ostoday %>
						<%
					}
					else
					{
						out.print(ostoday);
					}
					
					%>
					</div></td>
					<td style="<%=bgcolor %>"><div align="right"><%=kmtoday %></div></td>
					<td style="<%=bgcolor %>"><div align="right"><%=kmthismonth %></div></td>
								
					<% 
					if(fleetview.getUnitDescription(rst.getString("VehicleCode")).equals("FUELFLOW"))
					{ 	
						java.util.Date lastday=new java.util.Date();
						long todaymils=lastday.getTime();
						long oneday=1000*60*60*24;
						todaymils=todaymils-oneday;
						lastday.setTime(todaymils);
						String daybefor=new SimpleDateFormat("yyyy-MM-dd").format(lastday);
						String firstday=daybefor.substring(0,8)+"01";
					%>
					<!-- *********************Changes done**************************************** -->
					<td style="display: none; <%=bgcolor %>" id="tdp<%=i%>"><%= rst.getString("LastDayAVG")%></td>
					<td style="display: none; <%=bgcolor %>" id="tdm<%=i%>"><%= rst.getString("LastMonthAVG") %></td>
					<td style="display: none; <%=bgcolor %>" id="tdf<%=i%>">
					<!-- *********************end Changes done**************************************** -->
					<%
					//fleetview.getFuelLevel(rst.getString("VehicleCode"),i) 
					if(rst.getString("LastDayAVG").equals("NC"))
					{
						out.print("Not Calibrated");
					}
					else
					{
						if(!((fuelvalue.equals("NA")) ||(fuelvalue.equals("0"))))
						{
							String str="<div id=\"showbar"+i+"\" style=\"font-size:6pt;padding:1px;border:solid black 1px;visibility:hidden\"> <span id=\"progressA"+i+"\">&nbsp;</span><span id=\"progressB"+i+"\">&nbsp;</span><span id=\"progressC"+i+"\">&nbsp;</span><span id=\"progressD"+i+"\">&nbsp;</span><span id=\"progressE"+i+"\">&nbsp;</span><span id=\"progressF"+i+"\">&nbsp;</span><span id=\"progressG"+i+"\">&nbsp;</span><span id=\"progressH"+i+"\">&nbsp;</span><span id=\"progressI"+i+"\">&nbsp;</span><span id=\"progressJ"+i+"\">&nbsp;</span><span id=\"progressK"+i+"\">&nbsp;</span><span id=\"progressL"+i+"\">&nbsp;</span><span id=\"progressM"+i+"\">&nbsp;</span><span id=\"progressN"+i+"\">&nbsp;</span><span id=\"progressO"+i+"\">&nbsp;</span><span id=\"progressP"+i+"\">&nbsp;</span><span id=\"progressQ"+i+"\">&nbsp;</span><span id=\"progressR"+i+"\">&nbsp;</span><span id=\"progressS"+i+"\">&nbsp;</span><span id=\"progressT"+i+"\">&nbsp;</span></div>";
							String str1="";
							if(Integer.parseInt(fuelvalue) > ax && Integer.parseInt(fuelvalue)<=bx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >bx && Integer.parseInt(fuelvalue)<=cx)
							{	
							str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >cx && Integer.parseInt(fuelvalue)<=dx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >dx && Integer.parseInt(fuelvalue)<=ex)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >ex && Integer.parseInt(fuelvalue)<=fx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >fx && Integer.parseInt(fuelvalue)<=gx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >gx && Integer.parseInt(fuelvalue)<=hx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >hx && Integer.parseInt(fuelvalue)<=ix)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >ix && Integer.parseInt(fuelvalue)<=jx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >jx && Integer.parseInt(fuelvalue)<=kx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >kx && Integer.parseInt(fuelvalue)<=lx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >lx && Integer.parseInt(fuelvalue)<=mx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >mx && Integer.parseInt(fuelvalue)<=nx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >nx && Integer.parseInt(fuelvalue)<=ox)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >ox && Integer.parseInt(fuelvalue)<=px)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >px && Integer.parseInt(fuelvalue)<=qx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >qx && Integer.parseInt(fuelvalue)<=rx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >rx && Integer.parseInt(fuelvalue)<=sx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressR"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) >sx && Integer.parseInt(fuelvalue)<=tx)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressR"+i+"').style.backgroundColor = progressColor;document.getElementById('progressS"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(Integer.parseInt(fuelvalue) > tx && Integer.parseInt(fuelvalue)<= ux)
							{
								str1="<script language=\"javascript\">var progressColor = 'blue';document.getElementById('showbar"+i+"').style.visibility = 'visible';document.getElementById('progressA"+i+"').style.backgroundColor = progressColor;document.getElementById('progressB"+i+"').style.backgroundColor = progressColor;document.getElementById('progressC"+i+"').style.backgroundColor = progressColor;document.getElementById('progressD"+i+"').style.backgroundColor = progressColor;document.getElementById('progressE"+i+"').style.backgroundColor = progressColor;document.getElementById('progressF"+i+"').style.backgroundColor = progressColor; document.getElementById('progressG"+i+"').style.backgroundColor = progressColor;document.getElementById('progressH"+i+"').style.backgroundColor = progressColor;document.getElementById('progressI"+i+"').style.backgroundColor = progressColor;document.getElementById('progressJ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressK"+i+"').style.backgroundColor = progressColor;document.getElementById('progressL"+i+"').style.backgroundColor = progressColor;document.getElementById('progressM"+i+"').style.backgroundColor = progressColor;document.getElementById('progressN"+i+"').style.backgroundColor = progressColor;document.getElementById('progressO"+i+"').style.backgroundColor = progressColor;document.getElementById('progressP"+i+"').style.backgroundColor = progressColor;document.getElementById('progressQ"+i+"').style.backgroundColor = progressColor;document.getElementById('progressR"+i+"').style.backgroundColor = progressColor;document.getElementById('progressS"+i+"').style.backgroundColor = progressColor;document.getElementById('progressT"+i+"').style.backgroundColor = progressColor;</script>";
							}
							if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
							{
							fuelvalue=fuelvalue +" Gal"+str +str1;
							}
							else
							{
								fuelvalue=fuelvalue +" ltr"+str +str1;
							}
						}
						out.print(fuelvalue);
					}
					%>
					</td> 
					<%
					String yesdate="",facnt="",ftcount="";
					String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
					String today2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
					try{
					String sql3="select DATE_ADD('"+today+"',INTERVAL -1 DAY) as newdate";
					ResultSet rs3= st1.executeQuery(sql3);
					if(rs3.next())
					{  
						yesdate=rs3.getString("newdate");
					}
					}catch (Exception e) {
						System.out.print("Exception--->"+e);
					}
					try{
						String sql16="select count(*) as ftcount from t_vehft where vehcode like '"+vcode+"' and Thedate>='"+today+"' and TheDate <='"+today+"' order by concat(TheDate,TheTime) desc";
						ResultSet rs16= st2.executeQuery(sql16);
						if(rs16.next())
						{  
							ftcount=rs16.getString("ftcount");
						}
						}catch (Exception e) {
							System.out.print("Exception--->"+e);
						}
					try{
						String sql4="select count(*) as fcnt from t_vehfa where vehcode like '"+vcode+"' and Thedate>='"+yesdate+"' and TheDate <='"+yesdate+"' order by concat(TheDate,TheTime) desc";
						ResultSet rs4= st2.executeQuery(sql4);
						if(rs4.next())
						{  
							facnt=rs4.getString("fcnt");
						}
						}catch (Exception e) {
							System.out.print("Exception--->"+e);
						}
						//out.print(facnt);
					String today1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(yesdate));
					%>
					<!-- *********************Changes done**************************************** -->
					<td style="display: none; <%=bgcolor %>" id="tdl<%=i%>"><a href="showfuelalert.jsp?vehcode=<%=vcode%>&data=<%=today2%>&data1=<%=today2%>"><%=ftcount%></a></td>
					<td style="display: none; <%=bgcolor %>" id="tdy<%=i%>"><a href="showfueladd.jsp?vehcode=<%=vcode%>&data=<%=today1%>&data1=<%=today1%>"><%=facnt%></a></td>
					<!-- *********************end of Changes done**************************************** -->
					<%	
						String sql20="select * from t_drivervehicles where vehcode like '"+vcode+"'";
						ResultSet rs20=st1.executeQuery(sql20);
						if(rs20.next())
						{
					%>
					<!-- *********************Changes done**************************************** -->
						<td style="display: none; <%=bgcolor %>" align="center" id="tdr<%=i%>"><%=rs20.getString("DayshiftDriver")%>  (<%=rs20.getString("Mob1")%>)</td>
						<td style="display: none; <%=bgcolor %>" align="center" id="tdn<%=i%>"><%=rs20.getString("NightshiftDriver")%>  (<%=rs20.getString("Mob2")%>)</td>
						<!-- *********************end of Changes done**************************************** -->				
					<%		
						}
						else
						{	
					%>	
					<!-- *********************Changes done**************************************** -->
					<td style="display: none; <%=bgcolor %>" id="tdr<%=i%>">-</td>
					<td style="display: none; <%=bgcolor %>" id="tdn<%=i%>">-</td>			
					<!-- *********************end of Changes done**************************************** -->
					<%
						}
								
			}
			else
			{
			%>
			<!-- *********************Changes done**************************************** -->
				<td style="display: none; <%=bgcolor %>" id="tdp<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdm<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdf<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdl<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdy<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdr<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdn<%=i%>">NA</td>
				<!-- *********************end of Changes done**************************************** -->
			<%
			}
			%>
			
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
%>
<tr>
	<td><%=i%></td>
	<td><%=rstremoved1.getString("VehicleRegNumber") %></td>
	<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rstremoved1.getDate("InstalledDate")) %></td>
	<!-- *****************Changes done************************** -->
	<td><%=rstremoved1.getString("OwnerName") %></td>
	<!-- ***************** end of Changes done************************** -->
	
	<td><div align="left">Device Installed But Not Active
<%
	if(fleetview.isUnitRemoved(rstremoved1.getString("VehicleCode")).equals("Yes"))
	{
		out.print("<font color='blue' size='2'> Device Removed</font>");
	}
%>
	</div></td>
	<td>-</td>
	<td>-</td>
	<td>-</td>
	<!-- *********************Changes done**************************************** -->
	<td style="display: none;" id="tdp<%=i%>">-</td>
	<td style="display: none;" id="tdm<%=i%>">-</td>
	<td style="display: none;" id="tdf<%=i%>">-</td>
	<td style="display: none;" id="tdl<%=i%>">-</td>
	<td style="display: none;" id="tdy<%=i%>">-</td>
	<!-- *********************end of Changes done**************************************** -->
	
<%
	String sql20="select * from t_drivervehicles where vehcode like '"+vcode+"'";
	ResultSet rs20=st1.executeQuery(sql20);
	if(rs20.next())
	{
%>
<!-- *********************Changes done**************************************** -->
		<td class="hed" align="center" style="display: none;" id="tdr<%=i%>"><%=rs20.getString("DayshiftDriver")%> (<%=rs20.getString("Mob1")%>)</td>
		<td class="hed" align="center" style="display: none;" id="tdn<%=i%>"><%=rs20.getString("NightshiftDriver")%> (<%=rs20.getString("Mob2")%>)</td>
		<!-- *********************end of Changes done**************************************** -->			
<%		
	}
	else
	{	
%>	
<!-- *********************Changes done**************************************** -->
		<td class="hed" align="center" style="display: none;" id="tdr<%=i%>">-</td>
		<td class="hed" align="center" style="display: none;" id="tdn<%=i%>">-</td>
		<!-- *********************end of Changes done**************************************** -->			
<%
	}
%>
<%
	if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
	{
%>
		<td class="hed" align="center">xxxx</td>
		<td class="hed" align="center">xxxx</td>
		<td class="hed" align="center">xxxx</td>
		<td class="hed" align="center">xxxx</td>
<%
	}
%>
		<td class="hed" align="center">-</td>
		<td class="hed" align="center">-</td>	
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
