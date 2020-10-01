<%@ include file="headernew.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

<%@ page import="com.transworld.fleetview.framework.VehicleDao"
		 import="com.fleetview.beans.ZoneColorIdentificationImpl" %>

<link href="css/css.css" rel="StyleSheet" type="text/css">
<script src="elabel.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>



<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript" language="JavaScript"></script>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<jsp:useBean
	id="vehicleDao" type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script language="javascript">

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
    var obj = document.getElementById(elemId);  
    var oFld = document.getElementById(frmFldId); 
    oFld.value = obj.innerHTML;
    
    document.brifCustomReport.action ="excel.jsp";
    document.forms["brifCustomReport"].submit();
} 
</script>
<%!
String VehicleCode,vehicleRegistrationNo, fromdate, todate, desc,vehregno,fromtime,totime,ftime1,ftime2,ttime1,ttime2,transporter,driverid,tripid;
String vehid,ss1,ss2,ss3,dd,vehicle;
String datenew1,datenew2;
Connection conn;
Statement st,sttemp;
String sql;
boolean flag=true;
%>
<%
String targetvalue1=session.getAttribute("usertypevalue").toString();
targetvalue1=session.getAttribute("usertypevaluemain").toString();
String dateformat="dd-MMM-yyyy";
dateformat=session.getAttribute("dateformat").toString();

ArrayList<String> target1=(ArrayList<String>)session.getAttribute("TargetList");
String empnamee="";
String bgColor="",routeID="";
ZoneColorIdentificationImpl zoneColor = new ZoneColorIdentificationImpl(); 

int numRecords = 0;


String fromPage=request.getParameter("fromPage");
String deviationType=request.getParameter("deviationType");
//System.out.println(deviationType);

//	VehicleCode=request.getParameter("vehcode");
//	datenew1=datenew2=request.getParameter("data");
	
	
	try{
	datenew1= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("startDate")));
	datenew2= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("endDate")));
	}
	catch(Exception e){
		datenew1= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("startDate")));
		datenew2= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("endDate")));
	}
	VehicleCode =request.getParameter("vehcode");
	tripid = request.getParameter("tripid");
	transporter = request.getParameter("transporter");
	vehicleRegistrationNo = request.getParameter("vehicleRegistrationNo");
	routeID = zoneColor.getRouteId(VehicleCode);
	/*System.out.println("tripid=="+tripid);
	System.out.println("VehicleCode=="+VehicleCode);
	System.out.println("vehicleRegistrationNo=="+vehicleRegistrationNo);
	System.out.println("transporter=="+transporter);*/
	//System.out.println(driverid);



if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sttemp=conn.createStatement();
	
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		
		if(target1.contains(targetvalue1))
		{
			empnamee=rst.getString("EmpName");
		//	System.out.println(driverid);
		}
	}
%>
<table border="0" width="100%" bgcolor="white">  
<tr align="center"><td>
<!--<center><div class="bobyText"><font size="2" ><b> Detail report  for the vehicle < %=vehicleRegistrationNo%></b></font></div></center>-->
<!--<div class="bodyText" align="right">Date : < %
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %>
</div>--></td></tr>
<%
	
	
		try{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("startDate")));
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("endDate")));
		}
		catch(Exception e){
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("startDate")));
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("endDate")));
		}

		try{
			fromtime = new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("startDate")));
			totime=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("endDate")));
		}
		catch(Exception e){
			fromtime = "00:00:00";
			totime = "23:59:59";
		}
		
	//	System.out.println(fromdate+" "+"----"+todate+" ");
	
	
	%>
	
<tr><td>
<%
String exportFileName=session.getAttribute("user").toString()+"_brifCustomReport.xls";  
if(!(null==request.getParameter("tripid")))
{
/* all code comes here */
%>

<form id="brifCustomReport" name="brifCustomReport" action="" method="post" >
    <div id="table1">
<table width="100%" align="center" class="stats">
<tr>
<td align="center"><font size="3"><b> Detail Report for Vehicle <%=vehicleRegistrationNo%> from <%=datenew1 %>  to <%=datenew2%> </b></font>

<div class="bodyText" align="left">
<!--<font size="3"><B></B><a href="#" onclick="javascript:window.open('show_custom_detail_rept_onMap.jsp?tripid=null&vehcode=< %=VehicleCode %>&data=< %=fromdate %>&data1=< %= todate%>&ftime1=< %=ftime1 %>&ftime2=< %=ftime2 %>&ttime1=< %=ttime1 %>&ttime2=< %=ttime2 %>&fromtime=< %=fromtime%>&totime=< %=totime%>');""> <font size="2"> <u>Journey On Map.</u></font></a> </font>-->
<div align="right">
	<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
    <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName %>" /> 
	
	<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
    <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
      
    <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
    <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>
		&nbsp;&nbsp;&nbsp;<%=fleetview.PrintDate() %>
	</div>
	<input type="hidden" id="tripid" value="<%=tripid %>">
	<input type="hidden" id="transporter" value="<%=transporter%>">
	<input type="hidden" id="driverid" value="<%=driverid%>">
	<input type="hidden" id="vehid" value="<%=VehicleCode%>">
	<input type="hidden" id="deviationType" value="<%=deviationType%>">
	
</td></tr>
</table>

<table width="100%" align="center" class="sortable" border="1">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed</th>
<th>Distance</th>
<th align="left">Location</th>

<%
String sqlchecksensorveh="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp=sttemp.executeQuery(sqlchecksensorveh);
if(rsttemp.next())
{
	%>
	<th>Sen1</th>
	<th>Sen2</th>
	<th>Sen3</th>
	<th>Sen4</th>
	<% 
}
%>
</tr>
<%
String sqlnew="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+fromdate+" "+fromtime+"' order by concat(TheFieldDataDate,' ',TheFieldDataTime) desc limit 1";
ResultSet rstnew=st.executeQuery(sqlnew);
if(rstnew.next())
{
	fromdate=rstnew.getString("TheFieldDataDate");
	fromtime=rstnew.getString("TheFieldDataTime");
	//System.out.println("fromdate---->"+fromdate+"fromtime-->"+fromtime);
	
}

sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+todate+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
//System.out.println(sql);
ResultSet rst1=st.executeQuery(sql);
int i=1;
int x=0;
int dist=0;

if(rst1.first())
{
	try{
		if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
		{
				
		}
		else{
		//zoneColor = vehicleDao.getZoneColor(routeID, rst1.getString("LatinDec"),rst1.getString("LonginDec"));
		bgColor=zoneColor.getZoneColor(routeID,Double.parseDouble(rst1.getString("LatinDec")),Double.parseDouble(rst1.getString("LonginDec")));
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	

	
	if(i==1)
	{
		dist=rst1.getInt("Distance");
		//System.out.println("dist::>>"+dist);
	}
%>
	<tr>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
		<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
	<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
	
	if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
				}
				else
				{
					%>
		
		
		<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
		</div></td>
		<%
				}
		
String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
if(rsttemp1.next())
{
	
	if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
	<%
	}
	if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
	<%
	}
	if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
	<%
	}
	if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
	<%
	}
	%>
	<% 
}
%>
	</tr>
<%
i++;

}

while(rst1.next())
{
	try{
		if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
		{
				
		}
		else{
		//zoneColor = vehicleDao.getZoneColor(routeID, rst1.getString("LatinDec"),rst1.getString("LonginDec"));
		bgColor=zoneColor.getZoneColor(routeID,Double.parseDouble(rst1.getString("LatinDec")),Double.parseDouble(rst1.getString("LonginDec")));
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
	if(rst1.getString("TheFiledTextFileName").equals("SI"))
	{
		
		if(rst1.getInt("Speed")==0)
		{
			
			if(flag)
			{
				//System.out.println("HIIIIIIIII");
				flag=false;
				x=1;
				%>
				<tr>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
					<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td style="<%=bgColor%>" class="bodyText" ><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
				<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
					
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
					</div></td>
					<%
					}
					%>
					<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
					
				</tr>
				<%
				i++;
			}
		}
		
		else
		{//SI wid  sp>0
			if(x==1)
			{
				flag=true;
				%>
				<tr>
					<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
					<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="Start"%></div></td>
					<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
					</div></td>
					<%
					}
					%>
					<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
				</tr>
				<%
				i++;
				x++;
			}
			
			flag=true;	
			%>
			<tr>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=i%></div></td>
				<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
				<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
				
				<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
	{
		 %>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		
		<%
	}else
	{
		%>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
	}
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
				
				<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
				</div></td>
				<%
					}
				%>
				<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
			</tr>
			<%
			i++;
		}
	}//ens of SI check
	else
    {
		if(rst1.getString("TheFiledTextFileName").equals("OF"))
    
		{
			String long1,long2,long3,lat1,lat2,lat3,loc1,loc2,loc3;
			int ds1,ds2,ds3;
			java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			loc1=rst1.getString("TheFieldSubject");
			lat1=rst1.getString("LatinDec");
			long1=rst1.getString("LonginDec");
			ds1=rst1.getInt("Distance");
			String speedof = rst1.getString("Speed");
			if(rst1.next())
			{
				if(rst1.getString("TheFiledTextFileName").equals("ON")||rst1.getString("TheFiledTextFileName").equals("SI"))
				{
					if(rst1.getString("TheFiledTextFileName").equals("SI"))
					{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						String speedsi = rst1.getString("Speed");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						
						if(mils3 > 20)
						{
							%>
							<tr>
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt1)%></div></td>
						<%
						/*if(mils3>=60)
						{
							hrs=mils3/60;
							mins=mils3%60;*/
							%>
							<!-- <td style="< %=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;< %=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>-->
							
							<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=speedof%></div></td>
							<%								
						/*}
						
						else
						{*/
							
							%>
						<!-- <td style="< %=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;< %="00 Hrs. "+mils3+" Mins. OFF"%></div></td>-->
						<%
						//}
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds1-dist)%></div></td>
						<% }
						else
						{
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds1-dist%></div></td>
							<%
						}
							if(target1.contains(targetvalue1))
							{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1 %>&long=<%=long1%>&discription=<%=empnamee+"<br>"+loc1%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1 %>&long=<%=long1%>&discription=<%=empnamee+"<br>"+loc1%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc1 %></a>
						</div></td>
						<%
							
						}
						else
							{
							%>
									
									
									<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat1,long1,loc1) %>
									</div></td>
									<%
							}
									%>
									<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
									</tr>
									<%		
					i++;
					%>
					
					<tr>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
												<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
												<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=speedsi%></div></td>
												<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
												{
												 %>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
												<% }
												else
												{
												%>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds2-dist%></div></td>
												<%
												}
												if(target1.contains(targetvalue1))
												{
												String d3=empnamee+"<br>"+loc2;
											%>
											<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc2 %></a>
											</div></td>
											<%
											}
											else
												{
												%>
														
														<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat2,long2,loc2) %>
														</div></td>
														<%
												}
														%>
														<%
			String sqlchecksensorveh11="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp11=sttemp.executeQuery(sqlchecksensorveh11);
			if(rsttemp11.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>	
													<%		
					i++;
					%>
					
					
					<tr>
												<td  style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
												<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
												<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="START"%></div></td>
												<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
												{
												 %>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
												<% }
												else
												{
												%>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds2-dist%></div></td>
												<%
												}
												if(target1.contains(targetvalue1))
												{
											String d3=empnamee+"<br>"+loc2;
											%>
											<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc2 %></a>
											</div></td>
											<%
											}
											else
												{
												%>
														
														<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat2,long2,loc2) %>
														</div></td>
														<%
												}
														%>
														<%
			String sqlchecksensorveh111="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp111=sttemp.executeQuery(sqlchecksensorveh111);
			if(rsttemp111.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>	
													<%		
					i++;
					flag=true;
					%>
					
					
					<tr>
							<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=i%></div></td>
							<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
							<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
							<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
												{
												 %>
												<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds2-dist)%></div></td>
												<% }
												else
												{
												%>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds2-dist%></div></td>
												<%
												}
							if(target1.contains(targetvalue1))
							{
						String d2=empnamee+"<br>"+loc2;
						%>
						<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc2 %></a>
						</div></td>
						<%
						}
						else
							{
							%>
									
									<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat2,long2,loc2) %>
									</div></td>
									<%
							}
									%>
									<%
			String sqlchecksensorveh1111="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1111=sttemp.executeQuery(sqlchecksensorveh1111);
			if(rsttemp1111.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
								</tr>	
								<%
								i++;
						}
					}//end of SI check after OF stamp
					
					else if(rst1.getString("TheFiledTextFileName").equals("ON"))
					{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						String speedon = rst1.getString("Speed");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						
						if(mils3 > 20)
						{
							if(rst1.next())
							{
								if(rst1.getString("TheFiledTextFileName").equals("SI"))
								{
									loc3=rst1.getString("TheFieldSubject");
									//System.out.println("Stamp::>>"+rst1.getString("TheFiledTextFileName"));
									lat3=rst1.getString("LatinDec");
									long3=rst1.getString("LonginDec");
									ds3=rst1.getInt("Distance");
									
									%>
									<tr>
								<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
								<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt1)%></div></td>
								<%
								/*if(mils3>=60)
								{
									hrs=mils3/60;
									mins=mils3%60;*/
									%>
								<!-- 	<td style="< %=bgColor%>"  class="bodyText"><div align="right">&nbsp;&nbsp;< %=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>-->
									<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=speedof%></div></td>
									<%								
								/*}
								
								else
								{*/
									
									%>
							<!-- <td style="< %=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;< %="00 Hrs. "+mils3+" Mins. OFF"%></div></td>-->
								<%
							//	}
								%>
								
								
								<%
						
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds1-dist)%></div></td>
						<% }
						else
						{
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds1-dist%></div></td>
							<%
						}
									if(target1.contains(targetvalue1))
									{
								String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
								%>
								<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1 %>&long=<%=long1%>&discription=<%=empnamee+"<br>"+loc1%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1 %>&long=<%=long1%>&discription=<%=empnamee+"<br>"+loc1%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc1 %></a>
								</div></td>
								<%
									
								}
								else
									{
									%>
											
											
											<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat1,long1,loc1) %>
											</div></td>
											<%
									}
											%>
											<%
			String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
			if(rsttemp1.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
											</tr>
											<%		
									i++;
											%>
											<tr>
												<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
												<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat+" HH:mm:ss").format(dt2)%></div></td>
												<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=speedon%></div></td>
												<%
						
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds3-dist)%></div></td>
						<% }
						else
						{
							%>
							<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=ds3-dist%></div></td>
							<%
						}
												if(target1.contains(targetvalue1))
												{
											String d3=empnamee+"<br>"+loc3;
											%>
											<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat3 %>&long=<%=long3%>&discription=<%=empnamee+"<br>"+loc3%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat3 %>&long=<%=long3%>&discription=<%=empnamee+"<br>"+loc3%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc3 %></a>
											</div></td>
											<%
											}
											else
												{
												%>
														
														<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat3,long3,loc3) %>
														</div></td>
														<%
												}
														%>
														<%
			String sqlchecksensorveh2="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp2=sttemp.executeQuery(sqlchecksensorveh2);
			if(rsttemp2.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>	
													<%
													i++;
													if(rst1.getInt("Speed")==0)
													{%>
														<tr>
														<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
														<td style="<%=bgColor%>"  class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
														<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
																	<%
						
						if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
						{
						 %>
						
						<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(ds3-dist)%></div></td>
						<% }
						else
						{
							%>
							<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=ds3-dist%></div></td>
							<%
						}
														if(target1.contains(targetvalue1))
														{
															String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
															%>
															<td style="<%=bgColor%>" class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat3 %>&long=<%=long3%>&discription=<%=empnamee+"<br>"+loc3%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat3 %>&long=<%=long3%>&discription=<%=empnamee+"<br>"+loc3%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc3 %></a>
															</div></td>
															<%
														}
														else
														{
														%>
														<td style="<%=bgColor%>" class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat3,long3,loc3) %>
														</div></td>
														<%
														}
														%>
														<%
			String sqlchecksensorveh3="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
			ResultSet rsttemp3=sttemp.executeQuery(sqlchecksensorveh3);
			if(rsttemp3.next())
			{
				
				if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
				<%
				}
				if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
				<%
				}
				if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
				<%
				}
				if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
				{
					%>
					<td style="<%=bgColor%>" class="bodyText"><div align="right">xxxx</div></td>
					<%		
				}
				else
				{
				%>
				<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
				<%
				}
				%>
				<% 
}
											
	%>
													</tr>
													<%
													i++;
													}
							
								}
							}
						}
					}//end of ON stamp after OF stamp
				}//end of SI or ON stamp check
			}
		}//end of OF stamp check
		//flag=true;
    }
}//end of while loop

				
					

		
if(rst1.last())
{
	
	try{
		if("".equalsIgnoreCase(routeID) || " ".equalsIgnoreCase(routeID) || "-".equalsIgnoreCase(routeID))
		{
				
		}
		else{
		//zoneColor = vehicleDao.getZoneColor(routeID, rst1.getString("LatinDec"),rst1.getString("LonginDec"));
		bgColor=zoneColor.getZoneColor(routeID,Double.parseDouble(rst1.getString("LatinDec")),Double.parseDouble(rst1.getString("LonginDec")));
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
%>
	<tr>
		<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=i%></div></td>
		<td style="<%=bgColor%>" class="bodyText"><div align="left"><%=new SimpleDateFormat(dateformat).format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<%if(session.getAttribute("distformat").toString().equalsIgnoreCase("ML"))
		{
			 %>
			<td style="<%=bgColor%>" class="bodyText"><div align="right"><%=(int)fleetview.KM_TO_MILES1(rst1.getInt("Distance")-dist)%></div></td>
		<%}else
		{
			%>
			<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		<%}
				if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
				}
				else
				{
					%>
		
		
		<td style="<%=bgColor%>"  class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
		</div></td>
		<%
				}
				
				String sqlchecksensorveh1="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
				ResultSet rsttemp1=sttemp.executeQuery(sqlchecksensorveh1);
				if(rsttemp1.next())
				{
					
					if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
					<%
					}
					if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
					{
						%>
						<td  style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
					<%
					}
					if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
					<%
					}
					if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
					{
						%>
						<td style="<%=bgColor%>"  class="bodyText"><div align="right">xxxx</div></td>
						<%		
					}
					else
					{
					%>
					<td style="<%=bgColor%>"  class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
					<%
					}
					%>
					<% 
}
		%>
	</tr>
<%
i++;

}
%>
</table>
</div>
</form>
<%
/* code end here*/
}

%>
</td></tr>
<%
//System.out.println("=============="+fromPage);
	%>
<tr>
<td><center><font size="1">Note:- The data is displayed from one record previous to selected date 
for distance accuracy purpose.</font></center></td>
</tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
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
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>
<% //fleetview.closeConnection(); %>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>
