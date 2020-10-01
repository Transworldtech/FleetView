<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.Date"%> 
    <%@page import="java.text.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<h3 align="center"><font color="black">Update ND Intimation</font></h3>
</head>
<script type="text/javascript" language="javascript" src="calendar/prototype-1.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-base-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/prototype-date-extensions.js"></script>
<script type="text/javascript" language="javascript" src="calendar/behaviour.js"></script>
<script type="text/javascript" language="javascript" src="calendar/datepicker.js"></script>
<link rel="stylesheet" href="calendar/datepicker.css">
<script type="text/javascript" language="javascript" src="calendar/behaviors.js"></script>
<script type="text/javascript">
function validateForm() {
	
	
	    var x = document.forms["formupdate"]["distance"].value;
	    var y = document.forms["formupdate"]["reason"].value; 
	    var d1 = document.forms["formupdate"]["data1"].value;
	    var d2 = document.forms["formupdate"]["data2"].value;

	    if (x==null || x==" ") {
	        alert("Please Enter The Distance ");
	        return false;
	    }
	    if (y ==null || y ==" ") {
	        alert("Please Give The Reason ");
	        return false;
	    }

	    var date=new Date().toISOString().slice(0, 19).replace('T', ' ');
	   // alert(date);
	    if(d2 == d1 || d2 < d1){
		    alert("To Date should be greater than from date");
		    return false;
	    }
	   /* if(d1== date || d1 < date){
		    alert("From date should be greater than current date");
		    return false;
		    }  */
	   
		    
	   var numbers = /^[0-9]+$/;
	    if(document.forms["formupdate"]["distance"].value.match(numbers)){
		    }else{
		    	 alert('Please Enter numeric characters only for distance'); 
		    	 return false;
		    }
	    var check1=	document.getElementById('rule1').checked;
		var check2=	document.getElementById('rule2').checked;
		var check3=	document.getElementById('rule3').checked;
	
		
		if(check1 == false ){
			alert("Please Accept All The Rules");
			return false;
		}
		if(check2 == false ){
			alert("Please Accept All The Rules");
			return false;
		}
		if(check3 == false ){
			alert("Please Accept All The Rules");
			return false;
		}
	 
	         
  }


</script>

<%
	String vehicle="",vehcode="";
		vehicle=request.getParameter("vehicle");
		System.out.println("Vehicle"+vehicle);
		vehcode=request.getParameter("vehcode");
		System.out.println("Vehiclecode"+vehcode);
		String fromtime=request.getParameter("fromtime");
		String totime=request.getParameter("totime");
		System.out.println("From Time->"+fromtime);
		System.out.println("To Time->"+totime);
	//	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy");
		String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy HH:mm")
		.format(new java.util.Date());
		

%>
 
 <body bgcolor="">
<form action="saveNdEntry.jsp?update=true&vehid=<%=vehcode %>&fromtime=<%=fromtime %>&totime=<%=totime %>" id="formupdate" name="update"  onsubmit="return validateForm()"  method="post">
<table align="center" bgcolor="#e3e9ff">
 <tr id="trb">
        <td><font face="Arial" size="2" color="black"><b>Vehicle</b></font></td>
        <td><input type="text" name="VehCode" readonly="readonly" id="VehCode" value="<%=vehicle%>  "></td>
</tr>
<tr id="trc">
        
	 			
	      			<td> 
	      			
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>From Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td >  
						<input type="text" id="MdateF" name="data1"  value="<%=nwfrmtdte %>"  class="datetimepicker" style="width: 130px;"    readonly/></font></div>
				
							</td>
						 
</tr>
<tr id="trd">
	<td> 
	      		
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>To Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td> 
						<input type="text" id="MdateF" name="data2"  value="<%=nwfrmtdte %>"  class="datetimepicker" style="width: 130px;"    readonly/></font></div>
             			
				
							</td>
</tr>
<tr id="tre">
	 <td><font face="Arial"  color="red">* </font><font size="2" color="black"><b>Distance</b></font></td>
        <td><input type="text" name="distance" id="distance" value=" "></td>
</tr>

<tr id="trg">
	 <td><font face="Arial"  color="red">* </font><font size="2" color="black"><b>Reason</b></font></td>
        <td><input type="text" name="reason" id="reason" value=" "></td>
</tr>
<tr>
					<td><font color="red">* </font><input type="checkbox" id="rule1" name="rule1" value="rule1">I will follow road safety rules</h3><br></td>

					</tr>
					<tr>
					<td><font color="red">* </font><input type="checkbox" id="rule2" name="rule2" value="rule2">I will not drink and drive<br></td>

					</tr>
					<tr>
					<td><font color="red">* </font><input type="checkbox" id="rule3" name="rule3" value="rule3">I am driving for personal reason<br></td>

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
<%@ include file="footernew.jsp" %>