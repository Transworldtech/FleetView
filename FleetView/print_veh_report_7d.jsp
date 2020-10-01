 <%@ include file="headerprintnew.jsp" %>
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn,conn1;
Statement st,st1;
ResultSet rst;
String vid,sql,sql1,sql2, transporter, vehregno, thedate1, thedate2, showdate,dateformat;
%>
<%
try
{
	dateformat = session.getAttribute("dateformat").toString();
	vid=request.getParameter("vid");
	java.util.Date NewDate= new java.util.Date();
	long dateMillis= NewDate.getTime();
	long dayInMillis = 1000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate2=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	dayInMillis = 6000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn1.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+vid+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");		
		transporter=rst.getString("OwnerName");
		
	}
%>
<table width="100%" align="center" >
			<tr>
			<td align="center">
			<div align="left"><font size="3" >Report No: 1.8</font></div>
			<font  size="3" ><b>Last 7 Days Report</b></font></td>
			</tr>
			<tr>
			<td>
			<div align="center"><font  size="3"><b>Exception Report For <%=transporter%>, Vehicle <%=vehregno%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate1))%> 00:00:00 to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2))%> 23:59:59 </b></font></div>
				<div align="right">
				<%=fleetview.PrintDate()%>
				</div>
			</td>
			</tr>
			</table>
			<table border="0" align="center" width="100%">
			<tr><td align="center"><font size="3"><b>Over Speed</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>From-Date-Time</b></th>
			<th> <b>Speed</b></th>
			<th> <b>Duration in Sec.</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>	
			<%
			/*thedate1 = "2007-01-01";
			thedate2="2007-09-31";
			vid = "125";*/
			ResultSet rst1=fleetview.retunOverSpeed(vid,thedate1,thedate2);
			int i=1;
			while(rst1.next())
			{
			%>	
				<tr>
			<td> <%=i %></td>
			<td><%=new SimpleDateFormat(dateformat).format(rst1.getDate("FromDate"))+" "+rst1.getString("FromTime") %></td>
			<td><div align="right"><%=rst1.getString("Speed")%></div></td>
			<td><div align="right"><%=rst1.getString("Duration")%></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst1.getString("FromDate"),rst1.getString("FromTime")) %></div></td>
			</tr>
			<%
			i++;
			}
			%>	
			</table>
			
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Rapid Acceleration</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Date-Time</b></th>
			<th> <b>From Speed</b></th>
			<th> <b>To Speed</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>		
			<%
			ResultSet rst2=fleetview.retunRA(vid,thedate1,thedate2);
			int j=1;
			while(rst2.next())
			{
			%>
				<tr>
			<td> <%=j %></td>
			<td> <%=new SimpleDateFormat(dateformat).format(rst2.getDate("TheDate"))+" "+rst2.getString("TheTime") %></td>
			<td><div align="right"><%=rst2.getString("FromSpeed") %></div> </td>
			<td><div align="right"><%=rst2.getString("ToSpeed") %></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst2.getString("TheDate"),rst2.getString("TheTime")) %></div></td>
			</tr>	
			<%
			j++;
			}
			%>
			</table>
			
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Rapid Deceleration</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Date-Time</b></th>
			<th> <b>From Speed</b></th>
			<th> <b>To Speed</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>		
				<%
			ResultSet rst3=fleetview.retunRD(vid,thedate1,thedate2);
			int k=1;
			while(rst3.next())
			{
			%>
				<tr>
			<td> <%=k %></td>
			<td> <%=new SimpleDateFormat(dateformat).format(rst3.getDate("TheDate"))+" "+rst3.getString("TheTime") %></td>
			<td><div align="right"><%=rst3.getString("FromSpeed") %></div> </td>
			<td><div align="right"><%=rst3.getString("ToSpeed") %></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst3.getString("TheDate"),rst3.getString("TheTime")) %></div></td>
			</tr>	
			<%
			k++;
			}
			%>
			</table>
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Stops</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Start Date-Time</b></th>
			<th> <b>End Date-Time</b></th>
			<th> <b>Duration</b></th>
			<th> <b>Location - Click To View On Map.</b></th>
			</tr>	
			<%
			ResultSet rst4=fleetview.retunStop(vid,thedate1,thedate2);
			int lx=1;
			while(rst4.next())
			{
			%>	
				<tr>
			<td> <%=lx %></td>
			<td> <div align="center"><%=new SimpleDateFormat(dateformat).format(rst4.getDate("FromDate"))%> <%=rst4.getString("FromTime")%></div></td>
			<td> <div align="center"><%=new SimpleDateFormat(dateformat).format(rst4.getDate("ToDate"))%> <%=rst4.getString("ToTime")%></div></td>
			<td> <div align="right"><%=rst4.getString("Duration") %></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst4.getString("FromDate"),rst4.getString("FromTime")) %></div></td>
			</tr>	
			<%
			 lx++;
			}
			%>
			</table>
			
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Night Driving</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Start Date-Time</b></th>
			<th> <b>Start Location - Click To View On Map.</b></th>
			<th> <b>End Date-Time</b></th>
			<th> <b>End Location - Click To View On Map.</b></th>
			<th> <b>Distance</b></th>
			<th> <b>Duration</b></th>
			</tr>		
			<%
			ResultSet rst5=fleetview.retunND(vid,thedate1,thedate2);
			int m=1;
			while(rst5.next())
			{
				System.out.println(rst5.getDate("FromDate"));
				System.out.println(rst5.getString("FromTime"));
				System.out.println(rst5.getDate("ToDate"));
				System.out.println(rst5.getString("ToTime"));
			%>	
				<tr>
			<td> <%=m %></td>
			<td> <div align="center"><%=new SimpleDateFormat(dateformat).format(rst5.getDate("FromDate"))%> <%=rst5.getString("FromTime")%></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst5.getString("FromDate"),rst5.getString("FromTime")) %></div></td>
			<td> <div align="center"><%=new SimpleDateFormat(dateformat).format(rst5.getDate("ToDate"))%> <%=rst5.getString("ToTime")%></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst5.getString("ToDate"),rst5.getString("ToTime")) %></div></td>
			<td> <div align="right"><%=rst5.getString("Distance") %></div></td>
			<td> <div align="right"><%=rst5.getString("Duration") %></div></td>
			</tr>	
			<%
			m++;
			}
			System.out.println("In ND");
			%>
			</table>
			
			</td>
			</tr>
			<tr><td align="center"><font size="3"><b>Continuous Driving</b></font></td></tr>
			<tr><td>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Start Date-Time</b></th>
			<th> <b>Start Location - Click To View On Map.</b></t
			<th> <b>End Date-Time</b></th>
			<th> <b>End Location - Click To View On Map.</b></th>
			<th> <b>Distance</b></th>
			<th> <b>Duration</b></th>
			</tr>		
			<%
			ResultSet rst6=fleetview.retunCD(vid,thedate1,thedate2);
			int n=1;
			while(rst6.next())
			{
			%>
				<tr>
			<td> <%=n %></td>
			<td> <div align="center"><%=new SimpleDateFormat(dateformat).format(rst6.getDate("FromDate"))%> <%=rst6.getString("FromTime")%></div></td>
			<td> <div align="center"><%=new SimpleDateFormat(dateformat).format(rst6.getDate("ToDate"))%> <%=rst6.getString("ToTime")%></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst5.getString("FromDate"),rst5.getString("FromTime")) %></div></td>
			<td><div align="left"><%=fleetview.getLocationByDateTime(vid,rst6.getString("ToDate"),rst6.getString("ToTime")) %></div></td>
			<td> <div align="right"><%=rst6.getString("Distance") %></div></td>
			<td> <div align="right"><%=rst6.getString("Duration") %></div></td>
			</tr>	
			<%
			n++;
			}
			System.out.println("In CD");
			%>
			</table>
			
			</td>
			</tr>
			
			</table>
			<%
			//conn.close();
			//conn1.close();
}catch(Exception e)
{
	out.print("Exception--->"+e);
}finally
{
	try
	{
		conn.close();
	}catch(Exception e)
	{}
	try
	{
		conn1.close();	
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection1();	
	}catch(Exception e)
	{}
	
}
			%>
<% //fleetview.closeConnection(); %>
<% //fleetview.closeConnection1(); %>
			</jsp:useBean>
<%@ include file="footerprintnew.jsp" %>
