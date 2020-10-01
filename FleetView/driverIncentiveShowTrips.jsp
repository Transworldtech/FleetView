<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body style="font-family: Arial">
<link href="css/currentPositions.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript">
function gotoPrint(divName)  
{    
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId,frmFldId)  
{  
	try
	{
	//alert("Hiii");
	     var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.DriverIncentiveDetail.action ="excel.jsp";
          document.forms["DriverIncentiveDetail"].submit();
	}
	catch(e)
	{
		alert(e);
	}
} 

function toggleDetails(id,show){
	var popup = document.getElementById("popup"+id);
if (show) {
popup.style.visibility = "visible";
popup.setfocus();
} else {
popup.style.visibility = "hidden";
 }}

</script>
<%!
Connection con=null;
Statement st=null;
Statement st1=null;
Statement st2=null;
Statement st6=null;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();	
	st6=con.createStatement();
	
	
String driverid=request.getParameter("driverid");
String category = request.getParameter("category");
String month = request.getParameter("month");
String month1 = request.getParameter("month1");
java.util.Date NewDate =new java.util.Date();
long dateMillis = NewDate.getTime();
long dayInMillis = 1000* 60 *60 *24;
dateMillis = dateMillis - dayInMillis;
NewDate.setTime(dateMillis);
Format NewFormatter = new SimpleDateFormat("yyyy-MM-dd");
Format NewFormatter1 = new SimpleDateFormat("dd-MMM-yyyy");
int monthcount=  0;
String sqlmonth = "SELECT TIMESTAMPDIFF(MONTH, '"+month+"', '"+month1+"') as monthno";
ResultSet rsmonth = st.executeQuery(sqlmonth);
if(rsmonth.next())
{
	monthcount = rsmonth.getInt("monthno")+1;
	System.out.println("Monthcount    "+rsmonth.getInt("monthno"));
}


String role="";
String ApprooveBy=session.getAttribute("mainuser").toString();
String sqlapp="select Role from db_gps.t_security where Username='"+ApprooveBy+"' ";
System.out.println("Find Role Query" +sqlapp);
ResultSet rsapp=st.executeQuery(sqlapp);
if(rsapp.next())
{
	role=rsapp.getString("Role");
}
System.out.println(" Role " +role);


/*String titleheading = "";
if(category.equalsIgnoreCase("tanker"))
{
	titleheading = "Tanker";
}
else
{
	titleheading = "Primary and Secondary";
}
*/
String exportFileName=session.getAttribute("user").toString()+"_DriverIncentiveDetails.xls";  
%>
		<div style="margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em; " align="center">
<form name="DriverIncentiveDetail" name="DriverIncentiveDetail" action="" method="post">
<div id="table1" align="center" >

<%

System.out.println("*********     hfgsbhdvfdsm");
	
%>
<div style="font-size: 1.4em;" align="center">
	Driver Incentive Trip Details</div>
<table border="0" width="100%" align="center">
<tr>
<td align="left">
                        <br>
                        <font size="2" color="black"> Disclaimer : The Calculated Amount may change if there is a change in the status or count of Violation</font></b> 
                       
                       </td>
                       <td align="right">
                       <br>
                           <div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                           <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
                           <a href="DriverIncShowTripExcel.jsp?driverid=<%=driverid%>&category=<%=category%>&month=<%=month%>&month1=<%=month1%>" title="Export to Excel">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
                           <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) %>
                           </div>
                       </td>
</tr>
</table>
<%System.out.println("*********     hfgsbhdvfdsm"); %>
<table class="sortable" style="width: 1500px;">
<tr>
<th style="width: 10px;">Sr No</th>
<th style="width: 60px;">Driver Id</th>
<th style="width: 100px;">Driver Name</th>
<th style="width: 60px;">Trip id</th>
<th style="width: 90px;">Veh Reg No</th>
<th style="width: 150px;">Origin</th>
<th style="width: 30px;">Start Date</th>
<th style="width: 150px;">Destination</th>
<th style="width: 30px;">End Date</th>
<th style="width: 20px;">Trip KM</th>
<th style="width: 20px;">RA</th>
<th style="width: 20px;">RD</th>
<th style="width: 20px;">OS</th>
<th style="width: 20px;">OS Dur</th>
<th style="width: 20px;">CD</th>
<th style="width: 20px;">ND</th>
<th style="width: 20px;">DC</th>
<th style="width: 30px;">DH Vio</th>
<th style="width: 30px;">Stops Greater Than 4 hrs</th>
<th style="width: 30px;">Trip Rating</th>
<th style="width: 30px;">DVI Points</th>
<th style="width: 30px;">JRM Points</th>
<th style="width: 30px;">Adherence To JRM and JP</th>
<th style="width: 30px;">Distance & Points Based Incentive (A)</th>
<%
//if(category.equals("tanker"))	
//{
	%>
<!--	<th style="width: 30px;">Tanker Zero DVI Incentive Rate</th>-->
	<%
//}
//else
//{
	%>
<!--	<th style="width: 30px;">Pri-Sec Zero DVI Incentive Rate</th>-->
	<%
//}
%>
<th style="width: 30px;">Zero DVI Based Incentive (B)</th>
<th style="width: 40px;">Total Incentive (A+B)</th>
<th style="width: 40px;">Total Incentive  (grouped by month)</th>
</tr>
<%
int i=1,totincentive1 = 0,zerodvirate1 = 0;

double totincentive11=0.0,totmonthinc1=0.0;
for(int k =0;k<monthcount;k++)
{
Calendar Cal = Calendar.getInstance();
System.out.println("k:    "+k);
Cal.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(month));
Cal.add(Calendar.MONTH,k);
String month3 = new SimpleDateFormat("yyyy-MM-dd").format(Cal.getTime());
System.out.println("Date:    "+month3);


String data1 = month3;
String data2 = new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd").parse(month3))+"-31";
System.out.println("Date:    "+month3);
String user,usertypevalue;
user=session.getAttribute("user").toString();
usertypevalue=session.getAttribute("usertypevalue").toString();

int totaltrips = 0;
String sql = "";
if(category.equals("tanker"))	
{
String sql1 = "SELECT * FROM `t_DriverIncentive` WHERE ScoreCategory = 'TankerRate'and GPName='Castrol'";
ResultSet rs1 = st1.executeQuery(sql1);
if(rs1.next())
{
	zerodvirate1 = rs1.getInt("Points");
}

sql1 = "Select count(*)  as cnt from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Tanker')  AND DRIVERID='"+driverid+"' and KmTravelled > 0";
rs1 = st1.executeQuery(sql1);
System.out.println("****sql1%%%%%%%%%%%%%  "+sql1);

if(rs1.next())
{
	totaltrips = rs1.getInt("cnt");
}		

 sql="Select * from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Tanker') AND DRIVERID='"+driverid+"'  and KmTravelled > 0 ";
}
else
{
String sql1 = "SELECT * FROM `t_DriverIncentive` WHERE ScoreCategory = 'PrimaryRate'and GPName='Castrol'";
ResultSet rs1 = st1.executeQuery(sql1);
if(rs1.next())
{
	zerodvirate1 = rs1.getInt("Points");
}


System.out.println("****zerodvirate1%%%%%%%%%%%%%  "+zerodvirate1);



sql1 = "Select count(*)  as cnt from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Primary','Secondary')  AND DRIVERID='"+driverid+"'  and KmTravelled > 0";
rs1 = st1.executeQuery(sql1);
if(rs1.next())
{
	totaltrips = rs1.getInt("cnt");
}		
 sql="Select * from db_gps.t_completedjourney where  StartDate >='"+data1+" 00:00:00' and StartDate<='"+data2+" 23:59:59'  and tripcategory in ('Primary','Secondary') AND DRIVERID='"+driverid+"' and KmTravelled > 0 ";

}

ResultSet rs= st.executeQuery(sql);
System.out.println("****sql%%%%%%%%%%%%%  "+sql);
int totincentive = 0;

double trippoint1=0.0;

double trippoint11=0.0;
totmonthinc1=0.0;
int totmonthinc = 0,m = 1,l = 0;
while(rs.next()){
 int trippoint = 0,zerodvirate=0,zerodviincentive = 0;
 
 
  trippoint1=0.0;
 System.out.println("****rs.KM%%%"+rs.getDouble("KmTravelled"));
 trippoint = (rs.getInt("KmTravelled") * (rs.getInt("dvipoint")+rs.getInt("jrmpoint")))/100;
 
 trippoint1=(rs.getDouble("KmTravelled") * (rs.getDouble("dvipoint")+rs.getDouble("jrmpoint")))/100;
 
 System.out.println("****trippoint DOUBLEEEE%%%%"+trippoint1);
 System.out.println("****trippoint%%%%"+trippoint);
 
 totincentive = 0;
 if(category.equals("tanker"))
 {
	 zerodvirate = zerodvirate1;
	 if(new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))).equals("0.00")  && (rs.getInt("dvipoint") > 0 || rs.getInt("jrmpoint") > 0))
	 {
		 zerodviincentive = zerodvirate1;
	 }
	 else
	 {
		 zerodviincentive = 0;
	 }
 }
 else
 {
	 if(totaltrips >= 5)
	 {
		 zerodvirate = zerodvirate1;
	 }
	 else
	 {
		 zerodvirate = 0;
	 }
	 if(new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))).equals("0.00") && (rs.getInt("dvipoint") > 0 || rs.getInt("jrmpoint") > 0))
	 {
		 zerodviincentive = zerodvirate;
	 }
	 else
	 {
		 zerodviincentive = 0;
	 }
 }
 
 
 
 
 totincentive = trippoint + zerodviincentive;
 totincentive11 = trippoint1 + zerodviincentive;
 
 
 
 
 totmonthinc = totmonthinc + totincentive;
 
 totmonthinc1=totmonthinc1+totincentive11;
 
 
 System.out.println("*********    totincentive"+totincentive);
 System.out.println("****trippoint*****    "+trippoint);
 System.out.println("****zerodviincentive*****    "+zerodviincentive);
 System.out.println("*********   totmonthinc***"+totmonthinc);
 
System.out.println("*********   totmonthinc111111111111111***"+totmonthinc1);
 
 
 
%>
<tr>   
<td><%=i++ %></td>
<td align="right" ><div style="text-align: right;"> <%=rs.getString("DriverID") %></div></td>
<td align="left" ><div style="text-align: left; "><%=rs.getString("DriverName") %></div></td>
<td align="right" ><div style="text-align: right;"><a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=rs.getString("TripID") %></a>
<div class="popup" id="popup<%=i%>">
<%
String fromdate = "",ftime1 = "",ftime2 = "",ftime3="",todate = "",ttime1 = "",ttime2 = "",ttime3="",fromdatetime = "",todatetime = "";
try{
	fromdatetime=rs.getString("StartDate");
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")));
 }catch(Exception e)
 {
	fromdatetime=rs.getString("StartDate")+" "+rs.getString("StartTime");
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("StartDate")));
}
try
{
		todatetime=rs.getString("EndDate");
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("EndDate")));
}catch(Exception e)
{
	todatetime=rs.getString("EndDate")+" "+rs.getString("EndTime");
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("EndDate")));
}
ftime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("StartTime")));
ftime2 = new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("StartTime")));
ftime3 = new SimpleDateFormat("ss").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("StartTime")));
ttime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("EndTime")));
ttime2 = new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("EndTime")));
ttime3 = new SimpleDateFormat("ss").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("EndTime")));
String briefid = "",rid = "",plannedstatus = "No";
boolean flag = false;
String sql1 = "select * from db_gps.t_briefing where tripid = '"+rs.getString("TripID")+"'";
ResultSet rs1 = st1.executeQuery(sql1);
if(rs1.next())
{
	briefid = rs1.getString("Briefid");
}

sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+rs.getString("TripID")+"' and briefid = '"+briefid+"' and driverid = '"+driverid+"'  order by advancedtrackid asc ,row asc limit 1 ";
rs1 = st1.executeQuery(sql1);
if(rs1.next())
{
	rid = rs1.getString("advancedrouteid");
	plannedstatus = "Yes";
	flag = true;
}
%>
<table border="1" bgcolor="white">
<tr>
<td><a href="detailed_report.jsp?vehcode=<%=rs.getString("Vehid")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);" target="_blank">Detail Report</a>
</td></tr>
	<tr>
<td>
<%
//if(flag == true)
//{
	%>
<!--	<a href="#" onclick = "javascript: window.open('ViewJourneyOnMap.jsp?tripid=< %=rs.getString("TripID")%>&driverid=< %=driverid %>&briefid=< %=briefid %>&rid=< %=rid %>','ViewOnMap','width=1000,height=900,scrollbars=yes')" >Show On Map</a>-->
	<%
//}
//else
//{
	%>
	<a href="ActAndPlanJrnyCompOnMap.jsp?tripid=<%=rs.getString("TripID")%>&vehcode=<%=rs.getString("Vehid")%>&data=<%=fromdate%>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ftime3=<%=ftime3 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&ttime3=<%=ttime3 %>&pg=cm&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=driverid %>" onclick="javascript:toggleDetails(<%=i%>,false);" target="_blank">Show On Map</a>
	<%
//}
%>
</td>
</tr>
<tr><td>
<a href="TripwiseException.jsp?startDate=<%=fromdatetime%>&endDate=<%=todatetime%>&vehcode=<%=rs.getString("VehId")%>&tripid=<%=rs.getString("Tripid")%>" onclick="javascript:toggleDetails(<%=i%>,false);" target="_blank" >TripWise Exception</a>
</td></tr>
<%if(role.equalsIgnoreCase("Castrolsuperadmin") || role.equals("Castrolsuperadmin") || session.getAttribute("mainuser").toString().equalsIgnoreCase("n_kallurwar@transworld-compressor.com")) {%>
<tr><td>
<a href="OverrideReport.jsp?tripid=<%=rs.getString("Tripid")%>&vid=<%=rs.getString("VehId")%>&vehRegNo=<%=rs.getString("VehRegNo")%>&Transporter=<%=rs.getString("OwnerName")%>&SD=<%=fromdatetime %>&ED=<%=todatetime%>" onclick="javascript:toggleDetails(<%=i%>,false);" target="_blank" >
Violation Override</a></td></tr>
<%} %>
<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
</table>
</div>
</div></td>  
<td align="left" ><div style="text-align: left; "><%=rs.getString("VehRegNo") %></div></td>
<td align="left"><div style="text-align: left; "><%=rs.getString("StartPlace") %></div></td>
<td align="right"><div style="text-align: right;"><% try { out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")))); } 
catch(Exception e)
{
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("StartDate")+" "+rs.getString("StartTime"))));
}
%></div></td>
<td align="left"><div style="text-align: left;"><%=rs.getString("EndPlace") %></div></td>
<td align="right"><div style="text-align: right;"><% try { out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("EndDate")))); } 
catch(Exception e)
{
	out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("EndDate")+" "+rs.getString("EndTime"))));
}

%></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("KmTravelled") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenRA") %></div></td> 
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenRD") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenOS") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenOSDur") %></div></td>
<td align="right"><div style="text-align: right;"><%
int CRCount=0;
try{
CRCount=rs.getInt("OpenCD");
out.print(CRCount);

}
catch(Exception e)
{
String CR=rs.getString("OpenCD");
String Vehid=rs.getString("Vehid");
if(CR.equalsIgnoreCase("Yes")||CR=="Yes")
{
	 sql1 = "SELECT count(*) as CRCount FROM db_gpsExceptions.t_veh"+Vehid+"_cr WHERE concat(FromDate, ' ',FromTime )>= '"+rs.getString("StartDate")+"'and concat(FromDate, ' ',FromTime )<= '"+rs.getString("EndDate")+"'";
	System.out.print("RRRR : "+sql1);
	 rs1 = st1.executeQuery(sql1);
	if(rs1.next())
	{
		CRCount = rs1.getInt("CRCount");
	}
}
out.print(CRCount);	
System.out.println("In Catch  CR : ");
}



%></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenND") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("OpenDC") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("RunHrVio") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("Stopsgreaterthan4hrs") %></div></td>
<td align="right"><div style="text-align: right;"><%=new DecimalFormat("0.00").format(Double.parseDouble(rs.getString("OpenRating"))) %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("dvipoint") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("jrmpoint") %></div></td>
<td align="right"><div style="text-align: right;"><%=rs.getString("JrmStatus") %></div></td>
<td align="right"><div style="text-align: right;"><%=trippoint %></div></td>
<!--<td align="right"><div style="text-align: right;">< %=zerodvirate %></div></td>-->
<td align="right"><div style="text-align: right;"><%=zerodviincentive%></div></td>
<td align="right"><div style="text-align: right;"><%=totincentive%></div></td>
<%
if(m == 1)
{
%>
<td align="right" rowspan="<%=totaltrips %>"><div style="text-align: right;" ><b id="total<%=i %>"></b></div></td>
<%
l = i;
m++;
}
%>
</tr>
<%}

totincentive1 = totincentive1 + totmonthinc;


System.out.println("totincentive11 ***********@@@@@@@@@@@  "+totincentive11);
totincentive11=totincentive11+totmonthinc1;
System.out.println("totincentive11 ***********@@@@@@@@@@@--------  "+totincentive11);


int mntcount = monthcount - 1;
System.out.println("k  "+k+"  monthcount  "+mntcount+"   m   "+m);
System.out.println("condition   "+(m==2 || k == mntcount));

System.out.println("totmonthinc ***********  "+totmonthinc);

if(m==2 || k != mntcount )
{
%>
<tr><th colspan="27"></th></tr>
<%
}
%>
<script>
var n = <%=l%>;
var totincen = <%=(int)totmonthinc1%>;
document.getElementById("total"+n).innerHTML = totincen;
</script>
<%


System.out.println("totincentive1 *totmonthinc1**********  "+totincentive1);
System.out.println("FINALLLLLLLLLLLLLLLL**********  "+(totincentive11));

}
%>
<tr><th colspan="26" align="right"><div style="text-align: right;">Total</div></th><th align="right"><div style="text-align: right;"><%=(int)totmonthinc1 %> </div></th></tr>
</table>
<br>
<div align="left">
<%
System.out.println("Catagory : "+category);
if(category.equalsIgnoreCase("prisec")||category=="prisec")
{
	 %>
<table width="30%" class="sortable" style="width: 600px;text-align: left">
<%
int i71=0;
String sql71="SELECT * FROM db_gps.t_DriverIncentive WHERE GPName = 'Castrol'";
ResultSet rs71 = st6.executeQuery(sql71);
if(rs71.next())
{	%>	
	<tr>
	<th colspan="4">
	Driver Incentive Card Rules
	</th>
	</tr>
	<tr class="cbFormTableRow">
	<th rowspan="2">SrNo</th>
	<th colspan="2">Parameter</th>
	<th  rowspan="2" width="95px">Points</th>
	</tr>
	<tr class="cbFormTableRow">
	
	<th width="250px">Catagory</th>
	<th width="95px">Range</th>
		</tr>	
	<%
rs71.previous();
int MaxDVI=0,MaxJRM=0;
while(rs71.next())
{
if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI") || rs71.getString("ScoreCategory").equalsIgnoreCase("JRM") )
{
	System.out.println(" in if :");
	i71++;
	%>
	<tr class="cbFormTableRow">
	<td><%=i71 %></td>
	<td><div align="left"><%=rs71.getString("ScoreCategory") %></div></td>
	<% if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI"))
	{
		if(rs71.getInt("Points")>MaxDVI)
		{			MaxDVI=rs71.getInt("Points");			
		}
	%>
	<td><%=rs71.getString("MinValue") %>-<%=rs71.getString("MaxValue") %></td>
	<%
	}
	else if (rs71.getString("ScoreCategory").equalsIgnoreCase("JRM"))
	{
		if(rs71.getInt("Points")>MaxJRM)
		{			
			MaxJRM=rs71.getInt("Points");
			System.out.println(" MaxJRM : "+MaxJRM);
		}
		System.out.println(" MaxJRM : "+MaxJRM);
	%>
		<td>NA</td><%	
	}
	else 
	{%>
		<td>NA</td><%	
	}
	%>	
	<td><%=rs71.getString("Points") %></td>
	</tr>	
	<%}

}
%>
<tr>
<td colspan="3">Total</td>
<%
System.out.println("Max DVI : "+MaxDVI+" MaxJRM : "+MaxJRM);
%> 
<td><% out.print(MaxJRM+MaxDVI); %></td>
</tr>


	<tr class="cbFormTableRow">
	<th >SrNo</th>
	<th >Category</th>
	<th  width="95px">Range</th>
	<th  width="95px">Maximum Earning Potential</th>
	
	</tr>

<%
i71=0;
rs71.last();
while(rs71.previous())
{ 

	if(rs71.getString("ScoreCategory").equalsIgnoreCase("MaxIncentiveKM") )
{
	i71++;
	%>
	<tr class="cbFormTableRow">
	<td><%=i71 %></td>
	<td><div align="left"><%=rs71.getString("KmsCategory") %></div></td>
	<td><%=rs71.getString("MinValue") %>-<%
	if(rs71.getString("MaxValue")=="10000"||rs71.getString("MaxValue").equalsIgnoreCase("10000"))
	{out.print("and More");		
	}
	else
	{
		out.print(rs71.getString("MaxValue"));
	}
		%></td>
	
	<td><%=rs71.getString("Points") %></td>
	</tr>	
	<%}

}




}
%>

<tr> 
<td colspan="4" align="center"><div align="center">
<font size="5" ><b>
<table border="2" >
<tr >
<td colspan="2" align="left"><div align="left">
Pri-Sec Zero DVI Incentive Rate : </div></td>
<td colspan="2" align="right"><div align="left">
<%=zerodvirate1 %> For Total Trips >= 5</div> </td>
 </tr>
 <tr>
<td colspan="2" align="right"></td>
<td colspan="2" align="right"><div align="left">
0 For Total Trips < 5 </div></td>
</tr>
<tr >
<td colspan="2" align="left"><div align="left">
Points for trip are forfeited : </div></td>
<td colspan="2" align="right"><div align="left">
1. Absence of registered Cleaner</div> </td>
 </tr>
<tr>
<td colspan="2" align="right"></td>
<td colspan="2" align="right"><div align="left">
2. GPS Disconnection </div></td>
</tr>
<tr>
<td colspan="2"></td>
<td colspan="2" align="left"><div align="left">
3. ND, CD, Stoppages, DH </div></td>
	</tr>
	<tr>
	<tr >

<td colspan="2" align="left"><div align="left">
Points for quarter are forfeited : </div></td>
<td colspan="2" align="right"><div align="left">
1. If our driver fails to report an incident</div> </td>
 </tr>
<tr>
<td colspan="2" align="right"></td>
<td colspan="2" align="right"><div align="left">
2. If our driver fails to take steps to avoid an incident </div></td>
</tr>
</tr>
</table>
</b>
</font>
</div>
</td> 
</tr>
</table>


<%
}
else
{
	 %>
	 <table width="30%" class="sortable" style="width: 600px;text-align: left">
	 <%
	 int i71=0;
	 String sql71="SELECT * FROM db_gps.t_DriverIncentive WHERE GPName = 'Castrol'";
	 ResultSet rs71 = st6.executeQuery(sql71);
	 if(rs71.next())
	 {	%>	
	 	<tr>
	 	<th colspan="4">
	 	Driver Incentive Card Rules
	 	</th>
	 	</tr>
	 	<tr class="cbFormTableRow">
	 	<th rowspan="2">SrNo</th>
	 	<th colspan="2">Parameter</th>
	 	<th  rowspan="2" width="95px">Points</th>
	 	</tr>
	 	<tr class="cbFormTableRow">
	 	
	 	<th width="250px">Catagory</th>
	 	<th width="95px">Range</th>
	 		</tr>	
	 	<%
	 rs71.previous();
	 int MaxDVI=0,MaxJRM=0;
	 while(rs71.next())
	 {
	 if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI") || rs71.getString("ScoreCategory").equalsIgnoreCase("JRM") )
	 {
	 	System.out.println(" in if :");
	 	i71++;
	 	%>
	 	<tr class="cbFormTableRow">
	 	<td><%=i71 %></td>
	 	<td><div align="left"><%=rs71.getString("ScoreCategory") %></div></td>
	 	<% if(rs71.getString("ScoreCategory").equalsIgnoreCase("DVI"))
	 	{
	 		if(rs71.getInt("Points")>MaxDVI)
	 		{			MaxDVI=rs71.getInt("Points");			
	 		}
	 	%>
	 	<td><%=rs71.getString("MinValue") %>-<%=rs71.getString("MaxValue") %></td>
	 	<%
	 	}
	 	else if (rs71.getString("ScoreCategory").equalsIgnoreCase("JRM"))
	 	{
	 		if(rs71.getInt("Points")>MaxJRM)
	 		{			
	 			MaxJRM=rs71.getInt("Points");
	 			System.out.println(" MaxJRM : "+MaxJRM);
	 		}
	 		System.out.println(" MaxJRM : "+MaxJRM);
	 	%>
	 		<td>NA</td><%	
	 	}
	 	else 
	 	{%>
	 		<td>NA</td><%	
	 	}
	 	%>	
	 	<td><%=rs71.getString("Points") %></td>
	 	</tr>	
	 	<%}

	 }
	 %>
	 <tr>
	 <td colspan="3">Total</td>
	 <%
	 System.out.println("Max DVI : "+MaxDVI+" MaxJRM : "+MaxJRM);
	 %> 
	 <td><% out.print(MaxJRM+MaxDVI); %></td>
	 </tr>


	 	<tr class="cbFormTableRow">
	 	<th >SrNo</th>
	 	<th >Category</th>
	 	<th  width="95px">Range</th>
	 	<th  width="95px">Maximum Earning Potential</th>
	 	
	 	</tr>

	 <%
	 i71=0;
	 rs71.last();
	 while(rs71.previous())
	 {
	 if(rs71.getString("ScoreCategory").equalsIgnoreCase("MaxTankerIncentive") )
	 {
	 	i71++;
	 	%>
	 	<tr class="cbFormTableRow">
	 	<td><%=i71 %></td>
	 	<td><div align="left">Maximum earning potential </div></td>
	 	<td>-</td>
	 	
	 	<td><%=rs71.getString("Points") %></td>
	 	</tr>	
	 	<%}

	 }

	 }
	 %>
	
	 <tr> 
	 <td colspan="4" align="center"><div align="center">
	 <font size="5" ><b>
	 <table border="2" >
	 <tr >
	<td colspan="2" align="left"><div align="left">
	Tanker Zero DVI Incentive Rate : </div></td>
	<td colspan="2" align="right"><div align="left">
	<%=zerodvirate1 %></div> </td>
 	</tr>
	 <tr >

	 <td colspan="2" align="left"><div align="left">
	Points for trip are forfeited : </div></td>
	 <td colspan="2" align="right"><div align="left">
	 1. Absence of registered Cleaner</div> </td>
	  </tr>
	 <tr>
	 <td colspan="2" align="right"></td>
	 <td colspan="2" align="right"><div align="left">
	 2. GPS Disconnection </div></td>
	 </tr>
	 <tr>
	 <td colspan="2"></td>
	 <td colspan="2" align="left"><div align="left">
	 3. ND, CD, Stoppages, DH </div></td>
	 	</tr>
	 	<tr>
	 	<tr >

	 <td colspan="2" align="left"><div align="left">
	 Points for quarter are forfeited : </div></td>
	 <td colspan="2" align="right"><div align="left">
	 1. If our driver fails to report an incident</div> </td>
	  </tr>
	 <tr>
	 <td colspan="2" align="right"></td>
	 <td colspan="2" align="right"><div align="left">
	 2. If our driver fails to take steps to avoid an incident </div></td>
	 </tr>
	 </tr>
	 </table>
	 </b>
	 </font>
	 </div>
	 </td> 
	 </tr>
	 </table>
	 <%} %>
	 
</div>
</div>
</form>
</div>
<%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		con.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%></body>
		</html>
	



</jsp:useBean>
<%@ include file="footernew.jsp" %>	