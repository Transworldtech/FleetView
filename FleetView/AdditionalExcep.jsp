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
if((element_3_6.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='6,';
}if((element_3_7.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='7,';
}if((element_3_8.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='8,';
}if((element_3_9.value==0)){
displaylabel+='<font face="Arial" size="1" color="red">Mandatory Field</font>,';
displaycount+='9,';
}// Mandatorytransworld
// alphatransworld
// charactertransworld
if(!(element_3_7.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_7.value.match(numbers))
{
count3+='7,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='7,';
}
}if(!(element_3_8.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_8.value.match(numbers))
{
count3+='8,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='8,';
}
}if(!(element_3_9.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_9.value.match(numbers))
{
count3+='9,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='9,';
}
}if(!(element_3_10.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_10.value.match(numbers))
{
count3+='10,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='10,';
}
}else{count3+='10,';}if(!(element_3_11.value==0))
{
var numbers = /^[0-9.]+$/;
if(element_3_11.value.match(numbers))
{
count3+='11,';
}
else
{
displaylabel+='<font face="Arial" size="1" color="red">Please Enter Number only</font>,';
displaycount+='11,';
}
}else{count3+='11,';}// numbertransworld
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

function Quantity(){
	//alert("here");
	var km=document.getElementById("element_3_7").value;
	var kmpl=document.getElementById("element_3_8").value;
	
	try {
		var qunty=km/kmpl;
		qunty=Math.round(qunty * 100) / 100
		//alert("here"+qunty);
		document.getElementById("element_3_9").value = qunty;
	}
	catch(err) {
	    document.getElementById("element_3_9").innerHTML = err.message;
	}

	
	
}

function amount(){
	//alert("here");
	var qnty=document.getElementById("element_3_9").value;
	var rate=document.getElementById("element_3_10").value;
	
	try {
		var amnt=qnty*rate;
		amnt=Math.round(amnt * 100) / 100
		//alert("here"+qunty);
		if(amnt==0){
			document.getElementById("element_3_11").value = "wrong Amount";
		}else{
		document.getElementById("element_3_11").value = amnt;
		}
	}
	catch(err) {
	    document.getElementById("element_3_11").innerHTML = err.message;
	}
}

function cardfinder(){
	var driverinfo=document.getElementById("element_3_3").value;
	//alert("driverinfo:-"+driverinfo);
	
	try
	{
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	}  
	catch (e)
	{
		// Internet Explorer Browsers
		try
		{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} 
		catch (e)
		{
			try
			{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} 
			catch (e)
			{
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			try
			{
			var reslt=ajaxRequest.responseText;
			//alert(reslt);
			var reslt1;
			//reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert(reslt);
			//reslt1=reslt.split("#");
			//document.getElementById("thisdaydiv1").innerHTML = reslt1[0];
			//document.getElementById("fdate9").innerHTML = reslt1[0];
			document.getElementById("element_3_6").value=reslt;
			//document.getElementById('temp2').style.display='none';
						
			}
			catch(e)
			{
				alert(e);
			}
		}
	};
	
	var queryString ="?driverinfo="+driverinfo;
	//alert(queryString);
	ajaxRequest.open("POST", "AjaxCardnofinder.jsp" + queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		alert(e);
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
<form name="userform" action="AdditionalExcepinsert.jsp" method="post" onsubmit="return formValidation();">
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3" color="black"><b>Additional Ad-hoc Request</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Vehicle Number :</b> </label><select id="element_3_1" name="element_3_1"  class="element select medium" >
<option value="select" selected="selected">select</option> 
<% 
     String sqlregno = "select VehicleRegNumber,vehiclecode from db_gps.t_vehicledetails where vehiclecode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
		System.out.println("*******"+sqlregno);
		PreparedStatement ps=con1.prepareStatement(sqlregno);
         ResultSet rsregno = ps.executeQuery();
		while(rsregno.next())
		{
			 //vehiclecode= rsregno.getString("vehiclecode");
			 //VehRegNo=rsregno.getString("VehicleRegNumber");
			 //System.out.println("VehicleRegNo-->"+VehRegNo);
			%>
		    <option value="<%=rsregno.getString("VehicleRegNumber")%>" ><%=rsregno.getString("VehicleRegNumber")%></option>			
			<%
			
      }
		%></select><br><br><!--1,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Driver Name :</b> </label><select id="element_3_3" name="element_3_3"  onchange="cardfinder();" class="element select medium" > 
<option value="select" selected="selected">select</option>
<% 
        String sqlregno1 = "select distinct(DriverName),DriverID from db_gps.t_drivers where (Owner='"+session.getAttribute("usertypevalue").toString()+"' or GPNAME='"+session.getAttribute("usertypevalue").toString()+"') and ACTIVESTATUS='Active' order by drivername";
		System.out.println("*******"+sqlregno);
		PreparedStatement ps1=con1.prepareStatement(sqlregno1);
        ResultSet rsregno1 = ps1.executeQuery();
		while(rsregno1.next())
		{
			 //vehiclecode= rsregno.getString("vehiclecode");
			 //VehRegNo=rsregno.getString("VehicleRegNumber");
			 //System.out.println("VehicleRegNo-->"+VehRegNo);
			%>
		    <option value="<%=rsregno1.getString("DriverName")+"-"+rsregno1.getString("DriverID")%>" ><%=rsregno1.getString("DriverName")+"("+rsregno1.getString("DriverID")+")"%></option>			
			<%
			
      }

%></select><br><br><!--1,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Card Number :</b> </label><input id="element_3_6" name="element_3_6"  readonly="readonly" class="element text medium" type="text"  value=""/></textarea><br><label id="element_error_6"></label><br><br><!--2,1--></td>
<td><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>KM :</b> </label><input id="element_3_7" name="element_3_7"  class="element text medium" type="text"  value=""/><br><label id="element_error_7"></label><br><br><!--3,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>KMPL :</b> </label><input id="element_3_8" name="element_3_8"  class="element text medium" type="text"  value=""/><br><label id="element_error_8"></label><br><br><!--3,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b><font size="2" color="red">*</font>Disel Quantity</b> </label><input id="element_3_9" name="element_3_9"  class="element text medium" type="text" readonly="readonly"  value=""/><a href="#" onclick="Quantity();">LoadQuantity</a><br><label id="element_error_9"></label><br><br><!--4,1--></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Default Fuel Rate :</b> </label><input id="element_3_10" name="element_3_10"  class="element text medium" type="text"  value=""/><br><label id="element_error_10"></label><br><br><br><!--4,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Fuel Amount :</b> </label><input id="element_3_11" name="element_3_11"  class="element text medium" type="text" readonly="readonly" value=""/><a href="#" onclick="amount();">LoadAmount</a><br><label id="element_error_11"></label><br><br><br><!--5,1--></td>
<td><!--5,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Reason :</b> </label><textarea id="element_3_12" name="element_3_12"  class="element textarea medium"/></textarea><br><br><br><!--6,1--></td>
<td><!--6,2--></td>
</tr>

</table>
<div align="center"><input id="saveForm" name="submit"  style="border-style: outset; border-color: black" type="submit" onClick="return validate()" value="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</form>
</jsp:useBean>
<%@ include file="footernew.jsp" %>