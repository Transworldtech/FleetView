<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">


<%!
Connection conn, con1;
Statement st,st1, stmt1;
String date1, date2, vehcode, vehregno,tbname,sql;
%>
<%
date1=session.getAttribute("data1").toString();
	date2=session.getAttribute("data2").toString();
	vehcode=request.getParameter("vid");
	vehregno=request.getParameter("vehno");
	 tbname="t_veh"+vehcode+"_cr";
	//out.print(tbname);
%>
<table border="1" gbcolor="white" width="100%">
<tr><td>
<table class="stats">
<tr><td colspan="6">
<div align="left">
<a href="javascript: history.go(-1)">Back</a>
</div>
 <b>CONTINUOUS DRIVING for Vehicle  <%=vehregno %> From Date :<%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To Date :<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>


Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdate = fmt.format(new java.util.Date());
 out.print(curdate); %></div>
</td></tr>
<tr><td>
<table class="sortable">
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
	
try{	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmt1=con1.createStatement();
	//out.print(tbname);
	int i=1;

      // sql="select * from "+tbname+" where ToDate  >= '"+date1+"' AND ToDate<= '"+date2+"'";
	//out.print(sql+"<br>");
	//ResultSet rst=st.executeQuery(sql);
	ResultSet rst=fleetview.retunCD(vehcode,date1,date2);
	while(rst.next())
	{  %>
		<tr>
		<td style="text-align: right"><%=i %></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate")) %> <%=rst.getString("FromTime") %></td>
		<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vehcode,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>
		<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate")) %> <%=rst.getString("ToTime") %></td>
		<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vehcode,rst.getString("ToDate"),rst.getString("ToTime")) %></div></td>
		<td><div align="right"><%=rst.getString("Distance") %></div></td>
		<td><div align="right"><%=rst.getString("Duration") %></div></td>
		
<%
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	try
	{
	conn.close();
	}
	catch(Exception e){}
	try
	{
	con1.close();
	}
	catch(Exception e){}
}

%>
</table>
<tr><td colspan="6" align="center">
<input type="button" name="Print" value="Print" onclick="javascript:window.print();" class="formElement">
</td></tr>
</table>
</td></tr></table>

</td></tr></table>
</jsp:useBean>