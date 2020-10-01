<%@ include file="Connections/conn.jsp" %>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
Connection conn, conn1;
Statement st, st1, st2, st3;
String sql, sql1;
double ra, rd, os, ra1, rd1,os1, rating,dist;
%>
<table border="1" width="100%" bgcolor="white">
<tr><td>
<!-- code start-->
<%!
String data1,data2,trans1,trans2,origin1,origin2,destination1,destination2;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn1.createStatement();

%>
<table class="stats" width="100%" align="center">
<tr>
<td>
<%
/************ The Search Result Comes here *******************/
 	%>
		<div align="center"><font color="brown" size="2"><%=session.getAttribute("heading").toString()%></font></div>
		<div align="right">
		 <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></div>		
		<table class="sortable" border="1" align="center" width="100%"
		<tr>
		<td><b>Sr.</b></td>
		<td><b>Trip Id</b></td>
		<td><b>Vehicle</b></td>
		<td><b>Driver</b></td>
		<td><b>Origin</b></td>
		<td><b>Destination</b></td>
		<td><b>Distance</b></td>
		<td><b>Time Taken</b></td>
		<td><b>OS</b></td>
		<td><b>RA</b></td>
		<td><b>RD</b></td>
		<td><b>CD</b></td>
		<td><b>ST</b></td>
		<td><b>ND</b></td>
		<td><b>Rating</b></td>
		</tr>
	<%
	sql=session.getAttribute("sql").toString();
	//out.print(sql);
	session.setAttribute("sql",sql);
	int i=1;
	ResultSet rst3=st.executeQuery(sql);
	while(rst3.next())
	{
	ra=0.0;
	rd=0.0;
	os=0.0;
	ra1=0.0;
	rd1=0.0;
	os1=0.0;
	dist=0.0;
	rating=0.0;
		%>
	<tr>
		<td><%=i%></td>
		<td><a href="detail_trip_report.jsp?tripid=<%=rst3.getString("TripId")%>&vehcode=<%=rst3.getString("VehId")%>&sdate=<%=rst3.getString("startDate")%>&vehregno=<%=rst3.getString("VehRegNo")%>&ownername=<%=rst3.getString("ownername")%>&startplace=<%=rst3.getString("StartPlace")%>&endplace=<%=rst3.getString("EndPlace")%>&enddate=<%=rst3.getString("EndDate")%>&pg=cm"><%=rst3.getString("TripId")%></a></td>
		<td><div align="left"><%=rst3.getString("VehRegNo")%></div></td>
		<td><div align="left"><%=rst3.getString("DriverName")%> ( <%=rst3.getString("DriverId")%> )</div></td>
		<td><div align="left"><%=rst3.getString("StartPlace")%></div></td>
		<td><div align="left"><%=rst3.getString("EndPlace")%></div></td>
		<td><div align="right"><%=rst3.getString("kmTravelled")%><% dist=rst3.getInt("kmTravelled"); %></div></td>
		<td>
		<%
		java.util.Date dt1=rst3.getDate("StartDate");		
		java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst3.getString("EndDate"));		
		long mils1,mils2,mils3;
		mils3=0;
		mils1=0;
		mils2=0;		
		mils1=dt1.getTime();
		mils2=dt2.getTime();
		mils3=((mils2-mils1)/1000/60/60);
		out.print(" "+mils3+" Hrs.");
		%>		
		</td>
		<td>
		<%
			sql="select count(*) as OScount,sum(duration) as duration from t_veh"+rst3.getString("vehid")+"_overspeed where fromdate >='"+rst3.getString("startdate")+"' and concat(fromdate,' ',fromtime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst4=st2.executeQuery(sql);
			if(rst4.next())
			{
			out.print(rst4.getInt("OSCount"));
			os=rst4.getDouble("Duration");
			}
		%>		
		
		</td>
		<td>
		<%
			sql="select count(*) as RAcount from t_veh"+rst3.getString("vehid")+"_ra where TheDate >='"+rst3.getString("startdate")+"' and concat(TheDate,' ',TheTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst5=st2.executeQuery(sql);
			if(rst5.next())
			{
			out.print(rst5.getInt("RAcount"));
			ra=rst5.getInt("RAcount");
			}
		%>			
		
		</td>
		<td>
		<%
			sql="select count(*) as RDcount from t_veh"+rst3.getString("vehid")+"_rd where TheDate >='"+rst3.getString("startdate")+"' and concat(TheDate,' ',TheTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst6=st2.executeQuery(sql);
			if(rst6.next())
			{
			out.print(rst6.getInt("RDcount"));
			rd=rst6.getInt("RDcount");
			}
		%>			
		</td>
		<td>
		<%
			sql="select count(*) as CRcount from t_veh"+rst3.getString("vehid")+"_cr where FromDate >='"+rst3.getString("startdate")+"' and concat(FromDate,' ',FromTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst7=st2.executeQuery(sql);
			if(rst7.next())
			{
			out.print(rst7.getInt("CRcount"));
			}
		%>			
		</td>
		<td>
		<%
			sql="select count(*) as STcount from t_veh"+rst3.getString("vehid")+"_stsp where FromDate >='"+rst3.getString("startdate")+"' and concat(FromDate,' ',FromTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst8=st2.executeQuery(sql);
			if(rst8.next())
			{
			out.print(rst8.getInt("STcount"));
			
			}
		%>			
		</td>
		<td>
		<%
			sql="select count(*) as NDcount from t_veh"+rst3.getString("vehid")+"_nd where FromDate >='"+rst3.getString("startdate")+"' and concat(FromDate,' ',FromTime) <='"+rst3.getString("enddate")+"'";
			//out.print(sql);
			ResultSet rst9=st2.executeQuery(sql);
			if(rst9.next())
			{
			if(rst9.getInt("NDcount") > 0)
			{
				out.print("Yes");
			}
			else
			{
				out.print("No");
			}
			}
		%>				
		
		</td>
		<td>
		<%
		try{
		if(dist <= -0)
		{
			ra1=0.0;
			rd1=0.0;
			os1=0.0;
		}
		else
		{
		ra1=(ra/dist)/100;
		rd1=(rd/dist)/100;
		os1=((os/10)/dist)*100;
		}
		String pp=""+(os1+ra1+rd1);
		if(pp.length() >5)
		{
			out.print(pp.substring(0,pp.indexOf(".")+2));
		}
		else
		{
			out.print(pp);
		}		
		}catch(Exception ee)
		{
			out.print("0");
		}
		%>
		</td>
	</tr>		
		<%
		i++;
	}	
	%>		
	</table>		
		<%

	
/************ The Search Result End here  *******************/
%>

</td>
</tr>
</table>
<%
}catch(Exception e)
{
	out.print("Exception -->"+e);
}
finally
{
	conn.close();
	conn1.close();
}
%>
<!-- code end -->
</td></tr>
	<tr><td align="center"><input type="button" name="Print" value="Print" onclick="javascript:window.print();" class="formElement"></td></tr>
</table>
<!-- footer start here -->
<table border="1" width="100%" bgcolor="white">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
