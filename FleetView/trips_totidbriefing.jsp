<%@ include file="headernew.jsp"%>
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
}
</style>
<%! Connection conn;
    Statement st,st1,stt;
    String sql,sql1;
  
    
    NumberFormat nf=DecimalFormat.getNumberInstance();
   %>
   
<% nf.setMaximumFractionDigits(2);
   nf.setMinimumFractionDigits(2);
   nf.setGroupingUsed(false);
   int cdcount,ndcount,kmcountall,kmcount,tripcount,drivercount,tripcountall,drivercountall,vehcount,vehcountall,oscount,oscountall,racount,racountall,rdcount,rdcountall,cdcountall,ndcountall,countlatency,latency,durationall,duration;
	String startplace,StartCode;
	double ratingcount,ratingcountall;
	double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
	String data1, data2,drivercnt,showdate1,showdate,Owner,datenew1,datenew2,transporter,thename,sTripID="",cTripID="",TripID="";
	String fromdate="", todate="",sql="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="";
	double ss=0.00,aa=0.00,rr=0.00,rt=0.00;
	double percnt=0.0;
	double rtcount=0.00,dtcount=0.00, dtcount1=0.00;
	double rating1=0.00,rating=0.00;
	int i=0;
	String  vv="",ownerNm="",counDriveYesNo=null,ntDriveYesNo=null,sortby="-";
	int  stcount=0, runDuration=0,osduration=0,osduration1=0,tpcount=0,tpcount1=0,dcount=0,dcount1=0,vcount=0, vcount1=0,mydtcount=0,mydtcount1=0;
	int oscount1=0, racount1=0,rdcount1=0, ndcount1=0, stcount1=0,cdcount1=0,transportercount=0,runDuration1=0,ndcountall1=0,cdcountall1=0;
	int pbrief,pdebrief,totpbrief,totpdebrief;
   
   
   String triptype="",rng="";
   fromdate=request.getParameter("fromdate");
   todate=request.getParameter("todate");
   triptype=request.getParameter("thename");
   //System.out.println(fromdate);
  // System.out.println(todate);
   
   data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromdate")));
   data2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("todate")));
   
   rng=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromdate")));
   //System.out.println(data1);
   //System.out.println(data2);
   
   try{
	   Class.forName(MM_dbConn_DRIVER);
	   conn=DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	   st=conn.createStatement();
		st1=conn.createStatement();
		stt=conn.createStatement();
		
   }
   catch(Exception e)
   {
	   e.printStackTrace();
   }
		
try{
			%>
			<table border="0" width="100%">
			<!-- <tr><td align="left"><div align="left"><font size="3" >Report No: 10.9</font></div></td></tr>-->
			<tr><td>
			<font size="3"><b><center>Report for Briefing from <%=data1%> to <%=data2%></center></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_totidbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&triptype=<%=triptype%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel_totidbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&triptype=<%=triptype%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
		<table border="1" width="100%" class="sortable">
				<tr>
			<td  class="hed"> Sr.</td>
			<td  class="hed"> Trip ID</td>
			<td  class="hed"> Vehicle Reg. No.</td>
			<td  class="hed"> Transporter</td>
			<td  class="hed"> Driver ID</td>
			<td  class="hed"> Driver Name</td>
			<td  class="hed"> Start Place</td>
			<td  class="hed"> Start Date</td>
			<td  class="hed"> End Place</td>
			<td  class="hed"> End Date</td>
			<td  class="hed">StdDistance(Km)</td>
			<td  class="hed">StdTransitTime(Hrs)</td>
			<td  class="hed"> Km Travelled</td>
			<td  class="hed"> OS Dur<br>(Sec)</br></td>
			<td  class="hed"> RA</td>
			<td  class="hed"> RD</td>
			<td  class="hed"> OS Count</td>
			<td  class="hed"> CD</td>
			<td  class="hed"> ND</td>
			<td  class="hed"> Rating</td>
			<td  class="hed">Basic</td>
			<td  class="hed">Module1</td>
			<td  class="hed">Module2</td>
			<td  class="hed">Module3</td>
			<td  class="hed">Module4</td>
			<td  class="hed">Briefing</td>
			<td  class="hed">BriefingTrainer</td>
			<td  class="hed">BriefingComments</td>
			<td  class="hed">Debriefing</td>
			<td  class="hed">DebriefingTrainer</td>
			<td  class="hed">DebriefingComments</td>
			<td  class="hed">% Data Captured</td>
			<td  class="hed">Category</td>
			</tr>
		<%
		int k=1;			
		kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
		rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
		totpbrief=0;totpdebrief=0;
		int Vehid=0;
		String Vehregno="";
		String drivername="-",startplace1="-",endplace="-",startdate="-",enddate="-",OwnerName="-";
		String briefdone="",brieftrainername="",briefcomment="",debriefdone="",debrieftrainername="",debriefcomment="";
		String basic="",module1="",module2="",module3="",module4="",category="",ttime1="",stdkm1="";
		int tbcount=0;
		int tdbcount=0;
		int bcount=0;
		int dbcount=0;
		String cdcountt="",ndcountt="";
		drivercount=0;
		ratingcount=0.0;
		vehcount=0;
		oscount=0;
		racount=0;
		rdcount=0;
		cdcount=0;
		ndcount=0;
		latency=0;
		oscount=0;
		racount=0;
		rdcount=0;
		cdcount=0;
		ndcount=0;
		latency=0;
		kmcount=0;
		duration=0;
		duration=0;startplace="-";StartCode="-";
		int compareDate=0;
		pbrief=0;pdebrief=0;
		String sqlCompareDate="SELECT DATEDIFF('"+fromdate+"','2011-10-31') AS DiffDate  ";
		ResultSet rsCompareDate=st1.executeQuery(sqlCompareDate);
		rsCompareDate.next();
		compareDate=rsCompareDate.getInt(1);
		if(triptype.equalsIgnoreCase("started"))
		{
			String sqll="";
			if(compareDate>0)
				sqll="select "+ 
					"count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid, "+
					"sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,"+
					"sum(RDCount) as RDCount,count(Briefing) as tbcount  "+
					" from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  "+
					" and Briefing = 'briefed'";
			else
				sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,"+
				"sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,"+
				"sum(RDCount) as RDCount,count(Briefing) as tbcount "+
				" from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' "+
				"and status<>'faulty' and Briefing = 'briefed'";
			//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
		//String sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount,count(Briefing) as tbcount from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and Briefing='briefed'";
		System.out.println(sqll);
		ResultSet rstt=stt.executeQuery(sqll);
		while(rstt.next())
		{
			drivercountall=rstt.getInt("DriverID");
			
			tripcountall=rstt.getInt("TripID");
			
			vehcountall=rstt.getInt("Vehid");
			
					//kmcount=rstt.getInt("KmTraveled");
					kmcountall=rstt.getInt("KmTraveled");
					//oscount=rstt.getInt("OSDuration");
					oscountall=rstt.getInt("OSCount");
					//racount=rstt.getInt("RACount");
					racountall=rstt.getInt("RACount");
					//rdcount=rstt.getInt("RDCount");
					rdcountall=rstt.getInt("RDCount");
					//duration=rstt.getInt("OSDuration");
					durationall=rstt.getInt("OSDuration");
					tbcount=rstt.getInt("tbcount");
					//ndcountall1=rstt.getInt("NDCount");
					//cdcountall=rstt.getInt("CDCount");
		}
					
					String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and Briefing='briefed'";
					ResultSet rstcd=st.executeQuery(sql11);
					if(rstcd.next())
					{
						//cdcount=rstcd.getInt("cdcount1");
						cdcountall=rstcd.getInt("cdcount1");
						
					}
					
					String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
					ResultSet rstnd=st.executeQuery(sql12);
					if(rstnd.next())
					{
						//ndcount=rstnd.getInt("ndcount1");
						ndcountall=rstnd.getInt("ndcount1");
						
					}
					
					/*String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary' and status<>'Faulty' and ND='Yes'";
					ResultSet rstb=st.executeQuery(sql13);
					if(rstb.next())
					{
						//bcount=rstb.getInt("bcount1");
						tbcount=rstb.getInt("bcount1");
					}*/
					
					String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
					ResultSet rstdb=st.executeQuery(sql14);
					if(rstdb.next())
					{
						//dbcount=rstdb.getInt("dbcount1");
						tdbcount=rstdb.getInt("dbcount1");
					}
					String sqlall="";
					if(compareDate>0)
						sqlall="Select * from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed'";
					else
						sqlall="Select * from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
					ResultSet rstall=st1.executeQuery(sqlall);
					while(rstall.next())
					{
						
						//System.out.println(sqlall);
						drivercount=rstall.getInt("DriverID");
						//System.out.println("drivercnt::>>>"+drivercount);
						tripcount=rstall.getInt("TripID");
						Vehid=rstall.getInt("Vehid");
						Vehregno=rstall.getString("vehregno");
						OwnerName=rstall.getString("Transporter");
						
						//////////////////////////////////////////////////////
						//vehcount=rstt2.getString("vehregno");
						//OwnerName=rstall.getString("Transporter");
						//Vehid=rstt2.getInt("Vehid");
						
						drivercnt=rstall.getString("DriverID");
						drivername=rstall.getString("DriverName");
						startplace1=rstall.getString("StartPlace");
						endplace=rstall.getString("EndPlace");
						startdate=rstall.getString("TripStartDate");
						enddate=rstall.getString("TripEndDate");
						kmcount=rstall.getInt("KmTraveled");
						//kmcountall=kmcountall+kmcount;
						oscount=rstall.getInt("OSCount");
						//oscountall=oscountall+oscount;
						racount=rstall.getInt("RACount");
						//racountall=racountall+racount;
						rdcount=rstall.getInt("RDCount");
						//rdcountall=rdcountall+Integer.valueOf(rdcount1);
						duration=rstall.getInt("OSDusration");
						//durationall+=rstt2.getInt("OSDusration");
						cdcountt=rstall.getString("CD");
						ndcountt=rstall.getString("ND");
						briefdone=rstall.getString("Briefing");
						brieftrainername=rstall.getString("BriefingTrainer");
						briefcomment=rstall.getString("BriefingComments");
						debriefdone=rstall.getString("Debriefing");
						debrieftrainername=rstall.getString("DebriefingTrainer");
						debriefcomment=rstall.getString("DebriefingComments");
						basic=rstall.getString("Basic");
						module1=rstall.getString("Module1");
						module2=rstall.getString("Module2");
						module3=rstall.getString("Module3");
						module4=rstall.getString("Module4");
						stdkm1=rstall.getString("StdKm");
						ttime1=rstall.getString("StdTime");
						category=rstall.getString("Category");
						
						///////////////////////////////////
						if(stdkm1.equalsIgnoreCase("NA"))
						{
							percnt=100;
						}
						else
						{
							percnt=Double.valueOf(kmcount)/Double.valueOf(stdkm1);
							percnt=percnt*100;
						}

					
				
		%>	
		<tr>
		<td><%=k%></td>
		<td><div align="left">
				<a href="javascript:toggleDetails(<%=k%>,true);" title="Click To See the Reports"><%=tripcount%></a><br />
				<div class="popup" id="popup<%=k%>">
				<table border="1" bgcolor="white">
<!--				<tr>-->
<!--				<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>-->
<!--				</td></tr>-->
				<tr>
				<td><a href="detailed_report.jsp?vehcode=<%=Vehid%>&fromdata=<%=startdate%>&todata=<%=enddate%>&submit=Submit" onclick="javascript:toggleDetails(<%=k%>,false);">Detail Report</a>
				</td>
				</tr>
				<tr><td><a href="javascript:toggleDetails(<%=k%>,false);">Close</a></td></tr>
				</table>
				</div> 
				</div></td>	
		<td>
		<div align="right">
		<%
			out.print(Vehregno);
		%>
		</div></td>
		
		<td>
		<div align="right">
		<%
			out.print(OwnerName);
		%>	
		</div></td>
		<td><div align="right"><%=drivercnt %></div></td>
		<td><div align="right"><%=drivername %></div></td>
		<td><div align="right"><%=startplace1 %></div></td>
		<td><div align="right">
		<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
		
		</div></td>
		<td><div align="right"><%=endplace %></div></td>
		<td>
		<%
		try{
		%>
		<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
		</div>
		<%
		}
		catch(Exception e)
		{
			out.print(enddate);
		}
		%></td>
		<td><div align="right">
		<%
			out.print(stdkm1);
		%>
		</div>	
		</td>
		<td><div align="right">
		<%
			out.print(ttime1);
		%>
		</div>	
		</td>
		<td><div align="right">
		<%
			out.print(kmcount);
		%>
		</div>	
		</td>
		<td><div align="right">
			<%
				out.print(duration);
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(racount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapidacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(racount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(racount);
			}
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(rdcount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapiddeacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(rdcount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(rdcount);
			}
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(oscount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_osduration.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(oscount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(oscount);
			}
			%>
			</div></td>
		<td><div align="right">
		<%
		
		out.print(cdcountt);
		%>
		</div></td>
		<td><div align="right">
		<%
		out.print(ndcountt);
			
		%>
		</div></td>
		<td>
		<div align="right">
		<%
			Accelaration1=0;
			Decelaration1=0;
			OverSpeed1=0;
		if(racount > 0 && kmcount > 0)
		{
			Accelaration1=((double)racount/(double)kmcount)*100;
		}
		if(rdcount > 0 && kmcount > 0)
		{
			Decelaration1=((double)rdcount/(double)kmcount)*100;
		}
		if(duration > 0 && kmcount> 0)
		{
			OverSpeed1 =(((double)duration/10)/(double)kmcount)*100;
		}
		ratingcount=Accelaration1+Decelaration1+OverSpeed1;
		ratingcountall=ratingcountall+ratingcount;
		
		if(kmcount > 0)
		{
		out.print(nf.format(ratingcount));	
		}
		else
		{
			out.print("NA");
		}
		%>
		</div></td>
		
		<td><%=basic%></td>
		<td><%=module1%></td>
		<td><%=module2%></td>
		<td><%=module3%></td>
		<td><%=module4%></td>
		<td><%=briefdone%></td>
		<td><%=brieftrainername%></td>
		<td><%=briefcomment%></td>
		<td><%=debriefdone%></td>
		<td><%=debrieftrainername%></td>
		<td><%=debriefcomment%></td>
		<td>
		<%
		out.print(nf.format(percnt));	
		%>
		</td>
		<td><%=category%></td>
		
		</tr>			
		<%
					k++;
					
					}
					%>	
					<tr>
					<td class="hed" colspan="12">Total :-</td>
					
					<td class="hed"><div align="right"><%=kmcountall%></div></td>
					<td class="hed"><div align="right"><%=durationall%></div></td>
					<td class="hed"><div align="right"><%=racountall%></div></td>
					<td class="hed"><div align="right"><%=rdcountall%></div></td>
					<td class="hed"><div align="right"><%=oscountall%></div></td>
					<td class="hed"><div align="right"><%=cdcountall%></div></td>
					<td class="hed"><div align="right"><%=ndcountall%></div></td>
								
							<td class="hed"><div align="right">
					<%
					
					if(kmcountall!=0)
					{
						aa=Double.valueOf(racountall);
						aa=(aa/kmcountall);
						aa=aa*100;

						rr=Double.valueOf(rdcountall);
						rr=(rr/kmcountall);
						rr=rr*100;
						
						ss=Double.valueOf(durationall/10);
						ss=ss/kmcountall;
						ss=ss*100;
						
						rt=aa+rr+ss;;
					out.print(nf.format(rt));
					}
					else
					{
						out.print("NA");
					}
					%></div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					<td class="hed"><div align="right">-</div></td>
					</tr>
					</table>
	<%
		}
		else if(triptype.equalsIgnoreCase("ended"))
		{
			//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
			String sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount,count(Briefing) as tbcount from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and Briefing='briefed'";
			//System.out.println(sqll);
			ResultSet rstt=stt.executeQuery(sqll);
			while(rstt.next())
			{
				drivercountall=rstt.getInt("DriverID");
				
				tripcountall=rstt.getInt("TripID");
				
				vehcountall=rstt.getInt("Vehid");
				
						//kmcount=rstt.getInt("KmTraveled");
						kmcountall=rstt.getInt("KmTraveled");
						//oscount=rstt.getInt("OSDuration");
						oscountall=rstt.getInt("OSCount");
						//racount=rstt.getInt("RACount");
						racountall=rstt.getInt("RACount");
						//rdcount=rstt.getInt("RDCount");
						rdcountall=rstt.getInt("RDCount");
						//duration=rstt.getInt("OSDuration");
						durationall=rstt.getInt("OSDuration");
						tbcount=rstt.getInt("tbcount");
						//ndcountall1=rstt.getInt("NDCount");
						//cdcountall=rstt.getInt("CDCount");
			}
						
						String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and Briefing='briefed'";
						ResultSet rstcd=st.executeQuery(sql11);
						if(rstcd.next())
						{
							//cdcount=rstcd.getInt("cdcount1");
							cdcountall=rstcd.getInt("cdcount1");
							
						}
						
						String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
						ResultSet rstnd=st.executeQuery(sql12);
						if(rstnd.next())
						{
							//ndcount=rstnd.getInt("ndcount1");
							ndcountall=rstnd.getInt("ndcount1");
							
						}
						
						/*String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary' and status<>'Faulty' and ND='Yes'";
						ResultSet rstb=st.executeQuery(sql13);
						if(rstb.next())
						{
							//bcount=rstb.getInt("bcount1");
							tbcount=rstb.getInt("bcount1");
						}*/
						
						String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
						ResultSet rstdb=st.executeQuery(sql14);
						if(rstdb.next())
						{
							//dbcount=rstdb.getInt("dbcount1");
							tdbcount=rstdb.getInt("dbcount1");
						}
						
						String sqlall="Select * from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
						ResultSet rstall=st1.executeQuery(sqlall);
						while(rstall.next())
						{
							
							//System.out.println(sqlall);
							drivercount=rstall.getInt("DriverID");
							//System.out.println("drivercnt::>>>"+drivercount);
							tripcount=rstall.getInt("TripID");
							Vehid=rstall.getInt("Vehid");
							Vehregno=rstall.getString("vehregno");
							OwnerName=rstall.getString("Transporter");
							
							//////////////////////////////////////////////////////
							//vehcount=rstt2.getString("vehregno");
							//OwnerName=rstall.getString("Transporter");
							//Vehid=rstt2.getInt("Vehid");
							
							drivercnt=rstall.getString("DriverID");
							drivername=rstall.getString("DriverName");
							startplace1=rstall.getString("StartPlace");
							endplace=rstall.getString("EndPlace");
							startdate=rstall.getString("TripStartDate");
							enddate=rstall.getString("TripEndDate");
							kmcount=rstall.getInt("KmTraveled");
							//kmcountall=kmcountall+kmcount;
							oscount=rstall.getInt("OSCount");
							//oscountall=oscountall+oscount;
							racount=rstall.getInt("RACount");
							//racountall=racountall+racount;
							rdcount=rstall.getInt("RDCount");
							//rdcountall=rdcountall+Integer.valueOf(rdcount1);
							duration=rstall.getInt("OSDusration");
							//durationall+=rstt2.getInt("OSDusration");
							cdcountt=rstall.getString("CD");
							ndcountt=rstall.getString("ND");
							briefdone=rstall.getString("Briefing");
							brieftrainername=rstall.getString("BriefingTrainer");
							briefcomment=rstall.getString("BriefingComments");
							debriefdone=rstall.getString("Debriefing");
							debrieftrainername=rstall.getString("DebriefingTrainer");
							debriefcomment=rstall.getString("DebriefingComments");
							basic=rstall.getString("Basic");
							module1=rstall.getString("Module1");
							module2=rstall.getString("Module2");
							module3=rstall.getString("Module3");
							module4=rstall.getString("Module4");
							stdkm1=rstall.getString("StdKm");
							ttime1=rstall.getString("StdTime");
							category=rstall.getString("Category");
							
							///////////////////////////////////
							if(stdkm1.equalsIgnoreCase("NA"))
							{
								percnt=100;
							}
							else
							{
								percnt=Double.valueOf(kmcount)/Double.valueOf(stdkm1);
								percnt=percnt*100;
							}

						
					
			%>	
			<tr>
			<td><%=k%></td>
			<td><div align="left">
					<a href="javascript:toggleDetails(<%=k%>,true);" title="Click To See the Reports"><%=tripcount%></a><br />
					<div class="popup" id="popup<%=k%>">
					<table border="1" bgcolor="white">
<!--					<tr>-->
<!--					<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>-->
<!--					</td></tr>-->
					<tr>
					<td><a href="detailed_report.jsp?vehcode=<%=Vehid%>&fromdata=<%=startdate%>&todata=<%=enddate%>&submit=Submit" onclick="javascript:toggleDetails(<%=k%>,false);">Detail Report</a>
					</td>
					</tr>
					<tr><td><a href="javascript:toggleDetails(<%=k%>,false);">Close</a></td></tr>
					</table>
					</div> 
					</div></td>	
			<td>
			<div align="right">
			<%
				out.print(Vehregno);
			%>
			</div></td>
			
			<td>
			<div align="right">
			<%
				out.print(OwnerName);
			%>	
			</div></td>
			<td><div align="right"><%=drivercnt %></div></td>
			<td><div align="right"><%=drivername %></div></td>
			<td><div align="right"><%=startplace1 %></div></td>
			<td><div align="right">
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
			
			</div></td>
			<td><div align="right"><%=endplace %></div></td>
			<td>
			<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
			</div></td>
			<td><div align="right">
			<%
				out.print(stdkm1);
			%>
			</div>	
			</td>
			<td><div align="right">
			<%
				out.print(ttime1);
			%>
			</div>	
			</td>
			<td><div align="right">
			<%
				out.print(kmcount);
			%>
			</div>	
			</td>
			<td><div align="right">
			<%
				out.print(duration);
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(racount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapidacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(racount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(racount);
			}
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(rdcount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapiddeacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(rdcount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(rdcount);
			}
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(oscount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_osduration.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(oscount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(oscount);
			}
			%>
			</div></td>
			<td><div align="right">
			<%
			
			out.print(cdcountt);
			%>
			</div></td>
			<td><div align="right">
			<%
			out.print(ndcountt);
				
			%>
			</div></td>
			<td>
			<div align="right">
			<%
				Accelaration1=0;
				Decelaration1=0;
				OverSpeed1=0;
			if(racount > 0 && kmcount > 0)
			{
				Accelaration1=((double)racount/(double)kmcount)*100;
			}
			if(rdcount > 0 && kmcount > 0)
			{
				Decelaration1=((double)rdcount/(double)kmcount)*100;
			}
			if(duration > 0 && kmcount> 0)
			{
				OverSpeed1 =(((double)duration/10)/(double)kmcount)*100;
			}
			ratingcount=Accelaration1+Decelaration1+OverSpeed1;
			ratingcountall=ratingcountall+ratingcount;
			
			if(kmcount > 0)
			{
			out.print(nf.format(ratingcount));	
			}
			else
			{
				out.print("NA");
			}
			%>
			</div></td>
			
			<td><%=basic%></td>
			<td><%=module1%></td>
			<td><%=module2%></td>
			<td><%=module3%></td>
			<td><%=module4%></td>
			<td><%=briefdone%></td>
			<td><%=brieftrainername%></td>
			<td><%=briefcomment%></td>
			<td><%=debriefdone%></td>
			<td><%=debrieftrainername%></td>
			<td><%=debriefcomment%></td>
			<td>
			<%
			out.print(nf.format(percnt));	
			%>
			</td>
			<td><%=category%></td>
			
			</tr>			
			<%
						k++;
						
						}
						%>	
						<tr>
						<td class="hed" colspan="12">Total :-</td>
						
						<td class="hed"><div align="right"><%=kmcountall%></div></td>
						<td class="hed"><div align="right"><%=durationall%></div></td>
						<td class="hed"><div align="right"><%=racountall%></div></td>
						<td class="hed"><div align="right"><%=rdcountall%></div></td>
						<td class="hed"><div align="right"><%=oscountall%></div></td>
						<td class="hed"><div align="right"><%=cdcountall%></div></td>
						<td class="hed"><div align="right"><%=ndcountall%></div></td>
									
								<td class="hed"><div align="right">
						<%
						
						if(kmcountall!=0)
						{
							aa=Double.valueOf(racountall);
							aa=(aa/kmcountall);
							aa=aa*100;

							rr=Double.valueOf(rdcountall);
							rr=(rr/kmcountall);
							rr=rr*100;
							
							ss=Double.valueOf(durationall/10);
							ss=ss/kmcountall;
							ss=ss*100;
							
							rt=aa+rr+ss;;
						out.print(nf.format(rt));
						}
						else
						{
							out.print("NA");
						}
						%></div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						</tr>
						</table>
		<%
			}
		else
		{
			//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
			String sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount,count(Briefing) as tbcount from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty' and Briefing='briefed'";
			//System.out.println(sqll);
			ResultSet rstt=stt.executeQuery(sqll);
			while(rstt.next())
			{
				drivercountall=rstt.getInt("DriverID");
				
				tripcountall=rstt.getInt("TripID");
				
				vehcountall=rstt.getInt("Vehid");
				
						//kmcount=rstt.getInt("KmTraveled");
						kmcountall=rstt.getInt("KmTraveled");
						//oscount=rstt.getInt("OSDuration");
						oscountall=rstt.getInt("OSCount");
						//racount=rstt.getInt("RACount");
						racountall=rstt.getInt("RACount");
						//rdcount=rstt.getInt("RDCount");
						rdcountall=rstt.getInt("RDCount");
						//duration=rstt.getInt("OSDuration");
						durationall=rstt.getInt("OSDuration");
						tbcount=rstt.getInt("tbcount");
						//ndcountall1=rstt.getInt("NDCount");
						//cdcountall=rstt.getInt("CDCount");
			}
						
						String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty' and Briefing='briefed'";
						ResultSet rstcd=st.executeQuery(sql11);
						if(rstcd.next())
						{
							//cdcount=rstcd.getInt("cdcount1");
							cdcountall=rstcd.getInt("cdcount1");
							
						}
						
						String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
						ResultSet rstnd=st.executeQuery(sql12);
						if(rstnd.next())
						{
							//ndcount=rstnd.getInt("ndcount1");
							ndcountall=rstnd.getInt("ndcount1");
							
						}
						
						/*String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary' and status<>'Faulty' and ND='Yes'";
						ResultSet rstb=st.executeQuery(sql13);
						if(rstb.next())
						{
							//bcount=rstb.getInt("bcount1");
							tbcount=rstb.getInt("bcount1");
						}*/
						
						String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
						ResultSet rstdb=st.executeQuery(sql14);
						if(rstdb.next())
						{
							//dbcount=rstdb.getInt("dbcount1");
							tdbcount=rstdb.getInt("dbcount1");
						}
						
						String sqlall="Select * from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Briefing='briefed' and status<>'Faulty'";
						ResultSet rstall=st1.executeQuery(sqlall);
						while(rstall.next())
						{
							
							//System.out.println(sqlall);
							drivercount=rstall.getInt("DriverID");
							//System.out.println("drivercnt::>>>"+drivercount);
							tripcount=rstall.getInt("TripID");
							Vehid=rstall.getInt("Vehid");
							Vehregno=rstall.getString("vehregno");
							OwnerName=rstall.getString("Transporter");
							
							//////////////////////////////////////////////////////
							//vehcount=rstt2.getString("vehregno");
							//OwnerName=rstall.getString("Transporter");
							//Vehid=rstt2.getInt("Vehid");
							
							drivercnt=rstall.getString("DriverID");
							drivername=rstall.getString("DriverName");
							startplace1=rstall.getString("StartPlace");
							endplace=rstall.getString("EndPlace");
							startdate=rstall.getString("TripStartDate");
							enddate=rstall.getString("TripEndDate");
							kmcount=rstall.getInt("KmTraveled");
							//kmcountall=kmcountall+kmcount;
							oscount=rstall.getInt("OSCount");
							//oscountall=oscountall+oscount;
							racount=rstall.getInt("RACount");
							//racountall=racountall+racount;
							rdcount=rstall.getInt("RDCount");
							//rdcountall=rdcountall+Integer.valueOf(rdcount1);
							duration=rstall.getInt("OSDusration");
							//durationall+=rstt2.getInt("OSDusration");
							cdcountt=rstall.getString("CD");
							ndcountt=rstall.getString("ND");
							briefdone=rstall.getString("Briefing");
							brieftrainername=rstall.getString("BriefingTrainer");
							briefcomment=rstall.getString("BriefingComments");
							debriefdone=rstall.getString("Debriefing");
							debrieftrainername=rstall.getString("DebriefingTrainer");
							debriefcomment=rstall.getString("DebriefingComments");
							basic=rstall.getString("Basic");
							module1=rstall.getString("Module1");
							module2=rstall.getString("Module2");
							module3=rstall.getString("Module3");
							module4=rstall.getString("Module4");
							stdkm1=rstall.getString("StdKm");
							ttime1=rstall.getString("StdTime");
							category=rstall.getString("Category");
							
							///////////////////////////////////
							if(stdkm1.equalsIgnoreCase("NA"))
							{
								percnt=100;
							}
							else
							{
								percnt=Double.valueOf(kmcount)/Double.valueOf(stdkm1);
								percnt=percnt*100;
							}

						
					
			%>	
			<tr>
			<td><%=k%></td>
			<td><div align="left">
					<a href="javascript:toggleDetails(<%=k%>,true);" title="Click To See the Reports"><%=tripcount%></a><br />
					<div class="popup" id="popup<%=k%>">
					<table border="1" bgcolor="white">
<!--					<tr>-->
<!--					<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>-->
<!--					</td></tr>-->
					<tr>
					<td><a href="detailed_report.jsp?vehcode=<%=Vehid%>&fromdata=<%=startdate%>&todata=<%=enddate%>&submit=Submit" onclick="javascript:toggleDetails(<%=k%>,false);">Detail Report</a>
					</td>
					</tr>
					<tr><td><a href="javascript:toggleDetails(<%=k%>,false);">Close</a></td></tr>
					</table>
					</div> 
					</div></td>	
			<td>
			<div align="right">
			<%
				out.print(Vehregno);
			%>
			</div></td>
			
			<td>
			<div align="right">
			<%
				out.print(OwnerName);
			%>	
			</div></td>
			<td><div align="right"><%=drivercnt %></div></td>
			<td><div align="right"><%=drivername %></div></td>
			<td><div align="right"><%=startplace1 %></div></td>
			<td><div align="right">
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
			
			</div></td>
			<td><div align="right"><%=endplace %></div></td>
			<td>
			<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
			</div></td>
			<td><div align="right">
			<%
				out.print(stdkm1);
			%>
			</div>	
			</td>
			<td><div align="right">
			<%
				out.print(ttime1);
			%>
			</div>	
			</td>
			<td><div align="right">
			<%
				out.print(kmcount);
			%>
			</div>	
			</td>
			<td><div align="right">
			<%
				out.print(duration);
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(racount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapidacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(racount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(racount);
			}
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(rdcount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_rapiddeacc.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(rdcount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(rdcount);
			}
			%>
			</div></td>
			
			<td><div align="right">
			<%
			if(oscount > 0)
			{	
			%>
			<a href="#" onclick="javascript:window.open('KPI_osduration.jsp?vid=<%=Vehid%>&tripid=<%=tripcount%>&sdate=<%=startdate %>&edate=<%=enddate %>');">
			<%
				out.print(oscount);
			%>
			</a>
			<%
			}
			else
			{
				out.print(oscount);
			}
			%>
			</div></td>
			<td><div align="right">
			<%
			
			out.print(cdcountt);
			%>
			</div></td>
			<td><div align="right">
			<%
			out.print(ndcountt);
				
			%>
			</div></td>
			<td>
			<div align="right">
			<%
				Accelaration1=0;
				Decelaration1=0;
				OverSpeed1=0;
			if(racount > 0 && kmcount > 0)
			{
				Accelaration1=((double)racount/(double)kmcount)*100;
			}
			if(rdcount > 0 && kmcount > 0)
			{
				Decelaration1=((double)rdcount/(double)kmcount)*100;
			}
			if(duration > 0 && kmcount> 0)
			{
				OverSpeed1 =(((double)duration/10)/(double)kmcount)*100;
			}
			ratingcount=Accelaration1+Decelaration1+OverSpeed1;
			ratingcountall=ratingcountall+ratingcount;
			
			if(kmcount > 0)
			{
			out.print(nf.format(ratingcount));	
			}
			else
			{
				out.print("NA");
			}
			%>
			</div></td>
			
			<td><%=basic%></td>
			<td><%=module1%></td>
			<td><%=module2%></td>
			<td><%=module3%></td>
			<td><%=module4%></td>
			<td><%=briefdone%></td>
			<td><%=brieftrainername%></td>
			<td><%=briefcomment%></td>
			<td><%=debriefdone%></td>
			<td><%=debrieftrainername%></td>
			<td><%=debriefcomment%></td>
			<td>
			<%
			out.print(nf.format(percnt));	
			%>
			</td>
			<td><%=category%></td>
			
			</tr>			
			<%
						k++;
						
						}
						%>	
						<tr>
						<td class="hed" colspan="12">Total :-</td>
						
						<td class="hed"><div align="right"><%=kmcountall%></div></td>
						<td class="hed"><div align="right"><%=durationall%></div></td>
						<td class="hed"><div align="right"><%=racountall%></div></td>
						<td class="hed"><div align="right"><%=rdcountall%></div></td>
						<td class="hed"><div align="right"><%=oscountall%></div></td>
						<td class="hed"><div align="right"><%=cdcountall%></div></td>
						<td class="hed"><div align="right"><%=ndcountall%></div></td>
									
								<td class="hed"><div align="right">
						<%
						
						if(kmcountall!=0)
						{
							aa=Double.valueOf(racountall);
							aa=(aa/kmcountall);
							aa=aa*100;

							rr=Double.valueOf(rdcountall);
							rr=(rr/kmcountall);
							rr=rr*100;
							
							ss=Double.valueOf(durationall/10);
							ss=ss/kmcountall;
							ss=ss*100;
							
							rt=aa+rr+ss;;
						out.print(nf.format(rt));
						}
						else
						{
							out.print("NA");
						}
						%></div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						<td class="hed"><div align="right">-</div></td>
						</tr>
						</table>
		<%
			}
}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			conn.close();
		}
%>
</div></td></tr></table>
<%@ include file="footernew.jsp"%>
