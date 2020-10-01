
<%@page import="com.transworld.fleetview.framework.VehicleDao"
	import="com.transworld.fleetview.framework.DebriefSubmitData"
	import="com.transworld.fleetview.framework.DebriefSubmitViewDataHelper"
	import="com.transworld.fleetview.framework.DebriefSubmitViewData"
	import="com.transworld.fleetview.framework.ReasonOfRejection"
	import="com.transworld.fleetview.framework.VehicleRegistrationNumberForTransporter"
	import="com.fleetview.beans.DisconnectionCount"
	import="com.transworld.fleetview.framework.PeripheralOfUnitDuringTrip"
	
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
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=con1.createStatement();
%>
	

<%@page import="com.lowagie.text.Document"%><html >

<%	
	
	final String lastmnthdate="", lastsixdate="", riskratingfrmtd="";
	final String trainerName = (String) session.getAttribute("user");
	final String drverid=request.getParameter("driverid");
	
   
	final String drivernam=request.getParameter("drivername");
	int numOfVehRecords=0;
	final String briefId = request.getParameter("briefId");
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
	
	System.out.println(" trans "+trans+" transname "+transname+" transporter "+transporter);
	
	String userid=session.getAttribute("user").toString();
	System.out.println("userid "+userid);
	
	
	List<VehicleRegistrationNumberForTransporter> VehRegNumber=null;
	session.setAttribute("drivername",drivernam);
	session.setAttribute("driverid",drverid);
	session.setAttribute("tname",transname);
	List<String> castrolZones =null;
	String startplace1="",desttplace1="";
	
	try{
		castrolZones=vehicleDao.getCastrolZones();
	}
	catch(Exception e){
		e.printStackTrace();
	}
   
    try{
		VehRegNumber=vehicleDao.getVehicleRegistrationNumberForTransporter(transporter);
		numOfVehRecords=VehRegNumber.size();
	}
	catch(Exception e){
		e.printStackTrace();
	}
   

%>

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
</style>

</head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"><!--

function validate()
{
	var tpclass=document.register.TripId.value;
	var startplace=document.register.startplace.value;
	var endplace=document.register.endplace.value;
	var VehRegNo=document.register.VehRegNo.value;
	var prob=document.register.data.value;
	var EmailId=document.getElementById("EmailId").value;
	var phno = document.register.Mob1.value;
	var phno1 = document.register.Mob.value;
	var passId=document.getElementById("CleanerId").value;
	var CleanerName=document.getElementById("CleanerName").value;
		var chk=document.getElementById("chkmob");
	var checkC=document.getElementById("NonCVeh").value;
	var invalid=/^[0-9]+$/;
	var invalid1=/^[A-Za-z .]+$/;
	
	if(chk.checked==true )
	{
	}
	else{
	
	/* if(!(phno ==0))
	{
		
		 if(isNaN(phno))
    		{
    			alert("Please Enter Numeric Value");
    			return false;
    		}
    	
			 if((phno.length < 10)  || (phno.length >12))
				 {
            alert("Please Enter valid Mobile Number"); 
            return false;
        }
	}
	else
	{
		phno="";
		
		alert("Please Enter Driver Mobile Number");
        return false;	
	} */
	
		 if(!(phno.length==0))
		   {
		   if(!invalid.test(phno))
		   {
		   
			 alert("Please Enter Numeric Value only for Driver No");  
			   
		   return false;
		   	   }
				
			 if((phno.trim().length < 10)  || (phno.trim().length >15))
					 {
					 alert("Driver Mobile Number No should be 10-15 digits");
		        return false;
		           }
		   
		   
		   }
		 else
			{
			
				
				alert("Please Enter Driver Mobile Number");
		        return false;	
			}
	   
	}
	
	/* 
	var x=EmailId;
	if(EmailId.length!=0)
		{
		
		 var atpos = x.indexOf("@");
		    var dotpos = x.lastIndexOf(".");
		    if (atpos< 1 || dotpos<atpos+2 || dotpos+2>=x.length) {
		        alert("Please enter valid E-mail id for Escalate Rejection To");
		        return false;			
		} */
	
	
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

	 
	    document.getElementById("reason1").innerHTML = reason1;
	    document.getElementById("reason2").innerHTML = reason2;
	 
	
	//alert("Adh: "+TChkAdh+" Adhj:"+TChkAdhJ+" Reson:"+reason1+" Reson2:"+reason2);
	if(document.getElementById("tr1").style.display!="none" || document.getElementById("tr2").style.display!="none" )
	{
		if((TChkAdh=="Yes" && reason1==""))
			{
			alert("Please select reason for Driver ");
			return false;
			
			}
		if((TChkAdhJ=="Yes" && reason2==""))
			{
			alert("Please select reason for Vehicle ");
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
		
		
		

	}
	
	
/*  */
	
	
	
	/* */
	
	if(tpclass.trim() == "")
	{
		alert("Please Enter the Trip ID.");
		return false;
	}
	if(VehRegNo=='Select')
	{
		alert("Please select Vehicle Registration Number");
		return false;
	}
	if(passId.trim()=="")
	{
		alert("Please Enter the Cleaner Passport ID .");
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
	if(startplace=="Select" || startplace.trim()=="")
	{
		alert("Please select Trip start Place");
		return false;
	}	
	
	if(endplace=="Select" || endplace.trim()=="")
	{
		alert("Please select Trip End Place");
		return false;
	}
	if(prob.trim() == "")
	{
		alert("Please Enter Contract Delivery Date.");
		return false;
	}	

	var dd11,mm11,yy11,mm1;
	var dd22,mm22,yy22,mm2;
	dd11=prob.substring(0,2);
	mm1=prob.substring(3,6);
	yy11=prob.substring(7,11)
	mm11=dateformat(mm1);
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear()
	
	if(dd<10) {
    dd='0'+dd;
} 

if(mm<10) {
    mm='0'+mm;
} 

today = dd+'/'+mm+'/'+yyyy;


dd22=today.substring(0,2);
mm1=today.substring(3,5);
yy22=today.substring(6,10)
mm22=dateformat(mm1);




     /* if(yy22>yy11 || (dd22>dd11) ||  (mm22>mm11)) 
	{
	alert("Contract Delivery Date should not be less than current Date");
	return false; 
	} */


	
	
	
	if(checkC=="Yes")
	{
		return checkApprove();
	}	
}
function getvisible()
{
	var chk=document.getElementById("chkmob");
	
		
		if(chk.checked==true )
		{
		document.getElementById("Mob").style.display = "";
		document.getElementById("Mob1").style.display = "none";
		document.register.Mob1.value='';

		}
		else{

			document.getElementById("Mob").style.display = "none";
			document.getElementById("Mob1").style.display = "";
				}
		
	}


var TChkAdh,TChkAdhJ,flg1,flg2,flg3;


var scr_DH=0,scr_ND=0,scr_CD=0,scr_DVI=0,scr_Adh=0,scr_N_DH=0,scr_N_ND=0,scr_N_CD=0,scr_N_DVI=0,scr_N_Adh=0;
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
				//document.getElementById("email").style.display="";
				//check.style.display='none';  // changes done here
			  	}else
			  		{
			  		document.getElementById("tr1").style.display = "none";
			  		document.getElementById("tr2").style.display = "none"
			  		document.getElementById("tr4").style.display="none";
	 				//document.getElementById("email").style.display="";
	 				check.style.display='inline';
			  		}		  
		}catch(e)
		{
		alert("Exception in showtext"+e);
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
	 				//document.getElementById("email").style.display="";
	 				
	 				check.style.display='none';
	 				
		 			}
	 			else
	 			{document.getElementById("tr2").style.display = "none";
 				document.getElementById("tr4").style.display="none";
 				//document.getElementById("email").style.display="";
 				
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
	alert(e);
		}
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
                         dest.add(newOption); //Standard
                         src.remove(count);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
	}
	catch(e)
	{
		alert(e);
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
                count--;
        }
    }
	}
	catch(e)
	{
		alert(e);
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

		//alert(DriveId+": "+BrifId+" : "+TripId)
		var vehrejj=document.getElementById("VehRegNo").value;
		var Mobno=document.getElementById("Mob").value;
		var EmailId=document.getElementById("EmailId").value;
				

		
		
		
		
		//showtext1();
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

		 
		    document.getElementById("reason1").innerHTML = reason1;
		    document.getElementById("reason2").innerHTML = reason2;
		 
		
		//alert("Adh: "+TChkAdh+" Adhj:"+TChkAdhJ+" Reson:"+reason1+" Reson2:"+reason2);
		if(document.getElementById("tr1").style.display == "")
		{
			if((TChkAdh=="Yes" && reason1==""))
				{
				
				alert("Please select reason for Driver ");
				return false;
				
				}
			if((TChkAdhJ=="Yes" && reason2==""))
				{
				alert("Please select reason for Vehicle ");
				return false;
				}
			
		}
			
			
			
		/* if((TChkAdh=="Yes" && reason1=="")||(TChkAdhJ=="Yes" && reason2=="")||(flg1==0||flg2==0))
		{
		alert("Please Select Reason ");
		return false;
		} */
		/*   if(EmailId.trim()=="")
		{
			alert("Please Enter Email Id ");
			return false;
		}  */
		var x=EmailId;
		if(EmailId.length!=0)
			{
			
			 var atpos = x.indexOf("@");
			    var dotpos = x.lastIndexOf(".");
			    if (atpos< 1 || dotpos<atpos+2 || dotpos+2>=x.length) {
			        alert("Please enter valid E-mail id for Escalate Rejection To");
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

/*
		ajaxRequest.onreadystatechange = function()
		{
			
			if(ajaxRequest.readyState == 4)
			{
				try
				{
					
				var reslt=ajaxRequest.responseText;

				reslt=reslt.replace(/^\s+|\s+$/g,'');
				alert("result "+reslt);
				if(reslt=="Updated")
					alert("Rejected Successfully");
				window.location.href="Driver_briefing_New.jsp";
			
				}catch(e)
				{
				alert(e);
				}
			} 
		};


		var queryString = "?ChkAdh="+TChkAdh+"&ChkAdhJ="+TChkAdhJ+"&EmailId="+EmailId+"&Mobno="+Mobno+"&reason1="+reason1+"&reason2="+reason2+"&DriveId="+drverid+"&DName="+drivernam+"&trans="+transporter+"&VehRegNo="+vehrejj+"";
		ajaxRequest.open("GET", "VehReject_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 
		*/
		
		}
			}}
	    catch(e)
		{
			alert(e);
		}

}
function dateformat(days)
{
if(days=='Jan')
return(1);
else
if(days=='Feb')
	return(2);
else
	if(days=='Mar')
		return(3);
	else
		if(days=='Apr')
			return(4);
		else
			if(days=='May')
				return(5);
			else
				if(days=='Jun')
					return(6);
				else
					if(days=='Jul')
						return(7);
					else
						if(days=='Aug')
							return(8);
						else
							if(days=='Sep')
								return(9);
							else
								if(days=='Oct')
									return(10);
								else
									if(days=='Nov')
										return(11);
									else
										if(days=='Dec')
											return(12);
}



function chkReject()
{
	try{


		var VehRegNo=document.getElementById("VehRegNo").value;
		var drverid=document.getElementById("DriverId").value;
		
		 var check = document.getElementById("Section1");
		 var check1 = document.getElementById("Section11");
		 
		//alert(VehRegNo);

		if(VehRegNo=='Select')
			{
		//	alert("Please select Vehicle");
			document.getElementById("td11").style.display = "none"; 
			document.getElementById("driverdiv").style.display = "none"; 
			document.getElementById("vehiclediv").style.display = "none"; 
			
			document.getElementById("VehNo1").value = "";
			document.getElementById("vt11").innerHTML = "-";
				document.getElementById("VehType").value = "-";
				document.getElementById("vt12").innerHTML = "-";
				document.getElementById("VehType1").value = "-";
				check.style.display='none';
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
				var r1;
				reslt=reslt.replace(/^\s+|\s+$/g,'');
			//alert(reslt);
				r1=reslt.split(",");
				
			if(r1[2]==null || r1[3]==null)
			{	document.getElementById("vt11").innerHTML = "NA";
 				document.getElementById("VehType").value = "NA";
 				document.getElementById("vt12").innerHTML = "NA";
 				document.getElementById("VehType1").value = "NA";	
 				check.style.display='inline';

 				
			}
			else{			
 				document.getElementById("vt11").innerHTML = r1[2];
 				document.getElementById("VehType").value = r1[2];
 				document.getElementById("vt12").innerHTML = r1[3];
 				document.getElementById("VehType1").value = r1[3];	
 				check.style.display='none';

 				
			}
		 			document.getElementById("td11").style.display = "none"; 
		 			document.getElementById("driverdiv").style.display = ""; 
					document.getElementById("vehiclediv").style.display = "";
					document.getElementById("tr1").style.display = "none"; 
					document.getElementById("tr2").style.display = "none"; 
					
					document.getElementById("tr4").style.display = "none"; 
	 				check.style.display='inline';
	 				check1.style.display='inline';


				

				}catch(e)
				{
				alert(e);
				}
			} 
			else{
				
				document.getElementById("VehNo1").value = "";
				document.getElementById("vt11").innerHTML = "-";
					document.getElementById("VehType").value = "-";
					document.getElementById("vt12").innerHTML = "-";
					document.getElementById("VehType1").value = "-";	
			}
		};


		
		var queryString = "?&VehRegNo="+VehRegNo+"&Did="+drverid+"";
		ajaxRequest.open("GET", "VehReject_Check_Ajax.jsp" + queryString, true);
		ajaxRequest.send(null); 

			}
		}
	    catch(e)
		{
			alert(e);
		}

	
	
	
}


function open1()
{

	var vehRejected=document.getElementById("VehNo1").value;

	if(vehRejected=='Select')
	{
		alert("Please Select Vehicle");
		
	}
	else{
	testwindow = window.open("driver_briefing_Vehicle_Reject.jsp?VehRNo1="+vehRejected,"JourneyPlanning","width=800,menubar=1,resizable=1,height=200,scrollbars=yes");
		testwindow.moveTo(250,250);
	}




		//testwindow.moveTo(250,250);
}


function getPeripheral(frmele)
{
	try{
	var VehRegNo=document.register.VehRegNo.value;
	var jrmBuzz1="";
	//alert(VehRegNo);
	var reslt=VehRegNo.split(",");
	var peripheral=reslt[1];
	var jrmBuzz="JRM";
	jrmBuzz1=reslt[1].replace("+"," ");
	jrmBuzz1=jrmBuzz1.replace("+"," ");
	jrmBuzz1="Device : "+jrmBuzz1;
	 
//	alert(document.getElementById("customdetailreport").style.display);	
	//document.getElementById("customdetailreport").style.display="";
//	if(trim(peripheral)==trim(jrmBuzz))
	RouteName(VehRegNo);
	//document.getElementById("jrmDevice").innerHTML=jrmBuzz1;
	//document.getElementById("jrmDevice").style.display="";
	
	if(jrmBuzz1.indexOf("null")!=-1){
		document.getElementById("jrmDevice").style.display="none";
			document.getElementById("vehroute").style.display= "none";}
	else{		
		document.getElementById("jrmDevice").innerHTML=jrmBuzz1;
		document.getElementById("jrmDevice").style.display="";		
				if(peripheral.indexOf(jrmBuzz)!=-1)
					{
						document.getElementById("vehroute").style.display= "";
					}
					else{
						document.getElementById("vehroute").innerHTML= "none";
	}
	}
	
	chkReject();
	}catch(e)
	{alert(e);}
}



function trim(inputString) {
	   // Removes leading and trailing spaces from the passed string. Also removes
	   // consecutive spaces and replaces it with one space. If something besides
	   // a string is passed in (null, custom object, etc.) then return the input.
	   if (typeof inputString != "string") { return inputString; }
	   var retValue = inputString;
	   var ch = retValue.substring(0, 1);
	   while (ch == " ") { // Check for spaces at the beginning of the string
	      retValue = retValue.substring(1, retValue.length);
	      ch = retValue.substring(0, 1);
	   }
	   ch = retValue.substring(retValue.length-1, retValue.length);
	   while (ch == " ") { // Check for spaces at the end of the string
	      retValue = retValue.substring(0, retValue.length-1);
	      ch = retValue.substring(retValue.length-1, retValue.length);
	   }
	   while (retValue.indexOf("  ") != -1) { // Note that there are two spaces in the string - look for multiple spaces within the string
	      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // Again, there are two spaces in each of the strings
	   }
	   return retValue; // Return the trimmed string back to the user
	} // Ends the "trim" function


	
	function RouteName(VehRegNo)
	{
		 //alert("in fun");
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
					document.getElementById("vehroute").innerHTML = reslt;
				
					}
					else
					{
									
					}
				}
			
			var queryString = "?VehRegNo="+VehRegNo;
		
			
			ajaxRequest.open("GET", "AjaxgetVehroute.jsp" + queryString, true);
			ajaxRequest.send(null); 
	}


/* function validateCID(txtCleanerId)
{
	
	try
	{
	var CleanerId = document.getElementById("CleanerId").value;
	var trans = document.getElementById("transporter").value; 
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
		    reslt = reslt.replace(/\s+/g,'');
	
			if(reslt=='true')
			{
				document.getElementById("Submit").disabled=false;	
			}
			else
			{
				alert("Cleaner ID is not valid! Please enter valid Cleaner ID");
				document.getElementById("Submit").disabled=true;
				document.getElementById("CleanerName").value="";
			}
					
		}
				
			catch(e)
			{
				//alert(e);
			}
		} 
	};

	var queryString = "?txtCleanerId="+txtCleanerId+"&transporter="+trans;
	ajaxRequest.open("GET", "AjaxValidateCID.jsp"+ queryString, true);
	ajaxRequest.send(null); 
	}
	catch(e)
	{
		//alert(e);
	}
} */

</script>

<script language="javascript">
function checkvalue(val)
 {
	
	 	 if(val=="Yes")
		 {	 
	        	 document.getElementById('ApproveBy').style.display='block';
	        	 document.getElementById('ApproveBy2').style.display='block';
	 	       document.getElementById('ApproveByMailID').style.display='block';
	 	      document.getElementById('ApproveByMailID2').style.display='block';  	
	 	  }	
	 	   else
	 	   {	   
	 		  document.getElementById('ApproveBy').style.display='none';
	 		 document.getElementById('ApproveBy2').style.display='none';
	 	      document.getElementById('ApproveByMailID').style.display='none';
	 	     document.getElementById('ApproveByMailID2').style.display='none';

	 	    document.getElementById('ApproveBy').value="";
	 	   document.getElementById('ApproveByMailID').value="";
		 	}

		 if(val=="Select")
		 {
			 alert("select");
	 		  document.getElementById('ApproveBy').style.display='none';
	 		 document.getElementById('ApproveBy2').style.display='none';
	 	      document.getElementById('ApproveByMailID').style.display='none';
	 	     document.getElementById('ApproveByMailID2').style.display='none';
			}	 
	 	    
 }

window.onload = function() {

	
	if(document.getElementById("NonCVeh").checked)
	{	
	 document.getElementById('ApproveBy').style.display='block';
     document.getElementById('ApproveByMailID').style.display='block';
     document.getElementById('ApproveBy2').style.display='block';
     document.getElementById('ApproveByMailID2').style.display='block';
	}
	else
	{
		document.getElementById('ApproveBy').style.display='none';
	     document.getElementById('ApproveByMailID').style.display='none';
	     document.getElementById('ApproveBy2').style.display='none';
	     document.getElementById('ApproveByMailID2').style.display='none';
	}   
};


function checkApprove()
{
	var NonCVeh=document.getElementById('NonCVeh').checked;
	var ApproveBy= document.getElementById('ApproveBy').value;
	var ApproveByMailID=document.getElementById('ApproveByMailID').value;
	ApproveBy=ApproveBy.trim();
	ApproveByMailID=ApproveByMailID.trim();
	var x=ApproveByMailID;
	var illegalChars=/[\(\)\<\>\,\:\:\\\/\""\[\]]/;
	 var approvedvalid=/^[A-Z a-z .]+$/; 
if(NonCVeh)	
{	
	if(ApproveBy.length == 0){
		alert("Please enter ApproveBy!");
		return false;
	}
	
	if(ApproveBy.trim()!="" &&   !approvedvalid.test(ApproveBy))
		{
		alert("Please Enter Only character value for ApproveBy");
		return false;
		
		}

	if(ApproveByMailID.length == 0){
		alert("Please enter ApproveByMailID!");
		return false;
	}

	 
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos< 1 || dotpos<atpos+2 || dotpos+2>=x.length || x.match(illegalChars) ) {
        alert("Please enter valid E-mail address");
        return false;
    }
	return true;
}
    
	return true;
}

</script>	 

<%! 
String reason1="", reason2=""; 
%>


<body background="#83738A" >
	 
	 <form action="RegInsert.jsp" method="post" id="register" name="register" onSubmit="return validate();" >


<div style="background:#FAFAFE;width:600px;  margin-left: 200px; margin-bottom: 300px">
<h2 style="background:#485682; color:#ffffff; cursor:pointer;">&nbsp; Registration For Briefing&nbsp;</h2>

<input type="hidden"  name="reason1" id="reason1" value="<%=reason1 %> " />
<input type="hidden"  name="reason1" id="reason2" value="<%=reason2 %> " />


<table >
<tr>
<td>
<font size="2" color="red">Note :(*) Fields Are Mandatory</font>
</td>
</tr>


<table  class="cbFormNestedTable" cellspacing="0">

<tr>
<td>
<label class="description" for="element_1" style="width: 170px;"><font size="2">&nbsp;&nbsp;Passport ID :</font></label>
</td>


<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2"><%=drverid %></font></label>
<input type="hidden" name="DriverId" id="DriverId" value="<%=drverid %>"  class="element text medium" readonly/>
</td>
</tr>
<tr>
<td>
<label class="description" for="element_1" style="width: 170px;"><font size="2">&nbsp;&nbsp;Driver Name :</label>
</td>


<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2"><%=drivernam %></font></label>
<input type="hidden"  name="DriverName" id="DriverName" value="<%=drivernam %> " class="element text medium"  readonly/>
</td>
</tr>

<tr>
<td>
<label class="description" for="element_1" style="width: 170px;"><font size="2">  <font color="red">*</font> Veh Reg No:</font></label>
</td>
<td>
<div >
<select class="element select medium" id="VehRegNo" name="VehRegNo" onchange="getPeripheral(this);" style="width: 150px">

     	      						<option value="Select" id="VehRegNo">Select</option>
     	      						
     <%
     	      						if(numOfVehRecords>0){
		try{
				for (final VehicleRegistrationNumberForTransporter vehRegNo : VehRegNumber) 
				{			
%>	
     	      	<option value="<%=vehRegNo.getVehicleRegistrationNumber()%>,<%=vehRegNo.getPeripheral() %>"> <%=vehRegNo.getVehicleRegistrationNumber()%> </option>
				<%
				}
				}catch(Exception e){
					e.printStackTrace();
				}
		}
%>	      						
     	      				
     	    					
					</select>		
						</div>
</td>
<td colspan="2">

						<div id="jrmDevice" style="display:none"><label  >Device:JRM</label></div>
       	                 <div id="vehroute"></div>


</td>
</tr>
</table>

<table>
<tr id="td11" style="display: none">
<td style="width: 500px">
<input type="hidden" value="" name="VehNo1" id="VehNo1"></input>

<font face="Arial" color="red"  size="2">This Vehicle is Rejected in Last Briefing</font> 

<a href="#" onclick="open1()"><font size="2"><b>Click here to View/Pass</b></font></a>
</td>
</tr>
<tr>
<td>
<input type="hidden" value="" name="VehNo2" id="VehNo2"></input>

</td>

</tr>

	</table>



<table  class="cbFormNestedTable" cellspacing="0">


<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 170px;"><font size="2">&nbsp;&nbsp;&nbsp;Vehicle Type :</label>
</td>


<td >
<label ><font size="2" id="vt11"></font></label>
<input type="hidden"  name="VehType" id="VehType" value=""/>
</td>
<td style="width: 50%;">

<b>
<font size="2" id="vt12"></font></b><label >&nbsp;Trips Done With Same Type Of Vehicle In Last 3 Month </label>

<input type="hidden"  name="VehType1" id="VehType1" value="" class="element text medium"  readonly/></td>

</tr>
</table>
<table id="Section11" style="display:inline;">
<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 170px;"> <font color="red">*</font>&nbsp;<font size="2">Driver Mobile No :</font></label>
</td>
<td>
<input type="text" name="Mob1" id="Mob1" style="width: 120px;display: inline;" value="" class="element text medium" />


<input type="text" name="Mob" id="Mob" style="width: 120px;display: none; " value="XXXX" class="element text medium" readonly=""  />
</td>
<td>
<input type="checkbox" id="chkmob" name="chkmob" value="" onclick="getvisible();">
<lable ><font face="Arial" size="2">Driver Mobile No. Not Available</font></lable>
</td>
</tr>
</table>


<table>



<tr>
<td colspan="4" class="cbFormNestedTableContainer" >
<div id="driverdiv" style="display: none">

<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">&nbsp;&nbsp;First Time Pass :</font> </label>
</td>
 </tr>
 <tr>
 <td></td>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Driver :</font></label>
</td>
<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormFieldCell">
	<input type="radio" name="ChkAdh" checked="checked" id="ChkAdh" value="No" onclick="showtext()" checked="checked"></input>
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
<tr id="tr1" style="display: none;">

<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0" >
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" for="element_1" style="width: 170px;"><font color="red">*</font>&nbsp;<font size="2">Reasons :</font></label>
</td>
<td  class="cbFormFieldCell">

<tr class="cbFormTableRow" align="center">
<td valign="top" class="cbFormLabelCell  cbFormLabel">
<select name="resources" style="width:280px" size="8" id="resources" multiple="multiple">
<%
String sql4 = "select Options from db_gps.t_JourneyGoals where Categoery='Reson_DriEntry' order by UpdatedDateTime";

		ResultSet rs4 = st.executeQuery(sql4);
		int i=0;
		while(rs4.next())
		{
		
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

<select name="assigned" id="assigned"  style="width:270px" size="8" multiple="multiple">
	
</select>
</td>
					</tr>

</td>

</tr>
</table>
</td>
</tr>

<tr align="center">

<td >
<div id="vehiclediv" style="display: none  ; margin-right: -100px">
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td></td>
<td></td>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" ><font size="2">Vehicle :</font></label>
</td>


<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormFieldCell">
<input type="radio" name="ChkAdhJ" checked="checked" id="ChkAdhJ" value="No"  onclick="showtext()" checked="checked"></input>
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
<tr id="tr2" style="display: none;">
<td colspan="4" class="cbFormNestedTableContainer" >
<table  class="cbFormNestedTable" cellspacing="0">
<tr>
<td  class="cbFormLabelCell  cbFormLabel">
<label class="description" for="element_1" style="width: 170px;"><font color="red">*</font>&nbsp;<font size="2" >Reasons :</label>
</td>
<td  class="cbFormFieldCell">
<tr class="cbFormTableRow" align="center">
<td valign="top" class="cbFormLabelCell  cbFormLabel">

<select name="resources2" style="width:270px" size="8" id="resources2" multiple="multiple">
<%



		String sql5 = "select Options from db_gps.t_JourneyGoals where Categoery='Reson_VehEntry' order by UpdatedDateTime";
         ResultSet rs5 = st.executeQuery(sql5);
		int i2=0;
		while(rs5.next())
		{
		
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

<select name="assigned2" id="assigned2" style="width:270px" size="8" multiple="multiple">
	
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
<label class="description" for="element_1" ><font size="2">&nbsp;Escalate Rejection To : </font></label>
</td>
</tr>
	<tr>
	<td>
	<label class="description" for="element_1" ><font size="2">&nbsp;Please enter mail id here : </font></label>
	</td>
<td  class="cbFormFieldCell">
<input type="text" class="element select medium" id="EmailId" name="EmailId" style="width: 350px" /><font color="red" size="1"><br>Enter Transporter Email ID Also.</font>
 </td>

 </tr>
						
						</table>

</td>

<!--<td align="center" style="margin-right: -800px">
<input id="button" type="button" name="button" class="button_text" style="border-style: outset; border-color: black" value="Submit"<%--  onclick="GetVeh('<%=drverid %>','<%=drivernam %>','<%=transporter %> --%>')" />
</td>
-->

</tr>
	
	
	</table>
	
<table id="Section1" style="display:none;">
<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 170px;"><font size="2">  <font color="red">*</font>&nbsp;Trip ID :</label>
</td>


<td  class="cbFormFieldCell">
<input type="text" name="TripId" id="TripId" value="DDDD" class="element text medium" /><font color="red" size="1"><br>Dummy trip id to be changed within 3 days from trainer history report</font>
</td>
</tr>
<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 170px;" ><font size="2">&nbsp;&nbsp;Transporter :</label>
</td>
<td  class="cbFormFieldCell">
<label class="description" for="element_1" style="width: 170px;"><font size="2"><%=trans %></font></label>
<input type="hidden" id="transporter" name="transporter" class="element text medium" 
							value="<%=trans %>" size="15"  readonly/> 
</td>
</tr>


<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 140px;"><font size="2">  <font color="red">*</font>&nbsp;Cleaner Passport ID :</label>
</td>
<td  class="cbFormFieldCell">
<!-- <input type="text" name="CleanerId" id="CleanerId" value="" class="element text medium" onblur="validateCID(this.value)" /> -->
<input type="text" name="CleanerId" id="CleanerId" value="" class="element text medium" />
</td>
</tr>


<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 140px;"><font size="2">  <font color="red">*</font>&nbsp;Cleaner Name :</label>
</td>
<td  class="cbFormFieldCell">
<input type="text" name="CleanerName" id="CleanerName" value="" class="element text medium" />
</td>
</tr>
<tr>
<td>
<label class="description" for="element_1" style="width: 170px;"><font size="2">  <font color="red">*</font>&nbsp;Trip Start Place :</font></label>
</td>
<td  class="cbFormFieldCell">

				<div align="left"><select class="element select medium" id="startplace" name="startplace">
					<option value="Select">Select</option>
			<%
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal=Calendar.getInstance();
			cal.add(Calendar.DATE, -90);
			String nintydaysback = dateFormat.format(cal.getTime()); 
			
			
			
			
			String sql6="select StartPlace from db_gps.t_castrolroutes where Owner='Castrol'  and lasttripdate>'"+nintydaysback+"' Group by StartPlace";
			ResultSet rs6=st.executeQuery(sql6);
			System.out.println(sql6);
			while(rs6.next())
			{
				startplace1=rs6.getString("StartPlace");
				%>
				<option ><%=startplace1%></option>
				
				<%
			}
	%>
					
				</select> 
				</div>
				</td>

</tr>

<tr>
<td  >
<label class="description" for="element_1" style="width: 170px;"><font size="2">  <font color="red">*</font>&nbsp;Trip Destination Place :</font></label>
</td >

<td  class="cbFormFieldCell" >


<div align="left">
 <select class="element select medium" id="endplace" name="endplace" >
					<option value="Select">Select</option>
	
					
<%
			String sql7="select EndPlace from db_gps.t_castrolroutes where Owner='Castrol' and lasttripdate>'"+nintydaysback+"' Group by EndPlace";
			ResultSet rs7=st.executeQuery(sql7);
			System.out.println(sql7);
			while(rs7.next())
			{
				desttplace1=rs7.getString("EndPlace");
				%>
				<option ><%=desttplace1%></option>
				
				<%
			}
	%>	
					
				</select> 
				</div>
</td>
</tr>
<tr>
                      <td  >
                <label class="description" for="element_1" style="width: 170px;"><font size="2">  <font color="red">*</font>&nbsp;Contract Delivery Date :</font></label>
               </td>
				<td >
				<div >
				<input type="text" id="data" name="data" value="" class="element text medium" 
		 style="width: 125px; height: 16px;"   readonly /> 
				<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "data",         // ID of the input field
      				ifFormat    : "%d-%b-%Y %H:%M",     // the date format
      				button      : "data",        // ID of the button
      				showsTime	: "true"       //Time
    				}
  					);
					</script></div>
				</td>

			</tr>

<tr>
<td  >
<label class="description" for="element_1" style="width: 170px;"><font size="2">&nbsp;&nbsp;Mode Of Briefing :</font></label>
</td>
<td class="cbFormFieldCell" colspan="2">
				<div align="left"><input type="radio" name="mode"
					value="Personal" CHECKED /> <font face="Arial" size="2">Personal</font> &nbsp;&nbsp; <input
					type="radio" name="mode" value="Video" /> <font face="Arial" size="2">Video</font> &nbsp;&nbsp; <input
					type="radio" name="mode" value="Audio" /> <font face="Arial" size="2">Audio</font></div>
</td>

</tr>


<tr>
<td  >
<label class="description" for="element_1" style="width: 170px;"><font size="2">Is a non-compliant vehicle being loaded? :</font></label>
</td>
<td class="cbFormFieldCell" colspan="2">
	<div align="left">
	<input type="radio" name="NonCVeh" id="NonCVeh" value="Yes" onchange='checkvalue(this.value)'  /> <font face="Arial" size="2">Yes</font> &nbsp;&nbsp; 
	<input	type="radio" name="NonCVeh" id="NonCVeh" value="No" checked="checked"  onchange='checkvalue(this.value)' /> <font face="Arial" size="2">No</font> &nbsp;&nbsp;
	
	</div>
</td>

</tr>

<tr>
<td  style="width: 30%;">
<label class="description" for="element_1" style="width: 140px;" id="ApproveBy2"><font size="2">  <font color="red">*</font>&nbsp;Approved by :</label>
</td>
<td  class="cbFormFieldCell">
	<input type="text" name="ApproveBy" id="ApproveBy"  class="element text medium"  />
</td>
</tr>

<tr>
<td  style="width: 30%;">
	<label class="description" for="element_1" style="width: 140px;" id="ApproveByMailID2"><font size="2">  <font color="red">*</font>&nbsp;Approved by Email Id</label>
</td>
<td  class="cbFormFieldCell">
	<input type="text" name="ApproveByMailID" id="ApproveByMailID"  class="element text medium"  />
</td>
</tr>



<tr><td></td></tr>
<tr>

<td></td>

<td>
<input align="center" id="Submit" type="submit" name="Register" class="button_text" style="border-style: outset; border-color: black"  value="Register"/>
</td>

</tr>
 
<tr></tr>
</table>
</table>
</div>

<html>
     

    </body>
</html>

</form>

</body></html>
<%@ include file="footernew.jsp" %>