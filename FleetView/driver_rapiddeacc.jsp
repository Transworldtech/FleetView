<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

String data1,data2,vid,vehno,sdate,edate,showdate,showdate1,time1,time2;
	
sdate=request.getParameter("sdate");
edate=request.getParameter("edate");
	//System.out.println("SDate1::>>>"+sdate);
//	System.out.println("EDate1::>>>"+edate);
	vid=request.getParameter("vcode");
	//vid=session.getAttribute("vid").toString();
	//System.out.println("Vid:::"+vid);
	vehno=request.getParameter("vehno");
//	System.out.println("Vregno:::"+vehno);
	String tbname="t_veh"+vid+"_rd";
//	System.out.println(tbname);
	
	
//	sdate=2010-01-27&edate=2010-01-28%2014:42:16&vehno=RJ%2014%202G%205076&vcode=1820
%>
<table border="0" width="100%">
<tr><td>
<table border="0" width="100%">
<tr><td colspan="2" align="center">


</td></tr>
<tr bgcolor=""><td align="center"colspan="2"><font size="3"><b>RAPID DECELERATION for Vehicle <%=vehno%> from Date :
<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sdate))%> to <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(edate))%></b>
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('printrapiddeacc1.jsp?data1=<%=sdate%>&data2=<%=edate%>&vehregno=<%=vehno%>&vcode=<%=vid%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="excelrapiddecacc1.jsp?data1=<%=sdate%>&data2=<%=edate%>&vehregno=<%=vehno%>&vcode=<%=vid%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
<%=fleetview.PrintDate() %>
</div>
	 </td></tr>
</table>
<P></P>
<table border="1" width="100%" bgcolor="#F5FFFA" class="sortable">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed From</th>
<th>Speed To</th>
<th>Location</th>
</tr>
<%!
Connection conn;
 %>
<%
	//String data1,data2,vid,vehno,dd;
	//data1=session.getAttribute("data1").toString();
	//data2=session.getAttribute("data2").toString();
	//vid=session.getAttribute("vid").toString();
	//vehno=session.getAttribute("vehno").toString();
	//dd=request.getParameter("dd").toString();
	//String tbname="t_veh"+vid+"_rd";
	try{
	
	conn = fleetview.ReturnConnection1();
	Statement st=conn.createStatement();
	String sql="select * from "+tbname+" where VehCode='"+vid+"' and TheDate>='"+sdate+"' and TheDate<='"+edate+"'";
	//out.print(sql+"<br>");'"+fromdate+" "+fromtime+"'
	int i=1;
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
		%>
	<tr>
	<td><%=i %></td>
	<td><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString(2)))+"<br> "+rst.getString(3) %></td>
	<td><%=rst.getString(4) %></td>
	<td><%=rst.getString(5) %></td>
	<td><div align="left"><%=fleetview.ShowOnMapOnlyByDateTime(vid,rst.getString(2),rst.getString(3)) %></div></td>
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
<%@ include file="footernew.jsp"%>