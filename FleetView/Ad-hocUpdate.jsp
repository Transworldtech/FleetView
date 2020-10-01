<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
 <link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link> 
<link href="css/css.css" rel="StyleSheet" type="text/css"></link> 
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script> 
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script> 
<link rel="stylesheet" type="text/css" href="css/cpanel_002_popup.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<!-- <link rel="stylesheet" type="text/css" href="css/form.css" media="all"> -->
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;

.popupnew {
background-color: #98AFC7;
position: absolute;
visibility: visible;
}

</style>
<script>
function cancelbutton()
{
	window.close();
}
 function Displayer(n)
 {var check = document.getElementById('Section' + n);
 if(check.style.display == 'none')
 {check.style.display='inline';}
 else{check.style.display='none';}
 }
function formValidation()
{
var displaylabel="";
var displaycount="";
var count3="";
// Mandatorytransworld
// alphatransworld
// charactertransworld
// numbertransworld
// emailtransworld

if(displaylabel == ""){
return true;
}

else{
var displaylabelres = displaylabel.split(",");
var res1=displaycount.split(",");
var res2=count3.split(",");
var i;
var j;

for(j=0; j < res2.length-1; j++){
 document.getElementById("element_error_"+ res2[j]).style.display='none';
 }
 
for (i = 0; i < displaylabelres.length-1; i++) {
    var element_error_="element_error_"+i;
    var number=i;
    document.getElementById("element_error_"+ res1[i]).style.display="";
    document.getElementById("element_error_"+ res1[i]).innerHTML=displaylabelres[i];
} 

 return false;
}
}
</script>
 <%
Connection con1 = null;
Statement stdynamicdrop = null,stmt2=null;
String datenew1="",datenew2="",datenew3="";
String totfuel="0.0";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
stmt2=con1.createStatement();
String sysDate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());


String Rid=request.getParameter("Rid");
String TripID=request.getParameter("TripID");
String Geofence=request.getParameter("Geofence");
String FuelIssueCategory=request.getParameter("FuelIssueCategory");
Geofence=request.getParameter("Geofence");
String FuelQuantity=request.getParameter("FuelQuantity");
String Rate=request.getParameter("Rate");
 %>
<%@ include file="headernew.jsp"%> 
				
<%!String StartDate="";
String VehRegNo="",origin="",destination="",FIxedKM="",GPName="",StartCode="",EndCode="",EndDate="";
%>
<form name="userform" action="Ad-hocexceptionupdate.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>

<div align="center">
<%-- <table width="50%" border="0">
<tr>
<td width="10%">
<table border="0"  width="100%">
<tr align="left">
<td  valign="top" width="0%"><font color="black">  <b> Vehicle:</b><%=VehRegNo %> </font></td>
</tr>
<tr align="left">
<td valign="top"  width="0%"><font color="black"><b>Owner:</b><%=GPName %> </font></td>
</tr>
</table>
</td>
</tr>
</table> --%>
<input type="hidden" name="Rid" id="Rid" value="<%=Rid%>"/>
<input type="hidden" name="TripID123" id="TripID123" value="<%=TripID%>"/>
<input type="hidden" name="FuelIssueCategory" id="FuelIssueCategory" value="<%=FuelIssueCategory%>"/>

</div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<h1 align="center" style="width: 776px; margin-left: 250;"><font size="3">Ad-hoc Entry Master</font></h1>
</tr>
<tr>
<%-- <td>
<label id="element_1" name="element_1"  class="description" for="element_1"><b>Select Date :</b> </label>
<input type="text" id="date1" name="date1"  value="<%=sysDate %>"  class="datetimepicker" style="width: 150px;"   readonly/></td>
 --%>
 </tr> 
<tr><td><br><br></td></tr>
<tr>
	    <td> 
	     <label id="element_1" name="element_1"  class="description" for="element_1"><b>Reason for Request :</b> </label> 
	     <textarea class="element textarea medium" name="loadcmnt" rows="4" cols="35"></textarea>
	     <br><br></td>
	</tr>
</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="Cancel" style="border-style: outset; border-color: black" value="Cancel" onclick="cancelbutton();"  class="button_text" /></div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
 