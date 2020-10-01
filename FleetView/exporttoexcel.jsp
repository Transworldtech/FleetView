<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString();
int cnt = 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename=filename.substring(0,cnt-1)+showdatex+"_customreport.xls";
}
else
{
	filename=session.getAttribute("user").toString()+"_customreport.xls";
}
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
    
%>
 <%@ include file="Connections/conn.jsp" %> 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
String type=request.getParameter("type");
System.out.println(">>>>>>>>>>>>>>>>type:"+type);
%>
 <table border="0" width="100%">
<tr ><td>
<%!
Connection conn, conn1;
Statement st1, st2, st, st3, st4, st5, st15,st21,stmain11,stt,st7;
int cntos, cntra, cntrda, cntdt, cntst,datadaystotal, cntcd, cntnd,cntndk,disk, cntfc, cntdisconn,
		cntft = 0, cntfa = 0;
int cntndpost=0;
double cntrh, cntavgos, cntavgra, cntavgrd, cntosdur;
double stopdur, totstopdur, cntrating;
double cntavg = 0.00,timevikram=0.0;
String vehregno, transporter;
String datex1, datex2, data1, data2;
String dateformat;%>
<%

datadaystotal=0;
cntdisconn=0;
cntrating=0;
cntos=0;
cntra=0;
cntrda=0;
cntdt=0;
cntst=0;
cntrh=0.0;
cntcd=0;
cntnd=0;
cntndk=0;
disk=0;
cntfc=0;
cntosdur=0;
stopdur=0.0;
totstopdur=0.0;
cntavgos=0.0;
cntavgra=0.0;
cntavgrd =0.0; //code to get system date as data2 and yesterdays date as a data1.
cntft=0;
cntfa=0;
cntavg=0.0;
int nd_pri=0;
//code to get system date as data2 and yesterdays date as a data1.



String data1=session.getAttribute("data1").toString();
String data2=session.getAttribute("data2").toString();
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
double tot_dur=0.0;
String time1 ="00:00:00";
String time2="23:59:59";
//database connectivity to get the transporter wise report.
try{
	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();
	st4=conn1.createStatement();
	st5=conn1.createStatement();
	st21=conn1.createStatement();
	stmain11=conn1.createStatement();
	stt=conn1.createStatement();
	st7= conn1.createStatement();
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
<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;&nbsp;
<%=fleetview.PrintDate() %></div>
</td></tr>
</table>

<table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
<tr><th colspan="9" class="sorttable_nosort"><div align="center">Parameters considered for the Report</div></th></tr>
<tr><td class="bodyText" colspan="4"><div align="left">1. OverSpeed :
<%=session.getAttribute("overspeed").toString() %>
</div></td><td class="bodyText" colspan="5"><div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%></div></td><td class="bodyText" ><div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%></div></td></tr>
<tr>
<td class="bodyText" colspan="4"><div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %> 
</div>
</td><td class="bodyText" colspan="5"><div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %></div></td>
<td  class="bodyText"><div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %></div></td></tr>
</table>
 <br>
            <b>Note:'Yes' in Average Speed Considered Column indicates Average speed is considered in calculation of Run hrs </b>
            </br>
			<p></p>
			<table border="1" width="100%" class="sortable">
				<tr>
					<th>Sr.</th>
					<th>Vehicle Reg no.</th>
					<th>Vehicle Type</th>
					<th>Transporter</th>
					<th>Date</th>
					<th>Location</th>
					<th>Data Days</th>
					<th>OS</th>
					<th>OS Dur</th>
					<th>RA</th>
					<th>RD</th>
					<th>CD</th>
					<th>DT</th>
					<th colspan="1">Rating</th>
					<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
					<th>Avg OS Dur/100km</th>
					<th>Avg RA/100km</th>
					<th>Avg RD/100km</th>
					<%}%>
					<th>FT</th>
					<th>FA</th>
					<th>FC</th>
					<th>AVG</th>
					<th>Stops</th>
					<th>Run Hrs.</th>
					<th>AVG speed</th>
					<th>ND</th>
					<th>ND Dur(Hrs)</th>
					<th>ND Km</th>
					<th>ND Int</th>	
					<th>ND Reason</th>
					<th>DayStop(Hrs)</th>
					<th>DC</th>
					<th>Total DC Km</th>
					

				</tr>
				<!-- Get The Data From the Database and show it -->

				<%	
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname;
	String vehtype="";
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
			vehtype=rst.getString("vehtype");
		}
		int datadayscount=0;
		if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
			%>
				<tr>
					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left"><%=vehtype %></td>
					<td style="text-align: left"><%=transporter%></td>
					<td style="text-align: left">Blocked</td>
					<td style="text-align: left">Access denied for <%=transporter%></td>
					<td style="text-align: right"><%=datadayscount%></td>
		
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
					<td>-</td>
					<td>-</td>
					<td>-</td>
					<%}%>
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
	
			
			Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
			String dttime="",location="",loc="";
			sql="select * from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
			ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
			
			 loc=rst1.getString("Location");
			if(!loc.equalsIgnoreCase("No data"))
			{
				 dttime=loc.substring(0,15);
				 location=loc.substring(19);
			}
			else{
				
				location=loc;
				dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
				/*System.out.println("location"+location);
				String sqldate="Select * from db_gps.t_veh"+aa+" where thefielddatadate='"+data2+"' order by thefielddatatime desc limit 1";
				ResultSet rstdate=st2.executeQuery(sqldate);
				if(rstdate.next())
				{
					dttime=rstdate.getString("thefielddatadatetime");
					System.out.println("dttime"+dttime);
				}
				else{
					dttime=data2;
					System.out.println("dttime"+dttime);
				}*/
				
			}
		%>
				<tr>

					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left"><%=vehtype %></td>
					<td style="text-align: left"><%=transporter %></td>
					<td style="text-align: right"><%=dttime %></td>
					<td>
					<div align="left">
					<%
	
		
		if(location.equalsIgnoreCase("No data") && !("-").equals(loc))
		{
			out.print(location);
		}
		else
		{
			out.print(fleetview.ShowOnMapOnlyByLocation(location,aa,rst1.getString("TheDate")));
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
					<td>
					<div align="right">
					<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			%>  <%=os%>
					 <%				
		}
		else
		{
			out.print(os);
		}
		%>
					</div>
					</td>
					<%
		double osavg =0.0;
		double osduration=0.0;
		String sqlos="SELECT sum(Duration)as duration FROM t_veh"+aa+"_overspeed  where concat(FromDate,' ',FromTime) >='"+data1+" 00:00:00' and ToDate <='"+data2+" 23:59:59' order by concat(FromDate,' ',FromTime)";
		System.out.println("sqlos--->"+sqlos);
		ResultSet rstos=st4.executeQuery(sqlos);
		if(rstos.next())
		{
			osduration=rstos.getDouble("Duration");
			System.out.println(" OS Duration--->"+osduration);
		}
		cntosdur= cntosdur + osduration;
		%>
					<td>
					<div align="right"><%=osduration%></div></td>
					<td>
					<div align="right">
					<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{ 
			%> 
					<%=ra%>  <%
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
					<%=rd%>  <%
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
					<%=cd%>  <%
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
		double dt=rstcounts.getDouble(5);
		cntdt+=dt;
		out.print(dt);
		%>
					</div>
					</td>

					<td>
					<div align="right">
					<%
					NumberFormat nfrating=NumberFormat.getInstance();
					nfrating.setMaximumFractionDigits(2);
					nfrating.setMinimumFractionDigits(2);			
		double rating=0.0;
	  	if(dt>0.0)
	  	{
	  	double RD=((rd/dt)*100);
	  	double RA=((ra/dt)*100);	
	  	double OS=((osduration/10/dt)*100);
	  	rating=RA+RD+OS;
	  	
	  	out.print(nfrating.format(rating));
	  	}
	  	else{
	  		out.print(0.0);
	  	}
	  	cntrating=rating+cntrating;
	  	%>
					</div>
					</td>

                   <%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
					<td>
					<div align="right">
					<%
			System.out.println("IN OS Avg");
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			//int osduration=fleetview.getOSDurationforDateRange(aa,data1,data2);
			
				if(osduration> 0.0 && dt >0.0)
				{
					System.out.println("distance --->"+dt);
					osavg=(osduration*10)/dt;
					System.out.println("OS avg--->"+osavg);
					out.print(nfos.format(osavg));
					//out.print(osavg);
					//out.print(osavg);
				}
				else{
					osavg=0.0;
					out.print(nfos.format(osavg));
					//out.print(osavg);
				}
				cntavgos+=osavg;
			
			
			%>
					</div>
					</td>
					<td>
					<div align="right">
					<% 
		NumberFormat nfra=NumberFormat.getInstance();
		nfra.setMaximumFractionDigits(2);
		nfra.setMinimumFractionDigits(2);
		double raavg =0.0;
		if(ra>0 && dt>0.0 )
		{
			System.out.println("RA --->"+ra);
			raavg= (ra/dt)*100;
			System.out.println("RA avg--->"+raavg);
			out.print(nfra.format(raavg));
			//out.print(raavg);
		}
		else  //if(dt==0.0 && ra>0 ||ra==0) 
		{ 
			raavg= 0.0;
			out.print(nfra.format(raavg));
		}
		cntavgra+=raavg;
		%>
					</div>
					</td>
					<td>
					<div align="right">
					<% 
		NumberFormat nfrd=NumberFormat.getInstance();
		nfrd.setMaximumFractionDigits(2);
		nfrd.setMinimumFractionDigits(2);
		double rdavg =0.0;
		
		if(rd>0 && dt>0.0)
		{
			System.out.println("RD -->"+rd);
			rdavg= (rd/dt)*100;
			System.out.println("RD avg--->"+rdavg);
			out.print(nfrd.format(rdavg));
			//out.print(rdavg);
			
		}
		else //if(dt==0.0 && rd>0 ||rd==0 )
		{
			rdavg= 0.0;
			out.print(nfrd.format(rdavg));
			//cntavgrd+=rdavg;
		}
		cntavgrd+=rdavg;
		%>
					</div>
					</td>
                    <%}%>
					<td>
					<div align="right">
					<%
		int ft=0;
		try{
			String sql4="select count(*) as fcnt from t_vehft where vehcode like '"+aa+"' and Thedate>='"+data1+"' and TheDate <='"+data2+"' order by concat(TheDate,TheTime) desc";
			ResultSet rs4= st2.executeQuery(sql4);
			if(rs4.next())
			{  
				ft=rs4.getInt("fcnt");
			}
			}catch (Exception e) {
				System.out.print("Exception--->"+e);
			}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> 
					<%=ft%> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>


					<td>
					<div align="right">
					<%
		int fa=0;
		try{
			String sql4="select count(*) as fcnt from t_vehfa where vehcode like '"+aa+"' and Thedate>='"+data1+"' and TheDate <='"+data2+"' order by concat(TheDate,TheTime) desc";
			ResultSet rs4= st2.executeQuery(sql4);
			if(rs4.next())
			{  
				fa=rs4.getInt("fcnt");
			}
			else{
				out.print(0);
			}
			}catch (Exception e) {
				System.out.print("Exception--->"+e);
			}
		//int fa=rstcounts.getInt(8);
		//cntfa+=fa;
		if(fa >0)
		{
			%> <a
						href="showfueladd.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=fa%> </a> <%				
		}
		else
		{
			out.print(0);
		}
		%>
					</div>
					</td>

					<%
		if(fleetview.getUnitDescription(aa).equals("FUELFLOW"))
		{
			%>
					<td>
					<div align="right">
					<%
				
				int fcval=fleetview.getFuelConsumptionForDateRange(aa,data1,data2);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td>
					<div align="right">
					<%
			NumberFormat nf=NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			Double favgval=fleetview.getFuelAVGForDateRange(aa,data1,data2);
			cntavg=cntavg+favgval;
			out.print(nf.format(favgval));
			
			
			
			%>
					</div>
					</td>
					<%
		}
		else
		{
			%>
					<td>
					<div align="right">-</div>
					</td>
					<td>
					<div align="right">-</div>
					</td>
					<%
		}
		%>
					<td>
					<div align="right">
					<%
			System.out.println("IN stop");
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			%>  <%=stsp%>
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
					<div align="left">
					<%
		 
		String avgsped="No";
		try{
			
		
		String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
		System.out.println("avgspeed==>"+avgspeed);
		ResultSet rstavg=st3.executeQuery(avgspeed);
		if(rstavg.next())
		{
			/*System.out.println("in avg speed");
			avgsped=rst1.getString("AvgSpeedConsidered");
			if(avgsped.equalsIgnoreCase("Yes"))
			{
				System.out.println("in Yes");*/
				out.print("Yes");
		}
			else{
				System.out.println("in NO");
				out.print("No");
			}
		//}
		//else{
			//out.print("No");
		// }
		}catch(Exception ea){
			System.out.println("Avg speed exception"+ea);
		}
		System.out.println("out of avgspeed");
		//cntdisconn=cntdisconn+rstdisconn.getInt("cnt"); 
		%>
					</div>
					</td>
					<td style="text-align: left">
					<%
					int cntnd11=fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
					if(cntnd11>0)
				{
					cntnd+=cntnd11;
					%> 
								<%=cntnd11%>
								<%
				}
				else
				{
					out.print(0);
				}
				%>
							</td>
							<td>
					<%
					
					int count1=0;
					String Time="00:00:00";
					try
					{
						String sql1="select Sec_To_Time(SUM(Time_To_Sec(Duration))),SUM(Time_To_Sec(Duration)) from t_veh"+aa+"_nd where  FromDate between '"+data1+"' and '"+data2+"' order by fromdate asc";
						System.out.println(">>>>>>>>>>>>>>>>sql1:"+sql1);
						ResultSet rst11=stmain11.executeQuery(sql1);
						if(rst11.next())
						{
							
								//count=rst11.getInt("cnt");
								Time=rst11.getString(1);
							    System.out.println(">>>>>>>>>>>>>>>>Time:"+Time);
							    tot_dur=tot_dur+rst11.getDouble(2);
							    System.out.println(">>>>>>>>>>>>>>>>tot_dur:"+tot_dur);
						}
					}catch (Exception e) {
						System.out.println("Exception-->"+e);
						
					}
					if(Time==null||Time==" ")
					{
						Time="00:00:00";
					}
					try
					{
						StringTokenizer str=new StringTokenizer(Time,":");
	                     while(str.hasMoreTokens())
	                     {
	                    	 String test=str.nextToken();
	                    	 String test1=str.nextToken();
	                    	 Time=test+"."+test1;
	                    	 String test2=str.nextToken();
	                     }
	                     timevikram=timevikram+Double.valueOf(Time.trim()).doubleValue();

					}
					catch(Exception e)
					{
						System.out.println(">>>>>>>exception:"+e);
					}
					%>
					<%=Time %>
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
												<!-- ---------------------------------------------------------- -->
															<td>
					<%
					
					int count=0;
					try
					{
						String sql1="select count(*) as cnt from t_veh"+aa+"_nd where  NDPreAuthorised='Yes' and FromDate>='"+data1+"' and FromDate <='"+data2+"' order by fromdate asc";
						ResultSet rst11=stmain11.executeQuery(sql1);
						if(rst11.next())
						{
							if(rst11.getInt("cnt")>0)
							{
								count=rst11.getInt("cnt");
								nd_pri=nd_pri+count;
							}
						}
					}catch (Exception e) {
						//System.out.println("Exception-->"+e);
						
					}
					
					%>
					<%=count %>
					</td>
					 <td>
                                <div align="right">
                                <% 
                                try{
                                        
                                //      String sqlpost="select count(*) as Reason from db_gpsExceptions.t_ndpostintimation where NdStartDateTime >='"+data1+" "+time1+"' and NdEndDateTime <='"+data2+" "+time2+"' and VehRegNo='"+vehregno+"' ";
                   
                                        String sqlpost="select count(*) as Reason from db_gpsExceptions.t_ndpostintimation where NdStartDateTime between '"+data1+" "+time1+"' and '"+data2+" "+time2+"' and VehRegNo='"+vehregno+"'";
                                
                                ResultSet rsndpost=st7.executeQuery(sqlpost);
                    
                    if(rsndpost.next())
                        {
                                if(rsndpost.getInt("Reason")>0)
                                {
                                        %>
                                                
                        <!--    <a href="detail_nd.jsp?vid=< %=aa%>&vehno=< %=vehregno%>&data1=< %=data1+' '+time1 %>&data2=< %=data2+' '+time2 %>&pageType=NightDriving"> < %=rsndpost.getInt("Reason")%> </a> -->
                            
                            
                            <a href="reason_details.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&data1=<%=data1+' '+time1 %>&data2=<%=data2+' '+time2 %>" ><%=rsndpost.getInt("Reason")%> </a>
                                        <%
                                }
                                else{
                                        out.print(0);
                                }
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rsndpost.getInt("Reason");
                                }catch(Exception ee)
                                {
                                 System.out.println("Exception in ND post intimation"+ee);
                                }
                                
                                %>
                         </div>
                                </td>
					<!-- ---------------------------------------------------------- -->
							
							<td >
							<div align="right">
							<%
				
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rststop=st3.executeQuery(sqlstop);
		
		if(rststop.next())
		{
			stopdur=rststop.getDouble("stopduration");
			totstopdur=totstopdur+rststop.getDouble("stopduration");
			%> <%=stopdur%> <%
		}
		else
		{
			out.print("0");
			
		}
		
		%>
					</div>
					</td>

				
					<%
					try{
						System.out.println("\n\n-->>in try....");
						
						//String time1 ="00:00:00";
						//String time2="23:59:59";
						
						String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59'";
		                 //System.out.println("sqldisconn==>"+sqldisconn);
		                 System.out.println("\n\n-->>in try....11");
						ResultSet rstdisconn=st5.executeQuery(sqldisconn);
						  System.out.println("\n\n-->>in try....22");
						%>
						<td >
									<div align="right">
						<%
						if(rstdisconn.next())
						{
							if(rstdisconn.getInt("cnt")>0)
							{
								%>
								 <%=rstdisconn.getInt("cnt")%> 
								<%
							}
							else{
								out.print(0);
							}
							
						}
						else
						{
							out.print(0);
						}
						
						cntdisconn=cntdisconn+rstdisconn.getInt("cnt");
						%>
						</div></td>
						<%

						// count total km of diss
						sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00'";
		
						ResultSet rstdis=st5.executeQuery(sqldisconn);
						int diskm=0;
						while(rstdis.next())
						{
						  diskm=diskm+rstdis.getInt("Distance");
						}
						%>
						<td >
									<div align="right">
						<%
						
						if(diskm>0)
						{
							disk+=diskm;
							%>
							<%=diskm %>
						<%
						}
						else
						{
							out.print(0);
						}
						
						//... end of total km
						
						%>
						</div>
						</td>
						<%
						
						
						}catch(Exception ee)
						{
							System.out.println("Exception disconnection "+ee);
						}
						System.out.println("out of Disconnection");
							%>
					

		
				</tr>
				<%
		i++;
				System.out.println("value of i"+i);	
		}
		System.out.println("While");	
		}
		else
		{
			%>
				<tr>
					<td style="text-align: right"><%=i %></td>
					<td style="text-align: left"><%=vehregno %></td>
					<td style="text-align: left"><%=vehtype %></td>
					<td style="text-align: left">No DATA</td>
					<td style="text-align: left">No DATA</td>
					<td>
					<div align="left">No DATA</div>
					</td>
					<td style="text-align: right"><%=datadayscount%></td>
		
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<%}%>
					<td>
					<div align="right">0</div>
					</td>
					<td style="text-align: left">No</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">No</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">00.00</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					<td>
					<div align="right">0</div>
					</td>
					
				</tr>
				<%
			i++;
		}
	}
	}
	}
	

NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
//String tt="0";
%>
				<tr class="sortbottom">
					<td colspan="6" class="hed"><div align="right">Total</div></td>
					<td class="hed">
					<div align="right"><%=datadaystotal %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntos %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntosdur %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntra %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntrda %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntcd %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntdt %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntrating %></div>
					</td>
					<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavgos) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavgra) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavgrd) %></div>
					</td>
					<%}%>
					<td class="hed">
					<div align="right"><%=cntft %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntfa %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntfc %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntavg) %></div>
					</td>
					
					<td class="hed">
					<div align="right"><%=cntst %></div>
					</td>
					
					<td class="hed">
					<div align="right"><%=nf1.format(cntrh) %></div>
					</td>
					<td class="hed">
					<div align="right">-</div>
					</td>
					<td class="hed">
					<div align="right"><%=cntnd %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(timevikram) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=cntndk %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nd_pri %></div>
					</td>
					
                    <td class="hed">
					<div align="right"><%=cntndpost %></div>
					</td>	                
					<td class="hed">
					<div align="right"><%=nf1.format(totstopdur) %></div>
					</td>
					<td class="hed">
					<div align="right"><%=nf1.format(cntdisconn)%></div>
					</td>
					<td class="hed">
					<div align="right"><%=disk %></div>
					</td>
					
				</tr>
			</table>
			<%

}catch(Exception e)
{
	System.out.println("Exception" +e);
}
finally
{
		try
		{
			conn.close();
		}catch(Exception e)
		{}
		try
		{
			conn1.close();
		}catch(Exception e)
		{}
		try
		{
			fleetview.closeConnection1();
		}catch(Exception e)
		{}
		try
		{
			fleetview.closeConnection();
		}catch(Exception e)
		{}
		
	
}
%>
			</td>
		</tr>
	</table>
	<%
//fleetview.closeConnection1();
//fleetview.closeConnection();
%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>
