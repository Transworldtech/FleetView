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
displaylabel+='<font face="Arial" size="1" color="red">This field is compulsory</font>,';
displaycount+='1,';
}else{
count3+='1,';
}if((element_3_2.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">This field is compulsory</font>,';
displaycount+='2,';
}else{
count3+='2,';
}// Mandatorytransworld
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
String VehId=request.getParameter("VehId");
System.out.println("VehId on Pto insertpage---->"+VehId);
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehId on Pto insertpage---->"+VehRegNo); 

%>
<%
Connection con1 = null;
Statement stdynamicdrop = null,st=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
st=con1.createStatement();




%>
<%-- <% --%>
<!-- // String abc="select *  from db_gps.t_pto"; -->
<!-- // rs = st.executeQuery(abc); -->

<%-- %> --%>

<%@ include file="headernew.jsp"%> 
<form name="userform" action="Ptoinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>PTO</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Make</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  value=""/></textarea><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Serial Number</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text"  value=""/></textarea><br><label id="element_error_2"></label><br><br><!--1,2--></td>
</tr>

<tr>
<input type="hidden" name="vehid" id="vehid" value="<%=VehId%>">
<input type="hidden" name="VehRegNo" id="VehRegNo" value="<%=VehRegNo%>">
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Grade</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Oil Capacity</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Type</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Ratio</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--3,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>No Of Units</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Shaft Details</b> </label><input id="element_3_8" name="element_3_8"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--4,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Flange Size</b> </label><input id="element_3_9" name="element_3_9"  class="element text medium" type="text"  value=""/></textarea><br><br><br><!--5,1--></td>
<td><!--5,2--></td>
</tr>

<tr>
<td><!--7,1--></td>
<td><!--7,2--></td>
</tr>
<tr>
<td><!--8,1--></td>
<td><!--8,2--></td>
</tr>
</table>
<tr>
<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></div>
</tr>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>