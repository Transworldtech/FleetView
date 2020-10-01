<%@ include file="header.jsp" %>
<%! 
Connection conn ;
Statement st,st1,st2;
String sql,tripid, vehcode,startdate,startime,enddate,endtime,startplace, endplace,vehregno,stopType;
%>
<%
tripid=request.getParameter("tripid");
vehcode=request.getParameter("vehcode");
vehregno=request.getParameter("vehregno");
startdate=request.getParameter("data");
startime=request.getParameter("frmtime");
enddate=request.getParameter("data1");
endtime=request.getParameter("ttime");
stopType=request.getParameter("stopType");
System.out.println("\n\n stopType-->> "+stopType);
//startplace=request.getParameter("startplace");

//endplace=request.getParameter("endplace");


//out.print(tripid+" "+vehcode+" "+vehregno+" "+startdate+" "+enddate+" "+startplace+" "+endplace);
%>
<html>
<body>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td align="center">
<table border="1" width="100%" align="center" bgcolor="white" class="stats">
<tr><td align="center">
<font color="brown" size="2">The Detail <%=stopType %> report for trip <%=tripid%>,vehicle <%=vehregno%></font>
<!-- <div align="right">
<a href="#" onclick="javascript:window.open('print_detail_stop_report.jsp?tripid=< %=tripid%>&vehcode=< %=vehcode%>&data=< %=startdate%>&data1=< %=enddate%>&vehregno=< %=vehregno%>&startplace=< %=startplace%>&endplace=< %=endplace%>');" title="Print Report">
<img src="images/print.jpg" width="15px" height="15px">
</a>&nbsp; &nbsp; 
<a href="excel_detail_stop_report.jsp?tripid=< %=tripid%>&vehcode=< %=vehcode%>&data=< %=startdate%>&data1=< %=enddate%>&vehregno=< %=vehregno%>&startplace=< %=startplace%>&endplace=< %=endplace%>"  title="Export to Excel">
<img src="images/excel.jpg" width="15px" height="15px">
</a>-->
&nbsp;&nbsp;&nbsp;<font size="2"> 
Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %></font>
</div>

</td></tr>
<tr><td>
<table border="1" width="100%" align="center" class="sortable">
<tr>
<td>Sr.</td>
<td>From Date-Time</td>
<td>To Date-Time</td>
<td>Duration</td>
<td>Location</td>
</tr>
<%
try
{
Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		int i=0;
	//	sql="select fromdate,todate,location,duration from db_gps.t_RoundTripStop "+
	//	" where tripid='"+tripid+"' and locationtype like ('%"+stopType.substring(0,3)+"%') "+
	//	" AND Fromdate >= '"+startdate+" "+startime+"'  AND todate <= '"+enddate+" "+endtime+"' ";
	
if(stopType.equals("Plant_Stop"))
{
	System.out.println("\nin ifffffffff....");
		sql="select fromdate,todate,location,duration from db_gps.t_RoundTripStop "+
		" where tripid='"+tripid+"' and locationtype like ('%"+stopType.substring(0,3)+"%')";
}
else
{
	System.out.println("\nin else....");
	sql="select fromdate,todate,location,duration from db_gps.t_RoundTripStop "+
		" where tripid='"+tripid+"' and locationtype like ('%"+stopType.substring(0,3)+"%') "+
		" AND Fromdate >= '"+startdate+" "+startime+"'  AND todate <= '"+enddate+" "+endtime+"' ";
	
}
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
		%>
		<tr>
		<td><%=i%></td>
		<td><%out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("fromdate"))));%> </td>
		<td><%out.print(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("todate"))));%></td>
		<td><%=rst.getString("Duration")%></td>
		<td><div align="left">
		<%
		sql="select * from db_gps.t_veh"+vehcode+" where TheFieldSubject='"+rst.getString("location")+"' limit 2";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{
			%>
			<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("location")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("location")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("location")%></a>
			
			<%
		}
		else
		{
			out.print(rst.getString("location"));
		}
		%></div></td>
		</tr>		
		<%
		i++;
		}
		}
		
catch(Exception e)
{
	out.print("Exception --->"+e);
}
finally
{
		conn.close();
}
%>
</table>
</td></tr>
</table>
</td></tr>
</table>
<br>

</body>
</html>
