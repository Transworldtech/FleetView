<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%@ include file="header.jsp" %>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,stmtnew;
String sql,sql1,driverid="",drivername="";
String vehfam="",vehfamcom="",routefam="",routefamcom="",mentcon="", mentconcom="",JRM="",JRMcom="",DirerRes="",DriverResCom="",Debrifingcom="",rid="";
String brifTrinerName="", drvMobNo="", drvLicnNo="",deBrifTrinerName="", spInst = "", drLicRd = "", drLicCmnt = "";
String debrfTrainerNm = "";

%>
<%
 vehfam="NA";
 vehfamcom="NA";
 routefam="NA";
 routefamcom="NA";
 mentcon="NA";
 mentconcom="NA";
 JRM="NA";
 JRMcom="NA";
 DirerRes="NA";
 DriverResCom="NA";
 Debrifingcom="NA";
 rid="NA";
 brifTrinerName="NA";
 drvMobNo="";
 drvLicnNo="NA";
 deBrifTrinerName="NA";
 spInst ="NA";
 drLicRd ="NA";
 drLicCmnt ="NA";
 debrfTrainerNm = "NA";
 driverid=request.getParameter("driverid");
drivername=request.getParameter("drivername");
String trans=request.getParameter("trans");
String briefId = "";
debrfTrainerNm = (String) session.getAttribute("user");
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	stmtnew=conn.createStatement();
	sql="select * from t_driverbriefingquest where driverid='"+driverid+"' and BriefingStatus = 'Incomplete' order by EntDateTime desc ";
	System.out.println("sql::"+sql);
   ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehfam=rst.getString("VehFamiliare");
		vehfamcom=rst.getString("VehFamiliareObs");
		routefam=rst.getString("RouteFamiliare");
		routefamcom=rst.getString("RouteFamiliareObs");
		mentcon=rst.getString("MentalPhysCond");
		mentconcom=rst.getString("MentalPhysCondObs");
		JRM=rst.getString("JRMBriefed");
		JRMcom=rst.getString("JRMBriefedObs");
		DirerRes=rst.getString("DriverRespObs");
		rid=rst.getString("SrNo");
      drvLicnNo = rst.getString("DrvLicNo");
      brifTrinerName = rst.getString("BriefingTrainer");
      drvMobNo = rst.getString("DrvMobNo");
      spInst = rst.getString("SpecialInst");
      briefId = rst.getString("SrNo");
      if(drvLicnNo.equals("-")||drvLicnNo.equals("")){
      drLicRd = "No";
      }
      else
      {
      drLicRd = "Yes";
      }
      drLicCmnt = rst.getString("drvLicCmnt");
      }
     %>
		<script language="javascript">
		function toggleDetails(id, show)
		{
   		var popup = document.getElementById("popup"+id);
       	if (show) 
       	{
				popup.style.visibility = "visible";
				popup.setfocus();
			}
			else
			{
				popup.style.visibility = "hidden";
			}
		}
	function newwindow(webadd)
	{ 
  		window.open(webadd,'jav','width=400,height=200,resizable=yes');
	} 

	function validate()
	{
      var mobNo = document.shDrivDeBrif.deBrifMobNo.value;
      if(mobNo.length == 0 )
		{
			alert("Please enter mobile No.");
			return false;
		}
      if(document.shDrivDeBrif.gpsData[0].checked==false && document.shDrivDeBrif.gpsData[1].checked==false)
		{
			alert("Please click Yes/No for GPS Data.");
			return false;
		}
      if(document.shDrivDeBrif.tranDelay[0].checked==false && document.shDrivDeBrif.tranDelay[1].checked==false)
		{
			alert("Please click Yes/No for Transition Delay.");
			return false;
		}	
      if(document.shDrivDeBrif.shortages[0].checked==false && document.shDrivDeBrif.shortages[1].checked==false)
		{
			alert("Please click Yes/No for Shortages.");
			return false;
		}	
      if(document.shDrivDeBrif.rtDeviation[0].checked==false && document.shDrivDeBrif.rtDeviation[1].checked==false)
		{
			alert("Please click Yes/No for Route Deviation.");
			return false;
		}	
	return true;
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
	<table border="1" width="100%" bgcolor="white">
	<tr>
	<td>
	<div align="left">  <a href="javascript:history.go(-1)"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a>
	<div align="center"> <font color="maroon" size="2"> <B> Driver De-Briefing Report</B> </font> </div> </td>
</tr>
<tr><td>
	<table border="0" width="100%" bgcolor="WHITE">
   <tr>
   <td>Transit Delay:</td><td> If the driver took more days to cover the trip then trainer can enter Yes to Transit Delay and in comment he can enter the no of days delayed.</td>
   </tr>
	<tr>
   <td> GPS Data:</td> <td>When data for last trip is shown on Map trainer can chek whether there is any gap, or data loss or latest Location of vehicle is not in proper location if he finds any thing he can select no  from GPS Data and add comment to it.</td>
 	</tr>
	</table>	
	<table border="1" width="100%" align="center" bgcolor="white">
	<tr><td valign="top" width="35%">
	<form action="debriefinsert.jsp" method="get" name="shDrivDeBrif" onSubmit="return validate();" >
	<input type="hidden" name="rid" value="<%=rid%>">
		<table class="stats" border="1" width="100%" valign="top">
      <tr>
      <td colspan="2" class="hed"> <B> <%=drivername%> of <%=trans%> </B> <br>
      <a href="#" onclick="javascript:window.open('brif_driverbrifsum.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );" > click here   </a>to see brief history
      </td>
      <input type="hidden" name="drvrname" class="formElement" value="<%=drivername%>" />
 		</td>
		</tr>
      <tr>
      <td> Driver Id: &nbsp;&nbsp;&nbsp; <%=driverid%>
      <input type="hidden" name="drvrid" class="formElement" value="<%=driverid%>" readonly/>   
      </td>
      <td> Passport No:  </td>
      </tr>
      <tr>
      <td> Joined on:</td>
      <td> Training Date: </td>
      </tr>   
      <tr>
      <td> Training Details </td>
      <td><a href="briefing/trininginfo.jsp?driverid=<%=driverid%>" onclick="popWin = open('briefing/trininginfo.jsp?driverid=<%=driverid%>','myWin','width=500,height=900');popWin.focus();return false" >Show Training Info</a>
      </td>
      </tr>   
      </table>
		<table width="100%" class="stats" border="1">
		<tr><td colspan="6" class="hed"><font color="brown" size="2">Driver De-briefing Report</font></td></tr>
	   </tr>
   	<tr>
		<td><b><div align="left"> Vehicle Familiarization</div></b></td>
		<td><div align="left"> <%=vehfam%></div></td>
		<td><div align="left"> <%=vehfamcom%></div></td>
		</tr>
		<tr>
		<td><b><div align="left"> Route Familiarization</div></b></td>
		<td><div align="left"> <%=routefam%></div></td>
		<td><div align="left"> <%=routefamcom%></div></td>
		</tr>
		<tr>
		<td><b><div align="left"> Mental / Physical Condition</div></b></td>
		<td><div align="left"> <%=mentcon%></div></td>
		<td><div align="left"><%=mentconcom%> </div></td>
		</tr>
		<tr>
		<td><b><div align="left"> JRM Briefed</div></b></td>
		<td><div align="left"> <%=JRM%></div></td>
		<td><div align="left"><%=JRMcom%> </div></td>
		</tr>
		<tr>
		<td><b><div align="left"> Driver License</div></b></td>
		<td><div align="left"> <%= drLicRd %></div></td>
		<td><div align="left"><%= drLicCmnt %> </div></td>
		</tr>
		<tr>
		<td><b><div align="left"> Driver Response</div></b></td>
		<td colspan="2"><div align="left"><%=DirerRes%> </div></td>
		</tr>
		<tr>	
		<td> <b><div align="left"> Special Instructions </div></b>
		</td>
		<td colspan="2"><div align="left">
		<%= spInst %>   </div>
		</td>
		</tr>
		<tr>	
		<td><b><div align="left"> Briefing Trainer Name </div></b>
		</td>
		<td colspan="2"  ><div align="left" > <%= brifTrinerName%> </div>
		</td>
		</tr>
		<tr>
		<td><b><div align="left"> GPS Data </div></b></td>
		<td> <input type="radio" name="gpsData" value="Yes" "checked"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="gpsData" value="No"> No </input>   </td>
		<td><a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=gpsdata');return false" target="_parent"> Click</a> to add Comment
</td>
		</tr>
		<tr> 
		<td><b><div align="left"> Transit Delay </div></b></td>
		<td> <input type="radio" name="tranDelay" value="Yes"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="tranDelay" value="No" "checked"> No </input>   </td>
		<td><a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=TransitDelay');return false" target="_parent"> Click</a> to add Comment
</td>
		</tr>
		<tr>
		<td><b><div align="left">Vehicle Shortages</div></b></td>
		<td> <input type="radio" name="shortages" value="Yes"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="shortages" value="No" "checked"> No </input>   </td>
		<td><a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=shortages');return false" target="_parent"> Click</a> to add Comment
		</td>
		</tr>
		<tr>
		<td><b><div align="left"> Route deviation</div></b></td>
		<td> <input type="radio" name="rtDeviation" value="Yes"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="rtDeviation" value="No" "checked"> No </input>   </td>
		<td><a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=rtDeviation');return false" target="_parent"> Click</a> to add Comment
		</td>
		</tr>
		<tr>	
		<td><b><div align="left"> Driver Mobile No. </div></b>
		</td>
		<td colspan="2"> <div align="left"> <input type="text" maxlength="10" name="deBrifMobNo" id="deBrifMobNo"  value="<%= drvMobNo %>" > </div>
		</td>
		</tr>
		<tr>
		<td><b><div align="left">De-Briefing Comment</div></b></td>
		<td  colspan="2"><div align="left"> <textarea name="debriefingcomment" id="debriefingcomment"></textarea></div></td>
		</tr>
		<tr>
		<td><b><div align="left">De-Briefing Triner Name</div></b></td>
		<td  colspan="2"  ><div align="left" ><%=debrfTrainerNm%> <input type="hidden" name="deBrifTrinerName" id="deBrifTrinerName" value="<%=debrfTrainerNm%>" readonly ></div>
		<a href="#" onclick="javascript:window.open('brif_trinerbrifsum.jsp?trNm=<%=debrfTrainerNm%>&pgFrom=debrif');" > click here   </a>to see brief history
		</td>
		</tr>
		<tr>
		<td  colspan="3"><input type="submit" name="Submit" value="Submit" class="formElement"></td>
		</tr>
		</table>
		</form>
		</td>
		<td >
		<div id="div1">
		<IFRAME src='tripgraph4.jsp?driverid=<%=driverid%>&cnt=1' scrolling=no   id='banner1'  width='600' height='520' style='padding-top:10;padding-left:10' frameborder='0'></IFRAME>
		</div>
		</td>
		</tr>
		</table>
		<table class="stats">
 		<tr>
		<td align="center"> <font color="maroon" size="2" > <B>Last Trip</B> <font> </td>
 		</tr>		
 		<tr>
		<td> 
		<table class="sortable" width="100%">
   	<tr>
		<td class="hed"> <B> Sr No</B> </td>
		<td class="hed"> <B> Trip Id</B> </td>
		<td class="hed"> <B> Start Date </B> </td> 
		<td class="hed"> <B> Start Place </B> </td>
		<td class="hed"> <B> End Date </B> </td>
		<td class="hed"> <B> End Place </B> </td>
		<td class="hed"> <B> Distance</B> </td>
		<td class="hed"> <B> OS </B> </td>
		<td class="hed"> <B> RA </B> </td>	
		<td class="hed"> <B> RD </B> </td>
		<td class="hed"> <B> ND </B> </td>
		<td class="hed"> <B> Rating </B> </td> 
		</tr>
		<%
   	String reqJcode = "", riskratingfrmtd = "";
   	String sql24 = "",sql4 ="",sql25="";
   	ResultSet rs24 = null,rs4=null,rs25=null ;
   	NumberFormat nf = DecimalFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);	
		nf.setGroupingUsed(false);
   	String sql4jcode="select * from t_completedjourney where DriverId='"+driverid+"' order by StartDate desc limit 1";
   	ResultSet rsjCode  = st.executeQuery(sql4jcode);
   	int i=1;
   	if(rsjCode.next())
   	{
		   reqJcode = rsjCode.getString("JDCode");
		   String stime, etime;
			try
			{
				stime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsjCode.getString("StartDate")));
			}catch(Exception ex1)
			{
				stime="00:00:00";
			}
			try
			{
				etime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsjCode.getString("EndDate")));
			}catch(Exception ex1)
			{
				etime="23:59:59";
			}
		   %>
		<tr>
		<td>1</td>
		<td><a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=reqJcode%></a>
		<br>
		<div class="popup" id="popup<%=i%>">
		<table border="1" bgcolor="white">
		<tr><td>
		<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brif_excponmap.jsp?tripid=<%=reqJcode%>&vehcode=<%=rsjCode.getString("VehId")%>&sdate=<%=rsjCode.getString("StartDate")%>&vehregno=<%=rsjCode.getString("VehRegNo")%>&ownername=<%=rsjCode.getString("OwnerName")%>&startplace=<%=rsjCode.getString("StartPlace")%>&endplace=<%=rsjCode.getString("EndPlace")%>&enddate=<%=rsjCode.getString("EndDate")%>&pg=cm&ftime=<%=stime%>&totime=<%=etime%>' );" >Show Trip on Map</a>	
		</td></tr>
		<tr><td>
		<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=reqJcode%>&vehcode=<%=rsjCode.getString("VehId")%>' );" >Trip detail report</a>	
		</td></tr>
		<tr><td>
		<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=reqJcode%>' );" >Trip exception report</a>	
		</td></tr>
		<tr><td>
		<a href="javascript:toggleDetails(<%=i%>,false);">Close </a>	
		</td></tr>
		</table>
		</div>		
		</td>
		<td>
		<% try 
		{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsjCode.getString("StartDate"))));
		}
		catch(Exception ex1)
		{
			try
			{
				out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rsjCode.getDate("StartDate"))+" 00:00:00");
			}
			catch(Exception ex2)
			{
				out.print(rsjCode.getString("StartDate"));
			}
		}		
		%>			
		</td>
		<td><%=rsjCode.getString("StartPlace")%></td>
		<td>
		<% try 
		{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsjCode.getString("EndDate"))));
		}
		catch(Exception ex1)
		{
			try
			{
				out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rsjCode.getDate("EndDate"))+" 00:00:00");
			}
			catch(Exception ex2)
			{
				out.print(rsjCode.getString("EndDate"));
			}
		}		
		%>		
		</td>
		<td><%=rsjCode.getString("EndPlace")%></td>
		<td><%=rsjCode.getString("KmTravelled")%></td>
		<td>
		<%
		sql1="select Count(*) as cnt from t_trip_overspeed where Jcode='"+rsjCode.getString("JDCode")+"'";
		ResultSet rstos=stmtnew.executeQuery(sql1);
		if(rstos.next())
		{
			out.print(rstos.getInt("cnt"));
		}	
	
	%>	
		</td>
		<td>
		<%
		sql1="select Count(*) as cnt from t_trip_ra where Jcode='"+rsjCode.getString("JDCode")+"'";
		ResultSet rstra=stmtnew.executeQuery(sql1);
		if(rstra.next())
		{
			out.print(rstra.getInt("cnt"));
		}	
	
	%>		
		</td>
		<td>
		<%
		sql1="select Count(*) as cnt from t_trip_rd where Jcode='"+rsjCode.getString("JDCode")+"'";
		ResultSet rstrd=stmtnew.executeQuery(sql1);
		if(rstrd.next())
		{
			out.print(rstrd.getInt("cnt"));
		}	
	
	%>	
		</td>
		<td>
		<%
		sql1="select Count(*) as cnt from t_trip_nd where Jcode='"+rsjCode.getString("JDCode")+"'";
		ResultSet rstnd=stmtnew.executeQuery(sql1);
		if(rstnd.next())
		{
			if(rstnd.getInt("cnt") > 0)
			{
				out.print("Yes");
			}
			else
			{
				out.print("No");
			}
		}	
	
	%>	
		</td>
		<td><%=nf.format(rsjCode.getDouble("TripRating"))%></td>
		</tr>	   
	   <%
   }
  %>
</td></tr></table>
</td></tr></table>

	<% 
	}
	catch(Exception e)
	{
		out.print("Exception--->"+e);
	}
	finally
	{
		st.close();
		st1.close();
		st2.close();
		st3.close();
		conn.close();
		conn1.close();
	}
	%>
	</td></tr>
</table>

<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>


</form>
</body>
</html>
