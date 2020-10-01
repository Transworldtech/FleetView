<%@ include file="header.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<table border="1" width="100%">
<tr><td>
<%

String userID1 = "";
if (! session.isNew()) 
userID1 = (String) session.getAttribute("user");
if (null == userID1) 
	{
		response.sendRedirect("index.html");
	}
else
	{
		
%>
<table border="1" width="100%" class="stats">
<tr bgcolor=""><td class="hed"><a href="javascript: history.go(-1)">Back</a></td><td align="center" class="hed"><b>CONTINUOUS DRIVING for Vehicle <%=session.getAttribute("vehno") %> On Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dd"));
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String s = formatter.format(date);
out.print(s);
 %> </b></td></tr>
</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="stats">
<tr>
      <th><b>Sr. No.</b></th>
	  <th><b>Start Date-Time </b></th>
	  <th><b>Start Location - Click To View On Map.</b></th>
	  <th><b>End Date-Time</b></th>
   	  <th><b>End Location - Click To View On Map.</b></th>
	  <th><b>Distance</b></th>
      <th><b>Duration</b></th>
</tr>
<%
	String data1,data2,vid,vehno,dd;
	data1=session.getAttribute("data1").toString();
	data2=session.getAttribute("data2").toString();
	vid=session.getAttribute("vid").toString();
	vehno=session.getAttribute("vehno").toString();
	dd=request.getParameter("dd").toString();
	String tbname="t_veh"+vid+"_cr";
	try{
		Class.forName(MM_dbConn_DRIVER); 
		Connection conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=conn.createStatement();
	//String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
	//out.print(sql+"<br>");
	ResultSet rst=fleetview.retunCD(vid,data1,data2);
	while(rst.next())
	{
		%>
	<tr><td align="center" class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%> <%=rst.getString(3) %>

<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>

</td><td align="center" class="bodyText"><%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(4));
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter1.format(ShowDate2);
 out.print(showdate2);

%> <%=rst.getString(5) %>
<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("ToDate"),rst.getString("ToTime")) %></div></td>

</td><td align="center" class="bodyText"><%=rst.getString("Distance") %><td align="center" class="bodyText"><%=rst.getString("Duration") %></td></tr>
		<%
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
 %>
<tr><td colspan="2" align="center"><a href="#" onclick='javascript:window.print();'>Print Report</a></td><td colspan="2" align="center"><a href="excelcountinous.jsp?dd=<%=request.getParameter("dd")%>">Export To Excel</a></td></tr>
</table>
<% }
%>
</td></tr>
</table>
</jsp:useBean>
<%@ include file="footernew.jsp"%>

