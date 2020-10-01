<%@ include file="headernew.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<script language="javascript">
function validate()
  {
  	if(document.getElementById("data").value=="")
  	{
  	
  		alert("Please select the from date");
  		return false;
  	}
  if(document.getElementById("data1").value=="")
  	{
  	
  		alert("Please select the to date");
  		return false;
  	}
  	//return datevalidate();
	return true;
  	
  }
  function datevalidate()
{	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
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
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}

	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
		alert("From date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(year==dy1 && year==dy2) if(dm1>dm2)
	{
		alert("From date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}
</script>
<%
String fromdate11,todate11;
%>
<%
		if(!(null==request.getQueryString()))
			{
			datenew1=request.getParameter("data");
			datenew2=request.getParameter("data1");
			}
			else
			{
				datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			}
%>
<table border="0" width="100%" class="stats">
<!-- <tr><td colspan="5" align="left"><font size="2"><b>Report No : 6.2</b></font>-->
<tr><td colspan="5" align="center"><font size="3"><b>Driver Rating Report</b></font> 
</td></tr>
<tr><td>
<!-- code start Here -->
<table border="0" align="center" width="500" class="sortable_entry">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td align="center"><b>From&nbsp;&nbsp;</b>
<input type="text" id="data" name="data"  value="<%=datenew1%>"  size="15" readonly/>
  </td><td align="left">
<!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data"       // ID of the button
    }
  );
</script>
</td>
<td align="center">
<b>To&nbsp;&nbsp;</b>
<input type="text" id="data1" name="data1"  value="<%=datenew2%>" size="15" readonly/></td><td align="left">
<!--  <input type="button" name="To Date" value="To Date" id="trigger1" >-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
</td>
<td><input type="submit" name="submit" id="submit" value="submit"></td>
</tr>
</form>
</table>
<%
String dd=request.getQueryString();
if(dd==null)
{
%>
<table class="stats">
<tr><td>
<center class='bodyText'><b>Please select the dates to display the Driver Rating report</b></center>
</td></tr>
</table>
<%
}
else
{
%>

<%!
Connection connnew,conn1;
Statement st, st1, st2,st3,st4,st5;
String user,sql,sql1,sql2;
String data1, data2,showdate1,showdate,DriverName,Owner,datenew1,datenew2,Transporter;
String DriverID;
%>

<%
int OScount, RAcount, RDcount,Distance;
double Rating;
boolean flag;

//NumberFormat nf=DecimalFormat.getInstance();

int JCode,VehCode,distance,OSduration,RAcnt=0,RDcnt=0,OScnt=0,Distcnt=0,dailyctr=0,weeklyctr=0,alldailyctr=0,allweeklyctr=0;
double rating;
//double a,b,c;
double ctr=0.0;
double d=0.0;

String ll="";


 %>
<%

NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2); 

data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
data2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
//System.out.println("datenew1::>>>>"+datenew1);
//System.out.println("datenew2::>>>>"+datenew2);
Transporter=session.getAttribute("usertypevalue").toString();
//System.out.println("Transporter");

try{
	Class.forName(MM_dbConn_DRIVER); 
	connnew = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=connnew.createStatement();
	st1=connnew.createStatement();
	st2=connnew.createStatement();
	st3=connnew.createStatement();
	st4=connnew.createStatement();
	st5=connnew.createStatement();
	
%>
<%
%>
<table border="0" width="100%" bgcolor="white" >
<tr><td align="center"><font size="2"><b>Driver Rating Report for <%=session.getAttribute("usertypevalue").toString()%> From <%=datenew1%> to <%=datenew2%>. </b></font><div align="right">
<a href="#" onclick="javascript:window.open('printdriverratingbydate.jsp?data1=<%=datenew1%>&data2=<%=datenew2%>&transporter=<%= Transporter%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceldriverratingbydate.jsp?data1=<%=datenew1%>&data2=<%=datenew2%>&transporter=<%= Transporter%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : 
<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %></div></td></tr>
</table>
<table border="0" width="100%" bgcolor="white" class="sortable">
<tr>
<td class="hed">SR.</td>
<td class="hed">Driver Name</td>
<td class="hed">Driver Code</td>
<td class="hed">Transporter</td>
<td class="hed">OS Duration</td>
<td class="hed">RA Count</td>
<td class="hed">RD Count</td>
<td class="hed">Distance</td>
<td class="hed">Daily CD Violation</td>
<td class="hed">Weekly CD Violation</td>
<td class="hed">Rating</td>

</tr>
<%
String DriverIdlist="(";
/*	String Svehlist="(0";
sql13="select Distinct(TripID) from t_alljddata where TripID in (select Distinct(TripID) from t_completedjourney where GPName='Castrol' and EndDate between '"+datenew1+"' and '"+todate+"') and Category = 'Primary' and Status <> 'NotProcessed'";
	//"select sum(KmTravelled) as KmTravelled,sum(RACount) as RACount,sum(RDCount) as RDCount,sum(OSDuration) as OSDuration,(sum(RACount)/sum(KmTravelled))*100 as RARating,(sum(RDCount)/sum(KmTravelled))*100 as RDRating,((sum(OSDuration)/10)/sum(KmTravelled))*100 as OSrating,(sum(RACount)/sum(KmTravelled))*100+(sum(RDCount)/sum(KmTravelled))*100+((sum(OSDuration)/10)/sum(KmTravelled))*100 as Rating from t_completedjourney where TripId in (select Distinct(TripID) from t_alljddata where StartDate between '"+datenew1+"' and '"+todate+"' and Category = 'Primary' and Status <> 'NotProcessed')";
//System.out.println(sql13);	
ResultSet rst13=st13.executeQuery(sql13);
while(rst13.next())
	{
	Svehlist=Svehlist+","+rst13.getString("VehicleCode");
	}
Svehlist=Svehlist+")";

//System.out.println(Svehlist);
*/
//sql="select JourneyCode,Vehid,StartDate,EndDate,sum(RACount) as RAcount,sum(RDCount) as RDcount,sum(OSDuration) as OSDuration,DriverID,DriverName,OwnerName,Sum(KmTravelled) as Distance from t_completedjourney where StartDate>='"+data1+"' and EndDate<='"+data2+"' and KmTravelled>0 and JourneyCode <>'-' and Vehid in "+session.getAttribute("VehList").toString()+" group by DriverID order by TripRating,KmTravelled desc";
//sql="select sum(RACount) as RAcount,sum(RDCount) as RDcount,sum(OSDuration) as OSDuration,DriverID,DriverName,OwnerName,Sum(KmTravelled) as Distance from t_completedjourney where StartDate>='"+data1+"' and EndDate<='"+data2+"' and JourneyCode <>'-'and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') group by DriverID,DriverName,OwnerName order by DriverName asc";
//sql="SELECT sum( RACount ) AS RAcount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration, DriverID, DriverName, OwnerName, Sum( KmTravelled ) AS Distance FROM t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC";
sql="SELECT sum( RACount ) AS RAcount, sum( RDCount ) AS RDcount, sum( OSDuration ) AS OSDuration, DriverID, DriverName, OwnerName, Sum( KmTravelled ) AS Distance FROM t_completedjourney WHERE StartDate >= '"+data1+"' AND StartDate <= '"+data2+"' AND Vehid in "+session.getAttribute("VehList").toString()+"  GROUP BY DriverID, DriverName, OwnerName ORDER BY DriverName ASC";


//sql="select sum(KmTravelled) as KmTravelled,sum(OSDuration) as OS,sum(RACount) as RA,sum(RDCount) as RD,count(distinct(TripID)) as Trips,count(distinct(DriverID)) as Driver,count(distinct(VehRegNo)) as VehRegNo, StartPlace from t_completedjourney where StartDate>='"+data+"' and StartDate<='"+data1+"' and (OwnerName LIKE '"+session.getAttribute("usertypevalue").toString()+"' OR GPName LIKE '"+session.getAttribute("usertypevalue").toString()+"') Group by StartPlace";

//System.out.println("SQL:::"+sql);
//sql="select distinct(Dcode), avg(Rating) as Rating ,sum(Distance) as Distance from t_driver_ds where TheDate >='"+data1+"' and TheDate <='"+data2+"' and distance > 0 and Jcode <>'-' group by Dcode order by Rating,Distance desc";
ResultSet rst=st2.executeQuery(sql);
int i=1;
while(rst.next())
{
	DriverIdlist=DriverIdlist+","+rst.getString("DriverID");
	dailyctr=0;
	weeklyctr=0;
	//VehCode=rst.getInt("Vehid");
	RAcount=rst.getInt("RAcount");
	//System.out.println("RACount::"+RAcount);
	RDcount=rst.getInt("RDCount");
	//System.out.println("RDCount::"+RDcount);
	OSduration=rst.getInt("OSDuration");
	//System.out.println("OSDuration::"+OSduration);
	DriverID=rst.getString("DriverID");
	//System.out.println("DriverID-----------------123--------------------------->" + DriverID);

	
	//System.out.println("DriverCode::"+DriverID);
	DriverName=rst.getString("DriverName");
	//System.out.println("DriverName::"+DriverName);
	Transporter=rst.getString("OwnerName");
	//System.out.println("Transporter::"+Transporter);
	//rating=rst.getDouble("Rating");
	distance=rst.getInt("Distance");
	//System.out.println("Distance::"+distance);
	
	%>
	<tr>
	<td class="bodyText"><div align="right"><%=i%></div></td>
	<td class="bodyText"><div align="left"><a href="driver_rating_by_date.jsp?DriverID=<%=rst.getString("DriverID")%>&DriverName=<%=rst.getString("DriverName")%>&data1=<%=data1%>&data2=<%=data2%>&Transporter=<%=rst.getString("OwnerName")%>"><%=DriverName%></a></div></td>
	<td class="bodyText"><div align="right"><%=DriverID%></div></td>
	<td class="bodyText"><div align="left"><%=Transporter%></div></td>
	<td class="bodyText"><div align="right"><%=OSduration%></div></td>
	<td class="bodyText"><div align="right"><%=RAcount%></div></td>
	<td class="bodyText"><div align="right"><%=RDcount%></div></td>
	<td class="bodyText"><div align="right"><%=distance%></div></td>
	
		<%	
	
		String str = "SELECT count(*) as count FROM `t_CastrolDrivers6` WHERE TheDte  BETWEEN '"+ data1 + "' AND '" + data2 + "' AND DrinHrs > 10 and DriverID = '" + DriverID + "'"; 
		//System.out.println(str);
		ResultSet myrst = st4.executeQuery(str);
		
		while(myrst.next()) {
		
			dailyctr=myrst.getInt("count");
			alldailyctr=alldailyctr+dailyctr;
			
		} 
		if(dailyctr>0)
		{
			%>	
			<!--  <td class="bodyText"><div align="right"><a href="Driver_violation_detail.jsp?DriverID=< %=DriverID%>&data1=< %=data1%>&data2=< %=data2%>&DriverName=< %=DriverName%>"> < %=dailyctr %> </a></div></td> -->
			<td class="bodyText"><div align="right"><a href="dailyviolation.jsp?DriverID=<%=DriverID%>&data1=<%=data1%>&data2=<%=data2%>&DriverName=<%=DriverName%>&thename=<%="started" %>"> <%=dailyctr %> </a></div></td>
		<%	
		}
		else
		{
			%>
			<td class="bodyText"><div align="right"><%=dailyctr %></div></td>
			 
		<%
		}
		
		String str1 = "SELECT count(*) as count FROM `t_CastrolDrivers6` WHERE TheDte  BETWEEN '"+ data1 + "' AND '" + data2 + "' AND LastWeekRDurInHrs > 60 and DriverID = '" + DriverID + "'"; 
		//System.out.println(str);
		ResultSet myrst1 = st5.executeQuery(str1);
		
		while(myrst1.next()) {
		
			weeklyctr=myrst1.getInt("count");
			allweeklyctr=allweeklyctr+weeklyctr;
		} 
		if(weeklyctr>0)
		{
			%>	
			 <!-- <td class="bodyText"><div align="right"><a href="Driver_violation_detail1.jsp?DriverID=< %=DriverID%>&data1=< %=data1%>&data2=< %=data2%>&DriverName=< %=DriverName%>">< %=weeklyctr %></a></div></td>-->
			 <td class="bodyText"><div align="right"><a href="weeklyhrsviolation.jsp?DriverID=<%=DriverID%>&data1=<%=data1%>&data2=<%=data2%>&DriverName=<%=DriverName%>&thename=<%="started" %>"><%=weeklyctr %></a></div></td>
		<%	
		}
		else
		{
			%>
			<td class="bodyText"><div align="right"><%=weeklyctr %></div></td>
			<%
			
		}
		%>
		<td class="bodyText"><div align="right">
	<%
	if(distance ==0)
	{
	out.print("NA");
	}
	else
	{
		rating=(((Double.valueOf(RAcount)/distance)*100)+((Double.valueOf(RDcount)/distance)*100)+((Double.valueOf(OSduration)/10/distance)*100));
		out.print(nf.format(rating));
	}
	
	%></div></td>
		
	</tr>
	<%
	i++;
	RAcnt=RAcnt+RAcount;
	//System.out.println("RACnt::::"+RAcnt);
	RDcnt=RDcnt+RDcount;
	//System.out.println("RDCnt::::"+RDcnt);
	OScnt=OScnt+OSduration;
	//System.out.println("OSCnt::::"+OScnt);
	Distcnt=Distcnt+distance;
	//System.out.println("Distcnt::::"+Distcnt);
	//ctr=ctr+d;
	//cntrate=cntrate+rating;
	
	}
DriverIdlist=DriverIdlist+")";
//System.out.println(DriverIdlist);
    ctr=(((Double.valueOf(RAcnt)/Distcnt)*100)+((Double.valueOf(RDcnt)/Distcnt)*100)+((Double.valueOf(OScnt)/10/Distcnt)*100));
    
	%>
	
	<tr>
	<td class="bodyText" colspan="4"><div align="right"><b>Total</b></div></td>
	<td class="bodyText"><div align="right"><b><%=OScnt%></b></div></td>
	<td class="bodyText"><div align="right"><b><%=RAcnt%></b></div></td>
	<td class="bodyText"><div align="right"><b><%=RDcnt%></b></div></td>
	<td class="bodyText"><div align="right"><b><%=Distcnt%></b></div></td>
	
	<%if(alldailyctr>0)
		{%>
		<!-- <td align="right"><div align="right"><a href="Drivinghrsviolation.jsp?fromdate=< %=fromdate%>&todate=< %=todate%>&thename=< %=thename%>"><font size="2">< %=rst99.getInt("count")%></font></a></div></td> -->
	<td class="bodyText"><div align="right"><a href="TotalDailyViolation.jsp?fromdate=<%=data1%>&todate=<%=data2%>&thename=<%="started"%>&driverlist=<%=DriverIdlist %>"><b><%=alldailyctr%></b></a></div></td>
	<%}
	else
	{
	%>
	<td class="bodyText"><div align="right"><b><%=0%></b></div></td>
	<%} %>
		<%if(allweeklyctr>0)
		{%>
	<td class="bodyText"><div align="right"><a href="TotalWeeklyViolation.jsp?fromdate=<%=data1%>&todate=<%=data2%>&thename=<%="started"%>&driverlist=<%=DriverIdlist %>"><b><%=allweeklyctr%></b></a></div></td>
	<%}
	else
	{
	%>
	<td class="bodyText"><div align="right"><b><%=0%></b></div></td>
	<%} %>
	<td class="bodyText"><div align="right"><b><%=nf.format(ctr)%></b></div></td>
	</tr>
	

</table>

<%
}catch(Exception e)
{
	out.print("Exception -->"+ e);
}
finally
{
	try
	{
		conn1.close();
	}catch(Exception e)
	{}
	try
	{
		connnew.close();
	}catch(Exception e)
	{}
	
}
}
%>
<!-- code end here -->
</td></tr>
</table>
<%@ include file="footernew.jsp" %>
