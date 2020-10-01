<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">Add New Geofence Location</font></h3>
</head>
<script type="text/javascript">
function geoAdd(lat,lon)
{
try{
	
	//alert('add fun is called');
	//alert(document.getElementById("lati").value);
	//alert(document.getElementById("langi").value);
	//alert(document.getElementById("add").value);
	//alert(document.getElementById("addcode").value);
	//alert(document.getElementById("WType1").value);
	//var lati=document.getElementById("lati").value;
	//var langi=document.getElementById("langi").value;
	var warehouse=document.getElementById("add").value;
	var warehousecode=document.getElementById("addcode").value;
	var WType1=document.getElementById("WType1").value;
   var fpage=document.getElementById("fpage1").value;
	//var polygonCoords = document.getElementById("cordonatestoasave").value;
//alert(polygonCoords);
	//alert(var polygonCoords);
	if((lat==null)||(lat=="") || (lon==null)||(lon==""))
	{
		lat="-";
		lon="-";
		//alert("Please Single click on the map then fill the details..!!!");
	//	return 0;
	}
	if((warehouse=="")||(warehouse==null)||(warehouse=="-"))
	{
		alert("Please enter new Geofence Location..!!!");
		return 0;
	}
	if((warehousecode=="")||(warehousecode==null)|(warehousecode=="-"))
	{
		alert("Please enter new Geofence Location Code..!!!");
		return 0;
	}
	 
	if(WType1=="Select")
	{
		alert("Please Select Location Type..!!!");
		return 0;
	}
	//document.form1.action="getGeoLocAdd.jsp?lati="+lati+"&langi="+langi+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType;
	document.formadd.action="getGeoLocAdd.jsp?lati="+lat+"&langi="+lon+"&warehouse="+warehouse+"&warehousecode="+warehousecode+"&WType="+WType1+"&fpage="+fpage;
	document.formadd.submit();
}catch(e)
{alert(e);
}
}


</script>
<%
try
{
String lat="",lon="";
lat=request.getParameter("lati");
lon=request.getParameter("langi");
String fpage1=request.getParameter("fpage1");
String flag2=request.getParameter("flag2");
String Msg=request.getParameter("Msg");
//System.out.println("-- flag2 --"+flag2);
if(flag2!=null && flag2.equalsIgnoreCase("true"))
{
	%>
	<script>
	var fpage="<%=fpage1%>";
		//alert(fpage);
	try{
	alert("Record is successfully Added.");
	if("detail_custom_report.jsp"==fpage)
	{
	window.close();
	}
	else 
		if("getalllatlong1.jsp"==fpage)
		{
			opener.Reload();
			window.close();
	  }
	else
	{
		opener.Reload1();
		window.close();
}
	}catch(e)
	{alert(e);}
	</script>
	<%
	flag2=null;
}
else if(flag2!=null && flag2.equalsIgnoreCase("false"))
{	
	%>
	<script>
	alert("Same record is already present.Please enter diffrent values." );
	</script>
    <%
   // lat=request.getParameter("lati");
   // lon=request.getParameter("langi"); 
}
else if(Msg!=null)
{
	%>
	<script>
	alert(Msg);
	</script>
	 lat=request.getParameter("lati");
     lon=request.getParameter("langi"); 
	<%
}

%>
<body bgcolor="#F7F2E0">
<form action="" name="formadd" method="post">
<table align="center" bgcolor="#e3e9ff">

<tr id="trb">
        <td><font size="2" color="black"><b>Geofence Location Name </b></font></td>
        <td><input type="text" name="add" id="add" value=""></td>
</tr>
<tr id="trc">
		<td><font size="2" color="black"><b>Geofence Location Code </b></font></td>
		<td><input type="text" name="addcode" id="addcode" value=""></td>
	</tr>
	<tr id="trd">
		<td><font size="2" color="black"><b>Location Type </b></font></td>
		<td><select name="WType1" id="WType1">
			<option value="Select" selected="selected">Select</option>
			<option value="-">-</option>
			<option value="WH">WH</option>
			<option value="Zone">Zone</option>
			<option value="BusinessUnit">BusinessUnit</option>
			<option value="Office">Office</option>
			<option value="HUB">HUB</option>
			<option value="Plant">Plant</option>
			<option value="Depot">Depot</option>
			<option value="POI">POI</option>
		</select></td>
	</tr>	 
	<tr id="tri">
	<td colspan="2" align="center">
	<input type="hidden" name="fpage1" id="fpage1" value="<%=fpage1 %>"></input>
	<input type="button" name="btn3" id="btn3" value="Add Location" onclick="javascript:geoAdd(<%=lat %>,<%=lon%>);">
	 </td>		
	</tr>

</table>
</form>
</body>
<%

}
catch(Exception e)
{
	System.out.println(e);
	e.printStackTrace();
	
}

%>
</html>