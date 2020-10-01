<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.transworld.common.exportFramework.ExcelExportData"
	import="com.transworld.common.exportFramework.ExcelExportable"
	import="com.transworld.common.exportFramework.ExcelExportableColumn"
	import="com.transworld.common.exportFramework.ExcelExportableRow"
	import="java.util.List" import="java.text.*"%>
<%
	response.setContentType("application/vnd.ms-excel");
	final Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	final String showdatex = formatterx.format(new java.util.Date());
	final String filename = session.getAttribute("user").toString()
			+"_currentposition.xls";
	response.addHeader("Content-Disposition", "attachment;filename=_currentposition.xls");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	/// There can be many Session Variables, hence the name of session variable to be fetched will be sent in request
	final ExcelExportable excelExportable = (ExcelExportable) session
			.getAttribute(request.getParameter("sessiondata"));
	// session.getAttribute(request.getParameter("sessiondata"));

	/// This is like status "Disconnected" etc sent by the calling page
	final ExcelExportData excelData = excelExportable
			.getExcelExportData(request.getParameter("key"));

	/// If Show Trip Info was clicked by user, there will be "ShowTripInfo" etc, to be sent by calling page
	final List<ExcelExportableColumn> columns = excelData
			.getVisibleColumns(request.getParameter("condition"));
	int i = 1;

	String key = "";
	if (request.getParameter("key").equalsIgnoreCase("ALL")) {
		key = "Current Position of";
	} else {
		key = request.getParameter("key");
	}
	/// print visible columns
%>
<html>
<body>
<table width="100%" align="center">
	<tr>
		<td align="center"><font size="3" ><b><%=key%> Vehicles</b></font></td>
	</tr>
</table>
<table width="100%">

	<tr>
		<th>Sr.</th>
		<%
			for (ExcelExportableColumn column : columns) {
		%>
		<th><%=column.getName()%></th>
		<%
			}
		%>
	</tr>
	<%
		/// now fetch all rows
		final List<ExcelExportableRow> rows = excelData.getVisibleRows();
		for (ExcelExportableRow row : rows) {
	%>
	<tr>
		<td><%=i%></td>
		<%
			for (ExcelExportableColumn column : columns) {
					/// print this record 0n excel -->
		%>
		<td><%=row.getCellValue(column)%></td>
		<%
			}
		%>
	</tr>
	<%
		i++;
		}
	%>

</table>
<table border="1" width="100%" align="center">
	<tr>
		<td bgcolor="#ccc" class="copyright" width="100%">
		<center>Copyright &copy; 2008 by Transworld Compressor
		Technologies Ltd. All Rights Reserved.</center>
		</td>
	</tr>
</table>
</body>
</html>