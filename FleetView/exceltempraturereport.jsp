<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_detail_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>

<%
String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString()+"&fromtime1="+session.getAttribute("fromtime1").toString()+"&fromtime2="+session.getAttribute("fromtime2").toString()+"&totime1="+session.getAttribute("totime1").toString()+"&totime2="+session.getAttribute("totime2").toString();
//String ll="?calender="+session.getAttribute("hdate1").toString()+"&calender1="+session.getAttribute("hdate2").toString()+"&mode="+session.getAttribute("mode").toString()+"&rvehid="+session.getAttribute("hvid").toString();
%>

<table border="0" width="90%" bgcolor="white" align="center">

<tr><td class="hed">
<%!
String VehicleCode, fromdate, todate, desc,fff,ttt;
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
	}
	String sql="select * from t_veh"+VehicleCode+" where TheFieldDataDate>='"+fromdate+"' and TheFieldDataTime >='"+fff+"' and TheFieldDataDate<='"+todate+"' and TheFieldDataTime<='"+ttt+"' and TheFiledTextFileName in('SI','DO','DS') order by concat(TheFieldDataDate,TheFieldDataTime) asc";
rst1=st1.executeQuery(sql);
%>

<center><font size="2" class="bodyText"><b>The Detail Report For the Vehicle <%=session.getAttribute("hvrno").toString()%> For the Period :<%=session.getAttribute("HisShowDate").toString() %> <%=fff%> to <%=session.getAttribute("HisShowDate1").toString() %> <%=ttt%></b></font></center><div class="bodyText" align="right">Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div>

</td></tr>
<tr><td>
<table border="1" width="100%" class="stats">

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
<td class="bodyText"><%=rst1.getString("Sen1")%></td><td class="bodyText"><%=rst1.getString("Sen2")%></td><td class="bodyText"><%=rst1.getString("Sen3")%></td><td class="bodyText"><%=rst1.getString("Sen4")%></td>

<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
	try{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
		}catch(Exception e1)
		{
		}
	}
%>
<td class="bodyText"><% if(rst1.getString("Sen1").equals("-")){out.print("-");} else { String aa=""+((Integer.parseInt(rst1.getString("Sen1"))-fuel)*0.005); if(aa.length()>5){ out.print(aa.substring(0,aa.indexOf(".")+3)); } else { out.print(aa);} }%></td>
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
<td class="bodyText"><%=rst1.getString("Sen1")%></td><td class="bodyText"><%=rst1.getString("Sen2")%></td><td class="bodyText"><%=rst1.getString("Sen3")%></td><td class="bodyText"><%=rst1.getString("Sen4")%></td>

<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
		try{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
		}catch(Exception e1)
		{
		}
	}
%>
<td class="bodyText"><% if(rst1.getString("Sen1").equals("-")){out.print("-");} else { String aa=""+((Integer.parseInt(rst1.getString("Sen1"))-fuel)*0.005); if(aa.length()>5){ out.print(aa.substring(0,aa.indexOf(".")+3)); } else { out.print(aa);} }%></td>
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
<td class="bodyText"><%=rst1.getString("Sen1")%></td><td class="bodyText"><%=rst1.getString("Sen2")%></td><td class="bodyText"><%=rst1.getString("Sen3")%></td><td class="bodyText"><%=rst1.getString("Sen4")%></td>

<%
}
if(null!=desc && desc.equals("FUELFLOW"))
{
	if(cnt2==1)
	{
		try{
		fuel=Integer.parseInt(rst1.getString("Sen1"));
		cnt2=2;
		}catch(Exception e1)
		{
		}
	}
%>
<td class="bodyText"><% if(rst1.getString("Sen1").equals("-")){out.print("-");} else { String aa=""+((Integer.parseInt(rst1.getString("Sen1"))-fuel)*0.005); if(aa.length()>5){ out.print(aa.substring(0,aa.indexOf(".")+3)); } else { out.print(aa);} }%></td>
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
</td></tr></table>
 
