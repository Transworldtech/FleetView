<%@ include file="headernew.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import=" java.text.*" import=" java.util.*"
	errorPage=""%>


<%!Connection conn, conn1;
	Statement st, st1, st2, st3, st4;
	String sql, sql1, sql2, sql3, sql4, username, userrole, olddate, Svehlist;
	int total, updated, dealy, disconnected, notactive, transid;
	String vid, vehno;%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title></title>
<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
<link rel="stylesheet" href="css/css.css" type="text/css"
	charset="utf-8" />
	
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">	
<script src="sorttable.js" type="text/javascript"></script>
<style type="text/css">


</style>


<script language="javascript">
showvoicepar="No";

var state = 'none';

function showwarcom1(layer_ref) {
//alert(layer_ref);
if (state == 'block') {
state = 'none';
}
else {
state = 'block';
}
if (document.all) { //IS IE 4 or 5 (or 6 beta)
eval( "document.all." + layer_ref + ".style.display = state");
}
if (document.layers) { //IS NETSCAPE 4 or below
document.layers[layer_ref].display = state;
}
if (document.getElementById &&!document.all) {
hza = document.getElementById(layer_ref);
hza.style.display = state;
}
}
UnitDamaged="No";
warcommentt="No";
NewDamage="No";
	function OnChangeFunc2(dropdown)
  	{
 		var vv1=dropdown.selectedIndex;
 		var SelValue1 = dropdown.options[vv1].value;
 
        	if(SelValue1=="Other")
       		{
             		document.getElementById("othinstloc").style.visibility="visible";
        	}      
        	else 
		{ 
         		document.getElementById("othinstloc").style.visibility="hidden";   
         		document.repunitform.othinst.value="";
             	}
 	}    
	function OnChangeChkBx()
	{

  		if(document.repunitform.instin.checked == false)
  		{
   
   			document.repunitform.tme.disabled=true;
   			document.repunitform.tme.value="";
   			document.getElementById("nwtme").style.visibility="visible";

   		}
  		else
  		{
    			document.repunitform.tme.disabled=false;
   			document.repunitform.tme.value="5.30";
   			document.repunitform.newtme.value="";
   			document.getElementById("nwtme").style.visibility="hidden";
  		}
	}
function AJAXFunc1()
{
	//alert(">>>rput222>>>");
  var v1=document.repunitform.newunid.value;
//  alert(v1);
  var owner=document.repunitform.owner.value;
 // alert(owner);

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
                
          // Create a function that will receive data sent from the server
            ajaxRequest.onreadystatechange = function()
            {
     	       if(ajaxRequest.readyState == 4)
                {
                      var reslt=ajaxRequest.responseText;
					 
                      var mySplitResult = reslt.split("#");


                     //alert(">>result1%%>>"+mySplitResult);
                      
                      var mySplitResult1=  mySplitResult[0].replace(/^\s+|\s+$/g,"");//Mobile Number

                    // alert(">>%1%%>>"+mySplitResult1);
                      
                      var mySplitResult2=  mySplitResult[1].replace(/^\s+|\s+$/g,"");//Sim Number

                      //alert(">>%%%2>>"+mySplitResult2);
                       var mySplitResult3=  mySplitResult[2].replace(/^\s+|\s+$/g,"");//Inst Type
                     
                     //  alert(">>%%3%>>"+mySplitResult3); 
                      var mySplitResult4=  mySplitResult[3].replace(/^\s+|\s+$/g,"");//Recieve by tech/cust

                      //alert(">>aaaa")
                      // alert(">>%%%4>>"+mySplitResult4);
                                           
                      var mySplitResult5=  mySplitResult[4].replace(/^\s+|\s+$/g,"");//Hold By

                      //alert(">>bbb>>")
                     // alert(">>%%%>555>"+mySplitResult5);
                     
                     
                     
                      var mySplitResult6=  mySplitResult[5].replace(/^\s+|\s+$/g,"");//Swr Ver

                      //alert(">>cccc")
                      
                     // alert(">>%%%code version>66>"+mySplitResult6);
                      
                      var mySplitResult7=  mySplitResult[6].replace(/^\s+|\s+$/g,"");//code Version


                    //  alert(">>%%%phrl1177>>"+mySplitResult7);
                      // alert(">>dd")
                      var mySplitResult8=  mySplitResult[7].replace(/^\s+|\s+$/g,"");//available
                    //  alert(">>eee>>")

                    
                  //  alert(">>%%%88>>"+mySplitResult8);
                    
                      var mySplitResult9=  mySplitResult[8].replace(/^\s+|\s+$/g,"");//JRM
					  // Results from Ajaxunitadd.jsp are put into fields
					
					 var mySplitResult10=  mySplitResult[10].replace(/^\s+|\s+$/g,"");//Type of Unit
					
					
					//alert(">>%%%rslt 10>>"+mySplitResult10);
					 //alert(">>111")
					 
					 
					 
					 
					 
					 
					  var swver=mySplitResult6;
					  var invalide=mySplitResult7;
					  var available=mySplitResult8;

					 //alert(">>222>>>")
					  
					  
					  // alert(">>%%%>>"+mySplitResult2+">>>33>>"+mySplitResult3);
 		              document.repunitform.mobno.value = mySplitResult1;
                      document.repunitform.simno.value = mySplitResult2; 
                      document.repunitform.typeunit.value = mySplitResult10; 
                      
                           try{
                      document.repunitform.InstType.value = mySplitResult3;
                           }catch(e){
                           alert(">>>hhhh"+e);
                           }

                     // alert(">>>.HI>111>>"+document.repunitform.InstType.value);
                      document.repunitform.jrm.value = mySplitResult9;
                     // document.repunitform.recby.value = mySplitResult5;
                   //   alert(">>"+mySplitResult1);
                      
                      //alert("software version is"+swver);
      					if(
      						(((swver.indexOf("AVL_LITE")!=-1)||(swver.indexOf("SIMARM")!=-1))&&(owner.indexOf("Castrol")!=-1))
      						||(((swver.indexOf("AVL_LITE")!=-1)||(swver.indexOf("SIMARM")!=-1))&&(owner.indexOf("Praxair")!=-1))
      						)
      						{
      						 alert("AVL_LITE unit is not allowed in "+owner);
      								return false;
                        		}else{
									//alert("condition is not matched");
                            		}
      					if(invalide=="Yes"){
							alert("Invalide software version in "+v1);
							return false;
                  		}
                  		if(available=="Yes"){
									alert("Unit ID "+v1+" already available in other vehicle.");
                      		}

                  	 // alert("end-1-1>>")
                  		
 	       }
            }
           // alert("end>>")
  
           var queryString = "?unid=" +v1;
 	   ajaxRequest.open("GET", "Ajaxunitadd1.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
}







function validate()
{
	//alert("in validate function")
	
	try{
	var jrm=document.repunitform.jrm.value;
	//alert(jrm);
	var instruction=document.repunitform.instruction.value;
	//alert(instruction);
	if(jrm==instruction||instruction=="-"){
			//alert("right decision!!!!!!!!");
		}else{
			alert("Only JRM units are valide for this vehicle.Please use JRM unit");
			}

	var mob=document.repunitform.mobno.value;
	//alert(">>>>juhuh>>>"+mob);
	
	//var unitholdby=document.repunitform.holdby.value;
	//alert("<<<<"+unitholdby);
	//var unitinstalby=document.repunitform.instby.value;
	//alert("<<<11"+unitinstalby);
	var recby=document.repunitform.recby.value;
	//alert("<<<222"+recby);
	//var adminoption=document.repunitform.whyoption.value;
	//alert(adminoption);
    //if(adminoption=="-"){
			//alert("Please enter proper details instead of - in Why you are using this option?");
			//return false;
        //}
    //if(adminoption==""||adminoption==null){
    	//alert("Please enter proper details in Why you are using this option?");
		//return false;
          //  }
	//unitholdby = unitholdby.replace(/^\s+|\s+$/g,"");//trim
	//alert("unitholdby"+unitholdby)
	recdby = recby.replace(/^\s+|\s+$/g,"");//trim
	//alert("unitinstalby"+unitinstalby)
	
//	alert(">>*(**(*(");
	//if(unitholdby != unitinstalby)
	//{

		//if(unitinstalby=="customer")
		//{
		//}
		//else
		//{
		//alert("Hi"+unitholdby);
		//alert("Hi"+unitinstalby);
		//alert("UNIT HOLD BY DIFFERENT TECH/CUST");
		//return false;
		//} 
	//}

	//alert("Hi"+recby);
	
	if(recby==" NO")
	{
		alert("UNIT NOT RECEIVED BY TECH/CUST. FIRST RECEIVE IT");
		return false;
		
	}

	}catch(e)
	{
   alert(">>>"+e);
	}
	//alert("@@@@>>>");
	
	if(document.repunitform.newunid.value=="")
		{ 
			alert("Please Enter New UnitId");
			return false; 
		}
	
	
	
	
	if(document.repunitform.instat.value=="Select")
	{
		alert("Please Select Installed Place");
		return false; 
	}
	// alert("@@@@>11>>");
	
	 

	
	
	
	
	
	 if(document.repunitform.unitrunon[0].checked==false && document.repunitform.unitrunon[1].checked==false)	
		{
			alert("Please select whether the Unit runs on Battery or Ignition");
			return false;
		}
		


	 if(document.repunitform.redlight[0].checked==false && document.repunitform.redlight[1].checked==false)
		{
			alert("Please Select The RED LIGHT condition");
			return false;
		}
		if(document.repunitform.greenlight[0].checked==false && document.repunitform.greenlight[1].checked==false && document.repunitform.greenlight[2].checked==false)
		{
			alert("Please Select The GREEN LIGHT Condition");
			return false;
		}
		if(document.repunitform.gpslight[0].checked==false && document.repunitform.gpslight[1].checked==false && document.repunitform.gpslight[2].checked==false)
		{
			alert("Please Select The GPS LIGHT Condition");
			return false;
		}
		if(document.repunitform.ringing[0].checked==false && document.repunitform.ringing[1].checked==false )
		{
			alert("Please Select The RINGING Status");
			return false;
		}




		var comm=document.repunitform.comment.value;
        //alert(">>>"+comm.length);
		
		//alert(">>>"+document.repunitform.warcom[0].checked);
		if(document.repunitform.warcom[0].checked==true)
		{
		if(comm.length=="1")
		{

			alert("Please Enter Warranty Comment");
			return false;
		} 

		}


	 
		var spcomt=document.repunitform.spcomment.value;	
		if(spcomt=="Select")
		{
			alert("Please Select Special Comment");
			return false;
		}


		if(document.repunitform.newunid.value=="")
		{ 
			alert("Please Enter New UnitId");
			return false; 
		}

		//alert("@@@@>44>>");
		if(document.repunitform.mobno.value=="")
		{	
			alert("The Mobile number not available");
			return false;
		}

		//alert("@@@@>55>>");
		if(document.repunitform.simno.value=="")
		{	
			alert("The sim number not available");
			return false;
		}


		
		

		if(document.repunitform.redlight[0].checked==false && document.repunitform.redlight[1].checked==false)
		{
			alert("Please Select The RED LIGHT condition");
			return false;
		}
		if(document.repunitform.greenlight[0].checked==false && document.repunitform.greenlight[1].checked==false && document.repunitform.greenlight[2].checked==false)
		{
			alert("Please Select The GREEN LIGHT Condition");
			return false;
		}
		if(document.repunitform.gpslight[0].checked==false && document.repunitform.gpslight[1].checked==false && document.repunitform.gpslight[2].checked==false)
		{
			alert("Please Select The GPS LIGHT Condition");
			return false;
		}
		if(document.repunitform.ringing[0].checked==false && document.repunitform.ringing[1].checked==false )
		{
			alert("Please Select The RINGING Status");
			return false;
		}

	 

		try{
			var comm1=document.repunitform.extracomment.value;
			//alert("@@@@>comm1>>"+comm1.length);

			if(comm1.length=="1")
			{
				alert("Please Enter Extra Comment");
				return false;
			}

			var drivercode =document.repunitform.drivercode.value;  
			 var drivermobno=document.repunitform.drivermob.value;  
			 var drivarname=document.repunitform.drivername.value;  
			//alert("@@@@>drivercode>>"+drivercode.length);
			
			
			 if(drivarname==""){
					alert("Please enter Driver Name");
					return false;
			   	 }
			if(drivermobno==""){
				alert("Please enter Driver mobile no");
				return false;
			   	 }else{
					if(drivermobno.length==10){
					}else{
							alert("Please enter drivers valid mobile number");
							return false;
						}
						if(isNaN(drivermobno))
						{
							alert("Please enter proper driver mobile no.Alfabets are not valid");
							return false;
						}

			   	 }
			
			
			
			
			
			
			
			if(drivercode.length=="0")
		  	{
		  		alert("Please enter Driver Code");
		  		return false;
		   	   
		  	}

			var drivarname=document.repunitform.drivername.value;  
//			alert(drivarname);
			 var drivermobno=document.repunitform.drivermob.value;  
//			alert(drivermobno);
			
			
			
		  	//alert(">>>drv code"+drivercode);
		  	
		  	
		  	
			
			
			
			
			 if(drivarname==""){
					alert("Please enter Driver Name");
					return false;
			   	 }

				if(drivermobno==""){
				alert("Please enter Driver mobile no");
				return false;
			   	 }else{
					if(drivermobno.length==10){
					}else{
							alert("Please enter drivers valid mobile number");
							return false;
						}
						if(isNaN(drivermobno))
						{
							alert("Please enter proper driver mobile no.Alfabets are not valid");
							return false;
						}

			   	 }
			



			}catch(e){

		alert(e);
		}



			


			
	

		var xw=document.repunitform.calender.value;

	    //  alert(">>###>>"+xw.length);
		var w=xw.length;
		
		if(w=="11" || w.equals("11"))
		{
			alert("Please Select Installed Time");
			return false; 
		}

	//alert("@@@@>22>>");
	if(document.repunitform.typeunit.value=="SELECT")
	{
		alert("Please Select Unit Type");
		return false; 
	}

	//alert("@@@@>33>>");



	//alert("@@@@>44>>");
	

	//alert("@@@@>44>>");
		
		
			if(document.repunitform.unitrunon[0].checked==false && document.repunitform.unitrunon[1].checked==false)	
	{
		alert("Please select whether the Unit runs on Battery or Ignition");
		return false;
	}
	
		
		
		if(document.repunitform.instby.value=="Select")
	{
		alert("Please Select Technician Name");
		return false; 
	}
	




		if(document.repunitform.unitrunon[0].checked==false && document.repunitform.unitrunon[1].checked==false)	
	{
		alert("Please select whether the Unit runs on Battery or Ignition");
		return false;
	}
	
	
	if(document.repunitform.mobno.value=="")
	{	
		alert("The Mobile number not available");
		return false;
	}

	//alert("@@@@>55>>");
	if(document.repunitform.simno.value=="")
	{	
		alert("The sim number not available");
		return false;
	}

	

	//alert("@@@@>66>>");

  	//alert(">rsdio>"+document.repunitform.unitrunon.value);
	
  	
	/*if(!(mob.length==10))
	{
		alert("Not Valid Mobile Number");
		return false;		
	}*/

	if(showvoicepar=="Yes")
   {
	var voic1=document.repunitform.voice1.value;
	var voic2=document.repunitform.voice2.value;

	if(voic1=="" || voic2=="")
	{
		alert("Please enter both Voice Call No's");
	        return false;
	}
	if(voic1.length<10 || voic1.length>10) 
	{
		alert("Please enter proper 10 digit Voice Call No. 1");
	        return false;
	}
	if(voic2.length<10 || voic2.length>10) 
	{
		alert("Please enter proper 10 digit Voice Call No. 2");
	        return false;
	}
	if(isNaN(voic1))
	{
		alert("Please enter proper Voice Call No. 1");
		return false;
	}
	if(isNaN(voic2))
	{
		alert("Please enter proper Voice Call No. 2");
		return false;
	}


       // return false;
   }	

	if(UnitDamaged=="Yes")
	{
		if(document.repunitform.gpsantcut.checked==false && document.repunitform.greenlightoff.checked==false && document.repunitform.loosecon.checked==false && document.repunitform.powharndam.checked==false && document.repunitform.unitfndop.checked==false)
		{
			alert("Please select damage of Old Unit");
			return false;
		}
		  /*if(document.repunitform.unitdamagedopt.value=="Select")	
  		{
			alert("Please select damage of Old Unit");
			return false;
  		}*/	
	}
	
	

	if(NewDamage=="Yes")
	{
		 if(document.repunitform.newdamageoption.value=="")	
  		{
			alert("Please enter new Unit damage option");
			return false;
  		}	
	}

	
	//alert("@@@@>comm1>>"+comm1);

	if(document.repunitform.redlight[0].checked==false && document.repunitform.redlight[1].checked==false)
	{
		alert("Please Select The RED LIGHT condition");
		return false;
	}
	if(document.repunitform.greenlight[0].checked==false && document.repunitform.greenlight[1].checked==false && document.repunitform.greenlight[2].checked==false)
	{
		alert("Please Select The GREEN LIGHT Condition");
		return false;
	}
	if(document.repunitform.gpslight[0].checked==false && document.repunitform.gpslight[1].checked==false && document.repunitform.gpslight[2].checked==false)
	{
		alert("Please Select The GPS LIGHT Condition");
		return false;
	}
	if(document.repunitform.ringing[0].checked==false && document.repunitform.ringing[1].checked==false )
	{
		alert("Please Select The RINGING Status");
		return false;
	}

	
	if(document.repunitform.warcom[0].checked==false && document.repunitform.warcom[1].checked==false )
	{
		alert("Please Select The Warranty Comment");
		return false;
	}


	var spcomt=document.repunitform.spcomment.value;	
	if(spcomt=="Select")
	{
		alert("Please Select Special Comment");
		return false;
	}
	if(document.repunitform.oldunitwith[0].checked==false && document.repunitform.oldunitwith[1].checked==false)
	{
		alert("Please select whether the Unit is with Cust / Tech / Company");
		return false;
	}

	var drivarname=document.repunitform.drivername.value;  
	var drivercode =document.repunitform.drivercode.value;  
  	//alert(drivercode);
  	
  	if(drivercode="")
  	{
  		alert("Please enter Driver Code");
  		return false;
   	   
  	}
  	
  	 var drivermobno=document.repunitform.drivermob.value;  
//  	alert(drivermobno);
    	 if(drivarname==""){
 			alert("Please enter Driver Name");
 			return false;
    	   	 }
    	if(drivermobno==""){
 		alert("Please enter Driver mobile no");
 		return false;
 	   	 }else{
 			if(drivermobno.length==10){
 			}else{
 					alert("Please enter drivers valid mobile number");
 					return false;
 				}
 				if(isNaN(drivermobno))
 				{
 					alert("Please enter proper driver mobile no.Alfabets are not valid");
 					return false;
 				}
 		   	 }
	
  return true;
	 
}

// if Type of UNit is 'Voice call', then this will get called

function voicecall(dropdown)
{
	var vv1=dropdown.selectedIndex;
 	var SelValue1 = dropdown.options[vv1].value;
	//alert(SelValue1);
 
       	if(SelValue1=="VOICECALL")
       	{
		document.getElementById("voiceparam").style.display="";
		showvoicepar="Yes";
	}   
	else
	{
		document.getElementById("voiceparam").style.display='none';
		document.unitaddform.voice1.value="";
		document.unitaddform.voice2.value="";
		showvoicepar="No";
	}   
}

function showDamageOpt(ind)
{ 
	if(ind==0)
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="visible";
		document.getElementById("damagedoption").style.display="";
		UnitDamaged="Yes";
	}
	else
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="hidden";

		document.repunitform.gpsantcut.checked=false;
		document.repunitform.greenlightoff.checked=false;
		document.repunitform.loosecon.checked=false;
		document.repunitform.powharndam.checked=false; 			
		document.repunitform.unitfndop.checked==false;	

		document.getElementById("damagedoption").style.display='none';
		document.repunitform.newdamageoption.style.visibility='hidden';

		UnitDamaged="No";
	}
}



function showwarcom(ind)
{ 
	if(ind==0)
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="visible";
		document.getElementById("warcomment").style.display="";
		warcommentt="Yes";
	}
	else
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="hidden";

		document.getElementById("warcomment").style.display='none';
		document.repunitform.newdamageoption.style.visibility='hidden';

		warcommentt="No";
	}
}

function NewDamageOpt()
{ 
	document.repunitform.newdamageoption.style.visibility="visible";
	NewDamage="Yes";
	
}

	</script>
</head>

<body id="main_body">
<div id="form_container" style="width: 800px;">

<form name="repunitform" method="get" action="repunitinsrt.jsp"
	onsubmit="return validate();">

<div class="form_container" style="text-align: center;">

<div width="100%" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;">
<table border="0" width="100%" align="center">
<tr align="center">
<td align="center">
<%
	try {
		
		
		System.out.println("=====1111=========");
		
		vid = request.getParameter("vid");
		System.out.println("=====vid========="+vid);
	
		String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_CustomerComplaints";
	String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";
	
	
	String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date());	
	 String instdate="",warranty="",instdate1="";
	 
	
	System.out.println("Creating Connection");
	Class.forName(MM_dbConn_DRIVER);
   // conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    System.out.println(">>>2222aaaaa ");
   conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
   
    System.out.println(">>>2222bbbb ");
    st=conn1.createStatement();
    System.out.println(">>>2222cccc ");
	st1=conn1.createStatement();
	
	   System.out.println(">>>2222ddd ");
    st2=conn1.createStatement();
    st3=conn1.createStatement();
    st4=conn1.createStatement();
    Statement stmt2 = conn1.createStatement();
    Statement stmt7 = conn1.createStatement();
    Statement stmt8 = conn1.createStatement();
    System.out.println(">>>2222 ");
		
		
		
		
		

		String userrole = (String)session.getAttribute("mainuser");
		String role = (String)session.getAttribute("role");

		
		 System.out.println(">>>role   11"+role);
		
		System.out.println(">>>2222   11");
		String email = "", unid = "", status = "", owner = "",Instruction="";

		java.util.Date dte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(dte);
		
		
		String  tid="";

		String cat="";
		


	

		
		
		
		
		sql = "select * from t_vehicledetails where VehicleCode='"
			+ vid + "' ";

	ResultSet rst = st2.executeQuery(sql);
	 System.out.println(">>>2222  sql 11"+sql);
	if (rst.next()) {
		status = rst.getString("Status");
		owner = rst.getString("OwnerName");
		vehno = rst.getString("VehicleRegNumber");
		email = rst.getString("TheFieldFromEmailAddress");
		Instruction=rst.getString("Instruction");
		instdate =rst.getString("InstalledDate");

		String sql8 = "select * from t_amchistory where VehNo = '"+vehno+"' order by NewDate desc limit 1" ;
		ResultSet rst2222=stmt7.executeQuery(sql8);
		System.out.println(">>>2222  sql8 11"+sql8);
		if(rst2222.next())
		{
			if(!(null==rst2222.getDate("WarrantyTill")))
			{
				
				
				
				try{
				String sql7 = "select TO_DAYS('"+rst2222.getDate("WarrantyTill")+"')-TO_DAYS('"+today+"') as days " ;
				ResultSet rst222=stmt7.executeQuery(sql7);
				System.out.println(">>>2222   %%%%%% sql7 11"+sql7);
				if(rst222.next())
				{
					if(rst222.getInt("days") > 0)
						{
							warranty="YES";
						}
					else
					{
						warranty="NO";
					}
				
					System.out.println(">>>2222 before warranty 11"+warranty);
				}
				}catch(Exception e)
				{
				out.println(e);	
					
				}
				
				
				}
					
				
				
				
				
			else{
		String sql7 = "select TO_DAYS('"+today+"')-TO_DAYS('"+instdate+"') as days " ;
		ResultSet rst222=stmt7.executeQuery(sql7);
		System.out.println(">>>2222  sql7 11"+sql7);
		if(rst222.next())
		{
			if(rst222.getInt("days") > 365)
				{
					warranty="NO";
				}
			else
			{
				warranty="YES";
			}
		
		
			
		}
		}
			
		}else{
			String sql9 = "select * from t_onlinedataotherservers where VehicleRegNo='"+vehno+"'" ;
			ResultSet rst77=stmt8.executeQuery(sql8);
			System.out.println(">>>2222  sql9s 11"+sql9);
			if(rst77.next())
			{
				
				instdate1 =rst.getString("InstDate");
				
				
				
				
				
				
				
			}
			String sql7 = "select TO_DAYS('"+today+"')-TO_DAYS('"+instdate1+"') as days " ;
			ResultSet rst222=stmt7.executeQuery(sql7);
			System.out.println(">>>2222  sql7 ELSE LOOP 11"+sql7);
			if(rst222.next())
			{
				if(rst222.getInt("days") > 365)
					{
						warranty="NO";
					}
				else
				{
					warranty="YES";
				}
			
			
				
			}
			
			
			
		}
		      
			
		String sql5 = "select * from t_unitreplacement where VehCode='"
				+ vid
				+ "' or VehregNo='"
				+ vehno
				+ "' order by rid desc limit 1";
		//out.print(sql5);
		System.out.println(">>>2222  sql5 11"+sql5);
		ResultSet rs5 = st2.executeQuery(sql5);
		if (rs5.next()) {
			unid = rs5.getString("NewUnitId");

		} else {
			//email=rst.getString("TheFieldFromEmailAddress");
			int pos = email.indexOf('@');
			unid = email.substring(2, pos);
		}

	}

		System.out.println(">>>2222 FINAL warranty 11"+warranty);
		
		String send = request.getParameter("send");
		if (send == null) {
		} else {
			String veh = "", unitidnew = "";
			String sql6 = "select * from t_vehicledetails where VehicleCode='"
					+ vid + "' ";
			ResultSet rs6 = st2.executeQuery(sql6);
			 System.out.println(">>>2222  sql6 11"+sql6);
			if (rs6.next()) {
				veh = rs6.getString("VehicleRegNumber");
				unitidnew = rs6.getString("UnitID");

			}
%>
<table border="0" width="750px" bgcolor="#77D7D4" align="center">
<tr>
	<td>
	<div align="center"><font color="maroon"><B>
	Successfuly Replaced ( Vehicle No <%=veh%> with Unit Id <%=unitidnew%>
	) </B></font></div>
	</td>
</tr>
</table>
<%
}

	String unidchk = request.getParameter("unidchk");
	if (unidchk == null) {
	} else {
		String own = request.getParameter("own");
		String vehnumb = request.getParameter("vehnumb");
%>
<table border="0" width="750px" bgcolor="#77D7D4" align="center">
<tr>
	<td>
	<div align="center"><font color="maroon"> <b>
	Unit Id <%=unidchk%> is already in Use in Vehicle no. <%=vehnumb%> of
	<%=own%> </b></font></div>
	</td>
</tr>
</table>

<%
}
%>			




<br></br>


<table border="0" width="750px" bgcolor="" align="center">
	<tr bgcolor=""><td align="center"><font color="#2A0A12" size="3"><h1 align="center">Unit Replacement</h1></font></td></tr>
</table>
<table border="0" width="750px" bgcolor="" align="center"  cellspacing="10">
	<tr bgcolor="">
		<td ><b>Transporter:</b></td>
		<td >
			<input type="text" class="element text medium" name="owner" value='<%=owner%>'
			class="formElement" readonly />
			<input type="hidden" name="instruction" class="formElement" value="<%=Instruction%>"/>
		</td>
		<td><b>Vehicle Reg. No.:</b></td>
		<td><input type="text" class="element text medium" name="vehreg" class="formElement"
			value='<%=vehno%>' readonly /></td>
	</tr>
	<tr bgcolor="">
		<td><b>Old Unit Id:</td>
		<td><input type="text" class="element text medium" name="oldunid" style="width:80px " class="formElement"
			value='<%=unid%>' /></td>
		<td><b>New Unit Id:</b></td>
		<td>
			<input type="text" class="element text medium" name="newunid" style="width:80px "    class="formElement" />
			<input type="hidden" name="jrm" class="formElement" />
		</td>
	</tr>

	<%
		//out.print(userrole);
			if (userrole.equalsIgnoreCase("service")) {
	%>

	<tr bgcolor="">
		<td rowspan="2"><b>Mobile No.:</b></td>
		<td rowspan="2"><input type="text" class="element text medium" name="mobno" size="13" onClick="AJAXFunc1()" ;
			 class="formElement" readonly></td>
		<td><b>Sim No.:</td>
		<td><input type="text" class="element text medium" name="simno" size="13" class="formElement"
			readonly></td>

	</tr>
	<tr bgcolor="#E6E6E6">
		<td><b> Type:</b></td>
		<td><input type="text"  name="InstType" size="13"
			class="element text medium" readonly></td>
	</tr>
	


	<tr bgcolor="">
		<td><b> Hold By:</b> <br>
		<b>Received Status:</b><br>
		</td>
		<td><input type="text" class="element text medium" name="holdby" size="20"
			class="formElement" readonly /> <input type="text" name="recby"
			size="20" class="formElement" readonly /></td>
	</tr>
	<%
		} else {
	%>
<tr bgcolor="">
		<td><b>Mobile No.:</b></td>
		<td><input type="text" class="element text medium" name="mobno" size="13"
			onClick="AJAXFunc1()" ; class="formElement" readonly></td>
		<td><b>Sim No.:</b></td>
		<td><input type="text" name="simno" class="element text medium" size="13" 
			readonly>
			<input type="hidden" name="holdby" size="20"
			class="formElement" readonly /> <input type="hidden" name="recby"
			size="20" class="formElement" readonly /></td>

	</tr>
	
	<tr bgcolor="">
		<td><b>Unit Type:</b></td>
		<td><input type="text" class="element text medium" name="InstType" size="13"
			 readonly></td>
		
	</tr>



	<%
		}
	%>
	<tr >
		<td><b>Installation Date:</b></td>
		<td><input type="text" class="element text medium" id="calender" name="calender" size="13"
			class="formElement" value="<%=nwfrmtdte%>" readonly class="formElement" />
		<script type="text/javascript">
               Calendar.setup(
               {
                    inputField  : "calender",         // ID of the input field
                    ifFormat    : "%d-%b-%Y %H:%M:%S",    // the date format
                    button      : "trigger",       // ID of the button
                    showsTime       : "true"   
                    }
                             );
               </script></td>
	<!--  	<td><b>Installation Time:</b></td>
		<td colspan="3"><b>HH : <select class="element select medium" name="hour" >
			<option value="Select">Select</option>
			<option value="00">00</option>
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
		</select> <b>MM :</b><select class="element select medium" name="minutes" >

			<option value="00">00</option>
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>
			<option value="50">50</option>
		</select></td> -->
	</tr>

	<%
		sql = "select Distinct(LName) as LName from db_CustomerComplaints.t_location order by LName";
	//System.out.println(">>>sql!!!before!!<<<"+sql);
	ResultSet rst2 = st.executeQuery(sql);
			System.out.println(">>>sql!!!!!<<<"+sql);
	%>
	<tr bgcolor="">
		<td><b>Installed at:</b></td>
		<td style=" "><select class="element select medium" name="instat" onChange="OnChangeFunc2(this);"
			class="formElement">

			<option  value="Select">Select</option>
			<%
				while (rst2.next()) {
			%>
			<option value="<%=rst2.getString("LName")%>"><%=rst2.getString("LName")%>
			</option>
			<%
				}
			%>
			<option value="Other"><b>Other</b></option>
		</select>
		<div id="othinstloc" style="visibility: hidden">
		<center><input type="text" name="othinst" size="20"
			class="formElement"> </input></center>
		</div>
		</td>
		<td><input type=checkbox class="element select medium"  name="instin" value="instin" checked
			onChange="OnChangeChkBx(this);" /> <b>Installed in India</b></td>
		<td><b>Time </b><input type="text" class="element select medium" name="tme" value="5:30" size="5"
			   style=""  readonly="readonly"> </input>
		<div id="nwtme" style="visibility: hidden">
		<center><input type="text" name="newtme" size="5"
			class="formElement"> </input></center>
		</div>
		</td>
		</tr>
		
		<tr bgcolor=""> 
		<td><b>Type of Unit:</b></td>
		
		<td ><input type="text" class="element select medium" name="typeunit"  style="width:165px "  
		readonly /></td>
		
		<td><b>Installed By:</b></td>
		<td> <input type="text" class="element select medium" name ="instby" value ="Customer"  style="width:80px; " readonly="readonly"> 
		<div id="voiceparam" style="display: none"><br>

		<label for="voic1" name="voic1" id="voic1" style="visibility: visible">
		<font color="maroon">Voice Call no.1 </font></label> <input type="text"
			name="voice1" class="formElement" style="visibility: visible" /> <br>
		<label for="voic2" style="visibility: visible"> <font
			color="maroon">Voice Call no.2 </font> </label> <input type="text"
			name="voice2" class="formElement" style="visibility: visible" /></div>
		
		 </td>
		
		</tr>
		
		

		</td>
	</tr>

	<!-- When Voice Call will be selected, two text boxes will get appeared to enter two Mobile No's which is mandatory-->
	
	<tr bgcolor="">
		<td><b>Old Unit Condition </b><br>
		(Physically Damaged):</td>
		<td><input type="radio" class="element select medium" class="element select medium" name="phydamaged" value="Yes"
			onClick="showDamageOpt(0);" />Yes <input type="radio"
			name="phydamaged" value="No" checked onClick="showDamageOpt(1);" />No
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
		<div id="damagedoption" style="display: none">

		<table border="0" width="100%">
			<tr>
				<td><input type="checkbox"  class="element select medium" name="gpsantcut"
					value="GPS Antenna Cut"> GPS Antenna Cut</td>
				<td><input type="checkbox" class="element select medium" name="greenlightoff"
					value="Green Light Off"> Green Light Off</td>
				<td><input type="checkbox" class="element select medium" name="loosecon"
					value="Loose Connection"> Loose Connection</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="powharndam"
					value="Power Harness Damage"> Power Harness Damage</td>
				<td><input type="checkbox" class="element select medium" name="unitfndop"
					value="Unit Found Open"> Unit Found Open</td>
				<td><a href="#" onClick="NewDamageOpt();"> Other </a></td>
			</tr>
		</table>
		</div>
		<br>
		<input type="text"  name="newdamageoption" style="visibility: hidden" />
		</td>
		<td><b>New Unit Run on:</b></td>
		<td><input type="radio" name="unitrunon" value="Battery">Battery
		<input type="radio" name="unitrunon" value="Ignition">Ignition
		</td>
	</tr>
	
	<tr bgcolor="">
		<td><b>LED Status:</b></td>
		<td>Red Light: <input type="radio" class="element select medium" name="redlight" value="On">On
		<input type="radio" class="element select medium" name="redlight" value="Off">Off <br></br>
		Green Light: <input type="radio" class="element select medium" name="greenlight" value="Stable">Stable
		<input type="radio" class="element select medium" name="greenlight" value="Blinking">Blinking
		<input type="radio" class="element select medium" name="greenlight" value="Off">Off <br></br>
		GPS Blue Light: <input type="radio" class="element select medium" name="gpslight" value="Stable">Stable
		<input type="radio" class="element select medium" name="gpslight" value="Blinking">Blinking
		<input type="radio" class="element select medium" name="gpslight" value="Off">Off <br></br>
		Ringing: <input type="radio" class="element select medium" name="ringing" value="Yes">Yes <input
			type="radio" name="ringing" value="No">No</td>

		<td><b>Warranty Comment:</b></font></td>
		
		<%
		if(warranty=="NO" || warranty.equalsIgnoreCase("NO"))
		{
		%>
		
		
		<td><input type="radio" name="warcom" value="Yes" checked="checked"
			onClick="showwarcom(0);">Yes 
			<input type="radio" name="warcom" value="No" onClick="showwarcom(1);" >No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
		

		<table border="0" width="100%">
			<tr>
				<td><textarea name="comment" class="formElement"> </textarea></td>
			</tr>


		</table>

		
		
		<%
		}else{
		%>
		<td><input type="radio" name="warcom" value="Yes" 
			onClick="showwarcom(0);">Yes 
			<input type="radio" name="warcom" value="No" onClick="showwarcom(1);" checked="checked">No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
		<div id="warcomment" style="display: none">

		<table border="0" width="100%">
			<tr>
				<td><textarea name="comment" class="formElement"> </textarea></td>
			</tr>


		</table>

		</div>
		
		
		
		
		<%
		
		
		}%>
	</tr>
	
	
	<tr bgcolor="">
		<td align="center"><b>Special Comment:</b></td>
		<td>
		<%
			String que = "select Comment from db_CustomerComplaints.t_commentlist where Modulename='DiarySystem' and Listname='Unit'";
				ResultSet rsget = stmt2.executeQuery(que);
		%> <select name="spcomment" class="element select medium" id="spcomment" class="formElement">
			<option value="Select">Select</option>
			<%
				while (rsget.next()) {
			%>
			<option value="<%=rsget.getString("Comment")%>"><%=rsget.getString("Comment")%></option>
			<%
				}
			%>
		</select></td>

		<td align="center"><b>Old Unit with:</b></td>
		<td><input type="radio" class="element select medium" name="oldunitwith" value="Cust" checked="checked">Cust
		
	</tr>
	
	<tr bgcolor="">
		<td align="center"><b>Extra Comment:</b></td>
		<td><textarea name="extracomment"  class="element select medium"  style="height: 45px"> </textarea>
		</td>
		<td colspan="2"></td>

	</tr>
	
<tr bgcolor="">
		<td><b>Driver Name:</b></td>
		<td><input type="text" class="element select medium" name="drivername" class="formElement" /></td>
		<td><b>Driver Code:</b></td>
		<td><input type="text" class="element select medium" name="drivercode" class="formElement" /></td>
	</tr>
	<tr bgcolor="">
		<td colspan="4" align="center"><b>Driver Mob. No.:</b>&nbsp;&nbsp; <input
			type="text" class="element select medium" name="drivermob" style="width:190px " /></td>
	</tr>
	
	

	
	
	
	<%
	int defaultST=0,defaultTX=0,defaultRA=0,defaultRD=0,defaultOS=0;
	String sqlDefault1="select ST,TX,AccelerationSpeedVarLimit,DecelerationSpeedVarLimit,Overspeedlimit from db_gps.t_defaultvals where OwnerName='Default'";
	ResultSet rsDefault1=st2.executeQuery(sqlDefault1);
	System.out.println(">>>sql!!!sqlDefault1!!<<<"+sqlDefault1);
	if(rsDefault1.next()){
	defaultST=rsDefault1.getInt("ST");
	defaultTX=rsDefault1.getInt("TX");
	defaultRA=rsDefault1.getInt("AccelerationSpeedVarLimit");
	defaultRD=rsDefault1.getInt("DecelerationSpeedVarLimit");
	defaultOS=rsDefault1.getInt("Overspeedlimit");
	}

	String sqlDefault="select ST,TX,RA,RD,OS from db_gps.t_vehicledetails where vehicleCode='"+vid+"'";
	ResultSet rsDefault=st2.executeQuery(sqlDefault);
	System.out.println(">>>sql!!!sqlDefault&&&!!<<<"+sqlDefault);
	if(rsDefault.next()){
		defaultST=rsDefault.getInt("ST");
		defaultTX=rsDefault.getInt("TX");
		defaultRA=rsDefault.getInt("RA");
		defaultRD=rsDefault.getInt("RD");
		defaultOS=rsDefault.getInt("OS");
	}
	
	String a="Customer ",b="cust";
	
	%>
	
     	
	<div id="dispST" style="display: none;" align="right">
		<input name="getST" id="getST" class="formElement"  size="13">
		</div>
		<div id="dispTX" style="display: none;" align="right">
		<input name="getTX" id="getTX" class="formElement"  size="13">
		</div>
		
		<div id="dispRA" style="display: none;" align="right">
		<input name="getRA" id="getRA" class="formElement"  size="13">
		</div>
		<div id="dispRD" style="display: none;" align="right">
		<input name="getRD" id="getRD" class="formElement"  size="13">
		</div>
		
		<div id="dispOS" style="display: none;" align="right">
		<input name="getOS" id="getOS" class="formElement"  size="13">
		</div>
		
	
	<br></br>
	<tr bgcolor="">
		<td colspan="4">
		<div align="center"><input type="submit" name="submit"
			value="Submit" class="formElement"></div>
		
		
			<input type="hidden" name="ST" value="<%=defaultST%>" />
				<input type="hidden" name="TX" value="<%=defaultTX%>" />
					<input type="hidden" name="RA" value="<%=defaultRA%>" />
						<input type="hidden" name="RD" value="<%=defaultRD%>" />
							<input type="hidden" name="OS" value="<%=defaultOS%>" />
								
								
								<input type="hidden"  name="oldunitwith" value="<%=b%>" />
								
								<input type="hidden" name="vid" value="<%=vid%>" />
								
		
		
			
			
			
			
			
		
		
		
		</td>
	</tr>
</table>
</td>
</tr>
</table>
</div>
</div>
<script language="javascript" >

//AJAXFunc1();

</script>

</form>
</div>

<%
System.out.println(">>>sql!!!ENDDDD!!<<<");
	} catch (Exception e) {
		out.print("Exception --->" + e);
		e.printStackTrace();
	} finally {
		//conn.close();
		conn1.close();
	}
%> <!-- code end here --->

<table width="750px" height="350px" border="0">
	<tr>
		<td></td>
	</tr>
</table>



<div id="copyright">Copyright 2008 by Transworld Compressor
Technologies Ltd. All Rights Reserved.</div>

</body>
</html>
