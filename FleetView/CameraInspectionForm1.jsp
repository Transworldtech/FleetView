<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Camera Inspection Form</title>
<link rel="stylesheet" type="text/css" href="css/view_cam.css" media="all">
<script type="text/javascript" src="js/view_cam.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

<script type="text/javascript">
function attach()
{
	try{
	
		
var cnt=document.form_563283.counter.value;
if(cnt>0)
{
	
}
else 
{
cnt=1;
var flagvalue=document.form_563283.flagvalue.value;
flagvalue++;
document.form_563283.flagvalue.value=flagvalue;
document.form_563283.counter.value=cnt;

       document.getElementById("tr1").style.display="";   	
       document.form_563283.Filename1.style.display="";
       document.getElementById("imageDiv").style.display="none";
       document.getElementById("tr2").style.display="";   
}
	}catch(e)
	{
		alert(e);
	}
}

function attach1()
{
	var cnt=document.form_563283.counter.value;
	cnt++;
	document.form_563283.counter.value=cnt;
	document.getElementById("tr5").style.display="";  
	document.form_563283.Filename2.style.display="";
    document.getElementById("imageDiv1").style.display="none" 	
    document.getElementById("tr2").style.display="none"; 
    document.getElementById("tr6").style.display="";  
}
function attach2()
{
	var cnt=document.form_563283.counter.value;
	cnt++;
	document.form_563283.counter.value=cnt;
	document.getElementById("tr7").style.display="";   
	document.form_563283.Filename3.style.display="";
    document.getElementById("imageDiv2").style.display="none"	
    document.getElementById("tr6").style.display="none"; 
    document.getElementById("tr8").style.display="";  
}
function attach3()
{
	var cnt=document.form_563283.counter.value;
	cnt++;
	document.form_563283.counter.value=cnt;
	document.getElementById("tr9").style.display="";   
	document.form_563283.Filename4.style.display="";
    document.getElementById("imageDiv3").style.display="none"	
    document.getElementById("tr8").style.display="none"; 
    document.getElementById("tr10").style.display="";  
}
function attach4()
{
	var cnt=document.form_563283.counter.value;
	cnt++;
	document.form_563283.counter.value=cnt;
	document.getElementById("tr11").style.display="";
	document.form_563283.Filename5.style.display="";
    document.getElementById("imageDiv4").style.display="none"   	
    document.getElementById("tr10").style.display="none"; 
    document.getElementById("tr12").style.display="";  
 }

function upload()
{
	try{
		var id_value = document.getElementById('up').value;
		var file1=document.form_563283.Filename1.value;
	

		 if(id_value != '')
		 { 
			 var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;
			    
		  if(valid_extensions.test(id_value))
		  { 
			
			  document.form_563283.Filename1.style.display="none";
				document.getElementById("imageDiv").style.display="";
				document.getElementById("f1").innerHTML=file1;
			  
		   //alert('OK');
		  }
		 // else if()
		  else
		  {
			 
			 
			 
			 var cnt=document.form_563283.counter.value;
   
    cnt--;
   // alert(cnt);
    if(cnt==0)
    {
    	document.form_563283.counter.value=cnt;
 		cleareall();
 		document.getElementById("f1").innerHTML=""; 	
 		
    }
    else
    {

    document.form_563283.counter.value=cnt;
	 document.form_563283.Filename1.value="";

	 document.form_563283.Filename2.value="";
	     document.getElementById("tr1").style.display="none";   
       document.getElementById("tr2").style.display="none"; 
       document.getElementById("f1").innerHTML=""; 	
}
			  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
		   
		  }
		 }

	
	} catch(e)
	{
		alert(e);
	}

}

function upload1()
{
	try{
		var file1=document.form_563283.Filename2.value;
		var id_value = document.getElementById('up1').value;

		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.ods|.xls|.pdf|.txt~)$/i;
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form_563283.Filename2.style.display="none"
		document.getElementById("imageDiv1").style.display="";
		document.getElementById("f2").innerHTML=file1;
	
		}
		  else
		  {

			  var cnt=document.form_563283.counter.value;
			   
			    cnt--;
			  // alert(cnt);
			    if(cnt==0)
			    {
			    	document.form_563283.counter.value=cnt;
					cleareall();
					document.getElementById("f2").innerHTML=""; 
			    }
			    else
			    {

			    document.form_563283.counter.value=cnt;
				
					  document.form_563283.Filename2.value="";
				       document.getElementById("tr5").style.display="none";   
				       document.getElementById("f2").innerHTML=""; 
			}
			  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
		   
		  }
		 }
	}catch(e)
		{
			alert(e);
		}
}

function upload2()
{
	try{
		var file1=document.form_563283.Filename3.value;
		var id_value = document.getElementById('up2').value;

		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form_563283.Filename3.style.display="none"
		document.getElementById("imageDiv2").style.display="";
		document.getElementById("f3").innerHTML=file1;
			}
			  else
			  {

				  var cnt=document.form_563283.counter.value;
				   
				    cnt--;
				   // alert(cnt);
				    if(cnt==0)
				    {
				    	document.form_563283.counter.value=cnt;
						cleareall();
						document.getElementById("f3").innerHTML=""; 
				    }
				    else
				    {
				 
				    document.form_563283.counter.value=cnt;
					
					 document.form_563283.Filename3.value="";
					document.getElementById("tr7").value=""; 
				       document.getElementById("tr7").style.display="none"; 
				       document.getElementById("f3").innerHTML=""; 
				} 
				  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
			   
			  }
			 }
		}catch(e)
		{
			alert(e);
		}
}

function upload3()
{
	try{
		var file1=document.form_563283.Filename4.value;
		var id_value = document.getElementById('up3').value;

		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form_563283.Filename4.style.display="none"
		document.getElementById("imageDiv3").style.display="";
		document.getElementById("f4").innerHTML=file1;
	}
	  else
	  {
		  var cnt=document.form_563283.counter.value;

		    cnt--;
		    if(cnt==0)
		    {
		    	document.form_563283.counter.value=cnt;
				cleareall();
				document.getElementById("f4").innerHTML=""; 
		    }
		    else
		    {

		    document.form_563283.counter.value=cnt;
			
			 document.form_563283.Filename4.value="";
			document.getElementById("tr9").value=""; 
		    document.getElementById("tr9").style.display="none";
		    document.getElementById("f4").innerHTML=""; 		   
		}
		 
		  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
	   
	  }
	 }
		
		}catch(e)
		{
			alert(e);
		}
}

function upload4()
{
	try{
		var file1=document.form_563283.Filename5.value;
		var id_value = document.getElementById('up4').value;

		 if(id_value != '')
		 { 
			  var valid_extensions = /(.jpg|.jpeg|.doc~|.doc|.txt|.png|.pdf|.ods|.xls|.txt~)$/i;  
		  if(valid_extensions.test(id_value))
		  { 
		//alert(file1);
		
		document.form_563283.Filename5.style.display="none"
		document.getElementById("imageDiv4").style.display="";
		document.getElementById("f5").innerHTML=file1;

	}
	  else
	  {
		  var cnt=document.form_563283.counter.value;

		    cnt--;
		    if(cnt==0)
		    {
		    	document.form_563283.counter.value=cnt;
				cleareall();
				document.getElementById("f5").innerHTML=""; 
		    }
		    else
		    {

		    document.form_563283.counter.value=cnt;
			
			 document.form_563283.Filename5.value="";
			document.getElementById("tr11").value=""; 
		       document.getElementById("tr11").style.display="none";  
		       document.getElementById("f5").innerHTML=""; 
		  	
		}
		  alert("Please Upload only doc,jpg,pdf,png,ods,xls,txt and jpeg Formatted File");
	   
	  }
	 }
		}catch(e)
		{
			alert(e);
		}
}

function cancel()
{
	var cnt=document.form_563283.counter.value;
   
    cnt--;
    if(cnt==0)
    {
    	document.form_563283.counter.value=cnt;
 		cleareall();
 		document.getElementById("f1").innerHTML=""; 	
 		
    }
    else
    {

    document.form_563283.counter.value=cnt;
	 document.form_563283.Filename1.value="";

	 document.form_563283.Filename2.value="";
	     document.getElementById("tr1").style.display="none";   
       document.getElementById("tr2").style.display="none"; 
       document.getElementById("f1").innerHTML=""; 	
}
}
function cancel1()
{
	var cnt=document.form_563283.counter.value;
   
    cnt--;
    if(cnt==0)
    {
    	document.form_563283.counter.value=cnt;
		cleareall();
		document.getElementById("f2").innerHTML=""; 
    }
    else
    {

    document.form_563283.counter.value=cnt;
	
		  document.form_563283.Filename2.value="";
	       document.getElementById("tr5").style.display="none";   
	       document.getElementById("f2").innerHTML=""; 
}
}
function cancel2()
{
	var cnt=document.form_563283.counter.value;
   
    cnt--;
    if(cnt==0)
    {
    	document.form_563283.counter.value=cnt;
		cleareall();
		document.getElementById("f3").innerHTML=""; 
    }
    else
    {
 
    document.form_563283.counter.value=cnt;
	
	 document.form_563283.Filename3.value="";
	document.getElementById("tr7").value=""; 
       document.getElementById("tr7").style.display="none"; 
       document.getElementById("f3").innerHTML=""; 
}
}
function cancel3()
{
	var cnt=document.form_563283.counter.value;

    cnt--;
    if(cnt==0)
    {
    	document.form_563283.counter.value=cnt;
		cleareall();
		document.getElementById("f4").innerHTML=""; 
    }
    else
    {

    document.form_563283.counter.value=cnt;
	
	 document.form_563283.Filename4.value="";
	document.getElementById("tr9").value=""; 
    document.getElementById("tr9").style.display="none";
    document.getElementById("f4").innerHTML=""; 
   
}
}
function cancel4()
{
	var cnt=document.form_563283.counter.value;

    cnt--;
    if(cnt==0)
    {
    	document.form_563283.counter.value=cnt;
		cleareall();
		document.getElementById("f5").innerHTML=""; 
    }
    else
    {

    document.form_563283.counter.value=cnt;
	
	 document.form_563283.Filename5.value="";
	document.getElementById("tr11").value=""; 
       document.getElementById("tr11").style.display="none";  
       document.getElementById("f5").innerHTML=""; 
  	
}
}

//validation of input fields
function validateForm() 
{	
	var sd_card_size = document.form_563283.sd_card_size.value;
	var invalid=/[^0-9]/; //digits only allowed
	if(sd_card_size == "") {
		alert("Enter SD Card Size!");    
		return false;
		}
	if(invalid.test(sd_card_size))
	{
		alert("Invalid SD Card Size!");
		return false;
	}
	

	var camera_seal_broken = document.getElementById("camera_seal_broken").options[document.getElementById("camera_seal_broken").selectedIndex].value;
	if(camera_seal_broken=="") {
		alert("Enter camera seal broken or not!");
		return false;
		}

	var current_seal_id = document.getElementById("current_seal_id").value;
	if(current_seal_id=="") {
		alert("Enter current seal ID!");
		return false;
		}
	if(invalid.test(current_seal_id))
	{
		alert("Invalid current seal ID!");
		return false;
	}

	var new_seal_id = document.getElementById("new_seal_id").value;
	if(new_seal_id!="") {
		
			if(invalid.test(new_seal_id))
			{
				alert("Invalid new seal ID!");
				return false;
			}
		}
	
	
	var camera_stand_id = document.getElementById("camera_stand_id").value;
	if(camera_stand_id=="") {
		alert("Enter camera stand ID!");
		return false;
		}
	if(invalid.test(camera_stand_id))
	{
		alert("Invalid Camera stand ID!");
		return false;
	}
	
	var vedio_duration = document.getElementById("vedio_duration").value;
	if(vedio_duration=="") {
		alert("Enter video duration!");
		return false;
		}
	if(invalid.test(vedio_duration))
	{
		alert("Invalid video duration!");
		return false;
	}
	
	var vedio_size = document.getElementById("vedio_size").value;
	if(vedio_size=="") {
		alert("Enter video size!");
		return false;
		}
	if(invalid.test(vedio_size))
	{
		alert("Invalid video size!");
		return false;
	}
	var sd_size = parseInt(sd_card_size,10);
	var vd_size = parseInt(vedio_size,10);
	//____________________________
	if(vd_size > sd_size)
	{
		alert("video size can not be greater than sd card size!");
		return false;
	}
	
	
	
	var locked_file_count = document.getElementById("locked_file_count").value;
	if(locked_file_count=="") {
		alert("Enter locked file count!");
		return false;
		}
	if(invalid.test(locked_file_count))
	{
		alert("Invalid locked file count!");
		return false;
	}

	var corrup_file_count = document.getElementById("corrup_file_count").value;
	if(corrup_file_count=="") {
		alert("Enter corrupted file count!");
		return false;
		}
	if(invalid.test(corrup_file_count))
	{
		alert("Invalid corrupted file count!");
		return false;
	}

	var file_count = document.getElementById("file_count").value;
	if(file_count=="") {
		alert("Enter file count!");
		return false;
		}
	if(invalid.test(file_count))
	{
		alert("Invalid File count!");
		return false;
	}
	var total = parseInt(corrup_file_count,10) + parseInt(locked_file_count,10);
	var total_file = parseInt(file_count,10);
	//alert(total +" "+total_file);
	if(total_file < total)
	{
		alert("File count should be greater than or equall to the sum of locked file and corrupted file!");
		return false;
	}
	
/*	var element_13_1 = document.getElementById("element_13_1").value;
	if(element_13_1=="") {
		alert("Enter Month of Latest Video date time!");
		return false;
		}
	var element_13_2 = document.getElementById("element_13_2").value;
	if(element_13_2=="") {
		alert("Enter Day of Latest Video date time!");
		return false;
		}
	var element_13_3 = document.getElementById("element_13_3").value;
	if(element_13_3=="") {
		alert("Enter year of Latest Video date time!");
		return false;
		}*/
	/*	var hr = document.getElementById("hr").value;
		if(hr=="0") {
			alert("Enter time of Latest Video date time!");
			return false;
			}
		var min = document.getElementById("min").value;
		if(min=="0") {
			alert("Enter time of Latest Video date time!");
			return false;
			}*/
		
    
return true;
}


</script>

</head>
<%!Connection conn = null;
   Statement st = null;
   Statement st1 = null;
%>
<%
Class.forName("org.gjt.mm.mysql.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps","fleetview","1@flv");
st=conn.createStatement();
st1=conn.createStatement();
%>
<%
int counter=0;
	
	String vehcode = request.getParameter("vehcode");
	String vehregno = request.getParameter("vehregno");
	String transporter = request.getParameter("transporter");
	String camID = request.getParameter("camID");
	String protect_cover_id = request.getParameter("protect_cover_id");
	String sd_card_present = request.getParameter("sd_card_present");
	String sd_id = request.getParameter("sd_id");
	String username = request.getParameter("user");
	String msg = request.getParameter("Msg");
	
	System.out.println("vehcode = "+vehcode);
	System.out.println("transporter = "+transporter);
	System.out.println("vehregno = "+vehregno);
	System.out.println("camID = "+camID);
	System.out.println("protect_cover_id = "+protect_cover_id);
	System.out.println("sd_card_present = "+sd_card_present);
	System.out.println("sd_id = "+sd_id);
	System.out.println("username = "+username);
	System.out.println("msg = "+msg);

	if(msg == "update" || msg.equals("update")) {
		
		String sql1 = "update db_gps.t_vehcileperipheral SET ProtectiveCoverId = '"+protect_cover_id+"', SdCardPresent = '"+sd_card_present+"', SdCardId = '"+sd_id+"' , EntryBy ='"+username+"' , InsertionDateTime = '"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"' where Vehiclecode = '"+vehcode+"' AND PeripheralSrNo = '"+camID+"' ";
		System.out.println("Query is "+sql1);
		st.execute(sql1);
		System.out.println("Record has been successfully inserted into masters form");
		

		//update history table
		String sql2 = "insert into db_gps.t_vehcileperipheralhistory(Vehiclecode,PeripheralSrNo,ProtectiveCoverId,SdCardPresent,SdCardId,EntryBy,InsertionDateTime) values('"+vehcode+"','"+camID+"','"+protect_cover_id+"','"+sd_card_present+"','"+sd_id+"','"+username+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')";
		System.out.println("Query is "+sql2);
		st1.execute(sql2);
		System.out.println("Record has been successfully inserted into history form");
		
	}else {
		String sql1 = "insert into db_gps.t_vehcileperipheral(Vehiclecode,PeripheralSrNo,ProtectiveCoverId,SdCardPresent,SdCardId,EntryBy,InsertionDateTime) values('"+vehcode+"','"+camID+"','"+protect_cover_id+"','"+sd_card_present+"','"+sd_id+"','"+username+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')";
		System.out.println("Query is "+sql1);
		st.execute(sql1);
		System.out.println("Record has been successfully inserted into masters form");
		

		//update history table
		String sql2 = "insert into db_gps.t_vehcileperipheralhistory(Vehiclecode,PeripheralSrNo,ProtectiveCoverId,SdCardPresent,SdCardId,EntryBy,InsertionDateTime) values('"+vehcode+"','"+camID+"','"+protect_cover_id+"','"+sd_card_present+"','"+sd_id+"','"+username+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"')";
		System.out.println("Query is "+sql2);
		st1.execute(sql2);
		System.out.println("Record has been successfully inserted into history form");
	}
	
%>
<body id="main_body" >
	
	<img id="top" src="top.png" alt="">
	<div id="form_container">
	
	<h1 align="center"><a>Camera Inspection Form</a></h1>
	<form id="form_563283" name ="form_563283" class="appnitro" enctype="multipart/form-data" method="post" action="CameraInspectionConn1.jsp" onsubmit="return validateForm()">
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
		<label class="description" for="element_15" style="text-align: left;">SD Card Size(GB) *</label>
		<div style="text-align: left;">
			<input id="sd_card_size" name="sd_card_size" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td>
		<td>
		<label class="description" for="element_18" style="text-align: left;">Camera Seal Broken? *</label>
		<div style="text-align: left;">
		<select class="element select medium" id="camera_seal_broken" name="camera_seal_broken" style="width: 250px"> 
			<option value="" selected="selected"></option>
			<option value="Yes" >Yes</option>
			<option value="No" >No</option>
		</select>
		</div> 
		</td></tr>
		
		<tr><td>
		<label class="description" for="element_2" style="text-align: left;">Current Seal ID *</label>
		<div style="text-align: left;">
			<input id="current_seal_id" name="current_seal_id" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td>
		<td>
		<label class="description" for="element_3" style="text-align: left;">New Seal ID </label>
		<div style="text-align: left;">
			<input id="new_seal_id" name="new_seal_id" class="element text medium" type="text" maxlength="255" style="width: 250px"  value=""/> 
		</div> 
		</td></tr>
		
		<tr><td>
		<label class="description" for="element_5" style="text-align: left;">Camera Stand ID *</label>
		<div style="text-align: left;">
			<input id="camera_stand_id" name="camera_stand_id" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td>
		<td>
		<label class="description" for="element_9" style="text-align: left;">Video Duration(mm) *</label>
		<div style="text-align: left;">
			<input id="vedio_duration" name="vedio_duration" class="element text medium" type="text" maxlength="255" style="width: 250px"  value=""/> 
		</div> 
		</td>
		</tr>
		
		<tr>
		<td>
		<label class="description" for="element_10" style="text-align: left;">Video Size(GB) *</label>
		<div style="text-align: left;">
			<input id="vedio_size" name="vedio_size" class="element text medium" type="text" maxlength="255" style="width: 250px"  value=""/> 
		</div> 
		</td><td>
		<label class="description" for="element_11" style="text-align: left;">Locked File Count *</label>
		<div style="text-align: left;">
			<input id="locked_file_count" name="locked_file_count" class="element text medium" type="text" maxlength="255" style="width: 250px"  value=""/> 
		</div> 
		</td></tr>
		
		<tr>
		<td>
		<label class="description" for="element_12" style="text-align: left;">Corrupt File Count *</label>
		<div style="text-align: left;">
			<input id="corrup_file_count" name="corrup_file_count" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td><td>
		<label class="description" for="element_8" style="text-align: left;">File Count *</label>
		<div style="text-align: left;">
			<input id="file_count" name="file_count" class="element text medium" type="text" maxlength="255" style="width: 250px" value=""/> 
		</div> 
		</td></tr>
		<tr>
<!--		<tr><td>-->
<!--		<label class="description" for="element_13" style="text-align: left;">Latest Video date time</label>-->
<!--		<div style="text-align: left;">-->
<!--		<span>-->
<!--			<input id="element_13_1" name="element_13_1" class="element text" size="2" maxlength="2" value="" type="text"> /-->
<!--			<label for="element_13_1">MM</label>-->
<!--		</span>-->
<!--		<span>-->
<!--			<input id="element_13_2" name="element_13_2" class="element text" size="2" maxlength="2" value="" type="text"> /-->
<!--			<label for="element_13_2">DD</label>-->
<!--		</span>-->
<!--		<span>-->
<!--	 		<input id="element_13_3" name="element_13_3" class="element text" size="4" maxlength="4" value="" type="text">-->
<!--			<label for="element_13_3">YYYY</label>-->
<!--		</span>-->
<!--	-->
<!--		<span id="calendar_13">-->
<!--			<img id="latest_vedio_date_time" class="datepicker" src="images/calendar.gif" alt="Pick a date.">	-->
<!--		</span>-->
<!--		<script type="text/javascript">-->
<!--			Calendar.setup({-->
<!--			inputField	 : "element_13_3",-->
<!--			baseField    : "element_13",-->
<!--			displayArea  : "calendar_13",-->
<!--			button		 : "cal_img_13",-->
<!--			ifFormat	 : "%B %e, %Y",-->
<!--			onSelect	 : selectDate-->
<!--			});-->
<!--		</script>-->
<!--		</div>-->
<!--		</td>-->
	
		<td>
		<label class="description" for="element_13" style="text-align: left;">Latest Video date time</label>
		<div style="text-align: left;">
			<input type="text" id="data1" name="data" size="12" value="<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%>"style="width: 140px; height: 15px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; text-align: center;" readonly/>
			
<!--			<label><font size="2">HH</font></label> -->
<!--			<input type="text" class="element text medium" id="hr" name="hr" style="width: 40px;" /> -->
<!--					-->
<!--			<label for="element_2_1"><font size="2">MM</font></label>-->
<!--			<input type="text" id="min" name="min" class="element text medium" type="text" style="width: 40px;" > -->
			
				<img src="images/calendar.gif" id="trigger" class="formElement">
				<script type="text/javascript">
				  Calendar.setup(
				    {
				      inputField  : "data1",         	// ID of the input field
				      ifFormat    : "%d-%b-%Y %H:%M",     	// the date format 
				      button      : "trigger" ,  			 
				      showsTime	: "true"				// Allow Time Selection
				    }
				  );
				</script>		
		</div>			
		</td>
		
		<td> 		
		<label class="description" for="element_16" style="text-align: left;">Upload File </label>
		<div style="text-align: left;">
			<input id="element_16" name="element_16" class="element file" type="file"/> 
		</div> 
		
		
		</td>
		</tr>
		</table>
		<input id="cam_id" class="button_text" type="hidden" name="cam_id" value="<%=camID %>" />
		<input id="veh_code" class="button_text" type="hidden" name="veh_code" value="<%=vehcode %>" />
		<div class="form_description">
			<p></p>
		</div>
		
		<table style="width: 600px;" border="0">
			    <tr><td>
					<input id="saveForm" class="button_text" type="submit" name="submit" value="Submit" />
				</td></tr>
		</table>
	</form>	
		<div id="footer">
			Generated by <a href="http://www.myfleetview.com" target = "_blank">Transworld Compressor Technologies Ltd.</a>
		</div>
	</div>
	<img id="bottom" src="bottom.png" alt="">
	</body>
</html>