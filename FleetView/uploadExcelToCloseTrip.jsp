
<%@page import="com.fleetview.beans.DisplayData1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>

<%@ include file="headernew.jsp" %> 
<html>
<body>
<table border="0" width="100%" bgcolor="white">
<tr><td>
<!--Main code -->
<table width="100%" align="center">	
	<tr>
	<td>
	
	
	</td>		
	</tr>
	<tr>
		<td align="center"><B><font size="3">Please select the Excel file to import data and then click on Upload</font></B></td>
	</tr>
<%
System.out.println("before file"+request.getContextPath());
%>
<tr><td><form name="registrationform" ENCTYPE="multipart/form-data" action="<%=request.getContextPath()%>/UploadExcelServet1" method="post">
<%
System.out.println("after file");
%>
<div id="imageDiv" align="center">
<input type="file" name="Filename">
               <a href="javascript:document.registrationform.submit();" class="btnLeft" ><span class="btnRight"><font size="3">Upload</font></span></a>
	
</div>

</form>
</td>
</tr><br></br><br></br><tr><td>&nbsp; &nbsp; &nbsp; &nbsp;</td></tr>
<tr><td align="right"><font size=2>Click on below image to download Excel Format for Trip Data</font>
<div>&nbsp; &nbsp;<a href="createExcelForTripClose.jsp?file=TripData.xls" title="Get Excel Fromat">
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