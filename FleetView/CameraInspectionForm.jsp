<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Camera Inspection Form</title>
<link rel="stylesheet" type="text/css" href="css/view_cam.css" media="all">
<script type="text/javascript" src="js/view_cam.js"></script>
<script type="text/javascript" src="js/calendar_cam.js"></script>

<script type="text/javascript">

function sdcardID(){

//	var sdcard_present = document.getElementById("sdID").value;
//	alert(">>"+sdcard_present);
	if(document.getElementById('sdID').value=='Yes') {
		//alert(">>>>"+sdcard_present);
		document.getElementById("displayID").style.display="block";
	}else{
		document.getElementById("displayID").style.display="none";
	}
}

function validateForm() 
{	
	var cam_id = document.form_563282.cam_id.value;
	var invalid=/[^0-9]/; //digits only allowed
	if(cam_id == "") {
		alert("Enter Camera ID!");    
		return false;
		}
	if(invalid.test(cam_id))
	{
		alert("Invalid Camera ID!");
		return false;
	}

	var protect_cover_id = document.form_563282.protect_cover_id.value;
	if(protect_cover_id=="") {
		alert("Enter Protected cover ID!");
		return false;
		}
	if(invalid.test(protect_cover_id))
	{
		alert("Invalid Protected cover ID!");
		return false;
	}

	var sdID = document.form_563282.sdID.value;
	if(sdID=="") {
		alert("Enter SD Card present or not!");
		return false;
		}

		if(document.getElementById("displayID").style.display=="block") {
		var sd_id= document.form_563282.sd_id.value;
			if(sd_id=="") {
				alert("Please enter SD Card ID!");
			return false;
		}
			if(invalid.test(sd_id))
			{
				alert("Invalid SD Card ID!");
				return false;
			}
}
    
return true;
}

</script>
 

</head>
<%!Connection conn = null;
   Statement st = null;
%>
<%
String vehcode=request.getParameter("vehcode");
String msg=request.getParameter("Msg");
System.out.println("vehcode = "+vehcode);
System.out.println("msg = "+msg);

Class.forName("org.gjt.mm.mysql.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
st=conn.createStatement();
%>

<%
String vehregno = "",transporter = "";
String sql1 = "select VehicleRegNumber,OwnerName from db_gps.t_vehicledetails where VehicleCode='"+vehcode+"'";
ResultSet rs1 = st.executeQuery(sql1);
if(rs1.next())
{
	vehregno = rs1.getString("VehicleRegNumber");
	transporter = rs1.getString("OwnerName");
}
System.out.println("The registration no is :"+vehregno);
System.out.println("The transporter is :"+transporter);

%>
<body id="main_body" >
	
		
<%
if(msg!=null){
	
	%>
	<script type="text/javascript">
	
	confirmSubmit('<%=vehcode%>');
	function confirmSubmit(vehcode)
	{		
			var agree=confirm("Your form has been successfully saved. Do you want to close the this pop window?");
			if (agree)
			{
				window.close();
				self.close();
				return true ;
			}
			else
			{
				//alert("else");
				window.location="CameraInspectionForm.jsp?vehcode="+vehcode+"";
				return true ;
			}
	}//end of function
	</script>		
	<%
	
	
}else {
	%>
	<img id="top" src="top.png" alt="">
	<div id="form_container">
		
	<h1><a>Camera Inspection Form</a></h1>
	<form id="form_563282" name="form_563282" class="appnitro" enctype="" method="get" action="CameraInspectionConn.jsp" onsubmit="return validateForm()">
		<div class="form_description">
		<table style="width: 600px;" border="0">			
			<tr><td align="left">	
					<a href="http://www.mobile-eye.in" target="_blank"><img src="images/mobile.jpg" style="height: 80px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
			</td><td align="left">
			<h2>Camera Inspection Form</h2></td></tr>
			<tr><td colspan="2"></td></tr>
			<tr><td colspan="2"></td></tr>
			<tr><td colspan="2" align="left"><font><%@ include file="headerpopup1.jsp" %></font></td></tr>	
			</table>			
		</div>						
		<div>	
		<table style="width: 600px;" border="0">
			<tr>
				<td style="width: 140px;text-align: left;"><b>Veh Reg Number</b></td><td style="width: 180px;text-align: left;"><%=vehregno %></td>
				<td style="width: 100px;text-align: left;"><b>Transporter</b></td><td style="width: 230px;text-align: left;"><%=transporter %></td>
			</tr>
		</table></div>
		
		<div class="form_description">
		<br></br>
		</div>	
		
		<table style="width: 600px;" border="0" cellspacing="5" cellpadding="2">	
		<tr><td>		
		<label class="description" for="cam_id1" style="text-align: left;">Camera ID *</label>
		<div style="text-align: left;">
			<input id="cam_id" name="cam_id" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td>
		<td>
		<label class="description" for="element_4" style="text-align: left;">Protective Cover ID *</label>
		<div style="text-align: left;">
			<input id="protect_cover_id" name="protect_cover_id" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td>
		</tr>
		
		<tr><td>		
		<label class="description" for="element_17" style="text-align: left;">SD Card present *</label>
		<div style="text-align: left;">
		<select class="element select medium" id="sdID" name="sdID" style="width: 250px" onchange="return sdcardID();"> 
			<option value="" selected="selected"></option>
			<option value="Yes" >Yes</option>
			<option value="No" >No</option>
		</select>
		</div> 		
		</td>
		<td>
		<div style="display: none" id ="displayID">
		<label class="description" for="sd_id1" style="text-align: left;">SD Card ID *</label>
		<div style="text-align: left;">
			<input id="sd_id" name="sd_id" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div>
		</div> 
		</td>
		</tr>
		</table>
		<input type = "hidden" name ="vehcode" id ="vehcode" value='<%= vehcode%>'></input>
		<input type = "hidden" name ="transporter" id ="transporter" value='<%= transporter%>' maxlength="255"></input>
		<input type = "hidden" name ="vehregno" id ="vehregno" value='<%= vehregno%>' maxlength="255"></input>
		<div class="form_description">
			<p></p>
		</div>	
		<table style="width: 600px;">
		<tr><td align="center">
		<input id="saveForm" class="button_text" type="submit" name="submit" value="Submit" />	
		</td></tr> 			    
					
	</table>
<%} 


%>			
	</form>	
		<div id="footer">
			Generated by <a href="http://www.myfleetview.com" target = "_blank">Transworld Compressor Technologies Ltd.</a>
		</div>
	</div>
	<img id="bottom" src="bottom.png" alt="">
	</body>
</html>