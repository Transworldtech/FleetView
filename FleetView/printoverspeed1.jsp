<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

String data1,data2,vid,vehno,tripid,sdate,edate,showdate,showdate1;
	
sdate=request.getParameter("data1");
edate=request.getParameter("data2");
tripid=request.getParameter("tripid");
vid=request.getParameter("vcode");
//System.out.println("Vid:::"+vid);
//vehno=request.getParameter("vehno");
//System.out.println("Vregno:::"+vehno);
	String tbname="t_veh"+vid+"_overspeed";
	//System.out.println(tbname);

%>
<table border="0" width="100%"><tr><td>
<table border="0" width="100%">

<tr>
<td colspan="2" align="center">
<font size="3"><b>
SPEED ANALYSIS for Trip <%=tripid%>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.print();" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
<b><%=fleetview.PrintDate() %></b>
</div>
</td></tr>
</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="sortable">
<tr>
<th>Sr.</th>
<th>From Date-Time</th>
<th>To Date-Time</th>
<th>Speed in KMPH</th>
<th>Duration in Seconds</th>
<th>Location</th>
</tr>
<%!
Connection conn;
%>
<%
	//String data1,data2,vid,vehno,dd;
	///data1=session.getAttribute("data1").toString();
	//data2=session.getAttribute("data2").toString();
	//vid=session.getAttribute("vid").toString();
	//vehno=session.getAttribute("vehno").toString();
	//dd=request.getParameter("dd").toString();
	//String tbname="t_veh"+vid+"_overspeed";
	try{
	conn = fleetview.ReturnConnection1();
	Statement st=conn.createStatement();
	//String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
	String sql="select * from "+tbname+" where concat(FromDate,' ',FromTime)>='"+sdate+"' and concat(ToDate,' ',ToTime)<='"+edate+"'";
	//System.out.print(sql);
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		%>
	<tr>
	<td><%=i %></td>
	<td> <%=rst.getString("FromDate")+"<br>"+rst.getString("FromTime") %></td>
	<td><%=rst.getString("ToDate")+"<br>"+rst.getString("ToTime") %></td>
	<td><div align="right"><%=rst.getString(6) %></div></td>
	<td><div align="right"><%=rst.getString(7) %></div></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>
	</tr>
		<%
		i++;
	}
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
	finally
	{
		try{
			conn.close();
		}
		catch(Exception e)
		{
			
		}
		try{
			fleetview.closeConnection1();
			fleetview.closeConnection();
		}
		catch(Exception e)
		{
			
		}
	}
 %>

</table>
</td></tr></table>
<%

%>
</jsp:useBean>
        <%@ include file="footernew.jsp" %>
