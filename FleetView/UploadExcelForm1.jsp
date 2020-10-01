<%@ include file="header.jsp" %> 
<%@page import="com.fleetview.beans.dataupload"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator;"%>
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

<tr><td><form name="registrationform1" ENCTYPE="multipart/form-data" action="<%=request.getContextPath()%>/UploadExcelServlet1" method="post">

<div id="imageDiv" align="center">
<input type="file" name="Filename">
               <a href="javascript:document.registrationform.submit();" class="btnLeft" ><span class="btnRight"><font size="3">Upload</font></span></a>
	
</div>

</form>
</td>
</tr>
</table>
</table>

</td>
</tr>
<br>
<br>




</body>

</html>