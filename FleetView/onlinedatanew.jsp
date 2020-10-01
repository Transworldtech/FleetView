<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
			<table width="100%" align="center" >
			<tr>
			<td align="center">
			<!-- <div align="left"><font size="3" >Report No: 1.6</font></div>-->
			<font  size="3" ><b>Vehicles On Map</b></font></td>
			</tr>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">The Report Heading Come Here</font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('print.jsp');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excel.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th> <b> Sr. </b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			<th> <b>Heding</b></th>
			</tr>		
				<tr>
			<td> 1</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			<td> data</td>
			</tr>	
				<tr>
			<td> 2 </td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			<td> data1</td>
			</tr>	
			<tr>
			<td> 3 </td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			<td> data2</td>
			</tr>	
			<tr>
			<td> 4 </td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			<td> data3</td>
			</tr>	
			<tr class="sortbottom">
			<td colspan="2" class="hed"> Total :</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			<td class="hed"> val</td>
			</tr>	
			</table>
			<% fleetview.closeConnection(); %>
			</jsp:useBean>
        <%@ include file="footernew.jsp" %>
   