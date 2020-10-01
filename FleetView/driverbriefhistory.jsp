<%@ include file="headernew.jsp" %>
<html>
<head>
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

function newwindow(webadd)
{ 
  window.open(webadd,'jav','width=400,height=200,resizable=yes');
} 
function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function showExcel()
{
	var drvrname=document.getElementById("drvrname").value; 
	var trans1=document.getElementById("trans1").value; 
	var drvrid=document.getElementById("drvrid").value;
	var briefidd=document.getElementById("briefidd").value;

	  window.open("excelbriefhistory.jsp?drivername="+drvrname+"&briefId="+briefidd+"&trans="+trans1+"&driverid="+ drvrid);
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
}
</style>
</head>

<%!
Connection con1;
String driveridjsp="";
String sql24,sql25,sql26;
ResultSet rs24,rs25,rs26;
%>
<form name="driverbriefingform1" method="post" action="driver_briefing_insert.jsp" onSubmit="return validate();" >
<% 
	try {
		
	System.out.println("hiii -----------------------------------");
		 	Class.forName(MM_dbConn_DRIVER);
			con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			
			Statement stmt1=con1.createStatement(),stmtnew=con1.createStatement();
			ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null, rs7=null, rs8=null, rs9=null, rs10=null, rs11=null, rs12=null, rs13=null, rs14=null, rs15=null, rs16=null;
			String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql12="", sql13="", sql14="", sql15="", sql16="";
			String lastmnthdate="", lastsixdate="", riskratingfrmtd="";
			String msg = "";
			String trans="";
			String trinerName = session.getAttribute("user").toString();
			System.out.println("trinername="+trinerName);
			String driverid=request.getParameter("driverid");
			String drivername=request.getParameter("drivername");
			trans=request.getParameter("trans");
			System.out.println("trans"+trans);
			String briefId = request.getParameter("briefId");
			java.util.Date tdydte = new java.util.Date();
			Format formatter = new SimpleDateFormat("yyyy-MM-dd");
			String tdydte1=formatter.format(tdydte);
			NumberFormat nf = DecimalFormat.getNumberInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);	
			nf.setGroupingUsed(false);
			
			NumberFormat nf1 = DecimalFormat.getNumberInstance();
			nf1.setMaximumFractionDigits(0);
			nf1.setMinimumFractionDigits(0);	
			nf1.setGroupingUsed(false);
			
				sql1="SELECT DATE_SUB('"+tdydte1+"', INTERVAL 30 DAY)";
				System.out.println("SQL 1="+sql1);
				rs1=stmt1.executeQuery(sql1);	
				if(rs1.next())	
				{
					lastmnthdate=rs1.getString(1);
				}
				sql3="SELECT DATE_SUB('"+tdydte1+"', INTERVAL 180 DAY)";
				System.out.println("SQL 3="+sql3);
				rs3=stmt1.executeQuery(sql3);	
				if(rs3.next())	
				{
					lastsixdate=rs3.getString(1);
				}
				String  exportFileName=session.getAttribute("user").toString()+"_Brief/Debrief_report.xls";

			%>
	
			   <table border="0" width="100%" class="stats">
				<tr>
				<td> <div align="center"> <font face="Arial" color="black" size="3"> <B> Driver Briefing History Report</B> </font> </div> </td>
				<td> <div align="right"> 
				</div> 
				</td>
				</tr>
		    	</table>		
		    
				 	
					<table class="stats" border="1" width="100%" align="top">
	            <tr>
					<td colspan="2"><font face="Arial" size="2" color="black"><%=drivername%> of <%=trans%> </font> <br><a href="#" onclick="javascript:window.open('trainerhistory.jsp?trNm1=<%=drivername%>&trNm=All&rdpassport=both' );" > click here  </a><font face="Arial" size="2" color="black">to see brief / de-brief history</font></td>
					<input type="hidden" id="drvrname" name="drvrname" class="formElement" value="<%=drivername%>" /> 
					<input type="hidden" id="trans1" name="trans1"  value="<%=trans%>" /> 
										<input type="hidden" id="briefidd" name="briefidd"  value="<%=briefId%>" /> 
		
					</tr>
					<tr>
					<td> Driver Id: &nbsp;&nbsp;&nbsp; <%=driverid%> 
					<input type="hidden" id="drvrid" name="drvrid" class="formElement" value="<%=driverid%>" readonly/>	
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
				   <div id="mytable">
				   			   <table border="0" width="100%" class="stats">
				   
				    <tr>
				   					<td align="center"><div align="center"> <font face="Arial" color="black" size="2" > <B> Trips done so far</B> </font> </div></td>
				   					</tr>
				   					<tr>
				   					<td>
				   						<div align="right">&nbsp; &nbsp;<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
		<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
		
		<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('mytable');">    
 			<img src="images/print.jpg"  width="15px" height="15px" style="border-style: none"></img>
		</a>
 		<a href="#" onclick="showExcel()" title="Export to Excel"><img
						src="images/excel.jpg" width="15px" height="15px"></a>
 		  <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(tdydte)%>
		</div>
				   					</td>
				   	</tr>
					</table>
				    

				   
<table class="sortable" width="100%">
<tr>
<th> <B> Sr No</B> </th>
<th> <B>Vehicle No.</B> </th>

<th> <B> Trip Id</B> </th>
<th> <B> Start Date </B> </th> 
<th> <B> Start Place </B> </th>
<th> <B> End Date </B> </th>
<th> <B> End Place </B> </th>
<th> <B> Distance</B> </th>
<th> <B> OS Duration (In Sec)</B> </th>
<th> <B> RA </B> </th>	
<th> <B> RD </B> </th>
<th> <B> ND </B> </th>
<th> <B> Rating </B> </th> 
<th> <B> Last Trip Rating</B> </th> 
<th> <B> special Instruction </B> </th> 
<th> <B>DeBriefing Comments </B> </th> 
</tr>
<%
	String sql="select distinct(JDCode),StartDate,StartPlace,NDCount, EndDate,EndPlace,KmTravelled,TripRating,VehId,VehRegNo,OwnerName,RACount,RDCount,OSDuration  from t_completedjourney where DriverID='"+driverid+"' and JDcode <>'-' and gpname='castrol' order by StartDate desc";
	System.out.println("Query:-"+sql);
	ResultSet rsttrips=stmt1.executeQuery(sql);
//out.print(sql);
	int i=1;
	while(rsttrips.next())
	{
		String sdate=rsttrips.getString("StartDate");
		String stime, etime;
	
	  /*#################################change#############################*/
        String fromdate="",todate="";
		int ftime1=0;
		int ftime2=0;
		int ftime3=0;
		int ttime1=0;
		int ttime2=0;
		int ttime3=0;
		String edate;
        
        
       	sdate=rsttrips.getString("StartDate");
    //  System.out.println("StartDate--->>"+sdate);
     try
    {
    	 fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
    }
    catch(Exception e)
    {
    	fromdate=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
    }
   
  	try
  	{
  	//retrieve time in hrs and mins
  		java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
  	 	ftime1=dt.getHours();
  	 	ftime2=dt.getMinutes();
  	 	ftime3=dt.getSeconds();
  	}
  	catch(Exception e)
  	{
  		ftime1=00;
  		ftime2=00;
  		ftime3=00;
  	}
  	 	edate=rsttrips.getString("EndDate");
 
  try
  	{
	  todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
  	}
  	catch(Exception e)
  	{
  		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd ").parse(edate));
  	}
  
  	try
  	{
  	//retrieve time in hrs and mins
  		java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
		ttime1=edt.getHours();
  	 	ttime2=edt.getMinutes();
  	 	ttime3=edt.getSeconds();
  	}
  	catch(Exception e)
  	{
  		ttime1=23;
  	 	ttime2=59;
  	 	ttime3=59;
  	}
  	 /*#################################change#############################*/   
		
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
	<td align="right"><div align="right"><%=i%></div></td>	
			<td align="left"><div align="left"><%=rsttrips.getString("VehRegNo")%></div></td>
	
	<td align="right"><div align="right"><a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"> <%=rsttrips.getString("JDCode")%></a>
	<br>
	<div class="popup" id="popup<%=i%>">
	<table border="1" bgcolor="white">
	<tr><td>
	<%
	String briefid = "",rid = "",plannedstatus = "No";
	boolean flag = false;
	 sql1 = "select * from db_gps.t_briefing where tripid = '"+rsttrips.getString("JDCode")+"'";
	 System.out.println("SQL1---->"+sql1);
	 rs1 = stmtnew.executeQuery(sql1);
	if(rs1.next())
	{
		briefid = rs1.getString("Briefid");
	}

	sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rsttrips.getString("JDCode")+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid asc ,row asc limit 1 ";
	System.out.println("from table t_intermediateroute="+sql1);
	rs1 = stmtnew.executeQuery(sql1);
	if(rs1.next())
	{
		rid = rs1.getString("advancedrouteid");
		plannedstatus = "Yes";
		flag = true;
	}
	%>
	<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rsttrips.getString("JDCode")%>&vehcode=<%=rsttrips.getString("VehId")%>&data=<%=fromdate %>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ftime3=<%=ftime3 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&ttime3=<%=ttime3 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=driverid %>' );" >Show Trip on Map</a>
	<!--<a href="javascript:toggleDetails(<%//=i%>,false);" onclick="javascript:window.open('brif_excponmap.jsp?tripid=<%//=rsttrips.getString("JDCode")%>&vehcode=<%//=rsttrips.getString("VehId")%>&sdate=<%//=rsttrips.getString("StartDate")%>&vehregno=<%//=rsttrips.getString("VehRegNo")%>&ownername=<%//=rsttrips.getString("OwnerName")%>&startplace=<%//=rsttrips.getString("StartPlace")%>&endplace=<%//=rsttrips.getString("EndPlace")%>&enddate=<%//=rsttrips.getString("EndDate")%>&pg=cm&ftime=<%//=stime%>&totime=<%//=etime%>' );" >Show Trip on Map</a>-->	
	</td></tr>
	<tr><td>
	<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=rsttrips.getString("JDCode")%>&vehicleRegistrationNo=<%=rsttrips.getString("VehRegNo")%>&startDate=<%=rsttrips.getString("StartDate")%>&endDate=<%=rsttrips.getString("EndDate")%>&vehcode=<%=rsttrips.getString("VehId")%>' );" >Trip detail report</a>	
	</td></tr>
	<tr><td>
	<a href="javascript:toggleDetails(<%=i%>,false);" onclick="javascript:window.open('TripwiseException.jsp?tripid=<%=rsttrips.getString("JDCode")%>&trans=<%=request.getParameter("trans") %>&startDate=<%=rsttrips.getString("StartDate") %>&endDate=<%=rsttrips.getString("EndDate") %>' );" >Trip exception report</a>	
	</td></tr>
	<tr><td>
	<a href="javascript:toggleDetails(<%=i%>,false);">Close </a>	
	</td></tr>
	</table>
	</div>
	</div>
	</td>
	<td align="right"><div align="right">
		<% try 
		{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate"))));
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
		</div>
	</td>
	
	<td align="left"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
	<td align="right"><div align="right">
	<% try 
		{
				out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("EndDate"))));
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
		</div>	
	</td>
	<td align="left"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
	<td align="right"><div align="right"><%=nf1.format(rsttrips.getDouble("KmTravelled"))%></div></td>
	<td align="right"><div align="right"><%=rsttrips.getString("OSDuration")%>
	<%
		//sql1="select Count(*) as cnt from t_trip_overspeed where Jcode='"+rsttrips.getString("JDCode")+"'";
		//ResultSet rstos=stmtnew.executeQuery(sql1);
		//if(rstos.next())
		//{
			//out.print(rstos.getInt("cnt"));
		//}	
	
	%></div>	
	</td>
	<td align="right"><div align="right">
	<%
	/*	sql1="select Count(*) as cnt from t_trip_ra where Jcode='"+rsttrips.getString("JDCode")+"'";
		ResultSet rstra=stmtnew.executeQuery(sql1);
		if(rstra.next())
		{
			out.print(rstra.getInt("cnt"));
		}	
	*/
	
	%><%=rsttrips.getString("RACount")%>	</div>	
	</td>
	<td align="right"><div align="right">
	<%
		/*sql1="select Count(*) as cnt from t_trip_rd where Jcode='"+rsttrips.getString("JDCode")+"'";
		ResultSet rstrd=stmtnew.executeQuery(sql1);
		if(rstrd.next())
		{
			out.print(rstrd.getInt("cnt"));
		}	
	*/
	%><%=rsttrips.getString("RDCount")%></div>	
	</td>
	<td align="right"><div align="right">
	<%
		/*sql1="select Count(*) as cnt from t_trip_nd where Jcode='"+rsttrips.getString("JDCode")+"'";
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
	*/
	%><%=rsttrips.getString("NDCount")%></div>	
	</td>
	
	<%
		if(rsttrips.getDouble("KmTravelled")== 0.0)
		{
			%>
			<td align="right"><div align="right">NA</div></td>
			
			<%
		}
		else
		{
	%>

	<td align="right"><div align="right">
		<%=nf.format(rsttrips.getDouble("TripRating"))%></div></td>
		<%
		}
		%>
	<td align="right"><div align="right">
<%
sql1="select TripRating from t_completedjourney where DriverID='"+driverid+"' and JDcode <>'-' and startdate<'"+sdate+"' order by StartDate desc";
System.out.println("From table t_completedjourny"+sql1);
ResultSet rstbfr=stmtnew.executeQuery(sql1);
double ratbef=0.0;
if(rstbfr.next())
{
	//ratbef=nf.format(rstbfr.getDouble("TripRating"));

	//out.print(ratbef);
%>
<%=nf.format(rstbfr.getDouble("TripRating"))%>
<%
}
%></div>
</td>

<%
	String spinst="Not Briefed",defcomm="Not Debrif";
	sql1="select specialinst,debriefingcomment from t_driverbriefingquest where driverid='"+driverid+"' and EntDateTime='"+sdate+"' order by EntDateTime desc";
   System.out.println("form t_driverbriefingquest"+sql1);
ResultSet rstbrfcom=stmtnew.executeQuery(sql1);
if(rstbrfcom.next())
{
	spinst=rstbrfcom.getString("specialinst");
	defcomm=rstbrfcom.getString("debriefingcomment");
	////out.print(spinst);
}
else
{
	spinst="-";
	defcomm="-";
}
%>
<td align="left"><div align="left"><%=spinst%></div></td>
<td align="left"><div align="left"><%=defcomm%></div></td>

	</tr>	
	<%	
	i++;
	}
%>
</table>
</div>

<% 
//}
} 
catch(Exception e) 
{ 
	//out.println("Exception----->" +e);
	System.out.println("Exception occured"+e.getMessage());
	e.printStackTrace();

}

finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
}

%>

<br></br>
</form>
</html>
<%@ include file="footernew.jsp"%>