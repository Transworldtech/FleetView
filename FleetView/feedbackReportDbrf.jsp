<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Incidents Feedback Contest - 2012</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript" src="js/view.js"></script>


<script language="javascript">
function validate()
{
	//What are the main cause of the incidents?
	var v1=document.getElementById("element_14_1").value;
	var v2=document.getElementById("element_14_2").value;
	var v3=document.getElementById("element_14_3").value;
	var v4=document.getElementById("element_14_4").value;
	var v5=document.getElementById("element_14_5").value;
	var v6=document.getElementById("element_14_6").value;
	
	//Is there any concern in our driver Management
	var a1=document.getElementById("element_15_1").value;
	var a2=document.getElementById("element_15_2").value;
	var a3=document.getElementById("element_15_3").value;
	var a4=document.getElementById("element_15_4").value;
	var a5=document.getElementById("element_15_5").value;
	var a6=document.getElementById("element_15_6").value;
	var a7=document.getElementById("element_15_7").value;
	var a8=document.getElementById("element_15_8").value;

	//How Do We address our Concern for Driver Management
	var b1=document.getElementById("element_4").value;

	//Is that any thing wrong in our vehicle Management
	var c1=document.getElementById("element_16_1").value;
	var c2=document.getElementById("element_16_2").value;
	var c3=document.getElementById("element_16_3").value;

	//How Do We address our Concern for Vehicle Management
	var d1=document.getElementById("element_5").value;

	//Is there any concern in Surrounding Environment
	var e1=document.getElementById("element_17_1").value;
	var e2=document.getElementById("element_17_2").value;
	var e3=document.getElementById("element_17_3").value;
	var e4=document.getElementById("element_17_4").value;
	var e5=document.getElementById("element_17_5").value;

	//How Do We address our Concern for Journey Management
	var f1=document.getElementById("element_6").value;

	//Is there any concern in Surrounding Environment
	var g1=document.getElementById("element_18_1").value;
	var g2=document.getElementById("element_18_2").value;
	var g3=document.getElementById("element_18_3").value;
	var g4=document.getElementById("element_18_4").value;
	var g5=document.getElementById("element_18_5").value;

	//How Do We address our Concern for Environment
	var h1=document.getElementById("element_7").value;

	var i1=document.getElementById("element_8").value;
	var j1=document.getElementById("element_9").value;
	var k1=document.getElementById("element_10").value;
	var l1=document.getElementById("element_11").value;

	//alert(document.getElementById("element_14_1").checked)
	if( (document.getElementById("element_14_1").checked==false) &&  (document.getElementById("element_14_2").checked==false)  &&  (document.getElementById("element_14_3").checked==false)  &&  (document.getElementById("element_14_4").checked==false) && (document.getElementById("element_14_5").checked==false) && (document.getElementById("element_14_6").checked==false))
	{
		alert("Please Select Values For Main Causes Of Incidents");
		return false;
	}

	if( (document.getElementById("element_15_1").checked==false) &&  (document.getElementById("element_15_2").checked==false) && (document.getElementById("element_15_3").checked==false) && (document.getElementById("element_15_4").checked==false) && (document.getElementById("element_15_5").checked==false) && (document.getElementById("element_15_6").checked==false) && (document.getElementById("element_15_7").checked==false) && (document.getElementById("element_15_8").checked==false) )
	{
		alert("Please Select Values for concern in our Driver Management");
		return false;
	}

	if(b1==null || b1=="")
	{	
		alert("Please Enter How Do We address our Concern for Driver Management");
		return false;
	}

	if( (document.getElementById("element_16_1").checked==false) &&  (document.getElementById("element_16_2").checked==false) && (document.getElementById("element_16_3").checked==false ) )
	{
		alert("Please Select Values For Vehicle Management");
		return false;
	}

	if(d1==null || d1=="")
	{	
		alert("Please Enter How Do We address our Concern for Vehicle Management");
		return false;
	}
	
	
	if( (document.getElementById("element_17_1").checked==false) &&  (document.getElementById("element_17_2").checked==false) && (document.getElementById("element_17_3").checked==false) &&  (document.getElementById("element_17_4").checked==false) && (document.getElementById("element_17_5").checked==false))
	{
		alert("Please Select Values For Concern in Surrounding Environment");
		return false;
	}

	if(f1==null || f1=="")
	{	
		alert("Please Enter How Do We address our Concern for Journey Management");
		return false;
	}

	if( (document.getElementById("element_18_1").checked==false) &&  (document.getElementById("element_18_2").checked==false) && (document.getElementById("element_18_3").checked==false) &&  (document.getElementById("element_18_4").checked==false) && (document.getElementById("element_18_5").checked==false))
	{
		alert("Please Select Values For concern in Surrounding Environment");
		return false;
	}

	if(h1==null || h1=="")
	{	
		alert("Please Enter How Do We address our Concern for Environment");
		return false;
	}
	if(i1==null || i1=="")
	{	
		alert("Please Enter Do We require Cleaner in the Truck");
		return false;
	}
	if(j1==null || j1=="")
	{	
		alert("Please Enter What are the Castrol Policies which are most disturbing and troubling");
		return false;
	}
	if(k1==null || k1=="")
	{	
		alert("Please Enter What are the changes you would like to see in Castrol Policies");
		return false;
	}
	if(l1==null || l1=="")
	{	
		alert("Please Enter Name & Email Address Trainer/Counselor");
		return false;
	}
	return true;
}
</script>
</head>

<body id="main_body" >
<%
String incident=request.getParameter("incidentid");
String driverId=request.getParameter("driverid").toString();
System.out.println(incident+"--------->>"+driverId);
%>
	<img id="top" src="top.png" alt="">
	<div id="form_container">
	
		<h1><a>Incidents Feedback Contest - 2012</a></h1>
		<form id="form_419706" class="appnitro"  method="post" action="feedbackReportInsert.jsp">
					<div class="form_description">
			<p>
Recent Incident Feedback from Drivers, TO be filled at the time of Briefing & Debriefing <br></br>

Top 25 Implementation suggestions will get 2000 Rs each, Every driver will get one opportunity to enter <br></br>

Trainer/Counselor who enters for the driver will get 250 RS for each winner<br></br>

Note: 1. Single Entry is allowed by Each Driver for Each Incident.<br></br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. To be filled by Trainer/Counselor only<br></br>
* Required</p>
		</div>						
			<ul >
			
					<li id="li_1" >
		<label class="description" for="element_1">Driver ID *
 </label>
		<div>
			<input id="element_1" name="element_1" class="element text medium" type="text" maxlength="255" value="<%=driverId%>" readonly="readonly"/> 
		</div><p class="guidelines" id="guide_1"><small> Mention Driver ID</small></p> 
		</li>				<li id="li_14" >
		<label class="description" for="element_14">What are the main cause of the incidents? * </label>
		<span>
			<input id="element_14_1" name="element_14_1" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_14_1">Condition of Vehicle</label>
<input id="element_14_2" name="element_14_2" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_14_2">Driver</label>
<input id="element_14_3" name="element_14_3" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_14_3">Journey</label>
<input id="element_14_4" name="element_14_4" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_14_4">Process</label>
<input id="element_14_5" name="element_14_5" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_14_5">All the four</label>
<input id="element_14_6" name="element_14_6" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_14_6">Other:</label>

		</span><p class="guidelines" id="guide_14"><small>Check the causes of recent Incidents.</small></p> 
		</li>		<li id="li_15" >
		<label class="description" for="element_15">Is there any concern in our driver Management? * </label>
		<span>
			<input id="element_15_1" name="element_15_1" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_1">Driver training</label>
<input id="element_15_2" name="element_15_2" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_2">Driver medical verification</label>
<input id="element_15_3" name="element_15_3" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_3">Driver counseling</label>
<input id="element_15_4" name="element_15_4" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_4">Working hours</label>
<input id="element_15_5" name="element_15_5" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_5">Resting locations</label>
<input id="element_15_6" name="element_15_6" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_6">Mental stress</label>
<input id="element_15_7" name="element_15_7" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_7">Physical stress</label>
<input id="element_15_8" name="element_15_8" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_15_8">Other:</label>

		</span><p class="guidelines" id="guide_15"><small>Is there any concern in our driver Management?</small></p> 
		</li>		<li id="li_4" >
		<label class="description" for="element_4">How Do We address our Concern for Driver Management? * </label>
		<div>
			<textarea id="element_4" name="element_4" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_4"><small>Suggestion to address Concern for Driver Management, Not more than 30 Words</small></p> 
		</li>		<li id="li_16" >
		<label class="description" for="element_16">Is that any thing wrong in our vehicle Management? * </label>
		<span>
			<input id="element_16_1" name="element_16_1" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_16_1">Maintenance</label>
<input id="element_16_2" name="element_16_2" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_16_2">Load Factor</label>
<input id="element_16_3" name="element_16_3" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_16_3">Other:</label>

		</span><p class="guidelines" id="guide_16"><small>Check if any thing wrong in our vehicle Management, current Process & Policy</small></p> 
		</li>		<li id="li_5" >
		<label class="description" for="element_5">How Do We address our Concern for Vehicle Management? *  </label>
		<div>
			<textarea id="element_5" name="element_5" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_5"><small>Suggestion to address Concern for Vehicle Management, Not more than 30 Words</small></p> 
		</li>		<li id="li_17" >
		<label class="description" for="element_17">Is there any concern in our Journey Management? * </label>
		<span>
			<input id="element_17_1" name="element_17_1" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_17_1">Driving hours</label>
<input id="element_17_2" name="element_17_2" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_17_2">Driving restrictions</label>
<input id="element_17_3" name="element_17_3" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_17_3">Recommended routes</label>
<input id="element_17_4" name="element_17_4" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_17_4">Speed</label>
<input id="element_17_5" name="element_17_5" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_17_5">Other:</label>

		</span><p class="guidelines" id="guide_17"><small>Is there any concern in our Journey Management?</small></p> 
		</li>		<li id="li_6" >
		<label class="description" for="element_6">How Do We address our Concern for Journey Management * </label>
		<div>
			<textarea id="element_6" name="element_6" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_6"><small>Suggestion to address Concern for Journey Management, Not more than 30 Words</small></p> 
		</li>		<li id="li_18" >
		<label class="description" for="element_18">Is there any concern in Surrounding Environment? * </label>
		<span>
			<input id="element_18_1" name="element_18_1" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_18_1">Harassment by authorities</label>
<input id="element_18_2" name="element_18_2" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_18_2">Road rage</label>
<input id="element_18_3" name="element_18_3" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_18_3">Huge traffic</label>
<input id="element_18_4" name="element_18_4" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_18_4">Disobedience to rules</label>
<input id="element_18_5" name="element_18_5" class="element checkbox" type="checkbox" value="1" />
<label class="choice" for="element_18_5">Other:</label>

		</span><p class="guidelines" id="guide_18"><small>Is there any concern in Surrounding Environment?</small></p> 
		</li>		<li id="li_7" >
		<label class="description" for="element_7">How Do We address our Concern for Environment? * </label>
		<div>
			<textarea id="element_7" name="element_7" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_7"><small>Suggestion to address Concern for Environment? Not more than 30 words</small></p> 
		</li>		<li id="li_8" >
		<label class="description" for="element_8">Do We require Cleaner in the Truck? * </label>
		<div>
			<textarea id="element_8" name="element_8" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_8"><small>Specify requirement Of Cleaner in the Truck. If Answer is No, Pls Mention How you will be managing the same </small></p> 
		</li>		<li id="li_9" >
		<label class="description" for="element_9">What are the Castrol Policies which are most disturbing and troubling? * </label>
		<div>
			<textarea id="element_9" name="element_9" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_9"><small>Mention Castrol Policies Which are most Disturbing and Troubling</small></p> 
		</li>		<li id="li_10" >
		<label class="description" for="element_10">What are the changes you would like to see in Castrol Policies? * </label>
		<div>
			<textarea id="element_10" name="element_10" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_10"><small>What are the changes you would like to see in Castrol Policies?</small></p> 
		</li>		<li id="li_11" >
		<label class="description" for="element_11">Name & Email Address Trainer/Counselor * </label>
		<div>
			<textarea id="element_11" name="element_11" class="element textarea small"></textarea> 
		</div><p class="guidelines" id="guide_11"><small>Mention Name and Email Address below to Identify the Trainer/Counselor</small></p> 
		
		<li class="buttons">
			    <input type="hidden" name="form_id" value="419706" />
			    
				<input id="saveForm" class="button_text" type="submit" name="submit" onclick="return validate();" value="Submit" />
		</li>
		<li class="section_break">
			<h3>All the contents of this form are confidential and covered by a Non-Disclosure agreement. The information herein is restricted to and intended for the recipient, who agrees to be bound by the NDA. 
<br></br>
Copyright "Transworld Compressor Technologies Ltd"</h3>
			<p></p>
		</li>
			
					
			</ul>
			<input type="hidden" name="incidentId" id="incidentId" value="<%=incident%>" />
		</form>	
	</div>
	<img id="bottom" src="bottom.png" alt="">
	</body>
</html>