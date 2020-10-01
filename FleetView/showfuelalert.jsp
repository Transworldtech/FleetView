<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
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
<table width="100%" align="center" class="stats">
			<tr>
			<td align="center" class="sorttable_nosort"><font color="block" size="2" >Fuel Theft Alert Report</font></td>
			</tr>
			<tr><td>
			<!-- if date range is not requred please remove this code start from this comment to -->
			<script language="javascript">
 			function validate()
  			{
  				if(document.getElementById("data").value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById("data1").value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  				}
  				return true;
  		  }
  	</script>
			<table border="0" width="100%" class="sortable_entry">
			<form action="" method="get" onsubmit="return validate();">
			<tr bgcolor="#87CEFA">
			<td align="right"> <B>From &nbsp;&nbsp;</B>
			<input type="hidden" name="vehcode" id="vehcode" value="<%=vehcode %>">
			  <input type="text" id="data" value="<%=fromdate %>" name="data"  size="15" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
<!--  			<td align="left">-->
<!--				<input type="button" name="From Date" value="From Date" id="trigger" >-->
<!--			-->
<!--			</td>-->
			<td align="right"> <B>To &nbsp;&nbsp;</B>
			  	<input type="text" id="data1" name="data1" value="<%=todate %>"   size="15" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "data1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
			  	
<!--			  	<td align="left">-->
<!--  			  	<input type="button" name="To Date" value="To Date" id="trigger1" >-->
<!--				-->
<!--			</td>-->
			<td>
				<input type="submit" name="submit" id="submit" value="submit" >
			</td>
		</tr>
		</form>
		</table>
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
		<%
		vehregno=fleetview.getVehRegNo(vehcode);
		%>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Fuel Theft Alert Report for <%=vehregno %> from <%=fromdate %> to <%=todate %></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('print.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
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
			//sql="select * from t_veh"+vehcode+" where TheFieldDataDate >='"+data+"' and TheFieldDataDate <='"+data1+"' and theFiledTextFileName='FT' order by concat(TheFieldDataDate,TheFieldDataTime) desc";
			sql="select * from t_vehft where vehcode like '"+vehcode+"' and Thedate>='"+data+"' and TheDate <='"+data1+"' order by concat(TheDate,TheTime) desc";
			ResultSet rst=st.executeQuery(sql);
			int i=1;
			while(rst.next())
			{
				/*prevlevel=Integer.parseInt(fleetview.getPrevFuelLevel(vehcode,rst.getString("TheFieldDataDate"),rst.getString("TheFieldDataTime")));
				currentlevel=rst.getInt("FuelLevel");
				diff=prevlevel-currentlevel;*/
				prevlevel=rst.getInt("Prevlevel");
				currentlevel=rst.getInt("Currlevel");
				diff=rst.getInt("Diff");
			%>	
			<tr>
			<td style="text-align: right"> <%=i %></td>
			<td style="text-align: left"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate")) %> <%=rst.getString("TheTime") %></td>
			<td style="text-align: left"> <%=fleetview.showNewMap(rst.getString("latitude"),rst.getString("longitude"),rst.getString("location")) %></td>
			<td> <div align="right"><%= prevlevel %> </div></td>
			<td> <div align="right"><%= currentlevel %> </div></td>
			<td><div align="right"><%= diff %></div></td>
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

<% //fleetview.closeConnection(); %>
			</jsp:useBean>
<%@ include file="footernew.jsp" %>