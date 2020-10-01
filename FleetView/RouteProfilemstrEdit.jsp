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
}if((element_3_3.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='3,';
}if((element_3_4.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='4,';
}if((element_3_5.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='5,';
}// Mandatorytransworld
if(!(element_3_6.value==0))
{
var letters = /^[0-9a-zA-Z]+$/;
if(element_3_6.value.match(letters))
{
count3+='6,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter alphnumeric only</font>,';
displaycount+='6,';
}
}else{count3+='6,';}// alphatransworld
if(!(element_3_1.value==0))
{ 
var letters = /^[A-Za-z ]+$/;
if(element_3_1.value.match(letters))
{
count3+='1,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='1,';
}
}if(!(element_3_2.value==0))
{ 
var letters = /^[A-Za-z-]+$/;
if(element_3_2.value.match(letters))
{
count3+='2,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Character only</font>,';
displaycount+='2,';
}
}else{count3+='2,';}if(!(element_3_3.value==0))
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
if(!(element_3_4.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_4.value.match(numbers))
{
count3+='4,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='4,';
}
}if(!(element_3_5.value==0))
{
var numbers = /^[0-9]+$/;
if(element_3_5.value.match(numbers))
{
count3+='5,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='5,';
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

 //function getClient2(id)
//{
	 /* var setcounttextbx=document.getElementById("counttextbx").value;
	 var orisetcounttextbx=document.getElementById("counttextbxprev").value;
	 var prevcode=document.getElementById("newdiv1").value;
      */
      /* if(id=="+")
      {
 
      alert("location:-"+id);
      alert("prevcode:-"+prevcode);
      alert("setcounttextbx:-"+setcounttextbx);
         for(j=1; j < 2; j++){
             var input="<input id='new_element_3_"+setcounttextbx+"' name='new_element_3_"+setcounttextbx+"'  class='element text medium' type='text'  value=''/><br><!--2,1-->";
             prevcode=prevcode.replace("<!--2,1-->", input);
             document.getElementById("newdiv").innerHTML = prevcode;
             document.getElementById("newdiv1").innerHTML = prevcode;
             //setcounttextbx=setcounttextbx+1
             document.getElementById("counttextbxprev").value=setcounttextbx;
             document.getElementById("counttextbx").value = setcounttextbx+1;
              //location=document.getElementById("fuelentr"+j).value;
             //location123+=location+",";
             //alert("location:-"+location);
         } */ 
/* document.getElementById("f1").style.display='none';
document.getElementById("mobileno2").style.display='';
document.getElementById("f2").style.display='none';
document.getElementById("f3").style.display='none';
document.getElementById("f4").style.display="";
 */

//}
//e lse{

	/* alert("in2 get"+id);
	alert("in2 get"+setcounttextbx);
	//alert("here"+document.getElementById("new_element_3_"+setcounttextbx).style.display);
	for(j=1; j < 2; j++){
		document.getElementById("new_element_3_"+orisetcounttextbx).style.display='none';
	}
 */	/* document.getElementById("f1").style.display="";
	document.getElementById("mobileno1").style.display='none';
	
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none'; */
//}
//}
 
 
  function getClient1(id)
	{ 
		//alert("in2 get"+id);

		if(id=="+")
	    {
		document.getElementById("f1").style.display='none';
		document.getElementById("mobileno1").style.display='';
		document.getElementById("f2").style.display="";
		document.getElementById("f3").style.display="";
		
	    }
	}
 
	function getClient2(id)
	    {
		if(id=="+")
	    {
		document.getElementById("f1").style.display='none';
		document.getElementById("mobileno2").style.display="";
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f5").style.display="";
		document.getElementById("f6").style.display="";
		
		//document.getElementById("f4").style.display="";
		
	    }
		else{


			//alert("in2 get"+id);
			    
			document.getElementById("f1").style.display="";
			document.getElementById("mobileno1").style.display='none';
			
			document.getElementById("f2").style.display='none';
			document.getElementById("f3").style.display='none';
			//document.getElementById("f5").style.display="none";
			//document.getElementById("f6").style.display="none";
			
	    }
	    }

	
	function getClient4(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno3").style.display="";
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f5").style.display='none';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display="";
	document.getElementById("f8").style.display="";
	
	//document.getElementById("f4").style.display="";
	
	
    }
	else{
		
		//document.getElementById("f1").style.display="";
		//document.getElementById("mobileno1").style.display='none';
		document.getElementById("mobileno2").style.display='none';
		document.getElementById("f2").style.display="";
		document.getElementById("f3").style.display="";
		document.getElementById("f5").style.display='none';
		document.getElementById("f6").style.display='none';
		//document.getElementById("f7").style.display='none';
		//document.getElementById("f8").style.display='none';
    }
    }

	
	function getClient5(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno4").style.display="";
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f5").style.display='none';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display='none';
	document.getElementById("f8").style.display='none';
	document.getElementById("f9").style.display="";
	document.getElementById("f10").style.display="";
	
	//document.getElementById("f4").style.display="";
	
	
    }
	else{
		
		//document.getElementById("f1").style.display="";
		//document.getElementById("mobileno1").style.display='none';
		document.getElementById("mobileno3").style.display='none';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f5").style.display="";
		document.getElementById("f6").style.display="";
		//document.getElementById("f9").style.display='none';
		//document.getElementById("f10").style.display='none';
		
		document.getElementById("f7").style.display='none';
		document.getElementById("f8").style.display='none';
		
    }
    }

	function getClient6(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno5").style.display="";
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f5").style.display='none';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display='none';
	document.getElementById("f8").style.display='none';
	document.getElementById("f9").style.display='none';
	document.getElementById("f10").style.display='none';
	document.getElementById("f11").style.display="";
	document.getElementById("f12").style.display="";
	
	
	//document.getElementById("f4").style.display="";
	
	
    }
	else{
		
		//document.getElementById("f1").style.display="";
		//document.getElementById("mobileno1").style.display='none';
		document.getElementById("mobileno4").style.display='none';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f7").style.display="";
		document.getElementById("f8").style.display="";
		document.getElementById("f5").style.display='none';
		document.getElementById("f6").style.display='none';
		//document.getElementById("f11").style.display='none';
		//document.getElementById("f12").style.display='none';
		document.getElementById("f9").style.display='none';
		document.getElementById("f10").style.display='none';
		
		
    }
    }


	function getClient7(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno6").style.display="";
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f5").style.display='none';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display='none';
	document.getElementById("f8").style.display='none';
	document.getElementById("f9").style.display='none';
	document.getElementById("f10").style.display='none';
	document.getElementById("f11").style.display='none';
	document.getElementById("f12").style.display='none';
	
	document.getElementById("f13").style.display="";
	document.getElementById("f14").style.display="";
	
	
	//document.getElementById("f4").style.display="";
	
	
    }
	else{
		
		//document.getElementById("f1").style.display="";
		//document.getElementById("mobileno1").style.display='none';
		document.getElementById("mobileno5").style.display='none';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f7").style.display='none';
		document.getElementById("f8").style.display='none';
		document.getElementById("f5").style.display='none';
		document.getElementById("f6").style.display='none';
		document.getElementById("f11").style.display='none';
		document.getElementById("f12").style.display='none';
		//document.getElementById("f13").style.display='none';
		//document.getElementById("f14").style.display='none';
		
		document.getElementById("f9").style.display="";
		document.getElementById("f10").style.display="";
		
		
    }
    }
	
	
	function getClient8(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno7").style.display="";
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f5").style.display='none';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display='none';
	document.getElementById("f8").style.display='none';
	document.getElementById("f9").style.display='none';
	document.getElementById("f10").style.display='none';
	document.getElementById("f11").style.display='none';
	document.getElementById("f12").style.display='none';
	document.getElementById("f13").style.display='none';
	document.getElementById("f14").style.display='none';
	
	document.getElementById("f15").style.display="";
	document.getElementById("f16").style.display="";
	
	
	//document.getElementById("f4").style.display="";
	
	
    }
	else{
		
		//document.getElementById("f1").style.display="";
		//document.getElementById("mobileno1").style.display='none';
		document.getElementById("mobileno6").style.display='none';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f7").style.display='none';
		document.getElementById("f8").style.display='none';
		document.getElementById("f5").style.display='none';
		document.getElementById("f6").style.display='none';
		document.getElementById("f13").style.display='none';
		document.getElementById("f14").style.display='none';
		
		document.getElementById("f9").style.display='none';
		document.getElementById("f10").style.display='none';
		document.getElementById("f11").style.display="";
		document.getElementById("f12").style.display="";
		
		
		
    }
    }

	
	function getClient9(id)
    {
	if(id=="+")
    {
	document.getElementById("f1").style.display='none';
	document.getElementById("mobileno8").style.display="";
	document.getElementById("f2").style.display='none';
	document.getElementById("f3").style.display='none';
	document.getElementById("f5").style.display='none';
	document.getElementById("f6").style.display='none';
	document.getElementById("f7").style.display='none';
	document.getElementById("f8").style.display='none';
	document.getElementById("f9").style.display='none';
	document.getElementById("f10").style.display='none';
	document.getElementById("f11").style.display='none';
	document.getElementById("f12").style.display='none';
	document.getElementById("f13").style.display='none';
	document.getElementById("f14").style.display='none';
	
	document.getElementById("f15").style.display='none';
	document.getElementById("f16").style.display='none';
	document.getElementById("f17").style.display="";
	//document.getElementById("f18").style.display="";
	
	
	//document.getElementById("f4").style.display="";
	
	
    }
	else{
		
		//document.getElementById("f1").style.display="";
		//document.getElementById("mobileno1").style.display='none';
		document.getElementById("mobileno7").style.display='none';
		document.getElementById("f2").style.display='none';
		document.getElementById("f3").style.display='none';
		document.getElementById("f7").style.display='none';
		document.getElementById("f8").style.display='none';
		document.getElementById("f5").style.display='none';
		document.getElementById("f6").style.display='none';
		document.getElementById("f15").style.display='none';
		document.getElementById("f16").style.display='none';
		
		document.getElementById("f9").style.display='none';
		document.getElementById("f10").style.display='none';
		document.getElementById("f11").style.display='none';
		document.getElementById("f12").style.display='none';
		document.getElementById("f13").style.display="";
		document.getElementById("f14").style.display="";
		
		
		
    }
    }

	
	function getClient10(id)
	{ 
		//alert("in2 get"+id);

		if(id=="-")
	    {
		//document.getElementById("f1").style.display='none';
		document.getElementById("mobileno8").style.display='none';
		document.getElementById("f15").style.display="";
		document.getElementById("f16").style.display="";
		document.getElementById("f17").style.display='none';
		
		
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
String origin=request.getParameter("origin");

String destination=request.getParameter("detination");
//System.out.println("Vendor*************************************************:-"+fueltype);
 	String rid=request.getParameter("rid");
 	//System.out.println("rid***************************in first update page **********************:-"+rid);
String via=request.getParameter("via");

//System.out.println("cardtype*************************************************:-"+fuelrate);
//String Date=request.getParameter("insertDate");
//Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(Date));
//System.out.println("Date*************************************************:-"+Date);

String stdkm=request.getParameter("stdkm");
String transitdays=request.getParameter("transitdays");
String category=request.getParameter("category");
//System.out.println("EntryBy**************************in first page***********************:-"+EntryBy);

%>

<%@ include file="headernew.jsp"%> 
<form name="userform" action="RouteProfileeditinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Edit Route Profile Form</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Origin :</b> </label><input id="element_3_1" name="element_3_1"  class="element text medium" type="text"  readonly="readonly" value="<%=origin%>"/><br><label id="element_error_1"></label><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Destination :</b> </label><input id="element_3_3" name="element_3_3"  class="element text medium" type="text" readonly="readonly" value="<%=destination%>"/><br><label id="element_error_3"></label><br><br><!--2,1--></td>
</tr>

<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Via :</b> </label><input id="element_3_2" name="element_3_2"  class="element text medium" type="text" readonly="readonly" value="<%=via%>"/><br><label id="element_error_2"></label>
<br><br><!--1,2--></td>
</tr>

<tr>

<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Std KM :</b> </label><input id="element_3_4" name="element_3_4"  class="element text medium" type="text"  value="<%=stdkm%>"/><br><label id="element_error_4"></label><br><br><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Transit Days :</b> </label><input id="element_3_5" name="element_3_5"  class="element text medium" type="text"  value="<%=transitdays%>"/><br><label id="element_error_5"></label><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Category :</b> </label><input id="element_3_6" name="element_3_6"  class="element text medium" type="text" readonly="readonly" value="<%=category%>"/><br><label id="element_error_6"></label><br><br><br><!--3,2--></td>
</tr>
<tr>
<input id="Rid" name="Rid"  class="element text medium" type="hidden"  value="<%=rid%>"/>
<td><!--4,1--></td>
<td><!--4,2--></td>
</tr>
<tr>
<td><!--5,1--></td>
<td><!--5,2--></td>
</tr>

</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- <input type="button" name="Cancel" style="border-style: outset; border-color: black" value="Cancel" onclick="cancelbutton();"  class="button_text" /> --></div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>