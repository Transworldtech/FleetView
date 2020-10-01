<%@ include file="headernew.jsp"%>
<%!Connection conn, conn1;
	Statement st, st1, st2, st3, stmt1, stmt2, stmt3, stmt4, stmt5, stmt6,
			stmt7, stmt8, stmt9, stmt10;;
	String sql, data, data1, trips, sqll1, sqll2, sqll3, sqll4, sqll5, sqll6,
			sqll7, sqll8, sqll9, sqll10;;
	String startplace, triptype;

	NumberFormat nf = DecimalFormat.getNumberInstance();%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);

		data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("data1")));
		data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("data2")));
		startplace=request.getParameter("transporter");
		startplace=startplace.replace("and","&");
		triptype=request.getParameter("triptype");
		
		try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn1.createStatement();
		st3=conn1.createStatement();
		stmt1=conn.createStatement();
		stmt2=conn.createStatement();
		stmt3=conn.createStatement();
		stmt4=conn.createStatement();
		stmt5=conn.createStatement();
		stmt6=conn.createStatement();
		stmt7=conn.createStatement();
		stmt8=conn.createStatement();
		stmt9=conn.createStatement();
		stmt10=conn.createStatement();
	
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
<tr><td>
<%

%>
<font size="2">Key Performance Indicator Report for <b><%=startplace%></b> from <b><%=data%></b> to <b><%=data1%></b></font>
<div align="right">
				<a href="#" onclick="javascript:window.open('print_KPI_report.jsp?date1=<%=data%>&date2=<%=data1%>&startplace=<%=startplace.replace("&","and")%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="Excel_KPI_report.jsp?date1=<%=data%>&date2=<%=data1%>&startplace=<%=startplace.replace("&","and")%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
</div>
</td></tr>
</table>
<table border="1" width="100%" class="stats">
			<tr>
			<td  class="hed" rowspan="2"> Sr.</td>
			<td  class="hed" rowspan="2"> Trip ID</td>
			<td  class="hed" rowspan="2"> Vehicle Reg. No.</td>
			<td  class="hed" rowspan="2"> Transporter</td>
			<td  class="hed" rowspan="2"> Driver ID</td>
			<td  class="hed" rowspan="2"> Driver Name</td>
			<td  class="hed" rowspan="2"> Start Place</td>
			<td  class="hed" rowspan="2"> Start Date</td>
			<td  class="hed" rowspan="2"> End Place</td>
			<td  class="hed" rowspan="2"> End Date</td>
			<td  class="hed" rowspan="2"> Km Travelled</td>
			<td  class="hed" colspan="3"> Process Violations</td>
			<td  class="hed" colspan="2"> Policy Violations</td>
			<td  class="hed" rowspan="2"> Rating</td>
			</tr>		
			<tr>
			<td  class="hed"> OS Dur<br>(Sec)</br></td>
			<td  class="hed"> RA</td>
			<td  class="hed"> RD</td>
			<td  class="hed"> CD</td>
			<td  class="hed"> ND</td>
			</tr>
					<%
					data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
					data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
					
			double ratingcount,ratingcountall;
			double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
			double ss,aa,rr,rt;
			int i=1;			
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
			%>
			
			<%
			if(triptype.equalsIgnoreCase("Started"))
			{
				//System.out.println("Hiiiiiiiiiiiiiiiiiiiiiiiiii");
				sqll1="select Distinct(TripID) from t_startedjourney where GPName='Castrol' and StartDate between '"+data+"' and '"+data1+"' and OwnerName = '"+startplace+"'";
				ResultSet rstt1=stmt1.executeQuery(sqll1);
				while(rstt1.next())
				{
					tripcount = rstt1.getString("TripID");
					sqll2="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where TripID='"+tripcount+"'";
					ResultSet rstt2=stmt2.executeQuery(sqll2);
					if(rstt2.next())
					{

						vehcount=rstt2.getString("VehRegNo");
						OwnerName=rstt2.getString("OwnerName");
						Vehid=rstt2.getInt("Vehid");
						
						drivercount=rstt2.getString("DriverID");
						drivername=rstt2.getString("DriverName");
						startplace1=rstt2.getString("StartPlace");
						endplace=rstt2.getString("EndPlace");
						startdate=rstt2.getString("StartDate");
						enddate=rstt2.getString("EndDate");
						kmcount=rstt2.getInt("KmTravelled");
						kmcountall=kmcountall+kmcount;
						oscount=rstt2.getInt("OSDuration");
						oscountall=oscountall+oscount;
						racount=rstt2.getInt("RACount");
						racountall=racountall+racount;
						rdcount=rstt2.getInt("RDCount");
						rdcountall=rdcountall+rdcount;
						duration=rstt2.getInt("OSDuration");
						durationall+=rstt2.getInt("OSDuration");
					
				%>	
				<tr>
				<td><%=i%></td>
				<td><a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=vehcount%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm');">	
				               
				<%=tripcount %></a></td>
				<td>
				<div align="right">
				<%=vehcount %>
				</div></td>
				<td>
				<div align="right">
				<%=OwnerName %>
				</div></td>
				<td>
				<div align="right">
				<%=drivercount %>
				</div></td>
				<td>
				<div align="right">
				<%=drivername %>
				</div></td>
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
				out.print(kmcount);
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
					cdcount=rstt2.getString("CRCount");
					if(cdcount.equals("Yes"))
					{
					cdcountall++;
					out.print("Yes");
					}
					else
					{
					out.print("No");
					}
				%>
				</div></td>
				<td><div align="right">
				<%
					ndcount=rstt2.getString("NDCount");
					if(ndcount.equals("Yes"))
					{
					ndcountall++;
					out.print("Yes");
					}
					else
					{
					out.print("No");
					}
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
					
				%>		</div>			
				</td>
				</tr>			
				<%
				i++;
				
					}
					else
					{
						
						sqll3="select VehRegNo,OwnerName,DriverCode,DriverName,StartPlace,StartDate,EndPlace from t_startedjourney where TripId = '"+tripcount+"'";
						ResultSet rstt3=stmt3.executeQuery(sqll3);
						if(rstt3.next())
						{

							vehcount=rstt3.getString("VehRegNo");
							OwnerName=rstt3.getString("OwnerName");
							drivercount=rstt3.getString("DriverCode");
							drivername=rstt3.getString("DriverName");
							startplace1=rstt3.getString("StartPlace");
							endplace=rstt3.getString("EndPlace");
							startdate=rstt3.getString("StartDate");
						/*	enddate=rstt3.getString("EndDate");
							kmcount=rstt3.getInt("KmTravelled");
							kmcountall=kmcountall+kmcount;
							oscount=rstt3.getInt("OSDuration");
							oscountall=oscountall+oscount;
							racount=rstt3.getInt("RACount");
							racountall=racountall+racount;
							rdcount=rstt3.getInt("RDCount");
							rdcountall=rdcountall+rdcount;
							duration=rstt3.getInt("OSDuration");
							durationall+=rstt3.getInt("OSDuration");
							*/
						
					%>	
					<tr>
					<td><%=i%></td>
					<td><a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=vehcount%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm');">	
					               
					<%=tripcount %></a></td>
					<td>
					<div align="right">
					<%=vehcount %>
					</div></td>
					<td>
					<div align="right">
					<%=OwnerName %>
					</div></td>
					<td>
					<div align="right">
					<%=drivercount %>
					</div></td>
					<td>
					<div align="right">
					<%=drivername %>
					</div></td>
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
					<font color="RED">
					TRIP
					</font>
					</div></td>
					<td>
					<div align="right">
					<font color="RED">
					NOT
					</font>
					</div></td>
					<td><div align="right">
					<font color="RED">
					ENDED
					</font>
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td>
					<div align="right">
					NA
					</div>			
					</td>
					</tr>			
					<%
					i++;
					
						}
						
					}
				}
				
				
				//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and GPName='Castrol' group by TripID";
			
			
			
			}
			else if(triptype.equalsIgnoreCase("ended"))
			{
				//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and EndDate>='"+data+"' and EndDate<='"+data1+"' and and GPName='Castrol' group by TripID";

				sqll1="select Distinct(TripID) from t_completedjourney where GPName='Castrol' and EndDate between '"+data+"' and '"+data1+"' and OwnerName = '"+startplace+"'";
				ResultSet rstt1=stmt1.executeQuery(sqll1);
				while(rstt1.next())
				{
					tripcount = rstt1.getString("TripID");
					sqll2="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where TripID='"+tripcount+"'";
					ResultSet rstt2=stmt2.executeQuery(sqll2);
					if(rstt2.next())
					{

						vehcount=rstt2.getString("VehRegNo");
						OwnerName=rstt2.getString("OwnerName");
						Vehid=rstt2.getInt("Vehid");
						
						drivercount=rstt2.getString("DriverID");
						drivername=rstt2.getString("DriverName");
						startplace1=rstt2.getString("StartPlace");
						endplace=rstt2.getString("EndPlace");
						startdate=rstt2.getString("StartDate");
						enddate=rstt2.getString("EndDate");
						kmcount=rstt2.getInt("KmTravelled");
						kmcountall=kmcountall+kmcount;
						oscount=rstt2.getInt("OSDuration");
						oscountall=oscountall+oscount;
						racount=rstt2.getInt("RACount");
						racountall=racountall+racount;
						rdcount=rstt2.getInt("RDCount");
						rdcountall=rdcountall+rdcount;
						duration=rstt2.getInt("OSDuration");
						durationall+=rstt2.getInt("OSDuration");
					
				%>	
				<tr>
				<td><%=i%></td>
				<td><a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=vehcount%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm');">	
				               
				<%=tripcount %></a></td>
				<td>
				<div align="right">
				<%=vehcount %>
				</div></td>
				<td>
				<div align="right">
				<%=OwnerName %>
				</div></td>
				<td>
				<div align="right">
				<%=drivercount %>
				</div></td>
				<td>
				<div align="right">
				<%=drivername %>
				</div></td>
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
				out.print(kmcount);
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
					cdcount=rstt2.getString("CRCount");
					if(cdcount.equals("Yes"))
					{
					cdcountall++;
					out.print("Yes");
					}
					else
					{
					out.print("No");
					}
				%>
				</div></td>
				<td><div align="right">
				<%
					ndcount=rstt2.getString("NDCount");
					if(ndcount.equals("Yes"))
					{
					ndcountall++;
					out.print("Yes");
					}
					else
					{
					out.print("No");
					}
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
					
				%>		</div>			
				</td>
				</tr>			
				<%
				i++;
				
					}
					else
					{
						
						sqll3="select VehRegNo,OwnerName,DriverCode,DriverName,StartPlace,StartDate,EndPlace from t_startedjourney where TripId = '"+tripcount+"'";
						ResultSet rstt3=stmt3.executeQuery(sqll3);
						if(rstt3.next())
						{

							vehcount=rstt3.getString("VehRegNo");
							OwnerName=rstt3.getString("OwnerName");
							drivercount=rstt3.getString("DriverCode");
							drivername=rstt3.getString("DriverName");
							startplace1=rstt3.getString("StartPlace");
							endplace=rstt3.getString("EndPlace");
							startdate=rstt3.getString("StartDate");
						/*	enddate=rstt3.getString("EndDate");
							kmcount=rstt3.getInt("KmTravelled");
							kmcountall=kmcountall+kmcount;
							oscount=rstt3.getInt("OSDuration");
							oscountall=oscountall+oscount;
							racount=rstt3.getInt("RACount");
							racountall=racountall+racount;
							rdcount=rstt3.getInt("RDCount");
							rdcountall=rdcountall+rdcount;
							duration=rstt3.getInt("OSDuration");
							durationall+=rstt3.getInt("OSDuration");
							*/
						
					%>	
					<tr>
					<td><%=i%></td>
					<td><a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=vehcount%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm');">	
					               
					<%=tripcount %></a></td>
					<td>
					<div align="right">
					<%=vehcount %>
					</div></td>
					<td>
					<div align="right">
					<%=OwnerName %>
					</div></td>
					<td>
					<div align="right">
					<%=drivercount %>
					</div></td>
					<td>
					<div align="right">
					<%=drivername %>
					</div></td>
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
					<font color="RED">
					TRIP
					</font>
					</div></td>
					<td>
					<div align="right">
					<font color="RED">
					NOT
					</font>
					</div></td>
					<td><div align="right">
					<font color="RED">
					ENDED
					</font>
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td>
					<div align="right">
					NA
					</div>			
					</td>
					</tr>			
					<%
					i++;
					
						}
						
					}
				}
				
				
				//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and GPName='Castrol' group by TripID";
				
			}
			else
			{
				//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and EndDate<='"+data1+"' and and GPName='Castrol' group by TripID";

				//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and EndDate>='"+data+"' and EndDate<='"+data1+"' and and GPName='Castrol' group by TripID";

				sqll1="select Distinct(TripID) from t_completedjourney where GPName='Castrol' and StartDate >= '"+data+"' and EndDate <= '"+data1+"' and OwnerName = '"+startplace+"'";
				ResultSet rstt1=stmt1.executeQuery(sqll1);
				while(rstt1.next())
				{
					tripcount = rstt1.getString("TripID");
					sqll2="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where TripID='"+tripcount+"'";
					ResultSet rstt2=stmt2.executeQuery(sqll2);
					if(rstt2.next())
					{

						vehcount=rstt2.getString("VehRegNo");
						OwnerName=rstt2.getString("OwnerName");
						Vehid=rstt2.getInt("Vehid");
						
						drivercount=rstt2.getString("DriverID");
						drivername=rstt2.getString("DriverName");
						startplace1=rstt2.getString("StartPlace");
						endplace=rstt2.getString("EndPlace");
						startdate=rstt2.getString("StartDate");
						enddate=rstt2.getString("EndDate");
						kmcount=rstt2.getInt("KmTravelled");
						kmcountall=kmcountall+kmcount;
						oscount=rstt2.getInt("OSDuration");
						oscountall=oscountall+oscount;
						racount=rstt2.getInt("RACount");
						racountall=racountall+racount;
						rdcount=rstt2.getInt("RDCount");
						rdcountall=rdcountall+rdcount;
						duration=rstt2.getInt("OSDuration");
						durationall+=rstt2.getInt("OSDuration");
					
				%>	
				<tr>
				<td><%=i%></td>
				<td><a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=vehcount%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm');">	
				               
				<%=tripcount %></a></td>
				<td>
				<div align="right">
				<%=vehcount %>
				</div></td>
				<td>
				<div align="right">
				<%=OwnerName %>
				</div></td>
				<td>
				<div align="right">
				<%=drivercount %>
				</div></td>
				<td>
				<div align="right">
				<%=drivername %>
				</div></td>
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
				out.print(kmcount);
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
					cdcount=rstt2.getString("CRCount");
					if(cdcount.equals("Yes"))
					{
					cdcountall++;
					out.print("Yes");
					}
					else
					{
					out.print("No");
					}
				%>
				</div></td>
				<td><div align="right">
				<%
					ndcount=rstt2.getString("NDCount");
					if(ndcount.equals("Yes"))
					{
					ndcountall++;
					out.print("Yes");
					}
					else
					{
					out.print("No");
					}
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
					
				%>		</div>			
				</td>
				</tr>			
				<%
				i++;
				
					}
					else
					{
						
						sqll3="select VehRegNo,OwnerName,DriverCode,DriverName,StartPlace,StartDate,EndPlace from t_startedjourney where TripId = '"+tripcount+"'";
						ResultSet rstt3=stmt3.executeQuery(sqll3);
						if(rstt3.next())
						{

							vehcount=rstt3.getString("VehRegNo");
							OwnerName=rstt3.getString("OwnerName");
							drivercount=rstt3.getString("DriverCode");
							drivername=rstt3.getString("DriverName");
							startplace1=rstt3.getString("StartPlace");
							endplace=rstt3.getString("EndPlace");
							startdate=rstt3.getString("StartDate");
						/*	enddate=rstt3.getString("EndDate");
							kmcount=rstt3.getInt("KmTravelled");
							kmcountall=kmcountall+kmcount;
							oscount=rstt3.getInt("OSDuration");
							oscountall=oscountall+oscount;
							racount=rstt3.getInt("RACount");
							racountall=racountall+racount;
							rdcount=rstt3.getInt("RDCount");
							rdcountall=rdcountall+rdcount;
							duration=rstt3.getInt("OSDuration");
							durationall+=rstt3.getInt("OSDuration");
							*/
						
					%>	
					<tr>
					<td><%=i%></td>
					<td><a href="#" onclick="javascript:window.open('showonmap.jsp?tripid=<%=tripcount%>&vehcode=<%=Vehid%>&sdate=<%=startdate%>&vehregno=<%=vehcount%>&ownername=<%=OwnerName%>&startplace=<%=startplace1%>&endplace=<%=endplace%>&enddate=<%=enddate%>&pg=cm');">	
					               
					<%=tripcount %></a></td>
					<td>
					<div align="right">
					<%=vehcount %>
					</div></td>
					<td>
					<div align="right">
					<%=OwnerName %>
					</div></td>
					<td>
					<div align="right">
					<%=drivercount %>
					</div></td>
					<td>
					<div align="right">
					<%=drivername %>
					</div></td>
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
					<font color="RED">
					TRIP
					</font>
					</div></td>
					<td>
					<div align="right">
					<font color="RED">
					NOT
					</font>
					</div></td>
					<td><div align="right">
					<font color="RED">
					ENDED
					</font>
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td><div align="right">
					NA
					</div></td>
					<td>
					<div align="right">
					NA
					</div>			
					</td>
					</tr>			
					<%
					i++;
					
						}
						
					}
				}
				//sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and GPName='Castrol' group by TripID";
			}
			%>	
			<tr>
			<td class="hed" colspan="10">Total :-</td>
			<td class="hed"><div align="right"><%=kmcountall%></div></td>
			<td class="hed"><div align="right"><%=oscountall%></div></td>
			<td class="hed"><div align="right"><%=racountall%></div></td>
			<td class="hed"><div align="right"><%=rdcountall%></div></td>
			<td class="hed"><div align="right"><%=cdcountall%></div></td>
			<%
			if(ndcountall > 0)
			{
				%>
				<td class="hed"><div align="right">Yes</div></td>
				<%
			}
			else
			{
				%>
				<td class="hed"><div align="right">No</div></td>
				<%
			}
			%>
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
			</tr>
			</table>

<%
}
}catch(Exception ee)
{
	out.print("Exception---->"+ee);
}
finally
{
	conn.close();
	conn1.close();
}

%>
</td></tr>
</table>
</td></tr>
<tr><td><%@ include file="footernew.jsp"%></td></tr>
</table>