<%@ include file="header.jsp" %>
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

tbname="t_driver_rd";

%>
<table border="1" gbcolor="white" width="100%">
<tr><td>
<table class="stats">
<tr><td colspan="6">
<div align="left">
<a href="javascript: history.go(-1)">Back</a>
</div>
 <b>RAPID DE-ACCELERATION REPORT for <%=drivername %> From <%
java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %> To <%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);%>

for Trip Id <%=tripid%>

<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('print_detail_dbrd.jsp?vid=<%=vehcode%>&vehno=<%=vehregno%>&date1=<%=date1%>&date2=<%=date2%>&drivername=<%=drivername%>&tripid=<%=tripid%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Excel_dbRD_detail.jsp?vid=<%=vehcode%>&vehno=<%=vehregno%>&date1=<%=date1%>&date2=<%=date2%>&drivername=<%=drivername%>&tripid=<%=tripid%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdate = fmt.format(new java.util.Date());
 out.print(curdate); %></div>
</td></tr>

<tr>
<td class="hed" rowspan="2">Sr. No. </td>
<td class="hed" rowspan="2">Date </td>
<td class="hed" rowspan="2">Time </td>
<td class="hed" colspan="2">Speed Variation</td>
<td align="center" rowspan="2" class="hed"><b>Location</b></td>
</tr>
<tr>
<td class="hed">From </td>
<td class="hed">To </td>
</tr>

<%
	
try{	
	
	
	
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmt1=con1.createStatement();
	int i=1;

       sql="select * from "+tbname+" where JCode='"+tripid+"' ";
	//out.print(sql+"<br>");
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	String thedt=rst.getString("TheDate");
		java.util.Date date4 = new SimpleDateFormat("yyyy-MM-dd").parse(thedt) ;
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String thedate = formatter2.format(date4);

		String frmdate=rst.getString("TheDate");
		String frmtime=rst.getString("TheTime");
		String location="", latit="", longit="";
	
		String sql2="select * from t_veh"+vehcode+" where TheFieldDataDate='"+frmdate+"' and TheFieldDataTime<='"+frmtime+"' order by TheFieldDataTime desc limit 1";

		ResultSet rs2=stmt1.executeQuery(sql2);
		if(rs2.next())
		{
			latit=rs2.getString("LatinDec");
			longit=rs2.getString("LonginDec");
			location=rs2.getString("TheFieldSubject");
		}
		%>
	<tr>
		<td align="center" class="bodyText"><%=i %></td>
		<td align="center" class="bodyText"><%=thedate %></td>
		<td align="center" class="bodyText">
	<%=rst.getString("TheTime") %></td><td align="center" class="bodyText"><%=rst.getString("FromSpeed") %></td><td align="center" class="bodyText"><%=rst.getString("ToSpeed") %></td>
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
