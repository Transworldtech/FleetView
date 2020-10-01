<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">Delete Geofence Location</font></h3>
</head>
<script type="text/javascript">
function geoDelete()
{
try{
	
	//alert('in side update ');
	var loc=document.getElementById("geo").value;
	var loc1=document.getElementById("geo1").value;
	//var oldloc=document.getElementById("oldgeo").value;
	//var oldloc1=document.getElementById("oldgeo1").value;
	var wtype=document.getElementById("WType1").value;
	//var oldwtype=document.getElementById("oldwtype").value;
	
	//alert(wtype);
	if((loc==null)||(loc=="")||(loc1==null)||(loc1==""))
	{
		alert("Please select the location to be Deleted..!!!");	
		return 0;
	}
	document.formdelete.action="getGeoLocDel.jsp?loc="+loc+"&loc1="+loc1+"&wtype="+wtype; //+"&wtype="+wtype;
	document.formdelete.submit();	
}catch(e)
{alert(e);
}
}
 

</script>
<%
String lat="",lon="",loc="",loc1="",wtype="";
 loc=request.getParameter("oldloc");
 loc1=request.getParameter("oldloc1");
wtype=request.getParameter("oldwtype");
  //loc="",loc1="",wtype="";
%>
<%
//lat=request.getParameter("lati");
//lon=request.getParameter("langi");
String flag2=request.getParameter("flag1");
//String Msg=request.getParameter("Msg");
//System.out.println("-- flag2 --"+flag2);
if(flag2!=null && flag2.equalsIgnoreCase("true"))
{
	%>
	<script>
	alert("Record is successfully Deleted.");
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
	alert("Please select the record to be deleted...!" );
	</script>
	<%
	loc=request.getParameter("loc");
	loc1=request.getParameter("loc1");
	wtype=request.getParameter("wtype");
}
/*else if(Msg!=null)
{*/
	%>
	<script>
	//alert(Msg);
	
	</script>
	<%
	/*loc=request.getParameter("loc");
	loc1=request.getParameter("loc1");
	wtype=request.getParameter("wtype");
}*/
if(null==loc||null==loc1||loc.equalsIgnoreCase("")||loc1.equalsIgnoreCase(""))
{
	loc="";
	loc1="";
}

%>
<body bgcolor="#F7F2E0">
<form action="" name="formdelete" method="post">
<table align="center" bgcolor="#e3e9ff">

<tr id="trb">
        <td><font size="2" color="black">Location Name </font></td>
        <td><input type="text" name="geo" id="geo" value="<%=loc%>" readonly="readonly"></td>
</tr>
<tr id="trc">
		<td><font size="2" color="black">Location Code </font></td>
		<td><input type="text" name="geo1" id="geo1" value="<%=loc1%>" readonly="readonly"></td>
		<!-- <input type="hidden" name="oldgeo" id="oldgeo" value=< %=loc%>>
		<input type="hidden" name="oldgeo1" id="oldgeo1" value=< %=loc1%>>-->
	</tr>
	<tr id="trd">
		<td><font size="2" color="black">Location Type </font></td>
		<td><input type="text" name="WType1" id="WType1" value="<%=wtype%>" readonly="readonly"></td>
		<!-- <select name="WType1" id="WType1">-->
		<!-- <input type="hidden" name="oldwtype" id="oldwtype" value=< %=wtype %>></td>-->
	</tr>	 
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="button" name="btn3" id="btn3" value="Delete Location" onclick="geoDelete();">
	 </td>		
	</tr>

</table>
</form>
</body>
</html>