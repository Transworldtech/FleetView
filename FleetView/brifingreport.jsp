<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>Vehicle Tracking System</title>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/erratic.css" rel="StyleSheet" type="text/css">
</head>
<body>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td width="1%" height="2"><img src="images/fboxtopleft.gif" width="20" height="12" alt="bk"/></td>
          <td class="fboxtop"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" height="2"><img src="images/fboxtopright.gif" width="20" height="12" alt="bk"/></td>
        </tr>
        <tr>
          <td width="1%" class="fboxleft"><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>

          <td width="98%" class="featureboxbg">
          <table border="0" align="left" width="100%">
<tr>
<td>
<!-- unit logo comes here --->
<div align="left">
<img src="images/Transworld.jpeg"  border="0">
</div>
<!-- unit logo comes here --->
<div align="right">Date: <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div></td>
</tr>
</table>
			<!-- header file -->
			<%@ include file="Connections/conn.jsp" %>       
         <!-- header file -->
          </td>
          <td width="1%" class="fboxright" ><img src="images/spacer.gif" width="2" height="2" alt=" "/></td>
        </tr>
        <tr>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleleft.gif" width="20" height="5" alt="bk" /></td>
          <td width="98%" class="fboxmiddle"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
          <td width="1%" class="featureboxbg"><img src="images/fboxmiddleright.gif" width="20" height="5" alt="bk" /></td>
        </tr>

        <tr>
          <td class="fboxlowleft">&nbsp;</td>
          <td>
			<!-- body part come here -->
			<%!
			Connection conn;
			Statement st, st1;
			String briefid="",driverid="",sql;
			%>
			<%
			briefid=request.getParameter("briefid");
			driverid=request.getParameter("driverid");
			try
			{
				Class.forName(MM_dbConn_DRIVER);
				conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
				st=conn.createStatement();
				if(!(null==briefid))
				{
				 sql="select * from t_briefing where briefid='"+briefid+"'";
				}
				else
				{
					sql="select * from t_briefing where driverid='"+driverid+"' order by brifdate desc limit 1";	
				}
				ResultSet rst=st.executeQuery(sql);
				if(rst.next())
				{
					%>
			<table width="100%" align="center" class="sortable">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Briefing Report of <%=rst.getString("DriverName") %> on <%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("brifdate")) %></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" id="table1" class="sortable">
			<tr><td align="left"><font size="2"><div align="left"> Briefing Id :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("briefid") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Brifing Date-Time :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("brifdate") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver Name (Id) :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("DriverId") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Trainer Name :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("TrainerName") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Trip Class :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("tripclass") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Trip ID :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("tripid") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Training Input Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("traininpcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Passport Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("passportcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Last Training Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("lasttrngcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Training Due Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("Trainduecomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Training Status Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("Trngstatuscomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Training Medical Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("trngmedicomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">GPS Captured :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("gpscaptured") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">GPS Service Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("GpsServicecomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">GPS ReActivation Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("GpsReactcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">GPS Replacement Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("gpsreplacecomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">GPS Obs. Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("gpasobscomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh Familiarization Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehfamicomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver License Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehdrivlicencomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Check-Up Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehcheckcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Check-Light Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehchecklightcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Check Inst. :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehcheckinstrucomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Tyre Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehchecktyrecomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Break Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehcheckBreakcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Seat-Belt Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehcheckSeatcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Reflector Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehcheckreflectcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Tool-Box Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vehchecktoolcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. OverAll Cond. Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("vcheckoveralcondcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Route Familiarization Comment :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("RootFamcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver Mental Cond. :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("Mentalcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver General Appearance :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("mentgenappcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver Mental Injury :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("Mentenjurycomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver Mental Stretch :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("MentStrechcomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Driver Medical Cond. :</div></font></td>
			<td align="left"><div align="left"><%=rst.getString("Mentmedicomm") %></div></td></tr>
			<tr><td align="left"><font size="2"><div align="left">Veh. Check-Light Comment :</div></font></td>
			<td align="left"><div align="left"><%="-" %></div></td></tr>
			
			</table>
			<!-- body part come here -->
				<%

				}
			}catch(Exception e)
			{
				out.print("Exception --->"+e);
			}
			
			%>
			</td>
    <td class="fboxlowright">&nbsp;</td>
    
    <tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>
    </table>
      <%@ include file="footernew.jsp" %>
    </body>
</html>