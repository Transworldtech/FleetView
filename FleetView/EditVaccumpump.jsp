<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/Fleetview.css" rel="stylesheet" type="text/css"></link>
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
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script> 
<jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page">
<script>
function formValidation()
{
var displaylabel="";
var displaycount="";
var count3="";
if((element_3_1.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='1,';
}if((element_3_2.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='2,';
}if((element_3_7.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='7,';
}if((element_3_8.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='8,';
}// Mandatorytransworld
if(!(element_3_1.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_1.value.match(letters))
{
count3+='1,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='1,';
}
}if(!(element_3_2.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_2.value.match(letters))
{
count3+='2,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='2,';
}
}if(!(element_3_3.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_3.value.match(letters))
{
count3+='3,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='3,';
}
}else{count3+='3,';}if(!(element_3_4.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_4.value.match(letters))
{
count3+='4,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='4,';
}
}else{count3+='4,';}if(!(element_3_5.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_5.value.match(letters))
{
count3+='5,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='5,';
}
}else{count3+='5,';}if(!(element_3_6.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_6.value.match(letters))
{
count3+='6,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='6,';
}
}else{count3+='6,';}if(!(element_3_7.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_7.value.match(letters))
{
count3+='7,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='7,';
}
}if(!(element_3_8.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_8.value.match(letters))
{
count3+='8,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='8,';
}
}if(!(element_3_9.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_9.value.match(letters))
{
count3+='9,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='9,';
}
}else{count3+='9,';}if(!(element_3_10.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_10.value.match(letters))
{
count3+='10,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='10,';
}
}else{count3+='10,';}if(!(element_3_11.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_11.value.match(letters))
{
count3+='11,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='11,';
}
}else{count3+='11,';}if(!(element_3_12.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_12.value.match(letters))
{
count3+='12,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='12,';
}
}else{count3+='12,';}if(!(element_3_13.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_13.value.match(letters))
{
count3+='13,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='13,';
}
}else{count3+='13,';}if(!(element_3_14.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_14.value.match(letters))
{
count3+='14,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='14,';
}
}else{count3+='14,';}if(!(element_3_15.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_15.value.match(letters))
{
count3+='15,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='15,';
}
}else{count3+='15,';}if(!(element_3_16.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_16.value.match(letters))
{
count3+='16,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='16,';
}
}else{count3+='16,';}if(!(element_3_17.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_17.value.match(letters))
{
count3+='17,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='17,';
}
}else{count3+='17,';}// alphatransworld
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
Statement stdynamicdrop = null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
%>
<%


String VehRegNo=request.getParameter("VehRegNo");
String Rid2=request.getParameter("Rid2");
String VehId=request.getParameter("VehId");
String no_four_way_valve=request.getParameter("no_four_way_valve");
String weight=request.getParameter("weight");
String no_of_VRV=request.getParameter("no_of_VRV");
String no_of_NRV=request.getParameter("no_of_NRV");
String installation=request.getParameter("installation");
String rid=request.getParameter("rid");
String make1=request.getParameter("make1");
String Capacity=request.getParameter("capacity");
String model=request.getParameter("model");
String oilgrade1=request.getParameter("oilgrade1");
String oilcapacity1=request.getParameter("oilcapacity1");
String serialnumber1=request.getParameter("serialnumber1");
String drive=request.getParameter("drive");
String type1=request.getParameter("type1");
String jettingpressurepump1=request.getParameter("jettingpressurepump1");
String rotation=request.getParameter("rotation");
String cooler=request.getParameter("cooler");
String power=request.getParameter("power");

%>

<%@ include file="headernew.jsp"%> 
<form name="userform" action="EditVaccumpumpinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Vacuum Pump</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Make</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value="<%=make1%>"/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Model</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value="<%=model%>"/><br><label id="element_error_2"></label><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Type</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=type1%>"/><br><label id="element_error_3"></label><br><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Capacity</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value="<%=Capacity%>"/><br><label id="element_error_4"></label><br><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Grade</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value="<%=oilgrade1%>"/><br><label id="element_error_5"></label><br><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Capacity</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value="<%=oilcapacity1%>"/><br><label id="element_error_6"></label><br><br><br><!--3,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Serial Number</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value="<%=serialnumber1%>"/><br><label id="element_error_7"></label><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Vaccum Pressure Rating</b> </label><input id="element_3_8" name="element_3_8"  class="element text medium" type="text"  value="<%=jettingpressurepump1%>"/><br><label id="element_error_8"></label><br><br><!--4,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Installation</b> </label><input id="element_3_9" name="element_3_9"  class="element text medium" type="text"  value="<%=installation%>"/><br><label id="element_error_9"></label><br><br><br><!--5,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Power </b> </label><input id="element_3_10" name="element_3_10"  class="element text medium" type="text"  value="<%=power%>"/><br><label id="element_error_10"></label><br><br><br><!--5,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Pump Rotation</b> </label><input id="element_3_11" name="element_3_11"  class="element text medium" type="text"  value="<%=rotation%>"/><br><label id="element_error_11"></label><br><br><br><!--6,1--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Drive</b> </label><input id="element_3_12" name="element_3_12"  class="element text medium" type="text"  value="<%=drive%>"/><br><label id="element_error_12"></label><br><br><br><!--7,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Weight </b> </label><input id="element_3_13" name="element_3_13"  class="element text medium" type="text"  value="<%=weight%>"/><br><label id="element_error_13"></label><br><br><br><!--7,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>No of 4 way valve</b> </label><input id="element_3_14" name="element_3_14"  class="element text medium" type="text"  value="<%=no_four_way_valve%>"/><br><label id="element_error_14"></label><br><br><br><!--8,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>No Of NRV</b> </label><input id="element_3_15" name="element_3_15"  class="element text medium" type="text"  value="<%=no_of_NRV%>"/><br><label id="element_error_15"></label><br><br><br><!--8,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>No.Of VRV</b> </label><input id="element_3_16" name="element_3_16"  class="element text medium" type="text"  value="<%=no_of_VRV%>"/><br><label id="element_error_16"></label><br><br><br><!--9,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Cooler</b> </label><input id="element_3_17" name="element_3_17"  class="element text medium" type="text"  value="<%=cooler%>"/><br><label id="element_error_17"></label><br><br><br><!--9,2--></td>
<input type="hidden" name="vehid" id="vehid" value="<%=VehId%>">
<input type="hidden" name="rid" id="rid" value="<%=Rid2%>">
<input type="hidden" name="VehRegNo" id="VehRegNo" value="<%=VehRegNo%>">
</tr>
<tr>
<td><!--10,1--></td>
<td><!--10,2--></td>
</tr>
<tr>
<td><!--11,1--></td>
<td><!--11,2--></td>
</tr>

</table>
<tr>
<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></div>
</tr>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>