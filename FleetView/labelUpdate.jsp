<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">Update Sensor Label</font></h3>
</head>
<script type="text/javascript">
function validateForm() {
	
	
	    var x = document.forms["formupdate"]["lab"].value;
	    var y = document.forms["formupdate"]["sensor"].value;    
    if (x==null || x==" ") {
        alert("Please Enter The Label ");
        return false;
    }
    if (y =="Select" || y =="") {
        alert("Please Select The Sensor ");
        return false;
    }
}


function Update()
{
try{
	
	//alert('in side update ');
	 var x = document.forms["formupdate"]["lab"].value;
	 if (x == null || x == " ") {
	        alert("Please Enter The Label ");
	        return false;
	    }else {
	var own=document.getElementById("owner").value;

	var vehno=document.getElementById("vehno").value;
	
	var sen=document.getElementById("sensor").value;
	var label=document.getElementById("lab").value;
	
	    
	//alert("loc "+loc);
	//alert("loc1 "+loc1);
	//alert("oldloc "+oldloc);
	//alert("oldloc1 "+oldloc1);
	//alert("wtype "+wtype);
	//alert(oldwtype);
	
	if((own==null)||(own=="")||(own=="-")||(vehno==null)||(vehno=="")||(vehno=="-"))
	{
		alert("Please select to be Update..!!!");	
		return 0;
	}
	document.formupdate.action="getlabelUpdate.jsp?owner="+own+"&vehno="+vehno+"&sensor="+sen+"&label="+label; //+"&wtype="+wtype;
	document.formupdate.submit();	
	window.opener.history.go(0); 
	    }
}catch(e)
{alert(e);
}
}
</script>

<%
	String owner="",vehicle="",sensor="",label="";
		owner=request.getParameter("owner");
		System.out.println("Owner"+owner);
		vehicle=request.getParameter("vehicle");
		System.out.println("Vehicle No"+vehicle);
		sensor=request.getParameter("sen");
		System.out.println("sensor"+sensor);
		label=request.getParameter("lab");
		System.out.println("Label"+label);

%>
 
 <body bgcolor="">
<form action="getlabelUpdate.jsp" id="formupdate" name=""  onsubmit="return validateForm()"  method="post">
<table align="center" bgcolor="#e3e9ff">
 <tr id="trb">
        <td><font face="Arial" size="2" color="black"><b>Ownername</b></font></td>
        <td><input type="text" name="owner" readonly="readonly" id="owner" value="<%=owner%>  "></td>
</tr>
<tr id="trc">
        <td><font face="Arial" size="2" color="black"><b>Vehicle No.</b></font></td>
        <td><input type="text" name="vehno" readonly="readonly" id="vehno" value="<%=vehicle%> "></td>
</tr>
<tr id="trd">
	<td><font face="Arial" size="2" color="black"><b>Sensor</b></font></td>
	<td><select name="sensor" id="sensor"  style="width: 150px">
									<option selected>Select</option>
									<option value="Sensor 1" selected>Sensor 1</option>
                               <option value="Sensor 2" selected>Sensor 2</option>
                  	            <option value="Sensor 3" selected>Sensor 3</option>
                  	             <option value="Sensor 4" selected>Sensor 4</option>
									</select>
									</td>
</tr>
<tr id="tre">
	 <td><font face="Arial"  color="red">* </font><font size="2" color="black"><b>Label</b></font></td>
        <td><input type="text" name="lab" id="lab" value=" "></td>
</tr>
<tr id="tri">
	<td colspan="2" align="center">
	<input type="submit" name="btn3" id="btn3" value="Update" class="formElement" />
	 </td>		
	</tr>
	</table>
</form>
</body>
</html>