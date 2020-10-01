<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">DMC Standard Option Entry</font></h3>
</head>
<script type="text/javascript">

function add()
{
	try{
	//alert("Hii");
	//alert("in attach ");
	
		
var cnt=document.incident.counter.value;
//alert("351 count "+cnt);
if(cnt>0)
{
	//alert("count "+cnt);
}
else 
{
cnt=1;
var flagvalue=document.incident.flagvalue.value;
flagvalue++;
document.incident.flagvalue.value=flagvalue;
//alert(cnt);
document.incident.counter.value=cnt;

       document.getElementById("tr1").style.display="";   	
       document.incident.Filename1.style.display="";
      // document.incident.Filename1.value="";
      //document.getElementById("imageDiv").innerHTML="";
       document.getElementById("imageDiv").style.display="none";
     //  document.incident.Upload.style.display="";  
       document.getElementById("tr2").style.display="";   
}
	}catch(e)
	{
		alert(e);
	}
}

function add1()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach1 ");
	
	document.getElementById("tr5").style.display="";  
	document.incident.Filename2.style.display="";
	//document.getElementById("imageDiv1").innerHTML="";
    document.getElementById("imageDiv1").style.display="none" 	
    document.getElementById("tr2").style.display="none"; 
    document.getElementById("tr6").style.display="";  
}
function add2()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach2 ");
	document.getElementById("tr7").style.display="";   
	document.incident.Filename3.style.display="";
	//document.getElementById("imageDiv2").innerHTML="";
    document.getElementById("imageDiv2").style.display="none"	
    document.getElementById("tr6").style.display="none"; 
    document.getElementById("tr8").style.display="";  
}
function add3()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach3 ");
	document.getElementById("tr9").style.display="";   
	document.incident.Filename4.style.display="";
	//document.getElementById("imageDiv3").innerHTML="";
    document.getElementById("imageDiv3").style.display="none"	
    document.getElementById("tr8").style.display="none"; 
    document.getElementById("tr10").style.display="";  
}
function add4()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach4 ");
	document.getElementById("tr11").style.display="";
	document.incident.Filename5.style.display="";
	//document.getElementById("imageDiv4").innerHTML="";
    document.getElementById("imageDiv4").style.display="none"   	
    document.getElementById("tr10").style.display="none"; 
    document.getElementById("tr12").style.display="";  
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}
function add5()
{
	var cnt=document.incident.counter.value;
	cnt++;
//	alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach5 ");
	document.getElementById("tr13").style.display="";  
	document.incident.Filename6.style.display="";
	//document.getElementById("imageDiv5").innerHTML="";
    document.getElementById("imageDiv5").style.display="none" 	
    document.getElementById("tr12").style.display="none"; 
    document.getElementById("tr14").style.display="";  
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}
function add6()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach6 ");
	document.getElementById("tr15").style.display="";   
	document.incident.Filename7.style.display="";
	//document.getElementById("imageDiv6").innerHTML="";
    document.getElementById("imageDiv6").style.display="none"	
    document.getElementById("tr14").style.display="none"; 
    document.getElementById("tr16").style.display="";  
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}
function add7()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach7 ");
	document.getElementById("tr17").style.display="";  
	document.incident.Filename8.style.display="";
	//document.getElementById("imageDiv7").innerHTML="";
    document.getElementById("imageDiv7").style.display="none" 	
    document.getElementById("tr16").style.display="none"; 
    document.getElementById("tr18").style.display="";  
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}
function add8()
{
	var cnt=document.incident.counter.value;
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach8 ");
	document.getElementById("tr19").style.display="";   
	document.incident.Filename9.style.display="";
	//document.getElementById("imageDiv8").innerHTML="";
    document.getElementById("imageDiv8").style.display="none"	
    document.getElementById("tr18").style.display="none"; 
    document.getElementById("tr20").style.display="";  
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}
function add9()
{
	var cnt=document.incident.counter.value;
	
	cnt++;
	//alert(cnt);
	document.incident.counter.value=cnt;
	//alert("in attach9 ");
	document.getElementById("tr21").style.display="";  
	document.incident.Filename10.style.display="";
	//document.getElementById("imageDiv9").innerHTML="";
    document.getElementById("imageDiv9").style.display="none" 	
    document.getElementById("tr20").style.display="none"; 
    
   // document.write("<tr align='center' id='tr23' style='' bgcolor='#FFF6F7'><td><div id='imageDiv' align='center'><font color='maroon' size='2'><b></b></font></div></td><td><input type='file' cols='40' name='Filename' value=''></td></tr>");
}

 

</script>
<%
String lat="",lon="",category="",subcategory="",wtype="",options="";
category=request.getParameter("category");
subcategory=request.getParameter("subcategory");
 options=request.getParameter("options");
  //loc="",loc1="",wtype="";
%>
<%
//lat=request.getParameter("lati");
//lon=request.getParameter("langi");
String flag2=request.getParameter("flag");
String Msg=request.getParameter("Msg");
//System.out.println("-- flag2 --"+flag2);
if(flag2!=null && flag2.equalsIgnoreCase("true"))
{
	%>
	<script>
	alert("Record is successfully Updated.");
	//loc="",loc1="",wtype="";
	opener.Reload();
	window.close();
	</script>
	
	<%
	flag2=null;
}
else if(flag2!=null && flag2.equalsIgnoreCase("false"))
{	
	%>
	<script>
	alert("Please do some changes in fields...!" );
	</script>
	<%
	category=request.getParameter("category");
	subcategory=request.getParameter("subcategory");
	options=request.getParameter("options");
}
else if(Msg!=null)
{
	%>
	<script>
	alert(Msg);
	
	</script>
	<%
	category=request.getParameter("category");
	subcategory=request.getParameter("subcategory");
	wtype=request.getParameter("wtype");
}

%>
<body bgcolor="#F7F2E0">
<form action="" name="formupdate" method="post">

<table align="center" bgcolor="#e3e9ff" width="100%">

<tr id="trb">
        <td><font size="2" color="black"><b>AddCategory</b></font></td>
        
	<td><font size="2" color="black"><b>AddSubCategory</b></font></td>
	<td><font size="2" color="black"><b>AddOptions</b></font></td>
	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>

	</tr>
	<tr>
        <td><input size="12" type="text" name="geo" id="geo" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

		<td><input size="12" type="text" name="geo1" id="geo1" value="<%=""%>"></td>

<!--<td style="size: 4"><a href="#"  id="tdz" shape="rect">Add New</a></td>-->

	</tr>
	
	 
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="button" name="btn3" id="btn3" value="Save" onclick="geoUpdate();">
	 </td>		
	</tr>
	

</table>
</form>
</body>
</html>