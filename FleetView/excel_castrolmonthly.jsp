
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"Castrol_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!

Connection conn,conn1;
Statement st,st1,sset,sset2,sset1,sset3,sset4,sset5,sset6,sset7,sset8,sset9,sset10,sset11;
String fromdate, todate,fromdate1, todate1,datenew1,datenew2;
String sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,sql9,sql10,sql11,sql12,sql13,sqlset,vsql,vsql1,vsql2;
int countTrip,bulk,primary,secondary,jcode,dgrt10,dgrt101,dgrt102,dgrt12,dgrt12_1,dgrt12_2,dgrt10_0,dgrt10_1,dgrt10_2,dgrt10_3,dgrt12_01,dgrt12_02,dgrt12_03,rviolation,sum=0,sum10,sum12;

String rduration1;
NumberFormat nf = DecimalFormat.getNumberInstance();
%>
<%
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
String thename;

fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");
thename=request.getParameter("thename");
fromdate1=new SimpleDateFormat("MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("fromdate")));
todate1=new SimpleDateFormat("yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("todate")));
datenew1=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
try
{
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
sset=conn1.createStatement();
sset1=conn1.createStatement();
sset2=conn1.createStatement();
sset3=conn1.createStatement();sset4=conn1.createStatement();sset5=conn1.createStatement();sset6=conn1.createStatement();
sset7=conn1.createStatement();sset8=conn1.createStatement();sset9=conn1.createStatement();sset10=conn1.createStatement();sset11=conn1.createStatement();


int alljd=0,nogpsjd=0,totjd=0;
int tcdb=0,fltydb=0,totdb=0;
int bcount=0,bidcount=0,tbcount=0;
int dbcount=0,dbidcount=0,tdbcount=0;
int totbrif=0,idbrif=0,rembrif=0;
int ndall=0,cdall=0;
double percent=0.0,percent1=0.0,percent11=0.0,percent111=0.0;//Rating=0.0,Rating1=0.0,Rating2=0.0,
int faultcnt=0,gpscnt=0,countdaily=0,countweekly=0;
int kt=0,ra=0,rd=0,os=0;
int kt1=0,ra1=0,rd1=0,os1=0;
int kt11=0,ra11=0,rd11=0,os11=0;
int PJDTrips=0, PCApturedTrips=0, PVehicles=0, PDrivers=0, PDistance=0, PRA=0, PRD=0, POSDuration=0, PND=0, PCD=0, PBrief=0, PDeBrief=0 ;
int TJDTrips=0, TCApturedTrips=0, TVehicles=0, TDrivers=0, TDistance=0, TRA=0, TRD=0, TOSDuration=0, TND=0, TCD=0, TBrief=0, TDeBrief=0;
int SJDTrips=0, SCApturedTrips=0, SVehicles=0, SDrivers=0, SDistance=0, SRA=0, SRD=0, SOSDuration=0, SND=0, SCD=0, SBrief=0, SDeBrief=0;
int kt2=0,ra2=0,rd2=0,os2=0;
double rartng=0.0,rdrtng=0.0,osrtng=0.0,rtng=0.0;
double rartng11=0.0,rdrtng11=0.0,osrtng11=0.0,rtng11=0.0;
double rartng2=0.0,rdrtng2=0.0,osrtng2=0.0,rtng2=0.0;
double  SRatings=0.00, PRatings=0.00,TRatings=0.00;
int c=0,count=0;
int opentot1=0,totauto1=0,manualtot1=0,k=1;
int opentot2=0,totauto2=0,manualtot2=0;
int opentot3=0,totauto3=0,manualtot3=0;
String endedby,tripendate;

%>
<table border="0" width="100%" align="center">
<tr><td align="center"><b><font size="2">
<%
if(thename.equals("started"))
{
	%>
	Castrol Monthly Report Of Started Trips For <%=datenew1%> 
	<%
}
else if(thename.equals("ended"))
{
	%>
	Castrol Monthly Report Of Ended Trips For <%=datenew1%> 
	<%
}
else
{
	%>
	Castrol Monthly Report Of Started And Ended Trips For <%=datenew1%> 
	<%
}
	
%>
</font></b>
<div align="right">
Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>
</td>
</tr>
</table>
</td>

</tr>
<tr>
<td>

<%
//datenew1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
//datenew2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
%>
 <table border="0" width="100%">

<%
if(!(null==thename))
{
	if(thename.equals("started"))
	{
		opentot1=0;totauto1=0;manualtot1=0;k=1;
		opentot2=0;totauto2=0;manualtot2=0;
		opentot3=0;totauto3=0;manualtot3=0;
%>		
		<tr>
		<td width="50%">
			<table border="1" width="100%" class="stats">
			<tr><th align="center" colspan="2"><b><font size="2">JD Data from Castrol</font></b></th></tr>
			<%
					//sql1="SELECT count(Distinct(`TripID`)) as count FROM t_alljddata WHERE StartDate between '"+fromdate+"' and '"+todate+"'";
				//	System.out.println(fromdate);
				//	System.out.println(todate);
					sql1="select sum(Tcount) as Tcount,sum(Ncount) as NGcount,sum(Fcount) as Fcount,sum(brf) as brfcount, "+
					"sum(dbrf) as dbrfcount,sum(tbcount) as tbrfcount,sum(tdbcount) as tdbrfcount,sum(ndall) as ND, "+
					"sum(cdall) as CD,sum(countdaily) as countdaily,sum(countweek) as countweek,sum(dgrt10) as dgrt10,"+
					"sum(dgrt10_0) as dgrt10_0,sum(dgrt101) as dgrt101,sum(dgrt10_1) as dgrt10_1,"+
					"sum(dgrt102) as dgrt102,sum(dgrt10_2) as dgrt10_2,sum(dgrt120) as dgrt120,sum(dgrt12_0) as dgrt12_0,"+
					"sum(dgrt121) as dgrt121,sum(dgrt12_1) as dgrt12_1,sum(dgrt122) as dgrt122,"+
					"sum(dgrt12_2) as dgrt12_2,sum(TJcode) as TJcode,sum(TEventCount) as TEventCount,sum(PAutoCount) as PAutoCount,"+
					"sum(TAutoCount) as TAutoCount,sum(SAutoCount) as SAutoCount,"+
					"sum(PMCount) as PMCount,sum(TMCount) as TMCount,sum(SMCount) as SMCount,sum(POCount) as POCount,"+
					"sum(TOCount) as TOCount,sum(SOCount) as SOCount from "+ 
					"(SELECT count(Distinct(TripID)) as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf, "+
					"0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,"+
					"0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2 ,0 as dgrt120,0 as dgrt12_0,"+
					"0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,"+
					"0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,"+
					"0 as SOCount FROM db_gps.t_alljddata WHERE StartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' "+
					"union "+ 
					"SELECT 0 as Tcount,count(Distinct(TripID)) as Ncount,0 as Fcount,0 as brf,0 as dbrf, "+
					"0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,"+
					"0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,"+
					"0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,"+
					"0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount FROM db_gps.t_alljddata WHERE "+
					"StartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status='NotProcessed' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,count(Distinct(TripID)) as Fcount,0 as brf,0 as dbrf, "+
					"0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,"+
					"0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,"+
					"0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,"+
					"0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount "+
					"from db_gps.t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Status = 'Faulty' "+ 
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,sum(Briefing) as brf,sum(Debriefing) as dbrf, "+
					"0 as tbcount,0 as tdbcount,sum(ND) as ndall,sum(CD) as cdall,0 as countdaily,0 as countweek,0 as dgrt10,"+
					"0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,"+
					"0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,"+
					"0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,"+
					"0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'"+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,count(*) as tbcount,0 as tdbcount,"+
					"0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,"+
					"0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,"+
					"0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,"+
					"0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_briefing where brifdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,count(*) as tdbcount,0 as ndall,"+
					"0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,0 as dgrt102,"+
					"0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,0 as TJcode,"+
					"0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_debriefing where Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' "+
					"union "+
					"SELECT 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,"+
					"0 as cdall,count(JCode) AS countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,"+
					"0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,"+
					"0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,"+
					"0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount FROM db_gpsExceptions.t_driver_ds WHERE "+
					"TheDate BETWEEN '"+fromdate+"' AND '"+todate+"' AND GPName = 'Castrol' AND RDurationinHrs >=12 "+ 
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,"+
					"0 as cdall,0 as countdaily,count(JCode) as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,"+
					"0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,0 as dgrt122,"+
					"0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,"+
					"0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount from  db_gpsExceptions.t_driver_ds where "+
					"TheDate  between '"+fromdate+"' AND '"+todate+"' and GPName='Castrol' AND Last7DayRDurationinHrs >= 60 "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,"+
					"0 as cdall,0 as countdaily,0 as countweek,count(distinct(JCode)) as dgrt10,count(JCode) as dgrt10_0 ,"+
					"0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,"+
					"0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,"+
					"0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount "+
					"from db_gpsExceptions.t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' "+
					"and GPName='Castrol'and Category='Tanker' and RDurationinHrs>='10' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,"+
					"0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,count(distinct(JCode)) as dgrt101,"+
					"count(JCode) as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,"+
					"0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,"+
					"0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount from "+
					"db_gpsExceptions.t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' "+
					"and GPName='Castrol'and Category='Primary' and RDurationinHrs>='10' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,"+
					"0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,"+
					"count(distinct(JCode)) as dgrt102,count(JCode) as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,"+
					"0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,"+
					"0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount "+
					"from db_gpsExceptions.t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' "+
					"and GPName='Castrol'and Category='Secondary' and RDurationinHrs>='10' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf, "+
					"0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,"+
					"0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,count(distinct(JCode)) as dgrt120,"+
					"count(JCode) as dgrt12_0,0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,"+
					"0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,"+
					"0 as TOCount,0 as SOCount  from db_gpsExceptions.t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' "+
					"and GPName='Castrol'and Category='Tanker' and RDurationinHrs>='12' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,"+
					"0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,"+
					"0 as dgrt120,0 as dgrt12_0,count(distinct(JCode)) as dgrt121,count(JCode) as dgrt12_1,0 as dgrt122,"+
					"0 as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,"+
					"0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount   from db_gpsExceptions.t_driver_ds "+
					"where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='Primary' "+
					"and RDurationinHrs>='12' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf, "+
					"0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,"+
					"0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,"+
					"count(distinct(JCode)) as dgrt122,count(JCode) as dgrt12_2,0 as TJcode,0 as TEventCount,0 as PAutoCount,"+
					"0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount from "+
					"db_gpsExceptions.t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='Secondary' and RDurationinHrs>='12' "+
					"union "+
					"select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf,0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,"+
					"0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,"+
					"0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,0 as dgrt122,0 as dgrt12_2,count(Jcode) as TJcode,"+
					"sum(countTrip) as TEventCount,0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,"+
					"0 as SMCount,0 as POCount,0 as TOCount,0 as SOCount from "+
					"(select JCode,count(*) as countTrip from db_gpsExceptions.t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'  and RDurationinHrs>='10' and JCode<>'-' group by JCode having countTrip > 1)b "+
					"union "+
					"Select 0 as Tcount,0 as Ncount,0 as Fcount,0 as brf,0 as dbrf, "+
					"0 as tbcount,0 as tdbcount,0 as ndall,0 as cdall,0 as countdaily,0 as countweek,0 as dgrt10,0 as dgrt10_0,"+
					"0 as dgrt101,0 as dgrt10_1,0 as dgrt102,0 as dgrt10_2,0 as dgrt120,0 as dgrt12_0,0 as dgrt121,0 as dgrt12_1,"+
					"0 as dgrt122,0 as dgrt12_2,0 as TJcode,0 as TEventCount,sum(PAutoCount) as PAutoCount,sum(TAutoCount) as TAutoCount,"+
					"sum(SAutoCount) as SAutoCount,sum(PMCount) as PMCount,sum(TMCount) as TMCount,sum(SMCount) as SMCount,"+
					"sum(POCount) as POCount,sum(TOCount) as TOCount,sum(SOCount) as SOCount from "+
					"(Select count(*) as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' and Endedby='-' "+
					"and (Endedby = '-' AND TripEnddate <> 'NA') and Category='Primary' "+
					"union "+
					"Select 0 as PAutoCount,count(*) as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' and Endedby='-' "+
					"and (Endedby = '-' AND TripEnddate <> 'NA') and Category='Tanker' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,count(*) as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' and Endedby='-' "+
					"and (Endedby = '-' AND TripEnddate <> 'NA') and Category='Secondary' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,count(*) as PMCount,0 as TMCount,0 as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' "+
					"and Endedby not in ('-','NA') and Category='Primary' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,count(*) as TMCount,0 as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' "+
					"and Endedby not in ('-','NA') and Category='Tanker' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,count(*) as SMCount,"+
					"0 as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where "+
					"TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' "+
					"and Endedby not in ('-','NA') and Category='Secondary' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,"+
					"count(*) as POCount,0 as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where "+
					"TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' "+
					"and TripEndDate='NA' and Category='Primary' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,"+
					"count(*) as TOCount,0 as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' "+
					"and TripEndDate='NA' and Category='Tanker' "+
					"union "+
					"Select 0 as PAutoCount,0 as TAutoCount,0 as SAutoCount,0 as PMCount,0 as TMCount,0 as SMCount,0 as POCount,"+
					"0 as TOCount,count(*) as SOCount from db_gps.t_CastrolTripsStarted where TripStartDate "+
					"between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and status<>'Faulty' and TripEndDate='NA' "+
					"and Category='Secondary')c "+
					")a";
					ResultSet rst1=st1.executeQuery(sql1);
					while(rst1.next())
					{
						 alljd=rst1.getInt("Tcount");
						 nogpsjd=rst1.getInt("NGcount");
						 faultcnt=rst1.getInt("Fcount");
						fltydb=rst1.getInt("Fcount");
						bidcount=rst1.getInt("brfcount");
						dbidcount=rst1.getInt("dbrfcount");
						tbcount=rst1.getInt("tbrfcount");
						tdbcount=rst1.getInt("tdbrfcount");
						ndall=rst1.getInt("ND");
						cdall=rst1.getInt("CD");
						countdaily=rst1.getInt("countdaily");
						countweekly=rst1.getInt("countweek");
						
						dgrt10=rst1.getInt("dgrt10");
			 			dgrt10_0=rst1.getInt("dgrt10_0");
						dgrt101=rst1.getInt("dgrt101");
				 		dgrt10_1=rst1.getInt("dgrt10_1"); 
						dgrt102=rst1.getInt("dgrt102");
						dgrt10_2=rst1.getInt("dgrt10_2");
						dgrt12=rst1.getInt("dgrt120");
					 	dgrt12_01=rst1.getInt("dgrt12_0"); 
						dgrt12_1=rst1.getInt("dgrt121");
						dgrt12_02=rst1.getInt("dgrt12_1");
						dgrt12_2=rst1.getInt("dgrt122");
						dgrt12_03=rst1.getInt("dgrt12_2");
						c=rst1.getInt("TJcode");
						count=rst1.getInt("TEventCount");
						 
						totauto1=rst1.getInt("PAutoCount");
						manualtot1=rst1.getInt("PMCount");
						opentot1=rst1.getInt("POCount");
						totauto2=rst1.getInt("TAutoCount");
						manualtot2=rst1.getInt("TMCount");
						opentot2=rst1.getInt("TOCount");
						totauto3=rst1.getInt("SAutoCount");
						manualtot3=rst1.getInt("SMCount");
						opentot3=rst1.getInt("SOCount");
					}
				
				totjd=alljd-nogpsjd;
				percent=Double.valueOf(totjd);
				percent1=Double.valueOf(alljd);
				percent=(percent/percent1)*100;
				//******************************************************************************************************
				%>
				<tr>
				<td><font size="2">Trip Installed with Mobile-Eye</font></td>
				<td align="right"><div align="right"><font size="2"><%=totjd%></font></div></td>
				</tr>
				<tr>
				<td><font size="2">Trip Not Installed with Mobile-Eye</font></td>
				<td align="right"><div align="right"><font size="2"><%=nogpsjd%></font></div></td>
				</tr>
				<tr>
				<td><font size="2">Total Trips from JD</font></td>
				<td align="right"><div align="right"><font size="2"><%=alljd%></font></div></td>
				</tr>
				<tr>
				<td><font size="2">Percent of Mobile-Eye Installed</font></td>
				<td align="right"><div align="right"><font size="2"><%=nf.format(percent)%>%</font></div></td>
				</tr>
				</table>
			</td>
			<!--  </tr>
			<tr> -->
			<td width="50%">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="2"><font size="2">Captured Trips Summary</font></th></tr>
				<% 
				
				tcdb=totjd;
				totdb=tcdb-faultcnt;
				//tcdb=totdb+fltydb;
				percent11=Double.valueOf(tcdb);
				percent111=Double.valueOf(totdb);
				percent11=(percent111/percent11)*100;
				//System.out.println(percent11);
				%>
			<tr>
				<td><font size="2">Trip with Checked Mobile-Eye</font></td>
				<td align="right"><div align="right"><font size="2"><%=totdb%></font></div></td>
				<!--<td></td>-->
			</tr>
			<tr>
				<td><font size="2">Trip Without Checked Mobile-Eye</font></td>
					<%
					if(faultcnt==0)
					{
					%>
					<td align="right"><div align="right"><%=faultcnt%></div></td>
					<%	
					}
					else
					{
					%>
					<td align="right"><div align="right"><font size="2"><%=faultcnt%></font></div></td>
					<%
					}
					%>
				<!--<td></td>-->
			</tr>
			<tr>
				<td><font size="2">Total Trips with Mobile Eye</font></td>
				<td align="right"><div align="right"><font size="2"><%=totjd%></font></div></td>
				<!--<td></td>-->
			</tr>
			<tr>
				<td><font size="2">Percentage with Checked Mobile-Eye</font></td>
				<td align="right"><div align="right"><font size="2"><%=nf.format(percent11)%>%</font></div></td>
				<!--<td></td>-->
			</tr>
			
			</table>
			</td>
			</tr>
				<%
				
				bcount=tbcount-bidcount;
				dbcount=tdbcount-dbidcount;
				
				%>
				<tr>
				<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="4"><font size="2">Drivers Counselling Summary</font></th></tr>
				<tr>
					<td><font size="2">Briefing Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><font size="2"><%=bidcount%></font></div></td>
					<td><font size="2">Debriefing Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><font size="2"><%=dbidcount%></font></div></td>
				</tr>
				<tr>
					<td><font size="2">Briefing Non-Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><font size="2"><%=bcount%></font></div></td>
					<td><font size="2">Debriefing Non-Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><font size="2"><%=dbcount%></font></div></td>
				</tr>
				<tr>
					<td><font size="2">Total Briefing Done</font></td>
					<td align="right"><div align="right"><font size="2"><%=tbcount%></font></div></td>
					<td><font size="2">Total DeBriefing Done</font></td>
					<td align="right"><div align="right"><font size="2"><%=tdbcount%></font></div></td>
				</tr>
				</table>
				</td>
				</tr>
				<%
				
						sql11="SELECT * FROM CastrolMonthlyReport WHERE Month='"+fromdate1+"' and Year='"+todate1+"' and filter='Started'";
						ResultSet rst11=st1.executeQuery(sql11);
						if(rst11.next())						

						{
							kt=rst11.getInt("TotFleetKm");
							ra=rst11.getInt("TotFleetRA");
							rd=rst11.getInt("TotFleetRD");
							os=rst11.getInt("TotFleetOSDuration");
							kt1=rst11.getInt("TotCapturedKm");
							ra1=rst11.getInt("TotCapturedRA");
							rd1=rst11.getInt("TotCapturedRD");
							os1=rst11.getInt("TotCapturedOSDuration");
							kt11=rst11.getInt("TotNoFaultyKm");
							ra11=rst11.getInt("TotNoFaultyRA");
							rd11=rst11.getInt("TotNoFaultyRD");
							os11=rst11.getInt("TotNoFaultyOSDuration");
							PJDTrips=rst11.getInt("PJDTrips");
							PCApturedTrips=rst11.getInt("PCApturedTrips");
							PVehicles=rst11.getInt("PVehicles");
							PDrivers=rst11.getInt("PDrivers");
							PDistance=rst11.getInt("PDistance");
							PRA=rst11.getInt("PRA");
							PRD=rst11.getInt("PRD");
							POSDuration=rst11.getInt("POSDuration");
							PND=rst11.getInt("PND");
							PCD=rst11.getInt("PCD");
							PBrief=rst11.getInt("PBrief");
							PDeBrief=rst11.getInt("PDeBrief");
							//PRatings=rst11.getInt("PRatings");
							TJDTrips=rst11.getInt("TJDTrips");
							TCApturedTrips=rst11.getInt("TCApturedTrips");
							TVehicles=rst11.getInt("TVehicles");
							TDrivers=rst11.getInt("TDrivers");
							TDistance=rst11.getInt("TDistance");
							TRA=rst11.getInt("TRA");
							TRD=rst11.getInt("TRD");
							TOSDuration=rst11.getInt("TOSDuration");
							TND=rst11.getInt("TND");
							TCD=rst11.getInt("TCD");
							TBrief=rst11.getInt("TBrief");
							TDeBrief=rst11.getInt("TDeBrief");
							SJDTrips=rst11.getInt("SJDTrips");
							SCApturedTrips=rst11.getInt("SCApturedTrips");
							SVehicles=rst11.getInt("SVehicles");
							SDrivers=rst11.getInt("SDrivers");
							SDistance=rst11.getInt("SDistance");
							SRA=rst11.getInt("SRA");
							SRD=rst11.getInt("SRD");
							SOSDuration=rst11.getInt("SOSDuration");
							SND=rst11.getInt("SND");
							SCD=rst11.getInt("SCD");
							SBrief=rst11.getInt("SBrief");
							SDeBrief=rst11.getInt("SDeBrief");
						%>
				<tr>						
			<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="6"><font size="2">CAPTURED DATA SUMMARY</font></th></tr>
				<tr>
				<th><font size="2">Rating Details</font></th>
				<th><font size="2">Km Captured</font></th>
				<th><font size="2">RA </font></th>
				<th><font size="2">RD </font></th>
				<th><font size="2">OS Duration</font></th>
				<th><font size="2">Rating</font></th>
				</tr>
				<tr>
				<td><font size="2">Total Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os%></font></div></td>
				<td align="right"></td>
				</tr>
				<%
				if(kt!=0)
				{
					rartng=Double.valueOf(ra);
					rartng=(rartng/kt);
					rartng=rartng*100;
					rdrtng=Double.valueOf(rd);
					rdrtng=(rdrtng/kt);
					rdrtng=rdrtng*100;
					osrtng=Double.valueOf(os/10);
					osrtng=osrtng/kt;
					osrtng=osrtng*100;
					rtng=rartng+rdrtng+osrtng;
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng)%></font></div></td>
					</tr>
					<%
				}
				else
				{
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
					</tr>
					<%
				}
				%>
				<tr>
				<td><font size="2">Castrol Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt11%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra11%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd11%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os11%></font></div></td>
				<td align="right"></td>
				</tr>
				<%
				if(kt11!=0)
				{
					rartng11=Double.valueOf(ra11);
					rartng11=(rartng11/kt11);
					rartng11=rartng11*100;
					rdrtng11=Double.valueOf(rd11);
					rdrtng11=(rdrtng11/kt11);
					rdrtng11=rdrtng11*100;
					osrtng11=Double.valueOf(os11/10);
					osrtng11=osrtng11/kt11;
					osrtng11=osrtng11*100;
					rtng11=rartng11+rdrtng11+osrtng11;
					
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng11)%></font></div></td>
						
					</tr>
					<%
					
				}
				else
				{
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						
					</tr>
					<%
				}
				kt2=kt-kt11;
				ra2=ra-ra11;
				rd2=rd-rd11;
				os2=os-os11;
				%>
				<tr>
				<td><font size="2">Non-Castrol Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt2%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra2%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd2%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os2%></font></div></td>
				<td align="right"></td>
				</tr>
				<%
				if(kt2!=0)
				{
					rartng2=Double.valueOf(ra2);
					rartng2=(rartng2/kt2);
					rartng2=rartng2*100;
					rdrtng2=Double.valueOf(rd2);
					rdrtng2=(rdrtng2/kt2);
					rdrtng2=rdrtng2*100;
					osrtng2=Double.valueOf(os2/10);
					osrtng2=osrtng2/kt2;
					osrtng2=osrtng2*100;
					rtng2=rartng2+rdrtng2+osrtng2;
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng2)%></font></div></td>
						
					</tr>
					<%
				}
				else
				{
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
					</tr>
					<%
				}
				%>
				</table>
			</td>
			</tr>
			<%
			}
				%>
	<!-- ****************** Code End For KM Count for Fleet And Castrol/Non Castrol**************** -->	
			<tr>
			<td width="50%">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="2"><font size="2">POLICY VIOLATIONS SUMMARY</font></th></tr>
				<tr>
					<th><font size="2">Policy Violations</font></th>
					<th><font size="2">Trips</font></th>
				</tr>
				<tr>
							<td><font size="2">Night Driving</font></td>

							<td align="right"><div align="right"><font size="2"><%=ndall%></font></div></td>
						</tr>
						<tr>
							<td><font size="2">Continuous Driving</font></td>
							<td align="right"><div align="right"><font size="2"><%=cdall%></font></div></td>
						</tr>
				</table>
				</td>
			
			<td width="50%">
			<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="2"><font size="2">Driving Hrs VIOLATIONS SUMMARY</font></th></tr>
				<tr>
					<th><font size="2">Violations</font></th>
					<th><font size="2">Counts</font></th>
				</tr>
			<%
				
					%>
						<tr>
							<td><font size="2">Daily Driving Hrs</font></td>
							<td align="right"><div align="right"><font size="2"><%=countdaily%></font></div></td>
							<!--<td align="right"><div align="right"><font size="2">< %=rst12.getInt("countdaily")%></font></div></td>-->
						</tr>
					<%
				
					%>
						<tr>
							<td><font size="2">Weekly Driving Hrs</font></td>
							<td align="right"><div align="right"><font size="2"><%=countweekly%></font></div></td>
							<!--<td align="right"><div align="right"><font size="2">< %=rst13.getInt("countweek")%></font></div></td>-->
						</tr>
					
				</table>
				</td>
		</tr>
			<tr>
			<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr>
				<th colspan="11" align="center"><font size="2">Driving Hrs Report</font></th>
				</tr>
			  <tr>
			  <td align="center"></td>
			  <td align="center" colspan="3"><font size="2"><b>No.of Castrol Trips</b></font></td>
			    <td align="center" colspan="3"><font size="2"><b>Driving Beyound 10 Hrs.</b></font></td>
			    <td align="center" colspan="3"><font size="2"><b>Driving Beyound 12 Hrs.</b></font></td>
			     <td align="center"></td>
			          	  </tr>
			  <tr>
			        <td><b>Month</b></td>
			        <td><b>Tanker</b></td><td><b>Primary</b></td><td><b>Secondary</b></td>
			       <td><b>Tanker &nbsp;&nbsp; &nbsp;(Violation Count)</b></td><td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
			    <td><b>Tanker &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
			     <td><b>Repeat Violation</b></td>
			  </tr>
			  <tr>
			     <td><%=new SimpleDateFormat("MMM").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%></td>
			     <td><%=TCApturedTrips %></td>
			     <td><%=PCApturedTrips%></td>  
			     <td><%=SCApturedTrips%></td>
			     
			      <% 
			         if(dgrt10==0)
			         {  %>
			        	 <td>0</td>
			        <% }
			         else
			         {
			      %>			  
			               <td align="right"><div align="right"><%=dgrt10%>(<font size="2"><%=dgrt10_0%></font>)</div></td>
			      <%  }   
			        
			      
			       if(dgrt101==0)
			         { %> 
			        	   <td>0</td>
			        <% }
			         else
			         {
			      %>
			          <td align="right"><div align="right"><%=dgrt101%>(<font size="2"><%=dgrt10_1%></font>)</div></td>
			       <%  } 
			     
			         if(dgrt102==0)
			         {  %>
			        	    <td>0</td>
			        <%  }
			         else
			         {
			            %>
			         <td align="right"><div align="right"><%=dgrt102%>(<font size="2"><%=dgrt10_2%></font>)</div></td>
	              <%  
	                    }
			         
			        if(dgrt12==0)
			        {  %>
			         	<td>0</td>
			       <% }
			    
			        else
			        {
			        %>
 			        <td align="right"><div align="right"><%=dgrt12%>(<font size="2"><%=dgrt12_01%></font>)</div></td>
	            <%  } 
                   if(dgrt12_1==0)
                  {   %>
                     <td>0</td>
               <%  } 
                else
                { %>
                <td align="right"><div align="right"><%=dgrt12_1%>(<font size="2"><%=dgrt12_02%></font>)</div></td>
		        <% }        
			    if(dgrt12_2==0)
			    { %>
			    	<td>0</td>
			   <% }
			    else
			    {
			       %>
			    <td align="right"><div align="right"><%=dgrt12_2%>(<font size="2"><%=dgrt12_03%></font>)</div></td>
		                  
			  <%  }
			         if( c==0)
			         {%>
			        	 <td>0</td>
			       <%  } 
			         else
			         
			         {
			          %>
			        	
			        	  <td align="right"><div align="right"><%=c%>(<font size="2"><%=count%></font>)</div></td>
			        	
			        	
				    <%    }
			                
			        %>
			      
			   </tr>
			  </table> 
				</td>	
			</tr>	
		
			<tr>
			<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr>
				<th colspan="17" align="center"><font size="2">CATEGORYWISE REPORT</font></th>
				</tr>
				<tr>
					<th><font size="2">Category</font></th>
					<th><font size="2">Trips by JD</font></th>
					<th><font size="2">Captured Trips</font></th>	
				  	<th><font size="2">Vehicles</font></th>
					<th><font size="2">Drivers</font></th>
					<th><font size="2">Distance</font></th>
					<th><font size="2">RA</font></th>
					<th><font size="2">RD</font></th>
					<th><font size="2">OSDuration</font></th>
					<th><font size="2">ND</font></th>
					<th><font size="2">CD</font></th>
					<th><font size="2">Brief</font></th>
					<th><font size="2">De-Brief</font></th>
					<th><font size="2">Rating</font></th>
					<th><font size="2">AutoClosed</font></th>
					<th><font size="2">ManualClosed</font></th>
					<th><font size="2">OpenTrips</font></th>
					
					
				</tr>
					<tr>
							<td><font size="2">Primary</font></td>
							<td align="right"><div align="right"><font size="2"><%=PJDTrips%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PCApturedTrips %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PVehicles %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PDrivers%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PDistance%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PRA%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PRD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=POSDuration%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PND%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PCD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PBrief%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PDeBrief%></font></div></td>
						<%
							if(PDistance!=0)
							{
								PRatings=Double.valueOf(PRA+PRD+(POSDuration/10));
								PRatings=PRatings/PDistance;
								PRatings=PRatings*100;	
							%>
							<td align="right"><div align="right"><font size="2"><%=nf.format(PRatings)%></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2">NA</font></div></td>
							<%
							}
				
							%>
							<!-- <td align="right"><div align="right"><font size="2">< %=totauto1%></font></div></td>-->
							<%
							if(totauto1>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto1%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto1%></font></div></td>
								<%
							}
							
							if(manualtot1>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot1%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot1%></font></div></td>
								<%
							}
							
							if(opentot1>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot1%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot1%></font></div></td>
								<%
							}
							%>
							
						</tr>
						<tr>
							<td><font size="2">Tanker</font></td>
							<td align="right"><div align="right"><font size="2"><%=TJDTrips%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TCApturedTrips%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TVehicles %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TDrivers %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TDistance%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TRA%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TRD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TOSDuration%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TND%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TCD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TBrief%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TDeBrief%></font></div></td>
						<%
							if(TDistance!=0)
							{
							TRatings=Double.valueOf(TRA+TRD+(TOSDuration/10));
							TRatings=TRatings/TDistance;
							TRatings=TRatings*100;
							%>
							<td align="right"><div align="right"><font size="2"><%=nf.format(TRatings)%></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2">NA</font></div></td>
							<%
							}
							if(totauto2>0)
							{
								%>
		
								<td align="right"><div align="right"><font size="2"><%=totauto2%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto2%></font></div></td>
								<%
							}
							
							if(manualtot2>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot2%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot2%></font></div></td>
								<%
							}
							
							if(opentot2>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot2%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot2%></font></div></td>
								<%
							}
							%>
						</tr>
						<tr>
							<td><font size="2">Secondary</font></td>
							<td align="right"><div align="right"><font size="2"><%=SJDTrips%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SCApturedTrips%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SVehicles%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SDrivers%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SDistance%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SRA%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SRD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SOSDuration%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SND%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SCD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SBrief%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SDeBrief%></font></div></td>
						<%
							if(SDistance!=0)
							{
								SRatings=Double.valueOf(SRA+SRD+(SOSDuration/10));
								SRatings=SRatings/SDistance;
								SRatings=SRatings*100;
							%>
							<td align="right"><div align="right"><font size="2"><%=nf.format(SRatings)%></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2">NA</font></div></td>
							<%
							}
							if(totauto3>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto3%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto3%></font></div></td>
								<%
							}
							
							if(manualtot3>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot3%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot3%></font></div></td>
								<%
							}
							
							if(opentot3>0)
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot3%></font></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot3%></font></div></td>
								<%
							}
							%>
							
						</tr>
				<tr>
					<td><font size="2">Total</font></td>
					<%
						int tottrip=PJDTrips+TJDTrips+SJDTrips;
					    int tottrip1=PCApturedTrips+TCApturedTrips+SCApturedTrips;
						int totveh=PVehicles+TVehicles+SVehicles;
						int totdriver=PDrivers+TDrivers+SDrivers;
						int totkm=PDistance+TDistance+SDistance;
						int totRACount=PRA+TRA+SRA;
						int totRDCount=PRD+TRD+SRD;
						int totOSDuration=POSDuration+TOSDuration+SOSDuration;
						int totnd=PND+TND+SND;
						int totcd=PCD+TCD+SCD;
						int totbrief=PBrief+TBrief+SBrief;
						int totdbrief=PDeBrief+TDeBrief+SDeBrief;
						int totopen=opentot1+opentot2+opentot3;
						int totauto=totauto1+totauto2+totauto3;
						int totmanual=manualtot1+manualtot2+manualtot3;
						
						double totratng=0.0;
					%>
					<td><div align="right"><font size="2"><b><%=tottrip %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=tottrip1 %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totveh %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totdriver %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totkm %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totRACount %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totRDCount %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totOSDuration %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totnd %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totcd %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totbrief %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totdbrief %></b></font></div></td>
					<%
							if(totkm!=0)
							{
							totratng=Double.valueOf(totRACount+totRDCount+(totOSDuration/10));
							totratng=totratng/totkm;
							totratng=totratng*100;
							%>
							<td align="right"><div align="right"><font size="2"><b><%=nf.format(totratng)%></b></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2"><b>NA</b></font></div></td>
							<%
							}
							%>
					<td><div align="right"><font size="2"><b><%=totauto %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totmanual %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totopen %></b></font></div></td>
				</tr>
			</table>
			</td>
			</tr>
		<%
	}
	else if(thename.equals("ended"))
	{
		opentot1=0;totauto1=0;manualtot1=0;k=1;
		opentot2=0;totauto2=0;manualtot2=0;
		opentot3=0;totauto3=0;manualtot3=0;
		//System.out.println("In Ended");
%>		
		<tr>
		<td width="50%">
			<table border="1" width="100%" class="stats">
			<tr><th align="center" colspan="2"><b><font size="2">JD Data from Castrol</font></b></th></tr>
			<%
					/*sql1="SELECT count(Distinct(`TripID`)) as count FROM t_alljddata WHERE StartDate between '"+fromdate+"' and '"+todate+"'";
					ResultSet rst1=st1.executeQuery(sql1);
					while(rst1.next())
					{
						 alljd=rst1.getInt("count");
					}
				sql2="SELECT count(Distinct(TripID)) as count FROM t_CastrolTripsStarted WHERE TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rst2=st1.executeQuery(sql2);
				while(rst2.next())
				{
					totjd=rst2.getInt("count");
				}
				nogpsjd=alljd-totjd;
				percent=Double.valueOf(totjd);
				percent1=Double.valueOf(alljd);
				percent=(percent/percent1)*100;*/
				//******************************************************************************************************
				%>
				<!--<tr>
				<td><font size="2">Trip Installed with Mobile-Eye</font></td>
				<td align="right"><div align="right"><a href="trips_GPSalljd.jsp?fromdate=< %=fromdate%>&todate=< %=todate%>&thename=< %=thename%>"><font size="2">< % =totjd%></font></a></div></td>
				</tr>
				<tr>
				<td><font size="2">Trip Not Installed with Mobile-Eye</font></td>
				<td align="right"><div align="right"><a href="trips_widoutGPS_castrol.jsp?fromdate=< %=fromdate%>&todate=< % =todate%>&thename=< %=thename%>"><font size="2">< %=nogpsjd%></font></a></div></td>
				</tr>
				<tr>
				<td><font size="2">Total Trips from JD</font></td>
				<td align="right"><div align="right"><a href="trips_alljd.jsp?fromdate=< %=fromdate%>&todate=< % =todate%>&thename=< %=thename%>"><font size="2">< %=alljd%></font></a></div></td>
				</tr>
				<tr>
				<td><font size="2">Percent of Mobile-Eye Installed</font></td>
				<td align="right"><div align="right"><font size="2">< %=nf.format(percent)%>%</font></div></td>
				</tr>-->
				<tr>
				<td><font size="2">Trip Installed with Mobile-Eye</font></td>
				<td align="right">-</td>
				</tr>
				<tr>
				<td><font size="2">Trip Not Installed with Mobile-Eye</font></td>
				<td align="right">-</td>
				</tr>
				<tr>
				<td><font size="2">Total Trips from JD</font></td>
				<td align="right">-</td>
				</tr>
				<tr>
				<td><font size="2">Percent of Mobile-Eye Installed</font></td>
				<td align="right">-</td>
				</tr>
				</table>
			</td>
			<!--  </tr>
			<tr> -->
			<td width="50%">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="2"><font size="2">Captured Trips Summary</font></th></tr>
				<% 
				//*******************************************************************************************
				sql3="select count(distinct(tripid)) as scount from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rst3=st1.executeQuery(sql3);
				while(rst3.next())
				{
					totdb=rst3.getInt("scount");
				}
				//*********************************************************************************************
				/*sql4="select count(distinct(tripid)) as count from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+"23:59:59'";
				ResultSet rst4=st1.executeQuery(sql4);
				while(rst4.next())
				{
					faultcnt=rst4.getInt("count");
					fltydb=rst4.getInt("count");
				}*/
				tcdb=totdb+fltydb;
				percent11=Double.valueOf(tcdb);
				percent111=Double.valueOf(totdb);
				percent11=(percent111/percent11)*100;
				//System.out.println(percent11);
				%>
			<tr>
				<td><font size="2">Trip with Checked Mobile-Eye</font></td>
				<td align="right"><div align="right"><a href="castrolTotalTrips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totdb%></font></a></div></td>
				<!--<td></td>-->
			</tr>
			<tr>
				<td><font size="2">Trip Without Checked Mobile-Eye</font></td>
				<%
				if(faultcnt==0)
				{
					%>
					<td align="right"><div align="right"><%=faultcnt%></div></td>
					<%	
				}
				else
				{
				%>
				<td align="right"><div align="right"><a href="trips_Faulty_castrol.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=faultcnt%></font></a></div></td>
				<%
				}
				%>
				<!--<td></td>-->
			</tr>
			<tr>
				<td><font size="2">Total Trips with Mobile Eye</font></td>
				<td align="right"><div align="right"><a href="castrolTotalTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tcdb%></font></a></div></td>
				<!--<td></td>-->
			</tr>
			<tr>
				<td><font size="2">Percentage with Checked Mobile-Eye</font></td>
				<td align="right"><div align="right"><font size="2"><%=nf.format(percent11)%>%</font></div></td>
				<!--<td></td>-->
			</tr>
			
			</table>
			</td>
			</tr>
				<%
				sql5="select count(*) as bidcount from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'faulty' and Briefing = 'briefed'";
				ResultSet rst5=st1.executeQuery(sql5);
				if(rst5.next())
				{
					bidcount=rst5.getInt("bidcount");
				}
				sql6="select count(*) as dbidcount from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'faulty' and Debriefing = 'Yes'";
				ResultSet rst6=st1.executeQuery(sql6);
				if(rst6.next())
				{
					dbidcount=rst6.getInt("dbidcount");
				}
				sql7="select count(*) as tbcount from t_briefing where brifdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rst7=st1.executeQuery(sql7);
				if(rst7.next())
				{
					tbcount=rst7.getInt("tbcount");
				}
				sql8="select count(*) as tdbcount from t_debriefing where Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rst8=st1.executeQuery(sql8);
				if(rst8.next())
				{
					tdbcount=rst8.getInt("tdbcount");
				}
				
				bcount=tbcount-bidcount;
				dbcount=tdbcount-dbidcount;
				
				%>
				<tr>
				<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="4"><font size="2">Drivers Counselling Summary</font></th></tr>
				<tr>
					<td><font size="2">Briefing Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><a href="trips_totidbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=bidcount%></font></a></div></td>
					<td><font size="2">Debriefing Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><a href="trips_totiddbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=dbidcount%></font></a></div></td>
				</tr>
				<tr>
					<td><font size="2">Briefing Non-Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><a href="trips_briefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=bcount%></font></a></div></td>
					<td><font size="2">Debriefing Non-Identical to Trip Ids</font></td>
					<td align="right"><div align="right"><a href="trips_dbrifing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=dbcount%></font></a></div></td>
				</tr>
				<tr>
					<td><font size="2">Total Briefing Done</font></td>
					<td align="right"><div align="right"><a href="trips_totbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tbcount%></font></a></div></td>
					<td><font size="2">Total Briefing Done</font></td>
					<td align="right"><div align="right"><a href="trips_totdbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tdbcount%></font></a></div></td>
				</tr>
				</table>
				</td>
				</tr>
				<%
				sql9="select count(*) as ndall from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and ND = 'Yes' and status<>'Faulty'";
				ResultSet rst9=st1.executeQuery(sql9);
				if(rst9.next())
				{
					ndall=rst9.getInt("ndall");
				}
				sql10="select count(*) as cdall from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and CD = 'Yes' and status<>'Faulty'";
				ResultSet rst10=st1.executeQuery(sql10);
				if(rst10.next())
				{
					cdall=rst10.getInt("cdall");
				}
						sql11="SELECT * FROM CastrolMonthlyReport WHERE Month='"+fromdate1+"' and Year='"+todate1+"' and filter='Ended'";
						ResultSet rst11=st1.executeQuery(sql11);
						if(rst11.next())
						{
							kt=rst11.getInt("TotFleetKm");
							ra=rst11.getInt("TotFleetRA");
							rd=rst11.getInt("TotFleetRD");
							os=rst11.getInt("TotFleetOSDuration");
							kt1=rst11.getInt("TotCapturedKm");
							ra1=rst11.getInt("TotCapturedRA");
							rd1=rst11.getInt("TotCapturedRD");
							os1=rst11.getInt("TotCapturedOSDuration");
							kt11=rst11.getInt("TotNoFaultyKm");
							ra11=rst11.getInt("TotNoFaultyRA");
							rd11=rst11.getInt("TotNoFaultyRD");
							os11=rst11.getInt("TotNoFaultyOSDuration");
							PJDTrips=rst11.getInt("PJDTrips");
							PCApturedTrips=rst11.getInt("PCApturedTrips");
							PVehicles=rst11.getInt("PVehicles");
							PDrivers=rst11.getInt("PDrivers");
							PDistance=rst11.getInt("PDistance");
							PRA=rst11.getInt("PRA");
							PRD=rst11.getInt("PRD");
							POSDuration=rst11.getInt("POSDuration");
							PND=rst11.getInt("PND");
							PCD=rst11.getInt("PCD");
							PBrief=rst11.getInt("PBrief");
							PDeBrief=rst11.getInt("PDeBrief");
							//PRatings=rst11.getInt("PRatings");
							TJDTrips=rst11.getInt("TJDTrips");
							TCApturedTrips=rst11.getInt("TCApturedTrips");
							TVehicles=rst11.getInt("TVehicles");
							TDrivers=rst11.getInt("TDrivers");
							TDistance=rst11.getInt("TDistance");
							TRA=rst11.getInt("TRA");
							TRD=rst11.getInt("TRD");
							TOSDuration=rst11.getInt("TOSDuration");
							TND=rst11.getInt("TND");
							TCD=rst11.getInt("TCD");
							TBrief=rst11.getInt("TBrief");
							TDeBrief=rst11.getInt("TDeBrief");
							SJDTrips=rst11.getInt("SJDTrips");
							SCApturedTrips=rst11.getInt("SCApturedTrips");
							SVehicles=rst11.getInt("SVehicles");
							SDrivers=rst11.getInt("SDrivers");
							SDistance=rst11.getInt("SDistance");
							SRA=rst11.getInt("SRA");
							SRD=rst11.getInt("SRD");
							SOSDuration=rst11.getInt("SOSDuration");
							SND=rst11.getInt("SND");
							SCD=rst11.getInt("SCD");
							SBrief=rst11.getInt("SBrief");
							SDeBrief=rst11.getInt("SDeBrief");
						%>
				<tr>						
			<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="6"><font size="2">CAPTURED DATA SUMMARY</font></th></tr>
				<tr>
				<th><font size="2">Rating Details</font></th>
				<th><font size="2">Km Captured</font></th>
				<th><font size="2">RA </font></th>
				<th><font size="2">RD </font></th>
				<th><font size="2">OS Duration</font></th>
				<th><font size="2">Rating</font></th>
				</tr>
				<tr>
				<td><font size="2">Total Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os%></font></div></td>
				<td align="right"></td>
				</tr>
				<%
				if(kt!=0)
				{
					rartng=Double.valueOf(ra);
					rartng=(rartng/kt);
					rartng=rartng*100;
					rdrtng=Double.valueOf(rd);
					rdrtng=(rdrtng/kt);
					rdrtng=rdrtng*100;
					osrtng=Double.valueOf(os/10);
					osrtng=osrtng/kt;
					osrtng=osrtng*100;
					rtng=rartng+rdrtng+osrtng;
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng)%></font></div></td>
					</tr>
					<%
				}
				else
				{
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
					</tr>
					<%
				}
				%>
				<tr>
				<td><font size="2">Castrol Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt11%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra11%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd11%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os11%></font></div></td>
				<td align="right"></td>
				</tr>
				<%
				if(kt11!=0)
				{
					rartng11=Double.valueOf(ra11);
					rartng11=(rartng11/kt11);
					rartng11=rartng11*100;
					rdrtng11=Double.valueOf(rd11);
					rdrtng11=(rdrtng11/kt11);
					rdrtng11=rdrtng11*100;
					osrtng11=Double.valueOf(os11/10);
					osrtng11=osrtng11/kt11;
					osrtng11=osrtng11*100;
					rtng11=rartng11+rdrtng11+osrtng11;
					
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng11)%></font></div></td>
						
					</tr>
					<%
					
				}
				else
				{
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						
					</tr>
					<%
				}
				kt2=kt-kt11;
				ra2=ra-ra11;
				rd2=rd-rd11;
				os2=os-os11;
				%>
				<tr>
				<td><font size="2">Non-Castrol Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt2%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra2%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd2%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os2%></font></div></td>
				<td align="right"></td>
				</tr>
				<%
				if(kt2!=0)
				{
					rartng2=Double.valueOf(ra2);
					rartng2=(rartng2/kt2);
					rartng2=rartng2*100;
					rdrtng2=Double.valueOf(rd2);
					rdrtng2=(rdrtng2/kt2);
					rdrtng2=rdrtng2*100;
					osrtng2=Double.valueOf(os2/10);
					osrtng2=osrtng2/kt2;
					osrtng2=osrtng2*100;
					rtng2=rartng2+rdrtng2+osrtng2;
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng2)%></font></div></td>
						
					</tr>
					<%
				}
				else
				{
					%>
					<tr>
						<td></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
					</tr>
					<%
				}
				%>
				</table>
			</td>
			</tr>
			<%
			}
				%>
	<!-- ****************** Code End For KM Count for Fleet And Castrol/Non Castrol**************** -->	
			<tr>
			<td width="50%">
				<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="2"><font size="2">POLICY VIOLATIONS SUMMARY</font></th></tr>
				<tr>
					<th><font size="2">Policy Violations</font></th>
					<th><font size="2">Trips</font></th>
				</tr>
				<tr>
							<td><font size="2">Night Driving</font></td>
</font></td>
							<td align="right"><div align="right"><a href="NDAllTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&triptype=<%=thename%>"><font size="2"><%=ndall%></font></div></td>
						</tr>
						<tr>
							<td><font size="2">Continuous Driving</font></td>
							<td align="right"><div align="right"><font size="2"><%=cdall%></font></div></td>
						</tr>
				</table>
				</td>
			
			<td width="50%">
			<table border="1" width="100%" class="stats">
				<tr><th align="center" colspan="2"><font size="2">Driving Hrs VIOLATIONS SUMMARY</font></th></tr>
				<tr>
					<th><font size="2">Violations</font></th>
					<th><font size="2">Counts</font></th>
				</tr>
			<%
				sql12="select count(*) as countdaily from  t_driver_ds where TheDate  between '"+fromdate+"' and '"+todate+"' AND RDurationinHrs >= 12";
				//println(sql);
				ResultSet rst12=sset5.executeQuery(sql12);
				while(rst12.next())
				{
					%>
						<tr>
							<td><font size="2">Daily Driving Hrs</font></td>
							<td align="right"><div align="right"><a href="Drivinghrsviolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=rst12.getInt("countdaily")%></font></a></div></td>
							<!--<td align="right"><div align="right"><font size="2">< %=rst99.getInt("count") %></font></div></td>-->
						
						</tr>
					<%
				}
				String sql13="select count(*) as countweek from  t_driver_ds where TheDate  between '"+fromdate+"' and '"+todate+"' AND Last7DayRDurationinHrs >= 60";
				//println(sql);
				ResultSet rst13=sset5.executeQuery(sql13);
				while(rst13.next())
				{
					%>
						<tr>
							<td><font size="2">Weekly Driving Hrs</font></td>
							<td align="right"><div align="right"><a href="WeeklyDrvnghrsviolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=rst13.getInt("countweek")%></font></a></div></td>
							<!--<td align="right"><div align="right"><font size="2">< %=rst999.getInt("count") %></font></div></td>-->
						</tr>
					<%
				}
				%>
				</table>
				</td>
			</tr>
	      <tr>
			<td colspan="2">
				
		<table border="1" width="100%" class="stats">
				<tr>
				<th colspan="11" align="center"><font size="2">Driving Hrs Report</font></th>
				</tr>
			  <tr>
			  <td align="center"></td>
			  <td align="center" colspan="3"><font size="2"><b>No.of Castrol Trips</b></font></td>
			    <td align="center" colspan="3"><font size="2"><b>Driving Beyound 10 Hrs.</b></font></td>
			    <td align="center" colspan="3"><font size="2"><b>Driving Beyound 12 Hrs.</b></font></td>
			     <td align="center"></td>
			          	  </tr>
			  <tr>
			        <td><b>Month</b></td>
			        <td><b>Tanker</b></td><td><b>Primary</b></td><td><b>Secondary</b></td>
			       <td><b>Tanker &nbsp;&nbsp; &nbsp;(Violation Count)</b></td><td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
			    <td><b>Tanker &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
			     <td><b>Repeat Violation</b></td>
			  </tr>
			 
		   	<%
			         
			
		 
			String qset4="select count(distinct(JCode)) as dgrt10,count(JCode) as dgrt10_0  from t_driver_ds  where GPName='Castrol'and Category='Tanker' and TheDate between '"+fromdate+"' and '"+todate+"' and RDurationinHrs>='10' ";
		ResultSet rset4=sset4.executeQuery(qset4);
			while(rset4.next())
			{
				 dgrt10=rset4.getInt("dgrt10");
				 dgrt10_0=rset4.getInt("dgrt10_0");
			}
			
			String qset5="select  count(distinct(JCode)) as dgrt101,count(JCode) as dgrt10_1   from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='primary' and RDurationinHrs>='10' ";
		ResultSet	rset5= sset5.executeQuery(qset5);
			while(rset5.next())
			{
			 dgrt101=rset5.getInt("dgrt101");
			 dgrt10_1=rset5.getInt("dgrt10_1");
				
			}
					
			String qset6="select count(distinct(JCode)) as dgrt102, count(JCode) as dgrt10_2  from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='secondary' and RDurationinHrs>='10' ";
			ResultSet rset6=sset6.executeQuery(qset6);
			while(rset6.next())
			{
				 dgrt102=rset6.getInt("dgrt102");
				 dgrt10_2=rset6.getInt("dgrt10_2");
					
			}
			
		
			String qset7="select  count(distinct(JCode))  as dgrt12, count(JCode) as dgrt12_01   from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='Tanker' and RDurationinHrs>='12' ";
		ResultSet	rset7=sset7.executeQuery(qset7);
			while(rset7.next())
			{
			 dgrt12=rset7.getInt("dgrt12");
			 dgrt12_01=rset7.getInt("dgrt12_01");
				
			}
			
			String qset8="select  count(distinct(JCode)) as dgrt12_1,count(JCode) as dgrt12_02   from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='primary' and RDurationinHrs>='12' ";
		ResultSet	rset8=sset8.executeQuery(qset8);
			while(rset8.next())
			{
				 dgrt12_1=rset8.getInt("dgrt12_1");
				 dgrt12_02=rset8.getInt("dgrt12_02");
					
			}
			
			
			String qset9="select  count(distinct(JCode)) as dgrt12_2, count(JCode) as dgrt12_03   from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='secondary' and RDurationinHrs>='12' ";
		ResultSet	rset9=sset9.executeQuery(qset9);
			while(rset9.next())
			{
				 dgrt12_2=rset9.getInt("dgrt12_2");
				 dgrt12_03=rset9.getInt("dgrt12_03");
					
			
			} 
			%>  
			     <tr>
			     <td><%=new SimpleDateFormat("MMM").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%></td>
			     <td><%=TCApturedTrips %></td>
			     <td><%=PCApturedTrips%></td>  
			     <td><%=SCApturedTrips%></td>
			     
			      <% 
			         if(dgrt10==0)
			         {  %>
			        	 <td>0</td>
			        <% }
			         else
			         {
			      %>			  
			               <td align="right"><div align="right"><%=dgrt10%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Tanker&con=10"><font size="2"><%=dgrt10_0%></font></a>)</div></td>
			      <%  }   
			        
			      
			       if(dgrt101==0)
			         { %> 
			        	   <td>0</td>
			        <% }
			         else
			         {
			      %>
			          <td align="right"><div align="right"><%=dgrt101%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Primary&con=10"><font size="2"><%=dgrt10_1%></font></a>)</div></td>
			       <%  } 
			     
			         if(dgrt102==0)
			         {  %>
			        	    <td>0</td>
			        <%  }
			         else
			         {
			            %>
			         <td align="right"><div align="right"><%=dgrt102%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Secondary&con=10"><font size="2"><%=dgrt10_2%></font></a>)</div></td>
	              <%  
	                    }
			         
			        if(dgrt12==0)
			        {  %>
			         	<td>0</td>
			       <% }
			    
			        else
			        {
			        %>
 			        <td align="right"><div align="right"><%=dgrt12%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Tanker&con=12"><font size="2"><%=dgrt12_01%></font></a>)</div></td>
	            <%  } 
                   if(dgrt12_1==0)
                  {   %>
                     <td>0</td>
               <%  } 
                else
                { %>
                <td align="right"><div align="right"><%=dgrt12_1%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Primary&con=12"><font size="2"><%=dgrt12_02%></font></a>)</div></td>
		        <% }        
			    if(dgrt12_2==0)
			    { %>
			    	<td>0</td>
			   <% }
			    else
			    {
			       %>
			    <td align="right"><div align="right"><%=dgrt12_2%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Secondary&con=12"><font size="2"><%=dgrt12_03%></font></a>)</div></td>
		                  
			  <%  }
			   
			      
		                int c1=0,count1=0;
			            vsql1= "select JCode,count(*) as countTrip from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'  and RDurationinHrs>='10' and  JCode<>'-' group by JCode ";
			           ResultSet vset1=sset11.executeQuery(vsql1); 
			          // System.out.println(vsql);
			          while(vset1.next())
			           {
			        	      countTrip=vset1.getInt("countTrip");  
			        	     
			        	      //System.out.println(countTrip);
					          if(countTrip>1)                
					            {
					        	   c1++;
					        	   count1=count1+vset1.getInt("countTrip");
						             
					            
					            }
			           
			         }  
			           
			           //System.out.println(c);
			           if( c1==0)
			         {%>
			        	 <td>0</td>
			       <%  } 
			         else
			         
			         {
			          %>
			        	 <td align="right"><div align="right"><%=c1%>(<a href="Drivinghrsviolation2.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=count1%></font></a>)</div></td>
			        	
				    <%    }
			                
			        %>
			     
			
			  </tr>
			  </table> 
			
			</td>
			</tr>		
			
			
		   <tr>
			<td colspan="2">
				<table border="1" width="100%" class="stats">
				<tr>
				<th colspan="17" align="center"><font size="2">CATEGORYWISE REPORT</font></th>
				</tr>
				<tr>
					<th><font size="2">Category</font></th>
					<th><font size="2">Trips by JD</font></th>
					<th><font size="2">Captured Trips</font></th>	
				  	<th><font size="2">Vehicles</font></th>
					<th><font size="2">Drivers</font></th>
					<th><font size="2">Distance</font></th>
					<th><font size="2">RA</font></th>
					<th><font size="2">RD</font></th>
					<th><font size="2">OSDuration</font></th>
					<th><font size="2">ND</font></th>
					<th><font size="2">CD</font></th>
					<th><font size="2">Brief</font></th>
					<th><font size="2">De-Brief</font></th>
					<th><font size="2">Rating</font></th>
					<th><font size="2">AutoClosed</font></th>
							<th><font size="2">ManualClosed</font></th>
							<th><font size="2">OpenTrips</font></th>
					
				</tr>
					<tr>
							<td><font size="2">Primary</font></td>
							<td align="right"><div align="right"><font size="2">-</font></div></td>
							<td align="right"><div align="right"><a href="castrolPrimaryTrips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=PCApturedTrips %></font></a></div></td>
							<td align="right"><div align="right"><font size="2"><%=PVehicles %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PDrivers%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PDistance%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PRA%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PRD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=POSDuration%></font></div></td>
							<td align="right"><div align="right"><a href="NDPrimaryTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=PND%></font></a></div></td>
							<td align="right"><div align="right"><font size="2"><%=PCD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PBrief%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=PDeBrief%></font></div></td>
						<%
							if(PDistance!=0)
							{
								PRatings=Double.valueOf(PRA+PRD+(POSDuration/10));
								PRatings=PRatings/PDistance;
								PRatings=PRatings*100;	
							%>
							<td align="right"><div align="right"><font size="2"><%=nf.format(PRatings)%></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2">NA</font></div></td>
							<%
							}
						
						String sql111="Select EndedBy,TripEndDate,Category from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary' and status<>'Faulty'";
						ResultSet rst111=st1.executeQuery(sql111);
						while(rst111.next())
						{
							//category11=rst111.getString("Category");
							endedby=rst111.getString("EndedBy");
							tripendate=rst111.getString("TripEndDate");
							if(tripendate.equalsIgnoreCase("NA"))
							{
								opentot1++;
							}
							if(endedby.equalsIgnoreCase("-"))
							{
							if(tripendate.equalsIgnoreCase("NA"))
							{
							
							}
							else
							{	
								totauto1++;
							}
							}
							else
							{
							if(tripendate.equalsIgnoreCase("NA"))
							{
							
							}
							else
							{	
								manualtot1++;
							}	
								
							}
							k++;
						}
							%>
							<%
							if(totauto1>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolPrimaryAuto.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totauto1%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto1%></font></div></td>
								<%
							}
							
							if(manualtot1>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolPrimaryManual.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=manualtot1%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot1%></font></div></td>
								<%
							}
							
							if(opentot1>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolPrimaryOpen.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=opentot1%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot1%></font></div></td>
								<%
							}
							%>
							
							
							
						</tr>
						<tr>
							<td><font size="2">Tanker</font></td>
							<td align="right"><div align="right"><font size="2">-</font></div></td>
							<td align="right"><div align="right"><a href="castrolTankerTrips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=TCApturedTrips%></font></a></div></td>
							<td align="right"><div align="right"><font size="2"><%=TVehicles %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TDrivers %></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TDistance%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TRA%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TRD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TOSDuration%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TND%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TCD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TBrief%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=TDeBrief%></font></div></td>
						<%
							if(TDistance!=0)
							{
							TRatings=Double.valueOf(TRA+TRD+(TOSDuration/10));
							TRatings=TRatings/TDistance;
							TRatings=TRatings*100;
							%>
							<td align="right"><div align="right"><font size="2"><%=nf.format(TRatings)%></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2">NA</font></div></td>
							<%
							}
							
						String sqltrip11="Select EndedBy,TripEndDate,Category from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Tanker' and status<>'Faulty'";
						//System.out.println(sqltrip11);
						ResultSet rsttrip11=st1.executeQuery(sqltrip11);
						while(rsttrip11.next())
						{
							//category12=rsttrip11.getString("Category");
							endedby=rsttrip11.getString("EndedBy");
							tripendate=rsttrip11.getString("TripEndDate");
							if(tripendate.equalsIgnoreCase("NA"))
							{
								opentot2++;
							}
							if(endedby.equalsIgnoreCase("-"))
							{
							if(tripendate.equalsIgnoreCase("NA"))
							{
							}
							else
							{	
								totauto2++;
							}
							}
							else
							{
							if(tripendate.equalsIgnoreCase("NA"))
							{
							}
							else
							{	
								manualtot2++;
							}	
							
							}
							k++;
						}
						%>
						<%
							if(totauto2>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolTankerAuto.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totauto2%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto2%></font></div></td>
								<%
							}
							
							if(manualtot2>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolTankerManual.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=manualtot2%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot2%></font></div></td>
								<%
							}
							
							if(opentot2>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolTankerOpen.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=opentot2%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot2%></font></div></td>
								<%
							}
							%>
							
							
						</tr>
						<tr>
							<td><font size="2">Secondary</font></td>
							<td align="right"><div align="right"><font size="2">-</font></div></td>
							<td align="right"><div align="right"><a href="castrolSecondaryTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=SCApturedTrips%></font></a></div></td>
							<td align="right"><div align="right"><font size="2"><%=SVehicles%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SDrivers%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SDistance%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SRA%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SRD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SOSDuration%></font></div></td>
							<td align="right"><div align="right"><a href="NDSecondaryTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=SND%></font></a></div></td>
							<td align="right"><div align="right"><font size="2"><%=SCD%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SBrief%></font></div></td>
							<td align="right"><div align="right"><font size="2"><%=SDeBrief%></font></div></td>
						<%
							if(SDistance!=0)
							{
								SRatings=Double.valueOf(SRA+SRD+(SOSDuration/10));
								SRatings=SRatings/SDistance;
								SRatings=SRatings*100;
							%>
							<td align="right"><div align="right"><font size="2"><%=nf.format(SRatings)%></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2">NA</font></div></td>
							<%
							}
							String sqltrip12="Select EndedBy,TripEndDate,Category from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Secondary' and status<>'Faulty'";
						ResultSet rsttrip12=st1.executeQuery(sqltrip12);
						while(rsttrip12.next())
						{
							//category13=rsttrip12.getString("Category");
							endedby=rsttrip12.getString("EndedBy");
							tripendate=rsttrip12.getString("TripEndDate");
							if(tripendate.equalsIgnoreCase("NA"))
							{
								opentot3++;
							}
							if(endedby.equalsIgnoreCase("-"))
							{
							if(tripendate.equalsIgnoreCase("NA"))
							{
							}	
							else
							{
								totauto3++;
							}
							}
							else
							{
							if(tripendate.equalsIgnoreCase("NA"))
							{
							}	
							else
							{
								manualtot3++;
							}
							}
							k++;
						}
							%>
							<%
							if(totauto3>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolSecondaryAuto.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totauto3%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto3%></font></div></td>
								<%
							}
							
							if(manualtot3>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolSecondaryManual.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=manualtot3%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot3%></font></div></td>
								<%
							}
							
							if(opentot3>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolSecondaryOpen.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=opentot3%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot3%></font></div></td>
								<%
							}
							%>
							
							
						</tr>
				<tr>
					<td><font size="2">Total</font></td>
					<%
						int tottrip=PJDTrips+TJDTrips+SJDTrips;
					    int tottrip1=PCApturedTrips+TCApturedTrips+SCApturedTrips;
						int totveh=PVehicles+TVehicles+SVehicles;
						int totdriver=PDrivers+TDrivers+SDrivers;
						int totkm=PDistance+TDistance+SDistance;
						int totRACount=PRA+TRA+SRA;
						int totRDCount=PRD+TRD+SRD;
						int totOSDuration=POSDuration+TOSDuration+SOSDuration;
						int totnd=PND+TND+SND;
						int totcd=PCD+TCD+SCD;
						int totbrief=PBrief+TBrief+SBrief;
						int totdbrief=PDeBrief+TDeBrief+SDeBrief;
						int totopen=opentot1+opentot2+opentot3;
						int totauto=totauto1+totauto2+totauto3;
						int totmanual=manualtot1+manualtot2+manualtot3;
						
						double totratng=0.0;
					%>
					<td><div align="right"><font size="2"><b>-</b></font></div></td>
					<td><div align="right"><font size="2"><b><%=tottrip1 %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totveh %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totdriver %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totkm %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totRACount %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totRDCount %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totOSDuration %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totnd %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totcd %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totbrief %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totdbrief %></b></font></div></td>
					<%
							if(totkm!=0)
							{
							totratng=Double.valueOf(totRACount+totRDCount+(totOSDuration/10));
							totratng=totratng/totkm;
							totratng=totratng*100;
							%>
							<td align="right"><div align="right"><font size="2"><b><%=nf.format(totratng)%></b></font></div></td>
							<%
							}
							else
							{
							%>
							<td align="right"><div align="right"><font size="2"><b>NA</b></font></div></td>
							<%
							}
							%>
					<td><div align="right"><font size="2"><b><%=totauto %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totmanual %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totopen %></b></font></div></td>
				</tr>
			</table>
			</td>
			</tr>
		<%
	}//end of ended trips
	else
	{
		opentot1=0;totauto1=0;manualtot1=0;k=1;
		opentot2=0;totauto2=0;manualtot2=0;
		opentot3=0;totauto3=0;manualtot3=0;
		//System.out.println("In StartEnded");
		%>		
				<tr>
				<td width="50%">
					<table border="1" width="100%" class="stats">
					<tr><th align="center" colspan="2"><b><font size="2">JD Data from Castrol</font></b></th></tr>
					<%
							/*sql1="SELECT count(Distinct(`TripID`)) as count FROM t_alljddata WHERE StartDate between '"+fromdate+"' and '"+todate+"'";
							ResultSet rst1=st1.executeQuery(sql1);
							while(rst1.next())
							{
								 alljd=rst1.getInt("count");
							}
						sql2="SELECT count(Distinct(TripID)) as count FROM t_CastrolTripsStarted WHERE TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
						ResultSet rst2=st1.executeQuery(sql2);
						while(rst2.next())
						{
							totjd=rst2.getInt("count");
						}
						nogpsjd=alljd-totjd;
						percent=Double.valueOf(totjd);
						percent1=Double.valueOf(alljd);
						percent=(percent/percent1)*100;*/
						//******************************************************************************************************
						%>
						<!--<tr>
						<td><font size="2">Trip Installed with Mobile-Eye</font></td>
						<td align="right"><div align="right"><a href="trips_GPSalljd.jsp?fromdate=< %=fromdate%>&todate=< %=todate%>&thename=< %=thename%>"><font size="2">< % =totjd%></font></a></div></td>
						</tr>
						<tr>
						<td><font size="2">Trip Not Installed with Mobile-Eye</font></td>
						<td align="right"><div align="right"><a href="trips_widoutGPS_castrol.jsp?fromdate=< %=fromdate%>&todate=< % =todate%>&thename=< %=thename%>"><font size="2">< %=nogpsjd%></font></a></div></td>
						</tr>
						<tr>
						<td><font size="2">Total Trips from JD</font></td>
						<td align="right"><div align="right"><a href="trips_alljd.jsp?fromdate=< %=fromdate%>&todate=< % =todate%>&thename=< %=thename%>"><font size="2">< %=alljd%></font></a></div></td>
						</tr>
						<tr>
						<td><font size="2">Percent of Mobile-Eye Installed</font></td>
						<td align="right"><div align="right"><font size="2">< %=nf.format(percent)%>%</font></div></td>
						</tr>-->
						<tr>
						<td><font size="2">Trip Installed with Mobile-Eye</font></td>
						<td align="right">-</td>
						</tr>
						<tr>
						<td><font size="2">Trip Not Installed with Mobile-Eye</font></td>
						<td align="right">-</td>
						</tr>
						<tr>
						<td><font size="2">Total Trips from JD</font></td>
						<td align="right">-</td>
						</tr>
						<tr>
						<td><font size="2">Percent of Mobile-Eye Installed</font></td>
						<td align="right">-</td>
						</tr>
						</table>
					</td>
					<!--  </tr>
					<tr> -->
					<td width="50%">
						<table border="1" width="100%" class="stats">
						<tr><th align="center" colspan="2"><font size="2">Captured Trips Summary</font></th></tr>
						<% 
						//*******************************************************************************************
						sql3="select count(distinct(tripid)) as scount from  t_CastrolTripsStartEnded where TripStartDate >= '"+fromdate+" 00:00:00' and TripEndDate <= '"+todate+" 23:59:59'";
						ResultSet rst3=st1.executeQuery(sql3);
						while(rst3.next())
						{
							totdb=rst3.getInt("scount");
						}
						//*********************************************************************************************
						/*sql4="select count(distinct(tripid)) as count from t_CastrolTripsEnded where TripEndDate between '"+fromdate+" 00:00:00' and '"+todate+"23:59:59'";
						ResultSet rst4=st1.executeQuery(sql4);
						while(rst4.next())
						{
							faultcnt=rst4.getInt("count");
							fltydb=rst4.getInt("count");
						}*/
						tcdb=totdb+fltydb;
						percent11=Double.valueOf(tcdb);
						percent111=Double.valueOf(totdb);
						percent11=(percent111/percent11)*100;
						//System.out.println(percent11);
						%>
					<tr>
						<td><font size="2">Trip with Checked Mobile-Eye</font></td>
						<td align="right"><div align="right"><a href="castrolTotalTrips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totdb%></font></a></div></td>
						<!--<td></td>-->
					</tr>
					<tr>
						<td><font size="2">Trip Without Checked Mobile-Eye</font></td>
						<%
						if(faultcnt==0)
						{
						%>
						<td align="right"><div align="right"><%=faultcnt%></div></td>
						<%	
						}
						else
						{
						%>
						<td align="right"><div align="right"><a href="trips_Faulty_castrol.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=faultcnt%></font></a></div></td>
						<%
						}
						%>
						<!--<td></td>-->
					</tr>
					<tr>
						<td><font size="2">Total Trips with Mobile Eye</font></td>
						<td align="right"><div align="right"><a href="castrolTotalTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tcdb%></font></a></div></td>
						<!--<td></td>-->
					</tr>
					<tr>
						<td><font size="2">Percentage with Checked Mobile-Eye</font></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(percent11)%>%</font></div></td>
						<!--<td></td>-->
					</tr>
					
					</table>
					</td>
					</tr>
						<%
						sql5="select count(*) as bidcount from t_CastrolTripsStartEnded where TripStartDate >= '"+fromdate+" 00:00:00' and TripEndDate <= '"+todate+" 23:59:59' and status<>'faulty' and Briefing = 'briefed'";
						ResultSet rst5=st1.executeQuery(sql5);
						if(rst5.next())
						{
							bidcount=rst5.getInt("bidcount");
						}
						sql6="select count(*) as dbidcount from t_CastrolTripsStartEnded where TripStartDate >= '"+fromdate+" 00:00:00' and TripEndDate <= '"+todate+" 23:59:59' and status<>'faulty' and Debriefing = 'Yes'";
						ResultSet rst6=st1.executeQuery(sql6);
						if(rst6.next())
						{
							dbidcount=rst6.getInt("dbidcount");
						}
						sql7="select count(*) as tbcount from t_briefing where brifdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
						ResultSet rst7=st1.executeQuery(sql7);
						if(rst7.next())
						{
							tbcount=rst7.getInt("tbcount");
						}
						sql8="select count(*) as tdbcount from t_debriefing where Debriefdate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
						ResultSet rst8=st1.executeQuery(sql8);
						if(rst8.next())
						{
							tdbcount=rst8.getInt("tdbcount");
						}
						
						bcount=tbcount-bidcount;
						dbcount=tdbcount-dbidcount;
						%>
						
						<tr> 
						<td colspan="2">
						<table border="1" width="100%" class="stats">
						<tr><th align="center" colspan="4"><font size="2">Drivers Counselling Summary</font></th></tr>
						<tr>
							<td><font size="2">Briefing Identical to Trip Ids</font></td>
							<td align="right"><div align="right"><a href="trips_totidbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=bidcount%></font></a></div></td>
							<td><font size="2">Debriefing Identical to Trip Ids</font></td>
							<td align="right"><div align="right"><a href="trips_totiddbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=dbidcount%></font></a></div></td>
						</tr>
						<tr>
							<td><font size="2">Briefing Non-Identical to Trip Ids</font></td>
							<td align="right"><div align="right"><a href="trips_briefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=bcount%></font></a></div></td>
							<td><font size="2">Debriefing Non-Identical to Trip Ids</font></td>
							<td align="right"><div align="right"><a href="trips_dbrifing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=dbcount%></font></a></div></td>
						</tr>
						<tr>
							<td><font size="2">Total Briefing Done</font></td>
							<td align="right"><div align="right"><a href="trips_totbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tbcount%></font></a></div></td>
							<td><font size="2">Total Briefing Done</font></td>
							<td align="right"><div align="right"><a href="trips_totdbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tdbcount%></font></a></div></td>
						</tr>
						</table>
						</td>
						</tr>
						<%
						sql9="select count(*) as ndall from t_CastrolTripsStartEnded where TripStartDate >= '"+fromdate+" 00:00:00' and TripEndDate <= '"+todate+" 23:59:59' and ND = 'Yes' and status<>'Faulty'";
						//System.out.println(sql9);
						ResultSet rst9=st1.executeQuery(sql9);
						if(rst9.next())
						{
							ndall=rst9.getInt("ndall");
						}
						sql10="select count(*) as cdall from t_CastrolTripsStartEnded where TripStartDate >= '"+fromdate+" 00:00:00' and TripEndDate <= '"+todate+" 23:59:59' and CD = 'Yes' and status<>'Faulty'";
						ResultSet rst10=st1.executeQuery(sql10);
						if(rst10.next())
						{
							cdall=rst10.getInt("cdall");
						}
								sql11="SELECT * FROM CastrolMonthlyReport WHERE Month='"+fromdate1+"' and Year='"+todate1+"' and filter='StartEnded'";
								ResultSet rst11=st1.executeQuery(sql11);
								if(rst11.next())
								{
									kt=rst11.getInt("TotFleetKm");
									ra=rst11.getInt("TotFleetRA");
									rd=rst11.getInt("TotFleetRD");
									os=rst11.getInt("TotFleetOSDuration");
									kt1=rst11.getInt("TotCapturedKm");
									ra1=rst11.getInt("TotCapturedRA");
									rd1=rst11.getInt("TotCapturedRD");
									os1=rst11.getInt("TotCapturedOSDuration");
									kt11=rst11.getInt("TotNoFaultyKm");
									ra11=rst11.getInt("TotNoFaultyRA");
									rd11=rst11.getInt("TotNoFaultyRD");
									os11=rst11.getInt("TotNoFaultyOSDuration");
									PJDTrips=rst11.getInt("PJDTrips");
									PCApturedTrips=rst11.getInt("PCApturedTrips");
									PVehicles=rst11.getInt("PVehicles");
									PDrivers=rst11.getInt("PDrivers");
									PDistance=rst11.getInt("PDistance");
									PRA=rst11.getInt("PRA");
									PRD=rst11.getInt("PRD");
									POSDuration=rst11.getInt("POSDuration");
									PND=rst11.getInt("PND");
									PCD=rst11.getInt("PCD");
									PBrief=rst11.getInt("PBrief");
									PDeBrief=rst11.getInt("PDeBrief");
									//PRatings=rst11.getInt("PRatings");
									TJDTrips=rst11.getInt("TJDTrips");
									TCApturedTrips=rst11.getInt("TCApturedTrips");
									TVehicles=rst11.getInt("TVehicles");
									TDrivers=rst11.getInt("TDrivers");
									TDistance=rst11.getInt("TDistance");
									TRA=rst11.getInt("TRA");
									TRD=rst11.getInt("TRD");
									TOSDuration=rst11.getInt("TOSDuration");
									TND=rst11.getInt("TND");
									TCD=rst11.getInt("TCD");
									TBrief=rst11.getInt("TBrief");
									TDeBrief=rst11.getInt("TDeBrief");
									SJDTrips=rst11.getInt("SJDTrips");
									SCApturedTrips=rst11.getInt("SCApturedTrips");
									SVehicles=rst11.getInt("SVehicles");
									SDrivers=rst11.getInt("SDrivers");
									SDistance=rst11.getInt("SDistance");
									SRA=rst11.getInt("SRA");
									SRD=rst11.getInt("SRD");
									SOSDuration=rst11.getInt("SOSDuration");
									SND=rst11.getInt("SND");
									SCD=rst11.getInt("SCD");
									SBrief=rst11.getInt("SBrief");
									SDeBrief=rst11.getInt("SDeBrief");
								%>
						<tr>						
					<td colspan="2">
						<table border="1" width="100%" class="stats">
						<tr><th align="center" colspan="6"><font size="2">CAPTURED DATA SUMMARY</font></th></tr>
						<tr>
						<th><font size="2">Rating Details</font></th>
						<th><font size="2">Km Captured</font></th>
						<th><font size="2">RA </font></th>
						<th><font size="2">RD </font></th>
						<th><font size="2">OS Duration</font></th>
						<th><font size="2">Rating</font></th>
						</tr>
						<tr>
						<td><font size="2">Total Fleet</font></td>
						<td align="right"><div align="right"><font size="2"><%=kt%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=ra%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=rd%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=os%></font></div></td>
						<td align="right"></td>
						</tr>
						<%
						if(kt!=0)
						{
							rartng=Double.valueOf(ra);
							rartng=(rartng/kt);
							rartng=rartng*100;
							rdrtng=Double.valueOf(rd);
							rdrtng=(rdrtng/kt);
							rdrtng=rdrtng*100;
							osrtng=Double.valueOf(os/10);
							osrtng=osrtng/kt;
							osrtng=osrtng*100;
							rtng=rartng+rdrtng+osrtng;
							%>
							<tr>
								<td></td><td></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rartng)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rtng)%></font></div></td>
							</tr>
							<%
						}
						else
						{
							%>
							<tr>
								<td></td><td></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
							</tr>
							<%
						}
						%>
						<tr>
						<td><font size="2">Castrol Fleet</font></td>
						<td align="right"><div align="right"><font size="2"><%=kt11%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=ra11%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=rd11%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=os11%></font></div></td>
						<td align="right"></td>
						</tr>
						<%
						if(kt11!=0)
						{
							rartng11=Double.valueOf(ra11);
							rartng11=(rartng11/kt11);
							rartng11=rartng11*100;
							rdrtng11=Double.valueOf(rd11);
							rdrtng11=(rdrtng11/kt11);
							rdrtng11=rdrtng11*100;
							osrtng11=Double.valueOf(os11/10);
							osrtng11=osrtng11/kt11;
							osrtng11=osrtng11*100;
							rtng11=rartng11+rdrtng11+osrtng11;
							
							%>
							<tr>
								<td></td><td></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rartng11)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng11)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng11)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rtng11)%></font></div></td>
								
							</tr>
							<%
							
						}
						else
						{
							%>
							<tr>
								<td></td><td></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								
							</tr>
							<%
						}
						kt2=kt-kt11;
						ra2=ra-ra11;
						rd2=rd-rd11;
						os2=os-os11;
						%>
						<tr>
						<td><font size="2">Non-Castrol Fleet</font></td>
						<td align="right"><div align="right"><font size="2"><%=kt2%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=ra2%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=rd2%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=os2%></font></div></td>
						<td align="right"></td>dgrt101_0
						</tr>
						<%
						if(kt2!=0)
						{
							rartng2=Double.valueOf(ra2);
							rartng2=(rartng2/kt2);
							rartng2=rartng2*100;
							rdrtng2=Double.valueOf(rd2);
							rdrtng2=(rdrtng2/kt2);
							rdrtng2=rdrtng2*100;
							osrtng2=Double.valueOf(os2/10);
							osrtng2=osrtng2/kt2;
							osrtng2=osrtng2*100;
							rtng2=rartng2+rdrtng2+osrtng2;
							%>
							<tr>
								<td></td><td></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rartng2)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng2)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng2)%></font></div></td>
								<td align="right"><div align="right"><font size="2"><%=nf.format(rtng2)%></font></div></td>
								
							</tr>
							<%
						}
						else
						{
							%>
							<tr>
								<td></td><td></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
								<td align="right"><div align="right"><font size="2">NA</font></div></td>
							</tr>
							<%
						}
						%>
						</table>
					</td>
					</tr>
					<%
					}
						%>
			<!-- ****************** Code End For KM Count for Fleet And Castrol/Non Castrol**************** -->	
					<tr>
					<td width="50%">
						<table border="1" width="100%" class="stats">
						<tr><th align="center" colspan="2"><font size="2">POLICY VIOLATIONS SUMMARY</font></th></tr>
						<tr>
							<th><font size="2">Policy Violations</font></th>
							<th><font size="2">Trips</font></th>
						</tr>
						<tr>
									<td><font size="2">Night Driving</font></td>
		</font></td>
									<td align="right"><div align="right"><a href="NDAllTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&triptype=<%=thename%>"><font size="2"><%=ndall%></font></div></td>
								</tr>
								<tr>
									<td><font size="2">Continuous Driving</font></td>
									<td align="right"><div align="right"><font size="2"><%=cdall%></font></div></td>
								</tr>
						</table>
						</td>
					
					<td width="50%">
					<table border="1" width="100%" class="stats">
						<tr><th align="center" colspan="2"><font size="2">Driving Hrs VIOLATIONS SUMMARY</font></th></tr>
						<tr>
							<th><font size="2">Violations</font></th>
							<th><font size="2">Counts</font></th>
						</tr>
					<%
						sql12="select count(*) as countdaily from  t_driver_ds where TheDate  between '"+fromdate+"' and '"+todate+"' AND RDurationinHrs >= 12";
						//println(sql);
						ResultSet rst12=sset4.executeQuery(sql12);
						while(rst12.next())
						{
							%>
								<tr>
									<td><font size="2">Daily Driving Hrs</font></td>
									<td align="right"><div align="right"><a href="Drivinghrsviolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=rst12.getInt("countdaily")%></font></a></div></td>
									<!--<td align="right"><div align="right"><font size="2">< %=rst99.getInt("count") %></font></div></td>-->
								
								</tr>
							<%
						}
						String sql13="select count(*) as countweek from  t_driver_ds where TheDate  between '"+fromdate+"' and '"+todate+"' AND Last7DayRDurationinHrs >= 60";
						//println(sql);
						ResultSet rst13=sset4.executeQuery(sql13);
						while(rst13.next())
						{
							%>
								<tr>
									<td><font size="2">Weekly Driving Hrs</font></td>
									<td align="right"><div align="right"><a href="WeeklyDrvnghrsviolation.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=rst13.getInt("countweek")%></font></a></div></td>
									<!--<td align="right"><div align="right"><font size="2">< %=rst999.getInt("count") %></font></div></td>-->
								</tr>
							<%
						}
						%>
						</table>
						</td>
				</tr>
					
			<tr>
				<td colspan="2">
			       		
		    	<table border="1" width="100%" class="stats">
				<tr>
				<th colspan="11" align="center"><font size="2">Driving Hrs Report</font></th>
				</tr>
			  <tr>
			  <td align="center"></td>
			  <td align="center" colspan="3"><font size="2"><b>No.of Castrol Trips</b></font></td>
			    <td align="center" colspan="3"><font size="2"><b>Driving Beyound 10 Hrs.</b></font></td>
			    <td align="center" colspan="3"><font size="2"><b>Driving Beyound 12 Hrs.</b></font></td>
			     <td align="center"></td>
			          	  </tr>
			  <tr>
			        <td><b>Month</b></td>
			        <td><b>Tanker</b></td><td><b>Primary</b></td><td><b>Secondary</b></td>
			       <td><b>Tanker &nbsp;&nbsp; &nbsp;(Violation Count)</b></td><td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
			    <td><b>Tanker &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td><td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
			     <td><b>Repeat Violation</b></td>
			  </tr>
			 
		   	<%
			         
			
		   	
		
			
			
			String set4="select  count(distinct(JCode)) as dgrt10, count(JCode) as dgrt10_0  from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='Tanker' and RDurationinHrs>='10'";
			ResultSet rrset4=sset4.executeQuery(set4);
			while(rrset4.next())
			{
				 dgrt10=rrset4.getInt("dgrt10");
				 dgrt10_0=rrset4.getInt("dgrt10_0");
			}
			
			String set5="select  count(distinct(JCode)) as dgrt101,count(JCode) as dgrt10_1  from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='primary' and RDurationinHrs>='10'";
			ResultSet rrset5=sset5.executeQuery(set5);
			while(rrset5.next())
			{
			 dgrt101=rrset5.getInt("dgrt101");
			 dgrt10_1=rrset5.getInt("dgrt10_1");
				
			}
					
			String set6="select  count(distinct(JCode)) as dgrt102 ,count(JCode) as dgrt10_2   from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='secondary' and RDurationinHrs>='10'";
			ResultSet rrset6=sset6.executeQuery(set6);
			while(rrset6.next())
			{
				 dgrt102=rrset6.getInt("dgrt102");
				 dgrt10_2=rrset6.getInt("dgrt10_2");
			}
			
		
			String set7="select  count(distinct(JCode))  as dgrt12 ,count(JCode) as dgrt12_01   from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='Tanker' and RDurationinHrs>='12'";
			ResultSet rrset7 = sset7.executeQuery(set7);
			while(rrset7.next())
			{
			 dgrt12=rrset7.getInt("dgrt12");
			 dgrt12_01=rrset7.getInt("dgrt12_01");
			}
			
			String set8="select  count(distinct(JCode)) as dgrt12_1,count(JCode) as dgrt12_02    from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='primary' and RDurationinHrs>='12'";
			ResultSet rrset8=sset8.executeQuery(set8);
			while(rrset8.next())
			{
				 dgrt12_1=rrset8.getInt("dgrt12_1");
				 dgrt12_02=rrset8.getInt("dgrt12_02");
			}
			
			
			String set9="select  count(distinct(JCode)) as dgrt12_2,count(JCode) as dgrt12_03   from t_driver_ds where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='secondary' and RDurationinHrs>='12'";
			ResultSet rrset9 =sset9.executeQuery(set9);
			while(rrset9.next())
			{
				 dgrt12_2=rrset9.getInt("dgrt12_2");
				 dgrt12_03=rrset9.getInt("dgrt12_03");
			} 
			%>  
			      <tr>
			     <td><%=new SimpleDateFormat("MMM").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%></td>
			     <td><%=TCApturedTrips %></td>
			     <td><%=PCApturedTrips%></td>  
			     <td><%=SCApturedTrips%></td>
			     
			      <% 
			            if(dgrt10==0)
			            {      %>
			        	       <td>0</td>
			          <% }
			           
			             else
			             { %>	
			     		  
			                    
			                   <td align="right"><div align="right"><%=dgrt10%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Tanker&con=10"><font size="2"><%=dgrt10_0%></font></a>)</div></td>
			       <%    }   
			        
			      
			           if(dgrt101==0)
			              {  %> 
			        	          <td>0</td>
			             <% }
			           else
			          {   
 			              
			        	   %>
			                    <td align="right"><div align="right"><%=dgrt101%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Primary&con=10"><font size="2"><%=dgrt10_1%></font></a>)</div></td>
			       <%  } 
			     
			         if(dgrt102==0)
			         {  %>
			        	    <td>0</td>
			        <%  }
			         else
			           {
			           %>
			             <td align="right"><div align="right"><%=dgrt102%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Secondary&con=10"><font size="2"><%=dgrt10_2%></font></a>)</div></td>
	                 <%  
	                    }
			         
			        if(dgrt12==0)
			        {  %>
			         	<td>0</td>
			        <% }
			    
			        else
			        {
			        %>
 			           <td align="right"><div align="right"><%=dgrt12%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Tanker&con=12"><font size="2"><%=dgrt12_01%></font></a>)</div></td>
	             <%  } 
                  
			        if(dgrt12_1==0)
                     {   %>
                     <td>0</td>
                  <%  } 
                else
                { %>
                <td align="right"><div align="right"><%=dgrt12_1%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Primary&con=12"><font size="2"><%=dgrt12_02%></font></a>)</div></td>
		        <% }        
			    if(dgrt12_2==0)
			    { %>
			    	<td>0</td>
			   <% }
			    else
			    {
			       %>
			    <td align="right"><div align="right"><%=dgrt12_2%>(<a href="Drivinghrsviolation1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>&cg=Secondary&con=12"><font size="2"><%=dgrt12_03%></font></a>)</div></td>
		                  
			  <%  }  
			   
			    
		                     int c2=0,count2=0;
		            vsql2= "select JCode,count(*) as countTrip from t_driver_ds  where TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'  and RDurationinHrs>='10' and  JCode<>'-' group by JCode ";
			           ResultSet vset2=sset11.executeQuery(vsql2); 
			          // System.out.println(vsql);
			          while(vset2.next())
			           {
			        	      countTrip=vset2.getInt("countTrip");  
			        	     
			        	      //System.out.println(countTrip);
					          if(countTrip>1)                
					            {
					        	   c2++;
					        	   count2=count2+vset2.getInt("countTrip");
						             
					            }
			           
			         }  
			           
			           //System.out.println(c);
			           if( c2==0)
			         {%>
			        	 <td>0</td>
			       <%  } 
			         else
			         
			         {
			          %>
			        	 <td align="right"><div align="right"><%=c2%>(<a href="Drivinghrsviolation2.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=count2%></font></a>)</div></td>
			        	
				    <%    }
			                
			        %>
			             
			    
			  
			  
			  
			  
			   </tr>
			  </table> 	
					
	    		</td>
					</tr>		
					
				<tr>
					<td colspan="2">
						<table border="1" width="100%" class="stats">
						<tr>
						<th colspan="17" align="center"><font size="2">CATEGORYWISE REPORT</font></th>
						</tr>
						<tr>
							<th><font size="2">Category</font></th>
							<th><font size="2">Trips by JD</font></th>
							<th><font size="2">Captured Trips</font></th>	
						  	<th><font size="2">Vehicles</font></th>
							<th><font size="2">Drivers</font></th>
							<th><font size="2">Distance</font></th>
							<th><font size="2">RA</font></th>
							<th><font size="2">RD</font></th>
							<th><font size="2">OSDuration</font></th>
							<th><font size="2">ND</font></th>
							<th><font size="2">CD</font></th>
							<th><font size="2">Brief</font></th>
							<th><font size="2">De-Brief</font></th>
							<th><font size="2">Rating</font></th>
							<th><font size="2">AutoClosed</font></th>
							<th><font size="2">ManualClosed</font></th>
							<th><font size="2">OpenTrips</font></th>
							
						</tr>
							<tr>
									<td><font size="2">Primary</font></td>
									<td align="right"><div align="right"><font size="2">-</font></div></td>
									<td align="right"><div align="right"><a href="castrolPrimaryTrips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=PCApturedTrips %></font></a></div></td>
									<td align="right"><div align="right"><font size="2"><%=PVehicles %></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=PDrivers%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=PDistance%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=PRA%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=PRD%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=POSDuration%></font></div></td>
									<td align="right"><div align="right"><a href="NDPrimaryTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=PND%></font></a></div></td>
									<td align="right"><div align="right"><font size="2"><%=PCD%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=PBrief%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=PDeBrief%></font></div></td>
								<%
									if(PDistance!=0)
									{
										PRatings=Double.valueOf(PRA+PRD+(POSDuration/10));
										PRatings=PRatings/PDistance;
										PRatings=PRatings*100;	
									%>
									<td align="right"><div align="right"><font size="2"><%=nf.format(PRatings)%></font></div></td>
									<%
									}
									else
									{
									%>
									<td align="right"><div align="right"><font size="2">NA</font></div></td>
									<%
									}
									
								String sql111="Select EndedBy,TripEndDate,Category from t_CastrolTripsStartEnded where TripStartDate >= '"+fromdate+" 00:00:00' and TripEndDate <= '"+todate+" 23:59:59' and Category='Primary'";
								ResultSet rst111=st1.executeQuery(sql111);
								while(rst111.next())
								{
									//category11=rst111.getString("Category");
									endedby=rst111.getString("EndedBy");
									tripendate=rst111.getString("TripEndDate");
									if(tripendate.equalsIgnoreCase("NA"))
									{
										opentot1++;
									}
									if(endedby.equalsIgnoreCase("-"))
									{
										if(tripendate.equalsIgnoreCase("NA"))
									{
										
									}
									else
									{
										totauto1++;
									}
									}
									else
									{
									if(tripendate.equalsIgnoreCase("NA"))
									{
										
									}
									else
									{
										manualtot1++;
									}	
										
									}
									k++;
								}
									%>
									<%
							if(totauto1>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolPrimaryAuto.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totauto1%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto1%></font></div></td>
								<%
							}
							
							if(manualtot1>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolPrimaryManual.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=manualtot1%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot1%></font></div></td>
								<%
							}
							
							if(opentot1>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolPrimaryOpen.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=opentot1%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot1%></font></div></td>
								<%
							}
							%>
									
								</tr>
								<tr>
									<td><font size="2">Tanker</font></td>
									<td align="right"><div align="right"><font size="2">-</font></div></td>
									<td align="right"><div align="right"><a href="castrolTankerTrips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=TCApturedTrips%></font></a></div></td>
									<td align="right"><div align="right"><font size="2"><%=TVehicles %></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TDrivers %></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TDistance%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TRA%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TRD%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TOSDuration%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TND%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TCD%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TBrief%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=TDeBrief%></font></div></td>
								<%
									if(TDistance!=0)
									{
									TRatings=Double.valueOf(TRA+TRD+(TOSDuration/10));
									TRatings=TRatings/TDistance;
									TRatings=TRatings*100;
									%>
									<td align="right"><div align="right"><font size="2"><%=nf.format(TRatings)%></font></div></td>
									<%
									}
									else
									{
									%>
									<td align="right"><div align="right"><font size="2">NA</font></div></td>
									<%
									}
									String sqltrip11="Select EndedBy,TripEndDate,Category from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Tanker'";
							//System.out.println(sqltrip11);
							ResultSet rsttrip11=st1.executeQuery(sqltrip11);
							while(rsttrip11.next())
							{
								//category12=rsttrip11.getString("Category");
								endedby=rsttrip11.getString("EndedBy");
								tripendate=rsttrip11.getString("TripEndDate");
								if(tripendate.equalsIgnoreCase("NA"))
								{
									opentot2++;
								}
								if(endedby.equalsIgnoreCase("-"))
								{
								if(tripendate.equalsIgnoreCase("NA"))
								{
									
								}	
								else
								{
									totauto2++;
								}
								}
								else
								{
								if(tripendate.equalsIgnoreCase("NA"))
								{
									
								}	
								else
								{
									manualtot2++;
								}	
									
								}
								k++;
							}
							%>
							<%
							if(totauto2>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolTankerAuto.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totauto2%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto2%></font></div></td>
								<%
							}
							
							if(manualtot2>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolTankerManual.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=manualtot2%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot2%></font></div></td>
								<%
							}
							
							if(opentot2>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolTankerOpen.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=opentot2%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot2%></font></div></td>
								<%
							}
							%>
									
								</tr>
								<tr>
									<td><font size="2">Secondary</font></td>
									<td align="right"><div align="right"><font size="2">-</font></div></td>
									<td align="right"><div align="right"><a href="castrolSecondaryTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=SCApturedTrips%></font></a></div></td>
									<td align="right"><div align="right"><font size="2"><%=SVehicles%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SDrivers%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SDistance%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SRA%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SRD%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SOSDuration%></font></div></td>
									<td align="right"><div align="right"><a href="NDSecondaryTrips.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=SND%></font></a></div></td>
									<td align="right"><div align="right"><font size="2"><%=SCD%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SBrief%></font></div></td>
									<td align="right"><div align="right"><font size="2"><%=SDeBrief%></font></div></td>
								<%
									if(SDistance!=0)
									{
										SRatings=Double.valueOf(SRA+SRD+(SOSDuration/10));
										SRatings=SRatings/SDistance;
										SRatings=SRatings*100;
									%>
									<td align="right"><div align="right"><font size="2"><%=nf.format(SRatings)%></font></div></td>
									<%
									}
									else
									{
									%>
									<td align="right"><div align="right"><font size="2">NA</font></div></td>
									<%
									}
									String sqltrip12="Select EndedBy,TripEndDate,Category from t_CastrolTripsStartEnded where TripStartDate>='"+fromdate+" 00:00:00' and TripEndDate<='"+todate+" 23:59:59' and Category='Secondary'";
						ResultSet rsttrip12=st1.executeQuery(sqltrip12);
						while(rsttrip12.next())
						{
							//category13=rsttrip12.getString("Category");
							endedby=rsttrip12.getString("EndedBy");
							tripendate=rsttrip12.getString("TripEndDate");
							if(tripendate.equalsIgnoreCase("NA"))
							{
								opentot3++;
							}
							if(endedby.equalsIgnoreCase("-"))
							{
							if(tripendate.equalsIgnoreCase("NA"))
								{
								}
								else
								{
								totauto3++;	
								}
							}
							else
							{
							if(tripendate.equalsIgnoreCase("NA"))
								{
								}
								else
								{
								manualtot3++;
								}	
								
							}
							k++;
						}
							%>
							<%
							if(totauto3>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolSecondaryAuto.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totauto3%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=totauto3%></font></div></td>
								<%
							}
							
							if(manualtot3>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolSecondaryManual.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=manualtot3%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=manualtot3%></font></div></td>
								<%
							}
							
							if(opentot3>0)
							{
								%>
								<td align="right"><div align="right"><a href="castrolSecondaryOpen.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=opentot3%></font></a></div></td>
								<%
							}
							else
							{
								%>
								<td align="right"><div align="right"><font size="2"><%=opentot3%></font></div></td>
								<%
							}
							%>
									
								</tr>
						<tr>
							<td><font size="2">Total</font></td>
							<%
								int tottrip=PJDTrips+TJDTrips+SJDTrips;
							    int tottrip1=PCApturedTrips+TCApturedTrips+SCApturedTrips;
								int totveh=PVehicles+TVehicles+SVehicles;
								int totdriver=PDrivers+TDrivers+SDrivers;
								int totkm=PDistance+TDistance+SDistance;
								int totRACount=PRA+TRA+SRA;
								int totRDCount=PRD+TRD+SRD;
								int totOSDuration=POSDuration+TOSDuration+SOSDuration;
								int totnd=PND+TND+SND;
								int totcd=PCD+TCD+SCD;
								int totbrief=PBrief+TBrief+SBrief;
								int totdbrief=PDeBrief+TDeBrief+SDeBrief;
								int totopen=opentot1+opentot2+opentot3;
								int totauto=totauto1+totauto2+totauto3;
								int totmanual=manualtot1+manualtot2+manualtot3;
								double totratng=0.0;
							%>
							<td><div align="right"><font size="2"><b>-</b></font></div></td>
							<td><div align="right"><font size="2"><b><%=tottrip1 %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totveh %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totdriver %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totkm %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totRACount %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totRDCount %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totOSDuration %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totnd %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totcd %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totbrief %></b></font></div></td>
							<td><div align="right"><font size="2"><b><%=totdbrief %></b></font></div></td>
							<%
									if(totkm!=0)
									{
									totratng=Double.valueOf(totRACount+totRDCount+(totOSDuration/10));
									totratng=totratng/totkm;
									totratng=totratng*100;
									%>
									<td align="right"><div align="right"><font size="2"><b><%=nf.format(totratng)%></b></font></div></td>
									<%
									}
									else
									{
									%>
									<td align="right"><div align="right"><font size="2"><b>NA</b></font></div></td>
									<%
									}
									%>
									<td><div align="right"><font size="2"><b><%=totauto %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totmanual %></b></font></div></td>
					<td><div align="right"><font size="2"><b><%=totopen %></b></font></div></td>
						</tr>
					</table>
					</td>
					</tr>
				<%
			}
}
else
{
	//println("Hiiiiiiiiiiii");
}
%>
</table>
<%
}catch(Exception e)
{
out.print("Exception -->"+e);
}
finally
{
conn.close();
conn1.close();
}
%>
<%@ include file="footernew.jsp" %>