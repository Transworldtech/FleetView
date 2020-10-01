
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"KPI_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11,st111;
String sql,sql1,sql2, data,data1,trips,ndcount1="";
String g="",s="",y="",p=""; 
int kmcountall,kmcount,tripcount,drivercount,tripcountall,drivercountall,vehcount,vehcountall,oscount,oscount1,oscountall,oscountall1,racount,racountall,rdcount,rdcountall,cdcount,cdcountall,ndcount,ndcountall,countlatency,latency,durationall,duration,RHcount,RHcountall,stop,stopall,BriefGoalsall,AdhJRMall,DeBriefGoalall;
String startplace,StartCode;
double ratingcount,ratingcountall;
double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
double ss,aa,rr,rt;
NumberFormat nf = DecimalFormat.getNumberInstance();
String BriefGoals="-";
String AdhJRM="-";
String DeBriefGoal="-";
 %>
<%
String usertypevalue=session.getAttribute("usertypevalue").toString();
System.out.println("transportername"+usertypevalue);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
	
		data=request.getParameter("data");
		data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
		 g=data.concat(" ");
		 s=g.concat("00:00:00");
		System.out.println("values of data appendeddata*****"+s);
		
		data1=request.getParameter("data1");
		data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
        y=data1.concat(" ");
	     p=y.concat("23:59:59");
		System.out.println("values of appendeddata11111@@@@@@"+p);
	
	
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		
		st=conn.createStatement();
		st1=conn.createStatement();
		st11=conn.createStatement();
		st111=conn.createStatement();
		st3=conn.createStatement();
	
	
	}catch(Exception e)
	{
		out.print("Exception--->"+e);
	}
%>

<!-- **************************** -->

<table border="1" width="100%" align="center" bgcolor="white">
<tr><td>
<table border="0" width="100%" align="center" bgcolor="white">
<tr><td>
<table class="stats">
<tr><td><font color="brown" size="2">Key Performance Indicator Report</font></td></tr>
<tr><td><div align="right">
<%
			if(!(null==request.getQueryString()))
			{
				data=request.getParameter("data");
			    data1=request.getParameter("data1");
				
			}
			else
			{
			data=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data));
			data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));
			}
%>
</div></td></tr>
</table>
</td></tr>
<tr><td>
<%
try{
if(!(null==request.getQueryString()))
{
%>
<table border="0" width="100%" align="center" class="stats">
<tr><td>
<font size="2">Key Performance Indicator Report from <%=data%> to <%=data1%></font>

</td></tr>
</table>
<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th rowspan="2"> Sr.</th>
			<th rowspan="2"> Origin</th>
			<th rowspan="2"> Loaded Trips</th>
			<th rowspan="2"> Completed Trips</th>
			<th rowspan="2"> Brief Trips</th>		
			<th rowspan="2"> Not Brief Trips</th>
			<th rowspan="2"> DeBrief Trips</th>		
			<th rowspan="2"> Not DeBrief Trips</th>
			<th rowspan="2"> Km. Travelled</th>
			<th rowspan="2"> Drivers</th>
			<th rowspan="2"> Veh.</th>
			<th colspan="4"> Process Violations</th>
			<th colspan="2"> Policy Violations</th>
			<th rowspan="2"> Rating</th>
			<th rowspan="2"> RH Violation</th>
			<th rowspan="2"> Stops</th>
			<th rowspan="2"> Goals To Be Achieved</th>
			<th rowspan="2"> Adherance to JRM</th>
			<th rowspan="2"> Goals achieved</th>
			
			</tr>		
			<tr>
			
			<th> OS Dur<br>(Sec)</br></th>
			<th> OS Count</th>
			<th> RA</th>
			<th> RD</th>
			<th> CD</th>
			<th> ND</th>
			
			</tr>
					<%
					data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data));
					data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
					
			int i=1;			
			kmcountall=0;
			tripcountall=0;
			drivercountall=0;
			ratingcountall=0.0;
			vehcountall=0;
			oscountall=0;
			oscountall1=0;
			racountall=0;
			rdcountall=0;
			cdcountall=0;
			ndcountall=0;
			countlatency=0;
			durationall=0;
			stopall=0;
			BriefGoalsall=0;
			AdhJRMall=0;
			DeBriefGoalall=0;
			
			int j=0;
			kmcount=0;
			tripcount=0;
			drivercount=0;
			ratingcount=0.0;
			vehcount=0;
			oscount=0;
			oscount1=0;
			racount=0;
			rdcount=0;
			cdcount=0;
			ndcount=0;
			RHcount=0;
			stop=0;
			latency=0;
			duration=0;
			startplace="-";
			StartCode="-";
			int BriTripCount=0,DeBriTripCount=0,Loadedtrips=0,LoadedtripsAll=0;
			int BriTripCountAll=0,DeBriTripCountAll=0;
			String trips="";
			
			    ndcount1=request.getParameter("ndcount");
// 			 	sql="select sum(KmTravelled) as KmTravelled,sum(OSDuration) as OS,sum(RACount) as RA,sum(RDCount) as RD,count(distinct(TripID)) as Trips,count(distinct(DriverID)) as Driver,count(distinct(VehRegNo)) as VehRegNo, StartPlace, StartCode,sum(NDCount) as ND from db_gps.t_completedjourney where StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') Group by StartPlace";
			    sql="select  sum(a.KmTravelled) as KmTravelled,sum(a.OSDuration) as OS,sum(a.OSCount) as oscount,sum(a.RACount) as RA,sum(a.RDCount) as RD,count(distinct(a.TripID)) as Trips,count(distinct(a.DriverID)) as Driver,count(distinct(a.VehRegNo)) as VehRegNo,a.StartPlace as startlocation, a.StartCode as startlocationcode,sum(a.NDCount) as ND,sum(a.runhrvio)as rhvio,sum(a.stoppagecount) as stops,sum(a.crcount) as cd,count(b.goalstobeachieved) as goals,count(c.adhjrm) as jrm,count(c.GoalsAchived) as goalachieved from db_gps.t_completedjourney as a left outer join db_gps.t_briefing as b on a.tripid=b.tripid left outer join db_gps.t_debriefing as c on b.tripid=c.tripid where a.StartDate>='"+s+"' and a.StartDate<='"+p+"' and (a.OwnerName LIKE '"+usertypevalue+"' OR a.GPName LIKE '"+usertypevalue+"') Group by a.StartPlace";
				ResultSet rstkm=st1.executeQuery(sql);
				System.out.println("nddddddddddddddd" +sql);
				while(rstkm.next())
				{
					
				//String sql31="select a.tripid as tripid from db_gps.t_briefing a inner join db_gps.t_completedjourney b on a.tripid=b.tripid and  a.Driverid=b.DriverID where b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					
					BriTripCount=0;
					DeBriTripCount=0;
					startplace=rstkm.getString("startlocation");
					kmcount=rstkm.getInt("KmTravelled");
					kmcountall=kmcountall+kmcount;
					oscount=rstkm.getInt("OS");
					oscountall=oscountall+oscount;
					racount=rstkm.getInt("RA");
					racountall=racountall+racount;
					rdcount=rstkm.getInt("RD");
					rdcountall=rdcountall+rdcount;
					duration=rstkm.getInt("OS");
					durationall+=rstkm.getInt("OS");
					drivercount=rstkm.getInt("Driver");
					drivercountall=drivercountall+drivercount;
					tripcount=rstkm.getInt("Trips");
					tripcountall=tripcountall+tripcount;
					vehcount=rstkm.getInt("VehRegNo");
					vehcountall=vehcountall+vehcount;
					ndcount = rstkm.getInt("ND");
					ndcountall += rstkm.getInt("ND");
// 					RHcount = rstkm.getInt("rhvio");
// 					RHcountall=RHcountall+RHcount;
					RHcount = rstkm.getInt("rhvio");
					System.out.println("rh violation"+RHcount);
					RHcountall=RHcountall+RHcount;
					System.out.println("rh violation allllll"+RHcountall);
					
					oscount1=rstkm.getInt("oscount");
					oscountall1=oscountall1+oscount1;
// 					System.out.println("rh violation"+RHcount);
					
// 					System.out.println("rh violation allllll"+RHcountall);
					stop=rstkm.getInt("stops");
// 					System.out.println("stop violation"+stop);
					stopall+= rstkm.getInt("stops");
// 					System.out.println("stop violation allll"+stopall);
					BriefGoals=rstkm.getString("goals");
					BriefGoalsall+= rstkm.getInt("goals");
					AdhJRM=rstkm.getString("jrm");
					AdhJRMall+= rstkm.getInt("jrm");
					DeBriefGoal=rstkm.getString("goalachieved");
					DeBriefGoalall+= rstkm.getInt("goalachieved");
					
					
					
					
					String sql31="SELECT count(distinct(tripid)) AS tripid FROM db_gps.t_startedjourney WHERE  StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and StartPlace='"+startplace+"'";
					System.out.println(">>>>>>" +sql31);
					ResultSet rst31=st3.executeQuery(sql31);
					if(rst31.next())
					{Loadedtrips=rst31.getInt("tripid");
					}
				
					
					
					
					
					
					
					try{
// 					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_briefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and  a.Driverid=b.DriverCode and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_briefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					//String sql3="select count(tripid) as tripid from db_gps.t_briefing where tripid in ("+trips+")";
					System.out.println(">>>>>>" +sql3);
					ResultSet rst3=st3.executeQuery(sql3);
					if(rst3.next())
					{BriTripCount=rst3.getInt("tripid");	
					
					}
					}catch(Exception e)
					{
						e.printStackTrace();
					}
					
					try{
// 					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_debriefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and  a.Driverid=b.DriverCode and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					String sql3="select count(distinct(b.tripid)) as tripid from db_gps.t_debriefing a inner join db_gps.t_startedjourney b on a.tripid=b.tripid and b.StartDate>='"+data+"' and b.StartDate<='"+data1+"' and (b.OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR b.GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') and b.StartPlace='"+startplace+"'";
					//String sql3="select count(tripid) as tripid from db_gps.t_debriefing where tripid in ("+trips+")";
					System.out.println(">>>>>>" +sql3);
					ResultSet rst3=st3.executeQuery(sql3);
					if(rst3.next())
					{DeBriTripCount=rst3.getInt("tripid");	
					
					}
					}catch(Exception e)
					{
						e.printStackTrace();
					}
					LoadedtripsAll=LoadedtripsAll+Loadedtrips;
					DeBriTripCountAll=DeBriTripCountAll+DeBriTripCount;
					BriTripCountAll=BriTripCountAll+BriTripCount;
					System.out.println("@@@@@" +DeBriTripCount);
					System.out.println("@@@@@" +BriTripCount);
					
			%>	
			<tr>
			<td align="right"><%=i%></td>
			<td align="left"><%=startplace%>
			</td>
			<td align="right"><%out.print(Loadedtrips);%></td>
			<td align="right"><%out.print(tripcount);%></td>
			<td align="right"><%out.print(BriTripCount);%></td>
			<td align="right"><%out.print(Loadedtrips-BriTripCount);%></td>			
			<td align="right"><%out.print(DeBriTripCount);%></td>
			<td align="right"><%out.print(Loadedtrips-DeBriTripCount);%></td>					
			<td align="right"><%out.print(kmcount);%></td>
			<td align="right"><%out.print(drivercount);%></td>
			<td align="right"><%out.print(vehcount);%>	</td>
			<td align="right"><%out.print(oscount);%></td>
			<td align="right"><%out.print(oscount1);%></td>
			<td align="right"><%out.print(racount);%></td>
			<td align="right"><%out.print(rdcount);%></td>
			<td align="right">
			<%
			sql1="select count(CRCount) as CD from db_gps.t_completedjourney where startPlace='"+startplace+"' and CRCount='Yes' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') limit 1";
			ResultSet rstcd=st11.executeQuery(sql1);
			if(rstcd.next())
			{
				cdcount=rstcd.getInt("CD");
// 				if(cdcount >0)
// 				{
// 				cdcountall++;
// 				out.print("Yes");
                out.print(cdcount);
				cdcountall=cdcountall+cdcount;


// 				}
// 				else
// 				{
// 				out.print("No");
// 				}
			}			
			%>
			</td>
			<td align="right">
			<%
			
			/*sql2="select count(NDCount) as ND from t_completedjourney where startPlace='"+startplace+"' and NDCount>0 and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') limit 1";
			ResultSet rstnd=st111.executeQuery(sql2);
			System.out.println("sssssssssssss222222" +sql2);
			if(rstnd.next())
			{
				ndcount=rstnd.getInt("ND");
				if(ndcount >0)
				{
			       ndcountall++;*/
				%>
				<%=ndcount %>
				<%
			//	out.print("Yes");
			/*	}
				else
				{
				out.print("0");
				}
			}		*/	
			%>
			</td>
			<td align="right">
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
			</td>
			<td><div align="right"><%out.print(RHcount);%></div></td>
			<td><div align="right"><%out.print(stop);%></div></td>
			
			<td><div align="right"><%out.print(BriefGoals);%></div></td>
			<td><div align="right"><%out.print(AdhJRM);%></div></td>
			<td><div align="right"><%out.print(DeBriefGoal);%></div></td>
			</tr>			
			<%
			i++;
			}
			%>	
			<tr>
			<td align="left" colspan="2">Total</td>
			<td align="right"><%=LoadedtripsAll%></td>
			<td align="right"><%=tripcountall%></td>
			<td align="right"><%=BriTripCountAll%></td>
			<td align="right"><%=LoadedtripsAll-BriTripCountAll%></td>
			<td align="right"><%=DeBriTripCountAll%></td>
			<td align="right"><%=LoadedtripsAll-DeBriTripCountAll%></td>
			
			<td align="right"><%=kmcountall%></td>
			<td align="right"><%=drivercountall%></td>
			<td align="right"><%=vehcountall%></td>
			<td align="right"><%=oscountall%></td>
			<td align="right"><%=oscountall1%></td>
			<td align="right"><%=racountall%></td>
			<td align="right"><%=rdcountall%></td>
			<td align="left"><%=cdcountall%></td>
			<td align="right"><%=ndcountall%></td>
			<%
				/*if(ndcountall > 0)
				{*/
					%>
<!--					<td align="right">Yes</td>-->
					<%
				/*}
				else`
				{*/
					%>
<!--					<td align="right">No</td>-->
					<%
				//}
			%>
					<td align="right">
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
			%></td>
			<td class="hed"><div align="right"><%=RHcountall%></div></td>
			<td class="hed"><div align="right"><%=stopall%></div></td>
			<td class="hed"><div align="right"><%=BriefGoalsall%></div></td>
			<td class="hed"><div align="right"><%=AdhJRMall%></div></td>
			<td class="hed"><div align="right"><%=DeBriefGoalall%></div></td>
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
	try
	{
		conn.close();
	}catch(Exception e)
	{}

}

%>
</td></tr>
</table>
</td></tr>
<tr><td><%@ include file="footernew.jsp"%></td></tr>
</table>