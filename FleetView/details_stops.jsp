 <%@ include file="header.jsp" %>
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

	
	 tbname="t_veh"+vehcode+"_stsp";
	//out.print(tbname);
%>
<table border="1" gbcolor="white" width="100%">
<tr><td>
<table class="stats">
<tr><td colspan="5">
<div align="left">
<a href="javascript: history.go(-1)">Back</a>
</div>
 <b>STOPPAGES for Vehicle  <%=vehregno %> From Date :
<%

java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
Format formatter = new SimpleDateFormat("dd-MMM-yyyy");
String fromdt = formatter.format(date);
out.print(fromdt); %>
	 To Date :
<%
java.util.Date date3 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String todt = formatter1.format(date3);
out.print(todt);
%>

<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('print_detail_stops.jsp?vid=<%=vehcode %>&vehno=<%=vehregno%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Exportdetail_stops.jsp?vid=<%=vehcode %>&vehno=<%=vehregno%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdate = fmt.format(new java.util.Date());
 out.print(curdate); %></div>
</td></tr>
<tr bgcolor="#FAFAD2"><td colspan="3" align="center" class="hed"><b>Period</b></td>
	
	<td align="center" rowspan="2" class="hed"> <b>Duration
</b></td>	
	<td align="center" rowspan="2" class="hed"><b>Location
</b></td>
	</tr>
<tr bgcolor="#FAFAD2">
	<td align="center" class="hed"><b>Sr. No. </b></td>
	<td align="center" class="hed"><b>From </b></td>
	<td align="center" class="hed"><b>To</b></td></tr>

<%
	
try{	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmt1=con1.createStatement();
	//out.print(tbname);
	int i=1;

	
       sql="select * from "+tbname+" where FromDate  >= '"+date1+"' AND ToDate<= '"+date2+"'";
	//out.print(sql);
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	String thedt=rst.getString("ToDate");
		java.util.Date date4 = new SimpleDateFormat("yyyy-MM-dd").parse(thedt) ;
Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
String thedate = formatter3.format(date4);

		String frmdate=rst.getString("FromDate");
		String frmtime=rst.getString("FromTime");
		String location="", latit="", longit="";

		String sql2="select * from t_veh"+vehcode+" where TheFieldSubject like '"+rst.getString("Location")+"' ";
//out.print(sql2);
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
	<td align="center" class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2));
Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter4.format(ShowDate1);
 out.print(showdate1);

%> <%=rst.getString(3) %></td>
<td align="center" class="bodyText"><%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(4));
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter1.format(ShowDate2);
 out.print(showdate2);

%> <%=rst.getString(5) %> </td>
<td align="center" class="bodyText"><%=rst.getString("Duration") %></td>
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
