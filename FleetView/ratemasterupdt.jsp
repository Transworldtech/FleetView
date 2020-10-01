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
if((element_3_3.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='3,';
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

String entryby="",currency="";
Connection con1 = null;
Statement stdynamicdrop = null,st=null,st1=null,st5=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
st=con1.createStatement();
st1=con1.createStatement();
st5=con1.createStatement();
%>
<%
String transporter=request.getParameter("transporter");
System.out.println("transporter*************************************************:-"+transporter);
String fueltype=request.getParameter("fuel");
System.out.println("Vendor*************************************************:-"+fueltype);
 	String rid=request.getParameter("rid");
 	System.out.println("rid***************************in first update page **********************:-"+rid);
String fuelrate=request.getParameter("rate");
System.out.println("cardtype*************************************************:-"+fuelrate);
String Date=request.getParameter("insertDate");
//Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Date));
System.out.println("Date*************************************************:-"+Date);

String EntryBy=request.getParameter("EntryBy");
System.out.println("EntryBy**************************in first page***********************:-"+EntryBy);

%>



<%@ include file="headernew.jsp"%> 
<form name="userform" action="Fuelratemasterinsertupdt.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Fuel Rate Master</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Transporter:</b> </label> <input id="element_3_1" name="element_3_1"  class="element text medium" type="text" readonly  value="<%=transporter%>"/></textarea><br><label id="element_error_1"></label><br><br><!--2,1--></td>




<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>FuelType:</b> </label><select id="element_3_2" name="element_3_2"  class="element select medium" > 
<option value="<%=fueltype %>" selected="selected"><%=fueltype %></option><option value="Petrol">Petrol</option><option value="Diesel">Diesel</option><option value="CNG">CNG</option><option value="Bio-Diesel">Bio-Diesel</option></select><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>FuelRate:</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=fuelrate%>"/></textarea><br><label id="element_error_3"></label><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Declare Date:</b> </label>
<%-- //<input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=fuelrate%>"/></textarea><br><label id="element_error_3"></label><br><br><!--2,1--></td> --%>
						<input type="text" id="fueldate" name="fueldate"  class="element text medium"   value="<%=Date%>" readonly  />
             			<script type="text/javascript">
				             Calendar.setup(
				             {
				                 inputField  : "fueldate",         // ID of the input field
				                 ifFormat    : "%d-%b-%Y",     // the date format
				                 button      : "fueldate"       // ID of the button
				             }
				                           );
             			</script> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;






<br><br><br><!--2,2--></td>
</tr>
<tr>


<td><!--3,2--></td>
</tr>
<tr>
<td><!--4,1--></td>
<td><!--4,2--></td>
</tr>
<tr>
<td><!--5,1--></td>
<td><!--5,2--></td>
</tr>

</table>

<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></textarea><br><br><br><!--3,1--></div>


 <input	type="hidden" id="rid1" name="rid1" value="<%=rid%>" /> 
 <input	type="hidden" id="entryby" name="entryby" value="<%=EntryBy%>" /> 




</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
