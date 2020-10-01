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
}

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

String rid="",entryby="",currency="",insertdate="";
Connection con1 = null;
 String owner=session.getAttribute("usertypevalue").toString();
Statement stdynamicdrop = null,st=null,st1=null,st5=null;
String datenew1="",datenew2="",datenew3="";
datenew1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew3=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
datenew2=datenew1;
centconn.getConnection();
con1=centconn.ReturnConnection();
stdynamicdrop=con1.createStatement();
st=con1.createStatement();
st1=con1.createStatement();
st5=con1.createStatement();

Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 Format fmt1 = new SimpleDateFormat("yyyy-MM-dd");
//SimpleDateFormat sdfIn = new SimpleDateFormat("dd-MMM-yyyy");
//  SimpleDateFormat sdfOut = new SimpleDateFormat("yyyy-MM-dd");
 
 
	 insertdate = fmt.format(new java.util.Date());

%>




<%@ include file="headernew.jsp"%> 



<form name="userform" action="Fuelratemasterinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Fuel Rate Master</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Transporter:</b> </label><label id="element_3_1" name="element_3_1"  class="description" value="" ><font size="2" color="black"><%=owner%></font></label><%-- <select id="element_3_1" name="element_3_1"  class="element select medium" > 
<option value="select" selected="selected">select</option>
<% 
String abc=" select distinct(OwnerName) from db_gps.t_vehicledetails where status='-' ";
ResultSet rsDropdown3=st.executeQuery(abc);
while(rsDropdown3.next()){
%>
 <option value="<%=rsDropdown3.getString(1)%>"><%=rsDropdown3.getString(1)%></option> 
			
		<% 	}%> 
</select></textarea> --%><br>
</select><br><br><!--1,1--></td>



<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>FuelType:</b> </label><select id="element_3_2" name="element_3_2"  class="element select medium" > 
<option value="select" selected="selected">select</option><option value="Petrol">Petrol</option><option value="Diesel">Diesel</option><option value="CNG">CNG</option><option value="Bio-Diesel">Bio-Diesel</option></select><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>FuelRate:</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value=""/></textarea><br><label id="element_error_3"></label><br><br><!--2,1--></td>
<%-- <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>DateBox:</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text" value="<%=datenew1%>" size="15" readonly/> --%>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Declare Date:</b> </label>
<%-- //<input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=fuelrate%>"/></textarea><br><label id="element_error_3"></label><br><br><!--2,1--></td> --%>
						<input type="text" id="fueldate" name="fueldate"  class="element text medium"   value="<%=datenew3%>" readonly  />
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

<div align="center"><label id="element_1" name="element_1"  class="description" for="element_1"><b></b> </label><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Submit" /></div>
 <input	type="hidden" id="rid" name="rid" value="<%=rid%>" /> 
<%-- <input	type="hidden" id="currency" name="currency" value="<%=currency%>" /> --%>
<%-- <input	type="hidden" id="entryby" name="entryby" value="<%=entryby%>" /> --%>



</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
