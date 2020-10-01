<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=showdatex+"arrived.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
			<!-- body part come here -->
<%!
Connection conn, conn1;
Statement st,st1;
String sql,thedate,sdate,edate,vehlist,location,locationcode,mainuser,locationlist;
%>
			<%
if(session.getAttribute("vehlistnew").toString().equals("-"))
{
	out.print("<table class='stats'><tr><td class='hed'>Please select the location first.</td></tr></table>");
}
else
{

try{
	
	location=session.getAttribute("Location").toString();
	locationcode=session.getAttribute("LocationCode").toString();
	vehlist=session.getAttribute("vehlistnew").toString();
	mainuser=session.getAttribute("usertypevaluemain").toString();
	locationlist=session.getAttribute("locationlist").toString();
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	String aa=request.getParameter("data");
	if(null==aa)
	{
	sql="SELECT SUBDATE(now(), INTERVAL 1 MONTH) as TheDate";	
	ResultSet rstdate=st.executeQuery(sql);
	if(rstdate.next())
	{
		thedate=rstdate.getDate("TheDate").toString();
		edate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	}
	}
	else
	{
		thedate=request.getParameter("data");
		edate=request.getParameter("data1");
	}
	if(location.equals("All"))
	{
	sql="select * from t_completedjourney where GPName='Castrol' and StartDate >='"+thedate+"' and StartDate <='"+edate+"' order by StartDate asc";
	
	}
	else
	{
		sql="select * from t_completedjourney where Endcode in "+locationlist+" and GPName='"+mainuser+"'  and StartDate >='"+thedate+"'  and StartDate <='"+edate+"' order by StartDate asc";
	}
	//out.print(sql);
	ResultSet rst=st.executeQuery(sql);
	%>
	<table border="0" width="100%" bgcolor="white">
	<tr><td>
	<table class="stats">
	<th colspan="12">Vehicle Arrived
	<%
	if(session.getAttribute("Location").toString().equals("All"))
	{
	}
	else
	{
		out.print(" at "+session.getAttribute("Location").toString() +" From "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate))+" to "+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate)) );
	}
	%>
	</th>
	<tr>
	<td class="hed"><div class="bodyText"><b>Trip ID</b></div></td>
	<td class="hed"><div class="bodyText"><b>Vehicle Reg. No</b></div></td>
	<td class="hed"><div class="bodyText"><b>Owner Name</div></b></td>
	<td class="hed"><div class="bodyText"><b>Start Date</div></b></td>
	<td class="hed"><div class="bodyText"><b>End Date</div></b></td>
	<td class="hed"><div class="bodyText"><b>Origin</div></b></td>
	<td class="hed"><div class="bodyText"><b>Destination</div></b></td>
	<td class="hed"><div class="bodyText"><b>Distance</div></b></td>
	<td class="hed"><div class="bodyText"><b>Avg. Speed</div></b></td>
	<td class="hed"><div class="bodyText"><b>Duration</div></b></td>
	<td class="hed"><div class="bodyText"><b>Driver Name</div></b></td>
	<td class="hed"><div class="bodyText"><b>Driver Code</div></b></td>

</tr>
<%
while(rst.next())
{
%>
<tr>
<td class="bodyText"><div align="left">
<%=rst.getString("TripID")%>
</div></td>
<td class="bodyText"><div align="left"><%=rst.getString("VehRegNo")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("OwnerName")%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StartDate"));
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(sd1);
 out.print(sh1);%></div></td>
<td class="bodyText"><div align="left"><%
java.util.Date sd2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("EndDate"));
Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sh2 = fmt2.format(sd2);
 out.print(sh2);%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("StartPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("EndPlace")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("KmTravelled")%></div></td>
<td class="bodyText"><div align="left"><%


String ss=rst.getString("AvgRunningSpeed");
if(ss.length() >4)
{
out.print(ss.substring(0,4));
}
else
{
out.print(ss);
}
%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("RunningDuration")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("DriverName")%></div></td>
<td class="bodyText"><div align="left"><%=rst.getString("DriverId")%></div></td>
</tr>


<%
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
<%
}
%>
			