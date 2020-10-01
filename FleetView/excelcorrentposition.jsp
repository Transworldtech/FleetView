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
Statement st,st1,stx,st2,stest,stmt1,sttemp;
String aa,regno,sq,searchveh,gp,tripid;
Object dateformat;
%>

<%
dateformat = session.getAttribute("dateformat").toString();

String tdx=request.getParameter("tdx");
//System.out.println("tdx====>"+tdx);



try{
	conn=fleetview.ReturnConnection();
	conn1=fleetview.ReturnConnection1();
	st=conn.createStatement();
	stx=conn.createStatement();
	st1=conn.createStatement();
	sttemp=conn.createStatement();
	st2=conn1.createStatement();
	
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
			<th colspan="2"> <b>Vehicle Reg.No.</b></th>
			<th colspan="2"> <b>Updated</b></th>
			<!-- ***************** new Column added************************** -->
			<th> <b>Transporter</b></th>
			<!-- ***************** end ************************** -->
			<%if(tdx.equals("hide"))
					{
					
					}
			else 
			{
				%>
			<th id="tdd0"> <b>Trip Id</b></th>
			<th colspan="3" id="tde0"><b>Driver Name(Code)</b></th>
			<th colspan="3" id="tda0"><b>Trip Origin</b></th>
			<th id="tdb0"><b>Start Date</b></th>
			<th colspan="3"id="tdc0"><b>Trip Destination</b></th>
			<%
				
			} //else end tdx=hide
			%>
			<th colspan="4"> <b>Location - Click To View On Map.</b></th>
			<th> <b>Ignition</b></th>
			<th> <b>Speed</b></th>
			<th> <b>OS Today</b></th>
			<th> <b>Distance Today</b></th>
			<th> <b>Distance This Month</b></th>
			<%if(tdx.equals("hide"))
					{
					
					}
			else
			{
				
				if(tdx.equals("show"))
						{
					
						}
				else
				{
					
					if(tdx.equals("hidefuel"))
					{
						
					}
					else
					{
						
					%>
			<th id="tdp0" style="display: none;"> <b>Previous Day Avg.</b></th>
			<th id="tdm0" style="display: none;"> <b>Avg. This Month</b></th>
			<th id="tdf0" style="display: none;"> <b>Fuel</b></th>
			<th id="tdl0" style="display: none;"> <b>Fuel Alert</b></th>
			<th id="tdy0" style="display: none;"> <b>Yesterday's Fuel Added</b></th>
			<th id="tdr0" style="display: none;"> <b>Day Shift Driver</b></th>
			<th id="tdn0" style="display: none;"> <b>Night Shift Driver</b></th>
			<%
					}	//else end tdx=hidefuel	
				}//else end tdx=show	
			}//else end tdx=hide
			%>
			<%
			//if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
			String sqlt= "select * from t_tempunitcust where Transporter = '"+session.getAttribute("usertypevalue").toString()+"'";
			//if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo")|| session.getAttribute("usertypevalue").toString().equals("Safe and Secure"))
			ResultSet rst1=sttemp.executeQuery(sqlt);
			if(rst1.next())
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
					<td colspan="2"><%=rst.getString("VehicleRegNo")%></td>
					<td><%="Blocked"%></td>
					<!-- *****************Changes done************************** -->
					<td><%=rst.getString("Transporter")%></td>
					<!-- ***************** end of Changes done************************** -->
					<td id="tdd<%=i%>">-</td>
					<td colspan="3" id="tde<%=i%>">-</td>
					<td colspan="3" id="tda<%=i%>">-</td>
					<td id="tdb<%=i%>">-</td>
					<td colspan="3" id="tdc<%=i%>">-</td>
					<td colspan="2"><%="Access denied for "+rst.getString("Transporter")%></td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td id="tdp<%=i%>" style="display: none;">-</td>
					<td id="tdm<%=i%>" style="display: none;">-</td>
					<td id="tdf<%=i%>" style="display: none;">-</td>
					<td id="tdl<%=i%>" style="display: none;">-</td>
					<td id="tdy<%=i%>" style="display: none;">-</td>
					<td id="tdr<%=i%>" style="display: none;">-</td>
					<td id="tdn<%=i%>" style="display: none;">-</td>
					<%
					//if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
					String sqlt2="select * from t_tempunitcust where Transporter = '"+session.getAttribute("usertypevalue").toString()+"'";
					ResultSet rstt2=sttemp.executeQuery(sqlt2);
					if(rstt2.next())
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
					<td style="<%=bgcolor %>" colspan="2">
					<%=rst.getString("VehicleRegNo")%> 
        			</td>
					<td style="<%=bgcolor %>" colspan="2">
					<%=new SimpleDateFormat(dateformat.toString()).format(rst.getDate("TheDate"))+" "+rst.getString("TheTime") %>
					</td>
					<%
					/***********************changes 8 sept 2010*******************/
					
					
					%><!-- *****************Changes done************************** -->
					<td style="<%=bgcolor %>"><%=rst.getString("Transporter") %></td>
					<!-- *****************end of Changes done************************** -->
					<%
					if(tdx.equals("hide"))
					{
						
					}
					else
					{
					ResultSet rsttrip=fleetview.isInTrip(rst.getString("VehicleCode"),session.getAttribute("TypeofUser").toString());
					if(rsttrip.next())
					{
					%>
					
					<td style="<%=bgcolor %>" id="tdd<%=i%>">
					<%=rsttrip.getString("TripId")%>  
        			</td>
					<td colspan="3" style="<%=bgcolor %>" id="tde<%=i%>"><div align="left"><%=rsttrip.getString("DriverName")+"("+rsttrip.getString("DriverCode")+")"%></div></td>
					<td colspan="3" style="<%=bgcolor %>" id="tda<%=i%>"><div align="left"><%=rsttrip.getString("StartPlace")%></div></td>
					<td style="<%=bgcolor %>" id="tdb<%=i%>">'<%=new SimpleDateFormat("dd-MMM-yyyy").format(rsttrip.getDate("StartDate"))%></td>
					<td colspan="3" style="<%=bgcolor %>" id="tdc<%=i%>"><div align="left"><%=rsttrip.getString("EndPlace")%></div></td>
					<%
					}
					else
					{
					%>
					<td style="<%=bgcolor %>" id="tdd<%=i%>"><--Enter</a></td>
					<td colspan="3" style="<%=bgcolor %>" id="tde<%=i%>">New</a></td>
					<td colspan="3" style="<%=bgcolor %>" id="tda<%=i%>">Trip</a></td>
					<td style="<%=bgcolor %>" id="tdb<%=i%>">Information</a></td>
					<td colspan="3" style="<%=bgcolor %>" id="tdc<%=i%>">Here --></a></td>
				
					<%
					}
					}//else end
					%>
					<td colspan="4" style="<%=bgcolor %>" ><div align="left"> 
					
					<%=rst.getString("Location") %> 
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
					if(tdx.equals("hide"))
					{
						
					}
					else
					{
						if(tdx.equals("show"))
						{
					
						}
				else
				{
					if(tdx.equals("hidefuel"))
					{
						
					}
					else
					{
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
					<td style="display: none; <%=bgcolor %>" id="tdp<%=i%>"><%= rst.getString("LastDayAVG")%></td>
					<td style="display: none; <%=bgcolor %>" id="tdm<%=i%>"><%= rst.getString("LastMonthAVG") %></td>
					<td style="display: none; <%=bgcolor %>" id="tdf<%=i%>">
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
					<td style="display: none; <%=bgcolor %>" id="tdl<%=i%>"><%=ftcount%></td>
					<td style="display: none; <%=bgcolor %>" id="tdy<%=i%>"><%=facnt%></td>
					
					<%	
						String sql20="select * from t_drivervehicles where vehcode like '"+vcode+"'";
						ResultSet rs20=st1.executeQuery(sql20);
						if(rs20.next())
						{
					%>
						<td style="display: none; <%=bgcolor %>" id="tdr<%=i%>" align="center"><%=rs20.getString("DayshiftDriver")%>  (<%=rs20.getString("Mob1")%>)</td>
						<td style="display: none; <%=bgcolor %>" id="tdn<%=i%>" align="center"><%=rs20.getString("NightshiftDriver")%>  (<%=rs20.getString("Mob2")%>)</td>				
					<%		
						}
						else
						{	
					%>	
					<td style="display: none; <%=bgcolor %>" id="tdr<%=i%>">-</td>
					<td style="display: none; <%=bgcolor %>" id="tdn<%=i%>">-</td>			
					<%
						}
								
			}
			else
			{
			%>
				<td style="display: none; <%=bgcolor %>" id="tdp<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdm<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdf<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdl<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdy<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdr<%=i%>">NA</td>
				<td style="display: none; <%=bgcolor %>" id="tdn<%=i%>">NA</td>
			<%
			}
					}//else end tdx=hidefuel
				}	//else end tdx=show
					}//else end tdx=hide
			%>
			<%
				//if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
				String sqlt3="select * from t_tempunitcust where Transporter = '"+session.getAttribute("usertypevalue").toString()+"'";
			    //System.out.println(sqlt3);
				ResultSet rstt3=sttemp.executeQuery(sqlt3);
				if(rstt3.next())
				{
					//System.out.println("Aa gaya");
					//System.out.println("code"+rst.getString("VehicleCode"));
					ResultSet rsttemp=fleetview.getTempValue(rst.getString("VehicleCode"));					
					if(rsttemp.next())
					{
			%>
					<td style="<%=bgcolor %>">
			<%
					try
					{
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
					try
					{
						out.print("xxxx");
					}
					catch(Exception e2)
					{
					}
				}
 			%>
				</td>
				<td style="<%=bgcolor %>">
			<%
				try
				{
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
					try
					{
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
ResultSet rstremoved1=stx.executeQuery(sql);
while(rstremoved1.next())
{
	String vcode=rstremoved1.getString("VehicleCode");
	i++;
%>
<tr>
	<td><%=i%></td>
	<td colspan="2"><%=rstremoved1.getString("VehicleRegNumber") %></td>
	<td colspan="2"><%=new SimpleDateFormat(dateformat.toString()).format(rstremoved1.getDate("InstalledDate")) %></td>
	<!-- *****************Changes done************************** -->
	<td><%=rstremoved1.getString("OwnerName") %></td>
	<!-- ***************** end of Changes done************************** -->
	<%
	if(tdx.equals("hide"))
	{
	}
	else
	{
		%>
	<td id="tdd<%=i%>">-</td>
	<td colspan="3" id="tde<%=i%>">-</td>
	<td colspan="3" id="tda<%=i%>">-</td>
	<td id="tdb<%=i%>">-</td>
	<td colspan="3" id="tdc<%=i%>">-</td>
	<%
	}//else end tdx=hide
	%>
	<td colspan="4"><div align="left">Device Installed But Not Active
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
	<td style="display: none;" id="tdp<%=i%>">-</td>
	<td style="display: none;" id="tdm<%=i%>">-</td>
	<%
	if(tdx.equals("hide"))
	{
		
	}
	else
	{
		if(tdx.equals("show"))
		{
			
		}
		else
		{
			if(tdx.equals("hidefuel"))
			{
				
			}
			else
			{
	%>
	<td style="display: none;" id="tdf<%=i%>">-</td>
	<td style="display: none;" id="tdl<%=i%>">-</td>
	<td style="display: none;" id="tdy<%=i%>">-</td>
	
	
<%
	String sql20="select * from t_drivervehicles where vehcode like '"+vcode+"'";
	ResultSet rs20=st1.executeQuery(sql20);
	if(rs20.next())
	{
%>
		<td class="hed" align="center" style="display: none;" id="tdr<%=i%>"><%=rs20.getString("DayshiftDriver")%> (<%=rs20.getString("Mob1")%>)</td>
		<td class="hed" align="center" style="display: none;" id="tdn<%=i%>"><%=rs20.getString("NightshiftDriver")%> (<%=rs20.getString("Mob2")%>)</td>			
<%		
	}
	else
	{	
%>	
		<td class="hed" align="center" style="display: none;" id="tdr<%=i%>">-</td>
		<td class="hed" align="center" style="display: none;" id="tdn<%=i%>">-</td>			
<%
	}
	
%>
<%
	//if(session.getAttribute("usertypevalue").toString().equals("Foodland")||session.getAttribute("usertypevalue").toString().equals("tempdemo"))
	String sqlt1="select * from t_tempunitcust where Transporter = '"+session.getAttribute("usertypevalue").toString()+"'";
	ResultSet rstt1=sttemp.executeQuery(sqlt1);
	if(rstt1.next())
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
			}//else end tdx=hidefuel
	} //else end tdx=show
	} //else end tdx=hide
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
	}finally
	{
		try{
			 fleetview.closeConnection();
		}catch(Exception e)
		{}
		try{
		fleetview.closeConnection1();
		}catch(Exception e)
		{}
	}
	%>

	<% //fleetview.closeConnection();
	//fleetview.closeConnection1();%>
	
	</jsp:useBean>
	<%@ include file="footernew.jsp" %>
