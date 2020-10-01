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



String VehRegNo=request.getParameter("VehRegNo");
String rid=request.getParameter("rid");
String pto=request.getParameter("pto");
String acceleration=request.getParameter("acceleration");
String control_panel_location=request.getParameter("control_panel_location");
String jetting_pressure_gauge=request.getParameter("jetting_pressure_gauge");
String suction_pressure_gauge=request.getParameter("suction_pressure_gauge");
String hyd_pressure_gauge=request.getParameter("hyd_pressure_gauge");
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
String VehRegNo1=request.getParameter("VehRegNo");
String VehId=request.getParameter("VehId");
System.out.println("VehId on control system insertpage---->"+VehId); %>
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
<%@ include file="headernew.jsp"%> 
<form name="userform" action="Editcontrolsysteminsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Control System</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>PTO</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value="<%=pto%>"/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Acceleration</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value="<%=acceleration%>"/><br><label id="element_error_2"></label><br><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Control Panel Location</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=control_panel_location%>"/><br><label id="element_error_3"></label><br><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Jetting Pressure Gauge</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value="<%=jetting_pressure_gauge%>"/><br><label id="element_error_4"></label><br><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Suction Pressure Gauge</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value="<%=suction_pressure_gauge%>"/><br><label id="element_error_5"></label><br><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Hyd. Pressure Gauge</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value="<%=hyd_pressure_gauge%>"/><br><label id="element_error_6"></label><br><br><br><!--3,2--></td>
<input type="hidden" name="vehid" id="vehid" value="<%=VehId%>">
<input type="hidden" name="VehRegNo" id="VehRegNo" value="<%=VehRegNo%>">


</tr>

<tr>
<td><!--5,1--></td>
<td><!--5,2--></td>
</tr>
<tr>
<td><!--6,1--></td>
<td><!--6,2--></td>
</tr>
<tr>
<td><!--7,1--></td>
<td><!--7,2--></td>
</tr>
<tr>
<td><!--8,1--></td>
<td><!--8,2--></td>
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
<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>