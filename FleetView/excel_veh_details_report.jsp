<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_veh_details_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<table border="0" width="90%" bgcolor="white" align="center">

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
	
VehicleCode=session.getAttribute("hvid").toString();
fff=session.getAttribute("fff").toString();
ttt=session.getAttribute("ttt").toString();	
fromdate=session.getAttribute("hdate1").toString();
	
todate=session.getAttribute("hdate2").toString();
	
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
<div class="bodyText" align="right">


Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div>

</td></tr>
<tr><td>
<table border="0" width="100%" class="stats">

<tr><td class="hed">Date Time</td><td class="hed">Speed</td><td class="hed">Distance</td><td class="hed">Location - Click To View On Map.</td>

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
<%=rst1.getString("TheFieldDataTime")%></td><td class="bodyText"><%=rst1.getString("Speed")%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Distance"))-dist%></td><td class="bodyText"><div align="left"><% String loc=rst1.getString("TheFieldSubject"); if(loc.equals("-")) out.print("No Data");
else 
{
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
%>
<%=loc%>
<%
}
else
{
%>
<%=loc%>
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
<%=loc%>
<%
}
else
{
%>
<%=loc%>
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
<%=rst1.getString("TheFieldDataTime")%></td><td class="bodyText"><%=rst1.getString("Speed")%></td><td class="bodyText"><%=Integer.parseInt(rst1.getString("Distance"))-dist%></td><td class="bodyText"><div align="left"><% String loc=rst1.getString("TheFieldSubject"); if(loc.equals("-")) out.print("No Data");
else 
{
if(session.getAttribute("usertypevalue").toString().equals("Om"))
{
%>
<%=loc%>
<%
}
else
{
%>
<%=loc%>
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
	conn.close();
}
%>
</td></tr>
</table>

