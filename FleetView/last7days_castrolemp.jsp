<%@ include file="headernew.jsp" %> 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<script type="text/javascript">
var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");}
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
};
 
</script>
 <table border="0" width="100%">
<tr><td>
<%!
Connection conn, conn1;
Statement st1,st2,st;
int cntos,cntra,cntrda,cntdt,cntst,cntrh,cntcd,cntnd,cntfc,cntft,cntfa;
Double cntavg=0.00;
String vehregno,transporter,empname,empcode;
%>
<%
cntos=0;
cntra=0;
cntrda=0;
cntdt=0;
cntst=0;
cntrh=0;
cntcd=0;
cntnd=0;
cntfa=0;
cntft=0;
cntfc=0;
cntavg=0.00;

//code to get system date as data2 and yesterdays date as a data1.

java.util.Date NewDate =new java.util.Date();

long dateMillis = NewDate.getTime();
long dayInMillis = 1000 * 60 * 60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
Format NewFormatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String data2 = NewFormatter.format(NewDate);
String data4 = NewFormatter1.format(NewDate);
long dayInMills1=6000*60*60*24;
NewDate.setTime(dateMillis-dayInMills1);
String data1 = NewFormatter.format(NewDate);
String data3 = NewFormatter1.format(NewDate);
session.setAttribute("data1",data1);
session.setAttribute("data2",data2);
session.setAttribute("data3",data3);
session.setAttribute("data4",data4);

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
	session.setAttribute("reportno","Report No:5.0");
	session.setAttribute("reportname","Last 7 Days Exception Report For Full Fleet");
	

%>

<table border="0" width="100%" class="stats" >
  <tr><td colspan="3" align="center">
<!-- <div align="left"><font size="3">Report No:5.0</font></div>-->
<font size="3"><b>Last 7 Days Exception Report For Full Fleet</b></font>
</td></tr>
<tr>
<td colspan="3" align="center">
<font size="3"><b>Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period : 
<%
java.util.Date ShowDate = new SimpleDateFormat("yyyy-MM-dd").parse(data1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String showdate = formatter.format(ShowDate);
out.print(showdate);
%> 00:00:00 am to <%
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
out.print(showdate1);
session.setAttribute("ShowDate",showdate+" 00:00:00");
session.setAttribute("ShowDate1",showdate1+" 23:59:00");

String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());

%> 23:59:00 am</b></font>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printreport_castrolemp.jsp');" title="Print Last 24 Hours Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exporttoexcel_castrolemp.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
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
<th>Veh.</th>
<th>Employee Name</th>
<th>Employee Code</th>
<th>Transporter</th>
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
			empname=rst.getString("EmpName");
			empcode=rst.getString("EmpCode");
		}
		if(fleetview.checkUserBlocked(transporter).equals("Yes"))
		{
			%>
			<tr>
			<td style="text-align: right"><%=i %></td>
			<td style="text-align: left"><%=vehregno %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">Blocked</td>
			<td style="text-align: left">Access denied for <%=transporter%></td>
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
		%>
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><a href="customreportemp.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
		<td style="text-align: left"><%=empname %></td>
		<td style="text-align: right"><%=empcode%></td>
		<td style="text-align: left"><%=transporter %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate")) %></td>
		<td style="text-align: left"><div align="left">
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
			<a href="detail_ra.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&pageType=RapidAcceleration"> <%=ra%> </a> 
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
			<a href="detail_cd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&pageType=ContinuousDriving"> <%=cd%> </a> 
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
		
		int rh=rstcounts.getInt(7);
		cntrh+=rh;
		out.print(rh);
		%>
		</div>
		</td>
		
		<td>
		<%
		if(fleetview.isNightDrivingFormExceptionsForDateRange(aa,data1,data2).equals("Yes"))
		{
			cntnd++;
			%>
			<a href="detail_nd.jsp?vid=<%=aa%>&vehno=<%=vehregno%>&pageType=NightDriving"> Yes </a> 
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
			<td style="text-align: right"><%=i %></td>
			<td style="text-align: left"><%=vehregno %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter%>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: left">No DATA</td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td><div align="right">0</div></td>
			<td style="text-align: left">No</td>
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
//NumberFormat nf1=NumberFormat.getInstance();
//nf1.setMaximumFractionDigits(2);
//nf1.setMinimumFractionDigits(2);
%>

<td class="hed"><div align="right"><%=cntst %></div></td>
<td class="hed"><div align="right"><%=cntrh %></div></td>
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
        <%@ include file="footernew.jsp" %>
