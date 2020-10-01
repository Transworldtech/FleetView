<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+"_"+showdatex+"_"+session.getAttribute("tripid").toString()+"_journeydetailreport.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<table border="0" width="98%" align="center">
<tr><td align="center">
<div align="left"><font size="3">Report No:1.13</font></div>

</td></tr>
<tr>
<td align="center">
<font size="3"><B>The Trip Report For Vehicle <%=session.getAttribute("tripvehregno").toString() %> From Date 
<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(session.getAttribute("tripstartdate").toString())) %>
<%
if(session.getAttribute("pg").toString().equals("cm"))
{
 out.print(" To Date :" +new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(session.getAttribute("tripenddate").toString())));
}
%> Trip Id: <%=session.getAttribute("tripid").toString()%>, Owner Name : <%=session.getAttribute("tripownername").toString()%>, Start Place : <%=session.getAttribute("tripstartplace").toString()%>, End Place : <%=session.getAttribute("tripendplace").toString()%></B></font>
<div align="right">
Date : <%=fleetview.PrintDate()%></div>
</td>
</tr>
<tr><td>
<%!
Connection conn;
Statement st,st1;
String sql,sql1,startdate,vehid,tripid,enddate,sql2;
%>
<%
try{
tripid=session.getAttribute("tripid").toString();
enddate=session.getAttribute("tripenddate").toString();
	conn = fleetview.ReturnConnection();
	st = conn.createStatement();
	st1 = conn.createStatement();
sql="select * from t_startedjourney where TripID='"+tripid+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
	vehid=rst.getString("VehId");
	startdate=rst.getString("startdate");
	}
	else
	{
	sql="select * from t_completedjourney where TripID='"+tripid+"'";
	ResultSet rst2=st.executeQuery(sql);
	if(rst2.next())
	{
	vehid=rst2.getString("VehId");
	startdate=rst2.getString("startdate");
	}
	}
/**************** code for Over Speed ********************/
%>
<table border="0" width="100%" align="center">
<tr><td align="center"><font size="3"><b>Over Speed</b></font></td></tr>
</table>
<table class="sortable" border="1" width="100%">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed</th>
<th>Distance</th>
<th>Location</th>
</tr>
<%
ResultSet rst1=fleetview.getOSforDateRange(startdate,enddate,vehid);
int i=1;
while(rst1.next())
{
	%>
<tr>
<td><%=i %></td>
<td class="bodyText">
<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate")))%>
<%=" "+rst1.getString("TheFieldDataTime") %></td>
<td class="bodyText"><%=rst1.getString("Speed") %></td>
<td class="bodyText"><%=rst1.getString("Distance") %></td>
<td class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject") %></div></td>
</tr>
	<%
	i++;
	}
%>
</table>
<%

/*************** end of code for Over Speed **************/

/**************** Rapid Acceleration *********************/

%>
<table  border="0" width="100%">
<tr><td align="center"><font size="3"><b>Rapid Acceleration</b> </font></td></tr>
<tr>
</table>
<table border="1" width="100%" class="sortable">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>From Speed</th>
<th>To Speed</th>
<th>Location</th>
</tr>
<%
ResultSet rst2=fleetview.getACforDateRange(startdate,enddate,vehid);
int j=1;
while(rst2.next())
{
	%>
<tr>
<td><%=j %></td>
<td ><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst2.getString("TheFieldDataDate")))%>
	<%=rst2.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst2.getString("Distance") %></td>
	<td class="bodyText"><%=rst2.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><%=rst2.getString("TheFieldSubject") %></div></td>
</tr>
	<%
	
}
j++;
%>
</table>
<%

/**************** End Rapid Acceleration *********************/
/**************** Rapid Deceleraion *************************/

%>
<table  width="100%" border="0">
<tr><td align="center"><font size="3"><b>Rapid Deceleration</b></font> </td></tr>
</table>
<table class="sortable" border="1" width="100%">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>From Speed</th>
<th>To Speed</th>
<th>Location</th>
</tr>
<%
ResultSet rst3=fleetview.getDCforDateRange(startdate,enddate,vehid);
int k=1;
while(rst3.next())
{
	%>
<tr>
<td><%=k %></td>
<td class="bodyText"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst3.getString("TheFieldDataDate")))%>
	<%=rst3.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst3.getString("Distance") %></td>
	<td class="bodyText"><%=rst3.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><%=rst3.getString("TheFieldSubject") %></div></td>
</tr>
	<%
	
k++;
}
%>
</table>
<%


/***************** End of Rapid Deceleration ****************/

/******************code for stops***************/
%>
<table  border="0" width="100%">
<tr>
<td align="center">
<font size="3"><b>Stops</b></font>
</td>
</tr>
</table>
<table class="sortable" width="100%" align="center">
<tr>
<th>Sr.</th>
<th>Start Date-Time</th>
<th>End Date-Time</th>
<th>Duration</th>
<th>Location</th>
</tr>
<%
String startdatetime="-",stopdatetime="-";
sql="select * from t_veh"+vehid+" where TheFieldDataDate >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
ResultSet rstst=st.executeQuery(sql);
boolean flag=true;
int lx=1;
while(rstst.next())
{
	if(rstst.getInt("Speed")==0)
	{
		if(flag)
		{
			stopdatetime=rstst.getString("TheFieldDataDate")+" "+rstst.getString("TheFieldDataTime");
			flag=false;
		}
	}
	else
	{
		flag=true;
		startdatetime=rstst.getString("TheFieldDataDate")+" "+rstst.getString("TheFieldDataTime");
		if(!(stopdatetime.equals("-")))
		{
			java.util.Date spdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stopdatetime);
			java.util.Date stdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(startdatetime);
			
			long mils=(stdate.getTime()-spdate.getTime());
			long mins=mils/1000/60;
			if(mins >= Integer.parseInt(session.getAttribute("stop11").toString()))
			{
				String hrs=""+mins/60;
				String min="00";
				try{
				 min=""+mins%60;
				}catch(Exception ee)
				{
					min="00";
				}
			%>
			<tr>
			<td><%=lx %></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(spdate) %></td>
			<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(stdate) %></td>
			<td><%=hrs+":"+min %></td>
			<td ><div align="left"><%=rstst.getString("TheFieldSubject") %></div></td>
			</tr>
	
			<%
			stopdatetime="-";
			lx++;
			}
		}
	}
}
%>
</table>
</td></tr>
</table>
<%
/******************code for stops***************/

}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();

}
%>
<% fleetview.closeConnection(); %>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
