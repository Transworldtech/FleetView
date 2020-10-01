<%@ include file="headernew.jsp"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

onload=function()
{
	document.getElementById("trans").value="Select";
};

function Reload()
{
	//alert("Hej");  
    window.location.reload(); 
}
function downloadExcelFormat()  
{  
	     window.location = "Driver_Incentive_Payment.xls";
         
}

function confirmSubmit()
{
	
	var fup = uploadTask.file.value;
	var ext = fup.substring(fup.lastIndexOf('.') + 1);

//alert(">>"+fup+">>>>"+ext);
    if(ext =="xls")
    {
      // return true;
    }
    else
    {
        alert("Please Upload Excel sheet having .xls extention file only");
        return false;
    }
	
var agree=confirm("Are you sure you wish to upload this excel sheet?");
if (agree)
	return true ;
else
	return false ;
}
</script>
</head>

<form name="uploadTask"  method="post" enctype="multipart/form-data"  action="saveexcel.jsp">
<div align="center">
<table border="0" width="" align="center" class="stats" >
<tr><td align="center"><font color="black" size="3"><b><i>Upload Excel Sheet for Driver Incentive Payment</i></b></font></td></tr>
<tr></tr>
<tr>
<td align="center" >

<table border="0" width="80%" align="center" class="sortable_entry">

<tr>
<td></td>
<td align="center" colspan="0" ><font size="2"><b>Download Excel Format</b> </font>
<a href="#" style="font-weight: bold; color: black; " onclick="downloadExcelFormat();">
<img src="images/excel.jpg" style="border-style: none" title="download excel format"></img></a>
</td>
</tr>

<tr>
<td  align="center" bgcolor="#f5f5f5" width=""><font size="2"><b>Browse excel file :</b></font></td><td >
	<INPUT NAME="file" id ="file" TYPE="file" size="20">
</td>
</tr>
<tr><td></td></tr>
<tr>
<td></td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b><input type ="submit"  onclick="return confirmSubmit();" name ="uploadexl" id="uploadexl" value="submit"/></b></font></td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</form>
<%@ include file="footernew.jsp" %>
