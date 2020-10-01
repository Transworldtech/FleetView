 <%@ include file="headerprintnew.jsp" %> 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
 <table border="0" width="100%">
<tr ><td>
<%!
Connection conn, conn1;
Statement st1,st2,st,st3,st21;

String vehregno,transporter,dateformat;
%>

<%
int cntos,cntra,cntrda,cntst,cntrh,cntcd,cntnd,datadaystotal,cntndk,disk,cntft,cntfa;
double stopdur,totstopdur;
Double cntavg=0.00,cntdt=0.0,cntfc=0.0;
cntos=0;
cntra=0;
cntrda=0;
cntst=0;
datadaystotal=0;
cntrh=0;
cntcd=0;
cntnd=0;
cntndk=0;
disk=0;
cntft=0;
cntfa=0;
stopdur=0.0;
totstopdur=0.0;



//code to get system date as data2 and yesterdays date as a data1.



String data1=session.getAttribute("data1").toString();
String data2=session.getAttribute("data2").toString();
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
dateformat = session.getAttribute("dateformat").toString();
//database connectivity to get the transporter wise report.
try{
	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st21=conn1.createStatement();

%>

<table border="0" width="100%" >
  <tr><td colspan="3" align="center">
<div align="left"><font size="3"><%=session.getAttribute("reportno").toString()%></font></div>
<font size="3"><b><%=session.getAttribute("reportname").toString()%></b></font>
</td></tr>
<tr>
<td colspan="3" align="center">
<font size="3"><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period : 
<%=session.getAttribute("ShowDate").toString()%> to
<%=session.getAttribute("ShowDate1").toString()%></b></font>
<div class="bodyText" align="right">
<%=fleetview.PrintDate() %></div>
</td></tr>
</table>

<table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
<tr><th colspan="3" class="sorttable_nosort"><div align="center">Parameters considered for the Report</div></th></tr>
<tr><td class="bodyText"><div align="left">1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %>
</div></td><td class="bodyText"><div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></div></td><td class="bodyText" ><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></div></td></tr>
<tr>
<td class="bodyText"><div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %> 
</div>
</td><td class="bodyText"><div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %></div></td>
<td  class="bodyText"><div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %></div></td></tr>
</table>

<p></p>
<table border="1" width="100%" class="sortable">
<tr ><th>Sr.</th>
<th>Vehicle Reg no.</th>
<th>Date</th>
<th>Location </th>
<th>Data Days</th>
<th>OS</th>
<th>RA</th>
<th>RD</th>
<th>CD</th>
<th>DT</th>
<th>FT</th>
<th>FA</th>
<th>FC</th>
<th>AVG</th>
<th>Stops</th>
<th>Run Hrs.</th>
<th>ND</th>
<th>Total ND Km</th>
<th>DayStop(Hrs)</th>
</tr>
<!-- Get The Data From the Database and show it -->

<%	
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	int i=1;
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_veh"+aa+"_ds";
	if(!aa.equals("0"))
	{
	String sql="select * from t_vehicledetails where vehicleCode='"+aa+"'";
	ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			vehregno=rst.getString("VehicleRegNumber");
			transporter=rst.getString("OwnerName");
		}
		int datadayscount=0;
		if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
			%>
			<tr>
			<td><%=i %></td>
			<td><%=vehregno %></td>
			<td>Blocked</td>
			<td>Access denied for <%=transporter%></td>
			<td style="text-align: right"><%=datadayscount%></td>
		
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			<td>-</td>
			</tr>
			<%
			i++;	
		}
		else
		{
			String datadays="select count(distinct(TheFieldDataDate)) as count  from db_gps.t_veh"+aa+" where TheFieldDataDate>='"+data1+"' and TheFieldDataDate<='"+data2+"'";
			ResultSet datadaysrs=st21.executeQuery(datadays);
			if(datadaysrs.next())
			{
				datadayscount=datadaysrs.getInt("count");
				datadaystotal=datadaystotal+datadayscount;
			}
	
		
		sql="select * from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
		%>
		<tr>
		<td><%=i %></td>
		<td><%=vehregno %></td>
		<td><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheDate")) %></td>
		<td><div align="left">
		<%
		String loc=rst1.getString("Location");
		if(loc.equals("-"))
		{
			out.print(loc);
		}
		else
		{
			out.print(fleetview.ShowOnMapOnlyByLocation(loc,aa,rst1.getString("TheDate")));
		}
		
		%>
		</div>
		</td>
			<td style="text-align: right"><%=datadayscount%></td>
		
		<%
		ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
		<td><div align="right">
		<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			%>
			<a href="detail_os.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=os%> </a> 
			<%				
		}
		else
		{
			out.print(os);
		}
		%>
		</div>
		</td>
		<td>
		<div align="right">
		<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{
			%>
			<a href="detail_ra.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=ra%> </a> 
			<%
		}
		else
		{
			out.print(ra);
		}
		
		%>
		</div>
		</td>
		<td>
		<div align="right">
		<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			%>
			<a href="detail_rd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=rd%> </a> 
			<%
		}
		else
		{
			out.print(rd);
		}
		
		%>
		</div>
		</td>
		<td>
		<div align="right">
		<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%>
			<a href="detail_cd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=cd%> </a> 
			<%
		}
		else
		{
			out.print(cd);
		}
		
		%>
		</div>
		</td>
		<td>
		<div align="right">
		<%
		int dt=rstcounts.getInt(5);
		cntdt+=dt;
		out.print(dt);
		%>
		</div>
		</td>
		
		<td><div align="right">
		<%
		int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%>
			<a href="detail_os.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=ft%> </a> 
			<%				
		}
		else
		{
			out.print(ft);
		}
		%>
		</div>
		</td>
		
		
		<td><div align="right">
		<%
		int fa=rstcounts.getInt(8);
		cntfa+=fa;
		if(fa >0)
		{
			%>
			<a href="detail_os.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=fa%> </a> 
			<%				
		}
		else
		{
			out.print(fa);
		}
		%>
		</div>
		</td>
		
		<%
		if(fleetview.getUnitDescription(aa).equals("FUELFLOW"))
		{
			%>
			<td><div align="right">
			
			<%
				
				int fcval=fleetview.getFuelConsumptionForDateRange(aa,data1,data2);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
			</div></td>
			<td><div align="right"><%
			NumberFormat nf=NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			//Double favgval=fleetview.getFuelAVGForDateRange(aa,data1,data2);
			//cntavg=cntavg+favgval;
			Double favgval=0.0;
			if(Double.valueOf(fcval)>0)
			{
			 favgval=Double.valueOf(dt)/Double.valueOf(fcval);
			}
			if(cntdt>0)
			{
				cntavg=cntdt/cntfc;
			}
			
			out.print(nf.format(favgval));
			
			
			
			%></div></td>
			<%
		}
		else
		{
			%>
			<td><div align="right">-</div></td>
			<td><div align="right">-</div></td>
			<%
		}
		%>
		<td>
		<div align="right">
			<%
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			%>
			<a href="detail_stops.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> <%=stsp%> </a> 
			<%
		}
		else
		{
			out.print(stsp);
		}
		
		%>
		</div>
		</td>
		
		<td>
		<div align="right">
		<%
		
		NumberFormat nf = DecimalFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);	
		nf.setGroupingUsed(false);
		double d=0.0;
		d=rstcounts.getDouble(11);
		/*	String dte = "";

			
			dte = ""+d;
			String runhrs = new SimpleDateFormat("HH").format(new SimpleDateFormat("ss").parse(dte));
			System.out.println("Runhrs===>"+runhrs);
			if("00".equalsIgnoreCase(runhrs))
				runhrs = "0";
			d = Double.valueOf(runhrs);*/
			String runhrs =  nf.format(d);
			cntrh+= d;
			out.print(runhrs);
		%>
		</div>
		</td>
		
		<td>
		<%
		int cntnd11=fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
		if(cntnd11>0)
	{
		cntnd+=cntnd11;
		%>
					<%=cntnd11%>  <%
	}
	else
	{
		out.print(0);
	}
	%>
				</td>
	<% 			
	int cntnd12=fleetview.NightDrivingFormExceptionsForDateRange1(aa,data1,data2);
	%>
	<td style="text-align: left">
	<%
	if(cntnd12>0)
	{
		cntndk+=cntnd12;
	%>			
		<%=cntnd12 %>
	<%
	}else
	{
		out.print(0);
	}
	%>		
		
		</td>
		<td>
		<div align="right">
		<%
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rststop=st3.executeQuery(sqlstop);
		//String sqlstop="select * from from t_veh"+aa+"_ds where  TheDate >='"+data1+"' AND TheDate <='"+data2+"'";
		System.out.println(sqlstop);
		if(rststop.next())
		{
			stopdur=rststop.getDouble("stopduration");
			totstopdur=totstopdur+rststop.getDouble("stopduration");
			%>
		<!--  	<a href="detail_daystop.jsp?vid=< %=aa%>&vehno=< %=vehregno%>"> --><%=stopdur%> <!-- </a> --> 
			<%
		}
		else
		{
			out.print("0");
			
		}
		
		%>
		</div>
		</td>
		</tr>
		<%
		i++;
		}
		}
		else
		{
			%>
			<tr>
			<td><%=i %></td>
			<td><%=vehregno %></td>
			<td>No DATA</td>
			<td>No DATA</td>
				<td style="text-align: right"><%=datadayscount%></td>
		
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td>No</td>
			<td><div align="right">0</div></td>
			</tr>
			<%
			i++;
		}
	}
	}
	}
	}catch(Exception e)
	{
		System.out.println("Exception" +e);
	}
	finally
	{
			try
		{
			conn.close();
		}catch(Exception e){}
		try
		{
			conn1.close();
		}
		catch(Exception e){}
		
		try
		{
		fleetview.closeConnection1();
		}catch(Exception e){}
		try
		{
		fleetview.closeConnection();
		}
		catch(Exception e){}
		
	}
%>
<tr class="sortbottom">
<td colspan="4" class="hed">Total</td>

<td class="hed"><div align="right"><%=datadaystotal %></div></td>
<td class="hed"><div align="right"><%=cntos %></div></td>
<td class="hed"><div align="right"><%=cntra %></div></td>
<td class="hed"><div align="right"><%=cntrda %></div></td>
<td class="hed"><div align="right"><%=cntcd %></div></td>
<td class="hed"><div align="right"><%=cntdt %></div></td>
<td class="hed"><div align="right"><%=cntft %></div></td>
<td class="hed"><div align="right"><%=cntfa %></div></td>
<td class="hed"><div align="right"><%=cntfc %></div></td>
<td class="hed"><div align="right">
<%
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
%>
<%=nf1.format(cntavg) %></div></td>
<td class="hed"><div align="right"><%=cntst %></div></td>
<td class="hed"><div align="right"><%=cntrh %></div></td>
<td class="hed"><div align="right"><%=cntnd %></div></td>
<td class="hed"><div align="right"><%=cntndk %></div></td>
<td class="hed"><div align="right"><%=totstopdur %></div></td>
</tr>
</table>
 </td></tr>
</table>
<%
//fleetview.closeConnection1();
//fleetview.closeConnection();
%>
</jsp:useBean>
        <%@ include file="footerprintnew.jsp" %>
