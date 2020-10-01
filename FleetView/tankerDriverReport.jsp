<%@ include file="headernew.jsp" %>
	
<!--<script language="javascript">
 /* function validate()
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
*/
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
<%
/*String fromdate="",todate="",transporter="",datenew1="",datenew2="";
if(!(null==request.getQueryString()))
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
transporter=request.getParameter("transporter");
datenew1=request.getParameter("data1");
datenew2=request.getParameter("data2");
}
else
{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;

}
*/
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
//if(!(null==request.getQueryString()))
//{
	NumberFormat nf = DecimalFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2); 

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
<font  size="3"><B>Tanker Driver Report From 15-May-2010 To 15-Aug-2010</B></font>
<div class="bodyText" align="right">
 <a href="excel_tanker_report.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> 
	 &nbsp;&nbsp;&nbsp;<a href="#" onclick="javascript:window.open('print_tanker_report.jsp');" title="Print Current Position Report"><img src="images/print.jpg" width="15px" height="15px"></a>
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
<th>TripCount</th>
<th>KmTravelled</th>
<th>RA Count</th>
<th>RD Count</th>
<th>OS Count</th>
<th>OS Duration</th>
<th>Rating</th>
</tr>
<%
String vehregno="",transporter="",drivernm="",startdate="",driverid1="",startdate1="";
int vehid=0,racnt=0,rdcnt=0,km=0,osduration=0,i=1,j=1,k=1,oscnt=0,driverid=0,tripcnt=0;
double rating=0.0;

sql="select DriverId,DriverName,Transporter,count(DriverId) as Tripcnt,sum(Distance) as Distance,sum(OSCount) as OSCount,sum(RACount) as RACount,sum(RDCount) as RDCount,sum(OSDuration) as OSDuration,format(((((sum(RACount)+sum(RDCount))/sum(Distance))*100)+(((sum(OSDuration)/10)/sum(Distance))*100) ),2) as rating from t_tanker where Distance > 0 group by DriverId order by rating asc,Distance desc";
ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	
	driverid=rst.getInt("DriverId");
    drivernm=rst.getString("DriverName");
    transporter=rst.getString("Transporter");
    tripcnt=rst.getInt("tripcnt");
    oscnt=rst.getInt("OSCount");
   	racnt=rst.getInt("RACount");
   	rdcnt=rst.getInt("RDCount");
   	km=rst.getInt("Distance");
   	osduration=rst.getInt("OSDuration");
   	rating=rst.getDouble("rating");
   
   			
	%>
	<tr>
	<td><%=j%></td>
	<td><%=driverid%></td>
	<td><%=drivernm%></td>
	<td><%=transporter%></td>
	<td><%=tripcnt %></td>
	<td><%=km%></td>
	<td><%=racnt%></td>
	<td><%=rdcnt%></td>
	<td><%=oscnt%></td>
	<td><%=osduration%></td>
	<%
	if(km>0)
	{
	%>
	<td><%=rating %></td>
	<%
	}
	else
	{
	%>
		<td>NA</td>
	<%
	}
	%>
	</tr>
	<%
	
	j++;
	
    }




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
//}
%>

</table> 


</td></tr>
</table>

<%@ include file="footernew.jsp" %>


