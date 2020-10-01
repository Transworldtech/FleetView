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
<%
String rid=request.getParameter("Rid3");
String VehId=request.getParameter("VehId");
String VehRegNo=request.getParameter("Vehregno");
%>
<script>
function formValidation()
{
	var displaylabel="";
	var displaycount="";
	var count3="";
	if((element_3_1.value==0)){
	displaylabel+='<font face="Arial" size="1" color="red">This field is compulsory</font>,';
	displaycount+='1,';
	}else{
	count3+='1,';
	}
// Mandatorytransworld
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
}if(!(element_3_4.value==0))
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
}if(!(element_3_5.value==0))
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
}if(!(element_3_7.value==0))
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
}if(!(element_3_10.value==0))
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
}if(!(element_3_11.value==0))
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
}if(!(element_3_12.value==0))
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
}if(!(element_3_13.value==0))
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
}if(!(element_3_14.value==0))
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
}if(!(element_3_15.value==0))
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
}if(!(element_3_16.value==0))
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
}if(!(element_3_17.value==0))
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
}if(!(element_3_18.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_18.value.match(letters))
{
count3+='18,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='18,';
}
}if(!(element_3_19.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_19.value.match(letters))
{
count3+='19,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='19,';
}
}if(!(element_3_20.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_20.value.match(letters))
{
count3+='20,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='20,';
}
}if(!(element_3_21.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_21.value.match(letters))
{
count3+='21,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='21,';
}
}if(!(element_3_22.value==0))
{
var letters = /^[0-9a-zA-Z .:-]+$/;
if(element_3_22.value.match(letters))
{
count3+='22,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='22,';
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
%>


<%


String Rid3=request.getParameter("Rid3");
String Type=request.getParameter("Type");
String Capacity=request.getParameter("Capacity");
String Pressure=request.getParameter("Pressure");
String Drive3=request.getParameter("Drive3");
String Tank_Capacity=request.getParameter("Tank_Capacity");
String Oil_Grade3=request.getParameter("Oil_Grade3");
String Make_Vendor=request.getParameter("Make_Vendor");
String Hyd_Cylinders_Numbers=request.getParameter("Hyd_Cylinders_Numbers");
String Drive2=request.getParameter("Drive2");
String Door_Cylinder_size=request.getParameter("Door_Cylinder_size");
String Door_Cylinder_Nos=request.getParameter("Door_Cylinder_Nos");
String Door_Clamp_Size=request.getParameter("Door_Clamp_Size");
String Door_Clamp_Nos=request.getParameter("Door_Clamp_Nos");
String Boom_Fwd_Rev_Size=request.getParameter("Boom_Fwd_Rev_Size");
String Boom_Fwd_Rev_Nos=request.getParameter("Boom_Fwd_Rev_Nos");
String  Boom_Up_Down_Size=request.getParameter("Boom_Up_Down_Size");
String Boom_Up_Down_Nos=request.getParameter("Boom_Up_Down_Nos");
String Directional_Control_Valve=request.getParameter("Directional_Control_Valve");
String Pressure_Relief_Valve=request.getParameter("Pressure_Relief_Valve");
String Speed_Control_Valve=request.getParameter("Speed_Control_Valve");
String Pilot_Valve_Make=request.getParameter("Pilot_Valve_Make");
String Tipping_Cyclinder_Make=request.getParameter("Tipping_Cyclinder_Make");
String Filters_Specification=request.getParameter("Filters_Specification");

%>
<%@ include file="headernew.jsp"%> 
<form name="userform" action="EditHydrolicsysteminsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b> Edit Hydraulic System</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Type</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value="<%=Type%>"/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Capacity</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value="<%=Capacity%>"/><br><label id="element_error_2"></label><br><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Pressure</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=Pressure%>"/><br><label id="element_error_3"></label><br><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Drive</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value="<%=Drive3%>"/><br><label id="element_error_4"></label><br><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Tank Capacity</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value="<%=Tank_Capacity%>"/><br><label id="element_error_5"></label><br><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Grade</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value="<%=Oil_Grade3%>"/><br><label id="element_error_6"></label><br><br><br><!--3,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Make / Vendor</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value="<%=Make_Vendor%>"/><br><label id="element_error_7"></label><br><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Hyd.Cylinders Numbers</b> </label><input id="element_3_8" name="element_3_8"  class="element text medium" type="text"  value="<%=Hyd_Cylinders_Numbers%>"/><br><label id="element_error_8"></label><br><br><br><!--4,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Door Cylinder size</b> </label><input id="element_3_9" name="element_3_9"  class="element text medium" type="text"  value="<%=Door_Cylinder_size%>"/><br><label id="element_error_9"></label><br><br><br><!--5,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Door Cylinder Nos.</b> </label><input id="element_3_10" name="element_3_10"  class="element text medium" type="text"  value="<%=Door_Cylinder_Nos%>"/><br><label id="element_error_10"></label><br><br><br><!--5,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Door Clamp Size</b> </label><input id="element_3_11" name="element_3_11"  class="element text medium" type="text"  value="<%=Door_Clamp_Size%>"/><br><label id="element_error_11"></label><br><br><br><!--6,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Door Clamp Nos</b> </label><input id="element_3_12" name="element_3_12"  class="element text medium" type="text"  value="<%=Door_Clamp_Nos%>"/><br><label id="element_error_12"></label><br><br><br><!--6,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Boom Fwd / Rev. Size</b> </label><input id="element_3_13" name="element_3_13"  class="element text medium" type="text"  value="<%=Boom_Fwd_Rev_Size%>"/><br><label id="element_error_13"></label><br><br><br><!--7,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Boom Fwd / Rev. Nos.</b> </label><input id="element_3_14" name="element_3_14"  class="element text medium" type="text"  value="<%=Boom_Fwd_Rev_Nos%>"/><br><label id="element_error_14"></label><br><br><br><!--7,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Boom Up / Down Size</b> </label><input id="element_3_15" name="element_3_15"  class="element text medium" type="text"  value="<%=Boom_Up_Down_Size%>"/><br><label id="element_error_15"></label><br><br><br><!--8,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Boom Up / Down Nos.</b> </label><input id="element_3_16" name="element_3_16"  class="element text medium" type="text"  value="<%=Boom_Up_Down_Nos%>"/><br><label id="element_error_16"></label><br><br><br><!--8,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Directional Control Valve Make</b> </label><input id="element_3_17" name="element_3_17"  class="element text medium" type="text"  value="<%=Directional_Control_Valve%>"/><br><label id="element_error_17"></label><br><br><br><!--9,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Pressure Relief Valve Make</b> </label><input id="element_3_18" name="element_3_18"  class="element text medium" type="text"  value="<%=Pressure_Relief_Valve%>"/><br><label id="element_error_18"></label><br><br><br><!--9,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Speed Control Valve</b> </label><input id="element_3_19" name="element_3_19"  class="element text medium" type="text"  value="<%=Speed_Control_Valve%>"/><br><label id="element_error_19"></label><br><br><br><!--10,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Pilot Valve Make</b> </label><input id="element_3_20" name="element_3_20"  class="element text medium" type="text"  value="<%=Pilot_Valve_Make%>"/><br><label id="element_error_20"></label><br><br><br><!--10,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Tipping Cyclinder Make</b> </label><input id="element_3_21" name="element_3_21"  class="element text medium" type="text"  value="<%=Tipping_Cyclinder_Make%>"/><br><label id="element_error_21"></label><br><br><br></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Filters Specification</b> </label><input id="element_3_22" name="element_3_22"  class="element text medium" type="text"  value="<%=Filters_Specification%>"/><br><label id="element_error_22"></label><br><br><br><!--11,2--></td>
<input type="hidden" name="VehId" id="VehId" value=<%=VehId %>>
<input type="hidden" name="rid" id="rid" value=<%=rid%>>
<input type="hidden" name="Vehregno" id="Vehregno" value=<%=VehRegNo%>>

</tr>

</table>

<tr>
<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></div>
</tr>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>