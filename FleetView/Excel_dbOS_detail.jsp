<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");


String filename="detail_os_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
 <%@ include file="Connections/conn.jsp" %>

<%!
Connection conn, con1;
Statement st,st1, stmt1;
String date1, date2, vehcode, vehregno,tbname,sql;
%>
<%
date1=request.getParameter("date1");
date2=request.getParameter("date2");
vehcode=request.getParameter("vid");
vehregno=request.getParameter("vehno");
String drivername=request.getParameter("drivername");
String tripid=request.getParameter("tripid");

 tbname="t_driver_overspeed";

	//out.print(tbname);
%>
<table border="1" gbcolor="white" width="100%">
<tr><td>

 <b><center>OVERSPEED ANALYSIS REPORT for <%=drivername %> From <%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To <%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>

for Trip Id <%=tripid%>

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdate = fmt.format(new java.util.Date());
 out.print(curdate); %></div>
</td></tr>

</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="stats">
<tr bgcolor="#FAFAD2"><td colspan="4" align="center" class="hed"><b>Period</b></td><td align="center" rowspan="2" class="hed"><b>Speed in KMPH
</b></td><td align="center" rowspan="2" class="hed"><b>Duration in Seconds</b></td>
	<td align="center" rowspan="2" class="hed"><b>Location</b></td>
</tr>
<tr bgcolor="#FAFAD2">
	
	<td align="center" class="hed"><b>Sr. No.</td>
	<td align="center" class="hed"><b>Date</td><td align="center" class="hed"><b>From Time</b></td>
	<td align="center" class="hed"><b>To Time</b></td></tr>
<%	
try{		
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmt1=con1.createStatement();

	int i=1;
      String sql="select * from "+tbname+" where JCode='"+tripid+"' ";
	ResultSet rst=st.executeQuery(sql);
	//out.print(sql);
	while(rst.next())
	{
		String frmdate=rst.getString("FromDate");
		String frmtime=rst.getString("FromTime");
		String location="", latit="", longit="";
	
		String sql2="select * from t_veh"+vehcode+" where TheFieldDataDate='"+frmdate+"' and TheFieldDataTime<='"+frmtime+"' and TheFiledTextFileName='OS' order by TheFieldDataTime desc limit 1";

		ResultSet rs2=stmt1.executeQuery(sql2);
		if(rs2.next())
		{
			latit=rs2.getString("LatinDec");
			longit=rs2.getString("LonginDec");
			location=rs2.getString("TheFieldSubject");
		}
		
	%>
	<tr>

		<td align="center" class="bodyText"> <%=i%> </td>
		<td align="center" class="bodyText">
<%
		String todate=rst.getString("ToDate");
		java.util.Date date8 = new SimpleDateFormat("yyyy-MM-dd").parse(todate);
		Format formatter9 = new SimpleDateFormat("dd-MMM-yyyy");
		String todt1 = formatter9.format(date8);
		out.print(todt1);
%>
</td>
		<td align="center" class="bodyText"><%=rst.getString(3) %> </td>
		<td align="center" class="bodyText"> <%=rst.getString(5) %></td>
		<td align="center" class="bodyText"><%=rst.getString(6) %></td>
		<td align="center" class="bodyText"><%=rst.getString(7) %></td>
		<td align="center" class="bodyText">
			<a href="shownewmap.jsp?lat=<%=latit%>&long=<%=longit%>&discription=<%="<b>" + vehregno + "</b><br>"%><%=location%>" onclick="popWin = open('shownewmap.jsp?lat=<%=latit%>&long=<%=longit%>&discription=<%="<b>" + vehregno + "</b><br>"%><%=location%>','myWin','width=500,height=500');popWin.focus();return false"> <%=location%> </a> 
		</td>
	</tr>
		
<%
i++;
}
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
	con1.close();
}

%>
</table>
</td></tr></table>

<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
