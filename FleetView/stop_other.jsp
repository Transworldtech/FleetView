<%@ include file="header.jsp" %>
<%! 
Connection conn,conn1;
Statement st,st1,st2;
String sql,tripid, vehcode,startdate,startime,enddate,endtime,startplace, endplace,vehregno;
%>
<%
tripid=request.getParameter("tripid");
vehcode=request.getParameter("vehcode");
vehregno=request.getParameter("vehregno");
startdate=request.getParameter("data");
startime=request.getParameter("frmtime");
enddate=request.getParameter("data1");
endtime=request.getParameter("ttime");
//startplace=request.getParameter("startplace");
//endplace=request.getParameter("endplace");


//out.print(tripid+" "+vehcode+" "+vehregno+" "+startdate+" "+enddate+" "+startplace+" "+endplace);
%>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td align="center">
<table border="1" width="100%" align="center" bgcolor="white" class="stats">
<tr><td align="center">
<font color="brown" size="2">The Detail stop report for the trip <%=tripid%>,vehicle <%=vehregno%></font>
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
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn1.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		int i=0;
		sql="select distinct a.FromDate as frmdate ,a.FromTime as frmtime ,a.ToDate tdate ,a.ToTime as ttime  ,a.Location as locate ,a.Duration  from db_gpsExceptions.t_veh"+vehcode+"_stsp a, db_gps.t_warehousedata b where concat(a.FromDate,' ',a.fromtime)>='"+startdate+" "+startime+"' and concat(a.ToDate,' ',a.Totime)<='"+enddate+" "+endtime+"' and concat(a.FromDate,' ',a.fromtime)  not in(select distinct concat(a.FromDate,' ',a.fromtime)   from db_gpsExceptions.t_veh"+vehcode+"_stsp a, db_gps.t_warehousedata b where concat(a.FromDate,' ',a.fromtime)>='"+startdate+" "+startime+"' and a.location like 'In %' and b.owner='"+session.getAttribute("usertypevalue").toString()+"' and a.location like concat('%',b.warehouse,'%'))";
		ResultSet rst=st.executeQuery(sql);
		while(rst.next())
		{
		%>
		<tr>
		<td><%=i%></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("frmdate"))%> <%=rst.getString("frmtime")%></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("tdate"))%> <%=rst.getString("ttime")%></td>
		<td><%=rst.getString("Duration")%></td>
		<td><div align="left">
		<%
		sql="select * from t_veh"+vehcode+" where TheFieldSubject='"+rst.getString("locate")+"' limit 2";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{
			%>
			<a href="shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("locate")%>" onclick="popWin = open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%="<b>"+vehregno+"</b><br>"%><%=rst.getString("locate")%>','myWin','width=500,height=500');popWin.focus();return false"><%=rst.getString("locate")%></a>
			
			<%
		}
		else
		{
			out.print(rst.getString("locate"));
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
