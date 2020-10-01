<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.DebriefSubmitData"
	import="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	import="com.transworld.fleetview.framework.DebriefSubmitViewData"
	import="com.transworld.fleetview.framework.ReasonOfRejection"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberForTransporter"
	import="com.fleetview.beans.DisconnectionCount"
	import="com.transworld.fleetview.framework.PeripheralOfUnitDuringTrip"
	import="com.transworld.fleetview.framework.DriverDebriefForTrip"
	import="com.transworld.fleetview.framework.DebriefSubmitShowOpenTripsData"
	%>
<%@ include file="headernew.jsp"%>
<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<jsp:useBean id="debriefSubmitViewDataProvider"
	type="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	scope="application"></jsp:useBean>
<%!
Connection con1;

int id= 0;
%>

<%
con1 = fleetview.ReturnConnection();
Statement st=con1.createStatement();
Statement st1=con1.createStatement();
Statement st41=con1.createStatement();
Statement st411=con1.createStatement();
%>
	

<%@page import="java.util.Date"%>
<%@page import="javax.print.DocFlavor.STRING"%><html >
<head>

<title>Driver Briefing Details</title>
<link rel="stylesheet" type="text/css" href="css/view1.css" media="all">
<style type="text/css">
<!--
h1
{

 font-size: 22px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 margin: 14px 0px 7px 0px;
 padding: 0px;

}
h2
{

 font-size: 17px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 padding: 0px;
 margin: 14px 0px 7px 0px;

}
h3
{

 font-size: 14px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 padding: 0px;
 margin: 14px 0px 7px 0px;

}
p
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 line-height: 130%;
 margin: 7px 0px 7px 0px;

}
ul
{

 list-style-position: inside;
 list-style-type: square;
 margin: 7px 0px 7px 0px;
 
 padding: 0px;

}
li
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 margin: 1px 0px 1px 0px;
 
 padding: 0px;

}
a
{

 color: #0000ff;
 text-decoration: underline;

}
a:hover
{

 color: #0000ff;
 text-decoration: none;

}
.cbFormLabel
{

 font-size: 13px;
 font-family: Arial;
 font-style: normal;
 font-weight: ;

}
.cbFormLabelError
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormError
{

 color: #ff0000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;
 text-align: left;
 vertical-align: middle; 
 
 margin-left: 5px;

}
.cbFormTable
{

 border-collapse: collapse;

}
.cbFormTableRow
{

 padding: 7px;

}
.cbFormLabelCell
{

 text-align: left;
 vertical-align: top;
 width: auto;
 font-size: 13px;
 font-family: Arial;
 padding: 3px;
 white-space: normal;

}
.cbFormTextField
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormTextArea
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormPassword
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 padding: 1px 1px 1px 1px;

}
.cbFormFieldCell
{
 font-size: 12px;
 font-family: Arial;
 text-align: left;
 vertical-align: top;
 padding: 3px;
 white-space: nowrap;

}
.cbFormDataCell
{

 text-align: left;
 vertical-align: top;
 width: auto;
 padding: 3px;
 white-space: normal;

}
.cbHTMLBlockContainer
{

 text-align: left;
 vertical-align: top;
 padding: 3px;

}
.cbFormNestedTable
{

 height:100%;
 border-collapse:collapse;
 padding: 0px;
 border: none;

}
.cbFormNestedTableContainer
{

 text-align: left;
 vertical-align: top;
 padding: 0px;

}
.cbFormLabelRequired
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: bold;

}
.cbFormRequiredMarker
{

 font-size: 12px;
 font-family: Arial;
     
 margin-left: 2px;
 font-style: normal;
 font-weight: bold;

}
.cbFormData
{

 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormCalendar
{

 padding-left:5px;

}
.cbFormErrorMarker
{

 margin-right:5px;
}
.cbFormSelect
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormFile
{

 color: #000000;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;

}
.cbFormDataLink
{

 color: #0000ff;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 text-decoration: underline;

}
.cbFormDataLink:hover
{

 color: #0000ff;
 font-size: 12px;
 font-family: Arial;
 font-style: normal;
 font-weight: normal;
 text-decoration: none;

}
.cbSubmitButton
{

 font-weight: normal;
 
 width: auto;
 height: auto;
 margin: 0 3px;

}
.cbSubmitButton_hover
{

 font-weight: normal;
 
 width: auto;
 height: auto;
 margin: 0 3px;

}
.cbSubmitButtonContainer
{

 padding: 3px;
 text-align: center;
 vertical-align: middle;

}

-->

.popup {
	background-color: #98AFC7;
	position: absolute;
	visibility: hidden;
}
.popupnew { 
	background-color : #98AFC7;
	position: absolute;
	visibility: visible;
}
.popupx { 
	background-color : #98AFC7;
	position: absolute;
	visibility: hidden;
}
</style>
</head>

<script>

function CheckCleanner(driverId)
{ 
	//alert("asdasd"+driverId);

	//alert("asdasd");
		var TripID=document.getElementById("tripid").innerHTML;
		var TripID1=document.getElementById("TripIdN").value;
		var CleanerId=document.getElementById("CleanerId").value;
				
		if(CleanerId==0000 || CleanerId== "0000"){
			
		}else{	
		  var ajaxRequest;  // The variable that makes Ajax possible!
		  var tripid1="";
	      var vehicle="";
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
	                
	          // Create a function that will receive data sent from the server
	            ajaxRequest.onreadystatechange = function()
	            {
	     	       if(ajaxRequest.readyState == 4)
	                {
	                      var reslt=ajaxRequest.responseText;
	                      reslt=reslt.replace(/^\s+|\s+$/g,'');
	                      r1=reslt.split("~");
	                     // alert(reslt);  
	              			if(r1[0]=="False")
	              			{
	              			if(r1[1]=="NotBrif")
	              				{
	              				alert("Cleaner ID is not valid!.If cleaner is absent,then enter as 0000 ");
	              				document.getElementById("CleanerId").value="";
	              				document.getElementById("CleanerId").focus();
	              				
	              				}else
	              					{
		              				alert("Cleaner ID is not valid!. If cleaner is absent,then enter as 0000 " );	              					
	              					}	              			
	              			}
	              			                                        						                      
	 	       } 
	            };
	           var queryString = "?tripid="+TripID+"&DriveId="+driverId+"&CId="+CleanerId;
	 	   ajaxRequest.open("GET", "driver_debrifing_Reg_New_Ajax.jsp" + queryString, true);
	 	   ajaxRequest.send(null); 
		
		//-----------------------------------------------------------------------
		

		}

		
}


function open1()
{

	var vehRejected=document.getElementById("VehNo1").value;


	testwindow = window.open("driver_briefing_Vehicle_Reject.jsp?VehRNo1="+vehRejected,"Rejection","width=800,menubar=1,resizable=1,height=200,scrollbars=yes");
		testwindow.moveTo(250,250);
			window.close();
	



		//testwindow.moveTo(250,250);
}



function addUser() {
	try
	{
	
    var src = document.register.resources;
    var dest = document.register.assigned;
	
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                 document.getElementById("dest1").value=newOption.text;
                count--;
        }
    }
	}
	catch(e)
	{
		//alert(e);
	}
}

function removeUser() {
    var src = document.register.assigned;
    var dest =  document.register.resources;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                        
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                        
                 }
                count--;
        }
    }
}

function addUser2() {
	try
	{
	
    var src2 = document.register.resources2;
    var dest2 = document.register.assigned2;
	
    for(var count=0; count < src2.options.length; count++) {
 
        if(src2.options[count].selected == true) {
                var option = src2.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest2.add(newOption, null); //Standard
                         src2.remove(count, null);
                 }catch(error) {
                         dest2.add(newOption); // IE only
                         src2.remove(count);
                 }
                 document.getElementById("dest2").value=newOption.text;
                count--;
        }
    }
	}
	catch(e)
	{
	//	alert(e);
	}
}

function removeUser2() {
    var src2 = document.register.assigned2;
    var dest2 =  document.register.resources2;
 
    for(var count=0; count < src2.options.length; count++) {
 
        if(src2.options[count].selected == true) {
                var option = src2.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest2.add(newOption, null); //Standard
                         src2.remove(count, null);
                        
                 }catch(error) {
                         dest2.add(newOption); // IE only
                         src2.remove(count);
                        
                 }
                count--;
        }
    }
}

function GetVeh(drverid,drivernam,transporter)
{
	try{

		//validate();
		var CleanerId=document.getElementById("CleanerId").value;
		var CleanerName=document.getElementById("CleanerName").value;
		var invalid1=/^[A-Za-z .]+$/;
		var EmailId=document.getElementById("EmailId").value;
	/* if(CleanerId.trim()=="")
	{
		alert("Please Enter The Cleaner Passport ID .");
		return false;
		
	}
	
	
 	if(CleanerName.trim()=="")
	{
		alert("Please Enter the Cleaner Name.");
		return false;
	}
	if(!invalid1.test(CleanerName)){
		alert("Please Enter Only Character value for Cleaner Name");
		     return false;
		 }	
	 */
	
		//alert(DriveId+": "+BrifId+" : "+TripId)
		var vehrejj=document.getElementById("VehRegNo").value;
		var TripID=document.getElementById("TripIdN").value;
		var EmailId=document.getElementById("EmailId").value;
		showtext1();
		showtext();
		//alert("Hii");
		var b=0;
		//var reason1=document.getElementById("reason1").value;
		//var reason2=document.getElementById("reason2").value;
		var reason1="";
		var reason2="";

		if(TChkAdh=="Yes")
		 {
			 var src = document.register.assigned;
		 for(var count=0; count < src.options.length; count++) 
			 {
			    var option = src.options[count];
			    if(count==0)
			    	reason1+=option.value;
			    else
			    reason1+="~"+option.value;
			  
				}
		 }
		 else
		 {
			 reason1="-";
		 }
			
		 if(TChkAdhJ=="Yes")
			{
				var src = document.register.assigned2;
			 for(var count=0; count < src.options.length; count++) 
				 {
				    var option = src.options[count];
				    if(count==0)
				    	reason2+=option.value;
				    else
				    reason2+="~"+option.value;
				 }
				   
			}
			else
			{
				reason2="-";
			}


		
		//alert("Adh: "+TChkAdh+" Adhj:"+TChkAdhJ+" Reson:"+reason1+" Reson2:"+reason2);
		
		/* if((TChkAdh=="Yes" && reason1=="")||(TChkAdhJ=="Yes" && reason2=="")||(flg1==0||flg2==0))
		{
		alert("Some Fields Are Missing");
		return false;
		} */
		if(TChkAdh=="Yes" && reason1=="")
				{
			
			alert("Please Select Reasons for Driver");
			return false;
				}
		
		if(TChkAdhJ=="Yes" && reason2=="")
				{
			
			alert("PLease Select Reason for Vehicle");
			return false;
				}
		var x=EmailId;
		if(EmailId.length!=0)
			{
			
			 var atpos = x.indexOf("@");
			    var dotpos = x.lastIndexOf(".");
			    if (atpos< 1 || dotpos<atpos+2 || dotpos+2>=x.length)
			    {
			        alert("Please enter valid E-mail id for Escalate Rejection To");
			        return false;			
		   	}
			    
			}
		if(CleanerId.trim()=="")
		{
			alert("Please Enter The Cleaner Passport ID .");
			return false;
			
		}
		
		
	 	if(CleanerName.trim()=="")
		{
			alert("Please Enter the Cleaner Name.");
			return false;
		}
		if(!invalid1.test(CleanerName)){
			alert("Please Enter Only Character value for Cleaner Name");
			     return false;
			 }
		
		else
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

				reslt=reslt.replace(/^\s+|\s+$/g,'');

				if(reslt=="Updated")
					{alert("Record updated Succesfully");
					window.location.href="Driver_briefing_New.jsp";
					}
			
				}catch(e)
				{
			//	alert(e);
				}
			} 
		};


		
		var queryString = "?ChkAdh="+TChkAdh+"&ChkAdhJ="+TChkAdhJ+"&reason1="+reason1+"&reason2="+reason2+"&DriveId="+drverid+"&DName="+drivernam+"&trans="+transporter+"&VehRegNo="+vehrejj+"&TripID="+TripID+"&EmailId="+EmailId+"";
		ajaxRequest.open("GET", "VehReject_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 

		}
		}
	    catch(e)
		{
		//	alert(e);
		}

}


function showtext()
{
	try{
			 var Val1 = document.getElementsByName("ChkAdh");
			 var Val2 = document.getElementsByName("ChkAdhJ");
			 var check = document.getElementById("Section1");
		flg1=0;
		var ChkVal1=0,ChkVal2=0;
	  for ( var i = 0; i < Val1.length; i++ ) 
		  {
	 		if ( Val1[i].checked==true)
		 		{
		 		TChkAdh=Val1[i].value;
		 		flg1=1;
	 			if ( Val1[i].value=='Yes')
	 				{
	 				ChkVal1=1;
	 				
	 				//document.getElementById("tr1").style.display = "";
	 				//document.getElementById("tr4").style.display="";
	 				//document.getElementById("email").style.display="";
	 				
	 				//check.style.display='none';
	 					
		 			}
	 			else
	 			{
	 			//	document.getElementById("tr1").style.display = "none";
 				//document.getElementById("tr4").style.display="none";
 				//document.getElementById("email").style.display="none";
 				
 				//check.style.display='inline';
 	
				} 
		 	 }	
		  }
	  
		if(flg1==0)
		{
		alert("Please Select Option"+flg1);
			}
	
	
	
		
		
		 flg2=0;
		  for ( var i = 0; i < Val2.length; i++ ) 
			  {
		 		if ( Val2[i].checked==true)
			 		{
		 			TChkAdhJ =Val2[i].value;
		 			flg2=1;
		 			if ( Val2[i].value=='Yes')
		 				{
		 				ChkVal2=1;
		 				//document.getElementById("tr2").style.display = "";
		 				//document.getElementById("tr4").style.display="";
		 				//document.getElementById("email").style.display="";
		 				
		 				//check.style.display='none';
		 				
			 			}
		 			else
		 			{
		 				//document.getElementById("tr2").style.display = "none";
	 				//document.getElementById("tr4").style.display="none";
	 				//document.getElementById("email").style.display="";
	 				
	 				//check.style.display='inline';
	 				
					}
			 	 }	
			  }
		  if(flg2==0)
			{
			alert("Please Select Option");
				}
		  
		//	alert("ChkVal1"+ChkVal1+"  ChkVal2"+ChkVal2);
		   if(ChkVal1=='1'|| ChkVal2=='1')
			   	{
			   	
			   if(ChkVal1=='1')
				   {document.getElementById("tr1").style.display = "";}
			   else
				   {document.getElementById("tr1").style.display = "none";}
				
			   if(ChkVal2=='1')
					{document.getElementById("tr2").style.display = "";}
			   else{document.getElementById("tr2").style.display = "none";}
					
				
				document.getElementById("tr4").style.display="";
				
				//check.style.display='none';
			  	}else
			  		{
			  		document.getElementById("tr1").style.display = "none";
			  		document.getElementById("tr2").style.display = "none";
			  		document.getElementById("tr4").style.display="none";
	 				
	 				check.style.display='inline';
			  		}
		   
		  
		  
		}catch(e)
		{
	//	alert(e);
			}
}

function showtext1()
{
	try{
	 var Val2 = document.getElementsByName("ChkAdhJ");
	 var check = document.getElementById("Section1");
	 flg2=0;
	  for ( var i = 0; i < Val2.length; i++ ) 
		  {
	 		if ( Val2[i].checked==true)
		 		{
	 			TChkAdhJ =Val2[i].value;
	 			flg2=1;
	 			if ( Val2[i].value=='Yes')
	 				{
	 				document.getElementById("tr2").style.display = "";
	 				document.getElementById("tr4").style.display="";
	 				//check.style.display='none';
	 				
		 			}
	 			else
	 			{document.getElementById("tr2").style.display = "none";
 				document.getElementById("tr4").style.display="none";
 				check.style.display='inline';
 				
				}
		 	 }	
		  }
	  if(flg2==0)
		{
		alert("Please Select Option");
			}
	}catch(e)
	{
//	alert(e);
		}
}


function chkReject()
{
	try{


		var VehRegNo=document.getElementById("VehRegNo").value;
		//alert(VehRegNo);

		
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
				var r1;
				reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert(reslt);
				r1=reslt.split(",");
				
			
			
				if(r1[0]=="Yes")
					{
					
	 				document.getElementById("td111").style.display = "";
	 				
	 				document.getElementById("VehNo1").value = r1[1];
		 			}
	 			else
	 			{document.getElementById("td111").style.display = "none"; 				
				}

				}catch(e)
				{
				//alert(e);
				}
			} 
		};


		
		var queryString = "?&VehRegNo="+VehRegNo+"";
		ajaxRequest.open("GET", "VehReject_Check_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 

		}
	    catch(e)
		{
		//	alert(e);
		}

	
	
	
}









function validate()
{
	//var TripID=document.getElementById("tripid").innerHTML;
	//var TripID1=document.getElementById("TripIdN").value;
	
	  
}


function toggleDetails(id, show)
{
   
	var popup = document.getElementById("popup"+id);
       	if (show) 
	{
		popup.style.visibility = "visible";
		popup.setfocus();
		
	}
	else
	{
		popup.style.visibility = "hidden";
	}
}

function toggleDetails1(id, show)
{	
	var popupx = document.getElementById("popupx"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
	} else {
		popupx.style.visibility = "hidden";
	}
}




function showHideTable(id)
{

	
	var tr=document.getElementById("tabl");
	//alert(id);
	
	var cnt=document.getElementById("cnt").value;
	var radList = document.getElementsByName("debrifRadioId");
		
		/*for (var i = 0; i < radList.length; i++) {
			var c=i+1;
			alert(c);
			if(c==id){
				alert(c);
				break;
			}
			else if(radList[i].checked){
				alert("hii");
				 radList[i].checked = false;
			}
		}*/
	//	alert(document.getElementById("debrifRadioId"+id).checked);
		
		if(document.getElementById("debrifRadioId"+id).checked==true)
		{
			var rad=document.getElementById("debrifRadioId"+id);
			var data=rad.value;
		//	alert(data);
			sp=data.split("#");
		}

		try{
		
		document.getElementById("tripid").innerHTML=sp[0];
		document.getElementById("TripIdN").value=sp[0];
		document.getElementById("EDate").innerHTML=sp[2];
		document.getElementById("startplace").innerHTML=sp[3];
		document.getElementById("element_2").innerHTML=sp[4];
		document.getElementById("Veh11").innerHTML=sp[8];
		chkReject();
		}
		catch(e)
		{
	//alert(e);
			}
	

		
	tr.style.display='';
	//-----------------------------------------------------------------------
	
	  var ajaxRequest;  // The variable that makes Ajax possible!
	  var tripid1="";
      var vehicle="";
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
                
          // Create a function that will receive data sent from the server
            ajaxRequest.onreadystatechange = function()
            {
     	       if(ajaxRequest.readyState == 4)
                {
                      var reslt=ajaxRequest.responseText;
                      var resnew=reslt.split("#");

                      tripid1=resnew[0];
                      vehicle=resnew[1];
                      var unitType=resnew[2];
						if(unitType.indexOf("JRM+Buzzer")==-1)
						{
							
							document.getElementById("jrmDevice").style.display='none';
						}
						else{
							document.getElementById("jrmDevice").style.display='';
						}
					                      
 	       } 
            };
           var queryString = "?tripid="+sp[0]+"&startDate="+sp[1]+"&endDate="+sp[2];
 	   ajaxRequest.open("GET", "unitTypeInVehicle.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
	
	//-----------------------------------------------------------------------
	



	
}





</script>

<%!
	private String getTripStartDate(final String datetime) {
		String fromdate = "";
		try {
			fromdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
					.parse(datetime));
			
		} catch (Exception e) {
			try {
				fromdate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(datetime));
				
			} catch (Exception e1) {
				try{
					fromdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.parse(datetime));
				}
				catch(Exception e2){
					try{
					fromdate = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("yyyy-MM-dd")
							.parse(datetime));
					}
					catch(Exception e3){
						
					}
				}
			}
		}
		return fromdate;
	}

	private String getTripEndDate(final String datetime) {
		String todate = "";
		try {
			todate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss")
					.parse(datetime));
			
		} catch (Exception e) {
			try{
				todate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(datetime));
			}catch(Exception e1){
				try{
					todate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
					.parse(datetime));
				}
					catch(Exception e2){
						try{
						todate=new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("yyyy-MM-dd")
						.parse(datetime));
						}
						catch(Exception e3){
							
						}
						
					}
			}
		}
		
		return todate;
	}

	private String getTripStartTimeHrs(final String datetime) {
		String ftime1 = "00";
		try {
			ftime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ftime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ftime1 = "00";
			}
		}
		return ftime1;
	}

	private String getTripStartTimeMins(final String datetime) {
		String ftime2 = "00";
		try {
			ftime2 = new SimpleDateFormat("mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ftime2 = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ftime2 = "00";
			}
		}
		return ftime2;
	}
	
	private String getTripStartTimeSeconds(final String datetime) {
		String ftime3 = "00";
		try {
			ftime3 = new SimpleDateFormat("ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ftime3 = new SimpleDateFormat("ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ftime3 = "00";
			}
		}
		return ftime3;
	}

	private String getTripEndTimeHrs(final String datetime) {
		String ttime1 = "23";
		try {
			ttime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ttime1 = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ttime1 = "23";
			}
		}
		return ttime1;
	}

	private String getTripEndTimeMins(final String datetime) {
		String ttime1 = "59";
		try {
			ttime1 = new SimpleDateFormat("mm").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ttime1 = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ttime1 = "59";
			}
		}
		return ttime1;
	}
	
	private String getTripEndTimeSeconds(final String datetime) {
		String ttime3 = "00";
		try {
			ttime3 = new SimpleDateFormat("ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(datetime));
		} catch (Exception e) {
			try{
				ttime3 = new SimpleDateFormat("ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime));
			}
			catch(Exception ex){
				ttime3 = "00";
			}
		}
		return ttime3;
	}

	
	
	private boolean isNull(final String input){
		return (null == input) || (input.trim().length()< 1) ? true : false; 
	}
	
%>
<%	System.out.println("Driver");
	final String lastmnthdate="", lastsixdate="", riskratingfrmtd="";
	final String trainerName = (String) session.getAttribute("user");
	final String drverid=request.getParameter("driverid");
	final String driverID=request.getParameter("driverid");
	st1=con1.createStatement();

	final String drivernam=request.getParameter("drivername");
	final String driverName=request.getParameter("drivername");
	int numOfVehRecords=0;
	//final String briefId = request.getParameter("briefid");
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String tdydte1=formatter.format(tdydte);
	NumberFormat nf = DecimalFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);	
	nf.setGroupingUsed(false);
	int numRecords=0;
	int numRecordsFor=0;
	final String trans=request.getParameter("trans");
	final String transname=request.getParameter("trans");
	final String transporter=request.getParameter("trans");
	List<VehicleRegistrationNumberForTransporter> VehRegNumber=null;
	session.setAttribute("drivername",drivernam);
	session.setAttribute("driverid",drverid);
	session.setAttribute("tname",transname);
	List<String> castrolZones =null;
	String Tripid="",VehRegNo="",startplace="",endplace="",probenddate="" ;
	
	
	int i=0;
	String limit="1";
	List<DebriefSubmitData> data = 	null;
	List<DebriefSubmitShowOpenTripsData> openTripsData = null;
	List<PeripheralOfUnitDuringTrip> peripheral=null;
	List<DebriefSubmitViewData> viewData= null;
	List<DriverDebriefForTrip> tripDebriefData = null;
	int numTriptripDebrief=0;
	int numOfPeripheralRecords=0;
	String driverMobileNumber="";
	String tripid="";
	String briefId="-";
	String feedBackReply="-";
	String tripStartDate="",tripEndDate="";
	int openTripRecords = 0;
	
	
	String startplace1="",desttplace1="";
	
	
	
	
	try{		
		data = vehicleDao.getDebriefSumbitData(session.getAttribute("usertypevaluemain").toString(),driverName,driverID,limit);
		if(data.size()>0){
		viewData = debriefSubmitViewDataProvider.getDebriefSubmitViewData(data,driverName,driverID);
		numRecords=viewData.size();
		}
	//	out.println("numREc===>"+numRecords);
	//	System.out.println("numREc===>"+numRecords);
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	
    if(numRecords>0 && !isNull(viewData.get(0).getBriefId())) {
		briefId = viewData.get(0).getBriefId();
		feedBackReply=viewData.get(0).getReplyFeedBack();
	//	out.println("briefid");
	}	
    if(numRecords>0){
    for(int counter=0; counter<numRecords; counter++){		
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		if(counter==0)
		{
			tripStartDate=getTripStartDate(currentRecord.getStartDate());
			tripEndDate=getTripEndDate(currentRecord.getEndDate());
		//	out.println(tripEndDate);
			tripid=currentRecord.getTripId();
		}
    }
    }
    else{
    	tripStartDate="-";
		tripEndDate="-";
		//out.println(tripEndDate);
		tripid="-";
	//	out.println("tripid = -");
	//	System.out.println("tripid = -");
    }
    
    try{		
		openTripsData = vehicleDao.getOpenTripsData(driverID,session.getAttribute("usertypevaluemain").toString());
		openTripRecords=openTripsData.size();
	//	System.out.println("openTripRecords===>"+openTripRecords);
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}

	
	
	try{		
		data = vehicleDao.getDebriefSumbitData(session.getAttribute("usertypevaluemain").toString(),driverName,driverID,limit);
		if(data.size()>0){
		viewData = debriefSubmitViewDataProvider.getDebriefSubmitViewData(data,driverName,driverID);
		numRecords=viewData.size();
		}
		}
	catch (Exception e) {
		e.printStackTrace();
	}
	
	
	    if(numRecords>0){
	    for(int counter=0; counter<numRecords; counter++){		
			final DebriefSubmitViewData currentRecord = viewData.get(counter);
			if(counter==0)
			{
				tripStartDate=getTripStartDate(currentRecord.getStartDate());
				tripEndDate=getTripEndDate(currentRecord.getEndDate());
			//	out.println(tripEndDate);
				tripid=currentRecord.getTripId();
			}
	    }
	    }
	    else{
	    	tripStartDate="-";
			tripEndDate="-";
			//out.println(tripEndDate);
			tripid="-";
		//	out.println("tripid = -");
		//	System.out.println("tripid = -");
	    }
	
	
	try{
		
	//String sql2="SELECT tripid, driverid, briefid,Tripid,VehRegNo,startplace,endplace,probenddate FROM db_gps.t_briefing WHERE Driverid = '"+drverid+"'";
		
	String sql2= "SELECT tripid, driverid, briefid,Tripid,VehRegNo,startplace,endplace,probenddate,updateddt FROM db_gps.t_briefing WHERE Driverid = '"+driverID+"'  ORDER BY `t_briefing`.`updateddt`  DESC";
	System.out.println(sql2);
			ResultSet rs2=st1.executeQuery(sql2);
			System.out.println("ccccccccccccccccccccccccccccccccccc=====551" +sql2);
			if(rs2.next()){
				Tripid=rs2.getString("tripid");
				VehRegNo=rs2.getString("VehRegNo");
				startplace=rs2.getString("startplace");
				endplace=rs2.getString("endplace");
				System.out.println(Tripid+" V "+VehRegNo+" S  "+startplace+" E "+endplace);
				if(rs2.getString("probenddate").equalsIgnoreCase("-")||rs2.getString("probenddate").equalsIgnoreCase(null)||rs2.getString("probenddate").equalsIgnoreCase(" "))
				{
					probenddate ="-";
				}
				else{
				System.out.println("ccccccccccccccccccccccccccccccccccc=====551" +rs2.getString("probenddate"));
				probenddate = rs2.getString("probenddate");
				System.out.println("Pdate"+probenddate+",End Place  "+endplace);
				}
				
			}		
	try{
		castrolZones=vehicleDao.getCastrolZones();
	}
	catch(Exception e){
		e.printStackTrace();
	}
    //System.out.println("step3");
    try{
		VehRegNumber=vehicleDao.getVehicleRegistrationNumberForTransporter(transporter);
		numOfVehRecords=VehRegNumber.size();
	}
	catch(Exception e){
		e.printStackTrace();
	}
   

%>



<body background="#83738A">
	 
	 <form action="RegInsertDeBrifing.jsp" method="post" id="register" name="register"  onSubmit="return GetVeh('<%=drverid %>','<%=drivernam %>','<%=transporter %>')" >

 <div align="center">
 <table  width="60%" align ="center">
 <tr>
		<td align="right">	<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date()) %></td></tr></table></div>
<div style="background:#e3e9ff;width: 990px;  margin-left: 30px; margin-bottom: 150px">

<h2 style="background:#485682; color:#ffffff; cursor:pointer;">&nbsp; Registration For De-Briefing&nbsp;</h2>


<table >
<tr>
<td colspan="2"   class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0" >
<tr >
<td  style="width: 40%;">
<label class="description" for="element_1" style="width: 270px;"><font size="2">Driver ID : </font>
<font size="2"><%=drverid %></font></label>
<input type="hidden" name="DriverId" id="DriverId" value="<%=drverid %>"  class="element text medium" readonly/>
</td>
<td  style="width: 40%;">
<label class="description" for="element_1" style="width: 270px;"><font size="2">Driver Name : <%=drivernam %></font></label>

<input type="hidden"  name="DriverName" id="DriverName" value="<%=drivernam %>" class="element text medium"  readonly/>
</td>
<td  style="width: 40%;">
<label class="description" for="element_1" style="width: 270px;" ><font size="2">Transporter : <%=trans %></font></label>


<input type="hidden" id="transporter" name="transporter" class="element text medium" value="<%=trans %>" size="15"  readonly/> 
<input type="hidden" id="VehRegNo" name="VehRegNo" class="element text medium" value="<%=VehRegNo %>" size="15"  readonly/> 
</td>
</tr>


<%
%>
<tr align="center">
		<td colspan="3"> 
		<div>
		
		<table class="sortable" background="#e3e9ff">
		<%
	
	String sql4111 = "SELECT TripID,Vehid,VehRegNo,StartPlace,StartDate,StartTime,EndPlace,OwnerName,JStatus FROM `t_startedjourney` where jstatus IN ('tobeclosed','Running') and drivercode='"+driverID+"'  ORDER BY `t_startedjourney`.`StartDate` DESC";
	ResultSet rs4111 = st41.executeQuery(sql4111);
	System.out.println("5555555555555555555555577777777"+sql4111);
	if(rs4111.next())
	{
	 %>	
		<tr>
				<td align="center" style="background-color: #e3e9ff; "><font  size="2"> <B>
				Open Trips :</B></font><font  size="1" color="red">  To debrief please close the trip </font></td>
			</tr>
	
			<tr>
				<td>
				<div
					style="margin-center: 220px; height: 100px; width: 980px; background-color: #e3e9ff; border: 1px solid blue; overflow: auto;">
				<table class="sortable" border="1">
					<tr>
	<th>Trip Id</th>
	<th>Veh Reg No</th>
	<th>Start Place</th>
	<th>Start Date</th>
	<th>Start Time</th>	
	<th>End Place</th>
	<th>Owner Name</th>
	<th></th>
	</tr>
	<%
	}else{
		%>
		<tr align="left">
		<td style="background-color: #e3e9ff; "><font  size="2"> <B> Open trips : No open trips</B></font></td>
		</tr>
	<%	
	}
	
	rs4111.previous();
	
	while(rs4111.next())
	{
%>
	<tr>
	<td><%=rs4111.getString("TripID") %></td>
	<td><%=rs4111.getString("VehRegNo") %></td>
	<td><%=rs4111.getString("StartPlace") %></td>
	<%
	String Date111= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs4111.getString("StartDate")));
	String Time111= new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs4111.getString("StartTime")));
	
	%>
	
	<td><%=Date111%></td>
	<td><%=Time111 %></td>
	<td><%=rs4111.getString("EndPlace") %></td>
	<td><%=rs4111.getString("OwnerName") %></td>
	<td><a href="javascript: flase;" onClick="window.open ('endtrip.jsp?tripid=<%=rs4111.getString("TripID")%>&vehcode=<%=rs4111.getString("Vehid")%>&vehno=<%=rs4111.getString("VehRegNo")%>&pageflag=BriefingPage', 'win1', 'width=900, height=400, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);">End Trip </a></td>

	
	
	</tr>	
<%
}
%>	
	
	</table>
	
	

</div>
</td>
</tr>
</table>
</div>
</td>
</tr>


<!----------------------------------------------------------------------------------------->

	<tr align="center">
		<td colspan="3">
		<br>
		<table class="sortable" background="#e3e9ff">
			<tr>
				<td align="center" style="background-color: #e3e9ff; "><font  size="2"> <B>
				Last 10 Trips</B> </font></td>
			</tr>
			<tr>
				<td>
				<div
					style="margin-center: 220px; height: 170px; width: 980px; background-color: #e3e9ff; border: 1px solid blue; overflow: auto;">
				<table class="sortable" border="1">
					<tr>
						<th></th>
						<th><B>Sr.No</B></th>
						<th><B> Trip Id</B></th>
						<th><B> Start Date </B></th>
						<th><B> Start Place </B></th>
						<th><B> End Date </B></th>
						<th><B> End Place </B></th>
						<th><B> DT</B></th>
						<th><B> OS </B></th>
						<th><B> RA </B></th>
						<th><B> RD </B></th>
						<th><B> ND </B></th>
						<th><B> Rating </B></th>
						<th><B> DC </B></th>
						<th><B> Peripheral</B></th>
					</tr>
					
<%
if(numRecords>0){
	
	DisconnectionCount disconnCount = new DisconnectionCount();
	for(int counter=0; counter<numRecords; counter++){		
		final DebriefSubmitViewData currentRecord = viewData.get(counter);
		i = counter + 1;	
		
		
%>
					
					<tr>
<%
try{		
	tripDebriefData = vehicleDao.getDebriefStatusForTrip(currentRecord.getTripId(),session.getAttribute("usertypevaluemain").toString());
	numTriptripDebrief=tripDebriefData.size();
	
	
}
catch (Exception e) {
	e.printStackTrace();
}
	if(numTriptripDebrief>0)
	{
	for(int counter1=0; counter1<numTriptripDebrief; counter1++){		
		final DriverDebriefForTrip tripRecord = tripDebriefData.get(counter1);
		if(Integer.parseInt(tripRecord.getCount())>0){
%>				
					<td>
					
					</td>
<%
		}
		else{System.out.println("Vehical : "+currentRecord.getVehicleRegistrationNumber());	
%>
				<td><input type="radio" name="debrifRadioId" id="debrifRadioId<%=i %>" value="<%=currentRecord.getTripId()%>#<%=currentRecord.getStartDate()%>#<%=currentRecord.getEndDate()%>#<%=currentRecord.getStartPlace()%>#<%=currentRecord.getEndPlace()%>#<%=trans%>#<%=currentRecord.getVehicleId()%>#<%=driverID%>#<%=currentRecord.getVehicleRegistrationNumber() %>" onclick="javascript:showHideTable(<%=i %>)"></input></td>
<%
			}
%>
<%
		}
	}
	else{System.out.println("Vehical : "+currentRecord.getVehicleRegistrationNumber());		%>
				<td><input type="radio" name="debrifRadioId<%=i %>" id="debrifRadioId<%=i %>" value="<%=currentRecord.getTripId()%>#<%=currentRecord.getStartDate()%>#<%=currentRecord.getEndDate()%>#<%=currentRecord.getStartPlace()%>#<%=currentRecord.getEndPlace()%>#<%=trans%>#<%=currentRecord.getVehicleId()%>#<%=driverID%>#<%=currentRecord.getVehicleRegistrationNumber() %>" onclick="javascript:showHideTable(<%=i %>)"></input></td>
		<%
					}
%>
					<td style="text-align: right"><%=i %>

<%
		if(i==1)
		{
			
			if(isNull(currentRecord.getDriverMobileNumber())){
				driverMobileNumber="-";
			}
			else{
				driverMobileNumber=currentRecord.getDriverMobileNumber();
			}
				
%>
						<input type="hidden" name="hidLastTripRating" value="<%= currentRecord.getTripRating() %>" /> 
						<input type="hidden" name="hidLastTripId" value="<%=currentRecord.getTripId()%>" />
<% 
//javascript:toggleDetails(=i,false);" onclick="	
}
%>
						</td>
						<td style="text-align: right"><a
							href="javascript:toggleDetails(<%=i%>,true);"
							title="Click To See the Reports"> <%=currentRecord.getTripId()%></a>
						<br>
						<div class="popup" id="popup<%=i%>">
						<table border="1" bgcolor="white">
							<tr>
								<td>
								<%
								String briefid = "",rid = "",plannedstatus = "No";
								boolean flag = false;
								String sql1 = "select * from db_gps.t_briefing where tripid = '"+currentRecord.getTripId()+"'";
								ResultSet rs1 = st1.executeQuery(sql1);
								if(rs1.next())
								{
									briefid = rs1.getString("Briefid");
								}

								sql1 = "select * from db_gps.t_intermediatejrmroute where  Tripid = '"+currentRecord.getTripId()+"' and briefid = '"+briefid+"' and driverid = '"+drverid+"'  order by advancedtrackid asc ,row asc limit 1 ";
								rs1 = st1.executeQuery(sql1);
								if(rs1.next())
								{
									rid = rs1.getString("advancedrouteid");
									plannedstatus = "Yes";
									flag = true;
								}
								%>
								<a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="javascript:window.open('ActAndPlanJrnyCompOnMap.jsp?tripid=<%=currentRecord.getTripId()%>&vehcode=<%=currentRecord.getVehicleId()%>&data=<%=getTripStartDate(currentRecord.getStartDate())%>&data1=<%=getTripEndDate(currentRecord.getEndDate())%>&ftime1=<%=getTripStartTimeHrs(currentRecord.getStartDate())%>&ftime2=<%=getTripStartTimeMins(currentRecord.getStartDate())%>&ftime3=<%=getTripStartTimeSeconds(currentRecord.getStartDate())%>&ttime1=<%=getTripEndTimeHrs(currentRecord.getEndDate())%>&ttime2=<%=getTripEndTimeMins(currentRecord.getEndDate())%>&ttime3=<%=getTripEndTimeSeconds(currentRecord.getEndDate()) %>&pg=debrif&pstatus=<%=plannedstatus %>&brifid=<%=briefid %>&rid=<%=rid %>&driverid=<%=drverid %>');">Show
								Trip on Map </a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);" 
								onclick="newwindow1('debrifLasrTripChart.jsp?driverid=<%=driverID%>&tripid=<%=tripid%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&cnt=1');">Driver RunHrs Chart
								</a></td>
							</tr>
							
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brif_customreport.jsp?tripid=<%=currentRecord.getTripId()%>&vehicleRegistrationNo=<%=currentRecord.getVehicleRegistrationNumber()%>&vehcode=<%=currentRecord.getVehicleId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								detail report </a></td>
							</tr>
							
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('brfexceprepot.jsp?tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>' );">Trip
								exception report</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);"
									onclick="javascript:window.open('stop.jsp?tripid=<%=currentRecord.getTripId()%>&startDate=<%=getTripStartDate(currentRecord.getStartDate())%>&endDate=<%=getTripEndDate(currentRecord.getEndDate())%>&startPlace=<%=currentRecord.getStartPlace() %>&endPlace=<%=currentRecord.getEndPlace() %>' );">Stops
								 report</a></td>
							</tr>
							<tr>
								<td><a href="javascript:toggleDetails(<%=i%>,false);">Close
								</a></td>
							</tr>
						</table>
						</div>
						</td>
						<td style="text-align: left"><%=currentRecord.getStartDate() %></td>
						<td style="text-align: left"><%=currentRecord.getStartPlace()%></td>
						<td style="text-align: left"><%=currentRecord.getEndDate() %></td>
						<td style="text-align: left"><%=currentRecord.getEndPlace()%></td>
						<td style="text-align: right"><%=currentRecord.getKmTravelled()%></td>
						<td style="text-align: right"><%=currentRecord.getOverSpeedCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidAccelerationCount()%></td>
						<td style="text-align: right"><%=currentRecord.getRapidDecelerationCount()%></td>
						<td style="text-align: left"><%=currentRecord.getNightDrivingInfo()%></td>
						<td style="text-align: right"><%=currentRecord.getTripRating()%></td>
						<%int disconCount=0;
						disconCount = disconnCount.CalulateDrivingHours(currentRecord.getVehicleId(),getTripStartDate(currentRecord.getStartDate()),getTripEndDate(currentRecord.getEndDate()),currentRecord.getTripId()); 
						if(disconCount>0)
						{
							%>
							<td style="text-align: right"><a href="#" onclick="javascript:window.open('disconnectionFeedBack.jsp?ownername=<%=currentRecord.getOwnerName() %>&vehicleCode=<%=currentRecord.getVehicleId()%>&tripid=<%=currentRecord.getTripId()%>&fromDateTime=<%=currentRecord.getStartDate()%>&toDateTime=<%=currentRecord.getEndDate()%>','','top=200,left=200,width=800,height=400,resizable=1,scrollbars=1');"><%=disconCount%></a></td>
							<%
						}
						else
						{
							%>
							<td style="text-align: right"><%=disconCount%></td>
							<%
						}
						%>
						<%
						try{
							peripheral=vehicleDao.getPeripheralOfUnitDuringTrip(currentRecord.getVehicleId(),new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getStartDate())),new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(currentRecord.getEndDate())));
							numOfPeripheralRecords=peripheral.size();
						}
						catch(Exception e){
							e.printStackTrace();
						}
						if(numOfPeripheralRecords>0)
						{
							%>
							<td style="text-align: left"><%=peripheral.get(0).getPeripheral()%></td>
							<%
						}
						else
						{
						%>
							<td style="text-align: left"><%="-"%></td>
						<%	
						}
						%>
					</tr>
<%
		}
		
	}	
else{
	//out.println("not in completed journey");
	//System.out.println("not in completed journey");
	%>
						<tr>
						<td align="center" colspan="15"><font  size="3">NO TRIPS</font></td>
						</tr>
	<%
			}
%>
				</table>
				<input type="hidden" name="cnt" id="cnt" value="<%=i%>"></input>
				</div>
				</td>

			</tr>
		</table>

		
<!----------------------------------------------------------------------------------------->


























<table width="100%"  id="tabl"
					style="display: none">
					
			<tr>
			
				<td >


<!--			<b><label  id="trr"> Trip ID :  </label></b></td><td> -->
<!--			<input type="Text"	name="tripid" id="tripid" value="" readonly></input>-->

<input type="hidden" id="transporter" value=<%=trans%> ></input>
					</td>		
					
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
					
					
					<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0" align="center" border="0">

<%

//String sql9="select status from db_gps.t_reasonOfRejectionForDriver where vehno='"+vehicleRegNumber+"'";


%>

<%
String DrvStatus="",ReasoneForRejection="",RejectedBy="",UpdatedDateTime="",colorSt="",VehStatus="",colorSt1="";

String sql41 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver where DriverId ='"+driverID+"' and ReasoneForRejection='Driver Rejection' order by UpdatedDateTime DESC limit 1";
ResultSet rs41 = st41.executeQuery(sql41);
System.out.println("5555555555555555555555577777777"+sql41);
if(rs41.next())
{
if(rs41.getString("status").equalsIgnoreCase("Yes"))
	{
	ReasoneForRejection=rs41.getString("CommentForRejection").replace('~', ',');
	UpdatedDateTime= new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs41.getString("UpdatedDateTime")));
	DrvStatus="Rejected By "+rs41.getString("RejectedBy")+" Due to : "+ReasoneForRejection+" On "+UpdatedDateTime;
	colorSt="#FF0000";
	}
else if(rs41.getString("status").equalsIgnoreCase("No"))
	{
	DrvStatus="Pass";
	colorSt="#000000";
	}
}
	



String sql411 = "SELECT * FROM db_gps.t_reasonOfRejectionForDriver where VehRegNo='"+VehRegNo+"' and ReasoneForRejection='Vehicle Rejection' order by UpdatedDateTime DESC limit 1";
ResultSet rs411 = st411.executeQuery(sql411);
System.out.println("5555555555555555555555577777777"+sql411);
if(rs411.next())
{
if(rs411.getString("status").equalsIgnoreCase("Yes"))
	{
	ReasoneForRejection=rs411.getString("CommentForRejection").replace('~', ',');
	UpdatedDateTime= new SimpleDateFormat("dd-MMM-yyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs411.getString("UpdatedDateTime")));
	VehStatus="Rejected By "+rs411.getString("RejectedBy")+" Due to : "+ReasoneForRejection+" On "+UpdatedDateTime;
	colorSt1="#FF0000";
	}
else if(rs411.getString("status").equalsIgnoreCase("No"))
	{
	VehStatus="Pass";
	colorSt1="#000000";
	}
}
	


%>


	
	
	
	
	
<tr>
<td colspan="4" class="cbFormNestedTableContainer" >
<div >
<table  class="cbFormNestedTable" cellspacing="4" border="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Briefing Status : </font> </label>
</td>
 </tr>
 <tr>
 <td></td>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Driver : </font> <font size="2" color="<%=colorSt %>"> <%=DrvStatus %></font></label>

</td>
</tr>
 <tr>
 <td></td>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Vehicle : </font> <font size="2" color="<%=colorSt1 %>"> <%=VehStatus %></font></label>

</td>
</tr>
</table>


<table  class="cbFormNestedTable" cellspacing="4" border="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Reverse Audit </font> </label>
</td>
 </tr>
 <tr>
 <td></td>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Driver </font></label>
</td>
<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdh" checked="checked" id="ChkAdh" value="No" onclick="showtext()" ></input>
</td>
<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2"> Pass</font></label>
</td>
</tr>
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdh" id="ChkAdh" value="Yes" onclick="showtext()"  ></input>
</td>
<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2">Reject</font></label>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</td>
</tr>

<tr id="tr1" style="display: none;" >

<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="2" >
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" for="element_1" style="width: 170px;">  <font color="red">*</font> <font size="2">Reasons</font></label>
</td>
<td  class="cbFormFieldCell">

<tr class="cbFormTableRow" align="center">
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<select name="resources" style="width:160px" size="7" id="resources" multiple="multiple">
<%
String sql4 = "select Options from db_gps.t_JourneyGoals where Categoery='Reson_DriEntry' order by UpdatedDateTime";

		ResultSet rs4 = st.executeQuery(sql4);
		 i=0;
		while(rs4.next())
		{
			//System.out.println("*******");
			%>
			 <option value="<%=rs4.getString("Options") %>" ><%=rs4.getString("Options") %></option>
					<%
	i++;
	}
	
	%>

</select>
</td>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<div><input type="button" class="button" value="&gt;" onClick="addUser();" /></div>
<div><input type="button" class="button" value="&lt;" onClick="removeUser()" /></div>
</td>
<td align="center" valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<input type="hidden" id="dest1" name="dest1">
<select name="assigned" style="width:160px" size="7" multiple="multiple">

</select>
</td></tr>

<!--<input type="text" name="reason1"/>-->



</table>
</td>
</tr>

<tr >

<td >
<div style="margin-right: -260px">
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td></td>

<td  class="cbFormLabelCell  cbFormLabel" align="center">
<label class="description" ><font size="2">Vehicle</font></label>
</td>


<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdhJ" checked="checked" id="ChkAdhJ" value="No"  onclick="showtext()" ></input>
</td>
<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2">Pass</font></label>

</td>

</tr>
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdhJ" id="ChkAdhJ" value="Yes" onclick="showtext()" ></input>
</td>
<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2" >Reject</font></label>

</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</td>
</tr>
<input type="hidden" name="TripIdN" id="TripIdN" value="" ></input>
<tr id="tr2" style="display: none;">
<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" for="element_1" style="width: 170px;"><font color="red">*</font><font size="2" >Reasons</font></label>
</td>
<td  class="cbFormFieldCell">
<tr class="cbFormTableRow" align="center">
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<select name="resources2" style="width:160px" size="7" id="resources2" multiple="multiple">
<%

		String sql5 = "select Options from db_gps.t_JourneyGoals where Categoery='Reson_VehEntry' order by UpdatedDateTime";
         ResultSet rs5 = st.executeQuery(sql5);
		int i2=0;
		while(rs5.next())
		{
			//System.out.println("*******");
			%>
			 <option value="<%=rs5.getString("Options") %>" ><%=rs5.getString("Options") %></option>
					<%
	i2++;
	}
	
	%>

</select>
</td>
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<div><input type="button" class="button" value="&gt;" onClick="addUser2();" /></div>
<div><input type="button" class="button" value="&lt;" onClick="removeUser2()" /></div>
</td>
<td align="center" valign="top" class="cbFormLabelCell  cbFormLabel">
<br>
<input type="hidden" id="dest2" name="dest2">
<select name="assigned2" style="width:160px" size="7" multiple="multiple">
	
</select>
</td>
					</tr>

</td>
</tr>
</table>
</td>
	</tr>
	
	<tr id="tr4" style="display: none;" >
	
	<td>
	<table>



<tr>


<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" for="element_1" ><font size="2">&nbsp;Escalate Rejection E-mail ID :</font></label>
</td>

<td>
<input type="text" class="element select medium" id="EmailId" name="EmailId" style="width: 300px"/><font color="red" size="1"><br>Enter Transporter Email ID Also.</font>
		
						
						</td>
						
						</tr>
						
						</table>
	
	</td>
	
<!--<td align="center" style="margin-right: -800px">
<input id="button" type="button" name="button" class="button_text" style="border-style: outset; border-color: black" value="Submit" onclick="GetVeh('<%=drverid %>','<%=drivernam %>','<%=transporter %>')" />
</td>

--></tr>
	
	
<tr>
		
					
					
<!--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
<td>					
<table id="Section1" style="display:inline;">
<tr>
<td  class="cbFormFieldCell">

<div align="left">
<!--<select class="element select medium" id="VehRegNo" name="VehRegNo" onchange="getPeripheral(this)">-->
<!---->
<!--     	      						<option value="Select" id="VehRegNo">Select</option>-->
<!--     	      						-->
<!--     <%-->
<!--     	     if(numOfVehRecords>0){-->
<!--		try{-->
<!--				for (final VehicleRegistrationNumberForTransporter vehRegNo : VehRegNumber) -->
<!--				{-->
<!--					-->
<!--					System.out.println(vehRegNo.getVehicleRegistrationNumber()+"   "+VehRegNo);-->
<!--					if(vehRegNo.getVehicleRegistrationNumber().equalsIgnoreCase(VehRegNo))-->
<!--					{-->
<!--						%>-->
<!--						-->
<!--						<option selected="selected" value="<%=vehRegNo.getVehicleRegistrationNumber()%>,<%=vehRegNo.getPeripheral() %>"> <%=vehRegNo.getVehicleRegistrationNumber()%> </option>-->
<!--						-->
<!--						<%-->
<!--					}else-->
<!--					{-->
<!--%>	-->
<!--				-->
<!--     	      	<option value="< %=vehRegNo.getVehicleRegistrationNumber()%>,< %=vehRegNo.getPeripheral() %>"> < %=vehRegNo.getVehicleRegistrationNumber()%> </option>-->
<!--				<%-->
<!--					}-->
<!--				}-->
<!--				}catch(Exception e){-->
<!--					e.printStackTrace();-->
<!--				}-->
<!--     	      						}-->
<!--%>	      						-->
<!--     	      						-->
<!--     	      						-->
<!--     	      						-->
<!--     	      						-->
<!--     	      						-->
<!--					</select>		-->
						</div>


</td>
</tr>


<!--	<tr>-->
<!--		<td colspan="2"><input type="button" id ="generateTrip" value="Click Here" onclick="generateTripId(< %=viewData.get(0).getTripId()%>)"></input> To Generate New TripId-->
<!--		</td>-->
<!--		</tr>-->
<tr>					
<td  >
<label class="description" for="element_1" style="width: 170px;"><font size="2">Trip ID : </font></label>
</td>
<td align="center">
<div align="center">
<label class="description" for="element_1" style="width: 170px;" ><font size="2" id="tripid"></font></label>
<input type="hidden" name="TripIdN" id="TripIdN" value="" ></input>

<!--<input  class="description" for="element_1" type="text" style="width: 170px;" name="tripid" id="tripid" value="" readonly ></input>-->
</div>
</td>
</tr>
<tr>					
<td  >
<label class="description" for="element_1" style="width: 170px;"><font size="2">Vehicle Registration No:</font></label>
</td>


<td align="center">
<div align="center">

<label class="description" for="element_1" style="width: 170px;" ><font size="2" id="Veh11"></font></label>

<!--<input  class="description" for="element_1" type="hidden" style="width: 170px; name="VehRegNo" id="VehRegNo" value="" readonly ></input>-->
</div>
</td>

<!--<td id="td111" style="display: none">
<input type="hidden" value="" name="VehNo1" id="VehNo1"></input>

<label class="description" ><font size="2">This is in reject List</font> </label>

<label ><a href="#" onclick="open1()"><font size="2"><b>Please Click hear to Pass</b></font></a></label></td>


</tr>
-->

<tr>
<td>
<label class="description" for="element_1" style="width: 170px;"><font size="2">Trip Origin Place :</font></label>
</td>
<td>

<label class="description" for="element_1" style="width: 170px;"><font size="2" id="startplace"></font></label>

<!--<input  class="description" for="element_1" type="text" style="width: 250px;" name="startplace" id="startplace" value="" readonly ></input>-->

</td>

<!--<td  class="cbFormFieldCell">-->
<!---->
<!--	<div align="left">-->
<!--	<select class="element select medium" id="startplace" name="startplace">-->
<!--					<option value="Select">Select</option>-->
<!--			-->
<!--			-->
<!--			String sql6="select StartPlace from db_gps.t_castrolroutes where Owner='Castrol'";-->
<!--			ResultSet rs6=st.executeQuery(sql6);-->
<!--			System.out.println("jjjjjjjjjjjjjjmmmmmmmmmmmmmmmmmmmm"+sql6);-->
<!--			while(rs6.next())-->
<!--			{-->
<!--				startplace1=rs6.getString("StartPlace");-->
<!--				%>-->
<!--				<option >< %=startplace1%></option>-->
<!--				-->
<!--				-->
<!--			}-->
<!--	-->
<!--					-->
<!--					-->
<!---->
<!--				</select> &nbsp;&nbsp; <a href="#"-->
<!--					onclick="javascript:window.open('zonentry.jsp');" title="Add new location">Other</a>&nbsp;&nbsp;&nbsp;-->
<!--				</div>-->
<!--				</td>-->

</tr>

<tr>
<td  >
<label class="description" for="element_1" style="width: 170px;"><font size="2">Trip Destination Place:</font></label>
</td >

<td>

<label class="description" for="element_1" style="width: 170px;"><font size="2" id="element_2"></font></label>


<!--<input  class="description" for="element_1" type="text" style="width: 250px;" name="element_2" id="element_2" value="" readonly ></input>-->

</td>

</tr>

<tr >
                      <td  >
                <label class="description" for="element_1" style="width: 170px;"><font size="2">Trip End Date:</font></label>
               </td>
              <td>
              
    <label class="description" for="element_1" style="width: 170px;"><font size="2" id="EDate"></font></label>
              
<!--<input  class="description" for="element_1" type="text" style="width: 250px;" name="EDate" id="EDate" value="" readonly ></input>-->

</td> 
               
<!--				<td >-->
<!--				<div align="left">-->
<!--				<input type="text" id="data" name="data" value="< %=probenddate %>" class="element text medium" -->
<!--		 style="width: 125px; height: 16px;"   readonly /> -->
<!--				<script type="text/javascript">-->
<!--  					Calendar.setup(-->
<!--    				{-->
<!--      				inputField  : "data",         // ID of the input field-->
<!--      				ifFormat    : "%d-%b-%Y",     // the date format-->
<!--      				button      : "data"       // ID of the button-->
<!--    				}-->
<!--  					);-->
<!--					</script></div>-->
<!--				</td>-->

			</tr>

<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 140px;"><font size="2"> <font color="red">*</font>&nbsp;Cleaner Passport ID :</label>
</td>
<td  class="cbFormFieldCell">

<%-- <input type="text" name="CleanerId" id="CleanerId" value="" class="element text medium"  style="width: 200px;" onblur="CheckCleanner('<%=driverID %>');" />  --%>
<input type="text" name="CleanerId" id="CleanerId" value="" class="element text medium"  style="width: 200px;" /> 
</td>
</tr> 
<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 140px;"><font size="2"><font color="red">*</font>&nbsp;Cleaner Name :</label>
</td>
<td  class="cbFormFieldCell">
<input type="text" name="CleanerName" id="CleanerName" value="" class="element text medium"  style="width: 200px;"/>
</td>
</tr>
<tr align="center">

<td align="center" colspan="2">

<input id="Submit" type="submit" name="Register" class="button_text" style="border-style: outset; border-color: black" value="Register"/>
</td>

</tr>

<tr></tr>
</table>
</td></tr>


	</table>
	








</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</table>
</div>

</form>


</body></html>
<% 
}
	catch(Exception e){
		e.printStackTrace();
	}
	%>

</jsp:useBean>
<%@ include file="footernew.jsp"%>