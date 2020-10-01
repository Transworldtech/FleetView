<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

String data1,data2,vid,vehno,sdate,edate,showdate,showdate1;
int cntdt;

	sdate=request.getParameter("sdate");
	
	edate=request.getParameter("edate");
	vid=request.getParameter("vcode");
	//vid=session.getAttribute("vid").toString();
	//System.out.println("Vid:::"+vid);
	vehno=request.getParameter("vehno");
	String transporter=request.getParameter("OwnerName");
	
//	out.println("transporter:::"+transporter);
	String tbname="t_veh"+vid+"_overspeed";
	//System.out.println(tbname);

%>
<table border="0" width="100%"><tr><td>
<table border="0" width="100%">

<tr>
<td colspan="2" align="center">
<font size="3"><b>
SPEED ANALYSIS for Vehicle <%=vehno%> from Date :
<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate))%> to <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate))%></b></font>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printoverspeed1.jsp?data1=<%=sdate%>&data2=<%=edate%>&vehregno=<%=vehno%>&vcode=<%=vid%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="exceloverspeed1.jsp?data1=<%=sdate%>&data2=<%=edate%>&vehregno=<%=vehno%>&vcode=<%=vid%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %>
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
	cntdt=0;
	
	try{
	conn = fleetview.ReturnConnection1();
	Statement st=conn.createStatement();
	//String sql="select * from "+tbname+" where VehCode='"+vid+"' and FromDate='"+dd+"'";
	String sql="select * from "+tbname+" where Transporter = '"+transporter+"' and VehCode='"+vid+"' and concat(FromDate,' ',FromTime)>='"+sdate+"' and concat(ToDate,' ',ToTime)<='"+edate+"'";
	//uiop[ppout.print(sql);
	ResultSet rst=st.executeQuery(sql);
	int i=1;
	while(rst.next())
	{
		%>
	<tr>
	<td><%=i %></td>
	<td> <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("FromDate")))+"<br>"+rst.getString("FromTime") %></td>
	<td><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("ToDate")))+"<br>"+rst.getString("ToTime") %></td>
	<td><div align="right"><%=rst.getString(6) %></div></td>
	<td><div align="right">
	<%
	int ss4=rst.getInt(7);
	if(ss4>0)
	{
		cntdt=cntdt+ss4;
		out.print(rst.getInt(7));
		//out.print("<a href='driver_rapiddeacc.jsp?sdate="+rst.getString("StartDate")+"&edate="+rst.getString("EndDate")+"&vehno="+rst.getString("VehRegNo")+"&vcode="+rst.getString("Vehid")+"&data1="+data1+"&data2="+data2+"'>"+ss4+"</a>");
	}
	else
	{
		out.print(""+ss4);
	}
	%>
	</div></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString("FromDate"),rst.getString("FromTime")) %></div></td>
	</tr>
		<%
		i++;
	}
	%>
	<tr>
	<td colspan="4"><div align="right"><b></>Total</b></div></td>
	<td colspan="1"><div align="center"><b><%=cntdt%></b></div></td>
	<td colspan="1"><div align="center"></div></td>
	<% 
	}catch(Exception e)
	{
		System.out.print("Exception"+e);
	}
	finally
	{
		conn.close();
	}
 %>

</table>
</td></tr></table>
<%
fleetview.closeConnection1();
fleetview.closeConnection();
%>
</jsp:useBean>
        <%@ include file="footernew.jsp" %>
