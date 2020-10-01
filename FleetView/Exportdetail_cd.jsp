<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"deatail_cd_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
 <%@ include file="Connections/conn.jsp" %>
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
	{
	String thedt=rst.getString("ToDate");
		java.util.Date date4 = new SimpleDateFormat("yyyy-MM-dd").parse(thedt) ;
Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
String thedate = formatter3.format(date4);

	String frmdate=rst.getString("FromDate");
		String frmtime=rst.getString("FromTime");
		String location="";
	
		String sql2="select * from t_veh"+vehcode+" where TheFieldDataDate='"+frmdate+"' and TheFieldDataTime<='"+frmtime+"' order by TheFieldDataTime desc limit 1";

		ResultSet rs2=stmt1.executeQuery(sql2);
		if(rs2.next())
		{
			location=rs2.getString("TheFieldSubject");
		}
%>
<tr>
	<td align="center" class="bodyText"> <%=i%> </td>
	<td align="center" class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2));
Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter4.format(ShowDate1);
 out.print(showdate1);

%> <%=rst.getString(3) %>

<td style="text-align: left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate")) %> <%=rst.getString("FromTime") %></td>
</td><td align="center" class="bodyText"><%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(4));
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter1.format(ShowDate2);
 out.print(showdate2);

%> <%=rst.getString(5) %>
<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vehcode,rst.getString("ToDate"),rst.getString("ToTime")) %></div></td>
</td><td align="center" class="bodyText"><%=rst.getString("Distance") %><td align="center" class="bodyText"><%=rst.getString("Duration") %></td>
</tr>
	

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
</td></tr></table>
</jsp:useBean>