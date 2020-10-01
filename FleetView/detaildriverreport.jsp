<%@ include file="headernew.jsp" %>
<%@page import="java.util.Date"%>
  	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<script>
function getvalue()	{
	     var Driver2=document.getElementById("Driver").value;
		var vender2=document.getElementById("vendor").value;
		document.getElementById("vend1").value=vender2;
		var category2=document.getElementById("category").value;
		document.getElementById("cat1").value=category2;
		var startp2=document.getElementById("startp").value;
		document.getElementById("startpl1").value=startp2;
		var endp2=document.getElementById("endp").value;
		document.getElementById("endpl1").value=endp2;
		}
		</script>
		<script>
function statuscloser()
{
var stat=document.getElementById("status").value;
	if(stat=="Driver Wise Trips")
	{
		document.getElementById("tddrv").style.display='';
		document.getElementById("tdvh").style.display='none';
		document.getElementById("tdvend").style.display='';
		document.getElementById("tdcat").style.display='';
		document.getElementById("tdstpl").style.display='';
		document.getElementById("tdendpl").style.display='';
		}
	else 
	{
		document.getElementById("tddrv").style.display='none';
		document.getElementById("tdvh").style.display='none';
		document.getElementById("tdvend").style.display='';
		document.getElementById("tdcat").style.display='';
		document.getElementById("tdstpl").style.display='';
		document.getElementById("tdendpl").style.display='';
		
	}
	}	
	</script>
<script language="javascript">

  function validate()
  {
	  var myDate = new Date(document.getElementById("data1").value);
	  
  if(document.getElementById("data1").value=="")  {
    alert("Please select the from date");
  return false;  }
  if(document.getElementById("data2").value=="")  {
    alert("Please select the to date");
  return false;  }
  return true;  }
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
if(dy1>year || dy2>year){
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;}
else if(year==dy1 && year==dy2) if(dm1>month || dm2>month){
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;}
if(dm1==month){
if(dd1>day || dd2>day){
alert("selected date should not be greater than todays date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;}}
if(dy1>dy2){
alert("From date year is should not be greater than to date year");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;}
else if(year==dy1 && year==dy2) if(dm1>dm2){
alert("From date month is should not be greater than to date month");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;}
if(dm1==dm2) {
if(dd1 > dd2){
alert("From date is should not be greater than to date");
document.getElementById("data1").value="";
document.getElementById("data2").value="";
document.getElementById("data1").focus;
return false;}}
return true;}
  </script>
  <script type="text/javascript">
function toggleDetails(id,show){
	var popup = document.getElementById("popup"+id);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();
} else {
popup.style.visibility = "hidden";
 }}
function toggleDetails2(id,show){
	var temp="popup_"+id;
var popup = document.getElementById(temp);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();
} else {
popup.style.visibility = "hidden";
 }}
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
Statement st,st1,st2,st3,st11,stt1,stt2,st12,st13,st14,st15,st16,st4,sto,st20,st21,st22,strep;
String fromdate, todate,sql,sql1,sql2,sql3,transporter,pageflag,datenew1,datenew2,fromdatetime,todatetime, vendor1,category1,startp,endp,ven,startp1,endp1,vendername,
categoryname,startplacename,endplacename,statusname,vehino,vehicleno,vehiclecode,Sqlv="",distributorname="",Driver=null;
 String sqlname=null,briefing="",sqlbrif=null,Dbriefing="",etaclose="",reportclose="",drivername="",driv="";
%>
<%
Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
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
st16=conn.createStatement();
sto=conn.createStatement();
st4=conn.createStatement();
st20=conn.createStatement();
st21=conn.createStatement();
st22=conn.createStatement();
strep=conn.createStatement();

%>
<%
if(!(null==request.getQueryString())){
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
transporter=request.getParameter("transporter");
%>
<input type="hidden" id="data11" name="data11" value="<%=fromdate %>"></input>
<input type="hidden" id="data22" name="data22" value="<%=todate %>"></input>
<input type="hidden" id="transporter1" name="transporter1" value="<%=transporter %>"></input>
<%
session.setAttribute("reportno","Report No:9.0");
datenew1=request.getParameter("data1");
System.out.println("datenew1---->"+datenew1);
datenew2=request.getParameter("data2");
vendername=request.getParameter("vendor");
categoryname=request.getParameter("category");
startplacename=request.getParameter("startp");
endplacename=request.getParameter("endp");
statusname=request.getParameter("status");
vehino=request.getParameter("vehicle");
drivername=request.getParameter("Driver");
System.out.println("drivername---->"+drivername);
pageflag="MyTrip";
if(vehino.length()>0){
	int i=vehino.indexOf(',');
	vehino=vehino.substring(i+1);}
System.out.println("vendername---->"+vendername);
System.out.println("categoryname---->"+categoryname);
System.out.println("startplacename---->"+startplacename);
System.out.println("endplacename---->"+endplacename);
System.out.println("statusname---->"+statusname);
System.out.println("vehino---->"+vehino);
System.out.println("vehicleno---->"+vehicleno);
//System.out.println("vendername"+vendername+"categoryname"+categoryname+"startplacename"+startplacename+"endplacename"+endplacename+"statusname"+statusname);
System.out.println(""+fromdate);}
else{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;
statusname="Open";
vendername="ALL";
categoryname="ALL";
startplacename="ALL";
endplacename="ALL";
drivername="All";
System.out.println("Not in querystring");}
%>
<form name="dateform" action="" method="get" onsubmit="return validate();">
<table border="0" width="100%" align="center" class="stats">
<tr><td align="center">
<font size="3"><B>My Trips Report</B></font>
</td></tr>
</table>
<table border="0" width="500" align="center" class="sortable_entry">
<tr>
<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data1" name="data1" class="element text medium" style="width: 100px" value="<%=datenew1%>"  size="15" readonly/>
  </td><td align="left">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }  );
</script></td><td>
<b>To</b> &nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="data2" name="data2" class="element text medium" style="width: 100px" value="<%=datenew2%>" size="15" readonly/></td><td align="left">
<!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }  );
</script></td>
<%
System.out.println("Not in querystring---->?"+statusname);
%>
<td><b>Status</b>
<select id="status" name="status" class="element select medium" style="width: 200px" onChange="statuscloser(this.value)">
<option value="Driver Wise Trips"  <% if(statusname.equals("Driver Wise Trips")){ %>Selected<% } %>>Driver Wise Trips</option>
<option value="Vendor Wise Trips"  <% if(statusname.equals("Vendor Wise Trips")){ %>Selected<% } %>>Customer Wise Trips</option>
</select></td><td>
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<!--<input type="hidden"  name="vend1" id="vend1" value=""></input>-->
<!--<input type="hidden"  name="cat1" id="cat1" value=""></input>-->
<!--<input type="hidden" name="startpl1" id="startpl1" value=""></input>-->
<!--<input type="hidden"  name="endpl1" id="endpl1" value=""></input>-->
<input type="hidden"  name="colorvalue" id="colorvalue" value="all"></input>
&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="ubmit" id="submit" style="border-style: outset; border-color: black" value="Submit"></td>
</table></tr>
<table border="0" width="750" class="sortable_entry">
<tr>
<% if(statusname.equals("Driver Wise Trips")){
%>
<td id="tddrv" style="display:"><b>
Driver</b><select name="Driver" class="element select medium" style="width: 100px" id="Driver" onchange="getvalue()">
<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
System.out.println("DriverName"+Driver);
ResultSet rstdriver=st1.executeQuery(Driver);
while(rstdriver.next())
{	driv=rstdriver.getString("DriverName") ;
%>
<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
<%} %>
</select></td>
<td id="tdvh" style="display: none;">
	<b>Vehicle <select name="vehicle" id="vehicle" class="element select medium" style="width: 100px" onchange="getvalue()">
	<% 
			sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				out.println(rst.getString("VehicleRegNumber"));
			%>
			<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"><%=rst.getString("VehicleRegNumber")%></option>						
			<%
			}		
				
	%>			
	</select></b></td>
<td id="tdvend" style=""><b>
Customer</b><select name="vendor" class="element select medium" style="width: 100px" id="vendor" onchange="getvalue()">
<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by Vendor";
System.out.println("vendor1"+vendor1);
ResultSet rstvendor=st1.executeQuery(vendor1);
while(rstvendor.next())
{	 ven=rstvendor.getString("Vendor") ;
%>
<option value="<%=ven%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
<%} %>
</select></td>
<td id="tdcat" style=""><b>
Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
<option value="ALL" <% if(categoryname.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
ResultSet rstcategory=st12.executeQuery(category1);
while(rstcategory.next()){
	 String tripcategory=rstcategory.getString("TripCategory") ;
%>
<option value="<%=tripcategory %>" <% if(categoryname.equals(tripcategory)){ %>Selected<% } %>><%=tripcategory %></option>
<%} %>
</select></td>
<td id="tdstpl" style=""><b>
StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by StartPlace ";
ResultSet rststartp=st13.executeQuery(startp1);
while(rststartp.next()){
	 String startp=rststartp.getString("StartPlace") ;
%>
<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %> ><%=startp %></option>
<%} %>
</select></td>
<td id="tdendpl" style=""><b>
EndPlace</b><b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by EndPlace";
ResultSet rstendpp=st14.executeQuery(endp1);
while(rstendpp.next()){
	 endp=rstendpp.getString("EndPlace") ;
%>
<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %> ><%=endp %></option>
<%} 
%>
</select></b></td>
<%}
//********************************************************
else {
%>
<td id="tddrv" style="display:none;"><b>
Driver</b><select name="Driver" class="element select medium" style="width: 100px" id="Driver" onchange="getvalue()">
<option value="ALL" <% if(drivername.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
Driver="select Distinct(DriverName) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by DriverName";
System.out.println("DriverName"+Driver);
ResultSet rstdriver=st1.executeQuery(Driver);
while(rstdriver.next())
{	driv=rstdriver.getString("DriverName") ;
%>
<option value="<%=driv%>" <% if(drivername.equals(rstdriver.getString("DriverName"))){ %>Selected<% } %> ><%=rstdriver.getString("DriverName") %></option>
<%} %>
</select></td>
<td id="tdvh" style="display: none;">
	<b>Vehicle</b><select name="vehicle" class="element select medium" style="width: 100px" id="vehicle">
	<% 
			sql="select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber";
			ResultSet rst=st.executeQuery(sql);
			while(rst.next())
			{
				out.println(rst.getString("VehicleRegNumber"));
				String veh = rst.getString("VehicleRegNumber");
				
			%>
			<option value="<%=rst.getString("VehicleCode")%>,<%=rst.getString("VehicleRegNumber")%>"><%=rst.getString("VehicleRegNumber")%></option>						
			<%			}		
		%>			
	</select></td>
<td id="tdvend" style=""><b>
Customer</b>
<select name="vendor" id="vendor" class="element select medium" style="width: 100px" onchange="getvalue()">
<option value="ALL" <% if(vendername.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
vendor1="select Distinct(Vendor) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by Vendor ";
System.out.println("vendor1"+vendor1);
ResultSet rstvendor=st1.executeQuery(vendor1);
while(rstvendor.next()){
	 ven=rstvendor.getString("Vendor") ;
%>
<option value="<%=rstvendor.getString("Vendor")%>" <% if(vendername.equals(rstvendor.getString("Vendor"))){ %>Selected<% } %> ><%=rstvendor.getString("Vendor") %></option>
<%} %>
</select></td>
<td id="tdcat" style=""><b>
Category</b><select name="category" class="element select medium" style="width: 100px" id="category" onchange="getvalue()">
<option value="ALL" <% if(statusname.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
category1="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' ";
ResultSet rstcategory=st12.executeQuery(category1);
while(rstcategory.next()){
	 String tripcategory=rstcategory.getString("TripCategory") ;
%>
<option value="<%=tripcategory %>"><%=tripcategory %></option>
<%} %>
</select></td>
<td id="tdstpl" style=""><b>
StartPlace</b><select name="startp" class="element select medium" style="width: 150px" id="startp" onchange="getvalue()">
<option value="ALL" <% if(startplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
startp1="select Distinct(StartPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by StartPlace";
ResultSet rststartp=st13.executeQuery(startp1);
while(rststartp.next()){
	 String startp=rststartp.getString("StartPlace") ;
%>
<option value="<%=startp %>" <% if(startplacename.equals(startp)){ %>Selected<% } %>><%=startp %></option>
<%} %>
</select></td>
<td id="tdendpl" style=""><b>
EndPlace</b><select name="endp" class="element select medium" style="width: 150px" id="endp" onchange="getvalue()">
<option value="ALL" <% if(endplacename.equals("ALL")){ %>Selected<% } %>>ALL</option>
<%
endp1="select Distinct(EndPlace) from t_startedjourney where OwnerName='"+session.getAttribute("usertypevalue").toString()+"' order by EndPlace";
ResultSet rstendpp=st14.executeQuery(endp1);
while(rstendpp.next())
{
	 endp=rstendpp.getString("EndPlace") ;
%>
<option value="<%=endp %>" <% if(endplacename.equals(endp)){ %>Selected<% } %>><%=endp %></option>
<%} %>
</select></td>
<%}
%>

</table>
<br><br>

<%
try{
if(!(null==request.getQueryString())){
		String sum="";
	 if(vendername =="All" || vendername.equalsIgnoreCase("All"))
	 {
		 sum=sum+"";
	 }
	 else 	 {
		
		 sum= sum+" and Vendor='"+vendername+"'";	 }
		 if(categoryname=="All" || categoryname.equalsIgnoreCase("All"))	 {
		 sum=sum+"";	 }
	 else	 {
		 
		 sum=sum+" and TripCategory='"+categoryname+"'";	 }
	 
	 if(startplacename=="All" || startplacename.equalsIgnoreCase("All"))	 {
		 sum=sum+"";	 }
	 else	 {
		 
		 sum=sum+" and StartPlace='"+startplacename+"'";	 }
	 
	 if(endplacename=="All" || endplacename.equalsIgnoreCase("All"))	 {
		 sum=sum+"";	 }
	 else	 {
		 
		 sum=sum+" and EndPlace='"+endplacename+"'";	 }
	 if(drivername=="All" || drivername.equalsIgnoreCase("All"))	 {
		 sum=sum+"";	 }
	 else	 {
		 
		 sum=sum+" and DriverName='"+drivername+"'";	 }
	
 if(statusname.equalsIgnoreCase("Driver Wise Trips"))
{
		String fromdate1="",todate1="";
		vehino=request.getParameter("vehicle");
		StringTokenizer stk = new StringTokenizer(vehino,",");
		String vehiclecode=stk.nextToken();
		String vehicleno=stk.nextToken();
		Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from db_gps.t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  "+sum+" GROUP BY  DriverName ORDER BY DriverName ";
		//Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and VehRegNo='"+vehicleno+"' "+sum+" order by StartDate ";
	%>
	<table border="0" width="800" align="center">
	<tr align="center">
<!--	<td align="center" colspan="24" width="70%">-->
<!--	<font color="brown" size="3">The Trip Report for Vehicle < %=vehicleno%> from < %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to < %=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>-->
<!--	<div class="bodyText" align="right">-->
<!--	<input type="button" value="More Info" onclick="showhide2();" class="formElement" id="tds" name="tds" >&nbsp;&nbsp;-->
<!--	</div></td>-->
	<td id="print" colspan="1" width="100">
	<a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
	</td>
	<td id="excel" colspan="1" width="100">
	<a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
	<td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
	</td></tr></table>
	<table border="1" class="sortable" width="100%">
	<tr>
	<th>Sr.</th>
	<th>Trip ID</th>
	<th>Driver</th>
	<th>Veh</th>
<!--	<th id="vehcolveh"><a href="#" onClick="hide4('veh');" title="Click to hide Desc,Mode1,Type Cols"><img id="img14" src="images/sub.jpg" width="13px" height="10px" border="0"> </a><br></br>Veh.</th>-->
	<th id="tdd0" style="text-align: left; display: none"> Desc</th>
	<th id="tdm0" style="text-align: left; display: none"> Model</th>
	<th id="tdt0" style="text-align: left; display: none">Type</th>
	<th>Owner</th>
	<th id="tdw0" style="text-align: left; display: none">Weight Kg</th>
	<th id="tdf0" style="text-align: left; display: none">Freight Rs</th>
	<th id="tda0" style="text-align: left; display: none">Advance Rs</th>
	<th>Customer</th>
	<th>Category</th>
	<th>Origin</th>
	<th id="tdr0" style="text-align: left; display: none">Report DateTIme</th>
	<th>Start Date Time</th>
	<th id="tdl0" style="text-align: left; display: none">Load Delay (hh:mm:ss)</th>
	<th id="tdldr0" style="text-align: left; display: none">Ld Delay Rsn</th>
	<th id="tdlc0" style="text-align: left; display: none">Load Comments</th>
	<th>Destination</th>
	<th>End Date Time</th>
	<th id="tdu0" style="text-align: left; display: none">Unload Date Time</th>
	<th id="tdul0" style="text-align: left; display: none">Unload Delay (hh:mm:ss)</th>
	<th id="tdudr0" style="text-align: left; display: none">Unld Delay Rsn</th>
	<th id="tduc0" style="text-align: left; display: none">Unload Comments</th>
	<th id="stkmcolveh">Std Km</th>
	<th id="sttcolveh">StdTime</th>
	<th id="kmtcolveh">KM Traveled</th>
	<th id="trptcolveh">Trip Time</th>
	<th id="oscolveh">OS</th>
	<th id="osscolveh">OS(Sec)</th>
	<th id="racolveh">RA</th>
	<th id="rdcolveh">RD</th>
	<th id="cdcolveh">CD</th>
	<th id="ndcolveh">ND</th>
	<th id="dccolveh">DC</th>
	<th id="dckmcolveh">DC Km</th>
	<th id="ratcolveh">Trip Rating</th>
	<th>Closed By</th>
	</tr>
	<%
	System.out.println("Our exact query>>>>"+Sqlv); 
	ResultSet rstcloser=st15.executeQuery(Sqlv);
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
	String vehdesc="-",vehmodel="-",vehtype="-",tripcat="-",adv="-",freight="-",loadrsn="-",loadcmt="-",endedby="-",weight="-",vendor="-",reptdttme="-",unloadcmt="-",unloadrsn="-";
	String sdate,edate,LoadingDelay,UnloadingDelay;
	int KmTravelled=0;
	while(rstcloser.next())
	{
	i++;
	SDate=rstcloser.getString("StartDate");
	EDate=rstcloser.getString("EndDate");
	STime=rstcloser.getString("StartTime");
	ETime=rstcloser.getString("EndTime");
	tripid=rstcloser.getString("TripId");
	KmTravelled=rstcloser.getInt("KmTravelled");
	LoadingDelay=rstcloser.getString("LoadingDelay");
	if(LoadingDelay==null || LoadingDelay.equalsIgnoreCase("null")){
	LoadingDelay="-";}
	UnloadingDelay=rstcloser.getString("UnloadingDelay");
	if(UnloadingDelay==null || UnloadingDelay.equalsIgnoreCase("null")){
	UnloadingDelay="-";}
	unloadcmt=rstcloser.getString("Unloadingcomments");
	if(unloadcmt==null || unloadcmt.equalsIgnoreCase("null")){
	unloadcmt="-";}
	unloadrsn=rstcloser.getString("DelayReason");
	if(unloadrsn==null || unloadrsn.equalsIgnoreCase("null")){
	unloadrsn="-";}
	if(null==STime || STime.length()>8 || STime.equals("-"))
	{STime="00:00:00";}
	if(null==ETime || ETime.equals("-"))
	{ETime="23:59:59";}
	sdate=SDate;
	System.out.println("sdate  "+sdate);
	try{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
	}
	catch(Exception e){
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
	}
	try{
	java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
	ftime1=""+dt.getHours();
	ftime2=""+dt.getMinutes();}
	catch(Exception e){
		ftime1="00";
		ftime1="00";}
	edate=EDate;
	System.out.println("edate  "+edate);
	try
	{	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));}
	catch(Exception e){	 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
	}
	try{
	java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
	ttime1=""+edt.getHours();
	ttime2=""+edt.getMinutes();}
	catch(Exception e){
		ttime1="23";
	 	ttime2="59";}
	try{
	java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00
	miliseconds1=fd.getTime();
	}catch(Exception e1){
	try{
	java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
	miliseconds1=fd.getTime();
	}catch(Exception e4){
	java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
	miliseconds1=fd.getTime();}}
	try{
	java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
	miliseconds2=fd1.getTime();
	}catch(Exception e2){
	try{
	java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
	miliseconds2=fd1.getTime();
	}catch(Exception e5){
	java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
	miliseconds2=fd1.getTime();}}
	try{
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
	fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
	}catch(Exception e){
	fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
	fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
	}
	try{
		todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
		todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
	}catch(Exception e){
	todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
	todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));
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
	</td></tr><tr>
	<td><a href="ShowCustomReportonTWMap.jsp?tripid=<%=rstcloser.getString("TripId")%>&vehcode=<%=rstcloser.getString("VehId")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rstcloser.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rstcloser.getString("StartPlace")%>&endplace=<%=rstcloser.getString("EndPlace")%>&enddate=<%=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>
	</td></tr><tr><td>
	<a href="#" onclick="javascript:window.open('TripwiseException.jsp?startDate=<%=rstcloser.getString("StartDate")%>&endDate=<%=rstcloser.getString("EndDate")%>&vehcode=<%=rstcloser.getString("VehId")%>&tripid=<%=rstcloser.getString("Tripid")%>','','menubar=1,scrollbars=1,resizeable=0,width=700,height=700');">TripWise Exception </a>
	</td></tr><tr><td>
	<a href="#" onclick="javascript:window.open('endtrip1.jsp?tripid=<%=rstcloser.getString("Tripid")%>&EDate=<%=EDate%>&ETime=<%=ETime%>&vehcode=<%=rstcloser.getString("VehId")%>','','menubar=1,resizable=2,width=770,height=350,location=no');">Change Unload Time </a>
	</td></tr>
	<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
	</table></div> </div></td>
	<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>
	<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>
	<%
	String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"' order by VehicleRegNumber";
	ResultSet rstcol=stt2.executeQuery(sql3);
	System.out.println("veh desc"+sql3);
	if(rstcol.next()){
	vehdesc=rstcol.getString("VehDesc");
	if(vehdesc==null || vehdesc.equalsIgnoreCase("null"))
	{vehdesc="-";}
	vehmodel=rstcol.getString("VehModel");
	if(vehmodel==null || vehmodel.equalsIgnoreCase("null"))
	{vehmodel="-";}
	vehtype=rstcol.getString("VehType1");
	if(vehtype==null || vehtype.equalsIgnoreCase("null")){
	vehtype="-";}}
	else{
	vehdesc="-";
	vehmodel="-";
	vehtype="-";}
	%>
	<td id="tdd<%=i%>" style="text-align: left;display: none;"><%=vehdesc%></td>
	<td id="tdm<%=i%>" style="text-align: left;display: none;"><%=vehmodel%></td>
	<td id="tdt<%=i%>" style="text-align: left;display: none;"><%=vehtype%></td>
	<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>
	<%
	String sql="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,Loadreason,Loadcomments,TripCategory,FIxedKM,FIxedTime from t_startedjourney where tripid='"+tripid+"'";
	ResultSet rss=st2.executeQuery(sql);
	if(rss.next()){
	stdDist=rss.getDouble("FIxedKM");
	stdTme=rss.getDouble("FIxedTime"); 
	endedby=rss.getString("EndedBy");
	weight=rss.getString("Weight");
	if(weight==null || weight.equalsIgnoreCase("null"))
	{	 weight="-";}
	vendor=rss.getString("Vendor");
	if(vendor.equalsIgnoreCase("select") || vendor==null || vendor.equalsIgnoreCase("null"))
	{	 vendor="-";}
	tripcat =rss.getString("TripCategory");
	if(tripcat.equalsIgnoreCase("select") || tripcat==null || tripcat.equalsIgnoreCase("null"))
	{	 tripcat="-";}
	freight =rss.getString("Frieght");
	if(freight==null || freight.equalsIgnoreCase("null"))
	{
		 freight="-";
	}adv =rss.getString("Advance");
	if(adv==null || adv.equalsIgnoreCase("null"))
	{	 adv="-";}
	try{
		 reptdttme=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rss.getString("ReportDateTime")));
		}catch(Exception ss)
	{	 reptdttme=rss.getString("ReportDateTime");}
	if(reptdttme==null || reptdttme.equalsIgnoreCase("null"))
	{	 reptdttme="-";}
	if(loadrsn==null || loadrsn.equalsIgnoreCase("null"))
	{	 loadrsn="-";}
	if(loadcmt==null || loadcmt.equalsIgnoreCase("null"))
	{	 loadcmt="-";}	}
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
	%>
	<td id="tdw<%=i%>" style="text-align: left; display: none;"><%=weight%></td>
	<td id="tdf<%=i%>" style="text-align: left; display: none;"><%=freight%></td>
	<td id="tda<%=i%>" style="text-align: left; display: none;"><%=adv%></td>
	<td><%=vendor%></td>
	<td><%=tripcat%></td>
	<td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>
	<td id="tdr<%=i%>" style="text-align: left; display: none;"><%=reptdttme%></td>
	<td style="text-align: left">
	<% 
	try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"))));
	}catch(Exception ee)
	{out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+"<br>"+STime);
	}
	%>
	</td>
	<td id="tdl<%=i%>" style="text-align: right; display: none;"><%=LoadingDelay%></td>
	<td id="tdldr<%=i%>"style="text-align: right; display: none;"><%=loadrsn%></td>
	<td id="tdlc<%=i%>"style="text-align: right; display: none;"><%=loadcmt%></td>
	<td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
	<td style="text-align: left"><%
	try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
	}catch(Exception ee){
	out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
	}%>
	</td>
	<td id="tdu<%=i%>"style="text-align: left; display: none;"><%
	try{ 
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
	}catch(Exception ee)
	{out.print("-");}
	%>
	</td>
	<td id="tdul<%=i%>"style="text-align: right; display: none;"><%=UnloadingDelay%></td>
	<td id="tdudr<%=i%>"style="text-align: right; display: none;"><%=unloadrsn%></td>
	<td id="tduc<%=i%>"style="text-align: right; display: none;"><%=unloadcmt%></td>
	<%
	//*********************************************query is changed*****************************************************
	DecimalFormat twoDForm1 = new DecimalFormat("##.#");
	sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rstcloser.getString("StartPlace")+"' and EndPlace = '"+rstcloser.getString("EndPlace")+"' || StartPlace ='"+rstcloser.getString("EndPlace")+"' and EndPlace = '"+rstcloser.getString("StartPlace")+"'";
	ResultSet rstdist=st1.executeQuery(sql);
	if(stdDist==0 && stdTme==0)
	{
		if(rstdist.next())	{ 
		stdDist=rstdist.getDouble("Km");
		stdTme=rstdist.getDouble("TTime");
		}}
	if(stdDist==0 && stdTme==0)
	{%>
	<td style="text-align: right" id="stkmcolveh<%=i%>">NA</td>
	<td style="text-align: right" id="sttcolveh<%=i%>">NA</td>
	<%}
	else
	{%>
	<td style="text-align: right" id="stkmcolveh<%=i%>"><%=twoDForm1.format(stdDist)%></td>
	<td style="text-align: right" id="sttcolveh<%=i%>"><%=twoDForm1.format(stdTme)%></td>
	<%}%>
	<td style="text-align: right" id="kmtcolveh<%=i%>"><%=KmTravelled%></td>
	<!--<td style="text-align: right">
	<%
	//***************************************************************************************************************
	int dist;
	dist=0; dist1=0; dist2=0;
	%> 
	</td>--> 
	<td style="text-align: left" id="trptcolveh<%=i%>">
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
	long hrs,mins;
	double hrslong=0.00;
	java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
	java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
	long x=enddte11.getMinutes();
	long y=strdte11.getMinutes();
	long timediff=enddte11.getTime()-strdte11.getTime();//msec
	long mins11=timediff/1000/60;
	if(mins11>=60)
	{
	hrdiff=mins11/60;//2
	if((y>x)&&(x!=0)){
	mins=y-x;
	mins=60-mins;
	out.print(hrdiff+":"+mins);}
	else if((x>y)&&(y!=0)){
		mins=x-y;
		out.print(hrdiff+":"+mins);
		}else if(x==y){
		mins=x-y;
		out.print(hrdiff+":"+mins);}
	else if((x==0)&&(y>x)){
	mins=60-y;
	out.print(hrdiff+":"+mins);
	}else if(y==0){
	mins=x+y;
	out.print(hrdiff+":"+mins);}}
	else{
	hrdiff=0;
	mins=mins11;
	out.print(hrdiff+":"+mins);}
	String enddte=enddte1+" "+ETime;
	String strtdte=strdte1+" "+STime;
	long tmeinmils=enddte1.getTime()-strdte1.getTime();
	long hours=tmeinmils/(1000*60*60);
	String extractstrtminutes=STime.substring(3,5);
	String extractendminutes=ETime.substring(3,5);
	int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
	if(totmins >= 60){
	hrdiff=hrdiff+1;
	totmins=totmins-60;
	}}
	catch(Exception e)
	{}
	%>
	</td>
	<%
	DecimalFormat twoDForm = new DecimalFormat("##.##");
	%>
	<td style="text-align: right" id="oscolveh<%=i%>"><%=rstcloser.getInt("OSCount")%></td>
	<td style="text-align: right" id="osscolveh<%=i%>"><%=rstcloser.getDouble("OSDuration")%></td>
	<td style="text-align: right" id="racolveh<%=i%>"><%=rstcloser.getInt("RACount")%></td>
	<td style="text-align: right" id="rdcolveh<%=i%>"><%=rstcloser.getInt("RDCount")%></td>
	<td style="text-align: right" id="cdcolveh<%=i%>">
	<%
	String date3="",date4="";
	String vehid=rstcloser.getString("Vehid");
	int cdcnt=0;
	try{
		date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
		date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
	}
	catch(Exception e){
		date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")+" "+rstcloser.getString("StartTime")));
		date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")+" "+rstcloser.getString("EndTime")));
	}
	String sqlcd="select count(*) cdcount from db_gpsExceptions.t_veh"+vehid+"_cr where concat(FromDate,' ',FromTime) between '"+date3+"' and '"+date4+"'";
	ResultSet rscd=st16.executeQuery(sqlcd);
	while(rscd.next())
	{	cdcnt=rscd.getInt("cdcount");}
	if(cdcnt>0){
		%>
		<a href="detail_cd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("VehRegNo")%>&pageType=ContinuousDriving&data1=<%=date3%>&data2=<%=date4%>"><%=cdcnt%></a>
			 <%
	}
	else{
		%>		<%=cdcnt%>
			<%}%>
	</td><td style="text-align: right" id="ndcolveh<%=i%>">
	<%
	if(rstcloser.getInt("NDCount")>0)
	{
	%>
		<a
		href="detail_nd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("vehregno")%>&pageType=NightDriving&data1=<%=fromdate%>&data2=<%=todate%>"">
		<%=rstcloser.getInt("NDCount")%> </a> <%}
	else{
		%>	<%=rstcloser.getInt("NDCount")%>
		<%}%>
	</td><td style="text-align: right" id="dccolveh<%=i%>">
	<%
	int discount=0, diskm=0;
	String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rstcloser.getString("vehid")+"' and  OffTimeFrom >='"+rstcloser.getString("Startdate")+"'and  OffTimeTo<='"+rstcloser.getString("Enddate")+"' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30'";
	ResultSet rstdis=st2.executeQuery(sqldis);
	if(rstdis.next())
	{
		if(rstdis.getInt("cnt")>0)
		{
			discount=rstdis.getInt("cnt");
			diskm=rstdis.getInt("distance");
			%>
		    <a href="disconnectedDetailsReport.jsp?vehicleCode=<%=rstcloser.getString("vehid")%>&VehicleRegNo=<%=rstcloser.getString("vehregno")%>&ownerName=<%=rstcloser.getString("OwnerName")%>&fromDateTime=<%=rstcloser.getString("Startdate")%>&toDateTime=<%=rstcloser.getString("EndDate")%>&counterv=<%=rstdis.getInt("cnt")%>&tripid=<%=rstcloser.getString("TripId")%>"> <%=discount%> </a>
			<%	}
		else{		
			out.print("0");	}}
	else{	out.print("0");}
	%>
	</td><td style="text-align: right" id="dckmcolveh<%=i%>">
	<%
	if(discount>0){
		%>
		<%=diskm %>
		<%	}
	else{	out.print(0);	}
	%>
	</td><td style="text-align: right" id="ratcolveh<%=i%>"><%=twoDForm.format(rstcloser.getDouble("TripRating"))%></td>
	<%
	sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
	//System.out.println(sql);
	rss=st2.executeQuery(sql);
	if(rss.next())
	{endedby=rss.getString("EndedBy");} 
	%>
	<td style="text-align: left">  
	<%
	if(endedby.equals("-") || endedby.equals(""))
	{	out.print("Auto Closed");}
	else
	{	out.print(endedby);}
	%>
	</td></tr> 
	<%
	}
	%>
	<input type="hidden" name="cntcls" id="cntcls" value="<%=i%>">
	</table>
	<%
}


else{

	String fromdate1="",todate1="";
	vehino=request.getParameter("vehicle");
	StringTokenizer stk = new StringTokenizer(vehino,",");
	String vehiclecode=stk.nextToken();
	String vehicleno=stk.nextToken();
	Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'  "+sum+" group by Vendor order by  Vendor";

	//Sqlv="select distinct(tripid),Vehid,TripRating,VehRegNo,OwnerName,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,UnloadDateTime,LoadingDelay,UnloadingDelay,JourneyStatus,DriverID,DriverName,JDCode,Weight,Vendor,Unloadingcomments,DelayReason,OSCount,RACount,RDCount,OSDuration,NDCount,DisconnectionCount from t_completedjourney where  (OwnerName='"+session.getAttribute("usertypevalue").toString()+"' OR GPName='"+session.getAttribute("usertypevalue").toString()+"')    and  StartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' and VehRegNo='"+vehicleno+"' "+sum+" order by StartDate ";
%>
<table border="0" width="800" align="center">
<tr align="center"><td align="center" colspan="24" width="70%">
<font color="brown" size="3">The Trip Report for Vehicle <%=vehicleno%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
<div class="bodyText" align="right">
<input type="button" value="More Info" onclick="showhide2();" class="formElement" id="tds" name="tds" >&nbsp;&nbsp;
</div></td>
<td id="print" colspan="1" width="100">
<a href="#" onclick="javascript:window.open('print_my_trips.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp;
</td>
<td id="excel" colspan="1" width="100">
<a href="export_my_trip.jsp?tds=Hide Info&data1=<%=fromdate%>&data2=<%=todate%>&transporter=<%=transporter%>&statusp1=<%=statusname%>&vendor=<%=vendername%>&category=<%=categoryname %>&startp=<%=startplacename%>&endp=<%=endplacename%>&vehicle=<%=vehicleno%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a></td>
<td width="600">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
</td></tr></table>
<table border="1" class="sortable" width="100%">
<tr>
<th>Sr.</th>
<th>Trip ID</th>
<th>Driver</th>
<th>Veh</th>
<!--	<th id="vehcolveh"><a href="#" onClick="hide4('veh');" title="Click to hide Desc,Mode1,Type Cols"><img id="img14" src="images/sub.jpg" width="13px" height="10px" border="0"> </a><br></br>Veh.</th>-->
<th id="tdd0" style="text-align: left; display: none"> Desc</th>
<th id="tdm0" style="text-align: left; display: none"> Model</th>
<th id="tdt0" style="text-align: left; display: none">Type</th>
<th>Owner</th>
<th id="tdw0" style="text-align: left; display: none">Weight Kg</th>
<th id="tdf0" style="text-align: left; display: none">Freight Rs</th>
<th id="tda0" style="text-align: left; display: none">Advance Rs</th>
<th>Customer</th>
<th>Category</th>
<th>Origin</th>
<th id="tdr0" style="text-align: left; display: none">Report DateTIme</th>
<th>Start Date Time</th>
<th id="tdl0" style="text-align: left; display: none">Load Delay (hh:mm:ss)</th>
<th id="tdldr0" style="text-align: left; display: none">Ld Delay Rsn</th>
<th id="tdlc0" style="text-align: left; display: none">Load Comments</th>
<th>Destination</th>
<th>End Date Time</th>
<th id="tdu0" style="text-align: left; display: none">Unload Date Time</th>
<th id="tdul0" style="text-align: left; display: none">Unload Delay (hh:mm:ss)</th>
<th id="tdudr0" style="text-align: left; display: none">Unld Delay Rsn</th>
<th id="tduc0" style="text-align: left; display: none">Unload Comments</th>
<th id="stkmcolveh">Std Km</th>
<th id="sttcolveh">StdTime</th>
<th id="kmtcolveh">KM Traveled</th>
<th id="trptcolveh">Trip Time</th>
<th id="oscolveh">OS</th>
<th id="osscolveh">OS(Sec)</th>
<th id="racolveh">RA</th>
<th id="rdcolveh">RD</th>
<th id="cdcolveh">CD</th>
<th id="ndcolveh">ND</th>
<th id="dccolveh">DC</th>
<th id="dckmcolveh">DC Km</th>
<th id="ratcolveh">Trip Rating</th>
<th>Closed By</th>
</tr>
<%
System.out.println("Our exact query>>>>"+Sqlv); 
ResultSet rstcloser=st15.executeQuery(Sqlv);
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
String vehdesc="-",vehmodel="-",vehtype="-",tripcat="-",adv="-",freight="-",loadrsn="-",loadcmt="-",endedby="-",weight="-",vendor="-",reptdttme="-",unloadcmt="-",unloadrsn="-";
String sdate,edate,LoadingDelay,UnloadingDelay;
int KmTravelled=0;
while(rstcloser.next())
{
i++;
SDate=rstcloser.getString("StartDate");
EDate=rstcloser.getString("EndDate");
STime=rstcloser.getString("StartTime");
ETime=rstcloser.getString("EndTime");
tripid=rstcloser.getString("TripId");
KmTravelled=rstcloser.getInt("KmTravelled");
LoadingDelay=rstcloser.getString("LoadingDelay");
if(LoadingDelay==null || LoadingDelay.equalsIgnoreCase("null")){
LoadingDelay="-";}
UnloadingDelay=rstcloser.getString("UnloadingDelay");
if(UnloadingDelay==null || UnloadingDelay.equalsIgnoreCase("null")){
UnloadingDelay="-";}
unloadcmt=rstcloser.getString("Unloadingcomments");
if(unloadcmt==null || unloadcmt.equalsIgnoreCase("null")){
unloadcmt="-";}
unloadrsn=rstcloser.getString("DelayReason");
if(unloadrsn==null || unloadrsn.equalsIgnoreCase("null")){
unloadrsn="-";}
if(null==STime || STime.length()>8 || STime.equals("-"))
{STime="00:00:00";}
if(null==ETime || ETime.equals("-"))
{ETime="23:59:59";}
sdate=SDate;
System.out.println("sdate  "+sdate);
try{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
}
catch(Exception e){
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
}
try{
java.util.Date dt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
ftime1=""+dt.getHours();
ftime2=""+dt.getMinutes();}
catch(Exception e){
	ftime1="00";
	ftime1="00";}
edate=EDate;
System.out.println("edate  "+edate);
try
{	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));}
catch(Exception e){	 todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
}
try{
java.util.Date edt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
ttime1=""+edt.getHours();
ttime2=""+edt.getMinutes();}
catch(Exception e){
	ttime1="23";
 	ttime2="59";}
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);//00:00:00
miliseconds1=fd.getTime();
}catch(Exception e1){
try{
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate);
miliseconds1=fd.getTime();
}catch(Exception e4){
java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(SDate);
miliseconds1=fd.getTime();}}
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate+" "+ETime);
miliseconds2=fd1.getTime();
}catch(Exception e2){
try{
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(EDate);
miliseconds2=fd1.getTime();
}catch(Exception e5){
java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(EDate);
miliseconds2=fd1.getTime();}}
try{
fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
}catch(Exception e){
fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+" "+STime;
fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")));
}
try{
	todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
	todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}catch(Exception e){
todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+" "+ETime;
todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")));
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
</td></tr><tr>
<td><a href="ShowCustomReportonTWMap.jsp?tripid=<%=rstcloser.getString("TripId")%>&vehcode=<%=rstcloser.getString("VehId")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rstcloser.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rstcloser.getString("StartPlace")%>&endplace=<%=rstcloser.getString("EndPlace")%>&enddate=<%=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>
</td></tr><tr><td>
<a href="#" onclick="javascript:window.open('TripwiseException.jsp?startDate=<%=rstcloser.getString("StartDate")%>&endDate=<%=rstcloser.getString("EndDate")%>&vehcode=<%=rstcloser.getString("VehId")%>&tripid=<%=rstcloser.getString("Tripid")%>','','menubar=1,scrollbars=1,resizeable=0,width=700,height=700');">TripWise Exception </a>
</td></tr><tr><td>
<a href="#" onclick="javascript:window.open('endtrip1.jsp?tripid=<%=rstcloser.getString("Tripid")%>&EDate=<%=EDate%>&ETime=<%=ETime%>&vehcode=<%=rstcloser.getString("VehId")%>','','menubar=1,resizable=2,width=770,height=350,location=no');">Change Unload Time </a>
</td></tr>
<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
</table></div> </div></td>
<td style="text-align: left"><div align="left"><%=rstcloser.getString("DriverName")%> <%="("+rstcloser.getString("DriverId")+")"%></div></td>
<td style="text-align: left"><%=rstcloser.getString("VehRegNo")%></td>
<%
String sql3="Select VehDesc,VehModel,VehType1 from t_vehicledetails where VehicleRegNumber='"+rstcloser.getString("VehRegNo")+"' order by VehicleRegNumber";
ResultSet rstcol=stt2.executeQuery(sql3);
System.out.println("veh desc"+sql3);
if(rstcol.next()){
vehdesc=rstcol.getString("VehDesc");
if(vehdesc==null || vehdesc.equalsIgnoreCase("null"))
{vehdesc="-";}
vehmodel=rstcol.getString("VehModel");
if(vehmodel==null || vehmodel.equalsIgnoreCase("null"))
{vehmodel="-";}
vehtype=rstcol.getString("VehType1");
if(vehtype==null || vehtype.equalsIgnoreCase("null")){
vehtype="-";}}
else{
vehdesc="-";
vehmodel="-";
vehtype="-";}
%>
<td id="tdd<%=i%>" style="text-align: left;display: none;"><%=vehdesc%></td>
<td id="tdm<%=i%>" style="text-align: left;display: none;"><%=vehmodel%></td>
<td id="tdt<%=i%>" style="text-align: left;display: none;"><%=vehtype%></td>
<td style="text-align: left"><%=rstcloser.getString("OwnerName")%></td>
<%
String sql="Select EndedBy,Weight,Vendor,ReportDateTime,Frieght,Advance,Loadreason,Loadcomments,TripCategory,FIxedKM,FIxedTime from t_startedjourney where tripid='"+tripid+"'";
ResultSet rss=st2.executeQuery(sql);
if(rss.next()){
stdDist=rss.getDouble("FIxedKM");
stdTme=rss.getDouble("FIxedTime"); 
endedby=rss.getString("EndedBy");
weight=rss.getString("Weight");
if(weight==null || weight.equalsIgnoreCase("null"))
{	 weight="-";}
vendor=rss.getString("Vendor");
if(vendor.equalsIgnoreCase("select") || vendor==null || vendor.equalsIgnoreCase("null"))
{	 vendor="-";}
tripcat =rss.getString("TripCategory");
if(tripcat.equalsIgnoreCase("select") || tripcat==null || tripcat.equalsIgnoreCase("null"))
{	 tripcat="-";}
freight =rss.getString("Frieght");
if(freight==null || freight.equalsIgnoreCase("null"))
{
	 freight="-";
}adv =rss.getString("Advance");
if(adv==null || adv.equalsIgnoreCase("null"))
{	 adv="-";}
try{
	 reptdttme=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rss.getString("ReportDateTime")));
	}catch(Exception ss)
{	 reptdttme=rss.getString("ReportDateTime");}
if(reptdttme==null || reptdttme.equalsIgnoreCase("null"))
{	 reptdttme="-";}
if(loadrsn==null || loadrsn.equalsIgnoreCase("null"))
{	 loadrsn="-";}
if(loadcmt==null || loadcmt.equalsIgnoreCase("null"))
{	 loadcmt="-";}	}
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
%>
<td id="tdw<%=i%>" style="text-align: left; display: none;"><%=weight%></td>
<td id="tdf<%=i%>" style="text-align: left; display: none;"><%=freight%></td>
<td id="tda<%=i%>" style="text-align: left; display: none;"><%=adv%></td>
<td><%=vendor%></td>
<td><%=tripcat%></td>
<td style="text-align: left"><%=rstcloser.getString("StartPlace")%></td>
<td id="tdr<%=i%>" style="text-align: left; display: none;"><%=reptdttme%></td>
<td style="text-align: left">
<% 
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate"))));
}catch(Exception ee)
{out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("StartDate")))+"<br>"+STime);
}
%>
</td>
<td id="tdl<%=i%>" style="text-align: right; display: none;"><%=LoadingDelay%></td>
<td id="tdldr<%=i%>"style="text-align: right; display: none;"><%=loadrsn%></td>
<td id="tdlc<%=i%>"style="text-align: right; display: none;"><%=loadcmt%></td>
<td style="text-align: left"><%=rstcloser.getString("EndPlace")%></td>
<td style="text-align: left"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate"))));
}catch(Exception ee){
out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rstcloser.getString("EndDate")))+"<br>"+ETime);
}%>
</td>
<td id="tdu<%=i%>"style="text-align: left; display: none;"><%
try{ 
out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("UnloadDateTime"))));
}catch(Exception ee)
{out.print("-");}
%>
</td>
<td id="tdul<%=i%>"style="text-align: right; display: none;"><%=UnloadingDelay%></td>
<td id="tdudr<%=i%>"style="text-align: right; display: none;"><%=unloadrsn%></td>
<td id="tduc<%=i%>"style="text-align: right; display: none;"><%=unloadcmt%></td>
<%
//*********************************************query is changed*****************************************************
DecimalFormat twoDForm1 = new DecimalFormat("##.#");
sql="select * from db_gps.t_castrolroutes where StartPlace = '"+rstcloser.getString("StartPlace")+"' and EndPlace = '"+rstcloser.getString("EndPlace")+"' || StartPlace ='"+rstcloser.getString("EndPlace")+"' and EndPlace = '"+rstcloser.getString("StartPlace")+"'";
ResultSet rstdist=st1.executeQuery(sql);
if(stdDist==0 && stdTme==0)
{
	if(rstdist.next())	{ 
	stdDist=rstdist.getDouble("Km");
	stdTme=rstdist.getDouble("TTime");
	}}
if(stdDist==0 && stdTme==0)
{%>
<td style="text-align: right" id="stkmcolveh<%=i%>">NA</td>
<td style="text-align: right" id="sttcolveh<%=i%>">NA</td>
<%}
else
{%>
<td style="text-align: right" id="stkmcolveh<%=i%>"><%=twoDForm1.format(stdDist)%></td>
<td style="text-align: right" id="sttcolveh<%=i%>"><%=twoDForm1.format(stdTme)%></td>
<%}%>
<td style="text-align: right" id="kmtcolveh<%=i%>"><%=KmTravelled%></td>
<!--<td style="text-align: right">
<%
//***************************************************************************************************************
int dist;
dist=0; dist1=0; dist2=0;
%> 
</td>--> 
<td style="text-align: left" id="trptcolveh<%=i%>">
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
long hrs,mins;
double hrslong=0.00;
java.util.Date enddte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(todatetime);
java.util.Date strdte11= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromdatetime);
long x=enddte11.getMinutes();
long y=strdte11.getMinutes();
long timediff=enddte11.getTime()-strdte11.getTime();//msec
long mins11=timediff/1000/60;
if(mins11>=60)
{
hrdiff=mins11/60;//2
if((y>x)&&(x!=0)){
mins=y-x;
mins=60-mins;
out.print(hrdiff+":"+mins);}
else if((x>y)&&(y!=0)){
	mins=x-y;
	out.print(hrdiff+":"+mins);
	}else if(x==y){
	mins=x-y;
	out.print(hrdiff+":"+mins);}
else if((x==0)&&(y>x)){
mins=60-y;
out.print(hrdiff+":"+mins);
}else if(y==0){
mins=x+y;
out.print(hrdiff+":"+mins);}}
else{
hrdiff=0;
mins=mins11;
out.print(hrdiff+":"+mins);}
String enddte=enddte1+" "+ETime;
String strtdte=strdte1+" "+STime;
long tmeinmils=enddte1.getTime()-strdte1.getTime();
long hours=tmeinmils/(1000*60*60);
String extractstrtminutes=STime.substring(3,5);
String extractendminutes=ETime.substring(3,5);
int totmins=Integer.parseInt(extractstrtminutes)+Integer.parseInt(extractendminutes);
if(totmins >= 60){
hrdiff=hrdiff+1;
totmins=totmins-60;
}}
catch(Exception e)
{}
%>
</td>
<%
DecimalFormat twoDForm = new DecimalFormat("##.##");
%>
<td style="text-align: right" id="oscolveh<%=i%>"><%=rstcloser.getInt("OSCount")%></td>
<td style="text-align: right" id="osscolveh<%=i%>"><%=rstcloser.getDouble("OSDuration")%></td>
<td style="text-align: right" id="racolveh<%=i%>"><%=rstcloser.getInt("RACount")%></td>
<td style="text-align: right" id="rdcolveh<%=i%>"><%=rstcloser.getInt("RDCount")%></td>
<td style="text-align: right" id="cdcolveh<%=i%>">
<%
String date3="",date4="";
String vehid=rstcloser.getString("Vehid");
int cdcnt=0;
try{
	date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")));
	date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")));
}
catch(Exception e){
	date3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("StartDate")+" "+rstcloser.getString("StartTime")));
	date4=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstcloser.getString("EndDate")+" "+rstcloser.getString("EndTime")));
}
String sqlcd="select count(*) cdcount from db_gpsExceptions.t_veh"+vehid+"_cr where concat(FromDate,' ',FromTime) between '"+date3+"' and '"+date4+"'";
ResultSet rscd=st16.executeQuery(sqlcd);
while(rscd.next())
{	cdcnt=rscd.getInt("cdcount");}
if(cdcnt>0){
	%>
	<a href="detail_cd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("VehRegNo")%>&pageType=ContinuousDriving&data1=<%=date3%>&data2=<%=date4%>"><%=cdcnt%></a>
		 <%
}
else{
	%>		<%=cdcnt%>
		<%}%>
</td><td style="text-align: right" id="ndcolveh<%=i%>">
<%
if(rstcloser.getInt("NDCount")>0)
{
%>
	<a
	href="detail_nd.jsp?vid=<%=rstcloser.getString("vehid")%>&vehno=<%=rstcloser.getString("vehregno")%>&pageType=NightDriving&data1=<%=fromdate%>&data2=<%=todate%>"">
	<%=rstcloser.getInt("NDCount")%> </a> <%}
else{
	%>	<%=rstcloser.getInt("NDCount")%>
	<%}%>
</td><td style="text-align: right" id="dccolveh<%=i%>">
<%
int discount=0, diskm=0;
String sqldis="Select Count(*)as cnt, sum(Distance) as distance from t_disconnectionData where vehiclecode='"+rstcloser.getString("vehid")+"' and  OffTimeFrom >='"+rstcloser.getString("Startdate")+"'and  OffTimeTo<='"+rstcloser.getString("Enddate")+"' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30'";
ResultSet rstdis=st2.executeQuery(sqldis);
if(rstdis.next())
{
	if(rstdis.getInt("cnt")>0)
	{
		discount=rstdis.getInt("cnt");
		diskm=rstdis.getInt("distance");
		%>
	    <a href="disconnectedDetailsReport.jsp?vehicleCode=<%=rstcloser.getString("vehid")%>&VehicleRegNo=<%=rstcloser.getString("vehregno")%>&ownerName=<%=rstcloser.getString("OwnerName")%>&fromDateTime=<%=rstcloser.getString("Startdate")%>&toDateTime=<%=rstcloser.getString("EndDate")%>&counterv=<%=rstdis.getInt("cnt")%>&tripid=<%=rstcloser.getString("TripId")%>"> <%=discount%> </a>
		<%	}
	else{		
		out.print("0");	}}
else{	out.print("0");}
%>
</td><td style="text-align: right" id="dckmcolveh<%=i%>">
<%
if(discount>0){
	%>
	<%=diskm %>
	<%	}
else{	out.print(0);	}
%>
</td><td style="text-align: right" id="ratcolveh<%=i%>"><%=twoDForm.format(rstcloser.getDouble("TripRating"))%></td>
<%
sql="Select EndedBy from t_startedjourney where tripid='"+tripid+"'";
//System.out.println(sql);
rss=st2.executeQuery(sql);
if(rss.next())
{endedby=rss.getString("EndedBy");} 
%>
<td style="text-align: left">  
<%
if(endedby.equals("-") || endedby.equals(""))
{	out.print("Auto Closed");}
else
{	out.print(endedby);}
%>
</td></tr> 
<%
}
%>
<input type="hidden" name="cntcls" id="cntcls" value="<%=i%>">
</table>
<%

}




}
}
catch(Exception e)
{out.print("Exception -->"+e);}
finally
{		try
		{			conn.close();		}catch(Exception e)
		{}
		try		{
			conn1.close();		}catch(Exception e)		{}}
%>
</table>
</form>
<%@ include file="footernew.jsp" %>
