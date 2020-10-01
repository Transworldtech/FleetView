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
}if((element_3_5.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='5,';
}if((element_3_16.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='16,';
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
}if(!(element_3_6.value==0))
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
}else{count3+='7,';}if(!(element_3_8.value==0))
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
}else{count3+='8,';}if(!(element_3_9.value==0))
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
}// alphatransworld
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


String vehcode=request.getParameter("VehId");

String VehRegNo=request.getParameter("VehRegNo");



String rid=request.getParameter("rid");
String make=request.getParameter("make1");
String model=request.getParameter("model");
String serialnumber =request.getParameter("serialnumber1");
String oilgrade=request.getParameter("oilgrade1");
String oilcapacity=request.getParameter("oilcapacity1");
String drive=request.getParameter("drive");
String type=request.getParameter("type1");
String jettingpressurepump=request.getParameter("jettingpressurepump1");
String power=request.getParameter("power");
String suctionstrainer=request.getParameter("suctionstrainer1");
String rotation=request.getParameter("rotation");
String pistonsize=request.getParameter("pistonsize");
String sealsize=request.getParameter("sealsize");
String accumulatormake=request.getParameter("accumulatormake");

String Model_No=request.getParameter("modelno");
String cooler=request.getParameter("cooler");

%>
<%@ include file="headernew.jsp"%> 
<form name="userform" action="Editjettingpuminsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Jetting Pump</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Make</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value="<%=make%>"/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Model</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value="<%=model%>"/><br><label id="element_error_2"></label><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Grade</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=oilgrade%>"/><br><label id="element_error_3"></label><br><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Capacity</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value="<%=oilcapacity%>"/><br><label id="element_error_4"></label><br><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Serial Number</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value="<%=serialnumber%>"/><br><label id="element_error_5"></label><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Drive</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value="<%=drive%>"/><br><label id="element_error_6"></label><br><br><br><!--3,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Type</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value="<%=type%>"/><br><label id="element_error_7"></label><br><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Jetting Pressure Rating</b> </label><input id="element_3_8" name="element_3_8"  class="element text medium" type="text"  value="<%=jettingpressurepump%>"/><br><label id="element_error_8"></label><br><br><br><!--4,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Power</b> </label><input id="element_3_9" name="element_3_9"  class="element text medium" type="text"  value="<%=power%>"/><br><label id="element_error_9"></label><br><br><br><!--5,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Suction Strainer </b> </label><input id="element_3_10" name="element_3_10"  class="element text medium" type="text"  value="<%=suctionstrainer%>"/><br><label id="element_error_10"></label><br><br><br><!--5,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Rotation</b> </label><input id="element_3_11" name="element_3_11"  class="element text medium" type="text"  value="<%=rotation%>"/><br><label id="element_error_11"></label><br><br><br><!--6,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Piston Size</b> </label><input id="element_3_12" name="element_3_12"  class="element text medium" type="text"  value="<%=pistonsize%>"/><br><label id="element_error_12"></label><br><br><br><!--6,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Seal Size</b> </label><input id="element_3_13" name="element_3_13"  class="element text medium" type="text"  value="<%=sealsize%>"/><br><label id="element_error_13"></label><br><br><br><!--7,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Accumulator Make</b> </label><input id="element_3_14" name="element_3_14"  class="element text medium" type="text"  value="<%=accumulatormake%>"/><br><label id="element_error_14"></label><br><br><br><!--7,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Model No</b> </label><input id="element_3_15" name="element_3_15"  class="element text medium" type="text"  value="<%=Model_No%>"/><br><label id="element_error_15"></label><br><br><br><!--8,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Cooler</b> </label><input id="element_3_16" name="element_3_16"  class="element text medium" type="text"  value="<%=cooler%>"/><br><label id="element_error_16"></label><br><br><!--8,2--></td>
<input type="hidden" name="rid" id="rid" value="<%=rid%>">
<input type="hidden" name="vehid" id="vehid" value="<%=vehcode%>">
<input type="hidden" name="VehRegNo" id="VehRegNo" value="<%=VehRegNo%>">
</tr>
<tr>
<td><!--9,1--></td>
<td><!--9,2--></td>
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