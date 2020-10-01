<%@ include file="headernew.jsp" %>
	
<%!
Connection conn,conn1,conn2;
Statement st,st1,st2,st3,strip,st4,st5;
String fromdate, todate,sql,sql1,transporter,datenew1,datenew2,fromdatetime,todatetime;
%>

<script language="javascript">
  function validate()
  {
		var sortby=document.getElementById("sortby").value;
		//alert(sortby);
		if(sortby.equalsIgnoreCase("Select"))
		{
			alert("Please select the category type");
			return false;
		}

			  
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
<%
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

%>

<table border="0" width="100%" align="center" class="stats">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<tr><td align="center">

<font size="4"><B>Trips Report</B></font>
</td></tr>

<tr>

<td>
<table border="0" width="850" class="sortable_entry">
<tr>

<td><b>From </b>&nbsp;&nbsp;
<input type="text" id="data1" name="data1" value="<%=datenew1%>"  size="15" readonly/>
 &nbsp;&nbsp;
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
<b>To </b>&nbsp;&nbsp;
<input type="text" id="data2" name="data2" value="<%=datenew2%>" size="15" readonly/>&nbsp;&nbsp;
<!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script></td>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">

<td>
<b>Select Category :</b>&nbsp;&nbsp;<select name="sortby" id="sortby">
	<option value="select" selected="selected">Select</option>
	<option value="all">All</option>
	<option value="primary">Primary</option>
	<option value="tanker">Tanker</option>
	<option value="secondary">Secondary</option>
</select>
</td>

<td>
<b>Trip type : </b><select name="ttype" id="ttype">
	<option value="select" selected="selected">Select</option>
	<option value="autoclose">Auto close</option>
	<option value="manual">Manual</option>
	<option value="all">All</option>
</select>
</td>

</tr>
</table>
<%
NumberFormat nf = DecimalFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);  

try
{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn2 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	

st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();

strip=conn.createStatement();
st4=conn2.createStatement();
st5=conn.createStatement();

%>
<table border="0" width="750" class="sortable_entry">
<tr>
<td>
<b>Origin:</b>&nbsp;&nbsp;
<select name="origin" id="origin" size="1">
	<option value="allorg" selected="selected">All</option>
	<%
			try{
						
						sql="select distinct(StartPlace) from t_completedjourney where GPName='Castrol' order by StartPlace asc";
						ResultSet rst=st.executeQuery(sql);
						while(rst.next())
						{
						%>
						<option value="<%=rst.getString("StartPlace")%>"><%=rst.getString("StartPlace")%></option>						
						<%
						}		
					}catch(Exception e)
					{
						out.print("Exception---->"+e);
					}				
				%>		
	
</select>
</td>
<td>
<b>Destination:</b>&nbsp;&nbsp;
<select name="destination" id="destination">
	<option value="alldest" selected="selected">All</option>
	<%
	try{
		String sql1="Select distinct(EndPlace) from t_completedjourney where GPName='Castrol' order by EndPlace asc";
		//System.out.println(sql1);
		ResultSet rst1=st.executeQuery(sql1);
		while(rst1.next())
		{
			%>
			<option value="<%=rst1.getString("EndPlace")%>"><%=rst1.getString("EndPlace")%></option>						
			<%
		}
	}
	catch(Exception e)
	{
		out.print("Exception---->>"+e);
	}
	
	%>
	
</select>
</td><td>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" name="submit" id="submit" value="Submit"></td>
</tr>
</table>

</td>

</tr>

<tr><td>
<%
String sortby1,origin,destination,type;
if(!(null==request.getQueryString()))
{
	
	sortby1=request.getParameter("sortby");
	origin=request.getParameter("origin");
	destination=request.getParameter("destination");
	type=request.getParameter("ttype");
	
%>
<table border="0" width="100%" align="center">
<tr><td align="center">
<%
if(sortby1.equalsIgnoreCase("primary"))
{
	%>
	<font  size="3"><B>Primary Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}	
else if(sortby1.equalsIgnoreCase("tanker"))
{
	%>
	<font  size="3"><B>Tanker Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}	
else if(sortby1.equalsIgnoreCase("secondary"))
{
	%>
	<font  size="3"><B>Secondary Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}
else
{
	%>
	<font  size="3"><B>All Trips from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></B></font>
	<%
}	
	%>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('print_my_trips1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&transporter=<%=transporter%>&select=<%=sortby1 %>&origin=<%=origin %>&destination=<%=destination %>&type=<%=type %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="export_my_trip1.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&transporter=<%=transporter%>&select=<%=sortby1 %>&origin=<%=origin %>&destination=<%=destination %>&type=<%=type %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div> 
</td>
</tr>
</table>
<table border="1" class="sortable" width="100%">

<tr >
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
String TripID,category,date1,date2,sqltrip="";
int i=1,j=1,k=0;
int dist1=0,dist2=0;
double stdDist=0,capDist=0,stdDist1=0,capDist1=0;
String bgcolor="";
String fromdate1="",todate1="";
String sdate,edate;
int ftime1=0;
int ftime2=0;
int ttime1=0;
int ttime2=0;

String trip="(";
if(type.equalsIgnoreCase("autoclose"))
			{
	String sql="Select Distinct(TripID) from t_startedjourney where (EndedBy='-' or EndedBy=' ') and GPName='Castrol' and StartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
	ResultSet rs=st2.executeQuery(sql);
	
	while(rs.next())
	{
		trip=trip+"'"+rs.getString("TripID")+"',";
	
		 k++;
	}
	 trip=trip+")";
	trip=trip.replace(",)",")");
			}
	
if(type.equalsIgnoreCase("manual"))
			{
	String sql="Select Distinct(TripID) from t_startedjourney where LENGTH(EndedBy)>2 and GPName='Castrol' and StartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
	ResultSet res=st2.executeQuery(sql);
	while(res.next())
	{
		trip=trip+"'"+res.getString("TripID")+"',";
		
		 k++;
	}
	 trip=trip+")";
	trip=trip.replace(",)",")");
			}
if(type.equalsIgnoreCase("all"))
{
String sql="Select Distinct(TripID) from t_startedjourney where GPName='Castrol' and StartDate  between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
ResultSet res=st2.executeQuery(sql);

while(res.next())
{
trip=trip+"'"+res.getString("TripID")+"',";

k++;
}
trip=trip+")";
trip=trip.replace(",)",")");
}

if(trip.equals("()"))
{
}
else
{
if((!(origin.equalsIgnoreCase("allorg"))) && (!(destination.equalsIgnoreCase("alldest"))))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and StartPlace='"+origin+"' and EndPlace='"+destination+"' order by StartDate ";
}
else if((!(origin.equalsIgnoreCase("allorg"))) && (destination.equalsIgnoreCase("alldest")))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and StartPlace='"+origin+"' order by StartDate ";
}
else if((origin.equalsIgnoreCase("allorg")) && (!(destination.equalsIgnoreCase("alldest"))))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' and EndPlace='"+destination+"' order by StartDate ";
}
else if((origin.equalsIgnoreCase("allorg")) && (destination.equalsIgnoreCase("alldest")))
{
	 sqltrip="Select distinct(tripid) from t_completedjourney where TripID IN "+trip+" and GPName='Castrol' and StartDate >='"+fromdate+"' and StartDate <='"+todate+"' order by StartDate ";
}

ResultSet rstrip=strip.executeQuery(sqltrip);
while(rstrip.next())
{
	TripID=rstrip.getString("tripid");
	String ss6="select Category from t_alljddata where TripId='"+TripID+"'";
	ResultSet rs6=st2.executeQuery(ss6);
	if(rs6.next())
	{
		category=rs6.getString("Category");
		if(sortby1.equalsIgnoreCase("primary"))	//primary
		{
			if(category.equalsIgnoreCase("Primary"))
			{
				sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
				ResultSet rst=st.executeQuery(sql);						
				java.util.Date enddte1,strdte1;
				int p=1;
				String slat,slon,elat,elon;
				String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
				long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
				if(rst.next())
				{
					String finalComment="-",comment="-";
					int loop=0;
					String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
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
					SDate=rst.getString("StartDate");
					
					EDate=rst.getString("EndDate");
					STime=rst.getString("StartTime");
					
					ETime=rst.getString("EndTime");
					endComment=rst.getString("Comment1");
					if(null==STime || STime.length()>8 || STime.equals("-"))
					{
					STime="00:00:00";
					}

					if(null==ETime || ETime.equals("-"))
					{
					ETime="23:59:59";
					}
					
					sdate=SDate+" "+STime;
					fromdate1=SDate;//new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));
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

					edate=EDate+" "+ETime;
					todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
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
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
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
					
					millisecdiff=miliseconds2-miliseconds1;
					secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; 

					try{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
						
					}catch(Exception e)
					{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
						
					}

					try{
						todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
					}catch(Exception e)
					{
						todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
					}
					
					  	
					//******************************distance difference******************************
					
					String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ 
					stdDist1=res1.getDouble("Km");
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
					if(stdDist1==0)
					{
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
					if(Math.abs(diff)>20)
					{
						bgcolor="background-color:#FF0000";
					}
					else
					{
						
						 bgcolor="";
					}
			
				}
					
						%>
				
					<tr>
					<td style="<%=bgcolor%>; text-align: right"><%=i%></td>
					<td style="<%=bgcolor%>"><div align="right">
					<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=TripID%></font></a><br />
					<div class="popup" id="popup<%=i%>">
					<table border="1" bgcolor="white">
					<tr>
					<td><a href="ShowCustomReportonTWMap.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&data=<%=fromdate1%>&data1=<%= todate1%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&enddate=<%=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>
					<!--<a href="startedtrip.jsp?tripid=<%//=TripID%>&vehcode=<%//=rst.getString("VehId")%>&sdate=<%//=fromdatetime%>&vehregno=<%//=rst.getString("VehRegNo")%>&ownername=<%//=session.getAttribute("user").toString()%>&startplace=<%//=rst.getString("StartPlace")%>&endplace=<%//=rst.getString("EndPlace")%>&enddate=<%//=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>-->
					</td>
					</tr>
					<tr>
					<td><a href="detailed_reportalltrip.jsp?vehcode=<%=rst.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
					</td>
					</tr>
					<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
					</table>
					</div> 
					</div></td>
					<td style="<%=bgcolor%>"><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
					<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("VehRegNo")%></td>
					<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("OwnerName")%></td>
					<td style="<%=bgcolor%>; text-align: left"><%
					try{ 
						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
						
					}catch(Exception ee)
					{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
						

					}
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
				<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
			    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td style="<%=bgcolor%>" ><%="-" %></td>
				<td style="<%=bgcolor%>" ><%="-" %></td>
				<%
			}
		}


		}
		%>
		<td style="<%=bgcolor%>; text-align: left"><%
		try{ 
		out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"))));


		}catch(Exception ee)
		{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);
		}
		%></td>
		<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("EndPlace")%></td>
		<%

		String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
		ResultSet rst12=st2.executeQuery(sql12);
		if(rst12.next())
		{
			
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
			ResultSet rstg111=st2.executeQuery(sqlg1);
			if(rstg111.next())
			{
				%>
				<td style="<%=bgcolor%>; text-align: right"><%=rstg111.getString("Endlat")%></td>
			    <td style="<%=bgcolor%>; text-align: right"><%=rstg111.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td style="<%=bgcolor%>"><%="-" %></td>
				<td style="<%=bgcolor%>"><%="-" %></td>
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
			stdDist=rstdist.getDouble("Km");
		%>
		<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("Km")%></td>
		<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("TTime")%></td>
		<%
		}
		else
		{
			stdDist=0;
		%>
			<td style="<%=bgcolor%>; text-align: left"><%="NA" %></td>
			<td style="<%=bgcolor%>; text-align: left"><%="NA" %></td>
		<%}
		%>
		<td style="<%=bgcolor%>; text-align: right">
		<%
	
		capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
		%> 
		</td> 
		<td style="<%=bgcolor%>; text-align: left">
		<%
		try{

		
			try{
				enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
			}
			catch(Exception e)
			{
				enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
			}

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
		String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
		//System.out.println(sql);
		ResultSet rss=st2.executeQuery(sql);
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
		<td style="<%=bgcolor%>; text-align: left">
		<%
		out.print("Primary");
		%></td>
		<%
		String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
		ResultSet rst13=st2.executeQuery(sql13);
		if(rst13.next())
		{
			%>

			<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('unit_replace_report.jsp?fromdate=<%=fromdatetime%>&todate=<%=todatetime%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"> <b> <%="Yes" %></b></a></td>
			<%
		}
		else
		{
			%>
			<td style="<%=bgcolor%>; text-align: left"><%="No" %></td>
			<%
		}
			String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
		ResultSet rst2=st4.executeQuery(sql2);
		
		if(rst2.next())
		{%>
		<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('vehicle_attended_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>&transporter=<%=rst.getString("OwnerName") %>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b>Attended</b></a></td>
			<%
		}
		else
		{%>
		<td style="<%=bgcolor%>; text-align: left"><%="Not Attended" %></td>
		<%
			
		}

			%>
		<td style="<%=bgcolor%>">
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>

<td style="<%=bgcolor%>; text-align: left"><%=endComment %></td>
<td style="<%=bgcolor%>; text-align: left" ><a href="#" onClick="window.open ('tripcomment.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=finalComment %></a></td>
<td style="<%=bgcolor%>"><input type="button" name="edit" value="Edit" onclick="window.open ('editendtrip.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>&trans=<%=rst.getString("OwnerName")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"></input></td> 
		</tr> 
		<%
				}
				i++;
			}//end of primary check
		}//end of primary sortby check
		else if(sortby1.equalsIgnoreCase("tanker"))
		{
			if(category.equalsIgnoreCase("BPL")||(category.equalsIgnoreCase("tanker")))
			{
				sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
				ResultSet rst=st.executeQuery(sql);
				
				java.util.Date enddte1,strdte1;
				int t=1;
				String slat,slon,elat,elon;
				String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
				long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
				if(rst.next())
				{
				String finalComment="-",comment="-";
					int loop=0;
					String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
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
				
					SDate=rst.getString("StartDate");
					EDate=rst.getString("EndDate");
					STime=rst.getString("StartTime");
					ETime=rst.getString("EndTime");
					endComment=rst.getString("Comment1");

					if(null==STime || STime.length()>8 || STime.equals("-"))
					{
					STime="00:00:00";
					}

					if(null==ETime || ETime.equals("-"))
					{
					ETime="23:59:59";
					}
					
					sdate=SDate+" "+STime;
					try
					{
						fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));	
					}
					catch(Exception e)
					{
						fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
					}
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
					edate=EDate+" "+ETime;
					try
					{
						todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));	
					}
					catch(Exception e)
					{
						todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
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
					try{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
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
					
					millisecdiff=miliseconds2-miliseconds1;
					secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; 

					try{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
					}catch(Exception e)
					{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
					}

					try{
						todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
					}catch(Exception e)
					{
						todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
					}
					
					String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
  					ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ 
					stdDist1=res1.getDouble("Km");
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
					if(stdDist1==0)
					{
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
					if(Math.abs(diff)>20)
					{
						bgcolor="background-color:#FF0000";
				 	 
					}
					else
					{
						 bgcolor="";
					}
			
				}
					
					%>
					<tr>
					<td style="<%=bgcolor%>; text-align: right"><%=i%></td>
					<td style="<%=bgcolor%>"><div align="right">
					<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=TripID%></a><br />
					<div class="popup" id="popup<%=i%>">
					<table border="1" bgcolor="white">
					<tr>
					<td>
					<a href="ShowCustomReportonTWMap.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&data=<%=fromdate %>&data1=<%= todate%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>
					<!--<a href="startedtrip.jsp?tripid=<%//=TripID%>&vehcode=<%//=rst.getString("VehId")%>&sdate=<%//=fromdatetime%>&vehregno=<%//=rst.getString("VehRegNo")%>&ownername=<%//=session.getAttribute("user").toString()%>&startplace=<%//=rst.getString("StartPlace")%>&endplace=<%//=rst.getString("EndPlace")%>&enddate=<%//=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>-->
					</td>
					</tr>
					<tr>			
					<td><a href="detailed_reportalltrip.jsp?vehcode=<%=rst.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
					</td>
					</tr>
					<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
					</table>
					</div> 
					</div></td>
					<td style="<%=bgcolor%>"><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
					<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("VehRegNo")%></td>
					<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("OwnerName")%></td>
					<td style="<%=bgcolor%>; text-align: left"><%
					try{ 
						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
					}catch(Exception ee)
					{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
						

					}
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
				<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
			    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
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

		}catch(Exception ee)
		{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);

		}
		%></td>
		<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("EndPlace")%></td>
		<%

		String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
		ResultSet rst12=st2.executeQuery(sql12);
		if(rst12.next())
		{
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
				<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
			    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
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
			stdDist=rstdist.getDouble("Km");

		%>
		<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("Km")%></td>
		<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("TTime")%></td>
		<%
		}
		else
		{
			stdDist=0;
		%>
			<td style="<%=bgcolor%>; text-align: right"><%="NA" %></td>
			<td style="<%=bgcolor%>; text-align: right"><%="NA" %></td>
		<%}
		%>
		<td style="<%=bgcolor%>; text-align: right">
		<%
		
		capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
		%> 
		</td> 
		<td style="<%=bgcolor%>; text-align: left">
		<%
		try{

		
			try{
				enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
			}
			catch(Exception e)
			{
				enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
			}

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
		String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
		ResultSet rss=st2.executeQuery(sql);
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
		<td style="<%=bgcolor%>; text-align: left"><%
		out.print("Tanker");
		%></td>
		<%
		String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
		ResultSet rst13=st2.executeQuery(sql13);
		if(rst13.next())
		{
			%>
			<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('unit_replace_report.jsp?fromdate=<%=fromdatetime%>&todate=<%=todatetime%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b><%="Yes" %></b></a></td>
			<%
		}
		else
		{
			%>
			<td style="<%=bgcolor%>; text-align: left"><%="No" %></td>
			<%
		}
		
		String sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rst.getString("VehRegNo")+"'";
		ResultSet rst2=st4.executeQuery(sql2);
		if(rst2.next())
		{%>
		<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('vehicle_attended_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>&transporter=<%=rst.getString("OwnerName") %>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b>Attended</b></a></td>
			<%
		}
		else
		{%>
		<td style="<%=bgcolor%>; text-align: left"><%="Not Attended" %></td>
		<%
			
		}

			%>
		
		<td style="<%=bgcolor%>">
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>
<td style="<%=bgcolor%>; text-align: left"><%=endComment %></td>
<td style="<%=bgcolor%>; text-align: left"><a href="#" onClick="window.open ('tripcomment.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=finalComment %></a></td>
<td style="<%=bgcolor%>"><input type="button" name="edit" value="Edit" onClick="window.open ('editendtrip.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>&trans=<%=rst.getString("OwnerName")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"></input></td>
		</tr> 
		<%
				}
				i++;
			}//end of tanker || bpl check
		}//end od sortby tanker check
		else if(sortby1.equalsIgnoreCase("secondary"))
		{
			if(!(category.equalsIgnoreCase("Primary") || category.equalsIgnoreCase("BPL") || category.equalsIgnoreCase("Tanker")))
			{
				sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
				ResultSet rst=st.executeQuery(sql);
				java.util.Date enddte1,strdte1;
				
				String slat,slon,elat,elon;
				String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
				long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
				if(rst.next())
				{
				
					String finalComment="-",comment="-";
					int loop=0;
					String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
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
					
					SDate=rst.getString("StartDate");
					EDate=rst.getString("EndDate");
					STime=rst.getString("StartTime");
					ETime=rst.getString("EndTime");
					endComment=rst.getString("Comment1");

					if(null==STime || STime.length()>8 || STime.equals("-"))
					{
					STime="00:00:00";
					}

					if(null==ETime || ETime.equals("-"))
					{
					ETime="23:59:59";
					}
					
					

					/*#################################change#############################*/

					sdate=SDate+" "+STime;
					try
					{
						fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));	
					}
					catch(Exception e)
					{
						fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));	
					}
				//	System.out.println("StartDate--->>"+fromdate1);
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
					edate=EDate+" "+ETime;
					try
					{
						todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));	
					}
					catch(Exception e)
					{
						todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
					}
				//	System.out.println("todate1--->>"+todate1);
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
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
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
					
					millisecdiff=miliseconds2-miliseconds1;
					secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; 

					try{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
					}catch(Exception e)
					{
						fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
					}

					try{
						todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
					}catch(Exception e)
					{
						todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
					}
					
					//******************************distance difference******************************
					
					String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
					//System.out.println(sqlquery);
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ //System.out.println("12345");
					stdDist1=res1.getDouble("Km");
					//System.out.println(stdDist1);
					
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
					if(stdDist1==0)
					{
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
					if(Math.abs(diff)>20)
					{
						bgcolor="background-color:#FF0000";
					}
					else
					{
						 bgcolor="";
					}
			
				}
					
					
					
					
					
					%>
					<tr>
					<td style="<%=bgcolor%>; text-align: right"><%=i%></td>
					<td style="<%=bgcolor%>"><div align="right">
					<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><%=TripID%></a><br />
					<div class="popup" id="popup<%=i%>">
					<table border="1" bgcolor="white">
					<tr>
					<td>
					<a href="ShowCustomReportonTWMap.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&data=<%=fromdate1 %>&data1=<%= todate1%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&enddate=<%=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>
					<!--<a href="startedtrip.jsp?tripid=<%//=TripID%>&vehcode=<%//=rst.getString("VehId")%>&sdate=<%//=fromdatetime%>&vehregno=<%//=rst.getString("VehRegNo")%>&ownername=<%//=session.getAttribute("user").toString()%>&startplace=<%//=rst.getString("StartPlace")%>&endplace=<%//=rst.getString("EndPlace")%>&enddate=<%//=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%//=i%>,false);">Show On Map</a>-->
					</td>
					</tr>
					<tr>
					<td><a href="detailed_reportalltrip.jsp?vehcode=<%=rst.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
					</td>
					</tr>
					<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
					</table>
					</div> 
					</div></td>
					<td style="<%=bgcolor%>"><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
					<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("VehRegNo")%></td>
					<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("OwnerName")%></td>
					<td style="<%=bgcolor%>; text-align: left"><%
					try{ 
						out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
					}catch(Exception ee)
					{
						out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
						

					}
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
				<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
			    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
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

		
		}catch(Exception ee)
		{
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);

		}
		%></td>
		<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("EndPlace")%></td>
		<%

		String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
		ResultSet rst12=st2.executeQuery(sql12);
		if(rst12.next())
		{
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
				<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
			    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
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
			stdDist=rstdist.getDouble("Km");

		%>
		<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("Km")%></td>
		<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("TTime")%></td>
		<%
		}
		else
		{
			stdDist=0;
		%>
			<td style="<%=bgcolor%>; text-align: right"><%="NA" %></td>
			<td style="<%=bgcolor%>; text-align: right"><%="NA" %></td>
		<%}
		%>
		<td style="<%=bgcolor%>; text-align: right">
		<%
		//***************************************************************************************************************
		capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
		%> 
		</td> 
		<td style="<%=bgcolor%>; text-align: left">
		<%
		try{

			try{
				enddte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"));
			}
			catch(Exception e)
			{
				enddte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate"));
				strdte1=new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
			}

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
		String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
		//System.out.println(sql);
		ResultSet rss=st2.executeQuery(sql);
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
		<td style="<%=bgcolor%>; text-align: left"> <%
		out.print("Secondary");
		%></td>
		<%
		String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
		ResultSet rst13=st2.executeQuery(sql13);
		if(rst13.next())
		{
			%>

			<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('unit_replace_report.jsp?fromdate=<%=fromdatetime%>&todate=<%=todatetime%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b><%="Yes" %></b></a></td>
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
		<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('vehicle_attended_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>&transporter=<%=rst.getString("OwnerName") %>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b>Attended</b></a></td>
			
			
			<%
		}
		else
		{%>
		<td style="<%=bgcolor%>; text-align: left"><%="Not Attended" %></td>
		<%
			
		}

			%>
			
			<td style="<%=bgcolor%>">
<%
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>
<td style="<%=bgcolor%>; text-align: left"><%=endComment %></td>
<td style="<%=bgcolor%>; text-align: left"><a href="#" onClick="window.open ('tripcomment.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=finalComment %></a></td>
<td style="<%=bgcolor%>"><input type="button" name="edit" value="Edit" onClick="window.open ('editendtrip.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>&trans=<%=rst.getString("OwnerName")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"></input></td>
		</tr> 
		<%
				}
				i++;
			}//end of secondary check
		}//end od sortby secondary check
		
		else if(sortby1.equalsIgnoreCase("all"))//for all trips
		{
			//System.out.println("\n\nall");
			sql="select Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,EndPlace,EndCode,EndDate,EndTime,StartKm,EndKm,KmTravelled,JourneyStatus,DriverID,DriverName,JDCode,OwnerName,Comment1 from t_completedjourney where tripid='"+TripID+"'";
			ResultSet rst=st.executeQuery(sql);
			
			java.util.Date enddte1,strdte1;
			
			String slat,slon,elat,elon;
			String SDate,EDate,STime,ETime,tripid,StDate,EdDate,endComment="-";
			long millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
			if(rst.next())
			{
				
				
				String finalComment="-",comment="-";
				int loop=0;
				String sql3="select comment from t_tripcomments where tripid='"+TripID+"' and vehid='"+rst.getString("Vehid")+"' and  vehregno='"+rst.getString("VehRegNo")+"' order by datetime";
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
			
				SDate=rst.getString("StartDate");
				EDate=rst.getString("EndDate");
				STime=rst.getString("StartTime");
				ETime=rst.getString("EndTime");
				endComment=rst.getString("Comment1");

				if(null==STime || STime.length()>8 || STime.equals("-"))
				{
				STime="00:00:00";
				}

				if(null==ETime || ETime.equals("-"))
				{
				ETime="23:59:59";
				}

				sdate=SDate+" "+STime;
				try
				{
					fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate));	
				}
				catch(Exception e)
				{
					fromdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate));
				}
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

				edate=EDate+" "+ETime;
				try
				{
					todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate));
				}
				catch(Exception e)
				{
					todate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate));
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
				
				
				try{
				java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(SDate+" "+STime);
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
				
				millisecdiff=miliseconds2-miliseconds1;
				secdiff=millisecdiff/1000;
				mindiff=secdiff/60;
				hrdiff=mindiff/60; 

				try{
					fromdatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate")));
				}catch(Exception e)
				{
					fromdatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+" "+STime;
				}

				try{
					todatetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate")));
				}catch(Exception e)
				{
					todatetime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+" "+ETime;
				}
				
				
				
//******************************distance difference******************************
				
			String sqlquery="select * from t_castrolroutes where StartPlace='"+rst.getString("StartPlace")+"' and EndPlace='"+rst.getString("EndPlace")+"'"; 
				
				ResultSet res1=st2.executeQuery(sqlquery);
				
							
				if(res1.next())
				{ 
					stdDist1=res1.getDouble("Km");
					
				}
				else
				{
					stdDist1=0;
				}
					capDist1=rst.getDouble("KmTravelled");
					if(stdDist1==0)
					{
					 	bgcolor="";
					
				}
			
				else
				{
					double diff;
					diff=((stdDist1-capDist1)/stdDist1)*100;//difference
					if(Math.abs(diff)>20)
					{
						bgcolor="background-color:#FF0000";
				 	 
					}
					else
					{
						
						 bgcolor="";
					}
			
				}
				
				
				//************************************************************************
				
				%>
				<tr ">
				<!--tr bgcolor="< %=bgcolor%>"-->
				<td style="<%=bgcolor%>" align="right"><%=i%></td>
				<td style="<%=bgcolor%>"><div align="right">
				<a href="javascript:toggleDetails(<%=i%>,true);" title="Click To See the Reports"><font size="2"><%=TripID%></font></a><br />
				<div class="popup" id="popup<%=i%>">
				<table border="1" bgcolor="white">
				<tr>
				<td>
				<a href="ShowCustomReportonTWMap.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&data=<%=fromdate1%>&data1=<%= todate1%>&ftime1=<%=ftime1 %>&ftime2=<%=ftime2 %>&ttime1=<%=ttime1 %>&ttime2=<%=ttime2 %>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%=session.getAttribute("user").toString()%>&startplace=<%=rst.getString("StartPlace")%>&endplace=<%=rst.getString("EndPlace")%>&enddate=<%=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%=i%>,false);">Show On Map</a>
				<!--<a href="startedtrip.jsp?tripid=<%//=TripID%>&vehcode=<%//=rst.getString("VehId")%>&sdate=<%//=fromdatetime%>&vehregno=<%=rst.getString("VehRegNo")%>&ownername=<%//=session.getAttribute("user").toString()%>&startplace=<%//=rst.getString("StartPlace")%>&endplace=<%//=rst.getString("EndPlace")%>&enddate=<%//=todatetime%>&pg=cm" onclick="javascript:toggleDetails(<%//=i%>,false);">Show On Map</a>-->
				</td>
				</tr>
				<tr>
				<td><a href="detailed_reportalltrip.jsp?vehcode=<%=rst.getString("VehId")%>&fromdata=<%=fromdatetime%>&todata=<%=todatetime%>&submit=Submit" onclick="javascript:toggleDetails(<%=i%>,false);">Detail Report</a>
				</td>
				</tr>
				<tr><td><a href="javascript:toggleDetails(<%=i%>,false);">Close</a></td></tr>
				</table>
				</div> 
				</div></td>
				<td style="<%=bgcolor%>"><div align="left"><%=rst.getString("DriverName")%> <%="("+rst.getString("DriverId")+")"%></div></td>
				<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("VehRegNo")%></td>
				<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("OwnerName")%></td>
				<td style="<%=bgcolor%>; text-align: left"><%
				try{ 
					out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StartDate"))));
				}catch(Exception ee)
				{
					out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate")))+"<br>"+STime);
					

				}
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
			<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
		    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
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

	}catch(Exception ee)
	{
		
		out.print(new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("EndDate")))+"<br>"+ETime);	
	}
	%></td>
	<td style="<%=bgcolor%>; text-align: left"><%=rst.getString("EndPlace")%></td>
	<%

	String sql12="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rst.getString("EndPlace")+"' limit 1";
	ResultSet rst12=st2.executeQuery(sql12);
	if(rst12.next())
	{
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
			<td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlat")%></td>
		    <td style="<%=bgcolor%>; text-align: right"><%=rstg1.getString("Endlong")%></td>
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
	ResultSet rstdist=st1.executeQuery(sql);
	if(rstdist.next())
	{ 
		stdDist=rstdist.getDouble("Km");

	%>
	<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("Km")%></td>
	<td style="<%=bgcolor%>; text-align: right"><%=rstdist.getString("TTime")%></td>
	<%
	}
	else
	{
		stdDist=0;
	%>
		<td style="<%=bgcolor%>; text-align: left"><%="NA" %></td>
		<td style="<%=bgcolor%>; text-align: left"><%="NA" %></td>
	<%}
	%>
	<td style="<%=bgcolor%>; text-align: right">
	<%
	//***************************************************************************************************************
	capDist=rst.getDouble("KmTravelled");
		out.print(rst.getString("KmTravelled"));
	%> 
	</td> 
	<td style="<%=bgcolor%>; text-align: right">
	<%
	try{

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
	String sql="Select EndedBy from t_startedjourney where tripid='"+TripID+"'";
	//System.out.println(sql);
	ResultSet rss=st2.executeQuery(sql);
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
	<td style="<%=bgcolor%>; text-align: left"><%
	if(category.equalsIgnoreCase("Primary"))
	{
		out.print("Primary");
	}
	else if(category.equalsIgnoreCase("BPL")||category.equalsIgnoreCase("Tanker"))
	{
		out.print("Tanker");
	}
	else 
	{
		out.print("Secondary");
	}
	
	
	
	%></td>
	<%
	String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rst.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdatetime+"' AND '"+todatetime+"'";
	ResultSet rst13=st2.executeQuery(sql13);
	if(rst13.next())
	{
		%>

		<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('unit_replace_report.jsp?fromdate=<%=fromdatetime%>&todate=<%=todatetime%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b><%="Yes" %></b></a></td>
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
<td style="<%=bgcolor%>; text-align: right"><a href="javascript: flase" onClick="window.open ('vehicle_attended_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&vehcode=<%=rst.getString("VehId")%>&vehregno=<%=rst.getString("VehRegNo")%>&transporter=<%=rst.getString("OwnerName") %>', 'win1', 'width=700, height=270, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><b>Attended</b></a></td>
	
	
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
if(stdDist==0)
{
%>	
<div align="left">
	<%   out.print("NA");  %>
	</div>
<%	
}
else
{
	double diffdist=((stdDist-capDist)/stdDist)*100;
	%>
<div align="right">	
	
	<% out.print(nf.format(diffdist));%>
	</div>
	
<%
}
%>
</td>
<td style="<%=bgcolor%>; text-align: left"><%=endComment %></td>
<td style="<%=bgcolor%>; text-align: left"><a href="javascript: flase" onClick="window.open ('tripcomment.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"><%=finalComment %></a></td>
<td style="<%=bgcolor%>"><input type="button" name="edit" value="Edit" onClick="window.open ('editendtrip.jsp?tripid=<%=TripID%>&vehcode=<%=rst.getString("VehId")%>&vehno=<%=rst.getString("VehRegNo")%>&trans=<%=rst.getString("OwnerName")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');"></input></td>
	</tr>
	<%
	}
			i++;
		}//end of ALL code
		
			
			
			
		
	}//end of if category check loop
	
	//i++;
	
	
}//end of while loop
}
%>
</table> 
<%
}
}catch(Exception e)
{
out.print("Exception -->"+e);
}
finally
{
	
try
{

st.close();
}
catch(Exception e){}
try
{

st1.close();
}
catch(Exception e){}

try
{

st2.close();
}
catch(Exception e){}

try
{

st3.close();
}
catch(Exception e){}

try
{

st4.close();
}
catch(Exception e){}

try
{

st5.close();
}
catch(Exception e){}
try
{
strip.close();
}
catch(Exception e)
{

}
try
{
conn.close();
}
catch(Exception e){}
try
{
	conn2.close();
}catch(Exception e){}
}


%>
</td></tr>

</table>
</form>

<%@ include file="footernew.jsp" %>
