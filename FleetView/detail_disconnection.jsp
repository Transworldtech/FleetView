<%@ include file="header.jsp" %>
<%! 
Connection conn,conn1;
Statement st,st1,st2,st11;
String sql,tripid, vehcode,startdate,startime,enddate,endtime,startplace, endplace,vehregno;
%>
<%
Format formatter=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
Format formatter1=new SimpleDateFormat("dd-MMM-yyyy");
vehcode=request.getParameter("vid");
vehregno=request.getParameter("vehno");
startdate=request.getParameter("data");
String startdate1 =formatter1.format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate));
startime=request.getParameter("fromtime");
endtime=request.getParameter("totime");
enddate=request.getParameter("data1");
String endate1 =formatter1.format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate));

//startplace=request.getParameter("startplace");
//endplace=request.getParameter("endplace");


//out.print(tripid+" "+vehcode+" "+vehregno+" "+startdate+" "+enddate+" "+startplace+" "+endplace);
%>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td align="center">
<table border="1" width="100%" align="center" bgcolor="white" class="stats">
<tr><td align="center">
<font color="brown" size="2">The Detail Disconnection Report for the  vehicle <%=vehregno%> From <%=startdate1%> 00:00:00  to  <%=endate1%> 23:59:59</font>
<div align="right">
<a href="#" onclick="javascript:window.open('print_detail_disconnection_report.jsp?vid=<%=vehcode%>&data=<%=startdate%>&data1=<%=enddate%>&vehno=<%=vehregno%>');" title="Print Report">
<img src="images/print.jpg" width="15px" height="15px">
</a>&nbsp; &nbsp; 
<a href="excel_detail_disconnection_report.jsp?vid=<%=vehcode%>&data=<%=startdate%>&data1=<%=enddate%>&vehno=<%=vehregno%>"  title="Export to Excel">
<img src="images/excel.jpg" width="15px" height="15px">
</a>
&nbsp;&nbsp;&nbsp;<font size="2"> 
Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %></font>
</div>

</td></tr>
<tr><td>
<table border="1" width="100%" align="center" class="sortable">
<tr>
<td>Sr.</td>
<td>From Date-Time</td>
<td>From Location</td>
<td>To Date-Time</td>
<td>To Location</td>
<td>Distance</td>
<td>Duration</td>
<td>Tripid</td>
</tr>
<%
try
{
Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn1.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		st11=conn.createStatement();
		int i=0;
		sql="Select * from db_gps.t_disconnectionData where vehicleCode='"+vehcode+"'and  OffTimeFrom >= '"+startdate+" "+startime+"' and OffTimeFrom <='"+enddate+" "+endtime+"' ";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
			String fromdate=formatter.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parseObject(rst.getString("OffTimeFrom")));
			System.out.println("fromdate===>"+fromdate);
			String todate=formatter.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parseObject(rst.getString("OffTimeTo")));
			System.out.println("todate===>"+todate);
		%>
		<tr>
		<td><%=i%></td>
		<td><%=fromdate%></td>
		<td><div align=left>
		<% 
		sql="select * from t_veh"+vehcode+" where TheFieldSubject='"+rst.getString("FromLocation")+"' limit 1";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{
			%>
			<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("FromLocation")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("FromLocation")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("FromLocation")%></a>
			<%
		}
		else
		{
			out.print(rst.getString("FromLocation"));
		}
		%>
		</div>
		</td>
		<td><%=todate%></td>
		<td><div align="left">
		<%
		sql="select * from t_veh"+vehcode+" where TheFieldSubject='"+rst.getString("ToLocation")+"' limit 1";
		ResultSet rst11=st11.executeQuery(sql);
		if(rst11.next())
		{
			%>
			<a href="shownewmap.jsp?lat=<%=rst11.getString("LatinDec")%>&long=<%=rst11.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("ToLocation")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst11.getString("LatinDec")%>&long=<%=rst11.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("ToLocation")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("ToLocation")%></a>
			<%
		}
		else
		{
			out.print(rst.getString("ToLocation"));
		}
		%></div></td>
		<td> <div align="right"><%=rst.getDouble("Distance")%> </div></td>
		<td> <div align="right"><%=rst.getString("Duration")%> </div></td>
		<%
		String Tripid="";
		Tripid=rst.getString("TripId");
		if(Tripid.equalsIgnoreCase(" ")||Tripid==null || Tripid.equalsIgnoreCase("null")|| Tripid.equalsIgnoreCase(" -"))
		{
			%>
			<td>-</td>		
			<%			
		}
		else{
			%>
			<td> <%=rst.getString("TripId")%> </td>
			<%
		}
		%>
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
		conn1.close();
}
%>
</table>
</td></tr>
</table>
</td></tr>
</table>
<!-- footer starts here-->
<table border="1" width="100%" bgcolor="white">
<tr ><td class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</td></tr>
</table>
</body>
</html>
