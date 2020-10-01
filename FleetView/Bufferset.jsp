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
}// Mandatorytransworld
// alphatransworld
// charactertransworld
if(!(element_3_1.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_1.value.match(numbers))
{
count3+='1,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='1,';
}
}if(!(element_3_2.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_2.value.match(numbers))
{
count3+='2,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='2,';
}
}// numbertransworld
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
<%@ include file="headernew.jsp"%> 
<form name="userform" action="Buffersetinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Parameter Setting Master </b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>DistanceWise Buffer Km :</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value=""/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>GeofenceWise Buffer Km :</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value=""/><br><label id="element_error_2"></label><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red"></font>DayWise Buffer Time :</b> </label><font >
	            			HH : </font> 
	            						<select  class="element select medium"  style="width: 50px" name="element_3_3" >
						                   <!-- <option value="Select">Select</option> -->
						                   <option value="00">00</option>
						                   <option value="01">01</option>
						                   <option value="02">02</option>
						                   <option value="03">03</option>
						                   <option value="04">04</option>
						                   <option value="05">05</option>
						                   <option value="06">06</option>
						                   <option value="07">07</option>
						                   <option value="08">08</option>
						                   <option value="09">09</option>
						                   <option value="10">10</option>
						                   <option value="11">11</option> 
						                   <option value="12">12</option>
						                   <option value="13">13</option>
						                   <option value="14">14</option>
						                   <option value="15">15</option>
						                   <option value="16">16</option>
						                   <option value="17">17</option>
						                   <option value="18">18</option>
						                   <option value="19">19</option>
						                   <option value="20">20</option>
						                   <option value="21">21</option> 
						                   <option value="22">22</option>
						                   <option value="23">23</option>
            	 						</select>
<font >
	            			MM : </font> 
	            						<select  class="element select medium"  style="width: 50px" name="element_3_4" >
						                   <!-- <option value="Select">Select</option> -->
						                   <option value="00">00</option>
						                   <option value="10">10</option>
						                   <option value="20">20</option>
						                   <option value="30">30</option> 
						                   <option value="40">40</option>
						                   <option value="50">50</option>
            	 						</select>  
            	<br><br><!--2,1--></td>
<td><!--2,2--></td>
</tr>

</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>