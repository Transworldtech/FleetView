
<%@ include file="headernew.jsp" %> 
<%@page import="com.fleetview.beans.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.fleetview.POIClasses.*"%>

<html>
<body>
<table border="0" width="100%" class="stats">
<tr><td>
<!--Main code -->
<table width="100%" align="center" class="sortable_entry">	
	<tr>
	<td>
	
	</td>		
	</tr>
	<tr>
		<td align="center"><B><font size="3">Please select the Excel file/CSV file to import data and then click on Upload</font></B></td>
	</tr>

<tr><td><form name="uploadexcelform" ENCTYPE="multipart/form-data" action="<%=request.getContextPath()%>/UploadTripClosureExcelServlet" method="post">

<div id="imageDiv" align="center">
<input type="file" name="Filename">
               <a href="javascript:document.uploadexcelform.submit();" class="btnLeft" ><span class="btnRight"><font size="3">Upload</font></span></a>
	
</div>

</form>
</td>
</tr><br></br><br></br><tr><td>&nbsp; &nbsp; &nbsp; &nbsp;</td></tr>
<tr><td align="right"><div align="right"><font size=1>Click on below image to download Excel Format for Trip Data</font>
&nbsp; &nbsp;<a href="tripclosuredownloadexcel.jsp?file=TripClosureData.xls" title="Get Excel Fromat">
		<img src="images/excel.jpg" width="20px" height="20px" alt="Click here to download">
		</a>
</div>
</td></tr>
</table>
</table>
</td>
</tr>
<br>
<br>

</body>

</html>