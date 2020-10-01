<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
String vehcode, fromdate, todate;
%>
<%
Connection conn;
Statement st;
vehcode=request.getParameter("vehcode");
fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");
try{
	conn=fleetview.ReturnConnection();
	st=conn.createStatement();
	

%>
			<table width="100%" align="center" >
			<tr>
			<td align="center">
			<!-- <div align="left"><font size="3" >Report No: 1.14</font></div>-->
			<font  size="3" ><b>Rapid Acceleration Today  </b></font></td>
			</tr>
			<tr>
			<td>
			<div  align="center"><font size="3"><b>The Rapid Acceleration Report for <%=fleetview.getVehRegNo(vehcode) %> On <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)) %></b></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('printnewra.jsp?vehcode=<%=vehcode %>&fromdate=<%=fromdate %>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelnewra.jsp?vehcode=<%=vehcode %>&fromdate=<%=fromdate %>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=fleetview.PrintDate()%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Date-Time</b></th>
			<th> <b>Speed</b></th>
			<th> <b>Duration Sec.</b></th>
			<th> <b>Location</b></th>
			</tr>		
			<%
			String sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+fromdate+"' and TheFiledTextFileName in ('AC')";
			ResultSet rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{
			%>
				<tr>
			<td> <%=i %></td>
			<td> <%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheFieldDataDate"))+" "+rst.getString("TheFieldDataTime") %></td>
			<td> <div align="right"><%=rst.getString("Speed") %></div></td>
			<td> <div align="right"><%=rst.getString("Distance") %></div></td>
			<td> <div align="left"><%=fleetview.showNewMap(rst.getString("LatinDec"),rst.getString("LonginDec"),rst.getString("TheFieldSubject")) %></div></td>
			</tr>
			<%
			i++;
			} %>	
			</table>
			<%
			}catch(Exception e)
			{
				out.print("Exception--->"+e);
			}
			%>
			<% fleetview.closeConnection(); %>
			</jsp:useBean>
			
        <%@ include file="footernew.jsp" %>
   