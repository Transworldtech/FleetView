<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="Connections/conn.jsp" %>
   <link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">

function validate()
{
 var category=document.getElementById("addcatnew").value;
 var subcategory=document.getElementById("addsubcatnew").value;
 var addoptions=document.getElementById("addnewoption").value;
 var catelen=category.length;
 var subcatlen=subcategory.length;
 var addoptionslen=addoptions.length;
 
 category=category.replace(/\s/g, "");
 subcategory=subcategory.replace(/\s/g, "");
 addoptions=addoptions.replace(/\s/g, "");
 
 var newcategorylen=category.length;
 var newsubcategorylen=subcategory.length;
 var newaddoptionslen=addoptions.length;
 
 var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";

 for (var i = 0; i < category.length; i++) 
	{
			if (iChars.indexOf(category.charAt(i)) != -1) 
		{
		  	alert ("Special Characters are not allowed");
		  	return false;
			}
		}
 
 for (var i = 0; i < subcategory.length; i++) 
	{
			if (iChars.indexOf(subcategory.charAt(i)) != -1) 
		{
		  	alert ("Special Characters are not allowed");
		  	return false;
			}
		}

 ///for (var i = 0; i < addoptions.length; i++) 
//	{
//			if (iChars.indexOf(addoptions.charAt(i)) != -1) 
//		{
	//	  	alert ("Special Characters are not allowed");
	//	  	return false;
	//		}
	//	}

 var letter = /^[A-Za-z]+$/;  
// if(!(category.match(letter)) && category.length!=0)  
 //{  
 //   alert('Please enter characters value for category');  
 //return false;  
 //} 
 if(!(subcategory.match(letter)) && subcategory.length!=0)  
 {  
    alert('Please enter characters value for subcategory');  
 return false;  
 } 

 
// if(!(addoptions.match(letter)) && addoptions.length!=0)  
/// {  
 //   alert('Please enter characters value for options');  
 //return false;  
// } 

// if(catelen!=newcategorylen)
 //{
//	 alert("please enter valid category");
	// return false;
	 
 //}
 if(subcatlen!=newsubcategorylen)
 {
	 alert("please enter valid subcategory without spaces");
	 return false;
	 
 }
 //  if(addoptionslen!=newaddoptionslen)
 //  {
//	   alert("Please enter valid options without spaces");
//	   return false;
 //  }

   if(category=="" || category==null)
   {
  	 alert("Please enter category");
  	 return false;
   }
 
 if(subcategory=="" || subcategory==null)
 {
	 alert("Please enter subcategory");
	 return false;
 }

 if(addoptions=="" || addoptions==null)
 {
	 alert("Please add options");
	 return false;
 }
	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">DMC Standard Option Entry</font></h3>
</head>



<body bgcolor="#F7F2E0" >
<%!
Connection conn,conn1;
Statement st;
String ReportName="",Description="",Entby="",Name="",EmailID="",Email1="",FileName="",Category="";
String Priority="",ClosingComments="",ClosedBy="",Status="";

String ContactNumber="";

%>
<%
Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
st=conn.createStatement();
%>
<%
String lat="",lon="",category="",subcategory="",wtype="",options="",oldcategory="",oldsubcategory="",oldoptions="";
category=request.getParameter("category");
subcategory=request.getParameter("subcategory");
options=request.getParameter("options");
System.out.println("category   "  +category);
System.out.println("subcategory  "  +subcategory);
System.out.println("options   "  +options);
String updat=request.getParameter("param");
String updat1=request.getParameter("Parameter1");
String updat2=request.getParameter("Parameter2");
if(updat!=null)
{
	%>
	<script type="text/javascript">
	alert("Record updated successfully");
	//window.opener.location.reload();
	window.close();


	</script>
	<% 
	
}
if(updat1!=null)
{
	%>
	<script type="text/javascript">
	alert("No Changes made");
	//window.location="Standardedit.jsp";
//	window.opener.location.reload();
	//window.close();


	</script>
	<% 
	
}
if(updat2!=null)
{
	%>
	<script type="text/javascript">
	alert("Record already exist");
	//window.location="Standardedit.jsp";
//	window.opener.location.reload();
//	window.close();


	</script>
	<% 
	
}


%>

<form action="Standardeditoption.jsp" name="formupdate" method="post" onsubmit="return validate();">
<input type="hidden" name="categorysend" id="categorysend" value="<%=category %>"></input>
<input type="hidden" name="subcategorysend" id="subcategorysend" value="<%=subcategory %>"></input>
<input type="hidden" name="optionssend" id="optionssend" value="<%=options %>"></input>
<table align="center" bgcolor="#e3e9ff">

<tr id="trc">
<td><font size="2" color="black"><b>OldCategory</b></font></td>
		<td style="font-size: 15"><div style="width: 100px;"><input style="width: 180px;" type="text" name="OldCategory" id="OldCategory"  value="<%=category%>" readonly class="element text medium"></div></td>
	<td><font size="2" color="black"><b>AddCategory</b></font></td>
		<td style="font-size: 15"><input style="width: 180px;" type="text" name="addcatnew" id="addcatnew" value="<%=category %>" readonly="readonly" class="element text medium"></td>
	</tr>

<tr id="trc">
<td><font size="2" color="black"><b>OldSubCategory</b></font></td>
		<td style="font-size: 15"><input style="width: 180px;" type="text" name="OldSubCategory" id="OldSubCategory"  value="<%=subcategory%>" readonly class="element text medium"></td>
	<td><font size="2" color="black"><b>AddSubCategory</b></font></td>
		<td style="font-size: 15"><input style="width: 180px;" type="text" name="addsubcatnew" id="addsubcatnew" class="element text medium"></td>
	</tr>
	<tr id="trc">
	<td><font size="2" color="black"><b>OldInput</b></font></td>
		<td style="font-size: 15"><input style="width: 180px;" type="text" name="oldoption" id="oldoption" value="<%=options%>" readonly class="element text medium"></td>
		<td><font size="2" color="black"><b>AddInput</b></font></td>
		<td style="font-size: 15"><input style="width: 180px;" type="text" name="addnewoption" id="addnewoption" class="element text medium"></td>
	</tr>
	
	
	 
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="submit" name="submit" id="submit" value="update"  style="border-style: outset; border-color: black" >
	 </td>		
	</tr>

</table>
</form>
</body>
</html>