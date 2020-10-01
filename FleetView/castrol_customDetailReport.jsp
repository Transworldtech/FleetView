<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

<%@ page import="com.transworld.fleetview.framework.VehicleDao"
		 import="com.fleetview.beans.ZoneColorIdentificationImpl"%>
<%@ include file="briefing/header.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<jsp:useBean
	id="vehicleDao" type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<script language="javascript">
function Validate()
{ 
    
	if(document.getElementById("data").value=="") 
	{
		alert("Please Select The from date.");
		return false;
	}
	if(document.getElementById("data1").value =="")
  	{
		alert("please select To Date");
		return false;
  	}  		
		return datevalidate();
	return true;
	
}
function datevalidate()
{
	var date1=document.getElementById("data").value;
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
<%!
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime,ftime1,ftime2,ttime1,ttime2;
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

String vehicleRegistrationNo = request.getParameter("vehicleRegistrationNo");
String veh = request.getParameter("vehicleRegistrationNo");
//System.out.println("==="+veh);
StringTokenizer stk = new StringTokenizer(veh,",");
vehicleRegistrationNo =stk.nextToken();
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	sttemp=conn.createStatement();
	sql="select * from t_vehicledetails where Vehicleregnumber='"+vehicleRegistrationNo+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		VehicleCode = rst.getString("vehiclecode");
		System.out.println("~~~VehicleCode"+VehicleCode+"-----");
	}
	
	ZoneColorIdentificationImpl zoneColor = new ZoneColorIdentificationImpl();
	routeID = zoneColor.getRouteId(VehicleCode);
%>
<table border="0" width="100%" bgcolor="white">  
<tr align="center">
<td>
<!-- <div align="left"><font size="3">Report No:1.12</font></div>-->
 <font size="3"><div ><b>Custom Detail Report<b></div></font></center>
<div class="bodyText" align="right">

</div>
</td>
</tr>
<tr>
<td>
<form name="customdetail" method="get" action="" >
	<input type="hidden" name="vehicleRegistrationNo" value="<%=vehicleRegistrationNo%>">
	
	<table border="0" align="center" width="750" align="right">  
 	<tr>
 	<td align="left"><b>From&nbsp;&nbsp;</b>
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ftime1" id="ftime1">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<24;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		</select>
		<select name="ftime2" id="ftime2">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<60;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		
		</select>
  		</td>
<!--	<td align="left">-->
<!--		<input type="button" name="From Date" value="From Date" id="trigger">-->
<!--		-->
<!--	</td>-->
	<td align="left"><b>To&nbsp;&nbsp;</b>
		<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12" readonly/>
		<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "trigger1"       // ID of the button
    }
  );
		</script>
		&nbsp;&nbsp;
		<select name="ttime1" id="ttime1" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
		<select name="ttime2" id="ttime2" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<59;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="59" selected>59</option>
		</select>		
		</td>
<!--		<td align="left">-->
<!--  		<input type="button" name="To Date" value="To Date" id="trigger1">-->
<!--		-->
<!--	</td>-->
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
		<input type="submit" name="submit" value="Submit">
	</div></td>
	<%
	if(!(null==request.getParameter("data")))
			{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
	
	ftime1=request.getParameter("ftime1");
	ftime2=request.getParameter("ftime2");
	ttime1=request.getParameter("ttime1");
	ttime2=request.getParameter("ttime2");
		
	fromtime=request.getParameter("ftime1")+":"+request.getParameter("ftime2")+":00";
		totime=request.getParameter("ttime1")+":"+request.getParameter("ttime2")+":00";
		
		
	//out.print(fromtime+"  "+totime);
			}
	%>
	</tr>
	</table>
</td></tr>
<tr><td>
<%

if(!(null==request.getParameter("data")))
{
	/* all code comes here */
	%>
	<table width="100%" align="center">
	<tr>
	<td align="center"><font size="3"><b> Detail Report for Vehicle <%=vehicleRegistrationNo%> from <%=datenew1 %>  to <%=datenew2%> </b></font>

	<div class="bodyText" align="left">
	<!--<font size="3"><B></B><a href="#" onclick="javascript:window.open('show_custom_detail_rept_onMap.jsp?tripid=null&vehcode=< %=VehicleCode %>&data=< %=fromdate %>&data1=< %= todate%>&ftime1=< %=ftime1 %>&ftime2=< %=ftime2 %>&ttime1=< %=ttime1 %>&ttime2=< %=ttime2 %>&fromtime=< %=fromtime%>&totime=< %=totime%>');""> <font size="2"> <u>Journey On Map.</u></font></a> </font>-->
	<div class="bodyText" align="right">
		<!--<a href="#" onclick="javascript:window.open('castrol_custom_report.jsp?vehcode=< %=VehicleCode%>&data=< %=fromdate%>&data1=< %=todate%>&fromtime=< %=fromtime%>&totime=< %=totime%>');" title="Print Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>-->&nbsp; &nbsp; 
		<a href="excel_castrol_customdetail_report.jsp?vehcode=<%=VehicleCode%>&vehicleRegistrationNo=<%=vehicleRegistrationNo%>&data=<%=fromdate%>&data1=<%=todate%>&fromtime=<%=fromtime%>&totime=<%=totime%>" title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>
		&nbsp;&nbsp;&nbsp;<%=fleetview.PrintDate() %>
	</div>
		
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
			bgColor = zoneColor.getZoneColor(routeID,Double.parseDouble(rst1.getString("LatinDec")),Double.parseDouble(rst1.getString("LonginDec")));
			}}
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
			bgColor = zoneColor.getZoneColor(routeID,Double.parseDouble(rst1.getString("LatinDec")),Double.parseDouble(rst1.getString("LonginDec")));
			}}
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
							if(mils3>=60)
							{
								hrs=mils3/60;
								mins=mils3%60;
								%>
								<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
								<%								
							}
							
							else
							{
								
								%>
							<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
							<%
							}
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
													<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
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
									if(mils3>=60)
									{
										hrs=mils3/60;
										mins=mils3%60;
										%>
										<td style="<%=bgColor%>"  class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
										<%								
									}
									
									else
									{
										
										%>
									<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
									<%
									}
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
													<td style="<%=bgColor%>" class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
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
			bgColor = zoneColor.getZoneColor(routeID,Double.parseDouble(rst1.getString("LatinDec")),Double.parseDouble(rst1.getString("LonginDec")));
			}}
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
	<%
	/* code end here*/
}

%>
</td></tr>
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
