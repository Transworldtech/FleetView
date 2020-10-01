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
}if((element_3_3.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='3,';
}// Mandatorytransworld
if(!(element_3_1.value==0))
{
var letters = /^[0-9a-zA-Z]+$/;
if(element_3_1.value.match(letters))
{
count3+='1,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='1,';
}
}// alphatransworld
if(!(element_3_2.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_2.value.match(letters))
{
count3+='2,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='2,';
}
}if(!(element_3_3.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_3.value.match(letters))
{
count3+='3,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='3,';
}
}// charactertransworld
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

function cancel(){
windows.close();
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
String id=request.getParameter("id");
String cardid=request.getParameter("cardid");
String cardtype=request.getParameter("cardtype");
String status=request.getParameter("status");
System.out.println("**status***status**"+status);
String driverid=request.getParameter("driverid");
System.out.println("**driverid***driverid**"+driverid);
String vendor=request.getParameter("vendor");
%>
<%@ include file="headernew.jsp"%> 
<form name="userform" action="CardMasterupdtinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<input type="hidden" id="id" name="id" value="<%=id%>" />
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Card Edit/Update Master</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>CardId :</b> </label><input id="element_3_1" name="element_3_1"  readonly="readonly"  class="element text medium" type="text"  value="<%=cardid %>"/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Vendor :</b> </label><input id="element_3_2" name="element_3_2"  readonly="readonly"  class="element text medium" type="text"  value="<%=vendor %>"/><br><label id="element_error_2"></label><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Card Type :</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text"  value="<%=cardtype %>"/><br><label id="element_error_3"></label><br><br><!--2,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Status :</b> </label><select id="element_3_4" name="element_3_4"  class="element select medium" > 
<option value="<%=status %>" selected="selected"><%=status %></option><option value="Active">Active</option><option value="De-active">De-active</option></select><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>DriverId :</b> </label><select id="element_3_5" name="element_3_5"  onchange="cardfinder();" class="element select medium" > 
<option value="<%=driverid %>" selected="selected"><%=driverid %></option>
<% 
        String sqlregno1 = "select distinct(DriverName),DriverID from db_gps.t_drivers where (Owner='"+session.getAttribute("usertypevalue").toString()+"' or GPNAME='"+session.getAttribute("usertypevalue").toString()+"') and ACTIVESTATUS='Active' order by drivername";
		System.out.println("*******"+sqlregno1);
		PreparedStatement ps1=con1.prepareStatement(sqlregno1);
        ResultSet rsregno1 = ps1.executeQuery();
		while(rsregno1.next())
		{
			 
			%>
		    <option value="<%=rsregno1.getString("DriverName")+"-"+rsregno1.getString("DriverID")%>" ><%=rsregno1.getString("DriverName")+"("+rsregno1.getString("DriverID")+")"%></option>			
			<%
			
      }

%></select><br><br><!--3,1--></td>

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
<tr>
<td><!--6,1--></td>
<td><!--6,2--></td>
</tr>

</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="saveForm1" name="cancel"  style="border-style: outset; border-color: black" type="button" onClick="cancel()" value="Cancel" /></div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>
