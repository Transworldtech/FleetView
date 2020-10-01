<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"Fueladd.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
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
//System.out.println(vehcode);
	fromdate=request.getParameter("data");
	//System.out.println(fromdate);
	todate=request.getParameter("data1");
	//System.out.println(todate);
	data=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
	data1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));
	//System.out.println(data);
	//System.out.println(data1);
	
	try
	{
		conn=fleetview.ReturnConnection1();
		st=conn.createStatement();
		st1=conn.createStatement();
%>
<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort"><font color="block" size="2" >Fuel Addition Report</font></td>
			</tr>
			
		<%
		vehregno=fleetview.getVehRegNo(vehcode);
		//System.out.println(vehregno);
		
		%>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Fuel Addition Report for <%=vehregno %> from <%=fromdate %> to <%=todate %></font></div>
				<div align="right">
				
				
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
			//System.out.println(sql);	
			//"select * from t_veh"+vehcode+" where TheFieldDataDate >='"+data+"' and TheFieldDataDate <='"+data1+"' and theFiledTextFileName='FA' order by concat(TheFieldDataDate,TheFieldDataTime) desc";
			
			ResultSet rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{
				//prevlevel=Integer.parseInt(fleetview.getPrevFuelLevel(vehcode,rst.getString("TheFieldDataDate"),rst.getString("TheFieldDataTime")));
				//currentlevel=rst.getInt("FuelLevel");
				//diff=currentlevel-prevlevel;
				
				prevlevel=rst.getInt("Prevlevel");
				currentlevel=rst.getInt("Currlevel");
				diff=rst.getInt("Diff");
				//System.out.println(prevlevel);
				//System.out.println(currentlevel);
				//System.out.println(diff);
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
	//out.print("Exception---->"+e);
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