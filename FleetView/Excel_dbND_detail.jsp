<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");


String filename="detail_nd_report.xls";
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

	 tbname="t_driver_nd";
	//out.print(tbname);
%>
<table border="1" gbcolor="white" width="100%">
<tr><td>
<table class="stats">
<tr><td colspan="6">

 <b>NIGHT DRIVING REPORT for <%=drivername %> From <%
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
&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String curdate = fmt.format(new java.util.Date());
 out.print(curdate); %></div>
</td></tr>


<tr bgcolor="#FAFAD2"><td colspan="3" align="center" class="hed"><b>Period</b></td><td align="center" rowspan="2" class="hed"><b>Distance Covered in kms
</b></td><td align="center" rowspan="2" class="hed"> <b>Duration
</b></td>
<td align="center" rowspan="2" class="hed"> <b>Distance
</b></td>
</tr>
<tr bgcolor="#FAFAD2">
	<td align="center" class="hed"><b>Sr. No. </b></td>
	<td align="center" class="hed"><b>From </b></td>
	<td align="center" class="hed"><b>To</b></td></tr>
<%
	
try{	
	
	//out.print(data1+"  "+ data2+"  "+ vehcode+"  "+ vehregno);
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	stmt1=con1.createStatement();
	int i=1;

      sql="select * from "+tbname+" where JCode='"+tripid+"'";
	//sql="select * from "+tbname+"";
	
	
	ResultSet rst=st.executeQuery(sql);

	while(rst.next())
	{
	
	String thedt=rst.getString("ToDate");
		java.util.Date date4 = new SimpleDateFormat("yyyy-MM-dd").parse(thedt) ;
Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy");
String todate = formatter2.format(date4);

		String frmdate=rst.getString("FromDate");
		String frmtime=rst.getString("FromTime");
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
		<td align="center" class="bodyText"> <%=i%> </td>
		<td align="center" class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2));
Format formatter5 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter5.format(ShowDate1);
 out.print(showdate1+" ");

%><%=rst.getString(3) %></td><td align="center" class="bodyText">
<%
java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(4));
Format formatter6 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate2 = formatter6.format(ShowDate2);
 out.print(showdate2+" ");

%>
<%=rst.getString(5) %></td><td align="center" class="bodyText"><%=rst.getString(6) %><td align="center" class="bodyText"><%=rst.getString(7) %></td>
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
