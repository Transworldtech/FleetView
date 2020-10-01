<%@ include file="headernew.jsp" %>

<div id="1" style="overflow:auto; height:600px;">
<table border="1" width="100%" class="stats">

<tr><td class="hed">
<%!
String VehicleCode, fromdate, todate, desc,fff,ttt,vehregno;
Connection conn;
Statement st1,st2,st3;
ResultSet rst1, rst2, rst3;
int dist, fuel;
boolean flag=true;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1=conn.createStatement();
	
VehicleCode=request.getParameter("vehcode");
	//session.getAttribute("hvid").toString();
fff=request.getParameter("fromdata");
	//session.getAttribute("fff").toString();
ttt=request.getParameter("todata");
	//session.getAttribute("ttt").toString();	
fromdate=request.getParameter("fromdata");
	
todate=request.getParameter("todata");
	
String sql1="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	rst2=st1.executeQuery(sql1);
	if(rst2.next())
	{
		desc=rst2.getString("Description");
		vehregno=rst2.getString("VehicleRegNumber");
	}
	String sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+fff+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ttt+"' and TheFiledTextFileName in('SI','DO','DS') order by concat(TheFieldDataDate,TheFieldDataTime) asc";
rst1=st1.executeQuery(sql);
%>
<center><font size="2" ><div class="bobyText"><b>Detail Report for Vehicle <%=vehregno%>, Transporter <%=session.getAttribute("usertypevalue").toString()%> from date <%=fff%> to Date <%=ttt%><b></div></font></center>
<div class="bodyText" align="right">Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div>

</td></tr>
<tr><td>
<table border="1" width="100%" class="sortable">

<tr><td class="hed">Date Time</td><td class="hed">Speed</td><td class="hed">Distance</td><td class="hed">Location</td>

<%
if(null!=desc && desc.equals("TEMPSENSOR"))
{
%>
<td class="hed">Sen1</td><td class="hed">Sen2</td><td class="hed">Sen3</td><td class="hed">Sen4</td>

<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
%>
<td class="hed">Ltrs.</td>
<%
}
%>
</tr>
<%
int cnt=1;
int cnt2=1;
while(rst1.next())
{
	if(cnt==1)
	{
		dist=Integer.parseInt(rst1.getString("Distance"));
		
		cnt=2;
	}
/********************code for anil123 to show all the stamps *******************/
if(session.getAttribute("usertypevalue").toString().equals("Anil123"))
{
		%>

<tr ><td class="bodyText"><% if(rst1.getString("TheFiledTExtFileName").equals("DS")) out.print("<font color='green'>Door Close  </font>");%><% if(rst1.getString("TheFiledTExtFileName").equals("DO")) out.print("<font color='red'>Door Open  </font>");%>

<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1+" ");

%>
<%=rst1.getString("TheFieldDataTime")%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Speed"))%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Distance"))-dist%></td><td class="bodyText"><div align="left"><% String loc=rst1.getString("TheFieldSubject"); if(loc.equals("-")) out.print("No Data");
else 
{
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
%>
<a href="shownewmap.jsp?lat=<%=rst1.getString("LatitudeDir")%>&long=<%=rst1.getString("LongitudeDir")%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatitudeDir")%>&long=<%=rst1.getString("LongitudeDir")%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a>
<%
}
else
{
%>
<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a>
<%
}
} 
%>

</div>
</td>
<%
if(null!=desc && desc.equals("TEMPSENSOR"))
{
%>
<td class="hed" align="center"><%
try{
if(rst1.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rst1.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%
try{
if(rst1.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rst1.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td class="hed" align="center"><%

out.print("xxxx");

 %></td>
<td class="hed" align="center"><%

out.print("xxxx");

 %></td>



<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
	}
%>
<td class="bodyText"><% if(rst1.getString("Sen1").equals("-")){} else out.print((Integer.parseInt(rst1.getString("Sen1"))-fuel)*0.005);%></td>
<%
}
%>
</tr>
<%
}
else
{
	


/**********************end of code anil123 ************************************/


if(Integer.parseInt(rst1.getString("Speed"))==0 && rst1.getString("TheFiledTExtFileName").equals("SI"))

{

/*********************************************************************************/
if(flag)
{
flag=false;
%>

<tr ><td class="bodyText"><% if(rst1.getString("TheFiledTExtFileName").equals("DS")) out.print("<font color='green'>Door Close  </font>");%><% if(rst1.getString("TheFiledTExtFileName").equals("DO")) out.print("<font color='red'>Door Open  </font>");%>

<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1+" ");

%>
<%=rst1.getString("TheFieldDataTime")%></td><td class="bodyText"><%="STOP"%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Distance"))-dist%></td><td class="bodyText"><div align="left"><% String loc=rst1.getString("TheFieldSubject"); if(loc.equals("-")) out.print("No Data");
else 
{
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
%>
<a href="shownewmap.jsp?lat=<%=rst1.getString("LatitudeDir")%>&long=<%=rst1.getString("LongitudeDir")%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatitudeDir")%>&long=<%=rst1.getString("LongitudeDir")%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a>
<%
}
else
{
%>
<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a>
<%
}
} 
%>

</div>
</td>
<%
if(null!=desc && desc.equals("TEMPSENSOR"))
{
%>

<td align="center"><%
try{
if(rst1.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rst1.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td align="center"><%
try{
if(rst1.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rst1.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td  align="center"><%

out.print("xxxx");

 %></td>
<td align="center"><%

out.print("xxxx");

 %></td>

<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
	}
%>
<td class="bodyText"><% if(rst1.getString("Sen1").equals("-")){} else out.print((Integer.parseInt(rst1.getString("Sen1"))-fuel)*0.005);%></td>
<%
}
%>
</tr>
<%
}

/*********************************************************************************/

}
else
{
flag=true;
	%>

<tr ><td class="bodyText"><% if(rst1.getString("TheFiledTExtFileName").equals("DS")) out.print("<font color='green'>Door Close  </font>");%><% if(rst1.getString("TheFiledTExtFileName").equals("DO")) out.print("<font color='red'>Door Open  </font>");%>

<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1+" ");

%>
<%=rst1.getString("TheFieldDataTime")%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Speed"))%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Distance"))-dist%></td><td class="bodyText"><div align="left"><% String loc=rst1.getString("TheFieldSubject"); if(loc.equals("-")) out.print("No Data");
else 
{
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
%>
<a href="shownewmap.jsp?lat=<%=rst1.getString("LatitudeDir")%>&long=<%=rst1.getString("LongitudeDir")%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatitudeDir")%>&long=<%=rst1.getString("LongitudeDir")%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a>
<%
}
else
{
%>
<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=loc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=loc%>','myWin','width=500,height=500');popWin.focus();return false"><%=loc%></a>
<%
}
} 
%>

</div>
</td>
<%
if(null!=desc && desc.equals("TEMPSENSOR"))
{
%>

<td align="center"><%
try{
if(rst1.getString("Sen1").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rst1.getDouble("Sen1"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td align="center"><%
try{
if(rst1.getString("Sen2").equals("0"))
{
out.print("xxxx");
}
else
{
out.print(rst1.getDouble("Sen2"));
}
}
catch(Exception e1)
{
	try{
	out.print("xxxx");
	}
	catch(Exception e2)
	{
	}
}
 %></td>
<td  align="center"><%

out.print("xxxx");

 %></td>
<td align="center"><%

out.print("xxxx");

 %></td>
<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
	}
%>
<td class="bodyText"><% if(rst1.getString("Sen1").equals("-")){} else out.print((Integer.parseInt(rst1.getString("Sen1"))-fuel)*0.005);%></td>
<%
}
%>
</tr>
<%
}
}
}
%>
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
	
	}
	catch(Exception e){}
}
%>
</td></tr></table></div>
<!-- footer starts here-->
<%@ include file="footernew.jsp" %>