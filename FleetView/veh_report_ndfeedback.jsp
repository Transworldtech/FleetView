<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">



function dodisable()
{
    document.veh_report_ndfeedback.vehregno.readOnly="true";
    document.veh_report_ndfeedback.tripid.readOnly="true";
    document.veh_report_ndfeedback.startdatetime.readOnly="true";
    document.veh_report_ndfeedback.enddatetime.readOnly="true";

}


function insertfeedbk()
{


	  var trans=document.getElementById("trans").value;
	 // alert(trans);
	  if(trans=="GROUP")
	  {
		  
	  var name=document.veh_report_ndfeedback.entersname.value;
	  if(name=="")
     {
	 alert("Please Enter the Name");
	  return false;
	 }
}


	  var ndreason=document.veh_report_ndfeedback.reason.value;
	    if(ndreason=="")
	   {
	      alert("Please Enter the Reason");
	      return false;
	    }
	 var vehregno=document.veh_report_ndfeedback.vehregno.value;
	 var vid=document.veh_report_ndfeedback.vid.value;
	 var tripid=document.veh_report_ndfeedback.tripid.value;
	 var startdatetime=document.veh_report_ndfeedback.startdatetime.value;
	 var enddatetime=document.veh_report_ndfeedback.enddatetime.value;
	 var entersname=document.veh_report_ndfeedback.entersname.value;

	 var comments=document.veh_report_ndfeedback.comments.value;

		 var reason=document.veh_report_ndfeedback.reason.value;
	
	// alert(vehregno);
	 var ajaxRequest;  // The variable that makes Ajax possible!
	    try
	    {
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

		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function()
		{
			if(ajaxRequest.readyState == 4)
			{
				var reslt=ajaxRequest.responseText;
				//alert("result.....         "+reslt);
			//var finalres=reslt.trim();
				//alert(">>>>>>>>>>         >"+finalres);
				var data=reslt.split("#");
			   // alert("<*****  "+data);
				if(data[1].indexOf('Yes')==-1)
				{
					alert("Error Occured During form submission");
				}
				else
				{
					alert("Reason Save Successfully...");
					 window.opener.location.reload();
					 setTimeout('self.close()',5);      
				}
				
		    }
				
		};
		
		var queryString = "?vehregno="+vehregno+"&vid="+vid+"&tripid="+tripid+"&startdatetime="+startdatetime+"&enddatetime="+enddatetime+"&entersname="+entersname+"&comments="+comments+"&reason="+reason;
		//alert(queryString);
		
		ajaxRequest.open("GET", "veh_insertReason.jsp" + queryString, true);
		ajaxRequest.send(null); 
	
}



/*function insertform()
{
	var trans=document.getElementById("trans").value;
	  alert(trans);
	  if(trans=="GROUP")
	  {
		  
	  var name=document.veh_report_ndfeedback.entersname.value;
	  if(name=="")
   {
	 alert("Please Enter the Name");
	  return false;
	 }
}


	  var ndreason=document.veh_report_ndfeedback.reason.value;
	    if(ndreason=="")
	   {
	      alert("Please Enter the Reason");
	      return false;
	    }
	 var vehregno=document.veh_report_ndfeedback.vehregno.value;
	 var vid=document.veh_report_ndfeedback.vid.value;
	 var tripid=document.veh_report_ndfeedback.tripid.value;
	 var startdatetime=document.veh_report_ndfeedback.startdatetime.value;
	 var enddatetime=document.veh_report_ndfeedback.enddatetime.value;
	 var entersname=document.veh_report_ndfeedback.entersname.value;

	 var comments=document.veh_report_ndfeedback.comments.value;

		 var reason=document.veh_report_ndfeedback.reason.value;


             alert("form submitted");
             window.opener.location.reload();
			 setTimeout('self.close()',5);  
}*/





</script>




<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Night Driving Reason Form</title>

</head>
<body>

<%
String veh=request.getParameter("vehregno");
String vid=request.getParameter("vid");
String trip=request.getParameter("tripid");
String start=request.getParameter("startdatetime");
String end=request.getParameter("enddatetime");


String trans=session.getAttribute("TypeofUserMain").toString();




%>

<form name="veh_report_ndfeedback" method="post" action="" onsubmit="return validate()">
<h1 style="background-color:#6F9BEE;" align="center"><font size="4" face="Arial" color="white"><b>Please Enter Reason For Night Driving</b></font></h1>

<table border="0" align="left" style="font-family: arial;font-size:12;">

<tr>
<td><font size="2" face="Arial"><b> Vehicle Reg No:</b></font></td>

<td><input type="text" name="vehregno" style="border: 0px solid #000000;" value="<%=veh%>" onclick="dodisable()"/></input>
<input type="hidden" name="trans" id="trans" value="<%=trans%>"/></td>

<td><input type="hidden" name="vid" value="<%=vid%>" /></td>
</tr>

<tr>


<td><font size="2" face="Arial"><b>Trip ID:</b></font></td>
<td><input type="text" name="tripid"style="border: 0px solid #000000;" value="<%=trip %>"onclick="dodisable()"/></input></td>
</tr>



<tr>

<td><font size="2" face="Arial"><b>Start Date-Time:</b></font></td>


<td><input type="text" name="startdatetime"style="border: 0px solid #000000;" value="<%=start%>" onclick="dodisable()"/></input></td>
</tr>

<tr>

<td><font size="2" face="Arial"><b>End Date-Time:</b></font></td>

<td><input type="text" name="enddatetime"style="border: 0px solid #000000;" value="<%=end%>" onclick="dodisable()"/></input></td>
</tr>


<tr>
<td><font size="2" face="Arial"><b>Name:</b></font></td>


<td><input type="text" name="entersname"style="width:150px; padding: 4px 5px 2px 5px;
	border-color: activeborder; text-align:left;font: normal 11px Arial, Helvetica, sans-serif;
	color: #000000;"" /></td>
</tr>




<tr>
<td><font size="2" face="Arial"><b>Standard Reason:</b></font></td>
<td>
<select name="comments" style="width: 175px; height: 20px; border: 1px solid black; font: small Arial, Helvetica, sans-serif; color: #000000;border-color: activeborder;">
<option value="-">--Select--</option>
<option value="Traffic Jam">Traffic Jam</option>
<option value="No Entry Area in Day Time">No Entry Area in Day Time</option>
<option value="For Safe Parking">For Safe Parking</option>
<option value="Other">Other</option>

</select>
</tr>



<tr>
<td><font size="2" face="Arial"><b>Reason:</b></font></td>

<td><textarea name="reason" rows="2" id="search-text"
	 style='width: 175px; height: auto; border:1px solid'></textarea>
	 </td>
	 
</tr>






<tr>
<td align="center">
</td>
<td>
<br>
<input type="button" name="submit" value="Submit" onclick="insertfeedbk();"></input>
</td>
</tr>

</table>



</form>


</body>
</html> 