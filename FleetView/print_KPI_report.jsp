<%@ include file="headerprintnew.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">

<!-- code start Here -->

<%!
Connection conn,conn1;
Statement st,st1,st2,st3;
String sql, data,data1,trips;
String startplace;

NumberFormat nf = DecimalFormat.getNumberInstance();
%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);

		data=request.getParameter("date1");
		data1=request.getParameter("date2");
		startplace=request.getParameter("startplace");
		startplace=startplace.replace("and","&");
	
		try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn1.createStatement();
		st3=conn1.createStatement();
	
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

</td></tr>
</table>
<table width="100%" border="1" align="center" class="stats">
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
			
				sql="select OwnerName,Vehid,DriverName,StartDate,StartPlace,EndDate,EndPlace,KmTravelled,OSDuration,RACount,RDCount,TripID,DriverID,VehRegNo,StartPlace,StartDate,EndPlace,EndDate,CRCount,NDCount from t_completedjourney where StartPlace = '"+startplace+"' and StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') group by TripID";
				ResultSet rstkm=st1.executeQuery(sql);
				while(rstkm.next())
				{
					vehcount=rstkm.getString("VehRegNo");
					OwnerName=rstkm.getString("OwnerName");
					Vehid=rstkm.getInt("Vehid");
					tripcount = rstkm.getString("TripID");
					drivercount=rstkm.getString("DriverID");
					drivername=rstkm.getString("DriverName");
					startplace1=rstkm.getString("StartPlace");
					endplace=rstkm.getString("EndPlace");
					startdate=rstkm.getString("StartDate");
					enddate=rstkm.getString("EndDate");
					kmcount=rstkm.getInt("KmTravelled");
					kmcountall=kmcountall+kmcount;
					oscount=rstkm.getInt("OSDuration");
					oscountall=oscountall+oscount;
					racount=rstkm.getInt("RACount");
					racountall=racountall+racount;
					rdcount=rstkm.getInt("RDCount");
					rdcountall=rdcountall+rdcount;
					duration=rstkm.getInt("OSDuration");
					durationall+=rstkm.getInt("OSDuration");
				
			%>	
			<tr>
			<td><%=i%></td>
			<td>			
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
				cdcount=rstkm.getString("CRCount");
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
				ndcount=rstkm.getString("NDCount");
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
}

%>
</td></tr>
</table>
</td></tr>
<tr><td><%@ include file="footernew.jsp"%></td></tr>
</table>