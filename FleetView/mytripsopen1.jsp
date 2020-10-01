<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>

	
	<script>
	function getvalue()
	{
		var vender2=document.getElementById("vendor").value;
		document.getElementById("vend1").value=vender2;
		//alert(vender2);
		var category2=document.getElementById("category").value;
		document.getElementById("cat1").value=category2;
		//alert(category2);
		var startp2=document.getElementById("startp").value;
		document.getElementById("startpl1").value=startp2;
		//alert(startp2);
		var endp2=document.getElementById("endp").value;
		document.getElementById("endpl1").value=endp2;
		//alert(endp2);
		}
	
	</script>
	
	<script>
	function statuscloser()
	{
var stat=document.getElementById("status").value;


document.getElementById('statusp1').value=stat;
//alert(stat);
if(stat=="Closed")
{
	document.getElementById('ctrip').style.visibility='visible';
	
}
else
{
	document.getElementById('ctrip').style.visibility='hidden';
}
	}
	
	</script>
<script language="javascript">


//var trans=
	
function showhide2()
{
//alert("hi");
var frmdte=document.getElementById("data11").value;
var todte=document.getElementById("data22").value;
var trns=document.getElementById("transporter1").value;
//alert("todte--->"+todte);
//var todte1=todte.getFullYear() + "-" + todte.getMonth() + "-" + todte.getDate()
//todte.for
//alert("frmdte--->"+frmdte);
//alert("todte--->"+todte);
//alert("trans--->"+trns);

	var cnt=document.getElementById("cnt").value;
	//alert("cnt is--> "+cnt);
	var tdd,tdm,tdt;
	var tds=document.getElementById("tds").value;
	
	//alert("tds is -->"+tds);
	//alert("frmdte--->"+frmdte);
	//alert("todte--->"+todte);
	if(tds=="More Info")
	{
		//alert("In IF");
		for(i=0;i<=cnt;i++)
		{	
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='';
			tdt=document.getElementById("tdt"+i);
			tdt.style.display='';
			tdw=document.getElementById("tdw"+i);
			tdw.style.display='';
			tdv=document.getElementById("tdv"+i);
			tdv.style.display='';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='';
			tdu=document.getElementById("tdu"+i);
			tdu.style.display='';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='';
			tdul=document.getElementById("tdul"+i);
			tdul.style.display='';
			document.getElementById("tds").value="Hide Info";
		}
		document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'print_my_trips.jsp?tds=More Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'\');" title="Print My Trips Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
		document.getElementById("excel").innerHTML='<a href="export_my_trip.jsp?&tds=More Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
	else
	{
		//alert(tdx);
		for(i=0;i<=cnt;i++)
		{	
			tdd=document.getElementById("tdd"+i);
			tdd.style.display='none';
			tdm=document.getElementById("tdm"+i);
			tdm.style.display='none';
			tdt=document.getElementById("tdt"+i);
			tdt.style.display='none';
			tdw=document.getElementById("tdw"+i);
			tdw.style.display='none';
			tdv=document.getElementById("tdv"+i);
			tdv.style.display='none';
			tdr=document.getElementById("tdr"+i);
			tdr.style.display='none';
			tdu=document.getElementById("tdu"+i);
			tdu.style.display='none';
			tdl=document.getElementById("tdl"+i);
			tdl.style.display='none';
			tdul=document.getElementById("tdul"+i);
			tdul.style.display='none';
			document.getElementById("tds").value="More Info";
		}
		document.getElementById("print").innerHTML='<a href="#" onclick="javascript:window.open(\'print_my_trips.jsp?tds=Hide Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'\');" title="Print My Trips Report"><img src="images/print.jpg" width="15px" height="15px"></a>';
		document.getElementById("excel").innerHTML='<a href="export_my_trip.jsp?&tds=Hide Info&data1='+frmdte+'&data2='+todte+'&transporter='+trns+'" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>';
	}
}
  function validate()
  {
	  var myDate = new Date(document.getElementById("data1").value);
	  
  if(document.getElementById("data1").value=="")
  {
  
  alert("Please select the from date");
  return false;
  }
  if(document.getElementById("data2").value=="")
  {
    alert("Please select the to date");
  return false;
  }
  return true;
  //return datevalidate();
  
  }
  function datevalidate()
{ var date1=document.getElementById("data1").value;
var date2=document.getElementById("data2").value;
var dm1,dd1,dy1,dm2,dd2,dy2;
dy1=date1.substring(0,4);
dy2=date2.substring(0,4);
dm1=date1.substring(5,7);
dm2=date2.substring(5,7);
dd1=date1.substring(8,10);
dd2=date2.substring(8,10);
var date=new Date();
var month=date.getMonth()+1;
var day=date.getDate();
var year=date.getFullYear();



if(dy1>year || dy2>year)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}

if(dm1==month){
if(dd1>day || dd2>day)
{
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;

return false;

}
}
if(dy1>dy2)
{
alert("From date year is should not be greater than to date year");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}

else if(year==dy1 && year==dy2) if(dm1>dm2)
{
alert("From date month is should not be greater than to date month");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
if(dm1==dm2) {
if(dd1 > dd2)
{
alert("From date is should not be greater than to date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;
}
}
return true;
}

  </script>
  <script type="text/javascript">

function toggleDetails(id,show)
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
<style>
#ctrip {visibility:hidden;}

</style>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11,stt1,stt2,st12,st13,st14,st15;
String fromdate, todate,sql,sql1,sql2,sql3,transporter,datenew1,datenew2,fromdatetime,todatetime, vendor1,category1,startp,endp,ven,startp1,endp1,vendername,
categoryname,startplacename,endplacename,statusname,Sqlv="";



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
if(!(null==request.getQueryString()))
{

fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
transporter=request.getParameter("transporter");


%>
<input type="hidden" id="data11" name="data11" value="<%=fromdate %>"></input>
<input type="hidden" id="data22" name="data22" value="<%=todate %>"></input>
<input type="hidden" id="transporter1" name="transporter1" value="<%=transporter %>"></input>

<%
datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
vendername=request.getParameter("vend1");
categoryname=request.getParameter("cat1");
startplacename=request.getParameter("startpl1");
endplacename=request.getParameter("endpl1");
statusname=request.getParameter("statusp1");

//System.out.println("vendername"+vendername+"categoryname"+categoryname+"startplacename"+startplacename+"endplacename"+endplacename+"statusname"+statusname);
System.out.println(""+fromdate);
}
else
{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;

}

%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<div align="left"><font size="3">Report No:9.0</font></div>
<font size="3"><B>My Trips Report</B></font>
</td></tr>
<tr><td>
<table border="0" width="500" align="center">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr>
<td><b>From </b>&nbsp;&nbsp;
<input type="text" id="data1" name="data1" value="<%=datenew1%>"  size="15" readonly/>
  </td><td align="left">
<!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
</td>

<td>
<b>To</b> &nbsp;&nbsp;
<input type="text" id="data2" name="data2" value="<%=datenew2%>" size="15" readonly/></td><td align="left">
<!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script>
</td>

<td>
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<input type="hidden"  name="vend1" id="vend1" value=""></input>
<input type="hidden"  name="cat1" id="cat1" value=""></input>
<input type="hidden" name="startpl1" id="startpl1" value=""></input>
<input type="hidden"  name="endpl1" id="endpl1" value=""></input>
<input type="hidden"  name="statusp1" id="statusp1" value=""></input>
<input type="submit" name="submit" id="submit" value="submit"></td>

</tr>
</table>

</td>
<td>

<td >Status<select id="status" onChange="statuscloser(this.value)">
<option value="Open">Open</option>
<option value="Closed">Closed</option>
</select>
</td>

</td>

</tr>
<tr><td>

<table name="closetrip" id="ctrip" >
<tr>
<td >Vendor<select name="vendor" id="vendor" onchange="getvalue()">
<option value="ALL">ALL</option>
<%
vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
System.out.println("vendor1"+vendor1);
ResultSet rstvendor=st1.executeQuery(vendor1);
while(rstvendor.next())
{

	 ven=rstvendor.getString("Vendor") ;
%>
<option><%=rstvendor.getString("Vendor") %></option>
<%} %>


</select>
</td>
<td>
Category<select name="category" id="category" onchange="getvalue()">
<option value="ALL">ALL</option>
<%
category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
//System.out.println("vendor1"+vendor1);
ResultSet rstcategory=st12.executeQuery(category1);
while(rstcategory.next())
{

	 String tripcategory=rstcategory.getString("TripCategory") ;
%>
<option value="<%=tripcategory %>"><%=tripcategory %></option>
<%} %>


</select>

</td>

<td>
StartPlace<select name="startp" id="startp" onchange="getvalue()">
<option value="ALL">ALL</option>
<%
startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";

ResultSet rststartp=st13.executeQuery(startp1);
while(rststartp.next())
{

	 String startp=rststartp.getString("StartPlace") ;
%>
<option value="<%=startp %>"><%=startp %></option>

<%} %>


</select>

</td>
<td>
EndPlace<select name="endp" id="endp" onchange="getvalue()">
<option value="ALL">ALL</option>
<%
endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";

ResultSet rstendpp=st14.executeQuery(endp1);
while(rstendpp.next())
{

	 endp=rstendpp.getString("EndPlace") ;
%>
<option value="<%=endp %>"><%=endp %></option>

<%} %>


</select>

</td>


</tr>
</table>

<%

if(!(null==request.getQueryString()))
{
try
{
	
	 if(statusname.equals("Closed"))
		{
		  if(vendername.equals("ALL") && categoryname.equals("ALL") && startplacename.equals("ALL") && endplacename.equals("ALL"))
		  {
		  
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  order by StartDate ";
		  
		  }
		 //a - - -
		  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and  TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' order by StartDate ";
		  }
		//- a - -
		  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' order by StartDate ";
		  }
		//- - a -
		  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and EndPlace='"+endplacename+"' order by StartDate ";
		  }
		//- - - a
		  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and Vendor='"+vendername+"' and TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"'  order by StartDate "; 
		  }
		//- - - -
		  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' order by StartDate ";	  
		  }
		//a a - -
		  else  if(vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and StartPlace='"+startplacename+"' and EndPlace='"+endplacename+"' order by StartDate ";	  
		  }
		//a a a -
		  else  if(vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and EndPlace='"+endplacename+"' order by StartDate ";	  
		  }
		//a - a -
		  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'    and TripCategory='"+categoryname+"' and EndPlace='"+endplacename+"' order by StartDate ";	  
		  }
		//a - - a
		  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and TripCategory='"+categoryname+"' and StartPlace='"+startplacename+"'   order by StartDate ";	  
		  }
		//- a a a
		  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and Vendor='"+vendername+"'  order by StartDate ";	  
		  }
		//- - a a
		  else  if(!vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  and Vendor='"+vendername+"' and TripCategory='"+categoryname+"'  order by StartDate ";	  
		  }
		//- a a -
		  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (!endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and Vendor='"+vendername+"'  and EndPlace='"+endplacename+"' order by StartDate ";	  
		  }
		  //- a - a 
		  else  if(!vendername.equals("ALL") && (categoryname.equals("ALL")) && (!startplacename.equals("ALL")) && (endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and Vendor='"+vendername+"'  and StartPlace='"+startplacename+"'  order by StartDate ";	  
		  }
		//a - a a 
		  else  if(vendername.equals("ALL") && (!categoryname.equals("ALL")) && (startplacename.equals("ALL")) && (endplacename.equals("ALL")))
		  {
			  Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'   and TripCategory='"+categoryname+"'  order by StartDate ";	  
		  }
		  
		  
	
	
%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<font  size="3"><B>
My Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B>
</font>

<div class="bodyText" align="right">
<input type="button" value="More Info" onclick="showhide2();" class="formElement" id="tds" name="tds" >&nbsp;&nbsp;
</div>

</td>
<td id="print">

<!--  <input type="button" value="Show Fuel Info" onclick="showhide2();" class="formElement" id="tds" >-->
<a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
</td>
<td id="excel">
 <a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%> 
</td>
</tr>
</table>
<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>Trip ID</th>
<th>Driver</th>
<th>Veh.</th>
<th id="tdd0" style="text-align: left; display: none"> Desc</th>
<th id="tdm0" style="text-align: left; display: none"> Model</th>
<th id="tdt0" style="text-align: left; display: none">Type</th>
<th>Owner</th>
<th id="tdw0" style="text-align: left; display: none">Weight (kg)</th>
<th id="tdv0" style="text-align: left; display: none">Vendor</th>
<th id="tdr0" style="text-align: left; display: none">Report DateTIme</th>
<th>Start Date Time</th>
<th>Origin</th>
<th>End Date Time</th>
<th id="tdu0" style="text-align: left; display: none">Unload Date Time</th>
<th>Destination</th>
<th>Fixed Distance</th>
<th>Fixed Time</th>
<th>KM Traveled</th>
<th>Time Taken</th>
<th id="tdl0" style="text-align: left; display: none">Load Delay (hh:mm:ss)</th>
<th id="tdul0" style="text-align: left; display: none">Unload Delay (hh:mm:ss)</th>
<th>Trip Rating</th>
<th>Closed By</th>

<!-- th>% Diff in Distance</th> -->
</tr>
<%
 
	  
    System.out.println("Our exact query>>>>"+Sqlv); 
	ResultSet rstcloser=st15.executeQuery(Sqlv);
	
	
	
	

	//result set from Veh Details

	int i=0,dist1,dist2;
	java.util.Date enddte1,strdte1;

	double stdDist=0,stdTme=0,capDist=0;
	String SDate,EDate,STime,ETime,tripid,StDate,EdDate;
	long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0,etime;
	String fromdate="",todate="";
	int ftime1=0;
	int ftime2=0;
	int ttime1=0;
	int ttime2=0;
	String vehdesc="-",vehmodel="-",vehtype="-",endedby="-",weight="-",vendor="-",reptdttme="-", unloaddt="-";
	String sdate,edate,LoadingDelay,UnloadingDelay;
	int KmTravelled=0;

	while(rstcloser.next())
	{
	//StDate=rst.getDate("StartDate");
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
		System.out.println("sdate  "+sdate);
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
		 ftime1=dt.getHours();
		 ftime2=dt.getMinutes();
		}
		catch(Exception e)
	  	{
	  		ftime1=00;
	  		ftime1=00;
	  	}

		 edate=EDate;
		 System.out.println("edate  "+edate);
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
		 ttime1=edt.getHours();
		 ttime2=edt.getMinutes();
		}
		catch(Exception e)
	  	{
	  		ttime1=23;
	  	 	ttime2=59;
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
	/*
	millisecdiff=miliseconds2-miliseconds1;

	secdiff=millisecdiff/1000;

	mindiff=secdiff/60;//5217 
	hrdiff=mindiff/60;
	*/


	//out.println("iii"+i);
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

	%>
	<tr>

	<td style="text-align: right"><%=i%></td>

	<td><div align="right"  >
	<font size="10">

	<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=rstcloser.getString("TripId")%></font></a> </font><br />
	<div class="popup" id="popup<%=i%>">
	<table border="1" bgcolor="white">

	<tr>
	<td><a href="detailed_report.jsp?vehcode=<%=rstcloser.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
	</td>
	</tr>
	<tr>
	<!--  <td><a href="show_custom_detail_rept_onMap.jsp?tripid=< %=rst.getString("Tripid")%>&vehcode=< %=rst.getString("VehId")%>&fromdata=< %=fromdatetime%>&todata=< %=todatetime%>&ftime1=< %=ftime1 %>&ftime2=< %=ftime2 %>&ttime1=< %=ttime1 %>&ttime2=< %=ttime2 %>&vehregno=< %=rst.getString("VehRegNo")%>&ownername=< %=session.getAttribute("user").toString()%>&startplace=< %=rst.getString("StartPlace")%>&endplace=< %=rst.getString("EndPlace")%>&EDate=< %=rst.getString("EndDate")%>&pg=cm" onclick="javascript:toggleDetails(< %=i%>,false);">Show On Map</a>-->

	</tr>


	<tr><td>
	<a href="#" onclick="javascript:window.open('endtrip1.jsp?tripid=<%=rstcloser.getString("Tripid")%>&EDate=<%=EDate%>&ETime=<%=ETime%>&vehcode=<%=rstcloser.getString("VehId")%>','','menubar=1,resizable=2,width=770,height=350,location=no');">Change Unload Time</font> </a>
	<!-- <a href="endtrip1.jsp?tripid=<%=rstcloser.getString("Tripid")%>&EDate=<%=EDate%>&ETime=<%=ETime%>&vehcode=<%=rstcloser.getString("VehId")%>">Change Unload Time</a> -->
	</td>
	<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
	</table>
	</div> 
	</div></td>

	<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>

	<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>

	<%
	String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"'";
	ResultSet rst3=stt2.executeQuery(sql3);
	System.out.println("veh desc"+sql3);
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

	%>

	<td id="tdd<%=i%>" style="text-align: left;display: none;"><%=vehdesc%></td>
	<td id="tdm<%=i%>" style="text-align: left;display: none;"><%=vehmodel%></td>
	<td id="tdt<%=i%>" style="text-align: left;display: none;"><%=vehtype%></td>
	<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>



	<%

	String sql="Select EndedBy,Weight,Vendor,ReportDateTime from t_startedjourney where tripid='"+tripid+"'";
	//System.out.println(sql);
	ResultSet rss=st2.executeQuery(sql);
	if(rss.next())
	{
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
		 
	}
	else
	{
		 endedby="-";
		 weight="-";
		 vendor="-";
		 reptdttme="-";
	} //out.println("Mila");

	%>
	 <td id="tdw<%=i%>" style="text-align: left; display: none;"><%=weight%></td>
	 <td id="tdv<%=i%>"style="text-align: left; display: none;"><%=vendor%></td>
	 <td id="tdr<%=i%>" style="text-align: left; display: none;"><%=reptdttme%></td>
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

	<td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>

	<td style="text-align: left"><%
	try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
	}catch(Exception ee)
	{
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
	}
	%>
	</td>
	<td id="tdu<%=i%>"style="text-align: left; display: none;"><%
	try{ 
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
	}catch(Exception ee)
	{
		out.print("-");
	}
	%>
	</td>
	<td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
	<%
	//*********************************************query is changed*****************************************************
	sql="select * from t_castrolroutes where StartPlace='"+rstcloser.getString("StartPlace")+"' and EndPlace='"+rstcloser.getString("EndPlace")+"'";
	ResultSet rstdist=st1.executeQuery(sql);
	if(rstdist.next())
	{ 
		stdDist=rstdist.getDouble("Km");
		stdTme=rstdist.getDouble("TTime");
	}
	else
	{
		stdDist=0;
		stdTme=0;
	}


	if(stdDist==0)
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

	/*
	sql="select * from t_veh"+rst.getString("VehId")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+rst.getString("StartDate")+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+rst.getString("EndDate")+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1 ";
	//System.out.println(sql);
	ResultSet rstdist1=st2.executeQuery(sql);
	if(rstdist1.next())
	{
	dist1=rstdist1.getInt("Distance");
	//System.out.println(dist1);
	}
	else
	{
		dist1=0;
	}
	String sql11="select * from t_veh"+rst.getString("VehId")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+rst.getString("StartDate")+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+rst.getString("EndDate")+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) Desc limit 1";
	//out.print(sql);
	ResultSet rstdist2=st2.executeQuery(sql11);

	if(rstdist2.next())
	{
	dist2=rstdist2.getInt("Distance");
	//System.out.println(dist2);
	}
	else
	{
		dist2=0;	
	}
	capDist=dist2-dist1;
	if(capDist<0)
	{
	out.print("0");
	}
	else
	{ 
	out.print(dist2-dist1);
	//System.out.println(capDist);
	}*/
	%> 
	</td>--> 

	<td style="text-align: left">
	<%
	try{

	//String enddte=rst.getString("EndDate");
	//String endtme=rst.getString("EndTime");
	//String strtdte=rst.getString("StartDate");
	//String strtime=rst.getString("StartTime");

	//enddte=enddte+" "+endtme;
	//strtdte=strtdte+" "+strtime;
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
		/*	
		if(mins>=60)
		{
		hrdiff=hrdiff+1;
		mins=mins-60;
	  	out.print(hrdiff+"hrs"+mins+"mins");
		}else
		{
			
			out.print(hrdiff+"hrs"+mins+"mins");
		}
	}
	else
	{   hrdiff=mins11/60;
		mins=mins11%60;
		
	out.print(hrdiff+" hrs "+mins+" mins");
	}
	*/
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

	<td id="tdl<%=i%>" style="text-align: right; display: none;"><%=LoadingDelay%></td>
	<td id="tdul<%=i%>"style="text-align: right; display: none;"><%=UnloadingDelay%></td>
	<%
	NumberFormat nf1=NumberFormat.getInstance();
	nf1.setMaximumFractionDigits(2);
	nf1.setMinimumFractionDigits(2);
	%>

	<td style="text-align: right"><%=nf1.format(rstcloser.getInt("TripRating"))%></td>

	<%

	sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
	System.out.println(sql);
	rss=st2.executeQuery(sql);
	System.out.print(rss.next());
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
	
	

	

	<%
	}
	%>



















	</tr> 

	
	
	<%
}
else
{

String dateformat="dd-MMM-yyy";
Statement   st4;
String sql, sql1, sql2,sql3;
ResultSet rs2=null;
String today="",lastweek="", lastmonth="",startDate="",startCode="",startTime="",endCode="",TransTime="",updatedTm="",scheTmDt="",updtetime="",DisDate="";
int km1=0,km2=0,km3=0,km4=0,km5=0,km6=0,km7=0,km8=0,km9=0, kmrun1=0, kmrun2=0, kmrundist=0, totKm=0,remKm=0,todaysdist=0;
long diffDays=0,tTime=0;
java.util.Date dt1 = null;
//String tempUpDate;
	st4=conn.createStatement();

%>	
	</td>
	</tr>
	</table>
	<table class="sortable">
	<tr>
	<th class="head" valign="top"> Sr </th>
	<th  class="hed" id="vehcol" valign="top"> <a href="#" onClick="hide('veh');" title="Click to hide TripId,Driver,StartDate,StartPlace,EndPlace Cols"><img id="img11" src="images/sub.jpg" width="13px" height="10px" border="0"> </a> <br> <B>Vehicle</B></th> 
	<th class="hed" id="tripcol" valign="top">  <br> <B> TripID</B></th>
	<th class="hed" id="drivcol" valign="top">  <br> <B> Driver</B></th>
	<th class="hed" id="stdatecol" valign="top">  <br> <B>Start Date-Time</B></th>
	<th class="hed" id="stplacecol" valign="top"> <br> <B> Start Place</B></th>
	<th class="hed" id="endplacecol" valign="top">  <br> <B> End Place</B></th>
	<th class="hed" id="updtetmecol" valign="top"> <br> <B>Updated Dat-Time</B></th>
	<th class="hed" id="curposcol" valign="top"> <br> <B>Current Position</B></th>
	<th class="hed" id="FixedTimecol" valign="top"> <br> <B>FixedTime</B></th>
	<th class="hed" id="FixedKmcol" valign="top"> <br> <B>FixedKm</B></th>
  	<!--<th class="hed" id="kmsruncol" valign="top"> <a href="#" onClick="hide('kmsrun');" title="Click to hide KmsToRun,ETA Cols"> <img src="images/sub.jpg" id="img2" width="13px" height="10px" border="0"></a> <br><B>Kms run</B></th>-->
  	<th class="hed" id="kmsruncol" valign="top"><br><B>Kms run</B></th>
 	<th class="hed" id="kmstoruncol" valign="top">  <br><B>Kms to run</B></th>  
	<th class="hed" id="etacol" valign="top">  <br> <B>Scheduled Date-Time To Arrival</B></th>
<!-- 	<td class="hed" id="fuelconscol" valign="top"> <a href="#" onClick="hide('fuelcons');" title="Click to hide LoadingDelay,TransitTime"> <img src="images/sub.jpg" id="img3" width="13px" height="10px" border="0"></a> <br> <B>Fuel Consumption</td>
	<td class="hed" id="loaddelcol" valign="top">   <br> <B>Loading Delay</td> 
	<td class="hed" id="trantmecol" valign="top">  <br><B>Transit Time</td> 
-->	</tr>
	<%
	sql="select * from t_startedjourney where Jstatus='Running' and Vehid in"+session.getAttribute("VehList").toString()+" order by StartDate desc";
	ResultSet rsttrips=st.executeQuery(sql);
	int j=1;
	while(rsttrips.next())
	{
		String curpos="",  lat="", lon="";
		 kmrundist=0;
		String vehno=rsttrips.getString("VehRegNo");
		sql="select * from t_onlinedata where VehicleCode='"+rsttrips.getString("VehId")+"'";
		//out.print(sql);
		ResultSet rs1=st1.executeQuery(sql);
		
		try{
			if(rs1.next())
			{
				curpos=rs1.getString("Location");
				updtetime=new SimpleDateFormat(dateformat).format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))+" "+rs1.getString("TheTime");
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
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDate >='"+rsttrips.getString("StartDate")+"' and TheFieldDataTime>='"+rsttrips.getString("StartTime")+"' and TheFiledTextFileName='SI' order by TheFieldDataTime asc limit 1";
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
				sql="select Distance from t_veh"+rsttrips.getString("VehId")+" where TheFieldDataDate ='"+today+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1";
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
		tTime=0;
		//sql="select sum(Distance) as kmrundist from t_veh"+rsttrips.getString("VehId")+"_ds where TheDate>='"+rsttrips.getDate("StartDate")+"'and TheTime>='"+rsttrips.getTime("StartTime")+"' and startCode>='"+rsttrips.getString("StartCode")+"' and endCode>='"+rsttrips.getString("EndCode")+"' ";
		sql="select * from db_gps.t_startedjourney where StartDate='"+rsttrips.getDate("StartDate")+"'and StartTime='"+rsttrips.getTime("StartTime")+"' and StartCode='"+rsttrips.getString("StartCode")+"' and EndCode='"+rsttrips.getString("EndCode")+"' and Vehid="+rsttrips.getString("VehId")+"";
		///System.out.println(":::---SQL----:::"+sql);
		ResultSet rstTotKm=st3.executeQuery(sql);
		if(rstTotKm.next())
		{
			sql3="select * from db_gps.t_castrolroutes where StartCode='"+rsttrips.getString("StartCode")+"' and EndCode='"+rsttrips.getString("EndCode")+"' ";
			//System.out.println(":::---SQL2----:::"+sql3);
			ResultSet rst123=st4.executeQuery(sql3);
				if(rst123.next())
				{
					totKm=rst123.getInt("Km");
				    tTime=rst123.getInt("TTime");
				}
		}
		kmrundist=kmrun2-kmrun1;  //Finding tot run km by vehicle after trip started.
		remKm=totKm-kmrundist;  // Adding todays km also
		
		myMilisec=(tTime*60*60*1000);
		if(myMilisec!=0)
		{
		//System.out.println(":::::-myMilisec-::::"+myMilisec);
      	java.util.Date resultdate = new java.util.Date();
      	java.util.Date startDtTm=rsttrips.getDate("StartDate");
      	
		//System.out.println(":::::-startDtTmOriginal-::::"+startDtTm);
		long start=startDtTm.getTime();
		long totdate= start+myMilisec;
		resultdate.setTime(totdate);
        DisDate=new SimpleDateFormat(dateformat+" HH:mm:ss").format(resultdate);
		//System.out.println(":::::-startDtTmAftAdd-::::"+DisDate);
		}
		else{
			DisDate="NA";
		}
	}catch(Exception e11)
	{
		System.out.println("---I am in exception--kmrundist-");
		e11.printStackTrace();
	}
	%>
	<tr>
	<td style="text-align: right"><%=j%></td>
	<td id="vehcol<%=j%>" style="text-align: left"><b><div align="left">  <%=rsttrips.getString("VehRegNo")%> </div></b></td>
	<td id="tripcol<%=j%>" style="text-align: right"><font size="2"><%=rsttrips.getString("TripId")%></font></td>
	<td id="drivcol<%=j%>"><div align="left"><%=rsttrips.getString("DriverName")+"("+rsttrips.getString("DriverCode")+")"%></div></td>
	<td id="stdatecol<%=j%>" style="text-align: left">
	<% try{
	out.print(new SimpleDateFormat(dateformat+" HH:mm:ss").format(rsttrips.getDate("StartDate")));
	}catch(Exception ee)
	{
		System.out.print(rsttrips.getString("StartDate"));
		out.print("-");
	}
	%></td>
	<td id="stplacecol<%=j%>"><div align="left"><%=rsttrips.getString("StartPlace")%></div></td>
	<td id="endplacecol<%=j%>"><div align="left"><%=rsttrips.getString("EndPlace")%></div></td>
	<td id="updtetmecol<%=j%>"><div align="left"><%=updtetime%> </div></td>
	<td id="curposcol<%=j%>"><div align="left"> 
	<a href="shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>&discription=<%="<b>" + vehno + "</b><br>"%><%=curpos%>','myWin','width=500,height=500');popWin.focus();return false">
	<%=curpos%> </div></td>
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			%>
				<td id="FixedTimecol<%=j%>"> <br> NA</td>
				<td id="FixedKmcol<%=j%>"> <br>NA</td>
				
			<%
		}
		else
		{
			%>
				<td id="FixedTimecol<%=j%>"> <br> <%=tTime%></td>
				<td id="FixedKmcol<%=j%>"> <br> <%=totKm %></td>
				
			<%
		}
	
	%>
	
	<td id="kmsruncol<%=j%>"> <div align="left"><%=kmrundist%></div></td>  
	<%
		if(DisDate.equalsIgnoreCase("NA"))
		{
			%>
				
				<td id="kmstoruncol<%=j%>"><div align="left">NA</div></td>
			<%
		}
		else
		{
			%>
				
				<td id="kmstoruncol<%=j%>"><div align="left"><%=remKm%></div></td>
			<%
		}
	
	%>
 	
	<td id="etacol<%=j%>"><div align="left"><%=DisDate%> </div></td>
	
	</tr>
	<%
	j++;
	}
	//out.println("===end of 1st table===");
	%>
	</table>
	<p></p>
	</td>
	</tr>
	<tr><td>
	<table class="sortable" valign="top">
	<tr>

	<td colspan="5"><b><font color="brown" size="2">The Kilometer Analysis Report.</font></b>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#" onclick="javascript:window.open('printkmanalysis.jsp');" title="Print Report">
			<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
			<a href="excelkmanalysis.jsp" title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px">
			</a>
	&nbsp;&nbsp;&nbsp;&nbsp;<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>  
	</td>
	</tr>
	</table>
	
<%

}
%>	
	
	
	 
<%


}
catch(Exception e)
{
out.print("Exception -->"+e);
}
finally
{
conn.close();
conn1.close();
}
}

%>
</td></tr>
</table>

<%@ include file="footernew.jsp" %>