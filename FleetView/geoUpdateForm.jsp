<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">Update Geofence Location</font></h3>
</head>
<script type="text/javascript">
function geoUpdate()
{
try{
	
	//alert('in side update ');
	var loc=document.getElementById("geo").value;
	var loc1=document.getElementById("geo1").value;
	var oldloc=document.getElementById("oldgeo").value;
	var oldloc1=document.getElementById("oldgeo1").value;
	var wtype=document.getElementById("WType1").value;
	var oldwtype=document.getElementById("oldwtype").value;
	
	//alert("loc "+loc);
	//alert("loc1 "+loc1);
	//alert("oldloc "+oldloc);
	//alert("oldloc1 "+oldloc1);
	//alert("wtype "+wtype);
	//alert(oldwtype);
	
	if((loc==null)||(loc=="")||(loc=="-")||(loc1==null)||(loc1=="")||(loc1=="-"))
	{
		alert("Please select the location to be Update..!!!");	
		return 0;
	}
	document.formupdate.action="getGeoLocUpdate.jsp?loc="+loc+"&loc1="+loc1+"&oldloc="+oldloc+"&oldloc1="+oldloc1+"&wtype="+wtype+"&oldwtype="+oldwtype; //+"&wtype="+wtype;
	document.formupdate.submit();	
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
	loc=request.getParameter("loc");
	loc1=request.getParameter("loc1");
	wtype=request.getParameter("wtype");
}
else if(Msg!=null)
{
	%>
	<script>
	alert(Msg);
	
	</script>
	<%
	loc=request.getParameter("loc");
	loc1=request.getParameter("loc1");
	wtype=request.getParameter("wtype");
}

%>
<body bgcolor="#F7F2E0">
<form action="" name="formupdate" method="post">
<table align="center" bgcolor="#e3e9ff">

<tr id="trb">
        <td><font size="2" color="black"><b>Location Name</b></font></td>
        <td><input type="text" name="geo" id="geo" value="<%=loc%>"></td>
</tr>
<tr id="trc">
		<td><font size="2" color="black"><b>Location Code</b></font></td>
		<td><input type="text" name="geo1" id="geo1" value="<%=loc1%>"></td><input type="hidden" name="oldgeo" id="oldgeo" value="<%=loc%>">
		<input type="hidden" name="oldgeo1" id="oldgeo1" value="<%=loc1%>">
	</tr>
	<tr id="trd">
		<td><font size="2" color="black"><b>Location Type</b></font></td>
		<td><select name="WType1" id="WType1">
		<%
		if(wtype==null||(wtype.equalsIgnoreCase("")))
		{
			%>
			<option value="Select" selected="selected">Select</option>
			<%
			
		}
		else{
			%>
			<option value="<%=wtype %>" selected="selected"><%=wtype %></option>
			<%
		}
			%>
			
			<option value="-">-</option>
			<option value="WH">WH</option>
			<option value="Zone">Zone</option>
			<option value="BusinessUnit">BusinessUnit</option>
			<option value="Office">Office</option>
			<option value="HUB">HUB</option>
			<option value="Plant">Plant</option>
			<option value="Depot">Depot</option>
			<option value="POI">POI</option>
		</select><input type="hidden" name="oldwtype" id="oldwtype" value="<%=wtype %>"></td>
	</tr>	 
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="button" name="btn3" id="btn3" value="Update" onclick="geoUpdate();">
	 </td>		
	</tr>

</table>
</form>
</body>
</html>