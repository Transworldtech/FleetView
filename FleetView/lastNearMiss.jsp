<%@ include file="headerpopup.jsp"%>
<%@page import="java.util.Date"%>
<%!
Connection conn,con;
Statement st,st1,st2;
String routeid;
%>

<html>
<head>

	<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}

</style>
<style>
#ctrip {visibility:hidden;}

</style>

<%
try
{

Class.forName(MM_dbConn_DRIVER); 
con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 st = con.createStatement();
 st1 = con.createStatement();
 //st2 = con.createStatement();
 
 %>
 <div align="right"></div>
	<br>
	<center>
	<table border="0" width="50%" align="center" >
			<tr>
				<th colspan="3" align="center"><font size="3">Last 5 Near Miss  </font></th></tr></table>
	<div  style="width: 80%;" align="center">
		<table border="1"  class="sortable" align="center" >
		<tr>
		<th>Sr.No</th>
		<th>Trip Id</th>
		<th>Debrief Date</th>
		<th>Near Miss</th>
		<th>Near Miss Description</th>
		<th>RouteCause</th>
		<th>PreventionAction</th>
		<th>Trainer Name</th>
		</tr>
 
 <%
 //take the last 5 trip from t_brifing by checking origin and destination and the check that trip in t_debrifing
 
 String startplace="",endplace="";
 startplace=request.getParameter("startplace");
 endplace=request.getParameter("endplace");
 System.out.println("StartPlace "+startplace);
 System.out.println("EndPlace "+endplace);
 String startcode="",endcode="",tripid="",nearmiss="";
 String ddate="",Tname="",nmd="",routecause="",PreventionAction="";
 int i=0;
String sql1="select tripid from db_gps.t_briefing where Startplace like '%"+startplace+"%' and endplace like '%"+endplace+"%' and tripid in(select tripid from db_gps.t_debriefing order by Debriefdate desc ) order by brifdate desc limit 5 ";
ResultSet rs1=st1.executeQuery(sql1);
System.out.println("SQL1 "+sql1);
while(rs1.next())
{
	nearmiss="";nmd="";routecause="";PreventionAction="";
	tripid=rs1.getString("tripid");
	System.out.println("Trip ID->"+tripid);
	

 
	String sql = "SELECT nearmiss,Debriefdate,Trainername,NMDescription,RouteCause,PreventionAction FROM db_gps.t_debriefing  where tripid like '%"+tripid+"%' and  nearmiss not in('null','-','','false') order by Debriefdate desc";
	System.out.println("SQL "+sql);
	ResultSet rs = st.executeQuery(sql);
	if(rs.next())
	{
		nearmiss=rs.getString("nearmiss");
		ddate=rs.getString("Debriefdate");
		Tname=rs.getString("Trainername");
		nmd=rs.getString("NMDescription");
		routecause=rs.getString("RouteCause");
		PreventionAction=rs.getString("PreventionAction");
		System.out.println("Nearmiss--"+nearmiss);
	
		%>	<tr>
	 	  <td align="right"><div align="right"><%= ++i%></div></td>
	 	   <td align="left" ><div align="right"><%= tripid%></div></td>
	 	  <td align="left" ><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(ddate)) %></div></td>
	 	  <td align="left" ><div align="left"><%=nearmiss%></div></td>
	 	  <td align="left" ><div align="left"><%=nmd%></div></td>
	 	  <td align="left" ><div align="left"><%=routecause%></div></td>
	 	  <td align="left" ><div align="left"><%=PreventionAction%></div></td>
	 	  <td align="left" ><div align="left"><%=Tname%></div></td>
	</tr>


	<% 	
	}

}	
}
catch(Exception e)
{
	System.out.println("Exception--->   "+e);
}
%>
</table>
</div>
</center>
</head>
</html>
<%@ include file="footernew.jsp"%>