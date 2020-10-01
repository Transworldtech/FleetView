<%@ include file="headernew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
 <script language="javascript">
function validate()
{
	var v1=document.consignform.consgnno.value;

	if(v1=="")
	{
		alert("Please enter text to search");
		return false;
	}
	return true;
}
	
</script>
<%!
Connection con1;
%>

<form name="consignform" method="get" action="" onSubmit="return validate();" >

<% 
try {


con1 = fleetview.ReturnConnection();
Statement stmt1=con1.createStatement(), stmt2=con1.createStatement(), stmt3=con1.createStatement(), stmt4=con1.createStatement(), stmt5=con1.createStatement(), stmt6=con1.createStatement();
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null,rs6=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="";

String user=session.getValue("usertypevalue").toString();
String flag="no";

%>

	<table border="0" width="100%" bgcolor="white">
	<tr><td align="center"><div align="left">
	<!-- <font size="3">Report No:10.0</font>-->
	</div>
	<font size="3"><b>Consignment Tracking</b></font>
	</td></tr>
		<tr>
			<td align="right"> <font size="2"> Type in Consignment no. to find details. </font><input type="text" name="consgnno"  / > &nbsp;&nbsp;&nbsp; <input type="submit" name="submit" value="Search"  /> </td>
		</tr>
	</table>

<%
	String consignno=request.getParameter("consgnno");
	if(consignno==null)	
	{
	}
	else
	{	
%>	
		<table border="0" width="100%" bgcolor="white">
			<tr>
				<td align="center" > <font size="3"> <B> Search Result of <%=consignno%> </B> </font> </td>
			</tr>
			
		</table>

 		<table border="1" width="100%" class="sortable">
			<tr>
				<th> Sr. No </th>
				<th> Vehicle No. </th>
				<th> Date </th>
				<th> Trip Id </th>
				<th> Trip Status </th>
				<th> Completed Date </th>
				<th> Data Status </th>
				<th> Location </th>
			</tr>
<%
/* *************************Getting data from t_consinement*************************      */
	int i=1;
	sql1="select * from t_consinement where Consinementno like '"+consignno+"' and Ownername='"+user+"' ";
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())
	{ 
		String vehno=rs1.getString("TWVehicleNo");
		String vehcode=rs1.getString("VehicleCode");
		String consindate=rs1.getString("ondate");
		
		String tripid="-", location="", tripstat="Not Started", upddate="", updtime="", tripenddate="", tripendtime="", vehcodeloc="", vehcodedate="", vaehcodetime="", datastatus="Complete" ;
		double lat=0, longit=0, vehcodelat=0, vehcodelong=0;
		flag="yes";
%>
		<tr>
			<td align="center"> <%=i %> </td>
			<td align="center"> <%=rs1.getString("TWVehicleNo") %> </td>
			<td align="center"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("ondate"))) %> </td>
<%

/* ************************************Getting Trip Id and Status****************************      */

	sql2="select * from t_startedjourney where VehRegNo='"+vehno+"' and StartDate <= '"+consindate+"' and JStatus='Running' ";
	
	rs2=stmt2.executeQuery(sql2);
	if(rs2.next())
	{	
		tripid=rs2.getString("TripId");
		tripstat=rs2.getString("JStatus");

	}
	else
	{	
		sql4="select * from t_completedjourney where VehRegNo='"+vehno+"' and StartDate <= '"+consindate+"' and EndDate >= '"+consindate+"' order by EndDate desc limit 1 ";
		
		rs4=stmt4.executeQuery(sql4);	
		if(rs4.next())
		{
			tripid=rs4.getString("TripId");
			tripenddate=rs4.getString("EndDate");
			tripendtime=rs4.getString("EndTime");
			tripstat="Completed";
		}

		sql5="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,TheFieldDataTime) <= '"+tripenddate+""+tripendtime+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		//out.print(sql5);
		rs5=stmt5.executeQuery(sql5);
		if(rs5.next())
		{
			vehcodeloc=rs5.getString("TheFieldSubject");	
			vehcodelat=rs5.getDouble("Latitude");	
			vehcodelong=rs5.getDouble("Longitude");	
			vehcodedate=rs5.getString("TheFieldDataDate");
			vaehcodetime=rs5.getString("TheFieldDataTime");	
		}
	}

		/* *************************Getting last updated data date & time*************************      */
		sql3="select * from t_onlinedata where VehicleCode='"+vehcode+"' ";
		rs3=stmt3.executeQuery(sql3);
		if(rs3.next())
		{
			location=rs3.getString("Location");
			lat=rs3.getDouble("LatitudePosition");	
			longit=rs3.getDouble("LongitudePosition");
			upddate=rs3.getString("TheDate");	
			updtime=rs3.getString("TheTime");
		}
%>

			<td align="center"> <%=tripid %> </td>
			<td align="center"> <%=tripstat %> </td>
	
<%
/* *************************If Trip is completed, then displaying Trip end date.  *************************      */

	if(tripstat.equals("Completed"))
	{
%>			
			<td align="center"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(tripenddate)) %> <%=tripendtime %></td>
<%	}
	else
	{ %>
		<td align="center"> - </td>
<%	} %>		

<%

/* *************************If Last Updated date is less than trip end date, then Data is Incomplete *************************      */
	int noofdays=0;
	sql6="select (TO_DAYS('"+tripenddate+"')-TO_DAYS('"+vehcodedate+"'))";
	rs6=stmt6.executeQuery(sql6);
	if(rs6.next())
	{
		noofdays=rs6.getInt(1);
	} 
	if(noofdays>0)	
	{
		datastatus="Incomplete";
	}
		
%>
<%
	if(tripstat.equals("Completed"))
	{ %> 
		<td align="center"> <%=datastatus%> </td>
<%	}
	else
	{ %>
		<td align="center"> - </td>
<%	} %>
<%

/* *****************If Trip was completed, then I am displaying and sending location from t_vehcode table when trip was completed. Otherwise, if Trip is running, then I am sending current location of that particular Vehiucle from t_onlinedata *************************      */

	if(tripstat.equals("Completed"))
	{   %>
			<td align="center"> (<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(vehcodedate)) %> <%=vaehcodetime %>) <a href="shownewmap.jsp?lat=<%=vehcodelat%>&long=<%=vehcodelong%>&discription=<%=vehno+"<br>"%>+<%=vehcodeloc%>" onclick="popWin = open('shownewmap.jsp?lat=<%=vehcodelat%>&long=<%=vehcodelong%>&discription=<%=vehno+"<br>"%>+<%=vehcodeloc%>','myWin','width=500,height=500');popWin.focus();return false"><%=vehcodeloc%>  </a> (Trip end Location) </td>
<%	}
	
	else
	{ 
%>
			<td align="center">(<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(upddate)) %> <%=updtime %>) <a href="shownewmap.jsp?lat=<%=lat%>&long=<%=longit%>&discription=<%=vehno+"<br>"%>+<%=location%>" onclick="popWin = open('shownewmap.jsp?lat=<%=lat%>&long=<%=longit%>&discription=<%=vehno+"<br>"%>+<%=location%>','myWin','width=500,height=500');popWin.focus();return false"><%=location%> </a> </td>
<%	}
%>	
		</tr>
<%		i++;
	}
%>
		</table>

<%	if(flag.equals("no"))
	{ %>
		<table border="0" width="100%" bgcolor="white">
			<tr>
				<td colspan="6" align="center"> <font color="blue" size="3"> <B>No Details found.</B> </font>  </td>
			</tr>
		</table>
<%	}
   } //else

	
	
 } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
<%@ include file="footernew.jsp" %>

