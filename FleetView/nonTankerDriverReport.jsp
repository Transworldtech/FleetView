<%@ include file="headernew.jsp" %>
	
<!--<script language="javascript">
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

  </script>-->
  <!--<script type="text/javascript">

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
</script>-->
<!--<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}
</style>-->

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%!
Connection conn,conn1;
Statement st,st1,st2,st3,st11;
String sql,sql1;

%>

<table border="0" width="100%" align="center">
<!--<tr><td align="center">
<div align="center">
<font size="3"><B>Tanker Driver Report From 15-May-2010 To 15-Aug-2010</B></font></div>
</td></tr>-->
<tr><td>
<!--<table border="0" width="500" align="center">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td> <b>From&nbsp;&nbsp;</b>
<input type="text" id="data1" name="data1" value="< %=datenew1%>"  size="15" readonly/>
  </td><td align="left">
<input type="button" name="From Date" value="From Date" id="trigger" >
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
<b>To&nbsp;&nbsp;</b>
<input type="text" id="data2" name="data2" value="< %=datenew2%>" size="15" readonly/></td><td align="left">
<input type="button" name="To Date" value="To Date" id="trigger1">
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
<input type="hidden" name="transporter" id="transporter" value="< %=session.getAttribute("usertypevalue").toString()%>">
<input type="submit" name="submit" id="submit" value="submit"></td>
</tr>
</table>-->

</td></tr>
<tr><td>
<%

try
{
	
	
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
%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<font  size="3"><B>Non Tanker Drivers Report From 15-May-2010 To 15-Aug-2010</B></font>
<div class="bodyText" align="right">
 <a href="excel_nontanker_report.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_nontanker_report.jsp');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
	 &nbsp;&nbsp;&nbsp;
Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div> 
</td>
</tr>
</table>
<table border="1" class="sortable" width="100%">

<tr>
<th>Sr.</th>
<th>DriverID</th>
<th>DriverName</th>
<th>Transporter</th>
<th>Trip Count</th>
<th>KmTravelled</th>
<th>RA Count</th>
<th>RD Count</th>
<th>OS Count</th>
<th>OS Duration</th>
<th>Rating</th>
</tr>
<%
String drivernm="",transporter="";
int driverid=0,racnt=0,rdcnt=0,km=0,osduration=0,i=1,oscnt=0,tripcnt=0;
double rating=0.0;
sql="select DriverID as driverid,DriverName,OwnerName,count(DriverId) as Tripcnt,sum(KmTravelled) as km,sum(OSCount) as oscnt,sum(OSDuration) as osduration,sum(RACount) as racnt,sum(RDCount) as rdcnt,format(((((sum(RACount)+sum(RDCount))/sum(KmTravelled))*100)+(((sum(OSDuration)/10)/sum(KmTravelled))*100) ),2) as rating from t_completedjourney where StartDate between '2010-05-15 00:00:00' and '2010-08-15 23:59:59' and gpname='castrol' and tripcategory in ('primary','secondary') group by driverid order by rating asc,km desc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	driverid=rst.getInt("driverid");
	transporter=rst.getString("OwnerName");
	drivernm=rst.getString("DriverName");
	racnt=rst.getInt("racnt");
	rdcnt=rst.getInt("rdcnt");
	km=rst.getInt("km");
	tripcnt=rst.getInt("tripcnt");
	oscnt=rst.getInt("oscnt");
	osduration=rst.getInt("osduration");
	rating=rst.getDouble("rating");
	if(km>0)
	{
	%>
	<tr>
	<td style="text-align: right"><%=i%></td>
	<td style="text-align: right"><%=driverid%></td>
	<td style="text-align: left"><%=drivernm%></td>
	<td style="text-align: left"><%=transporter%></td>
<td style="text-align: left"><%=tripcnt%></td>

	<td style="text-align: right"><%=km%></td>
	<td style="text-align: right"><%=racnt%></td>
	<td style="text-align: right"><%=rdcnt%></td>
	<td style="text-align: right"><%=oscnt%></td>
	<td style="text-align: right"><%=osduration%></td>
<%
if(km>0)
{
%>
	<td style="text-align: right"><%=rating%></td>
<%
}
else
{
%>
<td style="text-align: right">NA</td>
<%
}
%>
	</tr>
	
	<%
	
	i++;
	}
	
}
%>
</table> 
<%
}
	catch(Exception e)
	{
		//e.printStackTrace();
		out.println("Exception:"+e);
	}
	finally
	{
		conn.close();
		conn1.close();
	}

%>
</td></tr>
</table>

<%@ include file="footernew.jsp" %>


