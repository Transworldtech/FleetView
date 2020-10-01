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
if((element_3_1.value=="")){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='1,';
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

function cancel(){
	window.close();
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


String kmpl=request.getParameter("kmpl");
System.out.println("kmpl------>"+kmpl);
String OwnerName=request.getParameter("OwnerName");
System.out.println("OwnerName------>"+OwnerName);
String VehcleRegNumber=request.getParameter("VehcleRegNumber");
System.out.println("VehcleRegNumber------>"+VehcleRegNumber);
String VehicleCode=request.getParameter("VehicleCode");
System.out.println("VehicleCode------>"+VehicleCode);
%>
<%@ include file="headernew.jsp"%> 
<form name="userform" action="KMPLsettupdtinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>KMPL Update Master</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>VehcleRegNumber</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  readonly  value="<%=VehcleRegNumber%>"/><br><label id="element_error_2"></label><br><br><!--1,1--></td>


<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>KMPL</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value="<%=kmpl%>" /><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><!--1,2--></td>
</tr>
<tr>
<td><!--2,1--></td>
<td><!--2,2--></td>
<input type="hidden" name="OwnerName" id="OwnerName" value="<%=OwnerName%>"></input>
<input type="hidden" name="VehcleRegNumber" id="VehcleRegNumber" value="<%=VehcleRegNumber%>"></input>
<input type="hidden" name="VehicleCode" id="VehicleCode" value="<%=VehicleCode%>"></input>
<input type="hidden" name="kmpl" id="kmpl" value="<%=kmpl%>"></input>
</tr>

</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Update" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="saveForm1" name="cancel"  style="border-style: outset; border-color: black" type="button" onClick="cancel()" value="Cancel" /></div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>