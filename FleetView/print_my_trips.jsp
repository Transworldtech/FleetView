<%@ include file="headerprintnew.jsp"%>

<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
String filename=session.getAttribute("user").toString();
int cnt= 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_my_report.xls";
}
else
{
	filename = filename=session.getAttribute("user").toString()+"_my_report.xls";
}
//System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
    %>

<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11,stt1,stt2,st12,st13,st14,st15;
String fromdate, tds,todate,sql,sql1,sql2,sql3,transporter,datenew1,datenew2,fromdatetime,todatetime, vendor1,category1,startp,endp,ven,startp1,endp1,vendername,
categoryname,startplacename,endplacename,vehicleno,statusname,Sqlv="";
%>
<%
Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn1.createStatement();
st11=conn.createStatement();
stt1=conn.createStatement();       //  *********************************
stt2=conn.createStatement();
st12=conn.createStatement();
st13=conn.createStatement();
st14=conn.createStatement();
st15=conn.createStatement();
%>

<%
	fromdate=request.getParameter("data1");
	//System.out.println("fromdate==>"+fromdate);
    todate=request.getParameter("data2");
    //System.out.println("todate==>"+todate);
    transporter=request.getParameter("transporter");
    //System.out.println("transporter==>"+transporter);
//	datenew1=request.getParameter("fromdate");
	//datenew2=request.getParameter("todate");
	tds=request.getParameter("tds");
    statusname=request.getParameter("statusp1");
   // System.out.println("statusname==>"+statusname);
   // System.out.println("statusname==>"+tds);
    vendername=request.getParameter("vendor");
    categoryname=request.getParameter("category");
    startplacename=request.getParameter("startp");
    endplacename=request.getParameter("endp");
    /*System.out.println("vendername==>"+vendername);
	System.out.println("categoryname==>"+categoryname);
	System.out.println("startplacename==>"+startplacename);
	System.out.println("endplacename==>"+endplacename);*/
    //out.println(""+fromdate);
%>
<table border="0" width="100%" align="center">
<tr><td align="center" colspan="20">
<div align="left"><font size="3">Report No:9.0</font></div>
<font size="3"><B>My Trips Report</B></font>
</td></tr>

<%
try
{
if(statusname.equalsIgnoreCase("Closed"))
{
	
	if(vendername.equals("ALL") && categoryname.equals("ALL") && startplacename.equals("ALL") && endplacename.equals("ALL"))
	  {
	  
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  order by StartDate ";
	  
	  }
	 //a - - -
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and  TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' order by StartDate ";
	  }
	//- a - -
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' order by StartDate ";
	  }
	//- - a -
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and EndPlace='"+endplacename+"' order by StartDate ";
	  }
	//- - - a
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"'  order by StartDate "; 
	  }
	//- - - -
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by StartDate ";	  
	  }
	//a a - -
	  else  if(vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' order by StartDate ";	  
	  }
	//a a a -
	  else  if(vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays  from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and EndPlace='"+endplacename+"' order by StartDate ";	  
	  }
	//a - a -
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays  from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'    and TripCategory='"+categoryname+"' and EndPlace='"+endplacename+"' order by StartDate ";	  
	  }
	//a - - a
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"'   order by StartDate ";	  
	  }
	//- a a a
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and Vendor='"+vendername+"'  order by StartDate ";	  
	  }
	//- - a a
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and Vendor='"+vendername+"' and TripCategory='"+categoryname+"'  order by StartDate ";	  
	  }
	//- a a -
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and Vendor='"+vendername+"'  and EndPlace='"+endplacename+"' order by StartDate ";	  
	  }
	  //- a - a 
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and Vendor='"+vendername+"'  and StartPlace='"+startplacename+"'  order by StartDate ";	  
	  }
	//a - a a 
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,NDCount,DisconnectionCount,DateDIFF(EndDate,StartDate) as noofdays from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and TripCategory='"+categoryname+"'  order by StartDate ";	  
	  }

%>


<tr><td align="center" colspan="20">
<font  size="3"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font>
</td>
</tr>
</table>

<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>Trip ID</th>
<th>Driver</th>
<th>Veh.</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th> Desc</th>
<th> Model</th>
<th>Type</th>
<% 
		}%>
<th>Owner</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Weight Kg</th>
<th>Freight Rs</th>
<th>Advance Rs</th>
<% 
		}%>
<th>Vendor</th>
<th>Category</th>
<th>Origin</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Report DateTime</th>
<% 
		}%>
<th>Start Date Time</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Load Delay (hh:mm:ss)</th>
<th>Ld Delay Rsn</th>
<th>Load Comments</th>
<% 
		}%>
<th>Destination</th>
<th>End Date Time</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Unload Date Time</th>
<th>Unload Delay (hh:mm:ss)</th>
<th>Unld Delay Rsn</th>
<th>Unload Comments</th>
<% 
		}%>
<th>Fixed Distance</th>
<th>Fixed Time</th>
<th>KM Traveled</th>
<th>Trip Days</th>
<th>Trip Time</th>
<th>Run Hrs</th>
<th>Avg hrs/day</th>
<th>Run Hr Violation</th>
<th>OSCount</th>
<th>OSDuration</th>
<th>OS(sec) in Red Zone</th>
<th>OS(sec) in Yellow Zone</th>
<th>OS(sec) in Green Zone</th>
<th>RACount</th>
<th>RDCount</th>
<th>Trip Rating</th>
<th>ND</th>
<th>ND Distance</th>
<th>ND Duration</th>
<th>Disconnection</th>
<th>Disconnection Km</th>
<th>Closed By</th>
</tr>
<%


//System.out.println("Our exact query>>>>"+Sqlv); 
ResultSet rstcloser=st15.executeQuery(Sqlv);
//result set from Veh Details
int i=0,dist1,dist2;
java.util.Date enddte1,strdte1;
String fromdate1="",todate1="";
double stdDist=0,stdTme=0,capDist=0;
String SDate,EDate,STime,ETime,tripid,StDate,EdDate;
long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0,etime;
String fromdate="",todate="";
String ftime1="00";
String ftime2="00";
String ttime1="00";
String ttime2="00";
int noofdays=0;

String vehdesc="-",vehmodel="-",vehtype="-",tripcat="-",adv="-",freight="-",loadrsn="-",loadcmt="-",endedby="-",weight="-",vendor="-",reptdttme="-",unloadcmt="-",unloadrsn="-";
String sdate,edate,LoadingDelay,UnloadingDelay;
int KmTravelled=0;

while(rstcloser.next())
{
//StDate=rstcloser.getDate("StartDate");
i++;

SDate=rstcloser.getString("StartDate");
EDate=rstcloser.getString("EndDate");
STime=rstcloser.getString("StartTime");
ETime=rstcloser.getString("EndTime");
tripid=rstcloser.getString("TripId");
KmTravelled=rstcloser.getInt("KmTravelled");
noofdays=rstcloser.getInt("noofdays")+1;

LoadingDelay=rstcloser.getString("LoadingDelay");
if(LoadingDelay==null || LoadingDelay.equalsIgnoreCase("null"))
{
LoadingDelay="-";
}
UnloadingDelay=rstcloser.getString("UnloadingDelay");
if(UnloadingDelay==null || UnloadingDelay.equalsIgnoreCase("null"))
{
UnloadingDelay="-";
}
unloadcmt=rstcloser.getString("Unloadingcomments");
if(unloadcmt==null || unloadcmt.equalsIgnoreCase("null"))
{
unloadcmt="-";
}
unloadrsn=rstcloser.getString("DelayReason");
if(unloadrsn==null || unloadrsn.equalsIgnoreCase("null"))
{
unloadrsn="-";
}

if(null==STime || STime.length()>8 || STime.equals("-"))
{
STime="00:00:00";
}

if(null==ETime || ETime.equals("-"))
{
ETime="23:59:59";
}

/*#################################change#############################*/

/*=====================================================
parameters passed to show_custom_detail_rept_onMap.jsp
start date
Start time-> Hrs mins separate
end date
end time-> hrs mins separate
==============================================*/
sdate=SDate;
//System.out.println("sdate  "+sdate);
try
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
}
catch(Exception e)
{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
}
// System.out.println("StartDate--->>"+fromdate);
try
{
java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
ftime1=""+dt.getHours();
ftime2=""+dt.getMinutes();
}
catch(Exception e)
{
	ftime1="00";
	ftime1="00";
}

edate=EDate;
//System.out.println("edate  "+edate);
try
{
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
}
catch(Exception e)
{
	 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
}
try
{
java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
ttime1=""+edt.getHours();
ttime2=""+edt.getMinutes();
}
catch(Exception e)
{
	ttime1="23";
 	ttime2="59";
}
/*#################################change#############################*/

try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00

miliseconds1=fd.getTime();

}catch(Exception e1)
{
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
miliseconds1=fd.getTime();

}catch(Exception e4)
{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
miliseconds1=fd.getTime();

}
}
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
miliseconds2=fd1.getTime();
}catch(Exception e2)
{
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
miliseconds2=fd1.getTime();

}catch(Exception e5)
{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
miliseconds2=fd1.getTime();
}
}

try{
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
    fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
 
}catch(Exception e)
{
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
	fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
	
}
try{
	
		todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
		todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));

}catch(Exception e)
{
	todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
	todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));

}


%>
<tr>

<td style="text-align: right"><%=i%></td>

<td style="text-align: right"><div align="right"  >
<%=rstcloser.getString("TripId")%></td>

<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>

<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>

<%
String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"'";
ResultSet rst3=stt2.executeQuery(sql3);
//System.out.println("veh desc"+sql3);
if(rst3.next())
{

vehdesc=rst3.getString("VehDesc");

if(vehdesc==null || vehdesc.equalsIgnoreCase("null"))
{
vehdesc="-";
}
vehmodel=rst3.getString("VehModel");
if(vehmodel==null || vehmodel.equalsIgnoreCase("null"))
{
vehmodel="-";
}
vehtype=rst3.getString("VehType1");
if(vehtype==null || vehtype.equalsIgnoreCase("null"))
{
vehtype="-";
}
}
else
{
vehdesc="-";
vehmodel="-";
vehtype="-";
}

if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=vehdesc%></td>
<td><%=vehmodel%></td>
<td><%=vehtype%></td>
<% 
}
	%>
<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>

<%

String sql="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,Loadreason,Loadcomments,TripCategory,FIxedKM,FIxedTime from t_startedjourney where tripid='"+tripid+"'";
//System.out.println(sql);
ResultSet rss=st2.executeQuery(sql);
if(rss.next())
{
stdDist=rss.getDouble("FIxedKM");
stdTme=rss.getDouble("FIxedTime"); 
endedby=rss.getString("EndedBy");
weight=rss.getString("Weight");
if(weight==null || weight.equalsIgnoreCase("null"))
{
	 weight="-";
}
vendor=rss.getString("Vendor");

if(vendor.equalsIgnoreCase("select") || vendor==null || vendor.equalsIgnoreCase("null"))
{
	 vendor="-";
}
tripcat =rss.getString("TripCategory");
if(tripcat.equalsIgnoreCase("select") || tripcat==null || tripcat.equalsIgnoreCase("null"))
{
	 tripcat="-";
}
freight =rss.getString("Frieght");
if(freight==null || freight.equalsIgnoreCase("null"))
{
	 freight="-";
}
adv =rss.getString("Advance");
if(adv==null || adv.equalsIgnoreCase("null"))
{
	 adv="-";
}
try
{
	 //out.println(i);
	 reptdttme=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rss.getString("ReportDateTime")));
	 	 
}catch(Exception ss)
{
	 reptdttme=rss.getString("ReportDateTime");
}
if(reptdttme==null || reptdttme.equalsIgnoreCase("null"))
{
	 reptdttme="-";
}
if(loadrsn==null || loadrsn.equalsIgnoreCase("null"))
{
	 loadrsn="-";
}

if(loadcmt==null || loadcmt.equalsIgnoreCase("null"))
{
	 loadcmt="-";
}	 

}
else
{
endedby="-";
weight="-";
vendor="-";
reptdttme="-";
tripcat="-";
freight="-";
adv="-";
loadcmt="-";
loadrsn="-";
} //out.println("Mila");

if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=weight%></td>
<td><%=freight%></td>
<td><%=adv%></td>
<% 

}
	%>
<td><%=vendor%></td>
<td><%=tripcat%></td>
<td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td style="text-align: right"><%=reptdttme%></td>
<% 
}
%>
<td style="text-align: right">
<% 
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"))));
}catch(Exception ee)
{
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+"<br>"+STime);
}
%>
</td>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=LoadingDelay%></td>
<td><%=loadrsn%></td>
<td><%=loadcmt%></td>
<% 
}	%>
<td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
<td style="text-align: right"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
}catch(Exception ee)
{
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
}
%>
</td>
<%
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td style="text-align: right"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
}catch(Exception ee)
{
out.print("-");
}
%>
</td>
<td><%=UnloadingDelay%></td>
<td><%=unloadrsn%></td>
<td><%=unloadcmt%></td>
<% 

}
//*********************************************query is changed*****************************************************
sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rstcloser.getString("StartPlace")+"' and EndPlace = '"+rstcloser.getString("EndPlace")+"' || StartPlace ='"+rstcloser.getString("EndPlace")+"' and EndPlace = '"+rstcloser.getString("StartPlace")+"'";
ResultSet rstdist=st1.executeQuery(sql);
if(stdDist==0 && stdTme==0)
if(rstdist.next())
{ 
	stdDist=rstdist.getDouble("Km");
	stdTme=rstdist.getDouble("TTime");
}
//else
//{
	//stdDist=0;
	//stdTme=0;
//}


if(stdDist==0 && stdTme==0)
{
	%>
	<td style="text-align: right">NA</td>
	<td style="text-align: right">NA</td>
	<%
}
else
{
	%>
	<td style="text-align: right"><%=stdDist%></td>
	<td style="text-align: right"><%=stdTme%></td>
	<%
}
%>
<td style="text-align: right"><%=KmTravelled%></td>
<!--<td style="text-align: right">
<%
//***************************************************************************************************************
int dist;
dist=0; dist1=0; dist2=0;

%> 
</td>--> 
<td style="text-align: right;"><%=noofdays %></td>
<td style="text-align: right">
<%
try{

	try{
		enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"));
	}
	catch(Exception e)
	{
		enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate"));
	}

	
	
/* 	Check the difference between two date time Date */
long hrs,mins;
double hrslong=0.00;
java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
long x=enddte11.getMinutes();
long y=strdte11.getMinutes();




long timediff=enddte11.getTime()-strdte11.getTime();//msec

//hrslong=timediff/1000/60/60;

long mins11=timediff/1000/60;

if(mins11>=60)
{
	hrdiff=mins11/60;//2

	if((y>x)&&(x!=0))
	{
	mins=y-x;
	mins=60-mins;
	out.print(hrdiff+"hrs"+mins+"mins");
	}
	else if((x>y)&&(y!=0))
	{
		mins=x-y;
		
		out.print(hrdiff+"hrs"+mins+"mins");
		
	}else if(x==y)
	{
		mins=x-y;
	
		out.print(hrdiff+"hrs"+mins+"mins");
	}
	
	 else if((x==0)&&(y>x))
 {
	 mins=60-y;
	 out.print(hrdiff+"hrs"+mins+"mins");
 }else if(y==0)
 {
	 mins=x+y;
	 out.print(hrdiff+"hrs"+mins+"mins");
 }
}
else
{
	hrdiff=0;
	mins=mins11;
	out.print(hrdiff+" hrs "+mins+" mins");
}
String enddte=enddte1+" "+ETime;

String strtdte=strdte1+" "+STime;

long tmeinmils=enddte1.getTime()-strdte1.getTime();
//out.println(""+enddte1.getTime());
long hours=tmeinmils/(1000*60*60);

String extractstrtminutes=STime.substring(3,5);
String extractendminutes=ETime.substring(3,5);
//out.print(""+ETime);
int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);

if(totmins >= 60)
{
hrdiff=hrdiff+1;
totmins=totmins-60;
}
}
catch(Exception e)
{
	
	//out.print("-");
}


%>


</td>
<%
String date1="",date2="";
double runhrs=00.00;
double avgrunhrs=00.00;
int k=0;
try
{
date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}
catch(Exception e)
{
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));
	k=1;
}
String vehid=rstcloser.getString("Vehid");
String sql5="Select SUM(RDurationinHrs) as runhrs from db_gpsExceptions.t_veh"+vehid+"_ds where TheDate>='"+date1+"' and TheDate<='"+date2+"'";
if(i==52)
{
System.out.println("######       "+sql5);
}
ResultSet rs=st3.executeQuery(sql5);
if(rs.next())
{
      if(null==rs.getString("runhrs") || rs.getString("runhrs").equalsIgnoreCase("null"))
     {
     	runhrs=00.00;
      }
else
{
	runhrs=rs.getDouble("runhrs");
}
}
avgrunhrs=runhrs/noofdays;

int j=0;
sql5="Select RDurationinHrs  from db_gpsExceptions.t_veh"+vehid+"_ds where TheDate>='"+date1+"'and TheDate<='"+date2+"'";
if(i==52)
{
System.out.println("&&&&&&       "+sql5);
}
rs=st3.executeQuery(sql5);
while(rs.next())
{
	if(rs.getDouble("RDurationinHrs")>10.00)
	{
		j++;
	}
}
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);

//int TripRating=
%>
<td style="text-align: right"><%=nf1.format(runhrs)%></td>
<td style="text-align: right"><%=nf1.format(avgrunhrs)%></td>
<td style="text-align: right"><%=j%></td>
<td style="text-align: right"><%=rstcloser.getInt("OSCount")%></td>
<td style="text-align: right"><%=rstcloser.getDouble("OSDuration")%></td>
<td style="text-align: right"><%=rstcloser.getDouble("OSDurationInRedZone")%></td>
<td style="text-align: right"><%=rstcloser.getDouble("OSDurationInYellowZone")%></td>
<td style="text-align: right"><%=rstcloser.getDouble("OSDurationInGreenZone")%></td>
<td style="text-align: right"><%=rstcloser.getInt("RACount")%></td>
<td style="text-align: right"><%=rstcloser.getInt("RDCount")%></td>

<td style="text-align: right"><%=nf1.format(rstcloser.getInt("TripRating"))%></td>
<td style="text-align: right">
<%
if(rstcloser.getInt("NDCount")>0)
{
	 
	%>
	
	<%=rstcloser.getInt("NDCount")%> <%
}
else{
	%>
	<%=rstcloser.getInt("NDCount")%>
	<%
}
%>
</td>
<%
int d=0;
String ndduration="";

if(k==1)
{
	sql5="select Distance,Sec_to_Time(Sum(Time_to_Sec(Duration))) from db_gpsExceptions.t_veh"+vehid+"_nd where FromDate >= '"+date1+"' and FromDate<='"+date2+"'";
}
else
{
   sql5="select SUM(Distance) as distance,Sec_to_Time(Sum(Time_to_Sec(Duration))) as duration from db_gpsExceptions.t_veh"+vehid+"_nd where concat(FromDate,' ',FromTime) >= '"+date1+"' and concat(FromDate,' ',FromTime)<='"+date2+"'";
}
try{
	//System.out.println(sql5);
rs=st3.executeQuery(sql5);
if(rs.next())
{
	d=rs.getInt("distance");
	ndduration=rs.getString("duration");
	
}
}
catch(Exception e)
{
	System.out.println("Exception      "+e);
}
if(ndduration==null || ndduration.equalsIgnoreCase("null"))
{
	ndduration="-";
}
else
{
	ndduration=new SimpleDateFormat("HH:mm").format( new SimpleDateFormat("HH:mm:ss"). parse(ndduration));
}
%>
<td style="text-align: right"><%=d %></td>
<td style="text-align: right"><%=ndduration%></td>
<td style="text-align: right">
<%
int discount=0, diskm=0;
String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rstcloser.getString("vehid")+"' and  OffTimeFrom >='"+rstcloser.getString("Startdate")+"'and  OffTimeTo<='"+rstcloser.getString("Enddate")+"' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30' ";
ResultSet rstdis=st2.executeQuery(sqldis);
if(rstdis.next())
{
	if(rstdis.getInt("cnt")>0)
	{
		
	      
		discount=rstdis.getInt("cnt");
		diskm=rstdis.getInt("distance");
		%>
		
		 <%=discount%>
	<%
	}
	else{
		
		out.print("0");
	}

}
else{
	out.print("0");
}

%>

</td>
<td style="text-align: right">
<%
if(discount>0){
	%>
	<%=diskm %>
	<%
	}
else{
	out.print(0);
	}
%>
</td>
<%


sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
//System.out.println(sql);
rss=st2.executeQuery(sql);
if(rss.next())
{
	  endedby=rss.getString("EndedBy");
} 
	 %>
	  <td style="text-align: left">  
	 <%
	if(endedby.equals("-") || endedby.equals(""))
	{
		out.print("Auto Closed");
	}
	else
	{
		out.print(endedby);
	}
	 %>
	 
	 </td>

</tr> 

<%

}
%>
<input type="hidden" name="cnt" id="cnt" value="<%=i%>">
<% 
}

else if(statusname.equalsIgnoreCase("Open"))
{
	double totKm=0,remKm=0;
	Statement st4, sttemp,stopen,stveh;
	String sql, sql1, sql2,sql3,sqlopen,sqlveh;
	ResultSet rs2=null;
	//String sttdate="";
	String vehdesc1="-",bgcolor1="",comments="-",bgcolor2="",temptime="",vehmodel1="-",vehtype1="-",tripcat1="-",adv1="-",freight1="-",endedby1="-",weight1="-",vendor11="-",reptdttme1="-",tripid1="";
	String gpname1="",ETA1="",today="",lastweek="", sdate="",edate="",lastmonth="",startDate="",startCode="",startTime="",endCode="",TransTime="",updatedTm="",scheTmDt="",updtetime="",DisDate="",ETADate="";
	int km1=0,km2=0,km3=0,km4=0,km5=0,km6=0,km7=0,km8=0,km9=0, kmrun1=0, kmrun2=0, kmrundist=0,todaysdist=0;
	long diffDays=0,tTime=0;
	java.util.Date dt1 = null;
String ftime1="00";
String ftime2="00";
String ttime1="00";
String ttime2="00";
String sttdate="";
//String tempUpDate;
String dateformat="dd-MMM-yyy";
		dateformat=session.getAttribute("dateformat").toString();
		//System.out.println("======1========");
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String currenttime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
	st4=conn.createStatement();
	stveh=conn.createStatement();
	stopen=conn.createStatement();
%>
	</td>
	</tr>
	<table border="0" width="100%" align="center">
<tr align="center"><td>
<font  size="3"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font>
</tr>
</table>
	</table>
	<table border="1" class="sortable" width="100%">
	<tr>
	<th  class="hed" id="srcol" valign="top"> <B>Sr No</B></th>
	<th  class="hed" id="vehcol" valign="top"> <B>Vehicle</B></th> 
	<th  class="hed" id="srcol" valign="top"> Desc</th>
	<th class="hed" id="srcol" valign="top"> Model</th>
	<th  class="hed" id="srcol" valign="top">Type</th>
	<th class="hed" id="srcol" valign="top">Owner</th>
	<th class="hed" id="tripcol" valign="top">  <B> TripID</B></th>
	<th class="hed" id="updtetmecol" valign="top">  <B>Updated Dat-Time</B></th>
	<th class="hed" id="curposcol" valign="top">  <B>Current Position</B></th>
	<th class="hed" id="drivcol" valign="top">   <B> Driver</B></th>
	<th class="hed" id="stplacecol" valign="top">  <B> Start Place</B></th>
	<th class="hed" id="stdatecol" valign="top">   <B>Start Date-Time</B></th>
	<th class="hed" id="endplacecol" valign="top">   <B> End Place</B></th>
	<th class="hed" id="FixedTimecol" valign="top">  <B>FixedTime</B></th>
	<th class="hed" id="FixedKmcol" valign="top">  <B>FixedKm</B></th>
  	<!--<th class="hed" id="kmsruncol" valign="top"> <a href="#" onClick="hide('kmsrun');" title="Click to hide KmsToRun,ETA Cols"> <img src="images/sub.jpg" id="img2" width="13px" height="10px" border="0"></a> <br><B>Kms run</B></th>-->
  	<th class="hed" id="kmsruncol" valign="top"><B>Kms run</B></th>
 	<th class="hed" id="kmstoruncol" valign="top">  <B>Kms to run</B></th>  
	<th class="hed" id="etacol" valign="top">   <B>ETA</B></th>
	<th class="hed" id="srcol" valign="top">Weight Kg</th>
	<th class="hed" id="srcol" valign="top" >Freight Rs</th>
	<th class="hed" id="srcol" valign="top" >Advance Rs</th>
	<th class="hed" id="srcol" valign="top">Vendor</th>
	<th class="hed" id="srcol" valign="top">Category</th>
	<th class="hed" id="srcol" valign="top">Comments</th>
	
	</tr>	
	</tr>
	<%
	//sql="select * from t_startedjourney where Jstatus='Running' and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
	//sql="select * from t_startedjourney where Jstatus in('Running','tobeclosed') and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
	
	
	//sql="select * from t_startedjourney where Jstatus in('Running','tobeclosed') and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
	sql="select * from t_startedjourney where Jstatus in('Running','tobeclosed') and Vehid in"+session.getAttribute("VehList").toString()+"AND  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by StartDate desc";
   
	ResultSet rsttrips=st.executeQuery(sql);
	int j=1;
	while(rsttrips.next())
	{
		comments=rsttrips.getString("Loadcomments");
		
		  totKm=rsttrips.getDouble("FIxedKM");
	      tTime=rsttrips.getLong("FIxedTime"); 
	     // gpname1=rsttrips.getString("GPName");
	     ETA1=rsttrips.getString("ETA");
	      ETADate=ETA1;
	      System.out.println("\n\n ETA from table-->>"+ETA1);
	      if(!(null==ETA1))
	      {
	       ETA1=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA1));
	      }
	       System.out.println("\n\n\n\nETA is ...>>>>"+ETA1); 
	     
	      System.out.println("\n\n\n\nfrom started journey...>>>>"+totKm+"\t\t"+tTime);
	      System.out.println("\n\n\n");
	      String curpos="",  lat="", lon="";
		kmrundist=0;
		kmrun1=0;kmrun2=0;
		String vehno=rsttrips.getString("VehRegNo");
		sql="select * from t_onlinedata where VehicleCode='"+rsttrips.getString("VehId")+"'";
		//out.print(sql);
		ResultSet rs1=st1.executeQuery(sql);
		
		try{
			if(rs1.next())
			{
				curpos=rs1.getString("Location");
				System.out.println("\n\ndate-->>"+rs1.getString("TheDate")+" "+rs1.getString("TheTime"));
			   temptime=rs1.getString("TheTime");
				//System.out.println("\n\ntime-->>"+);
				updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))+" "+rs1.getString("TheTime");
				//updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")));
				lat=rs1.getString("LatitudePosition");
				lon=rs1.getString("LongitudePosition");
			}
			// tempUpDate=updtetime;
			
		  }catch(Exception exc)
		  {
				//System.out.print("--i am in exception 5==");
				exc.printStackTrace();
	      }
		
		try{
				//sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime asc limit 1";
				//out.println("\nsql ==6==="+sql);
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDateTime between '"+rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")+"' AND '"+today+" "+currenttime+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime asc limit 1";
				ResultSet rstkmrun1=st1.executeQuery(sql);
				if(rstkmrun1.next())
				{
					kmrun1=rstkmrun1.getInt("Distance");
				}
		  }catch(Exception e)
			{
				//System.out.println("---I am in exception--rstkmrun1-");
				e.printStackTrace();
			}

		  try{
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDateTime between '"+rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")+"' AND '"+today+" "+currenttime+"' and TheFiledTextFileName='SI' order by TheFieldDataDateTime desc limit 1";
				//out.print("sql ====7===="+sql);
				ResultSet rstkmrun2=st1.executeQuery(sql);
			if(rstkmrun2.next())
			{
				kmrun2=rstkmrun2.getInt("Distance");
				//out.println("kmrun2----->"+kmrun2);
			}
		}catch(Exception e1)
		{
			//System.out.println("---I am in exception--rstkmrun2-");
			e1.printStackTrace();
		}
		
	try{
		long myMilisec;
		//tTime=0;
		//sql="select sum(Distance) as kmrundist from t_veh"+rsttrips.getString("VehId")+"_ds where TheDate>='"+rsttrips.getDate("StartDate")+"'and TheTime>='"+rsttrips.getTime("StartTime")+"' and startCode>='"+rsttrips.getString("StartCode")+"' and endCode>='"+rsttrips.getString("EndCode")+"' ";
		sql="select * from db_gps.t_startedjourney where StartDate='"+rsttrips.getDate("StartDate")+"'and StartTime='"+rsttrips.getTime("StartTime")+"' and StartCode='"+rsttrips.getString("StartCode")+"' and EndCode='"+rsttrips.getString("EndCode")+"' and Vehid="+rsttrips.getString("VehId")+"";
		///System.out.println(":::---SQL----:::"+sql);
		ResultSet rstTotKm=st3.executeQuery(sql);
		if(rstTotKm.next())
		{
			sql3="select * from db_gps.t_castrolroutes where StartPlace = '"+rsttrips.getString("StartPlace")+"' and EndPlace = '"+rsttrips.getString("EndPlace")+"' || EndPlace = '"+rsttrips.getString("StartPlace")+"' and StartPlace = '"+rsttrips.getString("EndPlace")+"' limit 1 ";
			//System.out.println(":::---SQL2----:::"+sql3);
			ResultSet rst123=st4.executeQuery(sql3);
			if(totKm==0 && tTime==0 )
			if(rst123.next())
				{
					totKm=rst123.getDouble("Km");
				    tTime=rst123.getLong("TTime");
				}
		}
		kmrundist=kmrun2-kmrun1;  //Finding tot run km by vehicle after trip started.
		remKm=totKm-kmrundist;  // Adding todays km also
		
		myMilisec=(tTime*60*60*1000);
		if(!(null==ETADate))
		{
			ETADate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETADate));	 
			 DisDate=ETADate;
				System.out.println(":::::-startDtTmAftAdd- ETA::::"+ETADate);
		}
		else
		{
		if(myMilisec!=0)
		{
		//System.out.println(":::::-myMilisec-::::"+myMilisec);
      	java.util.Date resultdate = new java.util.Date();
      	//java.util.Date startDtTm=rsttrips.getDate("StartDate");
       	 SimpleDateFormat sdftimemilli = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      	Date startDtTm = sdftimemilli.parse(rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")); 
     
		//System.out.println(":::::-startDtTmOriginal-::::"+startDtTm);
		long start=startDtTm.getTime();
		long totdate= start+myMilisec;
		resultdate.setTime(totdate);
        DisDate=new SimpleDateFormat(dateformat+" HH:mm:ss").format(resultdate);
		System.out.println(":::::-startDtTmAftAdd-::::"+DisDate);
		}
		else{
			DisDate="NA";
		}
		}
	}catch(Exception e11)
	{
		System.out.println("---I am in exception--kmrundist-");
		e11.printStackTrace();
	}
	sdate= rsttrips.getString("Startdate");
	try
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));	
	}
	catch(Exception e)
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
	}
	try
	{
	java.util.Date sdt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
	ftime1="00";
	ftime2="00";
	}
	catch(Exception e)
  	{
  		ftime1="00";
  		ftime1="00";
  	}
	
	 edate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	 try
	 {
		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));	 
	 }
	 catch(Exception e)
	 {
		 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate)); 
	 }
//	 System.out.println("endDate--->>"+todate);
try
{
	 java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
	 ttime1=""+edt.getHours();
	 ttime2=""+edt.getMinutes();
}
catch(Exception e)
	{
		ttime1="23";
	 	ttime2="59";
	}
System.out.println("\n update date-->>"+updtetime);
System.out.println("\n arrive date-->>"+DisDate);
if(updtetime.equalsIgnoreCase("NA") || DisDate.equalsIgnoreCase("NA"))
{
	System.out.println("\n\n in NA");

	bgcolor1="";
	bgcolor2="";
}
else
{
	
	try{
		sttdate= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate")));
	}catch(Exception ee)
	{
		sttdate= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrips.getString("StartDate")))+" "+rsttrips.getString("StartTime");
		//out.print("-");
	}	
	

 SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
 Date date1 = sdf1.parse(updtetime);
 Date date2 = sdf1.parse(sttdate);
 Date date3 = sdf1.parse(DisDate);
 System.out.println("\n===updated-->> "+sdf1.format(date1));
 System.out.println("\n===start-->>"+sdf1.format(date2));
 System.out.println("\n===Arrival-->>"+sdf1.format(date2));
 float timdiff=0,avg;
 long msec = date1.getTime() - date2.getTime();
 timdiff=(float)(msec / 1000 / 60/ 60);

 avg=(kmrundist/timdiff);

System.out.println("\n\n time diiff in msec.-->>"+msec);
System.out.println("\n\n time diiff in hours.-->>"+timdiff);
System.out.println("\n\n avg speed.-->>"+avg);

if(date1.compareTo(date3)>0){
	System.out.println("\nupdated date  is greater than arrivel date");
	bgcolor1="#B0E0FC";
	bgcolor2="B0E0FC";
	
}else 
{
	if(avg<=10)
{
	System.out.println("\nin less than 10");
	bgcolor1="#FD9970";
	bgcolor2="FD9970";
}else if(avg>10 && avg<=12)
{
	bgcolor1="#F4CB46";
	bgcolor2="F4CB46";
}else if(avg>12 && avg<=14.5)
{
	bgcolor1="#FFFED3";
	bgcolor2="FFFED3";
}else if(avg>14.5)
{
	bgcolor1="#A9F5A9";
	bgcolor2="A9F5A9";
	System.out.println("\n\n\n\n green-->>");
}
}
}

	



//		System.out.println("StartDate--->>"+fromdate+" "+ftime1+ftime2);
//		System.out.println("endDate--->>"+todate+" "+ttime1+ttime2);
		
	%>
	<%
	System.out.println("\n\n color value-->>"+request.getParameter("colorvalue"));
	System.out.println("\n\n bgcolor value-->>"+bgcolor2);
	if("all".equals(request.getParameter("colorvalue")))
	{
	%>
	<td><div align="right" ><%=j%></td>
	
<td WIDTH="6%" ><div align="right" >
<font size="2">

<%=rsttrips.getString("VehRegNo")%>
</div></td>
<%
sqlveh="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rsttrips.getString("VehRegNo")+"'";
ResultSet rstveh=stveh.executeQuery(sqlveh);
//System.out.println("veh desc"+sqlveh);
if(rstveh.next())
{

vehdesc1=rstveh.getString("VehDesc");

if(vehdesc1==null || vehdesc1.equalsIgnoreCase("null"))
{
	vehdesc1="-";
}
vehmodel1=rstveh.getString("VehModel");
if(vehmodel1==null || vehmodel1.equalsIgnoreCase("null"))
{
	vehmodel1="-";
}
vehtype1=rstveh.getString("VehType1");
if(vehtype1==null || vehtype1.equalsIgnoreCase("null"))
{
	vehtype1="-";
}
}
else
{
	vehdesc1="-";
	vehmodel1="-";
	vehtype1="-";
}

%>

<td><%=vehdesc1%></td>
<td><%=vehmodel1%></td>
<td><%=vehtype1%></td>
<td style="text-align: left"><%=rsttrips.getString("OwnerName")%></td>


<td WIDTH="6%" ><div align="right" >
<font size="2">
<%=rsttrips.getString("TripId")%>
</div></td>
	<td id="updtetmecol<%=j%>"><div align="left"><%=updtetime%> </div></td>
	<td WIDTH="8%" id="curposcol<%=j%>"><div align="left"> 
	
	<%=curpos%> </div></td>
	
	<td id="drivcol<%=j%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
	<td id="stplacecol<%=j%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
	<td id="stdatecol<%=j%>" style="text-align: left">
	<% try{
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate"))));
	}catch(Exception ee)
	{
		out.print(new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrips.getString("StartDate"))));
		out.print(rsttrips.getString("StartTime"));
		//out.print("-");
	}
	%></td>
	
	<td id="endplacecol<%=j%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
	
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
	
			if(totKm==0 && totKm==0){
			%>
	               <td ><div align="left">NA</div></td>
	               <td ><div align="left">NA</div></td>
			
				
			<%
		}
		}
		else
		{
			%>
				<td id="FixedTimecol<%=j%>">  <%=tTime%></td>
				<td id="FixedKmcol<%=j%>"> <%=totKm %></td>
				
			<%
		}
	
	%>
	
	<td id="kmsruncol<%=j%>"> <div align="left"><%=kmrundist%></div></td>  
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			if(totKm==0 && totKm==0){
			%>
				
				<td ><div align="left">NA</div></td>
			<%
		}
		}
		else
		{
			%>
				
				<td id="kmstoruncol<%=j%>"><div align="left"><%=remKm%></div></td>
			<%
		}
	
	%>
 	
	<td id="etacol<%=j%>"><div align="left"><%=DisDate%> </div></td>
	<%
sqlopen="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,TripCategory from t_startedjourney where tripid='"+rsttrips.getString("Tripid")+"'";
//System.out.println(sql);
ResultSet rssopen=stopen.executeQuery(sqlopen);
if(rssopen.next())
{

	endedby1=rssopen.getString("EndedBy");
	 weight1=rssopen.getString("Weight");
	 if(weight1==null || weight1.equalsIgnoreCase("null"))
	 {
		 weight1="-";
	 }
	 vendor11=rssopen.getString("Vendor");
	 
	 if(vendor11.equalsIgnoreCase("select") || vendor11==null || vendor11.equalsIgnoreCase("null"))
	 {
		 vendor11="-";
	 }
	 tripcat1 =rssopen.getString("TripCategory");
	 if(tripcat1.equalsIgnoreCase("select") || tripcat1==null || tripcat1.equalsIgnoreCase("null"))
	 {
		 tripcat1="-";
	 }
	 freight1 =rssopen.getString("Frieght");
	 if(freight1==null || freight1.equalsIgnoreCase("null"))
	 {
		 freight1="-";
	 }
	 adv1 =rssopen.getString("Advance");
	 if(adv1==null || adv1.equalsIgnoreCase("null"))
	 {
		 adv1="-";
	 }

}
else
{
	 endedby1="-";
	 weight1="-";
	 vendor11="-";
	 tripcat1="-";
	 freight1="-";
	 adv1="-";
	
} //out.println("Mila");

%>
 <td><%=weight1%></td>
 <td><%=freight1%></td>
 <td><%=adv1%></td>
 <td><%=vendor11%></td>
 <td><%=tripcat1%></td>
 <td><%=comments%></td>
	</tr>
	<%
	}
	else if(bgcolor2.equals(request.getParameter("colorvalue")))
	{
		%>
		<td><div align="right" ><%=j%></td>
		
	<td WIDTH="6%" ><div align="right" >
	<font size="2">

	<%=rsttrips.getString("VehRegNo")%>
	</div></td>
	<%
	sqlveh="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rsttrips.getString("VehRegNo")+"'";
	ResultSet rstveh=stveh.executeQuery(sqlveh);
	//System.out.println("veh desc"+sqlveh);
	if(rstveh.next())
	{

	vehdesc1=rstveh.getString("VehDesc");

	if(vehdesc1==null || vehdesc1.equalsIgnoreCase("null"))
	{
		vehdesc1="-";
	}
	vehmodel1=rstveh.getString("VehModel");
	if(vehmodel1==null || vehmodel1.equalsIgnoreCase("null"))
	{
		vehmodel1="-";
	}
	vehtype1=rstveh.getString("VehType1");
	if(vehtype1==null || vehtype1.equalsIgnoreCase("null"))
	{
		vehtype1="-";
	}
	}
	else
	{
		vehdesc1="-";
		vehmodel1="-";
		vehtype1="-";
	}

	%>

	<td><%=vehdesc1%></td>
	<td><%=vehmodel1%></td>
	<td><%=vehtype1%></td>
	<td style="text-align: left"><%=rsttrips.getString("OwnerName")%></td>


	<td WIDTH="6%" ><div align="right" >
	<font size="2">
	<%=rsttrips.getString("TripId")%>
	</div></td>
		<td id="updtetmecol<%=j%>"><div align="left"><%=updtetime%> </div></td>
	<td WIDTH="8%" id="curposcol<%=j%>"><div align="left"> 
		
		<%=curpos%> </div></td>
		
		<td id="drivcol<%=j%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
		<td id="stplacecol<%=j%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
		<td id="stdatecol<%=j%>" style="text-align: left">
	<% try{
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate"))));
	}catch(Exception ee)
	{
		out.print(new SimpleDateFormat("dd-MMM-yyyy ").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsttrips.getString("StartDate"))));
		out.print(rsttrips.getString("StartTime"));
		}
	%></td>
		
		<td id="endplacecol<%=j%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
		
		<%
			if(DisDate.equalsIgnoreCase("NA"))
			{
				if(totKm==0 && remKm==0){
				%>
					<td id="FixedTimecol<%=j%>">  NA</td>
					<td id="FixedKmcol<%=j%>"> NA</td>
					
				<%
			}
			}
			else
			{
				%>
					<td id="FixedTimecol<%=j%>">  <%=tTime%></td>
					<td id="FixedKmcol<%=j%>"> <%=totKm %></td>
					
				<%
			}
		
		%>
		
		<td id="kmsruncol<%=j%>"> <div align="left"><%=kmrundist%></div></td>  
		<%
			if(DisDate.equalsIgnoreCase("NA"))
			{
				if(totKm==0 && remKm==0){
				%>
					
					<td id="kmstoruncol<%=j%>"><div align="left">NA</div></td>
				<%
			}
			}
			else
			{
				%>
					
					<td id="kmstoruncol<%=j%>"><div align="left"><%=remKm%></div></td>
				<%
			}
		
		%>
	 	
		<td id="etacol<%=j%>"><div align="left"><%=DisDate%> </div></td>
		<%
	sqlopen="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,TripCategory from t_startedjourney where tripid='"+rsttrips.getString("Tripid")+"'";
	//System.out.println(sql);
	ResultSet rssopen=stopen.executeQuery(sqlopen);
	if(rssopen.next())
	{

		endedby1=rssopen.getString("EndedBy");
		 weight1=rssopen.getString("Weight");
		 if(weight1==null || weight1.equalsIgnoreCase("null"))
		 {
			 weight1="-";
		 }
		 vendor11=rssopen.getString("Vendor");
		 
		 if(vendor11.equalsIgnoreCase("select") || vendor11==null || vendor11.equalsIgnoreCase("null"))
		 {
			 vendor11="-";
		 }
		 tripcat1 =rssopen.getString("TripCategory");
		 if(tripcat1.equalsIgnoreCase("select") || tripcat1==null || tripcat1.equalsIgnoreCase("null"))
		 {
			 tripcat1="-";
		 }
		 freight1 =rssopen.getString("Frieght");
		 if(freight1==null || freight1.equalsIgnoreCase("null"))
		 {
			 freight1="-";
		 }
		 adv1 =rssopen.getString("Advance");
		 if(adv1==null || adv1.equalsIgnoreCase("null"))
		 {
			 adv1="-";
		 }

	}
	else
	{
		 endedby1="-";
		 weight1="-";
		 vendor11="-";
		 tripcat1="-";
		 freight1="-";
		 adv1="-";
		
	} //out.println("Mila");

	%>
	 <td><%=weight1%></td>
	 <td><%=freight1%></td>
	 <td><%=adv1%></td>
	 <td><%=vendor11%></td>
	 <td><%=tripcat1%></td>
	  <td><%=comments%></td>
		</tr>
		<%
		}
	
	j++;
	
	}
	//out.println("===end of 1st table===");
	%>
	</table>

	</td>
	</tr>
	
<%

}
else if(statusname.equalsIgnoreCase("Cancelled"))
{
	out.println("\n\n in cancelled trips loop");



	String vehregno="",tripid="",startplace="",endplace="",entryby="",driverid="",startdate="",starttime="",drivername="",OwnerName="",tripcategory="",updateddatetime="",jstatus="";	
	Statement st4, sttemp,stopen,stveh;
	String today="";



			//System.out.println("======1========");
			today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			String currenttime=new SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
		st4=conn.createStatement();
		stveh=conn.createStatement();
		stopen=conn.createStatement();
		String mydate1,mydate2;
		mydate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
		mydate2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
		//out.println("\n\n from-->>"+mydate1);
	//out.println("\n\nto-->>"+mydate2);
		
	//out.println("\n\nlist veh-->>"+myvehlist);
	%>
		

	</td>
	</tr>
	<table border="0" width="100%" align="center">
<tr align="center"><td>
<font  size="3"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font>
</tr>
</table>
	</table>
	<table border="1" class="sortable" width="100%">
	<tr>
	<th  class="hed" id="srcol" valign="top"> Sr No</th>
	<th class="hed" id="srcol" valign="top"> TripId</th>
	<th  class="hed" id="vehcol" valign="top">VehicleRegNo</th> 
	<th class="hed" id="tripcol" valign="top">DriverID</th>
	<th class="hed" id="tripcol" valign="top">DriverName</th>
	<th class="hed" id="updtetmecol" valign="top">OwnerName</th>
	<th class="hed" id="srcol" valign="top">StartDateTime</th>
	<th class="hed" id="srcol" valign="top"> StartPlace</th>
	<th  class="hed" id="srcol" valign="top">EndPlace</th>	
	<th class="hed" id="curposcol" valign="top">TripCategory</th>
	<th class="hed" id="drivcol" valign="top">CancelDateTime</th>
	<th class="hed" id="drivcol" valign="top">CanceledBy</th>
	
	</tr>	
		
		<%
			
		//sql="select * from t_startedjourney where Jstatus in('Running','tobeclosed') and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
		sql="select * from t_startedjourney where Jstatus='Cancelled' AND Vehid in"+session.getAttribute("VehList").toString()+"AND  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by StartDate desc";
	   // out.println("\n\n started journey query-->>"+sql);
		
		ResultSet rsttrips=st.executeQuery(sql);
		int j=1;
		while(rsttrips.next())
		{
			//	TripID,VehRegNo,StartPlace,StartCode,EndPlace,EndCode,StartDate,StartTime,DriverCode,DriverName,GPName,TripCategory,updateddt,JDDate,Ship_To,JStatus	
			 //vehregno="",tripid="",startplace="",endplace="",startdate="",starttime="",drivername="",gpname="",tripcategory="",updateddatetime="",jstatus="";	
				tripid="";
			       	vehregno=rsttrips.getString("VehRegNo");
			 		tripid=rsttrips.getString("TripID");
			 		startplace=rsttrips.getString("StartPlace");
			 		endplace=rsttrips.getString("EndPlace");
			 		startdate=rsttrips.getString("StartDate");
			 		starttime=rsttrips.getString("StartTime");
			 		drivername=rsttrips.getString("DriverName");
			 		OwnerName=rsttrips.getString("OwnerName");
			 		tripcategory=rsttrips.getString("TripCategory");
			 		updateddatetime=rsttrips.getString("updateddt");
			 		jstatus=rsttrips.getString("JStatus");
			 		entryby=rsttrips.getString("EntryBy");
			 		driverid=rsttrips.getString("DriverCode");
				 
					String stdateparse=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")));
					/// SimpleDateFormat sdftimemilli = new SimpleDateFormat("dd-MMM-yyyy HH:mm");
			      //	Date startDtTm = sdftimemilli.parse(rsttrips.getString("StartDate")+" "+rsttrips.getString("StartTime")); 
			      	updateddatetime=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updateddatetime));
			   	%>
				<tr>
				
				<td style="text-align: right;"><%=j%></td>
				<td style="text-align: right;"><%=tripid%></td>
			    <td style="text-align: left;"><%=vehregno%></td> 
			    <td style="text-align: left;"><%=driverid%></td>
			   <td style="text-align: left;"><%=drivername%></td>
			       <td style="text-align: left;"><%=OwnerName%></td> 
			   <td style="text-align: right;"><%=stdateparse%></td> 
			    <td style="text-align: left;"><%=startplace%></td> 
			   <td style="text-align: left;"><%=endplace%></td>
			       <td style="text-align: left;"><%=tripcategory%></td>
			    <td style="text-align: right;"><%=updateddatetime%></td> 
			    <td style="text-align: right;"><%=entryby%></td> 
			   
			   
			   
			   
			<%
			j++;
			    }

	
}

else{
	
	vehicleno=request.getParameter("vehicle");
	 if(vehicleno.length()>0)
	    {
	    	int i=vehicleno.indexOf(',');
	    	vehicleno=vehicleno.substring(i+1);
	    }
	//System.out.println("Vehicle-------> "+vehicleno);
	
	if(vendername.equals("ALL") && categoryname.equals("ALL") && startplacename.equals("ALL") && endplacename.equals("ALL"))
	  {
	  
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and VehRegNo='"+vehicleno+"' order by StartDate ";
	  
	  }
	 //a - - -
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and  TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' and VehRegNo='"+vehicleno+"' order by StartDate ";
	  }
	//- a - -
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"'and VehRegNo='"+vehicleno+"' order by StartDate ";
	  }
	//- - a -
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount, DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and EndPlace='"+endplacename+"'and VehRegNo='"+vehicleno+"' order by StartDate ";
	  }
	//- - - a
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"' and VehRegNo='"+vehicleno+"' order by StartDate "; 
	  }
	//- - - -
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by StartDate ";	  
	  }
	//a a - -
	  else  if(vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' and VehRegNo='"+vehicleno+"' order by StartDate ";	  
	  }
	//a a a -
	  else  if(vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and EndPlace='"+endplacename+"' and VehRegNo='"+vehicleno+"' order by StartDate ";	  
	  }
	//a - a -
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'    and TripCategory='"+categoryname+"' and EndPlace='"+endplacename+"' and VehRegNo='"+vehicleno+"'order by StartDate ";	  
	  }
	//a - - a
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"' and VehRegNo='"+vehicleno+"'  order by StartDate ";	  
	  }
	//- a a a
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and Vendor='"+vendername+"' and VehRegNo='"+vehicleno+"' order by StartDate ";	  
	  }
	//- - a a
	  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and VehRegNo='"+vehicleno+"' order by StartDate ";	  
	  }
	//- a a -
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and Vendor='"+vendername+"'  and EndPlace='"+endplacename+"' and VehRegNo='"+vehicleno+"'order by StartDate ";	  
	  }
	  //- a - a 
	  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and Vendor='"+vendername+"'  and StartPlace='"+startplacename+"' and VehRegNo='"+vehicleno+"' order by StartDate ";	  
	  }
	//a - a a 
	  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
	  {
		  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and   StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and TripCategory='"+categoryname+"' and  VehRegNo='"+vehicleno+"' order by StartDate ";	  
	  }
	//System.out.println("Query --------"+Sqlv);
%>

<tr><td align="center">
<font  size="3"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font>
</td>
</tr>
</table>

<table border="1" class="sortable" width="100%">
<tr>
<th>Sr.</th>
<th>Trip ID</th>
<th>Driver</th>
<th>Veh.</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th> Desc</th>
<th> Model</th>
<th>Type</th>
<% 
		}%>
<th>Owner</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Weight Kg</th>
<th>Freight Rs</th>
<th>Advance Rs</th>
<% 
		}%>
<th>Vendor</th>
<th>Category</th>
<th>Origin</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Report DateTime</th>
<% 
		}%>
<th>Start Date Time</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Load Delay (hh:mm:ss)</th>
<th>Ld Delay Rsn</th>
<th>Load Comments</th>
<% 
		}%>
<th>Destination</th>
<th>End Date Time</th>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<th>Unload Date Time</th>
<th>Unload Delay (hh:mm:ss)</th>
<th>Unld Delay Rsn</th>
<th>Unload Comments</th>
<% 
		}%>
<th>Fixed Distance</th>
<th>Fixed Time</th>
<th>KM Traveled</th>
<th>Time Taken</th>
<th>OSCount</th>
<th>OSDuration</th>
<th>RACount</th>
<th>RDCount</th>
<th>Trip Rating</th>
<th>ND</th>
<th>Disconnection</th>
<th>Disconnection Km</th>
<th>Closed By</th>
</tr>
<%


//System.out.println("Our exact query>>>>"+Sqlv); 
ResultSet rstcloser=st15.executeQuery(Sqlv);
//result set from Veh Details
int i=0,dist1,dist2;
java.util.Date enddte1,strdte1;

double stdDist=0,stdTme=0,capDist=0;
String SDate,EDate,STime,ETime,tripid,StDate,EdDate;
long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0,etime;
String fromdate="",todate="";
String ftime1="00";
String ftime2="00";
String ttime1="00";
String ttime2="00";
String fromdate1="",todate1="";
String vehdesc="-",vehmodel="-",vehtype="-",tripcat="-",adv="-",freight="-",loadrsn="-",loadcmt="-",endedby="-",weight="-",vendor="-",reptdttme="-",unloadcmt="-",unloadrsn="-";
String sdate,edate,LoadingDelay,UnloadingDelay;
int KmTravelled=0;

while(rstcloser.next())
{
//StDate=rstcloser.getDate("StartDate");
i++;

SDate=rstcloser.getString("StartDate");
EDate=rstcloser.getString("EndDate");
STime=rstcloser.getString("StartTime");
ETime=rstcloser.getString("EndTime");
tripid=rstcloser.getString("TripId");
KmTravelled=rstcloser.getInt("KmTravelled");

LoadingDelay=rstcloser.getString("LoadingDelay");
if(LoadingDelay==null || LoadingDelay.equalsIgnoreCase("null"))
{
LoadingDelay="-";
}
UnloadingDelay=rstcloser.getString("UnloadingDelay");
if(UnloadingDelay==null || UnloadingDelay.equalsIgnoreCase("null"))
{
UnloadingDelay="-";
}
unloadcmt=rstcloser.getString("Unloadingcomments");
if(unloadcmt==null || unloadcmt.equalsIgnoreCase("null"))
{
unloadcmt="-";
}
unloadrsn=rstcloser.getString("DelayReason");
if(unloadrsn==null || unloadrsn.equalsIgnoreCase("null"))
{
unloadrsn="-";
}

if(null==STime || STime.length()>8 || STime.equals("-"))
{
STime="00:00:00";
}

if(null==ETime || ETime.equals("-"))
{
ETime="23:59:59";
}

/*#################################change#############################*/

/*=====================================================
parameters passed to show_custom_detail_rept_onMap.jsp
start date
Start time-> Hrs mins separate
end date
end time-> hrs mins separate
==============================================*/
sdate=SDate;
//System.out.println("sdate  "+sdate);
try
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
}
catch(Exception e)
{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
}
// System.out.println("StartDate--->>"+fromdate);
try
{
java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
ftime1=""+dt.getHours();
ftime2=""+dt.getMinutes();
}
catch(Exception e)
{
	ftime1="00";
	ftime1="00";
}

edate=EDate;
//System.out.println("edate  "+edate);
try
{
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
}
catch(Exception e)
{
	 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
}
try
{
java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
ttime1=""+edt.getHours();
ttime2=""+edt.getMinutes();
}
catch(Exception e)
{
	ttime1="23";
 	ttime2="59";
}
/*#################################change#############################*/

try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00

miliseconds1=fd.getTime();

}catch(Exception e1)
{
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
miliseconds1=fd.getTime();

}catch(Exception e4)
{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
miliseconds1=fd.getTime();

}
}
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
miliseconds2=fd1.getTime();
}catch(Exception e2)
{
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
miliseconds2=fd1.getTime();

}catch(Exception e5)
{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
miliseconds2=fd1.getTime();
}
}

try{
fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));

}catch(Exception e)
{
fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));

}
try{

	todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
	todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));

}catch(Exception e)
{
todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));

}

%>
<tr>

<td style="text-align: right"><%=i%></td>

<td><div align="right"  >
<%=rstcloser.getString("TripId")%></td>

<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>

<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>

<%
String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"'";
ResultSet rst3=stt2.executeQuery(sql3);
//System.out.println("veh desc"+sql3);
if(rst3.next())
{

vehdesc=rst3.getString("VehDesc");

if(vehdesc==null || vehdesc.equalsIgnoreCase("null"))
{
vehdesc="-";
}
vehmodel=rst3.getString("VehModel");
if(vehmodel==null || vehmodel.equalsIgnoreCase("null"))
{
vehmodel="-";
}
vehtype=rst3.getString("VehType1");
if(vehtype==null || vehtype.equalsIgnoreCase("null"))
{
vehtype="-";
}
}
else
{
vehdesc="-";
vehmodel="-";
vehtype="-";
}

if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=vehdesc%></td>
<td><%=vehmodel%></td>
<td><%=vehtype%></td>
<% 
}
	%>
<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>

<%

String sql="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,Loadreason,Loadcomments,TripCategory,FIxedKM,FIxedTime from t_startedjourney where tripid='"+tripid+"'";
//System.out.println(sql);
ResultSet rss=st2.executeQuery(sql);
if(rss.next())
{
stdDist=rss.getDouble("FIxedKM");
stdTme=rss.getDouble("FIxedTime"); 
endedby=rss.getString("EndedBy");
weight=rss.getString("Weight");
if(weight==null || weight.equalsIgnoreCase("null"))
{
	 weight="-";
}
vendor=rss.getString("Vendor");

if(vendor.equalsIgnoreCase("select") || vendor==null || vendor.equalsIgnoreCase("null"))
{
	 vendor="-";
}
tripcat =rss.getString("TripCategory");
if(tripcat.equalsIgnoreCase("select") || tripcat==null || tripcat.equalsIgnoreCase("null"))
{
	 tripcat="-";
}
freight =rss.getString("Frieght");
if(freight==null || freight.equalsIgnoreCase("null"))
{
	 freight="-";
}
adv =rss.getString("Advance");
if(adv==null || adv.equalsIgnoreCase("null"))
{
	 adv="-";
}
try
{
	 //out.println(i);
	 reptdttme=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rss.getString("ReportDateTime")));
	 	 
}catch(Exception ss)
{
	 reptdttme=rss.getString("ReportDateTime");
}
if(reptdttme==null || reptdttme.equalsIgnoreCase("null"))
{
	 reptdttme="-";
}
if(loadrsn==null || loadrsn.equalsIgnoreCase("null"))
{
	 loadrsn="-";
}

if(loadcmt==null || loadcmt.equalsIgnoreCase("null"))
{
	 loadcmt="-";
}	 

}
else
{
endedby="-";
weight="-";
vendor="-";
reptdttme="-";
tripcat="-";
freight="-";
adv="-";
loadcmt="-";
loadrsn="-";
} //out.println("Mila");

if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=weight%></td>
<td><%=freight%></td>
<td><%=adv%></td>
<% 

try{
fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
}catch(Exception e)
{
fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
}
try{

	todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}catch(Exception e)
{
todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
}

}
	%>
<td><%=vendor%></td>
<td><%=tripcat%></td>
<td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=reptdttme%></td>
<% 
}
%>
<td style="text-align: left">
<% 
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"))));
}catch(Exception ee)
{
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+"<br>"+STime);
}
%>
</td>
<% 
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%=LoadingDelay%></td>
<td><%=loadrsn%></td>
<td><%=loadcmt%></td>
<% 
}	%>
<td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
<td style="text-align: left"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
}catch(Exception ee)
{
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
}
%>
</td>
<%
if(tds.equalsIgnoreCase("More Info"))
{
	%>
<td><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
}catch(Exception ee)
{
out.print("-");
}
%>
</td>
<td><%=UnloadingDelay%></td>
<td><%=unloadrsn%></td>
<td><%=unloadcmt%></td>
<% 

}
//*********************************************query is changed*****************************************************
sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rstcloser.getString("StartPlace")+"' and EndPlace = '"+rstcloser.getString("EndPlace")+"' || StartPlace ='"+rstcloser.getString("EndPlace")+"' and EndPlace = '"+rstcloser.getString("StartPlace")+"'";
ResultSet rstdist=st1.executeQuery(sql);
if(stdDist==0 && stdTme==0)
if(rstdist.next())
{ 
	stdDist=rstdist.getDouble("Km");
	stdTme=rstdist.getDouble("TTime");
}
//else
//{
	//stdDist=0;
	//stdTme=0;
//}


if(stdDist==0 && stdTme==0)
{
	%>
	<td style="text-align: right">NA</td>
	<td style="text-align: right">NA</td>
	<%
}
else
{
	%>
	<td style="text-align: right"><%=stdDist%></td>
	<td style="text-align: right"><%=stdTme%></td>
	<%
}
%>
<td style="text-align: right"><%=KmTravelled%></td>
<!--<td style="text-align: right">
<%
//***************************************************************************************************************
int dist;
dist=0; dist1=0; dist2=0;

%> 
</td>--> 

<td style="text-align: left">
<%
try{

	try{
		enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"));
	}
	catch(Exception e)
	{
		enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate"));
		strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate"));
	}

	
	
/* 	Check the difference between two date time Date */
long hrs,mins;
double hrslong=0.00;
java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
long x=enddte11.getMinutes();
long y=strdte11.getMinutes();




long timediff=enddte11.getTime()-strdte11.getTime();//msec

//hrslong=timediff/1000/60/60;

long mins11=timediff/1000/60;

if(mins11>=60)
{
	hrdiff=mins11/60;//2

	if((y>x)&&(x!=0))
	{
	mins=y-x;
	mins=60-mins;
	out.print(hrdiff+"hrs"+mins+"mins");
	}
	else if((x>y)&&(y!=0))
	{
		mins=x-y;
		
		out.print(hrdiff+"hrs"+mins+"mins");
		
	}else if(x==y)
	{
		mins=x-y;
	
		out.print(hrdiff+"hrs"+mins+"mins");
	}
	
	 else if((x==0)&&(y>x))
 {
	 mins=60-y;
	 out.print(hrdiff+"hrs"+mins+"mins");
 }else if(y==0)
 {
	 mins=x+y;
	 out.print(hrdiff+"hrs"+mins+"mins");
 }
}
else
{
	hrdiff=0;
	mins=mins11;
	out.print(hrdiff+" hrs "+mins+" mins");
}
String enddte=enddte1+" "+ETime;

String strtdte=strdte1+" "+STime;

long tmeinmils=enddte1.getTime()-strdte1.getTime();
//out.println(""+enddte1.getTime());
long hours=tmeinmils/(1000*60*60);

String extractstrtminutes=STime.substring(3,5);
String extractendminutes=ETime.substring(3,5);
//out.print(""+ETime);
int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);

if(totmins >= 60)
{
hrdiff=hrdiff+1;
totmins=totmins-60;
}
}
catch(Exception e)
{
	
	//out.print("-");
}


%>


</td>
<%
NumberFormat nf1=NumberFormat.getInstance();
nf1.setMaximumFractionDigits(2);
nf1.setMinimumFractionDigits(2);

//int TripRating=
%>

<td style="text-align: right"><%=rstcloser.getInt("OSCount")%></td>
<td style="text-align: right"><%=rstcloser.getDouble("OSDuration")%></td>
<td style="text-align: right"><%=rstcloser.getInt("RACount")%></td>
<td style="text-align: right"><%=rstcloser.getInt("RDCount")%></td>
<td style="text-align: right"><%=nf1.format(rstcloser.getInt("TripRating"))%></td>
<td>
<%
if(rstcloser.getInt("NDCount")>0)
{
	 
	%>
	
	<%=rstcloser.getInt("NDCount")%><%
}
else{
	//out.print("0");
	%>
	<%=rstcloser.getInt("NDCount")%>
	<%
}
%>
</td>

<td style="text-align: right">
<%
int discount=0, diskm=0;
String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rstcloser.getString("vehid")+"' and  OffTimeFrom >='"+rstcloser.getString("Startdate")+"'and  OffTimeTo<='"+rstcloser.getString("Enddate")+"'";
ResultSet rstdis=st2.executeQuery(sqldis);
if(rstdis.next())
{
	if(rstdis.getInt("cnt")>0)
	{
		discount=rstdis.getInt("cnt");
		diskm=rstdis.getInt("distance");
		%>
		
			<%=discount%>
	
	<%
	}
	else{
		
		out.print("0");
	}

}
else{
	out.print("0");
}
%>
</td>
<td style="text-align: right">
<%
if(discount>0){
	%>
	<%=diskm %>
	<%
	}
else{
	out.print(0);
	}
%>
</td>
<%




sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
//System.out.println(sql);
rss=st2.executeQuery(sql);
if(rss.next())
{
	  endedby=rss.getString("EndedBy");
} 
	 %>
	  <td style="text-align: left">  
	 <%
	if(endedby.equals("-") || endedby.equals(""))
	{
		out.print("Auto Closed");
	}
	else
	{
		out.print(endedby);
	}
	 %>
	 
	 </td>

</tr> 

<%

}
%>
<input type="hidden" name="cnt" id="cnt" value="<%=i%>">
<% 
}	 

}
catch(Exception e)
{
out.print("Exception -->"+e);
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
}

%>
</td></tr>
</table>
<%@ include file="footernew.jsp" %>
