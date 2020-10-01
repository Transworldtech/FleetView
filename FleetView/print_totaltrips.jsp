<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">

<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st4,st5,st6,st7,st8,stt,st9,st10,st11,sttt,stbrief,stplace,stdebrief,st12,sten,stst,stbt,sten1,sten2,sten3,stst1,sts2,sts3,stbt1,stbt2,stbt3,zst;
String fromdate, todate,sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sqll,sqlll,sqlplace,sql8,sql9,sqlbrief,sqldebrief,datenew1,datenew2;
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
	int kmcountall,kmcount,tripcount,zcount,drivercount,tripcountall,zcountall,drivercountall,vehcount,vehcountall,oscount,oscountall,racount,racountall,rdcount,rdcountall,cdcount,cdcountall,ndcount,ndcountall,countlatency,latency,durationall,duration,zcountr,zcountrall,zcountg,zcountgall;
	String startplace,StartCode;
	double ratingcount,ratingcountall;
	double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
	String data1, data2,showdate1,showdate,Owner,datenew1,datenew2,transporter,sTripID="",cTripID="",TripID="";
	String fromdate="", todate="",sql="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="";
	double ss=0.00,aa=0.00,rr=0.00,rt=0.00;
	
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
	
	 
	if(!(null==sortby))
	{
		if(sortby.equals("trans"))
		{
			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="3"><center>Transporter Wise Report Of Castrol Monthly Report For Started Trips</center></font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="3"><center>Transporter Wise Report Of Castrol Monthly Report For Ended Trips</center></font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="3"><center>Transporter Wise Report Of Castrol Monthly Report For Started & Ended Trips Trips</center></font></b></td></tr>
				<%
			}
		}
		else if(sortby.equals("location"))
		{
			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="3"><center>LocationWise Report Of Castrol Monthly Report For Started Trips</center></font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="3"><center>LocationWise Report Of Castrol Monthly Report For Ended Trips</center></font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="3"><center>LocationWise Report Of Castrol Monthly Report For Started & Ended Trips Trips</center></font></b></td></tr>
				<%
			}
		}
		else 
		{

			if(thename.equals("started"))
			{
				%>
				<tr><td><b><font size="3"><center>Total Trips Report Of Castrol Monthly Report For Started Trips</center></font></b></td></tr>
				<%
			}
			else if(thename.equals("ended"))
			{
				%>
				<tr><td><b><font size="3"><center>Total Trips Report Of Castrol Monthly Report For Ended Trips</center></font></b></td></tr>
				<%
			}
			else if(thename.equals("both"))
			{
				%>
				<tr><td><b><font size="3"><center>Total Trips Report Of Castrol Monthly Report For Started & Ended Trips Trips</center></font></b></td></tr>
				<%
			}
		
		}
	}
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	zst=conn.createStatement();
	st=conn.createStatement();
	st1=conn.createStatement();
	//st2=conn.createStatement();
	//st3=conn.createStatement();
	//st4=conn.createStatement();
	//st5=conn.createStatement();
	//st6=conn.createStatement();
	//st7=conn.createStatement();
	//st8=conn.createStatement();
	//st9=conn.createStatement();
	//st10=conn.createStatement();
	//st11=conn.createStatement();
	//st12=conn.createStatement();
	stt=conn.createStatement();
	/*sttt=conn.createStatement();
	stbrief=conn.createStatement();
	stdebrief=conn.createStatement();
	stplace=conn.createStatement();
	sten=conn.createStatement();
	stst=conn.createStatement();
	stst1=conn.createStatement();
	//stst2=conn.createStatement();
	//stst3=conn.createStatement();
	stbt=conn.createStatement();
	stbt1=conn.createStatement();
	stbt2=conn.createStatement();
	stbt3=conn.createStatement();
	sten1=conn.createStatement();
	sten2=conn.createStatement();
	sten3=conn.createStatement();*/
if(!(null==thename))
{ 
		//*********************************
	
	if(thename.equalsIgnoreCase("ended"))
	{
		// In stared loop all data is come from t_ complited journey..

		if(sortby.equalsIgnoreCase("location" ))
		{
			
			
			%>
				<table border="1" width="100%" class="sortable">
			<tr>
			<td  class="hed"> Sr.</td>
			<td  class="hed"> Origin</td>
			<td  class="hed"> Trips</td>
			<td  class="hed"> Trips With Zero Violation</td>
			<td  class="hed"> Trips with NA rating</td>
			<td  class="hed"> Trips With Violation</td>
			<td  class="hed"> Drivers</td>
			<td  class="hed"> Vehicles</td>
			<td  class="hed"> Km. Travelled</td>
			<td  class="hed"> OS Duration<br>(Sec)</br></td>
			<td  class="hed"> RA</td>
			<td  class="hed"> RD</td>
			<td  class="hed"> OSCount</td>
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
				totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;zcountr=0;zcountrall=0;zcountg=0;zcountgall=0;
				int tbcount=0;
				int tdbcount=0;
				//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
				sqll="select StartPlace,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' group by StartPlace order by StartPlace Asc";
				System.out.println("kiranade"+sqll);
				ResultSet rstt=stt.executeQuery(sqll);
				while(rstt.next())
				{
					System.out.println("Locationwise Trips");
				
					System.out.println(sqll);
				
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
							
							String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstcd=st.executeQuery(sql11);
							if(rstcd.next())
							{
								cdcount=rstcd.getInt("cdcount1");
								cdcountall=cdcountall+rstcd.getInt("cdcount1");
								
							}
							
							String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstnd=st.executeQuery(sql12);
							if(rstnd.next())
							{
								ndcount=rstnd.getInt("ndcount1");
								ndcountall=ndcountall+rstnd.getInt("ndcount1");
								
							}
							
							String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstb=st.executeQuery(sql13);
							if(rstb.next())
							{
								bcount=rstb.getInt("bcount1");
								tbcount=tbcount+bcount;
							}
							
							String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstdb=st.executeQuery(sql14);
							if(rstdb.next())
							{
								dbcount=rstdb.getInt("dbcount1");
								tdbcount=tdbcount+dbcount;
							}
							
							
												
							
							String zsqlr="select Transporter,count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and KmTraveled='0'  and StartPlace='"+startplace+"'";
							System.out.println("kiran"+zsqlr);
							ResultSet zrstr=st.executeQuery(zsqlr);               
							while(zrstr.next())
							{
							     zcountr=zrstr.getInt("Trip");
							     zcountrall=zcountrall+zcountr;
							     System.out.println("zcount=================================>"+zcountr);
							}
							
							
							String zsqle="select count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty'  and OSCount='0' and RACount='0' and RDCount='0' and KmTraveled<>'0'    and StartPlace='"+startplace+"'";
							//System.out.println("kiran"+zsqle);
							ResultSet zrste=st.executeQuery(zsqle);               
							while(zrste.next())
							{
							     zcount=zrste.getInt("Trip");
								 zcountall=zcountall+zcount;
							     System.out.println("zcount=================================>"+zcount);
							}
							String zsqlg="select count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty'  and (OSCount>'0' or RACount>'0' or RDCount>'0') and KmTraveled<>'0'     and StartPlace='"+startplace+"'";
							//System.out.println("kiran"+zsqle);
							ResultSet zrstg=st.executeQuery(zsqlg);               
							while(zrstg.next())
							{
							     zcountg=zrstg.getInt("Trip");
								 zcountgall=zcountgall+zcountg;
							     System.out.println("zcount=================================>"+zcountg);
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
					out.print(zcountr);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(zcountg);
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
				<td class="hed"><div align="right"><%=zcountrall%></div></td>
				<td class="hed"><div align="right"><%=zcountgall%></div></td>
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
				System.out.println("Done..........");
				}

		else if(sortby.equalsIgnoreCase("trans" ))
		{  
			System.out.println("TransporterWise For Ended Trips");
			///*********************** **************TRANSPORTER *****
		%>
		<table border="1" width="100%" class="sortable">
	<tr>
	<td  class="hed"> Sr.</td>
	<td  class="hed">Total Transporter</td>
	<td  class="hed"> Trips</td>
	<td  class="hed"> Trips With Zero Violation</td>
	<td  class="hed"> Trips with NA rating</td>
	<td  class="hed"> Trips with violation</td>
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
		/*String PSvehlist="(";
		String sqltrip="select distinct(tripid) from t_completedjourney where tripid IN (SELECT Distinct(`TripID`) FROM t_alljddata WHERE Tripid Not in (SELECT Distinct(`TripId`) FROM `t_avlfaulty_trips` WHERE `TripDate` between '"+fromdate+"' and '"+todate+"') and `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed')";
	//	String sqltrip="SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed'";
		ResultSet rsttrip=stt.executeQuery(sqltrip);
		while(rsttrip.next())
		{
			 PSvehlist=PSvehlist+rsttrip.getString("tripid")+",";
		}
		 PSvehlist=PSvehlist+")";
		 PSvehlist=PSvehlist.replace(",)",")");
		System.out.println(PSvehlist);*/
		int k=1;			
		kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
		rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
		totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;zcountr=0;zcountrall=0;zcountg=0;zcountgall=0;
		int tbcount=0;
		int tdbcount=0;
		sqll="select Transporter,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' group by Transporter order by Transporter Asc";
		//System.out.println(sqll);
		ResultSet rstt=stt.executeQuery(sqll);
		while(rstt.next())
		{
			System.out.println("Transporter Trips");
		
			System.out.println(sqll);
		
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
					
					String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
					System.out.println(sql11);
					ResultSet rstcd=st.executeQuery(sql11);
					if(rstcd.next())
					{
						cdcount=rstcd.getInt("cdcount1");
						cdcountall=cdcountall+rstcd.getInt("cdcount1");
						
					}
					
					String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
					ResultSet rstnd=st.executeQuery(sql12);
					if(rstnd.next())
					{
						ndcount=rstnd.getInt("ndcount1");
						ndcountall=ndcountall+rstnd.getInt("ndcount1");
						
					}
					
					String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
					ResultSet rstb=st.executeQuery(sql13);
					if(rstb.next())
					{
						bcount=rstb.getInt("bcount1");
						tbcount=tbcount+bcount;
					}
					
					String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
					ResultSet rstdb=st.executeQuery(sql14);
					if(rstdb.next())
					{
						dbcount=rstdb.getInt("dbcount1");
						tdbcount=tdbcount+dbcount;
					}
					
					
					String zsqlrg1="select Transporter,count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and(OSCount>'0' or RACount>'0' or RDCount>'0') and KmTraveled<>'0'    and Transporter='"+startplace+"'";
					//System.out.println(sqll);
					ResultSet zrstg1=st.executeQuery(zsqlrg1);               
					while(zrstg1.next())
					{
					     zcountg=zrstg1.getInt("Trip");
						 zcountgall=zcountgall+zcountg;
					     System.out.println("zcount=================================>"+zcountg);
					}
					
															
					String zsqlz="select count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty'  and OSCount='0' and RACount='0' and RDCount='0' and KmTraveled<>'0'    and Transporter='"+startplace+"'";
					System.out.println("kiran"+zsqlz);
					ResultSet zrstz=st.executeQuery(zsqlz);               
					while(zrstz.next())
					{
					     zcount=zrstz.getInt("Trip");
						 zcountall=zcountall+zcount;
					     System.out.println("zcount=================================>"+zcount);
					}
					
					String zsqlrr="select Transporter,count(TripID) as Trip from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and KmTraveled='0'  and Transporter='"+startplace+"'";
					System.out.println("kiran"+zsqlrr);
					ResultSet zrstrr=st.executeQuery(zsqlrr);               
					while(zrstrr.next())
					{
					     zcountr=zrstrr.getInt("Trip");
					     zcountrall=zcountrall+zcountr;
					     System.out.println("zcount=================================>"+zcountr);
					}
					
					
		%>	
		<tr>
		<td><%=k%></td>
		<td><div align="left"><%=startplace%>
		</div></td>
	<!-- 	<td><div align="left"><a href="driverwiseTrips_castrol.jsp?transporter=< %=startplace%>&data1=< %=fromdate%>&data2=< %=todate%>&triptype=< %=thename%>"><b><%=startplace%></b></a>
		</div></td>
	 -->	
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
			out.print(zcountr);
		%>	
		</div></td>
		<td>
		<div align="right">
		<%
			out.print(zcountg);
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
		<td class="hed"><div align="right"><%=zcountrall%></div></td>
		<td class="hed"><div align="right"><%=zcountgall%></div></td>
		<td class="hed"><div align="right"><%=drivercountall%></div></td>
		<td class="hed"><div align="right"><%=vehcountall%></div></td>
		<td class="hed"><div align="right"><%=kmcountall%></div></td>
		<td class="hed"><div align="right"><%=durationall%></div></td>
		<td class="hed"><div align="right"><%=racountall%></div></td>
		<td class="hed"><div align="right"><%=rdcountall%></div></td>
		<td class="hed"><div align="right"><%=oscountall%></div></td>
		<td class="hed"><div align="right"><%=cdcountall%></div></td>
		<td class="hed"><div align="right"><%=ndcountall%></div></td>
		
		<%
			//if(cdcountall > 0)
			//{
				%>
				<!-- <td class="hed"><div align="right">Yes</div></td> -->
				<%
			//}
			//else
			//{
				%>
				<!-- <td class="hed"><div align="right">No</div></td> -->
				<%
		//	}*/
		%>
		<%
			//if(ndcountall > 0)
			//{
				%>
				<!-- <td class="hed"><div align="right">Yes</div></td> -->
				<%
			//}
			//else
			//{
				%>
				<!-- <td class="hed"><div align="right">No</div></td> -->
				<%
			//}
		%>
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
		System.out.println("Done.............");
		}//End of Transporterwise Ended trips
		else
		{
			
			%>
			<table border="1" width="100%" class="sortable">
			<tr>
			<td class="hed"><b>Sr.</b></td>
			<td  class="hed"><b>TripID</b></td>
			<td  class="hed"><b>Vehicle</b></td>
			<td class="hed"><b>Transporter</b></td>
			<td  class="hed"> Driver ID</td>
			<td class="hed"><b>Drivername</b></td>
			<td  class="hed"><b>TripFrom</b></td>
			<td  class="hed"><b>TripStartDate</b></td>
			<td  class="hed"><b>TripTo</b></td>
			<td  class="hed"><b>TripEndDate</b></td>
			<td  class="hed"><b>StdDistance</b></td>
			<td  class="hed"><b>StdTransitTime</b></td>
			<td  class="hed"><b>Captured Km</b></td>
			<td class="hed"><b>OS Duration<br>(in Sec)</b></td>
			<td class="hed"><b>RA Count</b></td>
			<td  class="hed"><b>RD Count</b></td>
				<td  class="hed"><b>OS Count</b></td>
			<td  class="hed"><b>CD</b></td>
			<td  class="hed"><b>ND</b></td>
		
			<td  class="hed"><b>Rating</b></td>
			<td class="hed"><b>Basic</b></td>
			<td class="hed"><b>Module1</b></td>
			<td  class="hed"><b>Module2</b></td>
			<td class="hed"><b>Module3</b></td>
			<td  class="hed"><b>Module4</b></td>
			<td  class="hed"><b>Briefing</b></td>
			<td  class="hed"><b>BriefingTrainer</b></td>
			<td  class="hed"><b>BriefingComments</b></td>
			<td  class="hed"><b>Debriefing</b></td>
			<td  class="hed"><b>DebriefingTrainer</b></td>
			<td  class="hed"><b>DebriefingComments</b></td>
			<td  class="hed">% Data Captured</td>
			<td  class="hed"><b>Category</b></td>
						
			</tr>
	<%
	int k=1;			
	kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
	rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
	totpbrief=0;totpdebrief=0;
	int Vehid=0;
	String Vehregno="",cdcnt="",ndcnt="";
	String drivername="-",startplace1="-",endplace="-",startdate="-",enddate="-",OwnerName="-";
	String briefdone="",brieftrainername="",briefcomment="",debriefdone="",debrieftrainername="",debriefcomment="";
	String basic="",module1="",module2="",module3="",module4="",category="",ttime1="",stdkm1="";
	int tbcount=0,drivercnt=0;
	int tdbcount=0;
	int bcount=0;
	int dbcount=0;
	double prcnt=0.0;

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
	sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
	//System.out.println(sqll);
	ResultSet rstt=stt.executeQuery(sqll);
	while(rstt.next())
	{
		//System.out.println("Total Ended Trips");
	
		//System.out.println(sqll);
	
					
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
				
				String sql11="Select count(CD) as cdcount1 from t_CastrolTripsEnded where CD='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rstcd=st.executeQuery(sql11);
				if(rstcd.next())
				{
					//cdcount=rstcd.getInt("cdcount1");
					//System.out.println(sql11);
					cdcountall=rstcd.getInt("cdcount1");
					
				}
				
				String sql12="Select count(ND) as ndcount1 from t_CastrolTripsEnded where ND='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rstnd=st.executeQuery(sql12);
				if(rstnd.next())
				{
					//System.out.println(sql12);
				
					//ndcount=rstnd.getInt("ndcount1");
					ndcountall=rstnd.getInt("ndcount1");
					
				}
				
				String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsEnded where Briefing='briefed' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rstb=st.executeQuery(sql13);
				if(rstb.next())
				{
					//bcount=rstb.getInt("bcount1");
					//System.out.println(sql13);
					tbcount=rstb.getInt("bcount1");
				}
				
				String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsEnded where Debriefing='Yes' and TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rstdb=st.executeQuery(sql14);
				if(rstdb.next())
				{
					//dbcount=rstdb.getInt("dbcount1");
					//System.out.println(sql14);
					
					tdbcount=rstdb.getInt("dbcount1");
					//System.out.println("Hiiiiiiiiiiiii");
				}
				
				String sqlall="Select * from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rstall=st.executeQuery(sqlall);
				while(rstall.next())
				{
					//System.out.println("HIIIIIIIIIIIIIIIIIIIIiiiiiii");
				
					//dr=rstall.getInt("DriverID");
					tripcount=rstall.getInt("TripID");
					Vehid=rstall.getInt("Vehid");
					Vehregno=rstall.getString("vehregno");
					OwnerName=rstall.getString("Transporter");
					
					//////////////////////////////////////////////////////
					//vehcount=rstt2.getString("vehregno");
					//OwnerName=rstall.getString("Transporter");
					//Vehid=rstt2.getInt("Vehid");
					
					drivercnt=rstall.getInt("DriverID");
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
					cdcnt=rstall.getString("CD");
					ndcnt=rstall.getString("ND");
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
					prcnt=100;
				}
				else
				{
					prcnt=Double.valueOf(kmcount)/Double.valueOf(stdkm1);
					prcnt=prcnt*100;
				}
			
	%>	
	<tr>
	<td><%=k%></td>
	<td><div align="left">
			<%=tripcount%>
			</div></td>	
			<td>
			<div align="right">
			<%=Vehregno %>
			</div></td>
			<td>
			<div align="right">
			<%=OwnerName %>
			</div></td>
			<td><div align="right"><%=drivercnt %></div></td>
			<td><div align="right"><%=drivername %></div></td>
			<td>
			<div align="right">
			<%=startplace1 %>
			</div></td>
			<td>
			<div align="right">
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
			</div></td>
			<td>
			<div align="right">
			<%=endplace %>
			</div></td>
			<td>
			<div align="right">
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(stdkm1);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(ttime1);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(kmcount);
			%>
			</div></td>
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
				out.print(cdcnt);
				
			%>
			</div></td>
			<td><div align="right">
			<%
				
				out.print(ndcnt);
			
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
			if(Integer.valueOf(rdcount1) > 0 && kmcount > 0)
			{
				Decelaration1=((Double.valueOf(rdcount1))/(double)kmcount)*100;
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
				
			%>		</div>			
			</td>
			
			<td>
			<div align="right">
			<%
			out.print(basic);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(module1);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(module2);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(module3);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(module4);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(briefdone);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(brieftrainername);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(briefcomment);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(debriefdone);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(debrieftrainername);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(debriefcomment);
			%>
			</div></td>
			<td>
			<div align="right">
			<%
			out.print(nf.format(prcnt));
			%>
			</div></td>
			<td>
			<div align="right"><%=category %>
			
			</div></td>
						
	</tr>
	<%k++;
	}%>
	
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
			
		if(racountall > 0 && kmcountall > 0)
		{
			aa=((double)racountall/(double)kmcountall)*100;
		}	
		if(rdcountall > 0 && kmcountall > 0)
		{
			rr=((double)rdcountall/(double)kmcountall)*100;
			
		}		
		if(durationall > 0 && kmcountall> 0)
		{
			ss =(((double)durationall/10)/(double)kmcountall)*100;
		}
		rt=aa+rr+ss;
		
		if(kmcountall > 0)
		{
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
	System.out.println("Done..........");
	}//End of total Ended trips
	}//End of Ended trips
			


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
				<td  class="hed"> Trips</td>
				<td  class="hed"> Trips With Zero violation</td>
				<td  class="hed"> Trips with NA rating</td>
				<td  class="hed"> Trips With Violation</td>
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
					totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;zcountr=0;zcountrall=0;zcountg=0;zcountgall=0;
					int tbcount=0;
					int tdbcount=0;
					//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
					sqll="select StartPlace,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' group by StartPlace order by StartPlace Asc";
					//System.out.println(sqll);
					ResultSet rstt=stt.executeQuery(sqll);
					while(rstt.next())
					{
						//System.out.println("Locationwise Trips");
					
						//System.out.println(sqll);
					
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
								
								String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and status<>'Faulty' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
								ResultSet rstcd=st.executeQuery(sql11);
								if(rstcd.next())
								{
									cdcount=rstcd.getInt("cdcount1");
									cdcountall=cdcountall+rstcd.getInt("cdcount1");
									
								}
								
								String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and status<>'Faulty' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
								ResultSet rstnd=st.executeQuery(sql12);
								if(rstnd.next())
								{
									ndcount=rstnd.getInt("ndcount1");
									ndcountall=ndcountall+rstnd.getInt("ndcount1");
									
								}
								
								String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and status<>'Faulty'and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
								ResultSet rstb=st.executeQuery(sql13);
								if(rstb.next())
								{
									bcount=rstb.getInt("bcount1");
									tbcount=tbcount+bcount;
								}
								
								String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and status<>'Faulty' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
								ResultSet rstdb=st.executeQuery(sql14);
								if(rstdb.next())
								{
									dbcount=rstdb.getInt("dbcount1");
									tdbcount=tdbcount+dbcount;
								}
								
								
								String zsqlg="select count(TripID) as Trip from t_CastrolTripsStarted  where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty'  and (OSCount>'0' or RACount>'0' or RDCount>'0') and KmTraveled<>'0'      and StartPlace='"+startplace+"'";
								
								//System.out.println("kiran"+zsqlv);
								ResultSet zrstg=st.executeQuery(zsqlg);               
								while(zrstg.next())
								{
								     zcountg=zrstg.getInt("Trip");
									 zcountgall=zcountgall+zcountg;
								     System.out.println("zcount=================================>"+zcountg);
								}
								
								
							String zsqlr="select Transporter,count(TripID) as Trip from t_CastrolTripsStarted  where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and KmTraveled='0'  and StartPlace='"+startplace+"'";
								
								//System.out.println("kiran"+zsqlv);
								ResultSet zrstr=st.executeQuery(zsqlr);               
								while(zrstr.next())
								{
								     zcountr=zrstr.getInt("Trip");
									 zcountrall=zcountrall+zcountr;
								     System.out.println("zcount=================================>"+zcountr);
								}
								
								
								
								String zsqlv="select Transporter,count(TripID) as Trip from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty'  and OSCount='0' and RACount='0' and RDCount='0' and KmTraveled<>'0' and StartPlace='"+startplace+"'";
								
								//System.out.println("kiran"+zsqlv);
								ResultSet zrstv=st.executeQuery(zsqlv);               
								while(zrstv.next())
								{
								     zcount=zrstv.getInt("Trip");
									 zcountall=zcountall+zcount;
								     System.out.println("zcount=================================>"+zcount);
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
						out.print(zcountr);
					%>	
					</div></td>
					<td>
					<div align="right">
					<%
						out.print(zcountg);
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
					<td class="hed"><div align="right"><%=zcountrall%></div></td>
					<td class="hed"><div align="right"><%=zcountgall%></div></td>
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
					System.out.println("Done..........");
					}

			else if(sortby.equalsIgnoreCase("trans" ))
			{  
				System.out.println("TransporterWise For Started Trips");
				///*********************** **************TRANSPORTER *****
			%>
			<table border="1" width="100%" class="sortable">
		<tr>
		<td  class="hed"> Sr.</td>
		<td  class="hed"> Transporter</td>
		<td  class="hed">Total Trips</td>
		<td  class="hed"> Trips With Zero Violation</td>
		<td  class="hed">  Trips with NA rating</td>
		<td  class="hed">  Trips with violation</td>
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
			/*String PSvehlist="(";
			String sqltrip="select distinct(tripid) from t_completedjourney where tripid IN (SELECT Distinct(`TripID`) FROM t_alljddata WHERE Tripid Not in (SELECT Distinct(`TripId`) FROM `t_avlfaulty_trips` WHERE `TripDate` between '"+fromdate+"' and '"+todate+"') and `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed')";
		//	String sqltrip="SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed'";
			ResultSet rsttrip=stt.executeQuery(sqltrip);
			while(rsttrip.next())
			{
				 PSvehlist=PSvehlist+rsttrip.getString("tripid")+",";
			}
			 PSvehlist=PSvehlist+")";
			 PSvehlist=PSvehlist.replace(",)",")");
			System.out.println(PSvehlist);*/
			int k=1;			
			kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
			rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
			totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;zcountr=0;zcountrall=0;zcountg=0;zcountgall=0;
			int tbcount=0;
			int tdbcount=0;
			sqll="select Transporter,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' group by Transporter order by Transporter Asc";
			//System.out.println(sqll);
			ResultSet rstt=stt.executeQuery(sqll);
			while(rstt.next())
			{
				System.out.println("Transporter Trips");
			
				System.out.println(sqll);
			
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
						
						String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
						System.out.println(sql11);
						ResultSet rstcd=st.executeQuery(sql11);
						if(rstcd.next())
						{
							cdcount=rstcd.getInt("cdcount1");
							cdcountall=cdcountall+rstcd.getInt("cdcount1");
							
						}
						
						String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
						ResultSet rstnd=st.executeQuery(sql12);
						if(rstnd.next())
						{
							ndcount=rstnd.getInt("ndcount1");
							ndcountall=ndcountall+rstnd.getInt("ndcount1");
							
						}
						
						String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
						ResultSet rstb=st.executeQuery(sql13);
						if(rstb.next())
						{
							bcount=rstb.getInt("bcount1");
							tbcount=tbcount+bcount;
						}
						
						String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Transporter='"+startplace+"'";
						ResultSet rstdb=st.executeQuery(sql14);
						if(rstdb.next())
						{
							dbcount=rstdb.getInt("dbcount1");
							tdbcount=tdbcount+dbcount;
						}
			  
						
						String zsqlg3="select Transporter,count(TripID) as Trip from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and(OSCount>'0' or RACount>'0' or RDCount>'0') and KmTraveled<>'0'    and Transporter='"+startplace+"'";
						
						//System.out.println("kiran"+zsqlr2);
						ResultSet zrstg3=st.executeQuery(zsqlg3);               
						while(zrstg3.next())
						{
						     zcountg=zrstg3.getInt("Trip");
							 zcountgall=zcountgall+zcountg;
						     System.out.println("zcount=================================>"+zcountg);
						}
						
						
						String zsqlr3="select Transporter,count(TripID) as Trip from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and KmTraveled='0'  and Transporter='"+startplace+"'";
						
						//System.out.println("kiran"+zsqlr2);
						ResultSet zrstr3=st.executeQuery(zsqlr3);               
						while(zrstr3.next())
						{
						     zcountr=zrstr3.getInt("Trip");
							 zcountrall=zcountrall+zcountr;
						     System.out.println("zcount=================================>"+zcountr);
						}
						

						String zsql1="select count(TripID) as Trip from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty'  and OSCount='0' and RACount='0' and RDCount='0' and KmTraveled<>'0'    and Transporter='"+startplace+"'";
							//System.out.println(sqll);
							ResultSet zrst1=st.executeQuery(zsql1);
							if(zrst1.next())
							{
							     zcount=zrst1.getInt("Trip");
							     zcountall=zcountall+zcount;
							}
							System.out.println("=================================> Started "+zcount);
														
			%>	
			<tr>
			<td><%=k%></td>
			<td><div align="left"><%=startplace%>
			</div></td>
		<!-- 	<td><div align="left"><a href="driverwiseTrips_castrol.jsp?transporter=< %=startplace%>&data1=< %=fromdate%>&data2=< %=todate%>&triptype=< %=thename%>"><b><%=startplace%></b></a>
			</div></td>
		 -->	
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
				out.print(zcountr);
			%>	
			</div></td>
			<td>
			<div align="right">
			<%
				out.print(zcountg);
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
			<td class="hed"><div align="right"><%=zcountrall%></div></td>
			<td class="hed"><div align="right"><%=zcountgall%></div></td>
			<td class="hed"><div align="right"><%=drivercountall%></div></td>
			<td class="hed"><div align="right"><%=vehcountall%></div></td>
			<td class="hed"><div align="right"><%=kmcountall%></div></td>
			<td class="hed"><div align="right"><%=durationall%></div></td>
			<td class="hed"><div align="right"><%=racountall%></div></td>
			<td class="hed"><div align="right"><%=rdcountall%></div></td>
				<td class="hed"><div align="right"><%=oscountall%></div></td>
			<td class="hed"><div align="right"><%=cdcountall%></div></td>
			<td class="hed"><div align="right"><%=ndcountall%></div></td>
		
			<%
				//if(cdcountall > 0)
				//{
					%>
					<!-- <td class="hed"><div align="right">Yes</div></td> -->
					<%
				//}
				//else
				//{
					%>
					<!-- <td class="hed"><div align="right">No</div></td> -->
					<%
			//	}*/
			%>
			<%
				//if(ndcountall > 0)
				//{
					%>
					<!-- <td class="hed"><div align="right">Yes</div></td> -->
					<%
				//}
				//else
				//{
					%>
					<!-- <td class="hed"><div align="right">No</div></td> -->
					<%
				//}
			%>
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
			System.out.println("Done.............");
			}//end of started if
		//***************************************started all trips**************************************************
			else
			{
				
				%>
				<table border="1" width="100%" class="sortable">
				<tr>
				<td class="hed"><b>Sr.</b></td>
				<td  class="hed"><b>TripID</b></td>
				<td  class="hed"><b>Vehicle</b></td>
				<td class="hed"><b>Transporter</b></td>
				<td  class="hed"> Driver ID</td>
				<td class="hed"><b>Drivername</b></td>
				<td  class="hed"><b>TripFrom</b></td>
				<td  class="hed"><b>TripStartDate</b></td>
				<td  class="hed"><b>TripTo</b></td>
				<td  class="hed"><b>TripEndDate</b></td>
				<td  class="hed"><b>StdDistance</b></td>
				<td  class="hed"><b>StdTransitTime</b></td>
				<td  class="hed"><b>Captured Km</b></td>
				<td class="hed"><b>OS Duration<br>(in Sec)</b></td>
				<td class="hed"><b>RA Count</b></td>
				<td  class="hed"><b>RD Count</b></td>
				<td  class="hed"><b>OS Count</b></td>
				<td  class="hed"><b>CD</b></td>
				<td  class="hed"><b>ND</b></td>
				
				<td  class="hed"><b>Rating</b></td>
				<td class="hed"><b>Basic</b></td>
				<td class="hed"><b>Module1</b></td>
				<td  class="hed"><b>Module2</b></td>
				<td class="hed"><b>Module3</b></td>
				<td  class="hed"><b>Module4</b></td>
				<td  class="hed"><b>Briefing</b></td>
				<td  class="hed"><b>BriefingTrainer</b></td>
				<td  class="hed"><b>BriefingComments</b></td>
				<td  class="hed"><b>Debriefing</b></td>
				<td  class="hed"><b>DebriefingTrainer</b></td>
				<td  class="hed"><b>DebriefingComments</b></td>
				<td  class="hed">% Data Captured</td>
				<td  class="hed"><b>Category</b></td>
							
				</tr>
		<%
		int k=1;			
		kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
		rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
		totpbrief=0;totpdebrief=0;
		int Vehid=0;
		String Vehregno="",cdcnt="",ndcnt="";
		String drivername="-",startplace1="-",endplace="-",startdate="-",enddate="-",OwnerName="-";
		String briefdone="",brieftrainername="",briefcomment="",debriefdone="",debrieftrainername="",debriefcomment="";
		String basic="",module1="",module2="",module3="",module4="",category="",ttime1="",stdkm1="";
		int tbcount=0,drivercnt=0;
		int tdbcount=0;
		int bcount=0;
		int dbcount=0;
		double prcnt=0.0;
	
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
		sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
		//System.out.println(sqll);
		ResultSet rstt=stt.executeQuery(sqll);
		while(rstt.next())
		{
			//System.out.println("Total Ended Trips");
		
			//System.out.println(sqll);
		
						
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
					
					String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStarted where CD='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
					ResultSet rstcd=st.executeQuery(sql11);
					if(rstcd.next())
					{
						//cdcount=rstcd.getInt("cdcount1");
						cdcountall=rstcd.getInt("cdcount1");
						
					}
					
					String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStarted where ND='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
					ResultSet rstnd=st.executeQuery(sql12);
					if(rstnd.next())
					{
						//ndcount=rstnd.getInt("ndcount1");
						ndcountall=rstnd.getInt("ndcount1");
						
					}
					
					String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStarted where Briefing='briefed' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
					ResultSet rstb=st.executeQuery(sql13);
					if(rstb.next())
					{
						//bcount=rstb.getInt("bcount1");
						tbcount=rstb.getInt("bcount1");
					}
					
					String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStarted where Debriefing='Yes' and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
					ResultSet rstdb=st.executeQuery(sql14);
					if(rstdb.next())
					{
						//dbcount=rstdb.getInt("dbcount1");
						tdbcount=rstdb.getInt("dbcount1");
					}
					
					String sqlall="Select * from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' order by TripStartDate Asc";
					ResultSet rstall=st1.executeQuery(sqlall);
					while(rstall.next())
					{
						//dr=rstall.getInt("DriverID");
						tripcount=rstall.getInt("TripID");
						Vehid=rstall.getInt("Vehid");
						Vehregno=rstall.getString("vehregno");
						OwnerName=rstall.getString("Transporter");
						
						//////////////////////////////////////////////////////
						//vehcount=rstt2.getString("vehregno");
						//OwnerName=rstall.getString("Transporter");
						//Vehid=rstt2.getInt("Vehid");
						
						drivercnt=rstall.getInt("DriverID");
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
						cdcnt=rstall.getString("CD");
						ndcnt=rstall.getString("ND");
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
						prcnt=100;
					}
					else
					{
						prcnt=Double.valueOf(kmcount)/Double.valueOf(stdkm1);
						prcnt=prcnt*100;
					}
				
		%>	
		<tr>
		<td><%=k%></td>
		<td><div align="left">
				<%=tripcount%>
				</div></td>	
				<td>
				<div align="right">
				<%=Vehregno %>
				</div></td>
				<td>
				<div align="right">
				<%=OwnerName %>
				</div></td>
				<td><div align="right"><%=drivercnt %></div></td>
				<td><div align="right"><%=drivername %></div></td>
				<td>
				<div align="right">
				<%=startplace1 %>
				</div></td>
				<td>
				<div align="right">
				<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
				</div></td>
				<td>
				<div align="right">
				<%=endplace %>
				</div></td>
				<td>
				<%
				try
				{
				%>
				<div align="right">
				<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
				</div>
				<%
				}
				catch(Exception e)
				{
					out.print(enddate);
				}
				%>
				</td>
				<td>
				<div align="right">
				<%
				out.print(stdkm1);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(ttime1);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(kmcount);
				%>
				</div></td>
				
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
					out.print(cdcnt);
					
				%>
				</div></td>
				<td><div align="right">
				<%
					
					out.print(ndcnt);
				
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
				if(Integer.valueOf(rdcount1) > 0 && kmcount > 0)
				{
					Decelaration1=((Double.valueOf(rdcount1))/(double)kmcount)*100;
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
					
				%>		</div>			
				</td>
				
				<td>
				<div align="right">
				<%
				out.print(basic);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(module1);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(module2);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(module3);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(module4);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(briefdone);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(brieftrainername);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(briefcomment);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(debriefdone);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(debrieftrainername);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(debriefcomment);
				%>
				</div></td>
				<td>
				<div align="right">
				<%
				out.print(nf.format(prcnt));
				%>
				</div></td>
				<td>
				<div align="right"><%=category %>
				
				</div></td>
							
		</tr>
		<%k++;
		}%>
		
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
				
			if(racountall > 0 && kmcountall > 0)
			{
				aa=((double)racountall/(double)kmcountall)*100;
			}	
			if(rdcountall > 0 && kmcountall > 0)
			{
				rr=((double)rdcountall/(double)kmcountall)*100;
				
			}		
			if(durationall > 0 && kmcountall> 0)
			{
				ss =(((double)durationall/10)/(double)kmcountall)*100;
			}
			rt=aa+rr+ss;
			
			if(kmcountall > 0)
			{
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
		System.out.println("Done..........");
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
			<td  class="hed"> Trips</td>
			<td  class="hed"> Trips With Zero Violation</td>
			<td  class="hed"> Trips With NA Rating</td>
			<td  class="hed"> Trips With Violation</td>
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
				totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;zcountr=0;zcountrall=0;zcountg=0;zcountgall=0;
				int tbcount=0;
				int tdbcount=0;
				//sqll="select Distinct(StartCode) from t_completedjourney where EndDate>= '"+fromdate+"' and EndDate <='"+todate+"' and GPName='Castrol' order by StartPlace Asc";
				sqll="select StartPlace,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' group by StartPlace order by StartPlace Asc";
				//System.out.println(sqll);
				ResultSet rstt=stt.executeQuery(sqll);
				while(rstt.next())
				{
					System.out.println("Locationwise Trips");
				
					System.out.println(sqll);
				
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
							
							String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstcd=st.executeQuery(sql11);
							if(rstcd.next())
							{
								cdcount=rstcd.getInt("cdcount1");
								cdcountall=cdcountall+rstcd.getInt("cdcount1");
								
							}
							
							String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstnd=st.executeQuery(sql12);
							if(rstnd.next())
							{
								ndcount=rstnd.getInt("ndcount1");
								ndcountall=ndcountall+rstnd.getInt("ndcount1");
								
							}
							
							String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstb=st.executeQuery(sql13);
							if(rstb.next())
							{
								bcount=rstb.getInt("bcount1");
								tbcount=tbcount+bcount;
							}
							
							String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and StartPlace='"+startplace+"'";
							ResultSet rstdb=st.executeQuery(sql14);
							if(rstdb.next())
							{
								dbcount=rstdb.getInt("dbcount1");
								tdbcount=tdbcount+dbcount;
							}
							
							String	zsqlg3="select Transporter,count(TripID) as Trip2 from t_CastrolTripsStartEnded where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty'  and(OSCount>'0' or RACount>'0' or RDCount>'0') and KmTraveled<>'0'  and StartPlace='"+startplace+"'";
							//System.out.println(sqll);
							ResultSet zrstg3=zst.executeQuery(zsqlg3);
							if(zrstg3.next())
							{
							     zcountg=zrstg3.getInt("Trip2");
								zcountgall=zcountgall+zcountg;
							}
							
							
							 String	zsqlr3="select Transporter,count(TripID) as Trip2 from t_CastrolTripsStartEnded where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty'   and KmTraveled='0'and StartPlace='"+startplace+"'";
								//System.out.println(sqll);
								ResultSet zrstr3=zst.executeQuery(zsqlr3);
								if(zrstr3.next())
								{
								     zcountr=zrstr3.getInt("Trip2");
									zcountrall=zcountrall+zcountr;
								}
								
							
						 String	zsql3="select Transporter,count(TripID) as Trip2 from t_CastrolTripsStartEnded where  TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty'  and OSCount='0' and RACount='0' and RDCount='0' and KmTraveled<>'0'and StartPlace='"+startplace+"'";
							//System.out.println(sqll);
							ResultSet zrst3=zst.executeQuery(zsql3);
							if(zrst3.next())
							{
							     zcount=zrst3.getInt("Trip2");
								zcountall=zcountall+zcount;
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
					out.print(zcountr);
				%>	
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(zcountg);
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
				<td class="hed"><div align="right"><%=zcountrall%></div></td>
				<td class="hed"><div align="right"><%=zcountgall%></div></td>
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
				System.out.println("Done..........");
				}

				else if(sortby.equalsIgnoreCase("trans" ))

		{  
					System.out.println("TransporterWise For Both Trips");
					///*********************** **************TRANSPORTER *****
				%>
				<table border="1" width="100%" class="sortable">
			<tr>
			<td  class="hed"> Sr.</td>
			<td  class="hed"> Transporter</td>
			<td  class="hed">Total Trips</td>
			<td  class="hed"> Trips With Zero Violation</td>
			<td  class="hed"> Trips With NA Rating</td>
			<td  class="hed"> Trips With Violation</td>
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
				/*String PSvehlist="(";
				String sqltrip="select distinct(tripid) from t_completedjourney where tripid IN (SELECT Distinct(`TripID`) FROM t_alljddata WHERE Tripid Not in (SELECT Distinct(`TripId`) FROM `t_avlfaulty_trips` WHERE `TripDate` between '"+fromdate+"' and '"+todate+"') and `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed')";
			//	String sqltrip="SELECT Distinct(`TripID`) FROM t_alljddata WHERE `StartDate` between '"+fromdate+"' and '"+todate+"' and Status <> 'NotProcessed'";
				ResultSet rsttrip=stt.executeQuery(sqltrip);
				while(rsttrip.next())
				{
					 PSvehlist=PSvehlist+rsttrip.getString("tripid")+",";
				}
				 PSvehlist=PSvehlist+")";
				 PSvehlist=PSvehlist.replace(",)",")");
				System.out.println(PSvehlist);*/
				int k=1;			
				kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
				rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
				totpbrief=0;totpdebrief=0;zcount=0;zcountall=0;zcountr=0;zcountrall=0;zcountg=0;zcountgall=0;
				int tbcount=0;
				int tdbcount=0;
				sqll="select Transporter,count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' group by Transporter order by Transporter Asc";
				//System.out.println(sqll);
				ResultSet rstt=stt.executeQuery(sqll);
				while(rstt.next())
				{
					System.out.println("Both Transporter Trips");
				
					System.out.println(sqll);
				
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
							
							String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Transporter='"+startplace+"'";
							System.out.println(sql11);
							ResultSet rstcd=st.executeQuery(sql11);
							if(rstcd.next())
							{
								cdcount=rstcd.getInt("cdcount1");
								cdcountall=cdcountall+rstcd.getInt("cdcount1");
								
							}
							
							String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Transporter='"+startplace+"'";
							ResultSet rstnd=st.executeQuery(sql12);
							if(rstnd.next())
							{
								ndcount=rstnd.getInt("ndcount1");
								ndcountall=ndcountall+rstnd.getInt("ndcount1");
								
							}
							
							String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Transporter='"+startplace+"'";
							ResultSet rstb=st.executeQuery(sql13);
							if(rstb.next())
							{
								bcount=rstb.getInt("bcount1");
								tbcount=tbcount+bcount;
							}
							
							String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Transporter='"+startplace+"'";
							ResultSet rstdb=st.executeQuery(sql14);
							if(rstdb.next())
							{
								dbcount=rstdb.getInt("dbcount1");
								tdbcount=tdbcount+dbcount;
							}
			
							String	zsqlg="select Transporter,count(TripID) as Trip2 from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty'  and(OSCount>'0' or RACount>'0' or RDCount>'0') and KmTraveled<>'0'  and Transporter='"+startplace+"'";
							//System.out.println(sqll);
							ResultSet zrstg=zst.executeQuery(zsqlg);
							if(zrstg.next())
							{
							     zcountg=zrstg.getInt("Trip2");
								zcountgall=zcountgall+zcountg;
							}
							
							
							 String	zsqlr="select Transporter,count(TripID) as Trip2 from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty'   and KmTraveled='0'and Transporter='"+startplace+"'";
								//System.out.println(sqll);
								ResultSet zrstr=zst.executeQuery(zsqlr);
								if(zrstr.next())
								{
								     zcountr=zrstr.getInt("Trip2");
									zcountrall=zcountrall+zcountr;
								}
								
							
						 String	zsql2="select Transporter,count(TripID) as Trip2 from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and status<>'Faulty'  and OSCount='0' and RACount='0' and RDCount='0' and KmTraveled<>'0'and Transporter='"+startplace+"'";
							//System.out.println(sqll);
							ResultSet zrst=zst.executeQuery(zsql2);
							if(zrst.next())
							{
							     zcount=zrst.getInt("Trip2");
								zcountall=zcountall+zcount;
							}
							
							
							
													
							
							%>	
				<tr>
				<td><%=k%></td>
				<td><div align="left"><%=startplace%>
				</div></td>
			<!-- 	<td><div align="left"><a href="driverwiseTrips_castrol.jsp?transporter=< %=startplace%>&data1=< %=fromdate%>&data2=< %=todate%>&triptype=< %=thename%>"><b><%=startplace%></b></a>
				</div></td>
			 -->	
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
					out.print(zcountr);
				%>	
				</div></td>
				<td>
				<div align="right">
				<%
					out.print(zcountg);
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
				<td class="hed"><div align="right"><%=zcountrall%></div></td>
				<td class="hed"><div align="right"><%=zcountgall%></div></td>
				<td class="hed"><div align="right"><%=drivercountall%></div></td>
				<td class="hed"><div align="right"><%=vehcountall%></div></td>
				<td class="hed"><div align="right"><%=kmcountall%></div></td>
				<td class="hed"><div align="right"><%=durationall%></div></td>
				<td class="hed"><div align="right"><%=racountall%></div></td>
				<td class="hed"><div align="right"><%=rdcountall%></div></td>
				<td class="hed"><div align="right"><%=oscountall%></div></td>
				<td class="hed"><div align="right"><%=cdcountall%></div></td>
				<td class="hed"><div align="right"><%=ndcountall%></div></td>
				
				<%
					//if(cdcountall > 0)
					//{
						%>
						<!-- <td class="hed"><div align="right">Yes</div></td> -->
						<%
					//}
					//else
					//{
						%>
						<!-- <td class="hed"><div align="right">No</div></td> -->
						<%
				//	}*/
				%>
				<%
					//if(ndcountall > 0)
					//{
						%>
						<!-- <td class="hed"><div align="right">Yes</div></td> -->
						<%
					//}
					//else
					//{
						%>
						<!-- <td class="hed"><div align="right">No</div></td> -->
						<%
					//}
				%>
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
				System.out.println("Done.............");
				}//end of started if
	else
		{
		
		%>
		<table border="1" width="100%" class="sortable">
		<tr>
		<td class="hed"><b>Sr.</b></td>
		<td  class="hed"><b>TripID</b></td>
		<td  class="hed"><b>Vehicle</b></td>
		<td class="hed"><b>Transporter</b></td>
		<td  class="hed"> Driver ID</td>
		<td class="hed"><b>Drivername</b></td>
		<td  class="hed"><b>TripFrom</b></td>
		<td  class="hed"><b>TripStartDate</b></td>
		<td  class="hed"><b>TripTo</b></td>
		<td  class="hed"><b>TripEndDate</b></td>
		<td  class="hed"><b>StdDistance</b></td>
		<td  class="hed"><b>StdTransitTime</b></td>
		<td  class="hed"><b>Captured Km</b></td>
		<td class="hed"><b>OS Duration<br>(in Sec)</b></td>
		<td class="hed"><b>RA Count</b></td>
		<td  class="hed"><b>RD Count</b></td>
		<td  class="hed"><b>OS Count</b></td>
		<td  class="hed"><b>CD</b></td>
		<td  class="hed"><b>ND</b></td>
		
		<td  class="hed"><b>Rating</b></td>
		<td class="hed"><b>Basic</b></td>
		<td class="hed"><b>Module1</b></td>
		<td  class="hed"><b>Module2</b></td>
		<td class="hed"><b>Module3</b></td>
		<td  class="hed"><b>Module4</b></td>
		<td  class="hed"><b>Briefing</b></td>
		<td  class="hed"><b>BriefingTrainer</b></td>
		<td  class="hed"><b>BriefingComments</b></td>
		<td  class="hed"><b>Debriefing</b></td>
		<td  class="hed"><b>DebriefingTrainer</b></td>
		<td  class="hed"><b>DebriefingComments</b></td>
		<td  class="hed">% Data Captured</td>
		<td  class="hed"><b>Category</b></td>
					
		</tr>
<%
int k=1;			
kmcountall=0;tripcountall=0;drivercountall=0;ratingcountall=0.0;vehcountall=0;oscountall=0;racountall=0;
rdcountall=0;cdcountall=0;ndcountall=0;	countlatency=0;	durationall=0;int j=0;kmcount=0;tripcount=0;
totpbrief=0;totpdebrief=0;
int Vehid=0;
String Vehregno="",cdcnt="",ndcnt="";
String drivername="-",startplace1="-",endplace="-",startdate="-",enddate="-",OwnerName="-";
String briefdone="",brieftrainername="",briefcomment="",debriefdone="",debrieftrainername="",debriefcomment="";
String basic="",module1="",module2="",module3="",module4="",category="",ttime1="",stdkm1="";
int tbcount=0,drivercnt=0;
int tdbcount=0;
int bcount=0;
int dbcount=0;
double prcnt=0.0;

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
sqll="select count(TripID) as TripID,count(Distinct(DriverID)) as DriverID,count(Distinct(Vehid)) as Vehid,sum(KmTraveled) as KmTraveled,sum(OSCount) as OSCount,sum(OSDusration) as OSDuration,sum(RACount) as RACount,sum(RDCount) as RDCount  from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'";
//System.out.println(sqll);
ResultSet rstt=stt.executeQuery(sqll);
while(rstt.next())
{
	System.out.println("Total Both Trips");

	System.out.println(sqll);

				
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
			
			String sql11="Select count(CD) as cdcount1 from t_CastrolTripsStartEnded where CD='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'";
			ResultSet rstcd=st.executeQuery(sql11);
			if(rstcd.next())
			{
				//cdcount=rstcd.getInt("cdcount1");
				cdcountall=rstcd.getInt("cdcount1");
				
			}
			
			String sql12="Select count(ND) as ndcount1 from t_CastrolTripsStartEnded where ND='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'";
			ResultSet rstnd=st.executeQuery(sql12);
			if(rstnd.next())
			{
				//ndcount=rstnd.getInt("ndcount1");
				ndcountall=rstnd.getInt("ndcount1");
				
			}
			
			String sql13="Select count(Briefing) as bcount1 from t_CastrolTripsStartEnded where Briefing='briefed' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'";
			ResultSet rstb=st.executeQuery(sql13);
			if(rstb.next())
			{
				//bcount=rstb.getInt("bcount1");
				tbcount=rstb.getInt("bcount1");
			}
			
			String sql14="Select count(Debriefing) as dbcount1 from t_CastrolTripsStartEnded where Debriefing='Yes' and TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'";
			ResultSet rstdb=st.executeQuery(sql14);
			if(rstdb.next())
			{
				//dbcount=rstdb.getInt("dbcount1");
				tdbcount=rstdb.getInt("dbcount1");
			}
			
			String sqlall="Select * from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59'";
			ResultSet rstall=st1.executeQuery(sqlall);
			while(rstall.next())
			{
				//dr=rstall.getInt("DriverID");
				tripcount=rstall.getInt("TripID");
				Vehid=rstall.getInt("Vehid");
				Vehregno=rstall.getString("vehregno");
				OwnerName=rstall.getString("Transporter");
				
				//////////////////////////////////////////////////////
				//vehcount=rstt2.getString("vehregno");
				//OwnerName=rstall.getString("Transporter");
				//Vehid=rstt2.getInt("Vehid");
				
				drivercnt=rstall.getInt("DriverID");
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
				cdcnt=rstall.getString("CD");
				ndcnt=rstall.getString("ND");
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
				prcnt=100;
			}
			else
			{
				prcnt=Double.valueOf(kmcount)/Double.valueOf(stdkm1);
				prcnt=prcnt*100;
			}
		
%>	
<tr>
<td><%=k%></td>
<td><div align="left">
		<%=tripcount%> 
		</div></td>	
		<td>
		<div align="right">
		<%=Vehregno %>
		</div></td>
		<td>
		<div align="right">
		<%=OwnerName %>
		</div></td>
		<td><div align="right"><%=drivercnt %></div></td>
		<td><div align="right"><%=drivername %></div></td>
		<td>
		<div align="right">
		<%=startplace1 %>
		</div></td>
		<td>
		<div align="right">
		<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate)) %>
		</div></td>
		<td>
		<div align="right">
		<%=endplace %>
		</div></td>
		<td>
		<div align="right">
		<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate)) %>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(stdkm1);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(ttime1);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(kmcount);
		%>
		</div></td>
		
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
			out.print(cdcnt);
			
		%>
		</div></td>
		<td><div align="right">
		<%
			
			out.print(ndcnt);
		
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
		if(Integer.valueOf(rdcount1) > 0 && kmcount > 0)
		{
			Decelaration1=((Double.valueOf(rdcount1))/(double)kmcount)*100;
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
			
		%>		</div>			
		</td>
		
		<td>
		<div align="right">
		<%
		out.print(basic);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(module1);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(module2);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(module3);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(module4);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(briefdone);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(brieftrainername);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(briefcomment);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(debriefdone);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(debrieftrainername);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(debriefcomment);
		%>
		</div></td>
		<td>
		<div align="right">
		<%
		out.print(nf.format(prcnt));
		%>
		</div></td>
		<td>
		<div align="right"><%=category %>
		
		</div></td>
					
</tr>
<%k++;
}%>

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
		
	if(racountall > 0 && kmcountall > 0)
	{
		aa=((double)racountall/(double)kmcountall)*100;
	}	
	if(rdcountall > 0 && kmcountall > 0)
	{
		rr=((double)rdcountall/(double)kmcountall)*100;
		
	}		
	if(durationall > 0 && kmcountall> 0)
	{
		ss =(((double)durationall/10)/(double)kmcountall)*100;
	}
	rt=aa+rr+ss;
	
	if(kmcountall > 0)
	{
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
System.out.println("Done..........");
}
}

//*********************************************************************************************
} //the name
} //try

	catch(Exception e)
	{
	e.printStackTrace();
		//out.print("In side exception"+e);	
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


