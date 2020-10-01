<%@ include file="header.jsp" %>
<%! 
Connection conn,conn1;
Statement st,st1,st2;
String sql,tripid, vehcode,startdate,enddate,startplace, endplace,vehregno;
%>
<%
tripid=request.getParameter("tripid");
vehcode=request.getParameter("vehcode");
vehregno=request.getParameter("vehregno");
startdate=request.getParameter("data");
enddate=request.getParameter("data1");
startplace=request.getParameter("startplace");
endplace=request.getParameter("endplace");


//out.print(tripid+" "+vehcode+" "+vehregno+" "+startdate+" "+enddate+" "+startplace+" "+endplace);
%>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td align="center">
<table border="1" width="100%" align="center" bgcolor="white" class="stats">
<tr><td align="center">
<font color="brown" size="2">The Detail stop report for the trip <%=tripid%>, vehicle <%=vehregno%>, Start Date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(startdate))%>, start place <%=startplace%>, end date <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate))%> and end place <%=endplace%></font>
<div align="right">
<a href="#" onclick="javascript:window.open('print_detail_stop_report.jsp?tripid=<%=tripid%>&vehcode=<%=vehcode%>&data=<%=startdate%>&data1=<%=enddate%>&vehregno=<%=vehregno%>&startplace=<%=startplace%>&endplace=<%=endplace%>');" title="Print Report">
<img src="images/print.jpg" width="15px" height="15px">
</a>&nbsp; &nbsp; 
<a href="excel_detail_stop_report.jsp?tripid=<%=tripid%>&vehcode=<%=vehcode%>&data=<%=startdate%>&data1=<%=enddate%>&vehregno=<%=vehregno%>&startplace=<%=startplace%>&endplace=<%=endplace%>"  title="Export to Excel">
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
<td>Stop Date-Time</td>
<td>Start Date-Time</td>
<td>Duration</td>
<td>Location</td>
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
		sql="select * from t_warehousedata where Owner='"+session.getAttribute("usertypevalue")+"'";
		//out.print(sql);
		ResultSet rst2=st2.executeQuery(sql);
		int i=1;
		while(rst2.next())
		{
		sql="select * from t_veh"+vehcode+"_stsp where FromDate >='"+startdate+"' and FromDate <='"+enddate+"' and Location like '%"+rst2.getString("WareHouse")+"%'";
		ResultSet rst=st.executeQuery(sql);
		
		while(rst.next())
		{
		%>
		<tr>
		<td><%=i%></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("FromDate"))%> <%=rst.getString("FromTime")%></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("ToDate"))%> <%=rst.getString("ToTime")%></td>
		<td><%=rst.getString("Duration")%></td>
		<td><div align="left">
		<%
		sql="select * from t_veh"+vehcode+" where TheFieldSubject='"+rst.getString("Location")+"' limit 2";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{
			%>
			<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("Location")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("Location")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("Location")%></a>
			
			<%
		}
		else
		{
			out.print(rst.getString("Location"));
		}
		%></div></td>
		</tr>		
		<%
		i++;
		}
		}
		
}catch(Exception e)
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
