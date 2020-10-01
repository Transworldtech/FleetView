<style><!-- 
    SPAN.searchword { background-color:cyan; }
    // -->
</style>
<script src="searchhi.js" type="text/javascript" language="JavaScript"></script>
<body onLoad="JavaScript:loadSearchHighlight();" bgcolor="#FFE4E1">
<script language="JavaScript"><!--
    function loadSearchHighlight()
    {
      SearchHighlight();
      document.searchhi.h.value = searchhi_string;
      if( location.hash.length > 1 ) location.hash = location.hash;
      
    }
    // -->
</script>





<%@ include file="header.jsp" %>


<script language="javascript">
    
    
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

function validate()
{
			
        	var drivrmob=document.driverbriefingform1.drvMobNo.value;
			if(drivrmob.length < 10)
			{
				alert("Please enter 10 digit Driver Mobile No");
				return false;
			}		
			return true;
}


function ShowMap(id)
{
	if(id=="1")
	{	
		document.getElementById("div1").style.display="";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="none";
	}
	
	if(id=="2")
	{	
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="";
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="none";
	}
	
	if(id=="3")
	{	
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="";
		document.getElementById("div4").style.display="none";
	}

	if(id=="4")
	{	
		document.getElementById("div1").style.display="none";
		document.getElementById("div2").style.display="none";
		document.getElementById("div3").style.display="none";
		document.getElementById("div4").style.display="";
	}
}

function newwindow(webadd)
{ 
  window.open(webadd,'jav','width=400,height=200,resizable=yes');
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
Connection con1, con2;
String driveridjsp="";
String sql24,sql25,sql26;
ResultSet rs24,rs25,rs26;
%>
<form name="driverbriefingform1" method="post" action="driver_briefing_insert.jsp" onSubmit="return validate();" >
<% 
	try {
		 	Class.forName(MM_dbConn_DRIVER);
			con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			Statement stmt1=con1.createStatement(), stmt2=con2.createStatement(), stmt3=con2.createStatement(),stmt4=con2.createStatement(),stmtnew=con1.createStatement();
			ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null, rs7=null, rs8=null, rs9=null, rs10=null, rs11=null, rs12=null, rs13=null, rs14=null, rs15=null, rs16=null;
			String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql12="", sql13="", sql14="", sql15="", sql16="";
			String lastmnthdate="", lastsixdate="", riskratingfrmtd="";
			String msg = "";
			String trinerName = (String) session.getAttribute("user");
			String driverid=request.getParameter("driverid");
			String drivername=request.getParameter("drivername");
			String trans=request.getParameter("trans");
			String briefId = request.getParameter("briefId");
			java.util.Date tdydte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			String tdydte1=formatter.format(tdydte);
			NumberFormat nf = DecimalFormat.getNumberInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);	
			nf.setGroupingUsed(false);
			String sqlChkBrStatus = "select * from t_driverbriefingquest where DriverId = '"+driverid+"' and  BriefingStatus = 'Incomplete' order by EntDateTime desc limit 1";
        	rs1 = stmt1.executeQuery(sqlChkBrStatus);
        	if(rs1.next())
        	{
			   msg = "Briefing already done.";
         %>
          <table border="1" width="100%">
			 	<tr>
				<td>
				<div align="left">  <a href="javascript:history.go(-1);"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a>
				</td>
				<td> <div align="center"> <font color="maroon" size="2"> <B> Driver Briefing Report</B> </font> </div> </td>
				</tr>
            <tr><td></td>
            <td> <div align="center"> <font color="maroon" size="2"> <B> <%=msg%></B> </font> </div> </td>
            </tr>
            <tr>
            <td>
				</td>
            <td> <div align="center"> <font color="maroon" size="2"> <B> <a href="showdriverdebriefing.jsp?driverid=<%=driverid %>&drivername=<%= drivername %>&trans=<%= trans %>">Click here to de-brief the form.</a></B> </font> </div> </td>
            </tr>
		    </table>	
         <%
        
        }
        else
        {
				sql1="SELECT DATE_SUB('"+tdydte1+"', INTERVAL 30 DAY)";
				rs1=stmt1.executeQuery(sql1);	
				if(rs1.next())	
				{
					lastmnthdate=rs1.getString(1);
				}
				sql3="SELECT DATE_SUB('"+tdydte1+"', INTERVAL 180 DAY)";
				rs3=stmt1.executeQuery(sql3);	
				if(rs3.next())	
				{
					lastsixdate=rs3.getString(1);
				}
			%>
		<table border="1" width="100%" bgcolor="white">
	   <tr>
		<td>
			   <table border="0" width="100%">
				<tr>
				<td>
					<div align="left">  <a href="javascript:history.go(-1);"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a>
				</td>
				<td> <div align="center"> <font color="maroon" size="2"> <B> Driver Briefing Report</B> </font> </div> </td>
				<td> <div align="right"> 
				</div> 
				</td>
				</tr>
		    	</table>		
		     <table width="100%" bgcolor="white">
   	      <tr>
				<td valign="top"> 
					<P></P><P></P>
				   <table border="0" width="100%"> 
				   <tr> <td>	
					<table class="stats" border="1" width="100%" valign="top">
	            <tr>
					<td colspan="2" class="hed"> <B> <%=drivername%> of <%=trans%> </B> <br><a href="#" onclick="javascript:window.open('brif_driverbrifsum.jsp?drvName=<%=drivername%>&driverid=<%=driverid%>' );" > click here   </a>to see brief history</td>
					<input type="hidden" name="drvrname" class="formElement" value="<%=drivername%>" /> 
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
					<td> <a href="briefing/trininginfo.jsp?driverid=<%=driverid%>" onclick="popWin = open('briefing/trininginfo.jsp?driverid=<%=driverid%>','myWin','width=500,height=600');popWin.focus();return false" >Click to View Taining Details</a> </td>
				   </tr>	
					</table>
				   </td> </tr>
				  	<tr> <td> 
				  	<P></P>
				  	<P></P>
					<table class="stats" border="1" width="100%" align="center">
				   <tr>
					<td colspan="3" class="hed"> <div align="center"> <font color="maroon" size="2"> <B> Briefing</B> </font> </div> </td>
				    </tr>
               <tr>
					<td> Vehicle Familiarization </td>
					<td> <input type="radio" name="vehfam" value="Yes" "checked"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="vehfam" value="No"> No </input>   </td>
					<td>
                                            <a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=vehiclefamiliarize');return false" target="_parent"> Click</a> to add Comment
					</td>

				    </tr>
				    <tr>
					<td> Route Familiarization </td>
					<td> <input type="radio" name="routefam" value="Yes" "checked"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="routefam" value="No"> No </input> </td>
					<td>
						<a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=routefamiliarize');return false" target="_parent"> Click</a> to add Comment
					</td>
				    </tr>
				    <tr>	
					<td> Mental / Physical Condition </td>
					<td> <input type="radio" name="mentphycond" value="Ok" "checked"> Ok </input>  &nbsp;&nbsp; <input type="radio" name="mentphycond" value="Not Ok"> Not Ok </input> </td>
					<td>
						<a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=mentphyscond');return false" target="_parent"> Click</a> to add Comment
					 </td>
				    </tr>
				    <tr>	
					<td> JRM Briefed </td>
					<td> <input type="radio" name="jrmbrief" value="Yes" "checked"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="jrmbrief" value="No"> No </input> </td> 
					<td>
						<a href="#" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=jrmbriefed');return false" target="_parent"> Click</a> to add Comment
					</td>
				    </tr>
                                    <tr  >	
					<td title= "When data for last trip is shown on Map trainer can chek whether there is any gap, or data loss or latest Location of Vehcile is not in proper location" > GPS Data </td>
					<td> <input type="radio" name="gpsData" value="Yes" "checked"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="gpsData" value="No"> No </input> </td> 
               <td><a href="#" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=gpsdata');return false" target="_parent"> Click</a> to add Comment                                        
               </td>
				   </tr>
               <tr>
					<td> Driver License </td>
					<td> <input type="radio" name="drLicnRd" value="Yes" "checked"> Yes </input>  &nbsp;&nbsp; <input type="radio" name="drLicnRd" value="No"> No </input>   </td>
					<td> <a href="" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=drLicnRd');return false" target="_parent"> Click</a> to add Comment
					</td>
  	      	    </tr>
                                
				    <tr>	
					<td> Driver Response 

					</td>
					<td colspan="2">
						<a href="#" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=driverreponse');return false" target="_parent"> Click</a> to add Comment
					</td>
				   </tr>
				   <tr>	
					<td> Special Instructions 
					</td>
					<td colspan="2">
						<a href="#" onClick="newwindow('addrivbrfngcmtn.jsp?commentfor=specinst');return false" target="_parent"> Click</a> to add Comment
					</td>
				    </tr>
                                     
                                    <tr>	
					<td> Trainer Name 
					</td>
                                        <td colspan="2"> <%=trinerName%><input type="hidden" name="trinerName" value="<%= trinerName %>" maxlength="25" readonly />
                                        <br><a href="#" onclick="javascript:window.open('brif_trinerbrifsum.jsp?trNm=<%=trinerName%>&pgFrom=brif');" > click here   </a>to see brief history
                                        </td>
				    </tr>
                                   
                                    <tr>	
					<td> Driver Mobile No. 
					</td>
                                       <td colspan="2"> <input type="text" name="drvMobNo" value="" maxlength="10" />
                                        </td>
				    </tr>
                                    
				    <tr>
					<td colspan="3" align="center"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
				    </tr>		
				 </table>				
	
				</td> </tr>
				  </table>	
		
	
				     
				</td>

				<td> <div align="right">

					<table class="stats" border="1" width="90%">
	                   		    <tr>
						<td class="hed"> <a href="#" onCLick="ShowMap('1');"> Last Trip</a> </td>
						<td class="hed"> <a href="#" onCLick="ShowMap('2');"> 1 Month</a> </td>
						<td class="hed"> <a href="#" onCLick="ShowMap('3');"> 6 Months</a> </td>
						<td class="hed"> <a href="#" onCLick="ShowMap('4');">1 Year</a> </td>
					    </tr>
						</table>
						<div id="div1">
 						<IFRAME src='tripgraph4.jsp?driverid=<%=driverid%>&cnt=1' scrolling=no   id='banner1'  width='580' height='510' style='padding-top:10;padding-left:10' frameborder='0'></IFRAME>
 						</div>
 						<div id="div2" style="display:none">
 						<IFRAME src='tripgraph5.jsp?driverid=<%=driverid%>&cnt=2' scrolling=no   id='banner1'  width='580' height='510' style='padding-top:10;padding-left:10' frameborder='0'></IFRAME>
 						</div>
 						<div id="div3" style="display:none">
 						<IFRAME src='tripgraph6.jsp?driverid=<%=driverid%>&cnt=3' scrolling=no   id='banner1'  width='580' height='510' style='padding-top:10;padding-left:10' frameborder='0'></IFRAME>
 						</div>
 						
 						<div id="div4" style="display:none">
 						<IFRAME src='tripgraph7.jsp?driverid=<%=driverid%>&cnt=4' scrolling=no   id='banner1'  width='580' height='510' style='padding-top:10;padding-left:10' frameborder='0'></IFRAME>
 						</div>
                                                
 						
						</td></tr>
</table>					
	
<!-- -------------------- For Last Trip ---------------------------------------------- -->

			<!-- ------------------------Showing all trips done so far (Castrol) ----------------------------- -->
<table class="stats">
                                    
 					
				   <tr>
					<td align="center"> <font color="maroon" size="2" > <B> Trips done so far</B> <font> </td>
				   </tr>		
				   <tr>
				   <td> 
<div style="margin-center: 178px; height: 200px; background-color: azure; border: 1px solid black; overflow: auto;">	
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
	String sql="select distinct(JDCode),StartDate,StartPlace, EndDate,EndPlace,KmTravelled,TripRating,VehId,VehRegNo,OwnerName from t_completedjourney where DriverID='"+driverid+"' and JDcode <>'-' order by StartDate desc";
	ResultSet rsttrips=stmt1.executeQuery(sql);
	int i=1;
	while(rsttrips.next())
	{
	String stime, etime;
	try
	{
		stime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate")));
	}catch(Exception ex1)
	{
		stime="00:00:00";
	}
	try
	{
		etime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("EndDate")));
	}catch(Exception ex1)
	{
		etime="23:59:59";
	}
	%>
	<tr>
	<td><%=i%></td>	
	<td><a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"> <%=rsttrips.getString("JDCode")%></a>
	<br>
	<div class="popup" id="popup<%=i%>">
	<table border="1" bgcolor="white">
	<tr><td>
	<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brif_excponmap.jsp?tripid=<%=rsttrips.getString("JDCode")%>&vehcode=<%=rsttrips.getString("VehId")%>&sdate=<%=rsttrips.getString("StartDate")%>&vehregno=<%=rsttrips.getString("VehRegNo")%>&ownername=<%=rsttrips.getString("OwnerName")%>&startplace=<%=rsttrips.getString("StartPlace")%>&endplace=<%=rsttrips.getString("EndPlace")%>&enddate=<%=rsttrips.getString("EndDate")%>&pg=cm&ftime=<%=stime%>&totime=<%=etime%>' );" >Show Trip on Map</a>	
	</td></tr>
	<tr><td>
	<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=rsttrips.getString("JDCode")%>&vehcode=<%=rsttrips.getString("VehId")%>' );" >Trip detail report</a>	
	</td></tr>
	<tr><td>
	<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=rsttrips.getString("JDCode")%>' );" >Trip exception report</a>	
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
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate"))));
		}
		catch(Exception ex1)
		{
			try
			{
				out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rsttrips.getDate("StartDate"))+" 00:00:00");
			}
			catch(Exception ex2)
			{
				out.print(rsttrips.getString("StartDate"));
			}
		}		
		%>	
	</td>
	<td><%=rsttrips.getString("StartPlace")%></td>
	<td>
	<% try 
		{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("EndDate"))));
		}
		catch(Exception ex1)
		{
			try
			{
				out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rsttrips.getDate("EndDate")));
			}
			catch(Exception ex2)
			{
				out.print(rsttrips.getString("EndDate"));
			}
		}		
		%>	
	</td>
	<td><%=rsttrips.getString("EndPlace")%></td>
	<td><%=rsttrips.getString("KmTravelled")%></td>
	<td>
	<%
		sql1="select Count(*) as cnt from t_trip_overspeed where Jcode='"+rsttrips.getString("JDCode")+"'";
		ResultSet rstos=stmtnew.executeQuery(sql1);
		if(rstos.next())
		{
			out.print(rstos.getInt("cnt"));
		}	
	
	%>	
	</td>
	<td>
	<%
		sql1="select Count(*) as cnt from t_trip_ra where Jcode='"+rsttrips.getString("JDCode")+"'";
		ResultSet rstra=stmtnew.executeQuery(sql1);
		if(rstra.next())
		{
			out.print(rstra.getInt("cnt"));
		}	
	
	%>		
	</td>
	<td>
	<%
		sql1="select Count(*) as cnt from t_trip_rd where Jcode='"+rsttrips.getString("JDCode")+"'";
		ResultSet rstrd=stmtnew.executeQuery(sql1);
		if(rstrd.next())
		{
			out.print(rstrd.getInt("cnt"));
		}	
	
	%>	
	</td>
	<td>
	<%
		sql1="select Count(*) as cnt from t_trip_nd where Jcode='"+rsttrips.getString("JDCode")+"'";
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
	<td><%=nf.format(rsttrips.getDouble("TripRating"))%></td>
	</tr>	
	<%	
	i++;
	}
%>
</table>
</div>

					</td>
					
				   </tr>
				 </table>
	<!-- --------------------------------------------------------------------------------- -->
 	</td>
	   </tr>
	</table>

<% 
}
	
} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>
