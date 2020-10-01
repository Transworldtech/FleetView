<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn,conn1;
Statement st,st1,stt;
String fromdate, todate,sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sqll,datenew1,datenew2;
NumberFormat nf = DecimalFormat.getNumberInstance();
%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
String thename;


	
try
{
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	int cdcount,ndcount,kmcountall,kmcount,vvcount,vcountall,rcount,rcountall,lvcount,lvcountall,lrcount,lrcountall,zcount1,lcount,lcountall,zcountall1,tripcount,zcount,zcountall,drivercount,tripcountall,drivercountall,vehcount,vehcountall,oscount,oscountall,racount,racountall,rdcount,rdcountall,cdcountall,ndcountall,countlatency,latency,durationall,duration;
	String startplace,StartCode;
	double ratingcount,ratingcountall;
	double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
	String data1, data2,drivercnt,showdate1,showdate,Owner,datenew1,datenew2,transporter,sTripID="",cTripID="",TripID="";
	String fromdate="", todate="",sql="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="";
	double ss=0.00,aa=0.00,rr=0.00,rt=0.00;
	double percnt=0.0;
	double rtcount=0.00,dtcount=0.00, dtcount1=0.00;
	double rating1=0.00,rating=0.00;
	int i=0;
	String  vv="",ownerNm="",counDriveYesNo=null,ntDriveYesNo=null,sortby="-";
	int  stcount=0, runDuration=0,osduration=0,osduration1=0,tpcount=0,tpcount1=0,dcount=0,dcount1=0,vcount=0, vcount1=0,mydtcount=0,mydtcount1=0;
	int oscount1=0, racount1=0,rdcount1=0, ndcount1=0, stcount1=0,cdcount1=0,transportercount=0,runDuration1=0;
	int pbrief,pdebrief,totpbrief,totpdebrief;
	thename=request.getParameter("thename");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	String Transporter=session.getAttribute("usertypevalue").toString();
	 sortby=request.getParameter("sortby");
	 String rng=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
	if(!(null==sortby))
	{
		if(sortby.equals("trans"))
		{
			if(thename.equals("started"))
			{
				
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Contractor(Started)</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 
	</td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Contractor(Ended)</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	 
	</td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Contractor(Started And Ended )</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
		</td></tr>
				<%
			}
		}
		else if(sortby.equals("location"))
		{
			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Location(Started)</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	
	</td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Location(Ended)</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	
	</td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Location(Started And Ended)</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
		</td></tr>
				<%
			}
		}
		else 
		{

			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="2">Primary Auto Trips Captured For<%=rng%> -By Location(Started)</font></b></td></tr>
				 <tr><td>
	 <div class="bodyText" align="right">
	
	</td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Location(Ended)</font></b></td></tr>
				 <tr><td>
	
	</td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="2">Castrol Primary Auto Trips Captured For<%=rng%> -By Location(Started And Ended) </font></b></td></tr>
				 <tr><td>
	
	</td></tr>
				<%
			}
		
		}
	}
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

	st=conn.createStatement();
	st1=conn.createStatement();
	stt=conn.createStatement();
	
if(!(null==thename))
{ 
		//*********************************
	
	if(thename.equalsIgnoreCase("ended"))
	{
			if(sortby.equalsIgnoreCase("location" ))
			{
				%>
				<table border="1" width="100%" class="sortable">
				<tr>
				<td  class="hed"> Sr.</td>
				<td  class="hed"> Origin</td>
				<td  class="hed">Total Trips</td>
				<td  class="hed">Trips with zero violation</td>
				<td  class="hed">Trips with violation</td>
				<td  class="hed">Trips with NA rating</td>
				<td  class="hed"> Drivers</td>
				<td  class="hed"> Vehicles</td>
				<td  class="hed"> Km. Travelled</td>
				<td  class="hed"> OS Duration<br>(Sec)</br></td>
				<td  class="hed"> RA</td>
				<td  class="hed"> RD</td>
				<td  class="hed"> OS Count</td>
				<td  class="hed"> CD</td>
				<td  class="hed"> ND</td>
				<td  class="hed"> Briefed Trips</td>
				<td  class="hed"> De-Briefed Trips</td>
				<td  class="hed"> Rating</td>
				</tr>
					<%
					int k=1;			
					kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
					rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
					totpbrief=0;totpdebrief=0;lcount=0;lcountall=0;lvcount=0;lrcount=0;lvcountall=0;lrcountall=0;
					int tbcount=0;
					int tdbcount=0;
					String sqll1="select StartPlace,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and EndedBy='-' and tripenddate<>'NA' group by StartPlace order by StartPlace Asc";
				//	System.out.println(sqll1);
					ResultSet rstt1=stt.executeQuery(sqll1);
					while(rstt1.next())
					{
						int bcount=0;
						int dbcount=0;
						drivercount=0;
						ratingcount=0.0;
						vehcount=0;
						oscount=0;
						racount=0;
						rdcount=0;
						latency=0;
						oscount=0;
						racount=0;
						rdcount=0;
						cdcount=0;
						ndcount=0;
						latency=0;
						kmcount=0;
						duration=0;startplace="-";StartCode="-";
						pbrief=0;pdebrief=0;
				
						startplace=rstt1.getString("StartPlace");
						drivercount=rstt1.getInt("DriverID");
						drivercountall=drivercountall+rstt1.getInt("DriverID");
						tripcount=rstt1.getInt("TripID");
						tripcountall=tripcountall+rstt1.getInt("TripID");
						vehcount=rstt1.getInt("Vehid");
						vehcountall=vehcountall+rstt1.getInt("Vehid");
						
								kmcount=rstt1.getInt("KmTraveled");
								kmcountall=kmcountall+rstt1.getInt("KmTraveled");
								oscount=rstt1.getInt("OSCount");
								oscountall=oscountall+rstt1.getInt("OSCount");
								racount=rstt1.getInt("RACount");
								racountall=racountall+rstt1.getInt("RACount");
								rdcount=rstt1.getInt("RDCount");
								rdcountall=rdcountall+rstt1.getInt("RDCount");
								duration=rstt1.getInt("OSDuration");
								durationall=durationall+rstt1.getInt("OSDuration");
								
								String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstcd=st.executeQuery(sql11);
								if(rstcd.next())
								{
									cdcount=rstcd.getInt("cdcount1");
									cdcountall=cdcountall+rstcd.getInt("cdcount1");
									
								}
								
								String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstnd=st.executeQuery(sql12);
								if(rstnd.next())
								{
									ndcount=rstnd.getInt("ndcount1");
									ndcountall=ndcountall+rstnd.getInt("ndcount1");
									
								}
								
								String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstb=st.executeQuery(sql13);
								if(rstb.next())
								{
									bcount=rstb.getInt("bcount1");
									tbcount=tbcount+bcount;
								}
								
								String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and Category='Primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								//select * from db_gps.t_CastrolTripsStarted where Category ='Primary' and TripStartDate between '2010-05-01' and '2010-05-31 23:59:59' and Debriefing='Yes'
								ResultSet rstdb=st.executeQuery(sql14);
								if(rstdb.next())
								{
									dbcount=rstdb.getInt("dbcount1");
									tdbcount=tdbcount+rstdb.getInt("dbcount1");
								}
					 		
								
								String lsql="select count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  OSCount='0' and  RACount='0' and RDCount='0' and KmTraveled <>'0'  and  StartPlace  ='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet lrst=st.executeQuery(lsql);
								while(lrst.next())
								{
								     lcount=lrst.getInt("Trip");
									 lcountall=lcountall+lcount;
								    
								}
								   
								String lvsql="select count(TripID) as Trips from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and   StartPlace='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'  and  (OSCount>'0' or  RACount>'0' or RDCount>'0')  and KmTraveled <>'0' ";
								//System.out.println(sqll);
								ResultSet lvrst=st.executeQuery(lvsql);
								while(lvrst.next())
								{
								     lvcount=lvrst.getInt("Trips");
									 lvcountall=lvcountall+lvcount;
								    
								}
					
								String lrsql="select count(TripID) as Trips from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  KmTraveled=0 and StartPlace='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet lrrst=st.executeQuery(lrsql);
								while(lrrst.next())
								{
								     lrcount=lrrst.getInt("Trips");
									 lrcountall=lrcountall+lrcount;
								    
								}
								
						   			
					
					
					%>
					<tr>
					<td><%=k%></td>
					<td><div align="left"><%=startplace%>
					</div></td>
					
					<td>
					<div align="right">
					<%
						out.print(tripcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(lcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(lvcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(lrcount);
					%>	
					</div></td>
										<td>
					<div align="right">
					<%
						out.print(drivercount);
					%>
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(vehcount);
					%>
					</div></td>
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
						out.print(racount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(rdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(oscount);
					%>
					</div></td>
					<td><div align="right">
					<%
					
					out.print(cdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
					out.print(ndcount);
						
					%>
					</div></td>
					<td><%=bcount%></td>
					<td><%=dbcount%></td>
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
					</tr>			
					<%
					k++;
					
					}
					%>	
					<tr>
					<td class="hed" colspan="2">Total :-</td>
					<td class="hed"><div align="right"><%=tripcountall%></div></td>
					<td class="hed"><div align="right"><%=lcountall%></div></td>
					<td class="hed"><div align="right"><%=lvcountall%></div></td>
					<td class="hed"><div align="right"><%=lrcountall%></div></td>
					<td class="hed"><div align="right"><%=drivercountall%></div></td>
					<td class="hed"><div align="right"><%=vehcountall%></div></td>
					<td class="hed"><div align="right"><%=kmcountall%></div></td>
					<td class="hed"><div align="right"><%=durationall%></div></td>
					<td class="hed"><div align="right"><%=racountall%></div></td>
					<td class="hed"><div align="right"><%=rdcountall%></div></td>
					<td class="hed"><div align="right"><%=oscountall%></div></td>
					
					<td class="hed"><div align="right"><%=cdcountall%></div></td>
					<td class="hed"><div align="right"><%=ndcountall%></div></td>
						
						<td class="hed"><div align="right"><%=tbcount%></div></td>
						<td class="hed"><div align="right"><%=tdbcount%></div></td>
							
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
					</tr>
					</table>
					<% 
				//	System.out.println("Done..........");
					}

			else if(sortby.equalsIgnoreCase("trans" ))
			{
				
				
				%>
					<table border="1" width="100%" class="sortable">
				<tr>
				<td  class="hed"> Sr.</td>
				<td  class="hed"> Origin</td>
				<td  class="hed">Total Trips</td>
				<td  class="hed"> Trips with zero violation</td>
				<td  class="hed"> Trips with violation</td>
				<td  class="hed"> Trips with NA Rating</td>
				<td  class="hed"> Drivers</td>
				<td  class="hed"> Vehicles</td>
				<td  class="hed"> Km. Travelled</td>
				<td  class="hed"> OS Duration<br>(Sec)</br></td>
				<td  class="hed"> RA</td>
				<td  class="hed"> RD</td>
				<td  class="hed"> OS Count</td>
				<td  class="hed"> CD</td>
				<td  class="hed"> ND</td>
				<td  class="hed"> Briefed Trips</td>
				<td  class="hed"> De-Briefed Trips</td>
				<td  class="hed"> Rating</td>
				</tr>
					<%
					
				 			
					int k=1;			
					kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
					rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
					totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;vvcount=0;vcountall=0;rcount=0;rcountall=0;
					int tbcount=0;
					int tdbcount=0;
					//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
					sqll="select Transporter,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and EndedBy='-' and tripenddate<>'NA' group by Transporter order by Transporter Asc";
					//System.out.println(sqll);
					ResultSet rstt=stt.executeQuery(sqll);
					while(rstt.next())
					{
						int bcount=0;
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
						pbrief=0;pdebrief=0;
				
						startplace=rstt.getString("Transporter");
						drivercount=rstt.getInt("DriverID");
						drivercountall=drivercountall+rstt.getInt("DriverID");
						tripcount=rstt.getInt("TripID");
						tripcountall=tripcountall+rstt.getInt("TripID");
						vehcount=rstt.getInt("Vehid");
						vehcountall=vehcountall+rstt.getInt("Vehid");
						
								kmcount=rstt.getInt("KmTraveled");
								kmcountall=kmcountall+rstt.getInt("KmTraveled");
								oscount=rstt.getInt("OSCount");
								oscountall=oscountall+rstt.getInt("OSCount");
								racount=rstt.getInt("RACount");
								racountall=racountall+rstt.getInt("RACount");
								rdcount=rstt.getInt("RDCount");
								rdcountall=rdcountall+rstt.getInt("RDCount");
								duration=rstt.getInt("OSDuration");
								durationall=durationall+rstt.getInt("OSDuration");
								
								String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstcd=st.executeQuery(sql11);
								if(rstcd.next())
								{
									cdcount=rstcd.getInt("cdcount1");
									cdcountall=cdcountall+rstcd.getInt("cdcount1");
									
								}
								
								String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstnd=st.executeQuery(sql12);
								if(rstnd.next())
								{
									ndcount=rstnd.getInt("ndcount1");
									ndcountall=ndcountall+rstnd.getInt("ndcount1");
									
								}
								
								String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstb=st.executeQuery(sql13);
								if(rstb.next())
								{
									bcount=rstb.getInt("bcount1");
									tbcount=tbcount+bcount;
								}
								
								String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and Category='Primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								//select * from db_gps.t_CastrolTripsStarted where Category ='Primary' and TripStartDate between '2010-05-01' and '2010-05-31 23:59:59' and Debriefing='Yes'
								ResultSet rstdb=st.executeQuery(sql14);
								if(rstdb.next())
								{
									dbcount=rstdb.getInt("dbcount1");
									tdbcount=tdbcount+rstdb.getInt("dbcount1");
								}
							
					
								String zsql="select Transporter,count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  OSCount='0' and  RACount='0' and RDCount='0' and  KmTraveled<>'0'  and Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet zrst=st.executeQuery(zsql);
								while(zrst.next())
								{
								     zcount=zrst.getInt("Trip");
									 zcountall=zcountall+zcount;
								    
								}
								  
					
					
								String vsql="select count(TripID) as Trips from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and   Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA' and  (OSCount>'0' or  RACount>'0' or RDCount>'0')  and  KmTraveled<>'0'";
								//System.out.println(sqll);
								ResultSet vrst=st.executeQuery(vsql);
								while(vrst.next())
								{
								     vvcount=vrst.getInt("Trips");
									 vcountall=vcountall+vvcount;
								    
								}
					
								String rsql="select count(TripID) as Trips from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  KmTraveled=0 and Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet rrst=st.executeQuery(rsql);
								while(rrst.next())
								{
								     rcount=rrst.getInt("Trips");
									 rcountall=rcountall+rcount;
								    
								}
					
					%>	
					<tr>
					<td><%=k%></td>
					<td><div align="left"><%=startplace%>
					</div></td>
					
					<td>
					<div align="right">
					<%
						out.print(tripcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(zcount);
					%>	
					</div></td>
						<td>
					<div align="right">
					<%
						out.print(vvcount);
					%>	
					</div></td>
						<td>
					<div align="right">
					<%
						out.print(rcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(drivercount);
					%>
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(vehcount);
					%>
					</div></td>
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
						out.print(racount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(rdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(oscount);
					%>
					</div></td>
					<td><div align="right">
					<%
					
					out.print(cdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
					out.print(ndcount);
						
					%>
					</div></td>
					<td><%=bcount%></td>
					<td><%=dbcount%></td>
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
					</tr>			
					<%
					k++;
					
					}
					%>	
					<tr>
					<td class="hed" colspan="2">Total :-</td>
					<td class="hed"><div align="right"><%=tripcountall%></div></td>
					<td class="hed"><div align="right"><%=zcountall%></div></td>
					<td class="hed"><div align="right"><%=vcountall%></div></td>
					<td class="hed"><div align="right"><%=rcountall%></div></td>
					<td class="hed"><div align="right"><%=drivercountall%></div></td>
					<td class="hed"><div align="right"><%=vehcountall%></div></td>
					<td class="hed"><div align="right"><%=kmcountall%></div></td>
					<td class="hed"><div align="right"><%=durationall%></div></td>
					<td class="hed"><div align="right"><%=racountall%></div></td>
					<td class="hed"><div align="right"><%=rdcountall%></div></td>
					<td class="hed"><div align="right"><%=oscountall%></div></td>
					<td class="hed"><div align="right"><%=cdcountall%></div></td>
					<td class="hed"><div align="right"><%=ndcountall%></div></td>
						
						<td class="hed"><div align="right"><%=tbcount%></div></td>
						<td class="hed"><div align="right"><%=tdbcount%></div></td>
							
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
					</tr>
					</table>
					<% 
					//System.out.println("Done..........");
					}//end of ended transwise loop
		//***************************************Ended all trips**************************************************
			else
			{
				
				%>
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
		pbrief=0;pdebrief=0;
		//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
		sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
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
		}
					
					String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstcd=st.executeQuery(sql11);
					if(rstcd.next())
					{
						//cdcount=rstcd.getInt("cdcount1");
						cdcountall=rstcd.getInt("cdcount1");
						
					}
					
					String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstnd=st.executeQuery(sql12);
					if(rstnd.next())
					{
						//ndcount=rstnd.getInt("ndcount1");
						ndcountall=rstnd.getInt("ndcount1");
						
					}
					
					String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstb=st.executeQuery(sql13);
					if(rstb.next())
					{
						//bcount=rstb.getInt("bcount1");
						tbcount=rstb.getInt("bcount1");
					}
					
					String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstdb=st.executeQuery(sql14);
					if(rstdb.next())
					{
						//dbcount=rstdb.getInt("dbcount1");
						tdbcount=rstdb.getInt("dbcount1");
					}
					
					String sqlall="Select * from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
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
				<tr>
				<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>
				</td></tr>
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
			out.print(racount);
		%>
		</div></td>
		<td><div align="right">
		<%
			out.print(rdcount);
		%>
		</div></td>
		<td><div align="right">
		<%
			out.print(oscount);
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
					//System.out.println("Done..........");
		}
		
	
	}

///************************************************STARTED**********************************************************************************************	
	else if(thename.equalsIgnoreCase("started"))
	{
			// In stared loop all data is come from t_ complited journey..
		//System.out.println("Start....");
			if(sortby.equalsIgnoreCase("location" ))
			{
				
				
				%>
					<table border="1" width="100%" class="sortable">
				<tr>
				<td  class="hed"> Sr.</td>
				<td  class="hed"> Origin</td>
				<td  class="hed">Totlal Trips</td>
				<td  class="hed">Trips With zero violation</td>
				<td  class="hed">Trips With violation</td>
				<td  class="hed">Trips With NA rating</td>
				<td  class="hed"> Drivers</td>
				<td  class="hed"> Vehicles</td>
				<td  class="hed"> Km. Travelled</td>
				<td  class="hed"> OS Duration<br>(Sec)</br></td>
				<td  class="hed"> RA</td>
				<td  class="hed"> RD</td>
				<td  class="hed"> OS Count</td>
				<td  class="hed"> CD</td>
				<td  class="hed"> ND</td>
				<td  class="hed"> Briefed Trips</td>
				<td  class="hed"> De-Briefed Trips</td>
				<td  class="hed"> Rating</td>
				</tr>
					<%
					
				 			
					int k=1;			
					kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
					rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
					totpbrief=0;totpdebrief=0;lcount=0;lcountall=0;lvcount=0;lrcount=0;lvcountall=0;lrcountall=0;
					int tbcount=0;
					int tdbcount=0;
					//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
					sqll="select StartPlace,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and EndedBy='-' and tripenddate<>'NA' group by StartPlace order by StartPlace Asc";
				//	System.out.println(sqll);
					ResultSet rstt=stt.executeQuery(sqll);
					while(rstt.next())
					{
						int bcount=0;
						int dbcount=0;
						drivercount=0;
						ratingcount=0.0;
						vehcount=0;
						oscount=0;
						racount=0;
						rdcount=0;
						//cdcount=0;
						//ndcount=0;
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
						pbrief=0;pdebrief=0;
				
						startplace=rstt.getString("StartPlace");
						drivercount=rstt.getInt("DriverID");
						drivercountall=drivercountall+rstt.getInt("DriverID");
						tripcount=rstt.getInt("TripID");
						tripcountall=tripcountall+rstt.getInt("TripID");
						vehcount=rstt.getInt("Vehid");
						vehcountall=vehcountall+rstt.getInt("Vehid");
						
								kmcount=rstt.getInt("KmTraveled");
								kmcountall=kmcountall+rstt.getInt("KmTraveled");
								oscount=rstt.getInt("OSCount");
								oscountall=oscountall+rstt.getInt("OSCount");
								racount=rstt.getInt("RACount");
								racountall=racountall+rstt.getInt("RACount");
								rdcount=rstt.getInt("RDCount");
								rdcountall=rdcountall+rstt.getInt("RDCount");
								duration=rstt.getInt("OSDuration");
								durationall=durationall+duration;
								
								String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstcd=st.executeQuery(sql11);
								if(rstcd.next())
								{
									cdcount=rstcd.getInt("cdcount1");
									cdcountall=cdcountall+rstcd.getInt("cdcount1");
									
								}
								
								String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstnd=st.executeQuery(sql12);
								if(rstnd.next())
								{
									ndcount=rstnd.getInt("ndcount1");
									ndcountall=ndcountall+rstnd.getInt("ndcount1");
									
								}
								
								String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   and Category='primary' and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstb=st.executeQuery(sql13);
								if(rstb.next())
								{
									bcount=rstb.getInt("bcount1");
									tbcount=tbcount+bcount;
								}
								
								String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'    and Category='Primary' and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA' ";
								//select * from db_gps.t_CastrolTripsStarted where Category ='Primary' and TripStartDate between '2010-05-01' and '2010-05-31 23:59:59' and Debriefing='Yes'
								ResultSet rstdb=st.executeQuery(sql14);
								if(rstdb.next())
								{
									dbcount=rstdb.getInt("dbcount1");
									tdbcount=tdbcount+rstdb.getInt("dbcount1");
								}
							
					

								String lsql="select count(TripID) as Trip from t_CastrolTripsStarted  where TripStartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  OSCount='0' and  RACount='0' and RDCount='0' and  KmTraveled<>'0'  and  StartPlace  ='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet lrst=st.executeQuery(lsql);
								while(lrst.next())
								{
								     lcount=lrst.getInt("Trip");
									 lcountall=lcountall+lcount;
								    
								}
								   
								String lvsql="select count(TripID) as Trips from t_CastrolTripsStarted where TripStartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and   StartPlace='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA' and (OSCount>'0' or  RACount>'0' or RDCount>'0')  and  KmTraveled<>'0'";
								//System.out.println(sqll);
								ResultSet lvrst=st.executeQuery(lvsql);
								while(lvrst.next())
								{
								     lvcount=lvrst.getInt("Trips");
									 lvcountall=lvcountall+lvcount;
								    
								}
					
								String lrsql="select count(TripID) as Trips from t_CastrolTripsStarted  where TripStartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  KmTraveled=0 and StartPlace='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet lrrst=st.executeQuery(lrsql);
								while(lrrst.next())
								{
								     lrcount=lrrst.getInt("Trips");
									 lrcountall=lrcountall+lrcount;
								    
								}      
					
					
					%>	
					<tr>
					<td><%=k%></td>
					<td><div align="left"><%=startplace%>
					</div></td>
					
					<td>
					<div align="right">
					<%
						out.print(tripcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(lcount);
					%>	
					</div></td>
						<td>
					<div align="right">
					<%
						out.print(lvcount);
					%>	
					</div></td>
						<td>
					<div align="right">
					<%
						out.print(lrcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(drivercount);
					%>
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(vehcount);
					%>
					</div></td>
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
						out.print(racount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(rdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(oscount);
					%>
					</div></td>
					<td><div align="right">
					<%
					
					out.print(cdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
					out.print(ndcount);
						
					%>
					</div></td>
					<td><%=bcount%></td>
					<td><%=dbcount%></td>
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
					</tr>			
					<%
					k++;
					
					}
					%>	
					<tr>
					<td class="hed" colspan="2">Total :-</td>
					<td class="hed"><div align="right"><%=tripcountall%></div></td>
					<td class="hed"><div align="right"><%=lcountall%></div></td>
						<td class="hed"><div align="right"><%=lvcountall%></div></td>
							<td class="hed"><div align="right"><%=lrcountall%></div></td>
					<td class="hed"><div align="right"><%=drivercountall%></div></td>
					<td class="hed"><div align="right"><%=vehcountall%></div></td>
					<td class="hed"><div align="right"><%=kmcountall%></div></td>
					<td class="hed"><div align="right"><%=durationall%></div></td>
					<td class="hed"><div align="right"><%=racountall%></div></td>
					<td class="hed"><div align="right"><%=rdcountall%></div></td>
					<td class="hed"><div align="right"><%=oscountall%></div></td>
					<td class="hed"><div align="right"><%=cdcountall%></div></td>
					<td class="hed"><div align="right"><%=ndcountall%></div></td>
						
						<td class="hed"><div align="right"><%=tbcount%></div></td>
						<td class="hed"><div align="right"><%=tdbcount%></div></td>
							
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
					</tr>
					</table>
					<% 
				//	System.out.println("Done..........");
					}

			else if(sortby.equalsIgnoreCase("trans" ))
			{
				
				
				%>
					<table border="1" width="100%" class="sortable">
				<tr>
				<td  class="hed"> Sr.</td>
				<td  class="hed"> Origin</td>
				<td  class="hed">Total Trips</td>
				<td  class="hed"> Trips with zero violation</td>
				<td  class="hed"> Trips with violation</td>
				<td  class="hed"> Trips with NA Rating</td>
				<td  class="hed"> Drivers</td>
				<td  class="hed"> Vehicles</td>
				<td  class="hed"> Km. Travelled</td>
				<td  class="hed"> OS Duration<br>(Sec)</br></td>
				<td  class="hed"> RA</td>
				<td  class="hed"> RD</td>
				<td  class="hed"> OS Count</td>
				<td  class="hed"> CD</td>
				<td  class="hed"> ND</td>
				<td  class="hed"> Briefed Trips</td>
				<td  class="hed"> De-Briefed Trips</td>
				<td  class="hed"> Rating</td>
				</tr>
					<%
					
				 			
					int k=1;			
					kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
					rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
					totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;vvcount=0;rcount=0;vcountall=0;rcountall=0;
					int tbcount=0;
					int tdbcount=0;
					//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
					sqll="select Transporter,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and EndedBy='-' and tripenddate<>'NA' group by Transporter order by Transporter Asc";
				//	System.out.println(sqll);
					ResultSet rstt=stt.executeQuery(sqll);
					while(rstt.next())
					{
						int bcount=0;
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
						pbrief=0;pdebrief=0;
				
						startplace=rstt.getString("Transporter");
						drivercount=rstt.getInt("DriverID");
						drivercountall=drivercountall+rstt.getInt("DriverID");
						tripcount=rstt.getInt("TripID");
						tripcountall=tripcountall+rstt.getInt("TripID");
						vehcount=rstt.getInt("Vehid");
						vehcountall=vehcountall+rstt.getInt("Vehid");
						
								kmcount=rstt.getInt("KmTraveled");
								kmcountall=kmcountall+rstt.getInt("KmTraveled");
								oscount=rstt.getInt("OSCount");
								oscountall=oscountall+rstt.getInt("OSCount");
								racount=rstt.getInt("RACount");
								racountall=racountall+rstt.getInt("RACount");
								rdcount=rstt.getInt("RDCount");
								rdcountall=rdcountall+rstt.getInt("RDCount");
								duration=rstt.getInt("OSDuration");
								durationall=durationall+duration;
								
								String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstcd=st.executeQuery(sql11);
								if(rstcd.next())
								{
									cdcount=rstcd.getInt("cdcount1");
									cdcountall=cdcountall+rstcd.getInt("cdcount1");
									
								}
								
								String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								ResultSet rstnd=st.executeQuery(sql12);
								if(rstnd.next())
								{
									ndcount=rstnd.getInt("ndcount1");
									ndcountall=ndcountall+rstnd.getInt("ndcount1");
									
								}
								
								String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA' ";
								ResultSet rstb=st.executeQuery(sql13);
								if(rstb.next())
								{
									bcount=rstb.getInt("bcount1");
									tbcount=tbcount+bcount;
								}
								
								String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and Category='Primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
								//select * from db_gps.t_CastrolTripsStarted where Category ='Primary' and TripStartDate between '2010-05-01' and '2010-05-31 23:59:59' and Debriefing='Yes'
								ResultSet rstdb=st.executeQuery(sql14);
								if(rstdb.next())
								{
									dbcount=rstdb.getInt("dbcount1");
									tdbcount=tdbcount+rstdb.getInt("dbcount1");
								}
							
								String zsql="select count(TripID) as Trip from t_CastrolTripsStarted where TripStartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   and OSCount='0' and RACount='0' and RDCount='0' and  KmTraveled<>'0'  and Transporter='"+startplace+"' and Category='Primary'   and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet zrst=st.executeQuery(zsql);
								while(zrst.next())
								{
								     zcount=zrst.getInt("Trip");
									 zcountall=zcountall+zcount;
								    
								}
								
					

								String vsql="select count(TripID) as Trips from  t_CastrolTripsStarted  where TripStartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and   Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA' and  KmTraveled<>'0'  and (OSCount>'0' or  RACount>'0' or RDCount>'0') ";
								//System.out.println(sqll);
								ResultSet vrst=st.executeQuery(vsql);
								while(vrst.next())
								{
								     vvcount=vrst.getInt("Trips");
									 vcountall=vcountall+vvcount;
								    
								}
					
								String rsql="select count(TripID) as Trips from  t_CastrolTripsStarted  where TripStartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and  KmTraveled=0 and Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
								//System.out.println(sqll);
								ResultSet rrst=st.executeQuery(rsql);
								while(rrst.next())
								{
								     rcount=rrst.getInt("Trips");
									 rcountall=rcountall+rcount;
								    
								}
					
					
					%>	
					<tr>
					<td><%=k%></td>
					<td><div align="left"><%=startplace%>
					</div></td>
					
					<td>
					<div align="right">
					<%
						out.print(tripcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(zcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(vvcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(rcount);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(drivercount);
					%>
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(vehcount);
					%>
					</div></td>
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
						out.print(racount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(rdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
						out.print(oscount);
					%>
					</div></td>
					<td><div align="right">
					<%
					
					out.print(cdcount);
					%>
					</div></td>
					<td><div align="right">
					<%
					out.print(ndcount);
						
					%>
					</div></td>
					<td><%=bcount%></td>
					<td><%=dbcount%></td>
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
					</tr>			
					<%
					k++;
					
					}
					%>	
					<tr>
					<td class="hed" colspan="2">Total :-</td>
					<td class="hed"><div align="right"><%=tripcountall%></div></td>
					<td class="hed"><div align="right"><%=zcountall%></div></td>
					<td class="hed"><div align="right"><%=vcountall%></div></td>
					<td class="hed"><div align="right"><%=rcountall%></div></td>
					<td class="hed"><div align="right"><%=drivercountall%></div></td>
					<td class="hed"><div align="right"><%=vehcountall%></div></td>
					<td class="hed"><div align="right"><%=kmcountall%></div></td>
					<td class="hed"><div align="right"><%=durationall%></div></td>
					<td class="hed"><div align="right"><%=racountall%></div></td>
					<td class="hed"><div align="right"><%=rdcountall%></div></td>
					<td class="hed"><div align="right"><%=oscountall%></div></td>
					<td class="hed"><div align="right"><%=cdcountall%></div></td>
					<td class="hed"><div align="right"><%=ndcountall%></div></td>
						
						<td class="hed"><div align="right"><%=tbcount%></div></td>
						<td class="hed"><div align="right"><%=tdbcount%></div></td>
							
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
					</tr>
					</table>
					<% 
					//System.out.println("Done..........");
					}//end of started if transwise
		//***************************************started all trips**************************************************
			else
			{
				
				%>
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
		pbrief=0;pdebrief=0;
		//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
		sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
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
		}
					
					String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstcd=st.executeQuery(sql11);
					if(rstcd.next())
					{
						//cdcount=rstcd.getInt("cdcount1");
						cdcountall=rstcd.getInt("cdcount1");
						
					}
					
					
					String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstnd=st.executeQuery(sql12);
					if(rstnd.next())
					{
						//ndcount=rstnd.getInt("ndcount1");
						ndcountall=rstnd.getInt("ndcount1");
						
					}
					
					String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstb=st.executeQuery(sql13);
					if(rstb.next())
					{
						//bcount=rstb.getInt("bcount1");
						tbcount=rstb.getInt("bcount1");
					}
					
					String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
					ResultSet rstdb=st.executeQuery(sql14);
					if(rstdb.next())
					{
						//dbcount=rstdb.getInt("dbcount1");
						tdbcount=rstdb.getInt("dbcount1");
					}
					
					String sqlall="Select * from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
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
							percnt=100.0;
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
				<tr>
				<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>
				</td></tr>
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
try
{
%>
	<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
	</div>
<%
}
catch(Exception e)
{
		out.print(enddate);
}
%>
		</td>
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
			out.print(racount);
		%>
		</div></td>
		<td><div align="right">
		<%
			out.print(rdcount);
		%>
		</div></td>
		<td><div align="right">
		<%
			out.print(oscount);
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
		//			System.out.println("Done..........");
		}
		
	
	}//end of else if started
	else if(thename.equalsIgnoreCase("both"))
	{
		// In stared loop all data is come from t_ complited journey..

		if(sortby.equalsIgnoreCase("location" ))
		{
			
			
			%>
				<table border="1" width="100%" class="sortable">
			<tr>
			<td  class="hed"> Sr.</td>
			<td  class="hed"> Origin</td>
			<td  class="hed">Total Trips</td>
			<td  class="hed">Trips with zero violation</td>
			<td  class="hed">Trips with violation</td>
			<td  class="hed">Trips with NA rating</td>
			<td  class="hed"> Drivers</td>
			<td  class="hed"> Vehicles</td>
			<td  class="hed"> Km. Travelled</td>
			<td  class="hed"> OS Duration<br>(Sec)</br></td>
			<td  class="hed"> RA</td>
			<td  class="hed"> RD</td>
			<td  class="hed"> OS Count</td>
			<td  class="hed"> CD</td>
			<td  class="hed"> ND</td>
			<td  class="hed"> Briefed Trips</td>
			<td  class="hed"> De-Briefed Trips</td>
			<td  class="hed"> Rating</td>
			</tr>
				<%
				
			 			
				int k=1;			
				kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
				rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
				totpbrief=0;totpdebrief=0;lcount=0;lcountall=0;lvcount=0;lrcount=0;lvcountall=0;lrcountall=0;
				int tbcount=0;
				int tdbcount=0;
				//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
				sqll="select StartPlace,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and EndedBy='-' and tripenddate<>'NA' group by StartPlace order by StartPlace Asc";
			//	System.out.println(sqll);
				ResultSet rstt=stt.executeQuery(sqll);
				while(rstt.next())
				{
					int bcount=0;
					int dbcount=0;
					drivercount=0;
					ratingcount=0.0;
					vehcount=0;
					oscount=0;
					racount=0;
					rdcount=0;
					//cdcount=0;
					//ndcount=0;
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
					pbrief=0;pdebrief=0;
			
					startplace=rstt.getString("StartPlace");
					drivercount=rstt.getInt("DriverID");
					drivercountall=drivercountall+rstt.getInt("DriverID");
					tripcount=rstt.getInt("TripID");
					tripcountall=tripcountall+rstt.getInt("TripID");
					vehcount=rstt.getInt("Vehid");
					vehcountall=vehcountall+rstt.getInt("Vehid");
					
							kmcount=rstt.getInt("KmTraveled");
							kmcountall=kmcountall+rstt.getInt("KmTraveled");
							oscount=rstt.getInt("OSCount");
							oscountall=oscountall+rstt.getInt("OSCount");
							racount=rstt.getInt("RACount");
							racountall=racountall+rstt.getInt("RACount");
							rdcount=rstt.getInt("RDCount");
							rdcountall=rdcountall+rstt.getInt("RDCount");
							duration=rstt.getInt("OSDuration");
							durationall=durationall+rstt.getInt("OSDuration");
							
							String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
							ResultSet rstcd=st.executeQuery(sql11);
							if(rstcd.next())
							{
								cdcount=rstcd.getInt("cdcount1");
								cdcountall=cdcountall+rstcd.getInt("cdcount1");
								
							}
							
							String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
							ResultSet rstnd=st.executeQuery(sql12);
							if(rstnd.next())
							{
								ndcount=rstnd.getInt("ndcount1");
								ndcountall=ndcountall+rstnd.getInt("ndcount1");
								
							}
							
							String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
							ResultSet rstb=st.executeQuery(sql13);
							if(rstb.next())
							{
								bcount=rstb.getInt("bcount1");
								tbcount=tbcount+bcount;
							}
							
							String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'  and Category='Primary'   and StartPlace='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
							//select * from db_gps.t_CastrolTripsStarted where Category ='Primary' and TripStartDate between '2010-05-01' and '2010-05-31 23:59:59' and Debriefing='Yes'
							ResultSet rstdb=st.executeQuery(sql14);
							if(rstdb.next())
							{
								dbcount=rstdb.getInt("dbcount1");
								tdbcount=tdbcount+rstdb.getInt("dbcount1");
							}
						

							String lsql="select count(TripID) as Trip from t_CastrolTripsStartEnded  where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'  and  OSCount='0' and  RACount='0' and RDCount='0' and  KmTraveled<>'0' and  StartPlace  ='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
							//System.out.println(sqll);
							ResultSet lrst=st.executeQuery(lsql);
							while(lrst.next())
							{
							     lcount=lrst.getInt("Trip");
								 lcountall=lcountall+lcount;
							    
							}
							   
							String lvsql="select count(TripID) as Trips from t_CastrolTripsStartEnded  where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and   StartPlace='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'  and (OSCount>'0' or  RACount>'0' or RDCount>'0')  and  KmTraveled<>'0' ";
							//System.out.println(sqll);
							ResultSet lvrst=st.executeQuery(lvsql);
							while(lvrst.next())
							{
							     lvcount=lvrst.getInt("Trips");
								 lvcountall=lvcountall+lvcount;
							    
							}
				
							String lrsql="select count(TripID) as Trips from t_CastrolTripsStartEnded   where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'  and  KmTraveled=0 and StartPlace='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
							//System.out.println(sqll);
							ResultSet lrrst=st.executeQuery(lrsql);
							while(lrrst.next())
							{
							     lrcount=lrrst.getInt("Trips");
								 lrcountall=lrcountall+lrcount;
							    
							}      
				      
				
				
				%>	
				<tr>
				<td><%=k%></td>
				<td><div align="left"><%=startplace%>
				</div></td>
				
				<td>
				<div align="right">
				<%
					out.print(tripcount);
				%>	
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(lcount);
				%>	
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(lvcount);
				%>	
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(lrcount);
				%>	
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(drivercount);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(vehcount);
				%>
				</div></td>
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
					out.print(racount);
				%>
				</div></td>
				<td><div align="right">
				<%
					out.print(rdcount);
				%>
				</div></td>
				<td><div align="right">
				<%
					out.print(oscount);
				%>
				</div></td>
				<td><div align="right">
				<%
				
				out.print(cdcount);
				%>
				</div></td>
				<td><div align="right">
				<%
				out.print(ndcount);
					
				%>
				</div></td>
				<td><%=bcount%></td>
				<td><%=dbcount%></td>
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
				</tr>			
				<%
				k++;
				
				}
				%>	
				<tr>
				<td class="hed" colspan="2">Total :-</td>
				<td class="hed"><div align="right"><%=tripcountall%></div></td>
				<td class="hed"><div align="right"><%=lcountall%></div></td>
				<td class="hed"><div align="right"><%=lvcountall%></div></td>
				<td class="hed"><div align="right"><%=lrcountall%></div></td>
				<td class="hed"><div align="right"><%=drivercountall%></div></td>
				<td class="hed"><div align="right"><%=vehcountall%></div></td>
				<td class="hed"><div align="right"><%=kmcountall%></div></td>
				<td class="hed"><div align="right"><%=durationall%></div></td>
				<td class="hed"><div align="right"><%=racountall%></div></td>
				<td class="hed"><div align="right"><%=rdcountall%></div></td>
				<td class="hed"><div align="right"><%=oscountall%></div></td>
				<td class="hed"><div align="right"><%=cdcountall%></div></td>
				<td class="hed"><div align="right"><%=ndcountall%></div></td>
					
					<td class="hed"><div align="right"><%=tbcount%></div></td>
					<td class="hed"><div align="right"><%=tdbcount%></div></td>
						
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
				</tr>
				</table>
				<% 
				//System.out.println("Done..........");
				}//End of both loc wise

				else if(sortby.equalsIgnoreCase("trans" ))

		{
					
					
					%>
						<table border="1" width="100%" class="sortable">
					<tr>
					<td  class="hed"> Sr.</td>
					<td  class="hed"> Origin</td>
					<td  class="hed">Total Trips</td>
				    <td  class="hed"> Trips with zero violation</td>
				    <td  class="hed"> Trips with violation</td>
				    <td  class="hed"> Trips with NA Rating</td>
					<td  class="hed"> Drivers</td>
					<td  class="hed"> Vehicles</td>
					<td  class="hed"> Km. Travelled</td>
					<td  class="hed"> OS Duration<br>(Sec)</br></td>
					<td  class="hed"> RA</td>
					<td  class="hed"> RD</td>
					<td  class="hed"> OS Count</td>
					<td  class="hed"> CD</td>
					<td  class="hed"> ND</td>
					<td  class="hed"> Briefed Trips</td>
					<td  class="hed"> De-Briefed Trips</td>
					<td  class="hed"> Rating</td>
					</tr>
						<%
						
					 			
						int k=1;			
						kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
						rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
						totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;vvcount=0;rcount=0;vcountall=0;rcountall=0;
						int tbcount=0;
						int tdbcount=0;
						//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
						sqll="select Transporter,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and EndedBy='-' and tripenddate<>'NA' group by Transporter order by Transporter Asc";
					//	System.out.println(sqll);
						ResultSet rstt=stt.executeQuery(sqll);
						while(rstt.next())
						{
							int bcount=0;
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
							pbrief=0;pdebrief=0;
					
							startplace=rstt.getString("Transporter");
							drivercount=rstt.getInt("DriverID");
							drivercountall=drivercountall+rstt.getInt("DriverID");
							tripcount=rstt.getInt("TripID");
							tripcountall=tripcountall+rstt.getInt("TripID");
							vehcount=rstt.getInt("Vehid");
							vehcountall=vehcountall+rstt.getInt("Vehid");
							
									kmcount=rstt.getInt("KmTraveled");
									kmcountall=kmcountall+rstt.getInt("KmTraveled");
									oscount=rstt.getInt("OSCount");
									oscountall=oscountall+rstt.getInt("OSCount");
									racount=rstt.getInt("RACount");
									racountall=racountall+rstt.getInt("RACount");
									rdcount=rstt.getInt("RDCount");
									rdcountall=rdcountall+rstt.getInt("RDCount");
									duration=rstt.getInt("OSDuration");
									durationall=durationall+rstt.getInt("OSDuration");
									
									String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
									ResultSet rstcd=st.executeQuery(sql11);
									if(rstcd.next())
									{
										cdcount=rstcd.getInt("cdcount1");
										cdcountall=cdcountall+rstcd.getInt("cdcount1");
										
									}
									
									String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
									ResultSet rstnd=st.executeQuery(sql12);
									if(rstnd.next())
									{
										ndcount=rstnd.getInt("ndcount1");
										ndcountall=ndcountall+rstnd.getInt("ndcount1");
										
									}
									
									String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
									ResultSet rstb=st.executeQuery(sql13);
									if(rstb.next())
									{
										bcount=rstb.getInt("bcount1");
										tbcount=tbcount+bcount;
									}
									
									String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'  and Category='Primary'   and Transporter='"+startplace+"' and EndedBy='-' and tripenddate<>'NA'";
									//select * from db_gps.t_CastrolTripsStarted where Category ='Primary' and TripStartDate between '2010-05-01' and '2010-05-31 23:59:59' and Debriefing='Yes'
									ResultSet rstdb=st.executeQuery(sql14);
									if(rstdb.next())
									{
										dbcount=rstdb.getInt("dbcount1");
										tdbcount=tdbcount+rstdb.getInt("dbcount1");
									}
								
									String zsql="select Transporter,count(TripID) as Trip from t_CastrolTripsStartEnded where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'     and  OSCount='0' and RACount='0' and RDCount='0' and  KmTraveled<>'0'  and Transporter='"+startplace+"' and Category='Primary'   and tripenddate<>'NA'";
									//System.out.println(sqll);
									ResultSet zrst=st.executeQuery(zsql);
									while(zrst.next())
									{
									     zcount=zrst.getInt("Trip");
										 zcountall=zcountall+zcount;
									    
									}
									
						

									String vsql="select count(TripID) as Trips from  t_CastrolTripsStartEnded   where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'  and   Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'  and  KmTraveled<>'0'  and (OSCount>'0' or  RACount>'0' or RDCount>'0') ";
									//System.out.println(sqll);
									ResultSet vrst=st.executeQuery(vsql);
									while(vrst.next())
									{
									     vvcount=vrst.getInt("Trips");
										 vcountall=vcountall+vvcount;
									    
									}
						
									String rsql="select count(TripID) as Trips from  t_CastrolTripsStartEnded   where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'  and  KmTraveled=0 and Transporter='"+startplace+"' and Category='Primary'  and  EndedBy='-'    and tripenddate<>'NA'";
									//System.out.println(sqll);
									ResultSet rrst=st.executeQuery(rsql);
									while(rrst.next())
									{
									     rcount=rrst.getInt("Trips");
										 rcountall=rcountall+rcount;
									    
									}
						
						%>	
						<tr>
						<td><%=k%></td>
						<td><div align="left"><%=startplace%>
						</div></td>
						
						<td>
						<div align="right">
						<%
							out.print(tripcount);
						%>	
						</div></td>
						<td>
						<div align="right">
						<%
							out.print(zcount);
						%>	
						</div></td>
						<td>
						<div align="right">
						<%
							out.print(vvcount);
						%>	
						</div></td>
						<td>
						<div align="right">
						<%
							out.print(rcount);
						%>	
						</div></td>
						<td>
						<div align="right">
						<%
							out.print(drivercount);
						%>
						</div></td>
						<td>
						<div align="right">
						<%
							out.print(vehcount);
						%>
						</div></td>
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
							out.print(racount);
						%>
						</div></td>
						<td><div align="right">
						<%
							out.print(rdcount);
						%>
						</div></td>
						<td><div align="right">
						<%
							out.print(oscount);
						%>
						</div></td>
						<td><div align="right">
						<%
						
						out.print(cdcount);
						%>
						</div></td>
						<td><div align="right">
						<%
						out.print(ndcount);
							
						%>
						</div></td>
						<td><%=bcount%></td>
						<td><%=dbcount%></td>
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
						</tr>			
						<%
						k++;
						
						}
						%>	
						<tr>
						<td class="hed" colspan="2">Total :-</td>
						<td class="hed"><div align="right"><%=tripcountall%></div></td>
						<td class="hed"><div align="right"><%=zcountall%></div></td>
						<td class="hed"><div align="right"><%=vcountall%></div></td>
						<td class="hed"><div align="right"><%=rcountall%></div></td>
						<td class="hed"><div align="right"><%=drivercountall%></div></td>
						<td class="hed"><div align="right"><%=vehcountall%></div></td>
						<td class="hed"><div align="right"><%=kmcountall%></div></td>
						<td class="hed"><div align="right"><%=durationall%></div></td>
						<td class="hed"><div align="right"><%=racountall%></div></td>
						<td class="hed"><div align="right"><%=rdcountall%></div></td>
						<td class="hed"><div align="right"><%=oscountall%></div></td>
						<td class="hed"><div align="right"><%=cdcountall%></div></td>
						<td class="hed"><div align="right"><%=ndcountall%></div></td>
							
							<td class="hed"><div align="right"><%=tbcount%></div></td>
							<td class="hed"><div align="right"><%=tdbcount%></div></td>
								
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
						</tr>
						</table>
						<% 
						
						}//end of both transwise if
	else
		{
		
		%>
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
pbrief=0;pdebrief=0;
//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
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
}
			
			String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
			ResultSet rstcd=st.executeQuery(sql11);
			if(rstcd.next())
			{
				//cdcount=rstcd.getInt("cdcount1");
				cdcountall=rstcd.getInt("cdcount1");
				
			}
			
			String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
			ResultSet rstnd=st.executeQuery(sql12);
			if(rstnd.next())
			{
				//ndcount=rstnd.getInt("ndcount1");
				ndcountall=rstnd.getInt("ndcount1");
				
			}
			
			String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
			ResultSet rstb=st.executeQuery(sql13);
			if(rstb.next())
			{
				//bcount=rstb.getInt("bcount1");
				tbcount=rstb.getInt("bcount1");
			}
			
			String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
			ResultSet rstdb=st.executeQuery(sql14);
			if(rstdb.next())
			{
				//dbcount=rstdb.getInt("dbcount1");
				tdbcount=rstdb.getInt("dbcount1");
			}
			
			String sqlall="Select * from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Primary'   and EndedBy='-' and tripenddate<>'NA'";
			ResultSet rstall=st1.executeQuery(sqlall);
			while(rstall.next())
			{
				
				//System.out.println(sqlall);
			//	drivercount=rstall.getInt("DriverID");
				//System.out.println("drivercnt::>>>"+drivercount);
				tripcount=rstall.getInt("TripID");
				Vehid=rstall.getInt("Vehid");
				Vehregno=rstall.getString("vehregno");
				OwnerName=rstall.getString("Transporter");
				
						
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
		<tr>
		<td><a href="startedtrip.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=Vehregno%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm" onclick="javascript:toggleDetails(<%=k%>,false);">Show On Map</a>
		</td></tr>
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
try
{
%>
	<div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
	</div>
<%
}
catch(Exception e)
{
		out.print(enddate);
}
%>
</td>
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
	out.print(racount);
%>
</div></td>
<td><div align="right">
<%
	out.print(rdcount);
%>
</div></td>
<td><div align="right">
<%
	out.print(oscount);
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
}

//*********************************************************************************************
} //the name
} //try

	catch(Exception e)
	{
		e.printStackTrace();
		//out.println("In side exception"+e);	
	}
	finally
	{
		conn.close();
		conn1.close();
	}

	%>
	</table>
	</body>
	</html>
<%@ include file="footernew.jsp" %>
	