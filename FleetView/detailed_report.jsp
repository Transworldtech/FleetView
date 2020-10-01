<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>	
<script language="javascript">
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
};

function myFunction() {
    window.location.reload();
}

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
String VehicleCode, fromdate, todate, desc,vehregno,fromtime,totime;
String datenew1,datenew2;
Connection conn;
Statement st,st1,sttemp;
String sql;
boolean flag=true;
boolean flag0=false;
%>
<%
String targetvalue1=session.getAttribute("usertypevaluemain").toString();
ArrayList<String> target1=(ArrayList<String>)session.getAttribute("TargetList");
String empnamee="";

VehicleCode=request.getParameter("vehcode");
datenew1=request.getParameter("fromdata");
datenew2=request.getParameter("todata");
//java.util.Date date1=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse("datanew1");
String dd1="",dd2="";
try
{
	dd1=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datenew1));
	datenew1=datenew1;
}catch(Exception e)
{
	dd1=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew1));
	dd1=dd1+ "00:00:00";
	datenew1=datenew1+" 00:00:00";
}
try
{
	dd2=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datenew2));
	datenew2=datenew2;
}catch(Exception e)
{
	dd2=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd").parse(datenew2));
	datenew2=datenew2+ "23:59:59";
	dd2=dd2+" 23:59:59";
}
//System.out.println("datenew1:::"+date1);
//System.out.println("datenew2:::"+datenew2);
if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
try{
	conn = fleetview.ReturnConnection();
	st=conn.createStatement();
	st1=conn.createStatement();
	sttemp=conn.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");
		if(target1.contains(targetvalue1))
		{
			empnamee=rst.getString("EmpName");
		}
	}
%>
<table border="0" width="100%" class="stats">  
<tr align="center">
<td>

 <font size="3"><div ><b>Detail Report<b></div></font></center>

</td>
</tr>
<tr>
<td>
<form name="customdetail" method="get" action="" >
	<input type="hidden" name="vehcode" value="<%=VehicleCode%>">
	<input type="hidden" name="fromdata" value="<%=datenew1%>">
	<input type="hidden" name="todata" value="<%=datenew2%>">
	</td></tr>
<tr><td>
<%

if(!(null==request.getParameter("fromdata")))
{
/* all code comes here */
%>
<table width="100%" align="center" class="stats">
<tr>
<td align="center"><font size="3"><b> Detail Report for Vehicle <%=vehregno%> from <%=dd1  %> to <%=dd2%></b></font>

<div class="bodyText" align="left">
<%
//String date1=new SimpleDateFormat("yyyy-MM-dd").format(datenew1);
//String date2=new SimpleDateFormat("yyyy-MM-dd").format(datenew2);
//System.out.println("date1:>>"+date1);
//System.out.println("date2:>>"+date2);
//System.out.println("fromdate-->"+fromdate);
//System.out.println("todate-->"+todate);
//System.out.println("VehicleCode-->"+VehicleCode);
%>
	
<div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('print_detail_report.jsp?vehcode=<%=VehicleCode%>&data=<%=datenew1%>&data1=<%=datenew2%>');" title="Print Report">
		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="excel_detail_report.jsp?vehcode=<%=VehicleCode%>&data=<%=datenew1%>&data1=<%=datenew2%>" title="Export to Excel">
		<img src="images/excel.jpg" width="15px" height="15px">
		</a>
		&nbsp;&nbsp;&nbsp;<%=fleetview.PrintDate() %>
	</div>
</td></tr>
</table>

<div class="bodyText" align="left" id="tr2" >
	<font size="2" face="Arial">Show Zero Speed Also:
	<input type="checkbox" name="extAll" id="extAll" value="yes" class="formElement" ></input>
	<input type="submit" name="submit" value="Go"  class="formElement">
	</font>
	</div>
<table width="100%" align="center" class="sortable" border="1">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed</th>
<th>Distance</th>
<th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Location</th>
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

String chkbx=request.getParameter("extAll");
System.out.println("CheckBox Val:- "+chkbx);

sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+datenew1+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+datenew2+"' and TheFiledTextFileName in ('SI','OF','ON') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
System.out.print("Jspsql::>>"+sql);
ResultSet rst1=st.executeQuery(sql);
int i=1;
int x=0;
int dist=0;

if(rst1.first())
{
	if(i==1)
	{
		dist=rst1.getInt("Distance");
		//System.out.println("dist::>>"+dist);
	}
%>
	<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
		<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
				if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
				}
				else
				{
					%>
		
		
		<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
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
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
			<%
			}
			if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
			{
				%>
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
			<%
			}
			if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
			{
				%>
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
			<%
			}
			if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
			{
				%>
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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
String prevstamp="";
while(rst1.next())
{
	//if(i==1)
	//{
	//	dist=rst1.getInt("Distance");
		//System.out.println("dist::>>"+dist);
	//}
	if(rst1.getString("TheFiledTextFileName").equals("SI"))
	{
		
		if(rst1.getInt("Speed")==0)
		{
			
			if(flag)
			{
				
				System.out.println("flag");
				flag=false;
				flag0=true;
				x=1;
				if(chkbx==null){
					
					
				%>
				<tr >
					<td class="bodyText"><div align="right"><%=i%></div></td>
					<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText" ><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
					<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
					<%
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
					<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
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
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
						<%
						}
						if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
						<%
						}
						if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
						<%
						}
						if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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
			if(flag0){

				System.out.println("flag0");
				flag=false;
				flag0=true;
				x=1;
				if(!(chkbx==null)){
					System.out.println("!(chkbx==null)");
				%>
				<tr >
					<td class="bodyText"><div align="right"><%=i%></div></td>
					<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText" ><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
					<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
					<%
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
					<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
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
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
						<%
						}
						if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
						<%
						}
						if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
						<%
						}
						if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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
		
		else
		{//SI wid  sp>0
			if(x==1)
			{
				flag=true;
				if(chkbx==null){
					System.out.println("chkbx==null");
				%>
				<tr>
					<td class="bodyText"><div align="right"><%=i%></div></td>
					<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="Start"%></div></td>
					<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
					<%
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
					<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
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
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
						<%
						}
						if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
						<%
						}
						if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
						<%
						}
						if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
						{
							%>
							<td class="bodyText"><div align="right">xxxx</div></td>
							<%		
						}
						else
						{
						%>
						<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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
			}
			
			flag=true;	
			%>
			<tr>
				<td class="bodyText"><div align="right"><%=i%></div></td>
				<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
				<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
				
				<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
				
				<%
					if(target1.contains(targetvalue1))
					{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
					}
					else
					{
					%>
				
				<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
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
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
	<%
	}
	if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
	<%
	}
	if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
	<%
	}
	if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
	<%
	}
	%>
	<% 
}
%>
			</tr>
			<%
			i++;
	//	}
		}
	}//ens of SI check
	else
    {
		if(rst1.getString("TheFiledTextFileName").equals("OF"))
    
		{
			int j=1;
			
			String fdate,ftime,long1,long2,long3,lat1,lat2,lat3,loc1,loc2,loc3;
			int ds1,ds2,ds3;
			java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			loc1=rst1.getString("TheFieldSubject");
			lat1=rst1.getString("LatinDec");
			long1=rst1.getString("LonginDec");
			ds1=rst1.getInt("Distance");
			fdate=rst1.getString("TheFieldDataDate");
			ftime=rst1.getString("TheFieldDataTime");
		
			if(rst1.next())
			{
				if(!(rst1.getString("TheFiledTextFileName").equalsIgnoreCase("VD")))
				{
						
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						//System.out.println(dt1);
						//System.out.println(dt2);
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						//System.out.println(mils1);
						//System.out.println(mils2);
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						//System.out.println("HIiiiiiiiiiiii"+mils3);
						if(mils3 > 20)
						{
							//System.out.println("HIiiiiiiiiiiii");
							%>
							<tr>
						<td class="bodyText"><div align="right"><%=i%></div></td>
						<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></div></td>
						<%
						if(mils3>=60)
						{
							hrs=mils3/60;
							mins=mils3%60;
							%>
							<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
							<%								
						}
						
						else
						{
							
							%>
						<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
						<%
						}
						%>
						
						
						<td class="bodyText"><div align="right"><%=ds1-dist%></div></td>
							<%
							if(target1.contains(targetvalue1))
							{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1 %>&long=<%=long1%>&discription=<%=empnamee+"<br>"+loc1%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1 %>&long=<%=long1%>&discription=<%=empnamee+"<br>"+loc1%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc1 %></a>
						</div></td>
						<%
							
						}
						else
							{
							%>
									
									
									<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat1,long1,loc1) %>
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
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
	<%
	}
	if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
	<%
	}
	if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
	<%
	}
	if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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
												<td class="bodyText"><div align="right"><%=i%></div></td>
												<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
												<td class="bodyText"><div align="right"><%=ds2-dist%></div></td>
												<%
												if(target1.contains(targetvalue1))
												{
											String d3=empnamee+"<br>"+loc2;
											%>
											<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat2 %>&long=<%=long2%>&discription=<%=empnamee+"<br>"+loc2%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=loc2 %></a>
											</div></td>
											<%
											}
											else
												{
												%>
														
														<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(lat2,long2,loc2) %>
														</div></td>
														<%
												}
String sqlchecksensorveh11="select Vehiclecode from t_vehicledetails where Description='TEMPSENSOR' and vehiclecode='"+VehicleCode+"'";
ResultSet rsttemp11=sttemp.executeQuery(sqlchecksensorveh1);
if(rsttemp11.next())
{
	
	if(rst1.getString("Sen1").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
	<%
	}
	if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
	<%
	}
	if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
	<%
	}
	if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
	{
		%>
		<td class="bodyText"><div align="right">xxxx</div></td>
		<%		
	}
	else
	{
	%>
	<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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
	//*****************************************************************
						/*else
						{
							if(rst1.getString("TheFiledTextFileName").equals("OF"))	
							*///System.out.println("HIiiiiiiiiiiii");
							%><!--
							<tr>
						<td class="bodyText"><div align="right">< %=i%></div></td>
						<td class="bodyText"><div align="left">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></div></td>
					-->	<%
						/*if(mils3>=60)
						{
							hrs=mils3/60;
							mins=mils3%60;
							*/%><!--
							<td class="bodyText"><div align="right">&nbsp;&nbsp;< %=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
							--><%								
					/*	}
						
						else
						{
						*/	
							%>
						<!--<td class="bodyText"><div align="right">&nbsp;&nbsp;< %="00 Hrs. "+mils3+" Mins. OFF"%></div></td>-->
						<%
					//	}
						%>
						
						
						<!--<td class="bodyText"><div align="right">< %=ds1-dist%></div></td>-->
							<%
						/*	if(target1.contains(targetvalue1))
							{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
					*/	%>
						<!--<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=< %=lat1 %>&long=< %=long1%>&discription=< %=empnamee+"<br>"+loc1%>" onclick="popWin=open('shownewmap.jsp?lat=< %=lat1 %>&long=< %=long1%>&discription=< %=empnamee+"<br>"+loc1%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=loc1 %></a>
						</div></td>-->
						<%
							
						///}
						//else
						//	{
							%>
									
									
									<!--<td class="bodyText"><div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(lat1,long1,loc1) %>
									</div></td>-->
									<%
							//}
									%>
									</tr>
									<%		
					//i++;
					%>
					
					<!--<tr>
												<td class="bodyText"><div align="right">< %=i%></div></td>
												<td class="bodyText"><div align="left">< %=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText"><div align="right">&nbsp;&nbsp;< %="ON"%></div></td>
												<td class="bodyText"><div align="right">< %=ds2-dist%></div></td>
												<%
												/*if(target1.contains(targetvalue1))
												{
											String d3=empnamee+"<br>"+loc2;
											*/%>
											<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=< %=lat2 %>&long=< %=long2%>&discription=< %=empnamee+"<br>"+loc2%>" onclick="popWin=open('shownewmap.jsp?lat=< %=lat2 %>&long=< %=long2%>&discription=< %=empnamee+"<br>"+loc2%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;< %=loc2 %></a>
											</div></td>
											<%
										/*	}
											else
												{
												*/%>
														
														<td class="bodyText"><div align="left">&nbsp;&nbsp;< %=fleetview.showNewMap(lat2,long2,loc2) %>
														</div></td>
														<%
											//	}
												
														%>
													</tr>-->	
													<%		
				/*	i++;
						
						}*/
				}//end of VD loop
					
					
					
			}			
					
			prevstamp=rst1.getString("TheFiledTextFileName");
		}//end of OF stamp check
		//flag=true;
    }
}//end of while loop

				
					

		
if(rst1.last())
{
%>
	<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
		<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		
		<%
				if(target1.contains(targetvalue1))
				{
						String d1=empnamee+"<br>"+rst1.getString("TheFieldSubject");
						%>
						<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>" onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec") %>&long=<%=rst1.getString("LonginDec")%>&discription=<%=empnamee+"<br>"+rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst1.getString("TheFieldSubject") %></a>
						</div></td>
						<%
				}
				else
				{
					%>
		
		
		<td class="bodyText"><div align="left">&nbsp;&nbsp;<%=fleetview.showNewMap(rst1.getString("LatinDec"),rst1.getString("LonginDec"),rst1.getString("TheFieldSubject")) %>
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
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen1")%></div></td>
			<%
			}
			if(rst1.getString("Sen2").length()< 2 && !(rst1.getString("Sen2").equals("0")))
			{
				%>
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen2")%></div></td>
			<%
			}
			if(rst1.getString("Sen3").length()< 2 && !(rst1.getString("Sen3").equals("0")))
			{
				%>
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen3")%></div></td>
			<%
			}
			if(rst1.getString("Sen4").length()< 2 && !(rst1.getString("Sen1").equals("0")))
			{
				%>
				<td class="bodyText"><div align="right">xxxx</div></td>
				<%		
			}
			else
			{
			%>
			<td class="bodyText"><div align="right"><%=rst1.getString("Sen4")%></div></td>
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

</table>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
try
{
fleetview.closeConnection();
}catch(Exception e)
{
}

}
%>
	</jsp:useBean>
<%@ include file="footernew.jsp" %>
