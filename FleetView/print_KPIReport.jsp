<%@ include file="headerprintnew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">

<!-- code start Here -->

<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11,st111;
String sql,sql1,sql2, data,data1,trips;
int kmcountall,kmcount,tripcount,drivercount,tripcountall,drivercountall,vehcount,vehcountall,oscount,oscountall,racount,racountall,rdcount,rdcountall,cdcount,cdcountall,ndcount,ndcountall,countlatency,latency,durationall,duration;
String startplace,StartCode;
double ratingcount,ratingcountall;
double Accelaration1=0.0,Decelaration1=0.0,OverSpeed1=0.0;
double ss,aa,rr,rt;
NumberFormat nf = DecimalFormat.getNumberInstance();
 %>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
	
		data=request.getParameter("data");
		data1=request.getParameter("data1");
	
	
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		
		st=conn.createStatement();
		st1=conn.createStatement();
		st11=conn.createStatement();
		st111=conn.createStatement();
		
	
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
<table width="100%" border="1" align="center" class="stats">
			<tr>
			<td  class="hed" rowspan="2"> Sr.</td>
			<td  class="hed" rowspan="2"> Origin</td>
			<td  class="hed" rowspan="2"> Km. Travelled</td>
			<td  class="hed" rowspan="2"> Trips</td>
			<td  class="hed" rowspan="2"> Drivers</td>
			<td  class="hed" rowspan="2"> Vehicles</td>
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
					
			int i=1;			
			kmcountall=0;
			tripcountall=0;
			drivercountall=0;
			ratingcountall=0.0;
			vehcountall=0;
			oscountall=0;
			racountall=0;
			rdcountall=0;
			cdcountall=0;
			ndcountall=0;
			countlatency=0;
			durationall=0;
			int j=0;
			kmcount=0;
			tripcount=0;
			drivercount=0;
			ratingcount=0.0;
			vehcount=0;
			oscount=0;
			racount=0;
			rdcount=0;
			cdcount=0;
			ndcount=0;
			latency=0;
			duration=0;
			startplace="-";
			StartCode="-";
				sql="select sum(KmTravelled) as KmTravelled,sum(OSDuration) as OS,sum(RACount) as RA,sum(RDCount) as RD,count(distinct(TripID)) as Trips,count(distinct(DriverID)) as Driver,count(distinct(VehRegNo)) as VehRegNo, StartPlace, StartCode from t_completedjourney where StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') Group by StartPlace";
				ResultSet rstkm=st1.executeQuery(sql);
				while(rstkm.next())
				{
					startplace=rstkm.getString("StartPlace");
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
			%>	
			<tr>
			<td><%=i%></td>
			<td><div align="left">
			<%=startplace%>
			</div></td>
			<td><div align="right">
			<%
				out.print(kmcount);
			%>
			
			</div>	
			</td>
			<td>
			<div align="right">
			<%
				out.print(tripcount);
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
				out.print(oscount);
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
			sql1="select count(CRCount) as CD from t_completedjourney where startPlace='"+startplace+"' and CRCount='Yes' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') limit 1";
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
			</div></td>
			<td><div align="right">
			<%
			sql2="select count(NDCount) as ND from t_completedjourney where startPlace='"+startplace+"' and NDCount='Yes' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') limit 1";
			ResultSet rstnd=st111.executeQuery(sql2);
			if(rstnd.next())
			{
				ndcount=rstnd.getInt("ND");
				if(ndcount >0)
				{
				ndcountall++;
				out.print("Yes");
				}
				else
				{
				out.print("No");
				}
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
			%>
			</div></td>
			</tr>			
			<%
			i++;
			}
			%>	
			<tr>
			<td class="hed" colspan="2">Total :-</td>
			<td class="hed"><div align="right"><%=kmcountall%></div></td>
			<td class="hed"><div align="right"><%=tripcountall%></div></td>
			<td class="hed"><div align="right"><%=drivercountall%></div></td>
			<td class="hed"><div align="right"><%=vehcountall%></div></td>
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