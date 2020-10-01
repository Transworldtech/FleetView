<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<html>
<body>


<script type="text/javascript">
var renderStart = new Date().getTime();
window.onload=function() { 
var renderEnd=new Date().getTime();
var elapsed = new Date().getTime()-renderStart;   
var PageName = document.getElementById("PageName").value;
	try{var ajaxRequest;
	try{ajaxRequest = new XMLHttpRequest();	}  
		catch (e)
		{
		try
		{ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");}
		catch (e)
		{try
		{ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");} 
		catch (e)
		{alert("Your browser broke!");
		return false;
		}}}
		ajaxRequest.onreadystatechange = function()
		{if(ajaxRequest.readyState == 4)
		{try
		{var reslt=ajaxRequest.responseText;
		var result1;
		result1=reslt;
		result1=result1.replace(/^\s+|\s+$/g,'');
		if(result1=="Updated")
		{}
		}catch(e)
		{alert(e);
		}}};		 
		var queryString = "?PageName="+PageName+"&renderStart="+renderStart+"&renderEnd="+renderEnd+"&elapsed="+elapsed+"";
		ajaxRequest.open("GET","Ajax_PageLoadingTime.jsp" + queryString, true);
		ajaxRequest.send(null); 
		}
		   catch(e)
		{
			alert(e);
		}  
}


function gotoPrint(divName)  
{  
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}

function gotoExcel(elemId, frmFldId)
{   
	var originalContents = document.body.innerHTML; 
	var input = document.getElementsByTagName("a");
    var count = input.length;
    for(var i =0; i < count; i++)
    {
         document.getElementsByTagName("a")[i].removeAttribute("href");
    }
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId);  
          oFld.value = obj.innerHTML;  
          document.CastrolMonthly.action ="excel.jsp";
          document.forms["CastrolMonthly"].submit();
          document.body.innerHTML = originalContents; 
 }  
</script>


<%!
Connection conn=null,conn1=null;
Statement st,st1,sset,sset2,sset1,sset3,sset4,sset5,sset6,sset7,sset8,sset9,sset10,sset11;
String fromdate, todate,fromdate1, todate1,datenew1,datenew2;
String sql,sql1,sql2,sql3,sql4,sql5,sql6,sql7,sql8,sql9,sql10,sql11,sql12,sql13,sqlset,vsql,vsql1,vsql2;
int countTrip,bulk,primary,secondary,jcode,dgrt10,dgrt101,dgrt102,dgrt10_0,dgrt10_1,dgrt10_2,dgrt10_3,rviolation,sum=0,sum10,sum12;
int compareDate1=0;
int compareDate=0;
String  exportFileName="CastrolMonthly.xls";
String rduration1;
NumberFormat nf = DecimalFormat.getNumberInstance();

%>
<%

nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);	
nf.setGroupingUsed(false);
String thename;
if(!(null==request.getQueryString()))
{
	
fromdate1=request.getParameter("data1");
todate1=request.getParameter("data2");

fromdate=todate1+"-"+fromdate1+"-01";
if(fromdate1.equalsIgnoreCase("01")||fromdate1.equalsIgnoreCase("03")||fromdate1.equalsIgnoreCase("05")||fromdate1.equalsIgnoreCase("07")||fromdate1.equalsIgnoreCase("08")||fromdate1.equalsIgnoreCase("10")||fromdate1.equalsIgnoreCase("12"))
{
	todate=todate1+"-"+fromdate1+"-31";
}
else
{
	todate=todate1+"-"+fromdate1+"-30";
}
//todate=todate1+"-"+fromdate1+"-31";
datenew1=new SimpleDateFormat("MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
thename=request.getParameter("username");
//System.out.println(thename);
}

else
{
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;
thename="started";
}
//System.out.println(thename);
%>


<form name="dateform" action="" method="get" onsubmit="return validate();">
<input type="hidden" id="PageName" name="PageName" value="<%=PageName%>"/>  

<table align="center" class="stats">
<tr><td colspan="4"><font color="block" size="3" ></font>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font size="3"><B>Castrol Monthly Summary Report</B></font>
</td></tr>
</table>
<table align="center" class="sortable_entry">
<tr>

<td align="right">
<select name="data1" style="">
	<option value="01" selected="selected" >JAN</option>
	<option value="02" >FEB</option>
	<option value="03" >MAR</option>
	<option value="04" >APR</option>
	<option value="05" >MAY</option>
	<option value="06" >JUNE</option>
	<option value="07" >JULY</option>
	<option value="08" >AUG</option>
	<option value="09" >SEPT</option>
	<option value="10" >OCT</option>
	<option value="11" >NOV</option>
	<option value="12" >DEC</option>
</select>

</td>
<td>
<select name="data2" style="">
	<option value="2010" >2010</option>
	<option value="2011" selected="selected">2011</option>
	<option value="2012" >2012</option>
	<option value="2013" >2013</option>
	<option value="2014" >2014</option>
	<option value="2015" >2015</option>
	<option value="2016" >2016</option>
	<option value="2017" >2017</option>
	<option value="2018" >2018</option>
	<option value="2019" >2019</option>
	<option value="2020" >2020</option>
	
</select>
<!-- <input type="text" id="data2" name="data2" value="< %=datenew2%>" size="15" readonly/></td><td align="left">
  <input type="button" name="To Date" value="To Date" id="trigger1">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>-->
</td>
<td>
<select name="username" style="">
	<option value="started" >Started Trips</option>
	<option value="ended" >Ended Trips</option>
	<option value="both" >Started & Ended Trips</option>
</select>
</td>
<td>
<input type="hidden" name="transporter" id="transporter" value="<%=session.getAttribute("usertypevalue").toString()%>">
<input type="submit" name="submit" id="submit" value="submit">
</td>
</tr>
</table>
</form>

<%
if(!(null==request.getQueryString()))
{
try
{
	
//	Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection();	

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
int faultcnt=0,gpscnt=0;
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
int opentot1=0,totauto1=0,manualtot1=0,k=1;
int opentot2=0,totauto2=0,manualtot2=0;
int opentot3=0,totauto3=0,manualtot3=0;
String endedby,tripendate;

%>

<form id="CastrolMonthly" name="CastrolMonthly" action="" method="post">

		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a></td>
			</tr>
		</table>
<div id="mytable">	
<table border="0" width="100%" align="center" class="stats">
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
</td></tr></table>


<%
//datenew1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
//datenew2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
%>
 <table border="0" width="100%" class="stats">

<%
if(!(null==thename))
{
	if(thename.equals("started"))
	{
		
		String sqlCompareDate="SELECT DATEDIFF('"+fromdate+"','2011-10-31') AS DiffDate  ";
		ResultSet rsCompareDate=st1.executeQuery(sqlCompareDate);
		rsCompareDate.next();
		compareDate=rsCompareDate.getInt(1);
		
		String sqlCompareDate1="SELECT DATEDIFF('"+fromdate+"','2011-01-31') AS DiffDate  ";
		ResultSet rsCompareDate1=st1.executeQuery(sqlCompareDate1);
		rsCompareDate1.next();
		compareDate1=rsCompareDate1.getInt(1);
		
		/*in Previous report, ND data was calculated as
			count(ND) where nd='Yes' on t_CastrolTripsStarted table.
			according to new logic Given by ajay sir, ND count i.e sum(ND) is to be dispalyed.
			
			also, briefingg and de-briefing count on "Drivers Counselling Summary"
			table was calculated only for NonFaulty trips. now count for all tripsa will be displayed
		*/
		
		
		opentot1=0;totauto1=0;manualtot1=0;k=1;
		opentot2=0;totauto2=0;manualtot2=0;
		opentot3=0;totauto3=0;manualtot3=0;
%>		
		<tr>
		<td width="50%">
			<table border="1" width="100%" class="sortable">
			<tr><th align="center" colspan="2"><b><font size="2">JD Data from Castrol</font></b></th></tr>
			<%
					sql1="SELECT count(Distinct(`TripID`)) as count FROM t_alljddata WHERE StartDate between '"+fromdate+"' and '"+todate+"'";
					ResultSet rst1=st1.executeQuery(sql1);
					while(rst1.next())
					{
						 alljd=rst1.getInt("count");
					}
				sql2="SELECT count(Distinct(TripID)) as count FROM t_alljddata WHERE StartDate between '"+fromdate+"' and '"+todate+"' and status='NotProcessed'";
//sql2="SELECT count(Distinct(TripID)) as count FROM t_CastrolTripsStarted WHERE TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rst2=st1.executeQuery(sql2);
				while(rst2.next())
				{
					nogpsjd=rst2.getInt("count");
					//totjd=rst2.getInt("count");
				}
				totjd=alljd-nogpsjd;
				percent=Double.valueOf(totjd);
				percent1=Double.valueOf(alljd);
				percent=(percent/percent1)*100;
				//******************************************************************************************************
				%>
				<tr>
				<td><font size="2">Trip Installed with Mobile-Eye</font></td>
				<td align="right"><div align="right"><a href="trips_GPSalljd.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=totjd%></font></a></div></td>
				</tr>
				<tr>
				<td><font size="2">Trip Not Installed with Mobile-Eye</font></td>
				<td align="right"><div align="right"><a href="trips_widoutGPS_castrol.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=nogpsjd%></font></a></div></td>
				</tr>
				<tr>
				<td><font size="2">Total Trips from JD</font></td>
				<td align="right"><div align="right"><a href="trips_alljd.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=alljd%></font></a></div></td>
				</tr>
				<tr>
				<td><font size="2">Percent of Mobile-Eye Installed</font></td>
				<td align="right"><div align="right"><font size="2"><%=nf.format(percent)%></font></div></td>
				</tr>
				</table>
			</td>
			<!--  </tr>
			<tr> -->
			<td width="50%">
				<table border="1" width="100%" class="sortable">
				<tr><th align="center" colspan="2"><font size="2">Captured Trips Summary</font></th></tr>
				<% 
				//*******************************************************************************************
				sql3="select count(distinct(tripid)) as scount from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Status <> 'Faulty'";
				ResultSet rst3=st1.executeQuery(sql3);
				while(rst3.next())
				{
					totdb=rst3.getInt("scount");
				}
				//*********************************************************************************************
				sql4="select count(distinct(tripid)) as count from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+"23:59:59' and Status = 'Faulty'";
				ResultSet rst4=st1.executeQuery(sql4);
				while(rst4.next())
				{
					faultcnt=rst4.getInt("count");
					fltydb=rst4.getInt("count");
				}
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
				<td align="right"><div align="right"><font size="2"><%=nf.format(percent11)%></font></div></td>
				<!--<td></td>-->
			</tr>
			
			</table>
			</td>
			</tr>
				<%
				if(compareDate>0)
					sql5="select count(*) as bidcount from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   and Briefing = 'briefed'";
				else
					sql5="select count(*) as bidcount from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'faulty' and Briefing = 'briefed'";
				
					//out.println(sql5);
					
					ResultSet rst5=st1.executeQuery(sql5);
				if(rst5.next())
				{
					bidcount=rst5.getInt("bidcount");
				}
				
				if(compareDate>0)
					sql6="select count(*) as dbidcount from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'   and Debriefing = 'Yes'";
				else
					sql6="select count(*) as dbidcount from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'faulty' and Debriefing = 'Yes'";
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
				<table border="1" width="100%" class="sortable">
				<tr><th align="center" colspan="4"><font size="2">Drivers Counselling Summary</font></th></tr>
				<tr>
					<td><font size="2">Briefing Identical to Trip Ids</font></td>
					<%
					if(bidcount==0)
					{
						%>
						<td align="right"><div align="right"><font size="2"><%=bidcount%></font></div></td>
						<%
					}else
					{
						%>
						<td align="right"><div align="right"><a href="trips_totidbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=bidcount%></font></a></div></td>
						<%
					}
					%>
					
					<td><font size="2">Debriefing Identical to Trip Ids</font></td>
					<%
					if(dbidcount==0)
					{
						%>
						<td align="right"><div align="right"><font size="2"><%=dbidcount%></font></div></td>
						<%
					}else
					{
						%>
						<td align="right"><div align="right"><a href="trips_totiddbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=dbidcount%></font></a></div></td>
						<%
					}
					%>
					
				</tr>
				<tr>
					<td><font size="2">Briefing Non-Identical to Trip Ids</font></td>
					<%
					if(bcount==0)
					{
						%>
						<td align="right"><div align="right"><font size="2"><%=bcount%></font></div></td>
						<%
					}else
					{
						%>
						<td align="right"><div align="right"><a href="trips_briefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=bcount%></font></a></div></td>
						<%
					}
					%>
					
					<td><font size="2">Debriefing Non-Identical to Trip Ids</font></td>
					<%
					if(dbcount==0)
					{
						%>
						<td align="right"><div align="right"><font size="2"><%=dbcount%></font></div></td>
						<%
					}else
					{
						%>
						<td align="right"><div align="right"><a href="trips_dbrifing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=dbcount%></font></a></div></td>
						<%
					}
					%>
				</tr>
				<tr>
					<td><font size="2">Total Briefing Done</font></td>
					<td align="right"><div align="right"><a href="trips_totbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tbcount%></font></a></div></td>
					<td><font size="2">Total DeBriefing Done</font></td>
					<td align="right"><div align="right"><a href="trips_totdbriefing.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>&thename=<%=thename%>"><font size="2"><%=tdbcount%></font></a></div></td>
				</tr>
				</table>
				</td>
				</tr>
				<%
				
				if(compareDate>0)
				{
					sql9="select count(*) as ndall from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and ND>0  ";
				}
				else
				{
					sql9="select count(ND) as ndall from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and status<>'Faulty' and ND='Yes'";
				}
					
				sql9 = "select count(*) as ndall from db_gps.t_castrolnd where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and category in ('Primary','Secondary')";
					ResultSet rst9=st1.executeQuery(sql9);
				if(rst9.next())
				{
					ndall=rst9.getInt("ndall");
				}
				
				sql9 = "select count(*) as ndall from db_gps.t_castrolnd where TheDate between '"+fromdate+"' and '"+todate+"' and category in ('Tanker','-')";
				 rst9=st1.executeQuery(sql9);
			if(rst9.next())
			{
				ndall=ndall + rst9.getInt("ndall");
			}
				
				if(compareDate1>0)
				{
					sql10="select count(*) as cdall from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and CD>0  ";
				}
				else
				{
					sql10="select count(CD) as cdall from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and CD='Yes'";
				}
		//		sql10="select count(CD) as cdall from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'  and CD='Yes'";
				sql10 = "select count(*) as cdall from db_gps.t_castrolcd where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and category in ('Primary','Secondary') and (CDStartDay <> 0 or CDEndDay <> 0 or CDTransitDay <> 0)";
				ResultSet rst10=st1.executeQuery(sql10);
				if(rst10.next())
				{
					cdall=rst10.getInt("cdall");
				}
				
				sql10 = "select count(*) as cdall from db_gps.t_castrolcd where TheDate between '"+fromdate+"' and '"+todate+"' and category in ('Tanker','-')";
				 rst10=st1.executeQuery(sql10);
				if(rst10.next())
				{
					cdall= cdall + rst10.getInt("cdall");
				}

				 int OS_RED_ZONE_DURATION=0;
				 int OS_YELLOW_ZONE_DURATION=0;
				 int OS_MORE_THAN_LIMIT_DURATION=0;
				 
				 int FULL_FLEET_OS_RED_ZONE_DURATION=0;
				 int FULL_FLEET_OS_YELLOW_ZONE_DURATION=0;
				 int FULL_FLEET_OS_MORE_THAN_LIMIT_DURATION=0;
				 
				sql11="SELECT * FROM CastrolMonthlyReport WHERE Month='"+fromdate1+"' and Year='"+todate1+"' and filter='Started'";
						ResultSet rst11=st1.executeQuery(sql11);
						if(rst11.next())						

						{
							
							OS_RED_ZONE_DURATION=rst11.getInt("OsRedZoneDuration");
							OS_YELLOW_ZONE_DURATION=rst11.getInt("OsYellowZoneDuration");
							OS_MORE_THAN_LIMIT_DURATION=rst11.getInt("OsOtherZoneDuration");
							 	 	
							FULL_FLEET_OS_RED_ZONE_DURATION=rst11.getInt("TotalFleetRedZoneOS");
							FULL_FLEET_OS_YELLOW_ZONE_DURATION=rst11.getInt("TotalFleetYellowZoneOS");
							FULL_FLEET_OS_MORE_THAN_LIMIT_DURATION=rst11.getInt("TotalFleetOtherZoneOS");
							
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
				<table border="1" width="100%" class="sortable">
				<tr><th align="center" colspan="9"><font size="2">CAPTURED DATA SUMMARY</font></th></tr>
				<tr>
				<th><font size="2">Rating Details</font></th>
				<th><font size="2">Km Captured</font></th>
				<th><font size="2">RA </font></th>
				<th><font size="2">RD </font></th>
				<th><font size="2">OS Duration</font></th>
				<th style="width: 100px;"><font size="2">OS Duration<br>(RED Zone)</font></th>
				<th style="width: 100px;" ><font size="2">OS Duration<br>(Yellow Zone)</font></th>
				<th style="width: 100px;"><font size="2">OS Duration<br>(Speed > 65)</font></th>
				<th><font size="2">Rating</font></th>
				
				
				</tr>
				<tr>
				<td><font size="2">Total Fleet</font></td>
				<td align="right"><div align="right"><font size="2"><%=kt%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=ra%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=rd%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=os%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=FULL_FLEET_OS_RED_ZONE_DURATION%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=FULL_FLEET_OS_YELLOW_ZONE_DURATION%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=FULL_FLEET_OS_MORE_THAN_LIMIT_DURATION%></font></div></td>
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
					double redZoneRating=(FULL_FLEET_OS_RED_ZONE_DURATION*osrtng)/os;
					double yellowZoneRating=(FULL_FLEET_OS_YELLOW_ZONE_DURATION*osrtng)/os;
					double otherZoneRating=(FULL_FLEET_OS_MORE_THAN_LIMIT_DURATION*osrtng)/os;
					%>
					<tr> 
						<td><font size="2">Total Fleet Rating</font></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng)%></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(redZoneRating) %></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(yellowZoneRating) %></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(otherZoneRating) %></font></div></td>
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
						<td></td><td></td><td></td>
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
				<td align="right"><div align="right"><font size="2"><%=OS_RED_ZONE_DURATION%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=OS_YELLOW_ZONE_DURATION%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=OS_MORE_THAN_LIMIT_DURATION%></font></div></td>
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
					
					double redZoneRating=(OS_RED_ZONE_DURATION*osrtng11)/os11;
					double yellowZoneRating=(OS_YELLOW_ZONE_DURATION*osrtng11)/os11;
					double otherZoneRating=(OS_MORE_THAN_LIMIT_DURATION*osrtng11)/os11;
					
					%>
					<tr>
						<td>Castrol Fleet Rating</td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng11)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng11)%></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(redZoneRating) %></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(yellowZoneRating) %></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(otherZoneRating) %></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rtng11)%></font></div></td>
						
					</tr>
					<%
					
				}
				else
				{
					%>
					<tr>
						<td><font size="2">Castrol Fleet Rating</font></td><td></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td align="right"><div align="right"><font size="2">NA</font></div></td>
						<td></td><td></td><td></td>
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
				<td align="right"><div align="right"><font size="2"><%=FULL_FLEET_OS_RED_ZONE_DURATION - OS_RED_ZONE_DURATION%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=FULL_FLEET_OS_YELLOW_ZONE_DURATION - OS_YELLOW_ZONE_DURATION%></font></div></td>
				<td align="right"><div align="right"><font size="2"><%=FULL_FLEET_OS_MORE_THAN_LIMIT_DURATION - OS_MORE_THAN_LIMIT_DURATION%></font></div></td>
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
					
					double redZoneRating=((FULL_FLEET_OS_RED_ZONE_DURATION - OS_RED_ZONE_DURATION)*osrtng2)/os2;
					double yellowZoneRating=((FULL_FLEET_OS_YELLOW_ZONE_DURATION - OS_YELLOW_ZONE_DURATION)*osrtng2)/os2;
					double otherZoneRating=((FULL_FLEET_OS_MORE_THAN_LIMIT_DURATION - OS_MORE_THAN_LIMIT_DURATION)*osrtng2)/os2;
					%>
					<tr>
						<td><font size="2">Non-Castrol Fleet Rating</font></td><td></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rartng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(rdrtng2)%></font></div></td>
						<td align="right"><div align="right"><font size="2"><%=nf.format(osrtng2)%></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(redZoneRating) %></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(yellowZoneRating) %></font></div></td>
						<td><div align="right"><font size="2"><%=nf.format(otherZoneRating) %></font></div></td>
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
						<td></td><td></td><td></td>
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
	
	
	 <%
				String sqlset44="select count(distinct(JCode)) as dgrt10,count(JCode) as dgrt10_0   from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='Tanker' and RDurationinHrs>='10' ";
				sqlset44 = "select count(*) as dgrt10_0 from db_gps.t_castrolrunhrs  where TheDate between '"+fromdate+"' and '"+todate+"' and category in ('Tanker','-')";
	 			ResultSet rset44=sset4.executeQuery(sqlset44);
				while(rset44.next())
				{
		 			// dgrt10=rset44.getInt("dgrt10");
		 			dgrt10_0=rset44.getInt("dgrt10_0");
		 			
				}
				
				String sqlset55="select  count(distinct(JCode)) as dgrt101,count(JCode) as dgrt10_1  from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='primary' and RDurationinHrs>='10' ";
				sqlset55 = "select count(distinct(tripid)) as dgrt101,count(*) as dgrt10_1 from db_gps.t_castrolrunhrs where category in ('Primary') and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rset55=	sset5.executeQuery(sqlset55);
				while(rset55.next())
				{
				 dgrt101=rset55.getInt("dgrt101");
				 dgrt10_1=rset55.getInt("dgrt10_1");
					
				}
						
				String sqlset66="select  count(distinct(JCode)) as dgrt102,count(JCode) as dgrt10_2 from t_driver_ds  where  TheDate between '"+fromdate+"' and '"+todate+"' and GPName='Castrol'and Category='secondary' and RDurationinHrs>='10' ";
				sqlset66 = "select count(distinct(tripid)) as dgrt102,count(*) as dgrt10_2 from db_gps.t_castrolrunhrs where category in ('Secondary') and TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
				ResultSet rset66=sset6.executeQuery(sqlset66);
				while(rset66.next())
				{
					 dgrt102=rset66.getInt("dgrt102");
					 dgrt10_2=rset66.getInt("dgrt10_2");
						
				}
				
			 %>
			<tr>
			<td width="100%" colspan="2">
			<table width="100%"><tr> 
			<td width="60%">
				<table border="1" class="sortable">
				<tr><th align="center" colspan="5"><font size="2">POLICY VIOLATIONS SUMMARY</font></th></tr>
				<tr>
					<th><font size="2">Policy Violations</font></th>
					<th><font size="2">Trips</font></th>
					<th colspan="3"><font size="2">Driving Hrs Report</font></th>
					
				</tr>
				<tr>
							<td><font size="2">Night Driving</font></td>
							<td align="right"><div align="right"><a href="Castrol_NDSummary.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>"><font size="2"><%=ndall%></font></div></td>
							 <td><b>Tanker &nbsp;&nbsp; &nbsp;(Violation Count)</b></td>
			       <td><b>Primary &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Violation Count)</b></td>
			       <td><b>Secondary &nbsp;&nbsp;(Violation Count)</b></td>
						</tr>
						<tr>
							<td><font size="2">Continuous Driving</font></td>
							<td align="right">
							
							<%if(cdall > 0)
							{
								%>
								<div align="right"><font size="2"><a href="Castrol_CDSummary.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>"><%=cdall%></a></font></div>
								<%
								
							}
							else
							{
								%>
								<div align="right"><font size="2"><a href="Castrol_CDSummary.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>"><%=cdall%></a></font></div>
								<% 
							}
							%>
							</td>
							<%
			       //  if(dgrt10==0)
			        	 if(dgrt10_0==0)
			         {  %>
			        	 <td>0</td>
			        <% }
			         else
			         {
			      %>			  
			               <td align="right"><div align="right"><a href="Castrol_RunHrsSummary.jsp?date1=<%=fromdate%>&date2=<%=todate%>&cg=Tanker&con=10"><font size="2"><%=dgrt10_0%></font></a></div></td>
			      <%  }   
			        
			      
			       if(dgrt101==0)
			         { %> 
			        	   <td>0</td>
			        <% }
			         else
			         {
			      %>
			          <td align="right"><div align="right"><%=dgrt101%>(<a href="Castrol_RunHrsSummary.jsp?date1=<%=fromdate%>&date2=<%=todate%>&cg=Primary&con=10"><font size="2"><%=dgrt10_1%></font></a>)</div></td>
			       <%  } 
			     
			         if(dgrt102==0)
			         {  %>
			        	    <td>0</td>
			        <%  }
			         else
			         {
			            %>
			         <td align="right"><div align="right"><%=dgrt102%>(<a href="Castrol_RunHrsSummary.jsp?date1=<%=fromdate%>&date2=<%=todate%>&cg=Secondary&con=10"><font size="2"><%=dgrt10_2%></font></a>)</div></td>
	              <%  
	                    }
			         %>
						</tr>
				</table>
				</td>
				
				
				<td width="20%">
				<%
					String disconnCount="",disconnKM="",incidentCount="";
						String sqlDisconn="SELECT sum(DisconnectionCount) ,sum(Disconnectionkm) FROM t_CastrolTripsStarted WHERE "+
						" TripStartDate BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' ";
					ResultSet rsDisconn=st1.executeQuery(sqlDisconn);
					rsDisconn.next();
					disconnCount=rsDisconn.getString(1);
					disconnKM=rsDisconn.getString(2);
					%>
					<table border="1" class="sortable">
					<tr><th align="center" colspan="5"><font size="2">OTHER DETAILS</font></th></tr>
					<tr>
						<td><b>Disconnection Count</b></td>
						<td><div align="right"><%=disconnCount %></div></td>
					</tr>
					<tr>
						<td><b>Disconnection KM</b></td>
						<td><div align="right"><%=disconnKM%></div></td>
						</tr>
						<tr>
						<%
						sqlDisconn="SELECT count(*) FROM  db_gps.t_incidentsms WHERE gpname='Castrol' "+
						" AND UpdatedDateTime  BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59' ";
					rsDisconn=st1.executeQuery(sqlDisconn);
					rsDisconn.next();
						%>
						<td><b>Incident Count</b></td>
						<td><div align="right"><%=rsDisconn.getString(1) %></div></td>
					</tr>
					</table>
				
				</td>
				
				<td width="20%">
					<table border="1" class="sortable">
						<tr><th align="center" colspan="5"><font size="2">ALERT DETAILS</font></th></tr>
						<tr>
							<td><b>Night Driving Alert</b></td>
							<td>NA</td>
						</tr>
						<tr>
							<td><b>Disconnection Alert</b></td>
							<td>NA</td>
						</tr>
						<tr>
							<td><b>Driving Hrs Violation Alert</b></td>
							<td>NA</td>
						</tr>
					</table>
				</td>
				</tr>
				</table>
		</tr>
 
		
			<tr>
			<td colspan="2">
				<table border="1" width="100%" class="sortable">
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
						
						//String category11="";
						String sql111="Select EndedBy,TripEndDate,Category from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Primary' and status<>'Faulty'";
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
							<!-- <td align="right"><div align="right"><font size="2">< %=totauto1%></font></div></td>-->
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
							<td align="right"><div align="right"><font size="2"><%=TJDTrips%></font></div></td>
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
			         %>
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
						
						
						//String category11="";
						String sqltrip11="Select EndedBy,TripEndDate,Category from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Tanker' and status<>'Faulty'";
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
							<td align="right"><div align="right"><font size="2"><%=SJDTrips%></font></div></td>
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
						
						String sqltrip12="Select EndedBy,TripEndDate,Category from t_CastrolTripsStarted where TripStartDate between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and Category='Secondary' and status<>'Faulty'";
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
	try
	{
	fleetview.closeConnection1();
	}catch(Exception e)
	{}
	try
	{
	fleetview.closeConnection();
	}catch(Exception e)
	{
	}
}
}

%>
</td></tr>


</table>
</div>

</form>
</table>
</body>
</html>
<%@ include file="footernew.jsp" %>
</jsp:useBean>
