<%@ include file="header.jsp" %>
<table width="100%" align="center" border="0" class="stats">
<tr><td>

<div class="bodyText"  align='left'><B>The Report For Trip <%=request.getParameter("tripid") %> Vehicle <%=request.getParameter("vehregno") %> Start Date <% java.util.Date sd1 = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("sdate"));
Format fmt1 = new SimpleDateFormat("dd-MMM-yyyy");
String sh1 = fmt1.format(sd1);
 out.print(sh1);
if(request.getParameter("pg").equals("cm"))
{
java.util.Date ed1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("enddate"));
Format fmt2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String eh1 = fmt2.format(ed1);
 out.print(" End Date :" +eh1);
}
%>, Owner Name : <%=request.getParameter("ownername")%>, Start Place : <%=request.getParameter("startplace")%>, End Place : <%=request.getParameter("endplace")%></B></div>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('print_detail_trip_report.jsp?tripid=<%=request.getParameter("tripid")%>&sdate=<%=request.getParameter("sdate")%>&vehregno=<%=request.getParameter("vehregno")%>&ownername=<%=request.getParameter("ownername")%>&startplace=<%=request.getParameter("startplace")%>&endplace=<%=request.getParameter("endplace")%>&enddate=<%=request.getParameter("enddate")%>&pg=cm');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="excel_detail_trip_report.jsp?tripid=<%=request.getParameter("tripid")%>&sdate=<%=request.getParameter("sdate")%>&vehregno=<%=request.getParameter("vehregno")%>&ownername=<%=request.getParameter("ownername")%>&startplace=<%=request.getParameter("startplace")%>&endplace=<%=request.getParameter("endplace")%>&enddate=<%=request.getParameter("enddate")%>&pg=cm" title="Export to Excel">		<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;&nbsp;

Date : <%
Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
String sdt = fmt.format(new java.util.Date());
 out.print(sdt); %></div>
</td></tr>
<tr><td>
<%!
Connection conn;
Statement st,st1;
String sql,sql1,startdate,vehid,tripid,enddate,sql2;
%>
<%
try{
tripid=request.getParameter("tripid");
enddate=request.getParameter("enddate");
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	st1 = conn.createStatement();
sql="select * from t_startedjourney where TripID='"+tripid+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
	vehid=rst.getString("VehId");
	startdate=rst.getString("startdate");
	}
	else
	{
	sql="select * from t_completedjourney where TripID='"+tripid+"'";
	ResultSet rst2=st.executeQuery(sql);
	if(rst2.next())
	{
	vehid=rst2.getString("VehId");
	startdate=rst2.getString("startdate");
	}
	}
/**************** code for Over Speed ********************/
%>
<table class="sortable">
<tr><th colspan="4" class="hed">Over Speed</th></tr>
</table>
<table class="sortable">
<tr>
<td class="hed">Date-Time</td>
<td class="hed">Speed</td>
<td class="hed">Distance</td>
<td class="hed">Location</td>
</tr>
<%
sql1="SELECT * FROM t_veh"+vehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+ startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+ enddate+"' and TheFiledTextFileName='OS' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst1=st.executeQuery(sql1);
while(rst1.next())
{
	%>
<tr>
<td class="bodyText">
<%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst1.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%>
<%=rst1.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst1.getString("Speed") %></td>
	
	<td class="bodyText"><%=rst1.getString("Distance") %></td>
	<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst1.getString("TheFieldSubject")%></a>

</tr>
	<%
	

}
%>
</table>
<%

/*************** end of code for Over Speed **************/

/**************** Rapid Acceleration *********************/

%>
<br><br>
<table class="stats" border="1" width="100%">
<tr><td colspan="4" class="hed">Rapid Acceleration</td></tr>
</table>
<table class="sortable" border="1" width="100%">
<tr>
<td class="hed">Date-Time</td>
<td class="hed">From Speed</td>
<td class="hed">To Speed</td>
<td class="hed">Location</td>
</tr>
<%
sql1="SELECT * FROM t_veh"+vehid+" where  concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+ startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ enddate+"' and TheFiledTextFileName='AC' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst2=st.executeQuery(sql1);
while(rst2.next())
{
if(rst2.getInt("Distance")>5)
{
	%>
<tr>
<td class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst2.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%>
	<%=rst2.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst2.getString("Distance") %></td>
	<td class="bodyText"><%=rst2.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst2.getString("LatinDec")%>&long=<%=rst2.getString("LonginDec")%>&discription=<%=rst2.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst2.getString("LatinDec")%>&long=<%=rst2.getString("LonginDec")%>&discription=<%=rst2.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst2.getString("TheFieldSubject")%></a>

</tr>
	<%
	
}
}
%>
</table>
<%

/**************** End Rapid Acceleration *********************/
/**************** Rapid Deceleraion *************************/

%>
<br><br>
<table class="stats" width="100%" border="1">
<tr>
	<td colspan="4" class="hed">Rapid Deceleration</td>
</tr>
</table>
<table class="sortable" width="100%" border="1">
<tr>
	<td class="hed">Date-Time</td>
	<td class="hed">From Speed</td>
	<td class="hed">To Speed</td>
	<td class="hed">Location</td>
</tr>
<%
sql1="SELECT * FROM t_veh"+vehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+ startdate+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ enddate+"' and TheFiledTextFileName='DC' order by TheFieldDataDate desc,TheFieldDataTime desc";
ResultSet rst3=st.executeQuery(sql1);
while(rst3.next())
{
if(rst3.getInt("Distance")<120)
{
	%>
<tr>
<td class="bodyText"><%
java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd").parse(rst3.getString("TheFieldDataDate"));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate1 = formatter1.format(ShowDate1);
 out.print(showdate1);

%>
	<%=rst3.getString("TheFieldDataTime") %></td>
	<td class="bodyText"><%=rst3.getString("Distance") %></td>
	<td class="bodyText"><%=rst3.getString("Speed") %></td>
	<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst3.getString("LatinDec")%>&long=<%=rst3.getString("LonginDec")%>&discription=<%=rst3.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst3.getString("LatinDec")%>&long=<%=rst3.getString("LonginDec")%>&discription=<%=rst3.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst3.getString("TheFieldSubject")%></a>
</tr>
	<%
	
}
}
%>
</table>
<%


/***************** End of Rapid Deceleration ****************/

/******************code for stops***************/
%>
<br><br>
<table class="stats" border="1" width="100%">
<tr><td colspan="4" class="hed">Stops</td></tr>
</table>
<table class="sortable" border="1" width="100%">
<tr>
	<td class="hed">Start Date-Time</td>
	<td class="hed">End Date-Time</td>
	<td class="hed">Duration</td>
	<td class="hed">Location</td>
</tr>

<%
sql1="select *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehid+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+startdate+"' and  concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+enddate+"'  order by concat(TheFieldDataDate,TheFieldDataTime) asc";
ResultSet rst4= st.executeQuery(sql1);
while(rst4.next())
{
	sql2="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehid+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+startdate+"' and TheFieldDataDate='"+rst4.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rst4.getString("time1"))+" and abs(LatinDec - "+rst4.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1"; 
	ResultSet rst5= st1.executeQuery(sql2);
	if(rst5.next())
	{
	if(rst5.getDouble("time2")-rst4.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
		{
			double duration=(Double.parseDouble(rst5.getString("time2"))-Double.parseDouble(rst4.getString("time1")));
			int hrs=(int)duration/60;
			int min=(int)duration%60;
			
%>
<tr>
<td class="bodyText"><div align="left">
<%
java.util.Date ShowDate3 = new SimpleDateFormat("yyyy-MM-dd").parse(rst4.getString(1));
Format formatter3 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate3 = formatter3.format(ShowDate3);
 out.print(showdate3);
%>
<%=rst4.getString(2) %>
</div></td>
<td class="bodyText"><div align="left">
<%
java.util.Date ShowDate4 = new SimpleDateFormat("yyyy-MM-dd").parse(rst5.getString(1));
Format formatter4 = new SimpleDateFormat("dd-MMM-yyyy");
String showdate4 = formatter4.format(ShowDate4);
 out.print(showdate4);
%> <%=rst5.getString(2) %>
</div></td>
<td class="bodyText"><div align="left">
<%=hrs +"hrs "+min+" min" %>
</div></td>
<td class="bodyText"><div align="left"><a href="shownewmap.jsp?lat=<%=rst4.getString("LatinDec")%>&long=<%=rst4.getString("LonginDec")%>&discription=<%=rst4.getString("TheFieldSubject")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst4.getString("LatinDec")%>&long=<%=rst4.getString("LonginDec")%>&discription=<%=rst4.getString("TheFieldSubject")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst4.getString("TheFieldSubject")%></a>

</tr>

<%
		}

	}
}
%>
</table>
</td></tr>
</table>
<%
/******************code for stops***************/

}catch(Exception e)
{
out.print("Exception "+e);
}
finally
{
conn.close();

}
%>
<!-- footer start here -->
 <%@ include file="footernew.jsp" %>