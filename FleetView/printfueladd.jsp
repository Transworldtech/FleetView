<%@ include file="headerprintnew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
	fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
	Connection conn;
	Statement st, st1;
	String sql, vehcode, fromdate, todate, vehregno, data, data1;
	int prevlevel,currentlevel,diff;
%>
<%
	vehcode=request.getParameter("vehcode");
	fromdate=request.getParameter("data");
	todate=request.getParameter("data1");
	data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
	data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));
	try
	{
		conn=fleetview.ReturnConnection1();
		st=conn.createStatement();
		st1=conn.createStatement();
%>
<table width="100%" align="center" class="sortable">
		
		<%
		vehregno=fleetview.getVehRegNo(vehcode);
		%>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="black" size="3"><b></>The Fuel Addition Report for <%=vehregno %> from <%=fromdate %> to <%=todate %></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.print()" title="Print Current Position Report">
			<img src="images/print.jpg" width="15px" height="15px">
			</a>
				<%=fleetview.PrintDate() %>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Date-Time</b></th>
			<th> <b>Location</b></th>
			<th> <b>Previous Level</b></th>
			<th> <b>Current Level</b></th>
			<th> <b>Difference</b></th>
			</tr>	
			<%
			sql="select * from t_vehfa where vehcode like '"+vehcode+"' and Thedate>='"+data+"' and TheDate <='"+data1+"' order by concat(TheDate,TheTime) desc";
			ResultSet rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{
				prevlevel=rst.getInt("Prevlevel");
				currentlevel=rst.getInt("Currlevel");
				diff=rst.getInt("Diff");
			%>	
			<tr>
			<td> <%=i %></td>
			<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate")) %> <%=rst.getString("TheTime") %></td>
			<td> <%=rst.getString("location") %></td>
			<td> <%= prevlevel %> </td>
			<td> <%= currentlevel %> </td>
			<td> <%= diff %> </td>
			</tr>
			<%
			i++;
			}
			%>
			<tr class="sortbottom">
			<td colspan="6" class="hed"></td>
			</tr>	
			</table>
<%
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
finally
{
	try
	{
	fleetview.closeConnection();
	}
	catch(Exception e){}
}
%>


			</jsp:useBean>
<%@ include file="footernew.jsp" %>