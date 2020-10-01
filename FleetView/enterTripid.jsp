<%@page import="com.fleetview.beans.TripClosureData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css" media="all">
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css" media="all">

<title>Insert title here</title>
</head>
<script language="javascript">

function OpenE()
{
	window.opener.location.reload();
	window.close();
}
function OpenE1()
{
	window.close();
	

}

function validate()
{
	  var myData =document.getElementById("tripid").value;
	if(myData=="" || myData==null)
		{	alert("Please enter trip id");
			return false;
		}
		
		return true;
		
}
</script>

	<img id="top" src="newimages/top.png" alt="">

	<div id="form_container">
	

<body>
<%
String msg = "";

String Briefid="",tripid="",Driverid="",DriverName="";	
try{
 msg = request.getParameter("msg");
 }
catch(Exception e)
{
	e.printStackTrace();
}
if(null==msg||("null").equalsIgnoreCase(msg)||"".equalsIgnoreCase(msg)){
	%>
	<form action="inserttripid.jsp"  onSubmit="return validate();" method="get">
	<table class="stats" width="80%" >
	<tr>
	<%
	String TripId="",brifid="";
	try{
	TripId=request.getParameter("CurrTripId");
	
	
	}
	catch(Exception e)
	{

	}
	%>
	<td>Current TripId :</td>
	<td><label id ="Oldtripid" name="Oldtripid" size="8" ><%=TripId %></label>
	</td>
	</tr>
	<tr>
	
	<td>Enter TripId:</td>
	<td><input type="text" id ="tripid" name="tripid" size="15"></input></td>
	
	</tr>
	<tr >
	<td rowspan="2" align="right"><input type="submit" value="Submit" name="Submit"></input>


	<input type="hidden" id ="frompage" name="frompage" value="<%=request.getParameter("rdpassport")%>"></input>
	<input type="hidden" id ="briefdate" name="briefdate" value="<%=request.getParameter("briefdate")%>"></input>
	<input type="hidden" id ="debrifdate" name="debrifdate" value="<%=request.getParameter("debrifdate")%>"></input>
	<input type="hidden" id ="brifId" name="brifId" value="<%=request.getParameter("brifId")%>"></input>
	<input type="hidden" id ="OldTripId1" name="OldbrifId1" value="<%=request.getParameter("CurrTripId")%>"></input>
	</td>
	</tr>
	</table>
	</form>
	<%
	
}
else if("inserted".equalsIgnoreCase(msg)){
	System.out.println(msg);
	%>
	<table align="center">
	<tr><td align="center" ><font color="maroon">Inserted Successfully</font></td></tr>
	<tr>
	<td align="center">
	<input type="button" class="button_text" style="border-style: outset; border-color: black" value="CLose" onclick="OpenE();" />
	</td>
	</tr>
	
	</table>
	<script language="javascript">
	onunload=function(){
		window.opener.location.reload();
	}
	
	</script>
	<%
}
else if("alreadypresent".equalsIgnoreCase(msg)){
	
	
	Briefid=request.getParameter("Briefid");
	tripid=request.getParameter("tripid");
	Driverid=request.getParameter("Driverid");
	DriverName=request.getParameter("DriverName");
	%>
	<table align="center">
<!-- 	<tr><td align="center" ><font color="maroon">***TripId already present***</font></td></tr> -->
	<tr><td align="left" ><font color="maroon" size="3">Trip Id: "<%=tripid%>" already present with Driver ID: "<%=Driverid %>" and <br> Driver Name: "<%=DriverName %>" and Brief ID: "<%=Briefid %>".<br> Kindly Check Trip ID as both Drivers Can't have same trip ID.
</font></td>
	<td align="center"></tr>	
	<tr><td align="center"><div align="center">
	<input type="button" class="button_text" style="border-style: outset; border-color: black" value="Close" onclick="OpenE1();" />
	</div>
	</td>
	</tr>
	</table>
	<%
}
%>
</body>
</div>

</html>