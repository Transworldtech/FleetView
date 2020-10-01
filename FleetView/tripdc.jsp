<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn;
Statement st,st1;
String tripid, vehid, vehregno,startdate,enddate;
String sql,sql1,sql2;
%>
<%
tripid=session.getAttribute("tripid").toString();
enddate=session.getAttribute("tripenddate").toString();
try{
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
	enddate=rst2.getString("endtdate");
	}
	}
%>
<table border="0" width="100%" >
<tr><td align="center"><font size="3"><B>Rapid Deceleration</B></font></td></tr>
</table>
<table class="sortable" border="1">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>From Speed</th>
<th>To Speed</th>
<th>Location</th>
</tr>
<%

ResultSet rst1=fleetview.getDCforDateRange(startdate,enddate,vehid);
int i=1;
while(rst1.next())
{
%>
<tr>
<td><%=i %></td>
<td><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate")))%>
	<%=rst1.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst1.getString("Distance") %></td>
	<td class="bodyText"><%=rst1.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><%=rst1.getString("TheFieldSubject")%></div></td>
</tr>
	
<%
i++;
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
<% fleetview.closeConnection(); %>
</jsp:useBean>
