<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"_CD_Details.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.OverSpeedDetailsData"
	import="com.transworld.fleetview.framework.RapidAccelerationDetailsData"
	import="com.transworld.fleetview.framework.ContinuousDrivingDetailsData"
	import="com.transworld.fleetview.framework.GetVehicleDetails"
	import="com.transworld.fleetview.framework.Utilities"%>
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn,conn1;
Statement st,st1,st2,st12,st4,st5;
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
	dayInMillis = 14000 * 60 * 60 *24;
	dateMillis = dateMillis - dayInMillis;
	NewDate.setTime(dateMillis);
	thedate1=new SimpleDateFormat("yyyy-MM-dd").format(NewDate);
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();
	st=conn.createStatement();
	st1=conn1.createStatement();
	st2=conn1.createStatement();
	st4=conn1.createStatement();
	st5=conn1.createStatement();
	st12=conn1.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+vid+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");		
		transporter=rst.getString("OwnerName");
		
	}
	String datat=request.getParameter("datat");
	String datat1=request.getParameter("datat1");
	int discounter=0;
    if(request.getParameter("counterv")!=null)
    {
	  String str=request.getParameter("counterv");
	  //System.out.println("\n\n\nstr---->>>>>-->>"+str);
      discounter=Integer.parseInt(str);
      //System.out.println("\n\n\n---->>>>>-->>"+discounter);
    }
%>
<table width="100%" align="center" >
			<tr>
			<td align="center">
			<div align="left"><font size="3" >Report No: 1.9</font></div>
			</tr>
			<tr>
			<td>
			<div align="center"><font  size="3"><b>Continuous driving details For <%=transporter%>, Vehicle <%=vehregno%> For The Period : <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(datat1))%> </b></font></div>
				<div align="right">
				<%=fleetview.PrintDate()%>
				</div>
			</td>
			</tr>
			</table>
			<table border="0" align="center" width="100%">
	<tr>
		<td align="center"><font size="3"><b>Continuous Driving</b></font></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th><b> Sr. </b></th>
				<th><b>Start Date-Time</b></th>
				<th><b>Start Location - Click To View On Map.</b></th>
				<th><b>End Date-Time</b></th>
				<th><b>End Location - Click To View On Map.</b></th>
				<th><b>Distance</b></th>
				<th><b>Duration</b></th>
			</tr>
			<%
		    List<ContinuousDrivingDetailsData> data5 = null;
			int numRecords5 = 0;
			try {
				data5 = vehicleDao.getContinuousDrivingDetailsData(
						vid, datat+" 00:00:00", datat1+" 23:59:59", "ContinuousDriving");
				numRecords5 = data5.size();
			} catch (Exception e) {
				e.printStackTrace();
			}
			for (int counter = 0; counter < numRecords5; counter++)
			{
				final ContinuousDrivingDetailsData currentRecord5 = data5
				.get(counter);
%>
			<tr>
				<td><%=counter+1 %></td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getStartDate())) %> <%=currentRecord5.getStartTime()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())
									&& null != currentRecord5.getStartLocationLatitude()) {
						String lat1=currentRecord5.getStartLocationLatitude();
						String lon1=currentRecord5.getStartLocationLongitude();
						String disc=currentRecord5.getStartLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getStartLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getStartLocation())) {
								out.println(currentRecord5.getStartLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="center"><%=new SimpleDateFormat("dd-MMM-yyyy")
											.format(new SimpleDateFormat(
													"yyyy-MM-dd")
													.parse(currentRecord5
															.getEndDate())) %> <%=currentRecord5.getEndTime()%></div>
				</td>
				<td>
				<div align="left">
				<%
					if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())
									&& null != currentRecord5.getEndLocationLatitude()) {
						String lat1=currentRecord5.getEndLocationLatitude();
						String lon1=currentRecord5.getEndLocationLongitude();
						String disc=currentRecord5.getEndLocation();
%>							 

						<%="<a href=\"shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"\"onclick=\"popWin=open('shownewmap.jsp?lat="+lat1+"&long="+lon1+"&discription="+disc+"','myWin','width=500, height=500'); popWin.focus(); return false\">"+disc+"</a>"%>  								 
<%
					} else if (null != currentRecord5.getEndLocation()
									&& !"null".equalsIgnoreCase(currentRecord5
											.getEndLocation())) {
								out.println(currentRecord5.getEndLocation());
							}
				%>
				</div>
				</td>
				<td>
				<div align="right"><%=currentRecord5.getDistancetravelled()%></div>
				</td>
				<td>
				<div align="right"><%=currentRecord5.getDuration()%></div>
				</td>
			</tr>
			<%
			}
		    %>
		    
		</table>
		</td>
	</tr>
	
	
</table>
			<%
			
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
<%@ include file="footernew.jsp" %>
