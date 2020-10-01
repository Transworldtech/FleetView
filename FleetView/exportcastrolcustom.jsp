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
String type=request.getParameter("type");
System.out.println(">>>>>>>>>>>>>>>>type:"+type);
%>
<%!
	Connection conn=null, conn1=null;
	Statement st1,st2,st,st3,st4,st5,stndck,st21,st15,stmain11,stmain2,stt,st7,stmain12,stmain1,stmain3,stmain4;
	//int cntos,cntra,cntrda,cntdt,cntst,cntcd,cntnd,cntfc,datadaystotal;
	
	
	
	
%>
  <%
    
   String datex1="",datex2="",data1="",data2="";
	String vehregno="",transporter="",empname="",empcode="";

  //session.setAttribute("data1",data1);
  //session.setAttribute("data2",data2);
  data1 =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));         
  // request.getParameter("data");
  data2 =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1"))); 
	  //request.getParameter("data1");
  
  String user,usertypevalue;
  user=session.getAttribute("user").toString();
  usertypevalue=session.getAttribute("usertypevalue").toString();
  System.out.println("Date is "+data1+" and user is "+user+" and user type is"+usertypevalue);
  %>
  <table border="0" width="500" align="center" class="stats">
  <tr><td colspan="5" align="center">
<font face="Arial" color="black" size="3"><b>Custom Report For Full Fleet</b></font>
</td></tr></table>

 <table border="0" width="100%">
 <tr><td>
<%


String dd=request.getQueryString();
if(dd==null)
{
out.println("<center ><font size='2'>Please select the dates to display the report.</font></center>");

}else{
//database connectivity to get the transporter wise report.
try{
	
	
	
	String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_gpsExceptions";
	//String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";
	
	Class.forName(MM_dbConn_DRIVER);	   
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	
	
	
	st=conn.createStatement();
	st=conn.createStatement();
	st3=conn.createStatement();
	st2=conn1.createStatement();
	//st4=conn1.createStatement();
	st4=conn1.createStatement();
	st5=conn.createStatement();
	st21=conn.createStatement();
	st15=conn1.createStatement();
	stmain11 = conn1.createStatement();
	stmain12 = conn1.createStatement();
	stt = conn1.createStatement();
	st7= conn1.createStatement();
	stmain1= conn1.createStatement();
	stndck= conn1.createStatement();
	stmain2= conn1.createStatement();
	stmain3= conn1.createStatement();
	stmain4= conn1.createStatement();

	
	
	
	
	
	  String  exportFileName=session.getAttribute("mainuser").toString()+"_custom_report.xls";

session.setAttribute("reportno","Report No:6.0");
session.setAttribute("reportname","Custom Report For Full Fleet");
%>

<table border="0" width="100%" class="stats">
<tr>
<td colspan="3" align="center">
<%

Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data1));
String showdate1=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));




System.out.println(">>>>>>data1>"+data1+">>>>>data2>"+data2);
System.out.println(">>>>>>showdate>"+showdate+">>>>>showdate1>"+showdate1);
 %>
 
<table border="0" width="30%" align="left"> 
		<tr>
		<td  class="sorttable_nosort"><b>
			<a href="report_castrolemp.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype=all">Full Fleet</a></b>
		<input type="hidden" name="type" id="type" value="More Info"/>	
		</td>
		<td class="sorttable_nosort"><b><a href="report_castrolemp.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype=zerokm">Zero KM</a></b></td>
				<td class="sorttable_nosort"><b><a href="report_castrolemp.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype=zerogps">Zero GPS Violation</a></b></td>
						<td class="sorttable_nosort"><b><a href="report_castrolemp.jsp?data=<%=showdate%>&data1=<%=showdate1%>&submit=Submit&fleettype=morethan5">Violations >5</a></b></td>
 
 </tr></table>
 <%
 System.out.println("Fleet type is " +request.getParameter("fleettype"));
 System.out.println("Fleet type11 is " +request.getParameter("fleettype11"));

 if(request.getParameter("fleettype")!=null || "null".equals(request.getParameter("fleettype11")))
 {
	 %>
	 <table border="0" width="30%" align="left"> 
		<tr>
		<td  class="sorttable_nosort"><b>
		<%
 	
 if("all".equals(request.getParameter("fleettype")) && "null".equals(request.getParameter("fleettype11")))
 {
      %> Full Fleet Report </b></td></tr></table>
      <%
 }
 else if("zerokm".equals(request.getParameter("fleettype1")))
 { %> Zero KM Report </b></td></tr></table>
 <%
 
 }
 else if("zerogps".equals(request.getParameter("fleettype2")))
 {
	 %> Zero GPS Violation Report </b></td></tr></table>
     <%
 }

 else if("morethan5".equals(request.getParameter("fleettype")))
 {
	 %> Violations > 5  Report </b></td></tr></table>
     <%
 }

 
 }
 else
 {
	 %>
	 <table border="0" width="30%" align="left"> 
		<tr>
		<td  class="sorttable_nosort"><b>Full Fleet Report </b></td></tr></table>
		<%
 }
 %>
 
 </table></td></tr><tr><td>
<form id="Total_os" name="Total_os" action="" method="post">
 <div id="mytable">
<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>

		
		
		
		 
<font face="Arial" color="black" size="2">Individual stops > 10 mins and cumulative stops > 20 mins are considered as stoppage in Continuous Driving. 
</font>
<br>
<font face="Arial" color="black" size="3">Exception Analysis Report For AVL Mobile Eye 2000 for <%=usertypevalue %> For the Period : 
<%

out.print(showdate);
%> 00:00:00 am to <%

out.print(showdate1);
session.setAttribute("ShowDate",showdate+" 00:00:00");
session.setAttribute("ShowDate1",showdate1+" 23:59:00");

String tdydate = new SimpleDateFormat("yyyy-mm-dd").format(new java.util.Date());

%> 23:59:00 am

</font>
<table border="1" width="100%" bgcolor="#F5F5F5" class="sortable">
  <tr>
      <th colspan="3" class="sorttable_nosort">
      <div align="center">Parameters considered for the Report</div>
      </th>
  </tr>
    
  <tr>
      <td class="bodyText">
      <div align="left">1. OverSpeed :<%=session.getAttribute("overspeed").toString() %>
      </div>
      </td>
      <td class="bodyText">
      <div align="left">2. Rapid Acceleration :<%=session.getAttribute("racc").toString()%>
      </div>
      </td>
      <td class="bodyText" >
      <div align="left">3. Rapid Deceleration :<%=session.getAttribute("rdcc").toString()%>
      </div>
      </td>
  </tr>
  
  <tr>
       <td class="bodyText">
       <div align="left">4. Night Driving : <%=session.getAttribute("ndri").toString() %> 
       </div>
       </td>
       <td class="bodyText">
       <div align="left">5. Continuous Driving :><%=session.getAttribute("cdri").toString() %>
       </div>
       </td>
       <td  class="bodyText">
       <div align="left">6. Stoppages  :<%=session.getAttribute("stop").toString() %>
       </div>
       </td>
  </tr>
</table>
 <br>
<font face="Arial" color="black" size="2">Note:'Yes' in Average Speed Considered Column indicates Average speed is considered in calculation of Run hrs</font>
            
            </br>
<p></p>
<%
int cntos=0, cntra=0, cntrda=0, cntdt=0, cntst=0, cntcd=0, cntnd=0,cntndk=0,datadaystotal=0,disk=0, cntfc=0, cntdisconn=0,
cntft = 0, cntfa = 0,counter=0;
double cntrh=0.0;
double cntavg=0.00;
double cntosdur,cntavgos=0.0;
double tot_dur=0.0;
double stopdur=0, totstopdur=0, cntrating=0,cntavgra=0.0,cntavgrd=0.0,timevikram=0.0;
String str_os = "("; 
String str_os1= "("; 
String str_os2= "("; 
String str_os3= "("; 
int temp = 1;
int temp1= 1 ;
int temp2= 1;
int temp3= 1;
int nd_pri=0;
int cntndpost=0;
datadaystotal=0;
int i=1;
cntos=0;
cntra=0;
cntrda=0;
cntdt=0;
cntst=0;
cntrh=0.0;
cntcd=0;
cntnd=0;
cntfc=0;
cntosdur = 0.0;
%>
<table border="1" width="100%" class="sortable">
       <tr >
           <th>Sr.</th>
           <th>Vehicle No.</th>
           <th>Veh.Type</th>
           <th>Employee Name</th>
           <th>Employee Code</th>
           <th>Transporter</th>
           <th>Date</th>
           <th>Location </th>
           <th>Data Days</th>
           <th>OS</th>
           <th>OS Dur</th>
           <th>RA</th>
           <th>RD</th>
           <th>CD</th>
           <th>DT</th>
           <th colspan="1">Rating</th>
           					<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
           
		   <th >Avg OS Dur/100km</th>
		   <th >Avg RA/100km</th>
		   <th >Avg RD/100km</th>
		   <%} %>
		   <th>FT</th>
		   <th>FA</th>
		   <th>FC</th>
		   <th>AVG</th>
		   <th>Stops</th>
		   <th>Run Hrs.</th>
		   <th>AVG Speed</th>
		   <th>ND</th>
		   <th>ND Dur(Hrs)</th>
		   <th>ND Km</th>
		   <th>ND Int</th>
		   <th>ND Reason</th>
		   <th>DayStop <br>(Hrs)</th>
		   <th>DC</th>
		   <th>Total DC Km</th>
		  
      </tr>
<!-- Get The Data From the Database and show it -->

<%	
//System.out.println("\n\n color value-->>"+request.getParameter("fleettype"));
System.out.println("Fleet type is " +request.getParameter("fleettype"));
System.out.println("Fleet type11 is " +request.getParameter("fleettype11"));
if(request.getParameter("fleettype")!=null || "null".equals(request.getParameter("fleettype11")))
{
	
if("all".equals(request.getParameter("fleettype")) || "null".equals(request.getParameter("fleettype11")))
{
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String vehtype="-";
	String aa,tbname;
	 datadaystotal=0;
	
	while(s.hasMoreTokens())
	{
	aa=s.nextElement().toString();
	aa=aa.replace(")","");
	aa=aa.replace("(","");
	tbname="t_vehall_ds";
	//System.out.println("code-->>"+aa);
	if(!aa.equals("0"))
	{
	String sql="select * from t_vehicledetails where vehicleCode='"+aa+"'";
	System.out.println("first sql query is-->>"+sql);

	ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			vehregno=rst.getString("VehicleRegNumber");
			transporter=rst.getString("OwnerName");
			empname=rst.getString("EmpName");
			empcode=rst.getString("EmpCode");
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
			<td style="text-align: left"><%=empname %></td>
			<td align="right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
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
			<td>-</td>
			<td>-</td>
			</tr>
			<%
			i++;	
		}
		else
		{
			
			String datadays="select count(*) as count from db_gpsExceptions.t_vehall_ds where VehCode='"+aa+"' and TheDate>='"+data1+"' and TheDate <= '"+data2+"' and Location <> 'No Data'";
			System.out.println("second sql query is-->>"+datadays);

			ResultSet datadaysrs=st3.executeQuery(datadays);
			if(datadaysrs.next())
			{
				datadayscount=datadaysrs.getInt("count");
				datadaystotal=datadaystotal+datadayscount;
			}
			
		sql="select * from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
		%>
		
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><a href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
		<td style="text-align: left"><%=vehtype %></td>
		<td style="text-align: left"><%=empname %></td>
		<td align="right"><%=empcode %></td>
		<td style="text-align: left"><%=transporter %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate")) %></td>
		<td><div align="left">
		<%
		String location="-",dttime="";
		String loc=rst1.getString("Location");
		loc=rst1.getString("Location");
		 //System.out.println("loc===>"+loc);
		if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
		{
			 dttime=loc.substring(0,19);
			 location=loc.substring(19);
		}
		else{
			
			location=loc;
			dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
					
		}
		if(location.equalsIgnoreCase("No data"))
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
		String sqlcount="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";
		System.out.println("Third sql query is-->>"+sqlcount);

	      ResultSet rstcounts=stmain1.executeQuery(sqlcount);		

		//ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
		
		<td align="right">
		<div align="right">
		<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			if(temp==1)
			 {
				 str_os=aa;
				 temp++;
			 }
				 else
		    str_os=str_os+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=os%> </a> 
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
		osduration=rstcounts.getDouble(12);
		System.out.println(" OS Duration--->"+osduration);	
		
		cntosdur= cntosdur + osduration;
		%>
					<td align="right">
					<div align="right"><%=osduration%></div></td>
		
		<td align="right">
		<div align="right">
		<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{
			
			if(temp1==1)
			 {
				 str_os1=aa;
				 temp1++;
			 }
				 else
		    str_os1=str_os1+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=ra%> </a> 
			<%
		}
		else
		{
			out.print(ra);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			if(temp2==1)
			 {
				 str_os2=aa;
				 temp2++;
			 }
				 else
		    str_os2=str_os2+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=rd%> </a> 
			<%
		}
		else
		{
			out.print(rd);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=cd%> </a> 
			<%
		}
		else
		{
			out.print(cd);
		}
		
		%>
		</div>
		</td>
		<td align="right">
		<div align="right">
		<%
		int dt=rstcounts.getInt(5);
		cntdt+=dt;
		out.print(dt);
		%>
		</div>
		</td>
		<td align="right">
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
					<td align="right">
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
					
					<td align="right">
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
					<td align="right">
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
		
		
		<%} %>
		
		
		
		
		<td align="right">
					<div align="right">
					<%
		int ft=0;
					ft=rstcounts.getInt(13);
					if(ft==0)
					{
						ft=0;
					}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>		
					<td align="right">
					<div align="right">
					<%
		int fa=0;
					fa=rstcounts.getInt(14);
					
					if(fa==0)
					{
						fa=0;
					}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
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
					<td align="right">
					<div align="right">
					<%
				
					int fcval=rstcounts.getInt(15);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td align="right">
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
					<td align="right">
					<div align="right">-</div>
					</td>
					<td align="right">
					<div align="right">-</div>
					</td>
					<%
		}
		%>	
		<td align="right">
		<div align="right">
			<%
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			if(temp3==1)
			 {
				 str_os3=aa;
				 temp3++;
			 }
				 else
		    str_os3=str_os3+","+aa;
			
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=stsp%> </a> 
			<%
		}
		else
		{
			out.print(stsp);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
					<div align="right">
					<%
					NumberFormat nf = DecimalFormat.getNumberInstance();
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);	
					nf.setGroupingUsed(false);
					double d=0.0;
					d=rstcounts.getDouble(11);
					
						String runhrs =  nf.format(d);
						cntrh+= d;
						out.print(runhrs);
		%>
					</div>
					</td>
					<td align="left">
					<div align="left">
					<%
		 
		try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
						System.out.println("avgspeed==>"+avgspeed);
						ResultSet rstavg=st3.executeQuery(avgspeed);
						if(rstavg.next())
						{
							out.print("Yes");
						}
							else{
								System.out.println("in NO");
								out.print("No");
							}
												}catch(Exception ea){
							System.out.println("Avg speed exception"+ea);
						}
					
		%>
					</div>
					</td>
					
					
					
					
					
					<td style="text-align: right;">
					<%
					String time1 ="00:00:00";
					String time2="23:59:59";
					
					
			int cntnd11=0;//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
			
			if(rstcounts.getInt(17)>0)
			{
				cntnd11=rstcounts.getInt(17);
			}
			
			if(cntnd11>0)
		{
			cntnd+=cntnd11;
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=cntnd11%> </a> <%
		}
		else
		{
			out.print(0);
		}
		%>
					</td>
					
					
			
			
			
					
					<td style="text-align: right;">
					<%
	
					
		/////////////////////////////////////////////////// Night Duration Hr reaming ///////////////////////////////////////////////////////////////////////////////////			
					
					//double Time=0.0;
					double d11=0.0;
					d11=rstcounts.getDouble(24);
					
						String ndhr =  nf.format(d11);
						timevikram+= d11;
						out.print(ndhr);
					%>
					</td>
					
		<% 	
		
////////////////////////////////////////////////////////////////////////////// Stop ///////////////////////////////////////////
		
		
		
		
		
		
		int cntnd12=rstcounts.getInt(20);
		%>
		<td style="text-align: right;">
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
					<td style="text-align: right;">
					<%
					
					int count=0;
					count=rstcounts.getInt(21);
					nd_pri=nd_pri+count;
					
					%>
					<%=count %>
					</td>
				 <td>
                                <div align="right">
                                <% 
                            	if(rstcounts.getInt(22)>0)
                            	{
                            		%><%=rstcounts.getInt(22)%> 
<%
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rstcounts.getInt(22);
                               
                                
                                %>
                         </div>
                                </td>
				
					
					<td align="right">
					<div align="right">
					<%
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
					System.out.println("Fifth query is " +sqlstop);
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
		
		//String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		//ResultSet rstdisconn=st5.executeQuery(sqldisconn);
		%>
		<td align="right">
					<div align="right">
		<%
		if(rstcounts.getInt(23)>0)
		{
			%>
			
						<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=rstcounts.getInt(23)%> </a> 
			
			<%
		}
		cntdisconn=cntdisconn+rstcounts.getInt(23);
		%>
		</div></td>
		<%

		// count total km of diss
		String sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		System.out.println("sixth query is " +sqldisconn);

		ResultSet rstdis=st5.executeQuery(sqldisconn);
		int diskm=0;
		while(rstdis.next())
		{
		  diskm=diskm+rstdis.getInt("Distance");
		}
		%>
		<td align="right">
					<div align="right">
		<%
		
		if(diskm>0)
		{
			disk+=diskm;
			%>
		<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">	<%=diskm %></a>
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
		}
		}
		else
		{
			%>
			<tr>
			<td style="text-align: right"><%=i %></td>
			<td style="text-align: left"><%=vehregno %></td>
			<td style="text-align: left"><%=vehtype %></td>
		
			<td style="text-align: left"><%=empname %></td>
			<td align="right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: right"><%=datadayscount%></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right" ><div align="right">0</div></td>
			<td align="right" ><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%} %>
			<td align="right"><div align="right">0</div></td>
			<td style="text-align: left">No</td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="left"><div align="left">No</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">00.00</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			</tr>
			<%
			i++;
		}
	}
		
		
		
		
	}
	}
}

else if("zerokm".equals(request.getParameter("fleettype")))
{
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname,vehtype="-";
	//int i=1;
	 datadaystotal=0;
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
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">Blocked</td>
			<td style="text-align: left">Access denied for <%=transporter%></td>
			<td style="text-align: right"><%=datadayscount %></td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%} %>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			</tr>
			<%
			i++;	
		}
		else
		{
			
			String sqlcount="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";
			System.out.println("seventh query is " +sqlcount);

		      ResultSet rstcounts1=stmain1.executeQuery(sqlcount);
				
			//ResultSet rstcounts1=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
			if(rstcounts1.next())
			{
			
			int dt1=rstcounts1.getInt(5);
			
			if(dt1==0)
			{
			
				String datadays="select count(*) as count from db_gpsExceptions.t_vehall_ds where VehCode='"+aa+"' and TheDate>='"+data1+"' and TheDate <= '"+data2+"' and Location <> 'No Data'";
				ResultSet datadaysrs=st3.executeQuery(datadays);
				if(datadaysrs.next())
				{
					datadayscount=datadaysrs.getInt("count");
					datadaystotal=datadaystotal+datadayscount;
				}
			
			
		sql="select * from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
		%>
		
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><a href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
		<td style="text-align: left"><%=vehtype %></td>
		<td style="text-align: left"><%=empname %></td>
		<td style="text-align: right"><%=empcode %></td>
		<td style="text-align: left"><%=transporter %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate")) %></td>
		<td><div align="left">
		<%
		String location="-",dttime="";
		String loc=rst1.getString("Location");
		loc=rst1.getString("Location");
		 //System.out.println("loc===>"+loc);
		if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
		{
			 dttime=loc.substring(0,19);
			 location=loc.substring(19);
		}
		else{
			
			location=loc;
			dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
			
		}
		if(location.equalsIgnoreCase("No data"))
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
		String sqlcount1="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";

	      ResultSet rstcounts=stmain1.executeQuery(sqlcount1);	
		//ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
		
		<td align="right">
		<div align="right">
		<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			if(temp==1)
			 {
				 str_os=aa;
				 temp++;
			 }
				 else
		    str_os=str_os+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=os%> </a> 
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
		osduration=rstcounts.getDouble(12);
		System.out.println(" OS Duration--->"+osduration);	
		cntosdur= cntosdur + osduration;
		%>
					<td align="right">
					<div align="right"><%=osduration%></div></td>
		
		<td align="right">
		<div align="right">
		<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{
			
			if(temp1==1)
			 {
				 str_os1=aa;
				 temp1++;
			 }
				 else
		    str_os1=str_os1+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=ra%> </a> 
			<%
		}
		else
		{
			out.print(ra);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			if(temp2==1)
			 {
				 str_os2=aa;
				 temp2++;
			 }
				 else
		    str_os2=str_os2+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=rd%> </a> 
			<%
		}
		else
		{
			out.print(rd);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=cd%> </a> 
			<%
		}
		else
		{
			out.print(cd);
		}
		
		%>
		</div>
		</td>
		<td align="right">
		<div align="right">
		<%
		int dt=rstcounts.getInt(5);
		cntdt+=dt;
		out.print(dt);
		%>
		</div>
		</td>
		
		<td align="right">
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
								<td  align="right">
					<div align="right">
					<%
			System.out.println("IN OS Avg");
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			
				if(osduration> 0.0 && dt >0.0)
				{
					System.out.println("distance --->"+dt);
					osavg=(osduration*10)/dt;
					System.out.println("OS avg--->"+osavg);
					out.print(nfos.format(osavg));
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
					
					<td align="right">
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
					<td align="right">
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
		<%} %>
			<td align="right">
					<div align="right">
					<%
		int ft=0;
					ft=rstcounts.getInt(13);
					if(ft==0)
					{
						ft=0;
					}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>		
					<td align="right">
					<div align="right">
					<%
		int fa=0;
					fa=rstcounts.getInt(14);
					
					if(fa==0)
					{
						fa=0;
					}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
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
					<td align="right">
					<div align="right">
					<%
				
				int fcval=fleetview.getFuelConsumptionForDateRange(aa,data1,data2);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td align="right">
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
					<td align="right">
					<div align="right">-</div>
					</td>
					<td align="right">
					<div align="right">-</div>
					</td>
					<%
		}
		%>	
		<td align="right">
		<div align="right">
			<%
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			if(temp3==1)
			 {
				 str_os3=aa;
				 temp3++;
			 }
				 else
		    str_os3=str_os3+","+aa;
			
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=stsp%> </a> 
			<%
		}
		else
		{
			out.print(stsp);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
					<div align="right">
					<%
					NumberFormat nf = DecimalFormat.getNumberInstance();
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);	
					nf.setGroupingUsed(false);
					double d=0.0;
					d=rstcounts.getDouble(11);
					
						String runhrs =  nf.format(d);
						cntrh+= d;
						out.print(runhrs);
		%>
					</div>
					</td>
					<td align="left">
					<div align="left">
					<%
		 
		try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
						System.out.println("avgspeed==>"+avgspeed);
						ResultSet rstavg=st3.executeQuery(avgspeed);
						if(rstavg.next())
						{
								out.print("Yes");
						}
							else{
								System.out.println("in NO");
								out.print("No");
							}
						
						}catch(Exception ea){
							System.out.println("Avg speed exception"+ea);
						}
						
		%>
					</div>
					</td>
					
					
					
					
					
					
					
					
				<td style="text-align: right;">
					<%
					String time1 ="00:00:00";
					String time2="23:59:59";
					
					
			int cntnd11=0;//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
			
			if(rstcounts.getInt(17)>0)
			{
				cntnd11=rstcounts.getInt(17);
			}
			
			if(cntnd11>0)
		{
			cntnd+=cntnd11;
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=cntnd11%> </a> <%
		}
		else
		{
			out.print(0);
		}
		%>
					</td>
					
					
					
					
					
					
					
					
					<td style="text-align: right;">
					<%
	
					
		/////////////////////////////////////////////////// Night Duration Hr reaming ///////////////////////////////////////////////////////////////////////////////////			
					
					//double Time=0.0;
					double d11=0.0;
					d11=rstcounts.getDouble(24);
					
						String ndhr =  nf.format(d11);
						timevikram+= d11;
						out.print(ndhr);
					%>
					</td>
					
		<% 			
		int cntnd12=rstcounts.getInt(20);
		%>
		<td style="text-align: right;">
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
					<td style="text-align: right;">
					<%
					
					int count=0;
					count=rstcounts.getInt(21);
					nd_pri=nd_pri+count;
					
					%>
					<%=count %>
					</td>
				 <td align="right">
                                <div align="right">
                                <% 
                            	if(rstcounts.getInt(22)>0)
                            	{
                            		%><%=rstcounts.getInt(22)%> 
<%
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rstcounts.getInt(22);
                               
                                
                                %>
                         </div>
                                </td>
				
				
					
					<td align="right">
					<div align="right">
					<%
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
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
				
				//String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
				//ResultSet rstdisconn=st5.executeQuery(sqldisconn);
				%>
				<td align="right">
							<div align="right">
				<%
				if(rstcounts.getInt(23)>0)
				{
					%>
					
								<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=rstcounts.getInt(23)%> </a> 
					
					<%
				}
				cntdisconn=cntdisconn+rstcounts.getInt(23);
				%>
				</div></td>
				<%

				// count total km of diss
				String sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
				
				ResultSet rstdis=st5.executeQuery(sqldisconn);
				int diskm=0;
				while(rstdis.next())
				{
				  diskm=diskm+rstdis.getInt("Distance");
				}
				%>
				<td align="right">
							<div align="right">
				<%
				
				if(diskm>0)
				{
					disk+=diskm;
					%>
				<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">	<%=diskm %></a>
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
				
				
				}
        catch(Exception e)
        {
        	System.out.println(">>>>>>>>>>>>>>>>>>>>Exception:"+e);
        }
        i++;
		}
		}
		else
		{
			%>
		
	
			
			
			
			
			
			<tr>
			<td style="text-align: right"><%=i %></td>
			<td style="text-align: left"><%=vehregno %></td>
			<td style="text-align: left"><%=vehtype %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: left">No DATA</td>
			
			<td style="text-align: right"><%=datadayscount %></td>
			<td align="right">0</td>
			<td align="right">0</td>
			<td align="right">0</td>
			<td align="right">0</td>
			<td align="right">0</td>
			<td align="right">0</td>
			<td align="right">0</td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right">0</td>
			<td align="right">0</td>
			<td align="right">0</td>
			<%} %>
			<td align="right"><div align="right">0</div></td>
			<td style="text-align: left">No</td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="left"><div align="left">No</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">00.00</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			</tr>
			
			
			
			
			
			
			<%
			i++;
		}
			}
	}
		}
	}
	}



}
else if("zerogps".equals(request.getParameter("fleettype")))
{
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname,vehtype="-";
	//int i=1;
	 datadaystotal=0;
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
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">Blocked</td>
			<td style="text-align: left">Access denied for <%=transporter%></td>
			<td style="text-align: right"><%=datadayscount%></td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%} %>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			</tr>
			<%
			i++;	
		}
		else
		{
			
		
			//ResultSet rstcounts1=
				//fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
			String sqlcount="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";

	      ResultSet rstcounts1=stmain1.executeQuery(sqlcount);
			if(rstcounts1.next())
			{
				int os1=rstcounts1.getInt(1);
				int ra1=rstcounts1.getInt(2);
				int rd1=rstcounts1.getInt(3);
				int cd1=rstcounts1.getInt(4);
				int dt1=rstcounts1.getInt(5);
				
				
				System.out.println("\n\n in else");
				String nd1="";
				String ND="No";

				String sqlndck="select count(*) as cnt from t_vehall_ds where VehCode='"+aa+"' and  TheDate>='"+data1+"' and TheDate <='"+data2+"' and ND='Yes'";
				ResultSet rstck=stndck.executeQuery(sqlndck);
				if(rstck.next())
				{
					if(rstck.getInt("cnt")>0)
					{
						ND="Yes";
					}
				}
				
				if(ND.equals("Yes") )
				{
					nd1="Yes";
					System.out.println("\n\n yes");
				}
				else
				{
					nd1="No";
					System.out.println("\n\n No");
				}
				
				
				
				if(os1==0 && ra1==0 && rd1==0 && cd1==0 && nd1.equals("No") && dt1>0)
				{
			
					String datadays="select count(*) as count from db_gpsExceptions.t_vehall_ds where VehCode='"+aa+"' and TheDate>='"+data1+"' and TheDate <= '"+data2+"' and Location <> 'No Data'";
					ResultSet datadaysrs=st3.executeQuery(datadays);
					if(datadaysrs.next())
					{
						datadayscount=datadaysrs.getInt("count");
						datadaystotal=datadaystotal+datadayscount;
					}
					
			
		sql="select * from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		System.out.println("\n\n sqlll-->>"+sql);
		
		ResultSet rst9=st2.executeQuery(sql);
		if(rst9.next())
		{
			System.out.println("\n\n hi");
		%>
		
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><a href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
		<td style="text-align: left"><%=vehtype %></td>
		<td style="text-align: left"><%=empname %></td>
		<td style="text-align: right"><%=empcode %></td>
		<td style="text-align: left"><%=transporter %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst9.getDate("TheDate")) %></td>
		<td align="left"><div align="left">
		<%
		String location="-",dttime="";
		String loc=rst9.getString("Location");
		loc=rst9.getString("Location");
		 //System.out.println("loc===>"+loc);
		if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
		{
			 dttime=loc.substring(0,19);
			 location=loc.substring(19);
		}
		else{
			
			location=loc;
			dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
			
		}
		if(location.equalsIgnoreCase("No data"))
		{
			out.print(location);
		}
		else
		{
			out.print(fleetview.ShowOnMapOnlyByLocation(location,aa,rst9.getString("TheDate")));
		}
		%>
		</div>
		</td>
		<td style="text-align: right"><%=datadayscount%></td>
		<%
		String sqlcount12="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";

	      ResultSet rstcounts=stmain2.executeQuery(sqlcount12);		

		//ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
		
		<td align="right">
		<div align="right">
		<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			if(temp==1)
			 {
				 str_os=aa;
				 temp++;
			 }
				 else
		    str_os=str_os+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=os%> </a> 
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
		osduration=rstcounts.getDouble(12);
		System.out.println(" OS Duration--->"+osduration);	
		
		cntosdur= cntosdur + osduration;
		%>
					<td align="right">
					<div align="right"><%=osduration%></div></td>
		
		<td align="right">
		<div align="right">
		<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{
			
			if(temp1==1)
			 {
				 str_os1=aa;
				 temp1++;
			 }
				 else
		    str_os1=str_os1+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=ra%> </a> 
			<%
		}
		else
		{
			out.print(ra);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			if(temp2==1)
			 {
				 str_os2=aa;
				 temp2++;
			 }
				 else
		    str_os2=str_os2+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=rd%> </a> 
			<%
		}
		else
		{
			out.print(rd);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=cd%> </a> 
			<%
		}
		else
		{
			out.print(cd);
		}
		
		%>
		</div>
		</td>
		<td align="right">
		<div align="right">
		<%
		int dt=rstcounts.getInt(5);
		cntdt+=dt;
		out.print(dt);
		%>
		</div>
		</td>
		
 <td align="right">
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
								<td align="right">
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
					
					<td align="right">
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
					<td align="right">
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
		
		<%} %>
		
		
		
		
		
		
		
		<td align="right">
					<div align="right">
					<%
		int ft=0;
					ft=rstcounts.getInt(13);
					if(ft==0)
					{
						ft=0;
					}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>		
					<td align="right">
					<div align="right">
					<%
		int fa=0;
					fa=rstcounts.getInt(14);
					
					if(fa==0)
					{
						fa=0;
					}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
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
					<td align="right">
					<div align="right">
					<%
				
					int fcval=rstcounts.getInt(15);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td align="right">
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
					<td align="right">
					<div align="right">-</div>
					</td>
					<td align="right">
					<div align="right">-</div>
					</td>
					<%
		}
		%>	
		<td align="right">
		<div align="right">
			<%
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			if(temp3==1)
			 {
				 str_os3=aa;
				 temp3++;
			 }
				 else
		    str_os3=str_os3+","+aa;
			
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=stsp%> </a> 
			<%
		}
		else
		{
			out.print(stsp);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
					<div align="right">
					<%
					NumberFormat nf = DecimalFormat.getNumberInstance();
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);	
					nf.setGroupingUsed(false);
					double d=0.0;
					d=rstcounts.getDouble(11);
					
						String runhrs =  nf.format(d);
						cntrh+= d;
						out.print(runhrs);
		%>
					</div>
					</td>
					<td align="left">
					<div align="left">
					<%
		 
		try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
						System.out.println("avgspeed==>"+avgspeed);
						ResultSet rstavg=st3.executeQuery(avgspeed);
						if(rstavg.next())
						{
							out.print("Yes");
						}
							else{
								System.out.println("in NO");
								out.print("No");
							}
					
						}catch(Exception ea){
							System.out.println("Avg speed exception"+ea);
						}
						
		%>
					</div>
					
					
					
					
					
					</td>
					<td style="text-align: right;">
					<%
					String time1 ="00:00:00";
					String time2="23:59:59";
					int cntnd11=0;//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
					
					if(rstcounts.getInt(17)>0)
					{
						cntnd11=rstcounts.getInt(17);
					}
					
					if(cntnd11>0)
				{
					cntnd+=cntnd11;
					%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
							<%=cntnd11%> </a> <%
				}
				else
				{
					out.print(0);
				}
				%>
					</td>
					
					
					
					
					
					<td style="text-align: right;">
					<%
	
					
		/////////////////////////////////////////////////// Night Duration Hr reaming ///////////////////////////////////////////////////////////////////////////////////			
					
					//double Time=0.0;
					double d11=0.0;
					d11=rstcounts.getDouble(24);
					
						String ndhr =  nf.format(d11);
						timevikram+= d11;
						out.print(ndhr);
					%>
					</td>
				<% 
		int cntnd12=rstcounts.getInt(20);
				%>	
		<td style="text-align: right;">
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
					<td style="text-align: right;">
					<%
					
					int count=0;
					count=rstcounts.getInt(21);
					nd_pri=nd_pri+count;
					
					%>
					<%=count %>
					</td>
				 <td align="right">
                                <div align="right">
                                <% 
                            	if(rstcounts.getInt(22)>0)
                            	{
                            		%><%=rstcounts.getInt(22)%> 
<%
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rstcounts.getInt(22);
                               
                                
                                %>
                         </div>
                                </td>
					
					<td align="right">
					<div align="right">
					<%
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
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
		
				//String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
				//ResultSet rstdisconn=st5.executeQuery(sqldisconn);
				%>
				<td align="right">
							<div align="right">
				<%
				if(rstcounts.getInt(23)>0)
				{
					%>
					
								<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=rstcounts.getInt(23)%> </a> 
					
					<%
				}
				cntdisconn=cntdisconn+rstcounts.getInt(23);
				%>
				</div></td>
		<%

		// count total km of diss
		String sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		
		ResultSet rstdis=st5.executeQuery(sqldisconn);
		int diskm=0;
		while(rstdis.next())
		{
		  diskm=diskm+rstdis.getInt("Distance");
		}
		%>
		<td align="right">
					<div align="right">
		<%
		
		if(diskm>0)
		{
			disk+=diskm;
			%>
		<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">	<%=diskm %></a>
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
			}
            catch(Exception e)
            {
	            System.out.println(">>>>>>>>>>>>>>>>>>>>Exception:"+e);
            }		
		%>	
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
			<td style="text-align: left"><%=vehtype %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: right"><%=datadayscount%></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%} %>
			<td align="right"><div align="right">0</div></td>
			<td style="text-align: left">No</td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="left"><div align="left">No</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">00.00</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			</tr>
			<%
			i++;
		}
			}
	}
		}
	}
	}



}
else if("morethan5".equals(request.getParameter("fleettype")))
{
	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname,vehtype="-";
	//int i=1;
	 datadaystotal=0;
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
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">Blocked</td>
			<td style="text-align: left">Access denied for <%=transporter%></td>
			<td style="text-align: right"><%=datadayscount%></td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%} %>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			</tr>
			<%
			i++;	
		}
		else
		{
			
			String sqlcount3="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";

		      ResultSet rstcounts1=stmain3.executeQuery(sqlcount3);
			
			
			//ResultSet rstcounts1=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
			if(rstcounts1.next())
			{
				int os1=rstcounts1.getInt(1);
				int ra1=rstcounts1.getInt(2);
				int rd1=rstcounts1.getInt(3);
				int cd1=rstcounts1.getInt(4);
				int violationcount=0;
				violationcount=os1+ra1+rd1+cd1;
				
				System.out.println("\n\n in else");
				String nd="";
				
				
				
				if(fleetview.isNightDrivingFormExceptionsForDateRange(aa,data1,data2).equals("Yes"))
				{
					violationcount++;
				
					nd="Yes";
					System.out.println("\n\n yes");
				}
				
				
				
				
				if(violationcount>5)
				{
					String datadays="select count(*) as count from db_gpsExceptionst_vehall_ds where VehCode='"+aa+"' and  TheDate>='"+data1+"' and TheDate <= '"+data2+"' and Location <> 'No Data'";
					ResultSet datadaysrs=st3.executeQuery(datadays);
					if(datadaysrs.next())
					{
						datadayscount=datadaysrs.getInt("count");
						datadaystotal=datadaystotal+datadayscount;
					}
			
			
		sql="select * from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
		%>
		
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><a href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
		<td style="text-align: left"><%=vehtype %></td>
		<td style="text-align: left"><%=empname %></td>
		<td style="text-align: right"><%=empcode %></td>
		<td style="text-align: left"><%=transporter %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate")) %></td>
		<td align="left"><div align="left">
		<%
		String location="-",dttime="";
		String loc=rst1.getString("Location");
		loc=rst1.getString("Location");
		 //System.out.println("loc===>"+loc);
		if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
		{
			 dttime=loc.substring(0,19);
			 location=loc.substring(19);
		}
		else{
			
			location=loc;
			dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
			
		}
		if(location.equalsIgnoreCase("No data"))
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
		
		String sqlcount11="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";

	      ResultSet rstcounts=stmain1.executeQuery(sqlcount11);
		
		
		
		//ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
		
		<td align="right">
		<div align="right">
		<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			if(temp==1)
			 {
				 str_os=aa;
				 temp++;
			 }
				 else
		    str_os=str_os+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=os%> </a> 
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
		osduration=rstcounts.getDouble(12);
		System.out.println(" OS Duration--->"+osduration);	
		
		cntosdur= cntosdur + osduration;
		%>
					<td align="right">
					<div align="right"><%=osduration%></div></td>
		<td align="right">
		<div align="right">
		<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{
			
			if(temp1==1)
			 {
				 str_os1=aa;
				 temp1++;
			 }
				 else
		    str_os1=str_os1+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=ra%> </a> 
			<%
		}
		else
		{
			out.print(ra);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			if(temp2==1)
			 {
				 str_os2=aa;
				 temp2++;
			 }
				 else
		    str_os2=str_os2+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=rd%> </a> 
			<%
		}
		else
		{
			out.print(rd);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=cd%> </a> 
			<%
		}
		else
		{
			out.print(cd);
		}
		
		%>
		</div>
		</td>
		<td align="right">
		<div align="right">
		<%
		int dt=rstcounts.getInt(5);
		cntdt+=dt;
		out.print(dt);
		%>
		</div>
		</td>
		
        <td align="right">
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
								<td align="right">
					<div align="right">
					<%
			System.out.println("IN OS Avg");
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			
				if(osduration> 0.0 && dt >0.0)
				{
					System.out.println("distance --->"+dt);
					osavg=(osduration*10)/dt;
					System.out.println("OS avg--->"+osavg);
					out.print(nfos.format(osavg));
					
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
					
					<td align="right">
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
					<td align="right">
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
		<%} %>
		<td align="right">
					<div align="right">
					<%
		int ft=0;
					ft=rstcounts.getInt(13);
					if(ft==0)
					{
						ft=0;
					}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>		
					<td align="right">
					<div align="right">
					<%
		int fa=0;
					fa=rstcounts.getInt(14);
					
					if(fa==0)
					{
						fa=0;
					}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
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
					<td align="right">
					<div align="right">
					<%
				
				int fcval=rstcounts.getInt(15);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td align="right">
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
					<td align="right">
					<div align="right">-</div>
					</td >
					<td align="right">
					<div align="right">-</div>
					</td>
					<%
		}
		%>	
		<td align="right">
		<div align="right">
			<%
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			if(temp3==1)
			 {
				 str_os3=aa;
				 temp3++;
			 }
				 else
		    str_os3=str_os3+","+aa;
			
			
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
		
		<td align="right">
					<div align="right">
					<%
					NumberFormat nf = DecimalFormat.getNumberInstance();
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);	
					nf.setGroupingUsed(false);
					double d=0.0;
					d=rstcounts.getDouble(11);
					
						String runhrs =  nf.format(d);
						cntrh+= d;
						out.print(runhrs);
		%>
					</div>
					</td>
					<td align="left">
					<div align="left">
					<%
		 
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
						
						}catch(Exception ea){
							System.out.println("Avg speed exception"+ea);
						}
						
		%>
					</div>
					</td>
					<td style="text-align: right;">
					<%
					String time1 ="00:00:00";
					String time2="23:59:59";
					int cntnd11=0;//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
					
					if(rstcounts.getInt(17)>0)
					{
						cntnd11=rstcounts.getInt(17);
					}
					
					if(cntnd11>0)
				{
					cntnd+=cntnd11;
					%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
							<%=cntnd11%> </a> <%
				}
				else
				{
					out.print(0);
				}
				%>
							</td>
					<td style="text-align: right;">
					<%
	
					
		/////////////////////////////////////////////////// Night Duration Hr reaming ///////////////////////////////////////////////////////////////////////////////////			
					
					//double Time=0.0;
					double d11=0.0;
					d11=rstcounts.getDouble(24);
					
						String ndhr =  nf.format(d11);
						timevikram+= d11;
						out.print(ndhr);
					%>
					</td>
				
				
				
					
		<% 			

		int cntnd12=rstcounts.getInt(20);
		%>
		<td style="text-align: right;">
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
					<td style="text-align: right;">
					<%
					
					int count=0;
					count=rstcounts.getInt(21);
					nd_pri=nd_pri+count;
					
					%>
					<%=count %>
					</td>
				 <td align="right">
                                <div align="right">
                                <% 
                            	if(rstcounts.getInt(22)>0)
                            	{
                            		%><%=rstcounts.getInt(22)%> 
<%
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rstcounts.getInt(22);
                               
                                
                                %>
                         </div>
                                </td>
				
					
				
					
					<td align="right">
					<div align="right">
					<%
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
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
		
				//String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
				//ResultSet rstdisconn=st5.executeQuery(sqldisconn);
				%>
				<td align="right">
							<div align="right">
				<%
				if(rstcounts.getInt(23)>0)
				{
					%>
					
								<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=rstcounts.getInt(23)%> </a> 
					
					<%
				}
				cntdisconn=cntdisconn+rstcounts.getInt(23);
				%>
				</div></td>
		<%

		// count total km of diss
		String sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		
		ResultSet rstdis=st5.executeQuery(sqldisconn);
		int diskm=0;
		while(rstdis.next())
		{
		  diskm=diskm+rstdis.getInt("Distance");
		}
		%>
		<td align="right">
					<div align="right">
		<%
		
		if(diskm>0)
		{
			disk+=diskm;
			%>
		<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">	<%=diskm %></a>
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
			}
            catch(Exception e)
            {
	            System.out.println(">>>>>>>>>>>>>>>>>>>>Exception:"+e);
            }		
		%>	
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
			<td style="text-align: left"><%=vehtype %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: right"><%=datadayscount%></td>
			
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%} %>
			<td align="right"><div align="right">0</div></td>
			<td style="text-align: left">No</td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="left"><div align="left">No</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">00.00</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			</tr>
			<%
			i++;
		}
				}
		}
			}
	}
	}



}
}
else
{

	String ss=session.getAttribute("VehList").toString();
	StringTokenizer s= new StringTokenizer(ss,",");
	String aa,tbname,vehtype="-";
	//int i=1;
	 datadaystotal=0;
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
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">Blocked</td>
			<td style="text-align: left">Access denied for <%=transporter%></td>
			<td style="text-align: right"><%=datadayscount%></td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<%} %>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="left">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			<td align="right">-</td>
			</tr>
			<%
			i++;	
		}
		else
		{
			String datadays="select count(*) as count from db_gpsExceptions.t_vehall_ds where VehCode='"+aa+"' and TheDate>='"+data1+"' and TheDate <= '"+data2+"' and Location <> 'No Data'";
			ResultSet datadaysrs=st3.executeQuery(datadays);
			if(datadaysrs.next())
			{
				datadayscount=datadaysrs.getInt("count");
				datadaystotal=datadaystotal+datadayscount;
			}
		sql="select * from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
		%>
		
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><a href="customreport.jsp?vid=<%=aa%>&vehno=<%=vehregno%>"><%=vehregno %></a></td>
		<td style="text-align: left"><%=vehtype %></td>
		<td style="text-align: left"><%=empname %></td>
		<td style="text-align: right"><%=empcode %></td>
		<td style="text-align: left"><%=transporter %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate")) %></td>
		<td align="left"><div align="left">
		<%
		String location="-",dttime="";
		String loc=rst1.getString("Location");
		loc=rst1.getString("Location");
		 //System.out.println("loc===>"+loc);
		if(!loc.equalsIgnoreCase("No data") && !("-").equals(loc))
		{
			 dttime=loc.substring(0,19);
			 location=loc.substring(19);
		}
		else{
			
			location=loc;
			dttime=formatter.format(new SimpleDateFormat("yyyy-MM-dd").parse(data2));
			
		}
		if(location.equalsIgnoreCase("No data"))
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
		String sqlcount12="select SUM(OSCount),SUM(RACount),SUM(RDCount),SUM(CRCount),SUM(Distance),SUM(StopCount), SUM(RDuration), SUM(FACount),SUM(FTCount),SUM(RDinSec),SUM(RDurationinHrs),sum(Osduration),sum(FTCount),sum(FACount),sum(FC),AVG(FAVG) as FAVG,sum(NDCount),Sec_To_Time(SUM(Time_To_Sec(NDDurationinHrs))),SUM(Time_To_Sec(NDDurationinHrs)),sum(NDKm),sum(NDIntimation),sum(NDReason),sum(DCCount),sum(NDDurationinHrs) from t_vehall_ds where VehCode='"+aa+"' and TheDate >='"+data1+"' AND TheDate <='"+data2+"'";

	      ResultSet rstcounts=stmain4.executeQuery(sqlcount12);		

		
		
		//ResultSet rstcounts=fleetview.GetOS_RA_RD_CR_DT_ST_DURATION_CountFromExceptionDBForDateRange(aa,data1,data2);
		if(rstcounts.next())
		{
		%>
		
		<td align="right">
		<div align="right">
		<%
		int os=rstcounts.getInt(1);
		cntos+=os;
		if(os >0)
		{
			if(temp==1)
			 {
				 str_os=aa;
				 temp++;
			 }
				 else
		    str_os=str_os+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=os%> </a> 
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
		osduration=rstcounts.getDouble(12);
		System.out.println(" OS Duration--->"+osduration);	
		
		cntosdur= cntosdur + osduration;
		%>
					<td align="right">
					<div align="right"><%=osduration%></div></td>
		           <td align="right">
		           <div align="right">
		<%
		int ra=rstcounts.getInt(2);
		cntra+=ra;
		if(ra>0)
		{
			
			if(temp1==1)
			 {
				 str_os1=aa;
				 temp1++;
			 }
				 else
		    str_os1=str_os1+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=ra%> </a> 
			<%
		}
		else
		{
			out.print(ra);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int rd=rstcounts.getInt(3);
		cntrda+=rd;
		if(rd>0)
		{
			if(temp2==1)
			 {
				 str_os2=aa;
				 temp2++;
			 }
				 else
		    str_os2=str_os2+","+aa; 
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=rd%> </a> 
			<%
		}
		else
		{
			out.print(rd);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
		<div align="right">
		<%
		int cd=rstcounts.getInt(4);
		cntcd+=cd;
		if(cd>0)
		{
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=cd%> </a> 
			<%
		}
		else
		{
			out.print(cd);
		}
		
		%>
		</div>
		</td>
		<td align="right">
		<div align="right">
		<%
		int dt=rstcounts.getInt(5);
		cntdt+=dt;
		out.print(dt);
		%>
		</div>
		</td>
		
				<td align="right">
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
								<td align="right">
					<div align="right">
					<%
			System.out.println("IN OS Avg");
			NumberFormat nfos=NumberFormat.getInstance();
			nfos.setMaximumFractionDigits(2);
			nfos.setMinimumFractionDigits(2);
			
			
				if(osduration> 0.0 && dt >0.0)
				{
					System.out.println("distance --->"+dt);
					osavg=(osduration*10)/dt;
					System.out.println("OS avg--->"+osavg);
					out.print(nfos.format(osavg));
				}
				else{
					osavg=0.0;
					out.print(nfos.format(osavg));
				}
				cntavgos+=osavg;
			
			
			%>
					</div>
					</td>
					
					<td align="right">
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
					<td align="right">
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
			
		}
		else //if(dt==0.0 && rd>0 ||rd==0 )
		{
			rdavg= 0.0;
			out.print(nfrd.format(rdavg));
		}
		cntavgrd+=rdavg;
		%>
					</div>
					</td>
		<%} %>
		
		<td align="right">
					<div align="right">
					<%
		int ft=0;
					ft=rstcounts.getInt(13);
					if(ft==0)
					{
						ft=0;
					}
		//int ft=rstcounts.getInt(9);
		cntft+=ft;
		if(ft >0)
		{
			%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
					<%=ft%> </a> <%				
		}
		else
		{
			out.print(ft);
		}
		%>
					</div>
					</td>		
					<td align="right">
					<div align="right">
					<%
		int fa=0;
					fa=rstcounts.getInt(14);
					
					if(fa==0)
					{
						fa=0;
					}
		//int fa=rstcounts.getInt(8);
		cntfa+=fa;
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
					<td align="right">
					<div align="right">
					<%
				
				int fcval=rstcounts.getInt(15);
				cntfc=cntfc+fcval;
				out.print(fcval);
			%>
					</div>
					</td>
					<td align="right">
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
					<td align="right">
					<div align="right">-</div>
					</td>
					<td align="right">
					<div align="right">-</div>
					</td>
					<%
		}
		%>	
		<td align="right">
		<div align="right">
			<%
		int stsp=rstcounts.getInt(6);
		cntst+=stsp;
		if(stsp>0)
		{
			if(temp3==1)
			 {
				 str_os3=aa;
				 temp3++;
			 }
				 else
		    str_os3=str_os3+","+aa;
			
			
			%>
			<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"> <%=stsp%> </a> 
			<%
		}
		else
		{
			out.print(stsp);
		}
		
		%>
		</div>
		</td>
		
		<td align="right">
					<div align="right">
					<%
					NumberFormat nf = DecimalFormat.getNumberInstance();
					nf.setMaximumFractionDigits(2);
					nf.setMinimumFractionDigits(2);	
					nf.setGroupingUsed(false);
					double d=0.0;
					d=rstcounts.getDouble(11);
					
						String runhrs =  nf.format(d);
						cntrh+= d;
						out.print(runhrs);
		%>
					</div>
					</td>
					<td align="left">
					<div align="left">
					<%
		 
		try{
						
						
						String avgspeed="Select * from db_gpsExceptions.t_vehall_ds where vehcode='"+aa+"' and TheDate <='"+data2+"'  and  TheDate >='"+data1+"' and AvgSpeedConsidered='Yes' ";
						System.out.println("avgspeed==>"+avgspeed);
						ResultSet rstavg=st3.executeQuery(avgspeed);
						if(rstavg.next())
						{
							out.print("Yes");
						}
							else{
								System.out.println("in NO");
								out.print("No");
							}
						}catch(Exception ea){
							System.out.println("Avg speed exception"+ea);
						}
						
		%>
					</div>
					</td>
					<td style="text-align: right;">
					<%
					String time1 ="00:00:00";
					String time2="23:59:59";
					
					int cntnd11=0;//fleetview.NightDrivingFormExceptionsForDateRange(aa,data1,data2);
					
					if(rstcounts.getInt(17)>0)
					{
						cntnd11=rstcounts.getInt(17);
					}
					
					if(cntnd11>0)
				{
					cntnd+=cntnd11;
					%> <a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">
							<%=cntnd11%> </a> <%
				}
				else
				{
					out.print(0);
				}
				%>
							</td>
							
					
					
					<td style="text-align: right;">
					<%
	
					
		/////////////////////////////////////////////////// Night Duration Hr reaming ///////////////////////////////////////////////////////////////////////////////////			
					
					//double Time=0.0;
					double d11=0.0;
					d11=rstcounts.getDouble(24);
					
						String ndhr =  nf.format(d11);
						timevikram+= d11;
						out.print(ndhr);
					%>
					</td>
					
		<% 			
		int cntnd12=rstcounts.getInt(20);
		%>
		<td style="text-align: right;">
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
					<td style="text-align: right;">
					<%
					
					int count=0;
					count=rstcounts.getInt(21);
					nd_pri=nd_pri+count;
					
					%>
					<%=count %>
					</td>
				 <td align="right">
                                <div align="right">
                                <% 
                            	if(rstcounts.getInt(22)>0)
                            	{
                            		%><%=rstcounts.getInt(22)%> 
<%
                        }
                        else
                        {
                                out.print(0);
                        }
                        
                    cntndpost=cntndpost+rstcounts.getInt(22);
                               
                                
                                %>
                         </div>
                                </td>
					<td align="right">
					<div align="right">
					<%
		
		String sqlstop="select sum(DayStopDurationinHrs) as stopduration from db_gpsExceptions."+tbname+" where VehCode='"+aa+"' and TheDate <='"+data2+"' and TheDate >='"+data1+"' order by TheDate desc";
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
			
		
		
				//String sqldisconn="Select count(*) as cnt from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeFrom >='"+data1+" 00:00:00' and  OffTimeTo <='"+data2+" 23:59:59' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
				//ResultSet rstdisconn=st5.executeQuery(sqldisconn);
				%>
				<td align="right">
							<div align="right">
				<%
				if(rstcounts.getInt(23)>0)
				{
					%>
					
								<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>"><%=rstcounts.getInt(23)%> </a> 
					
					<%
				}
				cntdisconn=cntdisconn+rstcounts.getInt(23);
				%>
				</div></td>
		<%

		// count total km of diss
		String sqldisconn="Select Distance from db_gps.t_disconnectionData where vehicleCode='"+aa+"' and  OffTimeTo <='"+data2+" 23:59:59' and  OffTimeFrom >='"+data1+" 00:00:00' and Reason = 'Disconnection' and ignoredstamp='No' and Duration >= '0:30'";
		
		ResultSet rstdis=st5.executeQuery(sqldisconn);
		int diskm=0;
		while(rstdis.next())
		{
		  diskm=diskm+rstdis.getInt("Distance");
		}
		%>
		<td align="right">
					<div align="right">
		<%
		
		if(diskm>0)
		{
			disk+=diskm;
			%>
		<a href="CustomReportDrillDown.jsp?data=<%=data1 %>&data1=<%=data2 %>&vehcode=<%=aa%>">	<%=diskm %></a>
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
			}
            catch(Exception e)
            {
	            System.out.println(">>>>>>>>>>>>>>>>>>>>Exception:"+e);
            }		
		%>			
					
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
			<td style="text-align: left"><%=vehtype %></td>
			<td style="text-align: left"><%=empname %></td>
			<td style="text-align: right"><%=empcode %></td>
			<td style="text-align: left"><%=transporter %></td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: left">No DATA</td>
			<td style="text-align: right"><%=datadayscount%></td>
			
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<%} %>
			<td align="right"><div align="right">0</div></td>
			<td style="text-align: left">No</td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="left"><div align="left">No</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">00.00</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			<td align="right"><div align="right">0</div></td>
			</tr>
			<%
			i++;
		}
	}
	}
	}

}
	
	
	session.setAttribute("Str_os",str_os);
	session.setAttribute("Str_os1",str_os1);
	session.setAttribute("Str_os2",str_os2);
	session.setAttribute("Str_os3",str_os3);
%>

    <tr >
        <td colspan="8" class="hed"> <div align="left">Total</div></td>
         <td align="right" class="hed">
	    <div align="right"><%=datadaystotal %></div>
		</td>
        <%if(cntos>0){ %>
        <td align="right" class="hed">
        <div align="right"><a href="#" onclick="javascript:window.open('total_os.jsp?count=<%=cntos%>');"><%=cntos %></a></div>
        </td>
        <%}else {%>
        <td align="right" class="hed">
	    <div align="right"><%=cntos %></div>
		</td>
		<%} %>
		
         <td align="right" class="hed">
	    <div align="right"><%=cntosdur %></div>
		</td>
        
        <%if(cntra>0){ %>
        <td align="right" class="hed">
        <div align="right"><a href="#" onclick="javascript:window.open('total_ra.jsp?count=<%=cntra%>');"><%=cntra %></a></div>
        </td>
        <%}else {%>
					<td  align="right" class="hed">
					<div align="right"><%=cntra %></div>
					</td>
					<%} %>
					
        <%if(cntrda>0){ %>	       
        <td align="right" class="hed">
        <div align="right"><a href="#" onclick="javascript:window.open('total_rd.jsp?count=<%=cntrda%>');"><%=cntrda %></a></div>
        </td>
        <%}else {%>
					<td align="right" class="hed">
					<div align="right"><%=cntrda %></div>
					</td>
					<%} %>
					
		<%if(cntcd>0){ %>	       
        <td align="right" class="hed">
        <div align="right"><a href="#" onclick="javascript:window.open('total_cd.jsp?count=<%=cntcd%>');"><%=cntcd %></a></div>
        </td>
        <%}else {%>
					<td align="right" class="hed">
					<div align="right"><%=cntcd %></div>
					</td>
					<%} %>
					
        <td align="right" class="hed">
        <div align="right"><%=cntdt %></div>
        </td>
        
<%
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);
%>

         <td align="right" class="hed">
					<div align="right"><%=nf1.format(cntrating) %></div>
					</td>
					<%if(type=="Hide" || type.contains("Hide")||type.equals("Hide")){ %>
					<td align="right" class="hed" id="ta<%=i %>" style="display: none;">
					<div align="right"><%=nf1.format(cntavgos) %></div>
					</td>
					
					<td align="right" class="hed" id="tb<%=i %>" style="display: none;">
					<div align="right"><%=nf1.format(cntavgra) %></div>
					</td>
					
					<td align="right" class="hed" id="tc<%=i %>" style="display: none;">
					<div align="right"><%=nf1.format(cntavgrd) %></div>
					</td>
					<%}%>
					
					<td align="right" class="hed" >
					<div align="right"><%=cntft %></div>
					</td>
					
					<td align="right" class="hed" >
					<div align="right"><%=cntfa %></div>
					</td>
					
					<td align="right" class="hed" >
					<div align="right"><%=cntfc %></div>
					</td>
					
					<td align="right" class="hed" >
					<div align="right"><%=nf1.format(cntavg) %></div>
					</td>
					
					<%if(cntst>0){ %>	
					<td align="right" class="hed">									
					<div align="right"><a href="#" onclick="javascript:window.open('total_stops.jsp?count=<%=cntst%>');"><%=cntst %></a></div>
					</td>
					
					<%}else {%>
					<td align="right" class="hed">
					<div align="right"><%=cntst %></div>
					</td>
					
					<%} %>
					<td align="right" class="hed">
					<div align="right"><%=nf1.format(cntrh) %></div>
					</td>
					
					<td align="right" class="hed">
					<div align="right"><b>-</b></div>
					</td>
					
					
					<%if(cntnd>0){ %>	       
        			<td  align="right" class="hed">
       				 <div align="right"><a href="#" onclick="javascript:window.open('total_nd.jsp?count=<%=cntnd%>');"><%=cntnd %></a></div>
        			</td>
        			
        			<%}else {%>
					<td align="right" class="hed">
					<div align="right"><%=cntnd %></div>
					</td>
					
					<%} %>
					 <td align="right" class="hed">
					<div align="right"><%=nf1.format(timevikram) %></div>
					</td>
					
					<td align="right" class="hed">
					<div align="right"><%=cntndk %></div>
					</td>
					
					<td  align="right" class="hed">
					<div align="right"><%=nd_pri %></div>
					</td>
						
					<td align="right" class="hed">
					<div align="right"><%=cntndpost %></div>
					</td>	
							
					<td align="right" class="hed">
					<div align="right"><%=nf1.format(totstopdur) %></div>
					</td>
					
					<td align="right" class="hed">
					<div align="right"><%=cntdisconn%></div>
					</td>
					
					<td align="right" class="hed">
					<div align="right"><%=disk %></div>
					</td>
  </tr>
</table>

<input type="hidden" name="countermore" id="countermore" value="<%=i %>"/>
 </td></tr>
</table></div></form></td></tr>
</table>
<%
}catch(Exception e)
{
	System.out.println("Exception" +e);
}
finally
{
		conn.close();
		conn1.close();
	
}
}

%>
</jsp:useBean>
<%@ include file="footernew.jsp" %>