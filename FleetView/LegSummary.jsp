<%@ include file="Connections/conn.jsp" %>
<%@ page import="java.util.*" %>

<%!
Connection con1;
Statement st,st1,st2;
%>
<% 
try 
{
	System.out.println("legsummary");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con1.createStatement();
	st1=con1.createStatement();
	st2=con1.createStatement();
	ResultSet rst=null;
	String sql="",sql1="";
	
	String tripid = request.getParameter("tripid");
	String briefid = request.getParameter("briefid");
	String driverid=  request.getParameter("driverid");
	String day = request.getParameter("Day");
	String routeid = request.getParameter("routeid");
	//System.out.println("routeid    "+routeid);
	String buffer = "";
/*	 buffer = "<table border='1' class='sortable'><tr><th>Day</th><th>Event</th><th>Start</th><th>End</th><th>Duration</th><th>Origin</th>"+
							  "<th>Destination</th><th>Leg Distance</th><th>Trip Distance</th><th>Distance To Go</th><th>Stop Duration</th><th>Stop Reason</th></tr>";*/
	%>
<table border="1" class="sortable">
	<tr>
	<th>Day</th>
	<th>Event</th>
<th>Start</th>
	<th>End</th>
	<th>Duration</th>
	<th>Origin</th>
	<th>Destination</th>
	<th>Leg Distance</th>
	<th>Trip Distance</th>
	<th>Distance To Go</th>
	<th>Stop Duration</th>
	<th>Stop Reason</th>
	</tr>
	
	<%
	sql = "select * from db_gps.t_jrnyplanning where Tripid = '"+tripid+"' and brifid = '"+briefid+"' and driverid = '"+driverid+"' and Day = '"+day+"' order by start asc";
	//System.out.println("sql    "+sql);
	rst = st1.executeQuery(sql);
	while(rst.next())
	{
		String startdate = "",lat1 = "",lon1 = "",lat2 = "",lon2 = "";
		if(rst.getString("Start").equals(" ") || rst.getString("Start").equals("-"))
		{
			startdate = rst.getString("Start");
		}
		else
		{
			
			startdate = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse( rst.getString("Start"))) ;
		}
		
		String enddate = "",duration = "",stdur = "";
		if(rst.getString("End").equals("") || rst.getString("End").equals("-"))
		{
			enddate = rst.getString("End") ;
		}
		else
		{
			enddate =new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse( rst.getString("End")));
		}
		
		if(rst.getString("Duration").equals("") || rst.getString("Duration").equals("-"))
		{
			duration = rst.getString("Duration") ;
		}
		else
		{
			duration = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse( rst.getString("Duration"))) ;
		}
		
		if(rst.getString("StopDuration").equals("-"))
		{
			stdur = rst.getString("StopDuration") ;		
		}
		else
		{
			stdur = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rst.getString("StopDuration")))  ;
		}
		 //System.out.println("sql  ****************************************  ");
	    sql1 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rst.getString("Origin")+"'  and advancedrouteid = '"+routeid+"'";
	    //System.out.println("sql  ****************************************  "+sql1);
	    ResultSet rs2 = st2.executeQuery(sql1);
		   if(rs2.next())
		   {
			   lat1 = rs2.getString("latitude");
			   lon1 = rs2.getString("longitude");
		   }
		   
		   sql1 = "select * from db_gps.t_jrmrouteadvanceddetails where Placename = '"+rst.getString("Destination")+"'  and advancedrouteid = '"+routeid+"'";
			  rs2 = st2.executeQuery(sql1);
		   if(rs2.next())
		   {
			   lat2 = rs2.getString("latitude");
			   lon2 = rs2.getString("longitude");
		   }
		 //  System.out.println("sql  ****************************************  ");
		%>
		<tr>
	<td align="right"><div align="right"><%=rst.getString("day") %></div></td>
		<td align="left"><div align="left"><a href="#" onclick="javascript:try{open3('<%=tripid %>','<%=driverid %>','<%=briefid %>','<%=day %>')}catch(e){alert(e);}"><%=rst.getString("Event") %></a></div></td>
		<td align="right" width="10%"><div align="right"><%=startdate %></div></td>
		<td align="right"  width="10%"><div align="right"><%=enddate%></div></td>
		<td align="right"><div align="right"><%=duration %></div></td>
		<td align="left"><div align="left"><a href="shownewmap.jsp?lat=<%=lat1 %>&long=<%=lon1%>&discription=<%=rst.getString("Origin")  %>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat1 %>&long=<%=lon1%>&discription=<%=rst.getString("Origin")  %>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst.getString("Origin")  %></a></div></td>
		<td align="left"><div align="left"><a href="shownewmap.jsp?lat=<%=lat2 %>&long=<%=lon2%>&discription=<%=rst.getString("Destination") %>" onclick="popWin=open('shownewmap.jsp?lat=<%=lat2 %>&long=<%=lon2%>&discription=<%=rst.getString("Destination") %>', 'myWin','width=500, height=500'); popWin.focus(); return false">&nbsp;&nbsp;<%=rst.getString("Destination") %></a></div></td>
		<td align="right"><div align="right"><%=rst.getInt("LegDistance")/1000 %></div></td>
	<td align="right"><div align="right"><%=rst.getInt("Tripdist")/1000 %></div></td>
		<td align="right"><div align="right"><%=rst.getInt("kmtogo")/1000 %></div></td>
		<td align="right"><div align="right"><%=stdur %></div></td>
		<td align="left"><div align="left"><%=rst.getString("StopReason") %></div></td>
		</tr>
		<%
		/*buffer = buffer + "<tr><td align='right'><div align='right'>"+rst.getString("day")+"</div></td><td align='left'><div align='left'><a href='#' onclick='javascript:try{open3('"+tripid +"','"+driverid+"','"+briefid +"','"+day+"')}catch(e){alert(e);}">"+
					   rst.getString("Event")+"</div></td><td align='right'><div align='right'>"+rst.getString("Start")+"</div></td><td align='right'>"+
					   "<div align='right'>"+enddate+"</div></td><td align='right'><div align='right'>"+duration +"</div></td><td align='left'><div "+
					   "align='left'>"+rst.getString("Origin")+"</div></td><td align='left'><div align='left'>"+rst.getString("Destination")+"</div></td>"+
					   "<td align='right'><div align='right'>"+rst.getString("LegDistance")+"</div></td><td align='right'><div align='right'>"+rst.getString("Tripdist") +
					   "</div></td><td align='right'><div align='right'>"+rst.getString("kmtogo") +"</div></td><td align='right'><div align='right'>"+stdur +
					   "</div></td><td align='left'><div align='left'>"+rst.getString("StopReason")+"</div></td></tr>";*/
	}
	%>
	</table>
	<%
	//buffer = buffer + "</table>";
	//System.out.println(buffer);
//	out.print(buffer);
}
catch(Exception e)
{
	System.out.println("Exception    "+e);
}
finally
{
	st.close();
	con1.close();
}
	
	
	%>