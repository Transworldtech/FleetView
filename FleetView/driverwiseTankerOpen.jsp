<%@ include file="headernew.jsp"%>
<%
	response.setHeader("Cache-Control","no-cache");
  	response.setHeader("Pragma","no-cache");
  	response.setDateHeader ("Expires", 0);
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
<%!Connection conn, conn1;
	Statement st, st1, st2, st3, stmt1, stmt2, stmt3, stt, stmt5, stmt6,stmt7, stmt8, stmt9, stmt10,sten;
	String sql, data, data1, trips, sqll1, sqll2, sqll3, sqll4, sqll5, sqll6,sqll7, sqll8, sqll9, sqll10;
	String startplace, triptype;

	NumberFormat nf = DecimalFormat.getNumberInstance();%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);

		data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date1")));
		data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date2")));
		startplace=request.getParameter("startplace");
		//startplace=startplace.replace("and","&");
		triptype=request.getParameter("triptype");
		/*System.out.println("data----"+data);
		System.out.println("data1----"+data1);
		System.out.println("startplace----"+startplace);
		System.out.println("triptype----"+triptype);*/
		
		try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		
		st=conn.createStatement();
		st1=conn.createStatement();
		stt=conn.createStatement();
		
	
	}catch(Exception e)
	{
		out.print("Exception--->"+e);
	}
%>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td>
<table border="0" width="100%" align="center" bgcolor="white">

<tr><td>
<%
try{
if(!(null==request.getQueryString()))
{
%>
<table border="0" width="100%" align="center" class="stats">
<tr><td align="left"><div align="left"><font size="3" >Report No: 10.27.1</font></div></td></tr>
<tr><td>
<%

%>
<font size="2"><b>Tanker Open Trips Report for <%=startplace%> from <%=data%> to <%=data1%></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_transportertankeropen.jsp?startplace=<%=startplace.replace("&","and")%>&date1=<%=data %>&date2=<%=data1 %>&triptype=<%=triptype%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel_transportertankeropen.jsp?startplace=<%=startplace.replace("&","and")%>&date1=<%=data %>&date2=<%=data1 %>&triptype=<%=triptype%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
</div>
</td></tr>
</table>
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
			<td  class="hed"> Std Distance</td>
			<td  class="hed"> Std TransitTime</td>
			<td  class="hed"> Km Travelled</td>
			<td  class="hed"> OS Dur<br>(Sec)</br></td>
			<td  class="hed"> RA</td>
			<td  class="hed"> RD</td>
			<td  class="hed"> OS Count</td>
			<td  class="hed"> CD</td>
			<td  class="hed"> ND</td>
			
			<td  class="hed"> Rating</td>
			<td  class="hed"> Basic</td>
			<td  class="hed"> Module1</td>
			<td  class="hed"> Module2</td>
			<td  class="hed"> Module3</td>
			<td  class="hed"> Module4</td>
			<td  class="hed"> Briefing</td>
			<td  class="hed"> BriefingTrainer</td>
			<td  class="hed"> BriefingComments</td>
			<td  class="hed"> Debriefing</td>
			<td  class="hed"> DebriefingTrainer</td>
			<td  class="hed"> DebriefingComments</td>
			<td  class="hed"> % Data Captured</td>
			<td  class="hed"> Category</td>
			</tr>		
			
					<%
					data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
					data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
					
			double ratingcount,ratingcountall;
			double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
			double ss,aa,rr,rt;
			int i=1,k=1;			
			int kmcountall=0;
			int tripcountall=0;
			int drivercountall=0;
			 ratingcountall=0.0;
			int vehcountall=0;
			int oscountall=0;
			int racountall=0;
			int rdcountall=0;
			int cdcountall=0;
			int ndcountall=0;
			int countlatency=0;
			int durationall=0;
			int j=0;
			aa=0.0;
			ss=0.0;
			rr=0.0;
			rt=0.0;
			
			String vehcount="-";
			String tripcount="-";
			String drivercount="-";
			String cdcount="-";
			String ndcount="-";
			String drivername="-",startplace1="-",endplace="-",startdate="-",enddate="-",OwnerName="-";
			ratingcount=0.0;
			int kmcount=0;
			int oscount=0;
			int racount=0;
			int rdcount=0;
			int Vehid=0;
			int latency=0;
			int duration=0;
			int tbcount=0;
			int tdbcount=0;
			String basic="",Vehregno="",module1="",module2="",module3="",module4="",category="";
			String briefdone="",cdcountt="",ndcountt="",brieftrainername="",briefcomment="",debriefdone="",debrieftrainername="",debriefcomment="";
			double stdkm=0, ttime=0,percnt=0;
			String stdkm1="",ttime1="";
			%>
			
			<%
			if(triptype.equalsIgnoreCase("Started"))
			{
				String sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
			//	System.out.println(sqll);
				ResultSet rstt=stt.executeQuery(sqll);
				while(rstt.next())
				{

				//	System.out.println("Total Started Trips");
				
				//	System.out.println(sqll);
				
					/*int bcount=0;
					int dbcount=0;
				
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
					pbrief=0;pdebrief=0;*/
			
					//startplace=rstt.getString("StartPlace");
					
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
				
				}
				String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstcd=st.executeQuery(sql11);
				if(rstcd.next())
				{
					//cdcount=rstcd.getInt("cdcount1");
					cdcountall=rstcd.getInt("cdcount1");
					
				}
				
				
				String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstnd=st.executeQuery(sql12);
				if(rstnd.next())
				{
					//ndcount=rstnd.getInt("ndcount1");
					ndcountall=rstnd.getInt("ndcount1");
					
				}
				
				String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstb=st.executeQuery(sql13);
				if(rstb.next())
				{
					//bcount=rstb.getInt("bcount1");
					tbcount=rstb.getInt("bcount1");
				}
				
				String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstdb=st.executeQuery(sql14);
				if(rstdb.next())
				{
					//dbcount=rstdb.getInt("dbcount1");
					tdbcount=rstdb.getInt("dbcount1");
				}
				
				String sqlall="Select * from t_CastrolTripsStarted where TripStartDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstall=st1.executeQuery(sqlall);
				while(rstall.next())
				{
					//System.out.println(sqlall);
					drivercount=rstall.getString("DriverID");
					//System.out.println("drivercnt::>>>"+drivercount);
					tripcount=rstall.getString("TripID");
					Vehid=rstall.getInt("Vehid");
					Vehregno=rstall.getString("vehregno");
					OwnerName=rstall.getString("Transporter");
					
					//////////////////////////////////////////////////////
					//vehcount=rstt2.getString("vehregno");
					//OwnerName=rstall.getString("Transporter");
					//Vehid=rstt2.getInt("Vehid");
					
					//drivercount=rstall.getString("DriverID");
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
<!--							<tr>-->
<!--							<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>-->
<!--							</td></tr>-->
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
					<td><div align="right"><%=drivercount %></div></td>
					<td><div align="right"><%=drivername %></div></td>
					<td><div align="right"><%=startplace1 %></div></td>
					<td><div align="right">
					<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
					
					</div></td>
					<td><div align="right"><%=endplace %></div></td>
					<td>
					<div align="right"><%=enddate%>
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
							//	System.out.println("Done..........");			
			
			
			}
			else if(triptype.equalsIgnoreCase("ended"))
			{
				String sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
			//	System.out.println(sqll);
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
				}
				
				String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstcd=st.executeQuery(sql11);
				if(rstcd.next())
				{
					//cdcount=rstcd.getInt("cdcount1");
					cdcountall=rstcd.getInt("cdcount1");
					
				}
				
				String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstnd=st.executeQuery(sql12);
				if(rstnd.next())
				{
					//ndcount=rstnd.getInt("ndcount1");
					ndcountall=rstnd.getInt("ndcount1");
					
				}
				
				String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstb=st.executeQuery(sql13);
				if(rstb.next())
				{
					//bcount=rstb.getInt("bcount1");
					tbcount=rstb.getInt("bcount1");
				}
				
				String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstdb=st.executeQuery(sql14);
				if(rstdb.next())
				{
					//dbcount=rstdb.getInt("dbcount1");
					tdbcount=rstdb.getInt("dbcount1");
				}
				
				String sqlall="Select * from t_CastrolTripsEnded where TripEndDate between '"+data+" 00:00:00' and '"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstall=st1.executeQuery(sqlall);
				while(rstall.next())
				{

					
					//System.out.println(sqlall);
					drivercount=rstall.getString("DriverID");
					//System.out.println("drivercnt::>>>"+drivercount);
					tripcount=rstall.getString("TripID");
					Vehid=rstall.getInt("Vehid");
					Vehregno=rstall.getString("vehregno");
					OwnerName=rstall.getString("Transporter");
					
					//////////////////////////////////////////////////////
					//vehcount=rstt2.getString("vehregno");
					//OwnerName=rstall.getString("Transporter");
					//Vehid=rstt2.getInt("Vehid");
					
					//drivercnt=rstall.getString("DriverID");
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
<!--			<tr>-->
<!--			<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>-->
<!--			</td></tr>-->
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
	<td><div align="right"><%=drivercount %></div></td>
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
			//	System.out.println("Done..........");
			}
			else
			{
				String sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+data+" 00:00:00' and TripEndDate<='"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
			//	System.out.println(sqll);
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
				}
				
				String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+data+" 00:00:00' and TripEndDate<='"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstcd=st.executeQuery(sql11);
				if(rstcd.next())
				{
					//cdcount=rstcd.getInt("cdcount1");
					cdcountall=rstcd.getInt("cdcount1");
					
				}
				
				String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+data+" 00:00:00' and TripEndDate<='"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstnd=st.executeQuery(sql12);
				if(rstnd.next())
				{
					//ndcount=rstnd.getInt("ndcount1");
					ndcountall=rstnd.getInt("ndcount1");
					
				}
				
				String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+data+" 00:00:00' and TripEndDate<='"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstb=st.executeQuery(sql13);
				if(rstb.next())
				{
					//bcount=rstb.getInt("bcount1");
					tbcount=rstb.getInt("bcount1");
				}
				
				String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+data+" 00:00:00' and TripEndDate<='"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstdb=st.executeQuery(sql14);
				if(rstdb.next())
				{
					//dbcount=rstdb.getInt("dbcount1");
					tdbcount=rstdb.getInt("dbcount1");
				}
				
				String sqlall="Select * from t_CastrolTripsStartEnded where TripStartDate>='"+data+" 00:00:00' and TripEndDate<='"+data1+" 23:59:59' and Category='Tanker' and status<>'Faulty' and Transporter='"+startplace+"' and tripenddate='NA'";
				ResultSet rstall=st1.executeQuery(sqlall);
				while(rstall.next())
				{

					
					//System.out.println(sqlall);
					drivercount=rstall.getString("DriverID");
					//System.out.println("drivercnt::>>>"+drivercount);
					tripcount=rstall.getString("TripID");
					Vehid=rstall.getInt("Vehid");
					Vehregno=rstall.getString("vehregno");
					OwnerName=rstall.getString("Transporter");
					
					//////////////////////////////////////////////////////
					//vehcount=rstt2.getString("vehregno");
					//OwnerName=rstall.getString("Transporter");
					//Vehid=rstt2.getInt("Vehid");
					
					//drivercnt=rstall.getString("DriverID");
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
<!--			<tr>-->
<!--			<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>-->
<!--			</td></tr>-->
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
	<td><div align="right"><%=drivercount %></div></td>
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
			//	System.out.println("Done..........");
			}
			%>	
			
<%
}
}catch(Exception ee)
{
	out.print("Exception---->"+ee);
}
finally
{
	conn.close();
	
}

%>
</td></tr>
</table>
</td></tr>
<tr><td><%@ include file="footernew.jsp"%></td></tr>
</table>
