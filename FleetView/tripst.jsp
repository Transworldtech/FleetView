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
String sql,sql1,sql2,stopdatetime, startdatetime;
%>
<%

tripid=session.getAttribute("tripid").toString();
enddate=session.getAttribute("tripenddate").toString();
stopdatetime="-";
startdatetime="-";
try{
	conn =fleetview.ReturnConnection();
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
%>
<table border="0" width="100%">
<tr><td align="center"><font size="3"><b>Stops</b></font></td></tr>
</table>
<table class="sortable" border="1">

<tr>
<th>Sr.</th>
<th>Start Date-Time</th>
<th>End Date-Time</th>
<th>Duration</th>
<th>Location</th>
</tr>
<%
	sql="select * from t_veh"+vehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
	ResultSet rst2=st.executeQuery(sql);
	boolean flag=true;
	int i=1;
	while(rst2.next())
	{
		if(rst2.getInt("Speed")==0)
		{
			if(flag)
			{
				stopdatetime=rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime");
				flag=false;
			}
		}
		else
		{
			flag=true;
			startdatetime=rst2.getString("TheFieldDataDate")+" "+rst2.getString("TheFieldDataTime");
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
				<td><%=i %></td>
				<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(spdate) %></td>
				<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(stdate) %></td>
				<td><%=hrs+":"+min %></td>
				<td ><div align="left"><%=rst2.getString("TheFieldSubject") %></div></td>
				</tr>
		
				<%
				stopdatetime="-";
				i++;
				}
			}
		}
	}
%>
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
