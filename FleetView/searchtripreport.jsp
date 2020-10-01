<%@ include file="headernew.jsp" %>
	
<%!
Connection conn,conn1,conn2;
Statement st,st1,st2,st3,strip,st4,st5;
String fromdate, todate,sql,sql1,transporter,datenew1,datenew2,fromdatetime,todatetime;
%>
<%
NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);  

try
{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	conn2 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn1.createStatement();
strip=conn.createStatement();
st4=conn2.createStatement();
st5=conn.createStatement();
}
catch(Exception e)
{	
	out.print("Exception ---->"+e);
}	

%>
  <script type="text/javascript">

function toggleDetails(id, show)
{
var popup = document.getElementById("popup"+id);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();

} else {
popup.style.visibility = "hidden";
}
}
</script>
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}
</style>

  
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>




<%!
/*Connection conn,conn1,conn2;
Statement st,st1,st2,st3,strip,st4;
String fromdate, todate,sql,sql1,transporter,datenew1,datenew2,fromdatetime,todatetime;*/
%>




<%String trip1=request.getParameter("trip"); 
  System.out.println("trip id is====>"+trip1);
%>



<table border="0" width="100%" align="center">
<form name="dateform" action="" method="get"  onsubmit="return validate();">
<tr><td align="center">

<font size="4"><B>Trips Report</B></font>

</td></tr>
<tr>
<td>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('print_searchreport.jsp?&tripid=<%=trip1%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excel_searchreport.jsp?&tripid=<%=trip1%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>

</td>
</tr>


<tr><td>
<%

    try
{
/*	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	conn2 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
//conn = fleetview.ReturnConnection();
//conn1 = fleetview.ReturnConnection1();
st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn1.createStatement();
strip=conn.createStatement();
st4=conn2.createStatement();*/


%>
<% 	




%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<% 
String vno="";
String sq=  "select VehRegNo from  t_startedjourney  where TripID='"+trip1+"' ";
ResultSet rq=st2.executeQuery(sq);
while(rq.next())
{
	vno=rq.getString("VehRegNo");
}
%>
<td align="center"><B><font size="3">Trip Report for Vehicle: <%=vno%></B></font></td>
<%System.out.println("vno is====>"+vno);%>

<div class="bodyText" align="right">
</td>
</tr>
</table>
<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>Trip ID</th>
<th>Driver</th>
<th>Veh.</th>
<th>Transporter</th>
<th>Start Date Time</th>
<th>Origin</th>
<th>Start Latitude</th>
<th>Start Longitude</th>
<th>End Date Time</th>
<th>Destination</th>
<th>End Latitude</th>
<th>End Longitude</th>
<th>Fixed Distance</th>
<th>Fixed Time</th>
<th>Distance Traveled</th>
<th>Time Taken</th>
<th>EndTrip Type</th>
<th>Category</th>
<th>Unit Replaced</th>
<th>Vehicle Attended</th>
<th>% Diff in Kms</th>
<th>End Comment</th>
<th>Issues</th>
<th>Edit</th>
</tr>
<%
String TripID,category,dates1,dates2,sqltrips="";
int is=1,j=1,k=0;
int dists1=0,dists2=0;
double stdDists=0,capDists=0,stdDists1=0,capDists1=0;
String bgcolor="";
String fromdates1="",todates1="";
String sdates,edates;
int ftimes1=0;
int ftimes2=0;
int ttimes1=0;
int ttimes2=0;
//System.out.println(fromdate);
//System.out.println(todate);
//date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdate));
//date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todate));

//TripID=res.getString("tripid");

//List tripId=new ArrayList();
//System.out.print(type);
String tripID=""; 
String sqls1="Select * from t_startedjourney where GPName='Castrol' and TripId='"+trip1+"'";
ResultSet res=st2.executeQuery(sqls1);
while(res.next())
{
	tripID=res.getString("TripID");
}

sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where TripID='"+tripID+"'";
ResultSet rst=st.executeQuery(sql);

java.util.Date enddte1,strdte1;

String slat,slon,elat,elon;
String SDates,EDates,STimes,ETimes,tripids,StDates,EdDates,endComments="-";
long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
if(rst.next())
{
String finalComment="-",comment="-";
int loop=0;
String sql3="select comment from t_tripcomments where tripid='"+tripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
ResultSet commentRst=st5.executeQuery(sql3);
while(commentRst.next())
	{
		comment=commentRst.getString(1);
		if(!(comment.equalsIgnoreCase("-")))
		{
		  if(loop==0)
			{
				finalComment=comment+", ";
			}
		 else
			{
				finalComment+=comment+", ";		
			}
		loop++;
	}

}
if(!(finalComment.equalsIgnoreCase("-")))
{
finalComment=finalComment.substring(0,finalComment.lastIndexOf(","));
}	

SDates=rst.getString("StartDate");
EDates=rst.getString("EndDate");
STimes=rst.getString("StartTime");
ETimes=rst.getString("EndTime");
endComments=rst.getString("Comment1");

if(null==STimes || STimes.length()>8 || STimes.equals("-"))
{
STimes="00:00:00";
}

if(null==ETimes || ETimes.equals("-"))
{
ETimes="23:59:59";
}



/*#################################change#############################*/

sdates=SDates+" "+STimes;
try
{
	fromdates1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdates));	
}
catch(Exception e)
{
	fromdates1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdates));
}
//	System.out.println("StartDate--->>"+fromdate1);
try
{

java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdates);
ftimes1=dt.getHours();
ftimes2=dt.getMinutes();
}
catch(Exception e)
	{
		ftimes1=00;
		ftimes1=00;
	}
//	 System.out.println("ftime1--->>"+ftime1);
//System.out.println("ftime2--->>"+ftime2);


edates=EDates+" "+ETimes;
try
{
	todates1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edates));
}
catch(Exception e)
{
	todates1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edates));
}
//	System.out.println("todate1--->>"+todate1);
try
{
java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edates);
ttimes1=edt.getHours();
ttimes2=edt.getMinutes();
}
catch(Exception e)
{
	ttimes1=23;
	ttimes2=59;
}
/*#################################change#############################*/


try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDates+" "+STimes);
miliseconds1=fd.getTime();
}catch(Exception e1)
{
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDates);
miliseconds1=fd.getTime();
}catch(Exception e4)
{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDates);
miliseconds1=fd.getTime();
}
}
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDates+" "+ETimes);
miliseconds2=fd1.getTime();
}catch(Exception e2)
{
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDates);
miliseconds2=fd1.getTime();
}catch(Exception e5)
{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDates);
miliseconds2=fd1.getTime();
}
}

millisecdiff=miliseconds2-miliseconds1;
secdiff=millisecdiff/1000;
mindiff=secdiff/60;
hrdiff=mindiff/60; 
//System.out.println("start"+rst.getString("StartDate"));
//System.out.println("EndDate"+rst.getString("EndDate"));


try{
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
}catch(Exception e)
{
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STimes;
}

try{
	todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
}catch(Exception e)
{
	todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETimes;
}



//******************************distance difference******************************

String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 

	//System.out.println(sqlquery);
ResultSet res1=st2.executeQuery(sqlquery);

			
if(res1.next())
{ //System.out.println("12345");
	stdDists1=res1.getDouble("Km");
//	System.out.println(stdDist1);
	
}
else
{
	stdDists1=0;
}
	capDists1=rst.getDouble("KmTravelled");
//System.out.println(capDist1);
	if(stdDists1==0)
	{
	//	System.out.println("12345");
	 	bgcolor="";
	
}

else
{
	double diffs;
	diffs=((stdDists1-capDists1)/stdDists1)*100;//difference
//	System.out.println(diff);
	
//	System.out.println("abs diff="+Math.abs(diff));
	if(Math.abs(diffs)>20)
	{
		//System.out.println("1");
		bgcolor="background-color:#FF0000";
	//	 System.out.println(bgcolor);
 	 
	}
	else
	{
		
		 bgcolor="";
	}

}


//************************************************************************

%>
<tr>
<!--tr bgcolor="< %=bgcolor%>"-->
<td style="<%=bgcolor%>" align="right"><%=is%></td>
<td style="<%=bgcolor%>"><div align="right">
<a href="javascript:toggleDetails(<%=is%>,true);" title="Click To See the Reports"><font size="2"><%=tripID%></font></a><br />
<div class="popup" id="popup<%=is%>">
<table border="1" bgcolor="white">
<tr>
<td>
<a href="ShowCustomReportonTWMap.jsp?tripid=<%=tripID%>&vehcode=<%=rst.getString("VehId")%>&data=<%=fromdates1%>&data1=<%= todates1%>&ftime1=<%=ftimes1 %>&ftime2=<%=ftimes2 %>&ttime1=<%=ttimes1 %>&ttime2=<%=ttimes2 %>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&enddate=<%=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=is%>,false);">Show On Map</a>
<!--<a href="startedtrip.jsp?tripid=<%//=TripID%>&vehcode=<%//=rst.getString("VehId")%>&sdate=<%//=fromdatetime%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%//=session.getAttribute("user").toString()%>&startplace=<%//=rst.getString("StartPlace")%>&endplace=<%//=rst.getString("EndPlace")%>&enddate=<%//=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%//=is%>,false);">Show On Map</a>-->
</td>
</tr>
<tr>
<td><a href="detailed_reportalltrip.jsp?vehcode=<%=rst.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=is%>,false);">Detail Report</a>
</td>
</tr>
<tr><td><a href="javascript:toggleDetails(<%=is%>,false);">Close</a></td></tr>
</table>
</div> 
</div></td>
<td style="<%=bgcolor%>"><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("VehRegNo")%></td>
<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("OwnerName")%></td>
<td style="<%=bgcolor%>; text-align: left"><%
try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
	
//	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss")).format(rst.getString("StartDate")));
}catch(Exception ee)
{
//try{
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STimes);
	

}//catch(Exception eee)
/*{
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("StartDate"))+" 00:00:00");
}
}*/
%></td>
<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("StartPlace")%></td>
<%
double lat,lon;
String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("StartPlace")+"' limit 1";
ResultSet rst11=st2.executeQuery(sql11);
if(rst11.next())
{
slat=rst11.getString("Latitude");
slon=rst11.getString("Longitude");

%>
<td style="<%=bgcolor%>; text-align: right"><%=rst11.getString("Latitude")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rst11.getString("Longitude")%></td>
<%
}
else
{

String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"'";
ResultSet rstg=st2.executeQuery(sqlg);
if(rstg.next())
{
%>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Startlat")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Startlong")%></td>
<%
}
else
{
String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("StartPlace")+"'";
ResultSet rstg1=st2.executeQuery(sqlg1);
if(rstg1.next())
{

%>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Endlat")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Endlong")%></td>
<%
}
else
{
%>
<td style="<%=bgcolor%>; text-align: right"><%="-" %></td>
<td style="<%=bgcolor%>; text-align: right"><%="-" %></td>
<%
}
}


}
%>
<td style="<%=bgcolor%>; text-align: left"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));
//out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
/*if(null==rst.getString("EndTime"))
{
} 
else
{
out.print(rst.getString("EndTime"));
}*/

}catch(Exception ee)
{

out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETimes);	

//out.print((new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"))+"<br>"+ETime)));
//out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);


}
%></td>
<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("EndPlace")%></td>
<%

String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
ResultSet rst12=st2.executeQuery(sql12);
if(rst12.next())
{
//slat=rst11.getString("Latitude");
//slon=rst11.getString("Longitude");
%>
<td style="<%=bgcolor%>; text-align: right"><%=rst12.getString("Latitude")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rst12.getString("Longitude")%></td>
<%
}
else
{

String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rst.getString("EndPlace")+"'";
ResultSet rstg=st2.executeQuery(sqlg);
if(rstg.next())
{
%>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Startlat")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Startlong")%></td>
<%
}
else
{
String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rst.getString("EndPlace")+"'";
ResultSet rstg1=st2.executeQuery(sqlg1);
if(rstg1.next())
{
%>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Endlat")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rstg.getString("Endlong")%></td>
<%
}
else
{
%>
<td style="<%=bgcolor%>; text-align: right"><%="-" %></td>
<td style="<%=bgcolor%>; text-align: right"><%="-" %></td>
<%
}
}


}
%>
<%
//*********************************************qouery is changed*****************************************************
sql="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'";
//System.out.println(sql);
ResultSet rstdist=st1.executeQuery(sql);
if(rstdist.next())
{ 
stdDists=rstdist.getDouble("Km");

%>
<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("Km")%></td>
<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("TTime")%></td>
<%
}
else
{
stdDists=0;
%>
<td style="<%=bgcolor%>; text-align: left"><%="NA" %></td>
<td style="<%=bgcolor%>; text-align: left"><%="NA" %></td>
<%}
%>
<td style="<%=bgcolor%>; text-align: right">
<%
//***************************************************************************************************************
capDists=rst.getDouble("KmTravelled");
out.print(rst.getString("KmTravelled"));
%> 
</td> 
<td style="<%=bgcolor%>; text-align: right">
<%
try{

//String enddte=rst.getString("EndDate");
//String endtme=rst.getString("EndTime");
//String strtdte=rst.getString("StartDate");
//String strtime=rst.getString("StartTime");

//enddte=enddte+" "+endtme;
//strtdte=strtdte+" "+strtime;
try{
enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
}
catch(Exception e)
{
enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
}



long hrs,mins;
java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
long x=enddte11.getMinutes();
long y=strdte11.getMinutes();

long timediff=enddte11.getTime()-strdte11.getTime();//msec
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
/*else if((x==0)
{
 mins=60-y;
 out.print(hrdiff+"hrs"+mins+"mins");
}*/
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


//java.util.Date enddte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddte);
//java.util.Date strdte1= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(strtdte);
/*
String enddte=enddte1+" "+ETime;
String strtdte=strdte1+" "+STime;

long tmeinmils=enddte1.getTime()-strdte1.getTime();
long hours=tmeinmils/(1000*60*60);
String extractstrtminutes=STime.substring(3,5);
String extractendminutes=ETime.substring(3,5);
int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
if(totmins >= 60)
{
hours=hours+1;
totmins=totmins-60;
}
out.print(hours+" hrs "+totmins+" mins"); 
*/
}
catch(Exception e)
{
out.print("-");
}
%>
</td>



<td style="<%=bgcolor%>; text-align: left">
<%
String endedby;
String sql1="Select EndedBy from t_startedjourney where tripid='"+tripID+"'";
//System.out.println(sql);
ResultSet rss=st2.executeQuery(sql1);
if(rss.next())
{
endedby=rss.getString("EndedBy");
if(endedby.equals("-") || endedby.equals(""))
{
out.print("Auto Closed");
}
else
{
out.print(endedby);
}
}

%>
</td>
<%
String ss6="select Category from t_alljddata where TripId='"+tripID+"'";
	ResultSet rs6=st2.executeQuery(ss6);
	if(rs6.next())
	{%>
		
		<td style="<%=bgcolor%>; text-align: left"><%=rs6.getString("Category")%></td>
<% }
	
	


String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
ResultSet rst13=st2.executeQuery(sql13);
if(rst13.next())
{
%>

<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('unit_replace_report.jsp?fromdate=<%=fromdatetime%>&todate=<%=todatetime%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=is%>,false);"><b><%="Yes" %></b></a></td>
<%
}
else
{
%>
<td style="<%=bgcolor%>; text-align: left"><%="No" %></td>
<%
}
%>

<%

String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
ResultSet rst2=st4.executeQuery(sql2);
if(rst2.next())
{%>
<td style="<%=bgcolor%>; text-align: right"><a href="javascript: flase" onClick="window.open ('vehicle_attended_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>&transporter=<%=rst.getString("OwnerName") %>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=is%>,false);"><b>Attended</b></a></td>


<%
}
else
{%>
<td style="<%=bgcolor%>; text-align: right"><%="Not Attended" %></td>
<%

}

%>

<td style="<%=bgcolor%>">
<%
if(stdDists==0)
{
%>	
<div align="left">
<%   out.print("NA");  %>
</div>
<%	
}
else
{
double diffdists=((stdDists-capDists)/stdDists)*100;
%>
<div align="right">	

<% out.print(nf.format(diffdists));%>
</div>

<%
}
%>
</td>
<td style="<%=bgcolor%>; text-align: left"><%=endComments %></td>
<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('tripcomment.jsp?tripid=<%=tripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=finalComment %></a></td>
<td style="<%=bgcolor%>"><input type="button" name="edit" value="Edit" onClick="window.open ('editendtrip.jsp?tripid=<%=tripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>&trans=<%=rst.getString("OwnerName")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"></input></td>
</tr>
<%
}
%>
</table> 
</td></tr>
</table>
<a href="tripReport.jsp"><font size="3">back</font></a>

<%
}catch(Exception e)
{
out.print("Exception -->"+e);
}
   
finally
{
conn.close();
conn1.close();
conn2.close();
}
%>
<%@ include file="footernew.jsp" %>
