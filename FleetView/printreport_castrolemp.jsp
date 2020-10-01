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
Statement st1,st2,st;
int cntos,cntra,cntrda,cntdt,cntst,cntcd,cntnd,cntfc,cntft,cntfa;
double cntrh;
double cntavg=0.00;
String vehregno,transporter,empname,empcode;
%>

<%
cntos=0;
cntra=0;
cntrda=0;
cntdt=0;
cntst=0;
cntrh=0.0;
cntcd=0;
cntnd=0;
cntfc=0;
cntft=0;
cntfa=0;


//code to get system date as data2 and yesterdays date as a data1.



String data1=session.getAttribute("data1").toString();
String data2=session.getAttribute("data2").toString();
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();
//database connectivity to get the transporter wise report.
try{
	
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st=conn.createStatement();
	st2=conn1.createStatement();

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
<tr>
<th>Sr.</th>
<th>Vehicle Reg no.</th>
<th>Employee Name</th>
<th>Employee Code</th>
<th>Date</th>
<th>Location </th>
<th>OS</th>
<th>RA</th>
<th>RD</th>
<th>CD</th>
<th>DT</th>
<th>Stops</th>
<th>Run Hrs.</th>
<th>ND</th>
</tr>
<!-- Get The Data From the Database and show it -->

<%	
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname, loc="-",location="",dttime="";
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
			empname=rst.getString("EmpName");
			empcode=rst.getString("EmpCode");
		}
		if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
			%>
			<tr>
			<td><%=i %></td>
			<td><%=vehregno %></td>
			<td><%=empname %></td>
			<td><%=empcode %></td>
			<td>Blocked</td>
			<td>Access denied for <%=transporter%></td>
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
		sql="select * from "+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
			loc=rst1.getString("Location");
			 if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
			{
				 dttime=loc.substring(0,19);
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
		<td><%=i %></td>
		<td><%=vehregno %></td>
		<td><%=empname %></td>
		<td><%=empcode%></td>
		<td><%=dttime%></td>
		<td><div align="left">
		<%
		if(location.equalsIgnoreCase("No data"))
		{
			out.print(location);
		}
		else
		{
			out.print(fleetview.ShowOnMapOnlyByLocation(loc,aa,rst1.getString("TheDate")));
		}
		
		%>
		</div>
		</td>
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
		double rh=rstcounts.getDouble(11);
		/*String dte = "";
		dte = ""+rh;
		String runhrs = new SimpleDateFormat("HH").format(new SimpleDateFormat("ss").parse(dte));
		System.out.println("Runhrs===>"+runhrs);
		if("00".equalsIgnoreCase(runhrs))
			runhrs = "0";
			
		rh = Double.valueOf(runhrs); */
		cntrh=cntrh + rh;
		String runhrs = nf.format(rh);
		out.print(runhrs);
		%>
		</div>
		</td>
		
		<td>
		<%
		if(fleetview.isNightDrivingFormExceptionsForDateRange(aa,data1,data2).equals("Yes"))
		{
			cntnd++;
			%>
			<a href="detail_nd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"> Yes </a> 
			<%
		}
		else
		{
			out.print("No");
		}
		%>
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
			<td><%=empname %></td>
			<td><%=empcode %></td>
			<td>No DATA</td>
			<td>No DATA</td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td>No</td>
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
			conn.close();
			conn1.close();
		
	}
%>
<tr class="sortbottom">
<td colspan="6" class="hed">Total</td>
<td class="hed"><div align="right"><%=cntos %></div></td>
<td class="hed"><div align="right"><%=cntra %></div></td>
<td class="hed"><div align="right"><%=cntrda %></div></td>
<td class="hed"><div align="right"><%=cntcd %></div></td>
<td class="hed"><div align="right"><%=cntdt %></div></td>

<%
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
%>
<td class="hed"><div align="right"><%=cntst %></div></td>
<td class="hed"><div align="right"><%=nf1.format(cntrh) %></div></td>
<td class="hed"><div align="right"><%=cntnd %></div></td>
</tr>
</table>
 </td></tr>
</table>
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
        <%@ include file="footerprintnew.jsp" %>