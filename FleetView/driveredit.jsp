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
<%-- <jsp:useBean id="centconn" class="FormToolConnection.FormToolConn" scope="page"> --%>





<script>

function validation()
{

abc();
document.getElementById("dirid1").style.display="none";
document.getElementById("dirid3").style.display="none";
	var driverid=document.drivermgt.driverid.value;
	if(driverid.trim()==""||driverid==null)
	{
		
		//alert("Please Enter Driver ID");
		document.getElementById("dirid1").style.display="";
			return false; 
		}
	var invalid=/^[A-Za-z0-9 +-.,/ @()]+$/;
	var invalid1=/^[#!$*%]+$/;
	
	/* 
	var invalid=/^[A-Za-z0-9 -+.,/()]+$/;
	var invalid1=/^[#!$*%]+$/; */
	if(!invalid.test(driverid) || invalid1.test(driverid))
	{
	document.getElementById("dirid3").style.display="";
	    return false;
	} 
	

	
	
	
	document.getElementById("name1").style.display="none";
	document.getElementById("name2").style.display="none";	
	var name1=document.getElementById("drivername").value;
	var invalid=/^[A-Za-z .]+$/;

	if(name1.trim()=="" || name1==null){
	document.getElementById("name1").style.display="";
		return false;
	}
	if(!invalid.test(name1)){
	document.getElementById("name2").style.display="";
	     return false;
	 }	

	//document.getElementById("fatherlabel").styl="none";	
	 var name=document.getElementById("fathername").value;
	var invalid=/^[a-zA-Z .]+$/;
	/* if(name.trim()=="" || name==null ){
		//document.getElementById("fatherlabel").style.display="none";
			//return false;
		}  */
	if(!invalid.test(name) && name.trim()!=""){
		 document.getElementById("fatherlabel").style.display="";
			     return false;
			 }	

		
			
	document.getElementById("add12").style.display="none";
	document.getElementById("add13").style.display="none";	
	var peraddr=document.getElementById("address1").value;
	var invalid=/^[A-Za-z0-9 -.,&/]+$/m;
	var invalid1=/^[#!@$(*)%+]+$/m;
	if(peraddr.trim()=="" || peraddr==null){
	document.getElementById("add12").style.display="";
		return false;
	}
	 if(!invalid.test(peraddr) || invalid1.test(peraddr))
	 {
	document.getElementById("add13").style.display="";
	     return false;
	 } 	
//current address
	 document.getElementById("add14").style.display="none";
		document.getElementById("add15").style.display="none";	
		var curraddr=document.getElementById("address2").value;
		var invalid=/^[A-Za-z0-9 -.,&/]+$/m;
		var invalid1=/^[#!@$(*)%+]+$/m;
		if(curraddr.trim()=="" || curraddr==null){
		document.getElementById("add14").style.display="";
			return false;
		}
		 if(!invalid.test(curraddr) || invalid1.test(curraddr))
		 {
		document.getElementById("add15").style.display="";
		     return false;
		 } 	
	
	
	

var dob=document.drivermgt.dob.value;
			 	document.getElementById("doblabel").style.display="none";
			 	var dat = new Date();
			 var curday = dat.getDate();
			 var curmon = dat.getMonth()+1;
			 var curyear = dat.getFullYear();
			 var dd11,dd22,dd33,mm1,mm2,mm3,mm11,mm22,mm33,yy11,yy22,yy33;
			 var stm1,stm2,stm11,stm22;



			 dd11=dob.substring(0,2);
			 //alert("dd11 is"+dd11);

			 mm3=dob.substring(3,6);

			 //alert("mm3 is"+mm3);


			 if(mm3=="Jan")
			 {
			 	mm3="01";
			 }
			 else if(mm3=="Feb")
			 {//alert("in feb");
			 mm3="02";
			 }else if(mm3=="Mar")
			 {
			 	mm3="03";
			 }
			 else if(mm3=="Apr")
			 {
			 	mm3="04";
			 }

			 else if(mm3=="May")
			 {
			 	mm3="05";
			 }
			 else if(mm3=="Jun")
			 {
			 	mm3="06";
			 }
			 else if(mm3=="Jul")
			 {
			 	mm3="07";
			 }
			 else if(mm3=="Aug")
			 {
			 	mm3="08";
			 }
			 else if(mm3=="Sep")
			 {
			 	mm3="09";
			 }
			 else if(mm3=="Oct")
			 {
			 	mm3="10";
			 }else if(mm3=="Nov")
			 {
			 	mm3="11";
			 }
			 else if(mm3=="Dec")
			 {
			 	mm3="12";
			 }
			 //alert("mm3 is"+mm3);

			 yy33=dob.substring(7,11);


			 //alert("yy33 is"+yy33);




			 var mon1 = parseInt(mm3,10);
			 var dt1 = parseInt(dd11,10);
			 var yr1 = parseInt(yy33,10);

			 //  alert("mon1 is"+mon1);
			 // alert("dt1 is"+dt1);
			 // alert("yr1 is"+yr1);





			 var calday = parseInt(dd11,10);
			 var calmon = parseInt(mm3,10);
			 var calyear = parseInt(yy33,10);

			 //  alert("calday is"+calday);
			 //  alert("calmon is"+calmon);
			 //  alert("calyear is"+calyear);


			 console.log(calday);
			 console.log(calmon);
			 console.log(calyear);
			  var now = new Date();
			  var dob123=calday+"/"+calmon+"/"+calyear;
			   //// var birthdate = dob123.split("/");
			   if(isdate(dob123))
			 	  {
			 	  var age=calculateage(parsedate(dob123),new Date());
			 	  if(age<18)
			 		  
			 		  {
			 		 document.getElementById("doblabel").style.display="";
			 		 return false;
			 		  }
			 		 // alert("Age should be greter than 18"+age);
			 	  
			 	  }

			   function parsedate(datestr)
				 {
				 var dateparts=datestr.split("/");
				 return new Date(dateparts[2],(dateparts[1]-1),dateparts[0]);

				 }
				 function calculateage(dateofbirth,datetocalculate)
				 {
				 	var calculateyear=datetocalculate.getFullYear();
				 	var calculatemonth=datetocalculate.getMonth();
				 	var calculateday=datetocalculate.getDate();
				 	
				 	var birthyear=dateofbirth.getFullYear();
				 	var birthmonth=dateofbirth.getMonth();
				 	var birthday=dateofbirth.getDate();
				 	var age=calculateyear-birthyear;
				 	var agemonth=calculatemonth-birthmonth;
				 	var ageday=calculateday-birthday;
				 	if(agemonth<0||(agemonth==0&&ageday<0))
				 		{
				 		age=parseInt(age)-1;
				 		}
				 	return age;
				 	
				 }

				 function isdate(txtDate)
				 {
				 var currval=txtDate;

				 var rxdatepattern=/^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
				 var dtarray=currval.match(rxdatepattern);
				 var dtday=dtarray[1];
				 var dtmonth=dtarray[3];
				 var dtyear=dtarray[5];
				 if(dtmonth<1 || dtmonth>12)
				 	return false;
				 else if(dtday<1 || dtday >31)
				 	return false;
				 else if((dtmonth==4 || dtmonth==6 || dtmonth==9 || dtmonth==11) && dtday==31)
				 	
				      return false;
				 else if(dtmonth==2)
				 	{
				 	var isleap=(dtyear % 4==0 && (dtyear % 100!=0 ||dtyear % 400==0));
				 	if(dtday >29 ||(dtday==29 && !isleap))
				 		return false;
				 	}
				 return true;
				 }
				
				

	
	
	

	
	
	
	
	document.getElementById("mob1").style.display="none";//please enter numeric value
	   document.getElementById("mob12").style.display="none";//please enter valid number
	   document.getElementById("mob123").style.display="none";//please enter contact number
	   document.getElementById("mob1234").style.display="none";//please enter valid contact number
	   var invalid=/^[0-9]+$/;
	   var mob=document.getElementById("mobno").value;
	   if(mob.trim()==""||mob==null)
		{
		document.getElementById("mob123").style.display="";
		return false;
		}
	  
		   
	   if(!invalid.test(mob)){
			 document.getElementById("mob1234").style.display="";
				     return false;
				 }	
		   
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("mob1").style.display="";
						return false;
					}	
					 if((mob.trim().length < 10)  || (mob.trim().length >15))
						 {
						 document.getElementById("mob12").style.display=""; 
			        return false;
			    }
			}
	
		
	
	
	


	   //document.getElementById("licnolabel").style.display="none";
	   var x=document.getElementById("licenceno").value;


	   if(x.trim()=="" || x==null)
	   	{
	   	
	   	
	   	document.getElementById("licnolabel").style.display="";
	   		return false;
	   	}

	 

	 

	}


//funtion onblur
function driveridfunc()
{
	document.getElementById("dirid1").style.display="none";
	document.getElementById("dirid3").style.display="none";
var driverid=document.drivermgt.driverid.value;
if(driverid.trim()==""||driverid==null)
{
	document.getElementById("dirid1").style.display="";
		return false;
	}
var invalid=/^[A-Za-z0-9 +-.,/ @()]+$/;
var invalid1=/^[#!$*%]+$/;
if(!invalid.test(driverid) || invalid1.test(driverid))
{
document.getElementById("dirid3").style.display="";
    return false;
} 

	}
	
	
function maritalstatusfunc()
{
	document.getElementById("maritalstatus").style.display="none";

	if( document.drivermgt.maridstatus.value == "-1" )
	{
	  //alert( "Please provide your country!" );
	  document.getElementById("maritalstatus").style.display="";
	  return false;
	}
	
	}
	

function genderfunc()
{
	
	document.getElementById("genderstatus").style.display="none";

	if( document.drivermgt.gender.value == "-1" )
	{
	  //alert( "Please provide your country!" );
	  document.getElementById("genderstatus").style.display="";
	  return false;
	}
}


function abc()
{
	
	
	var did=document.drivermgt.driverid.value;
	var id=document.drivermgt.licenceno.value;
	//alert("Licence No:-"+id);
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
	{ //document.getElementById("dirid2").style.display="none";
		if(ajaxRequest.readyState == 4)
		{     
		    
			  var reslt=ajaxRequest.responseText;
			  var abc=reslt;
			  //alert("result:-"+abc);
			  if(abc.trim()=="")
				  {
				  //alert("in if");
				  
				  //document.getElementById("licenceno").value="";
				  }
			  else{
				  alert(abc.trim());
				  document.getElementById("licenceno").value="";
				  //document.getElementById("licenceno").value="";
				  //return on;
			      //document.getElementById("err1").innerHTML=reslt;
			  }
			   //document.getElementById("err1").innerHTML=reslt;
			 

		} 
	}
	//alert("abc");
	var queryString = "?liceno1="+id;
	queryString +=  "&drid="+did;
	ajaxRequest.open("GET", "Ajax_Licnonew.jsp" + queryString, true);
	ajaxRequest.send(null); 
	//document.getElementById("dirid2").style.display="none";

	
	
}

function dobfunction()
{
	var dob=document.drivermgt.dob.value;
	document.getElementById("doblabel").style.display="none";
	var dat = new Date();
var curday = dat.getDate();
var curmon = dat.getMonth()+1;
var curyear = dat.getFullYear();
var dd11,dd22,dd33,mm1,mm2,mm3,mm11,mm22,mm33,yy11,yy22,yy33;
var stm1,stm2,stm11,stm22;



dd11=dob.substring(0,2);
//alert("dd11 is"+dd11);

mm3=dob.substring(3,6);

//alert("mm3 is"+mm3);


if(mm3=="Jan")
{
	mm3="01";
}
else if(mm3=="Feb")
{//alert("in feb");
mm3="02";
}else if(mm3=="Mar")
{
	mm3="03";
}
else if(mm3=="Apr")
{
	mm3="04";
}

else if(mm3=="May")
{
	mm3="05";
}
else if(mm3=="Jun")
{
	mm3="06";
}
else if(mm3=="Jul")
{
	mm3="07";
}
else if(mm3=="Aug")
{
	mm3="08";
}
else if(mm3=="Sep")
{
	mm3="09";
}
else if(mm3=="Oct")
{
	mm3="10";
}else if(mm3=="Nov")
{
	mm3="11";
}
else if(mm3=="Dec")
{
	mm3="12";
}
//alert("mm3 is"+mm3);

yy33=dob.substring(7,11);


//alert("yy33 is"+yy33);




var mon1 = parseInt(mm3,10);
var dt1 = parseInt(dd11,10);
var yr1 = parseInt(yy33,10);

//  alert("mon1 is"+mon1);
// alert("dt1 is"+dt1);
// alert("yr1 is"+yr1);





var calday = parseInt(dd11,10);
var calmon = parseInt(mm3,10);
var calyear = parseInt(yy33,10);

//  alert("calday is"+calday);
//  alert("calmon is"+calmon);
//  alert("calyear is"+calyear);


var curd = new Date(curyear,curmon-1,curday);
var cald = new Date(calyear,calmon-1,calday);
var diff =  Date.UTC(curyear,curmon,curday,0,0,0)-
                Date.UTC(calyear,calmon,calday,0,0,0);
var dife = datediff(curd,cald);

var x = parseInt(dife);
if(x<parseInt(18))
{
	document.getElementById("doblabel").style.display="";
  //alert("Age should be greater than 18 years");
  return false;
}
else
	{
	return true;
	}
function datediff(date1, date2)
{
    var y1 = date1.getFullYear(), m1 = date1.getMonth(), d1 = date1.getDate(),
    y2 = date2.getFullYear(), m2 = date2.getMonth(), d2 = date2.getDate();
     return [y1 - y2];
}

	}
function func()
{
	
	document.getElementById("name1").style.display="none";
	document.getElementById("name2").style.display="none";	
	var name1=document.getElementById("drivername").value;
	var invalid=/^[A-Za-z .]+$/;
	
	if(name1.trim()=="" || name1==null){
	document.getElementById("name1").style.display="";
		return false;
	}
	if(!invalid.test(name1)){
	document.getElementById("name2").style.display="";
	     return false;
	 }	
		}
		
		
		function fathernamefunction()
		{
			//document.getElementById("name1").style.display="none";
			document.getElementById("fatherlabel").style.display="none";	
		var name=document.getElementById("fathername").value;
		var invalid=/^[a-zA-Z .]+$/;
		if(name==""||name==null){
			document.getElementById("fatherlabel").style.display="none";
				return false;
			} 
		if(!invalid.test(name)){
			 document.getElementById("fatherlabel").style.display="";
				     return false;
				 }	
		
		

			
		}
		
		
		
		
	
			
			 
			 function mydateofbirt()
			 {
			 	
			 	
			 	
			 	var dob=document.drivermgt.dob.value;
			 	document.getElementById("doblabel").style.display="none";
			 	var dat = new Date();
			 var curday = dat.getDate();
			 var curmon = dat.getMonth()+1;
			 var curyear = dat.getFullYear();
			 var dd11,dd22,dd33,mm1,mm2,mm3,mm11,mm22,mm33,yy11,yy22,yy33;
			 var stm1,stm2,stm11,stm22;



			 dd11=dob.substring(0,2);
			 //alert("dd11 is"+dd11);

			 mm3=dob.substring(3,6);

			 //alert("mm3 is"+mm3);


			 if(mm3=="Jan")
			 {
			 	mm3="01";
			 }
			 else if(mm3=="Feb")
			 {//alert("in feb");
			 mm3="02";
			 }else if(mm3=="Mar")
			 {
			 	mm3="03";
			 }
			 else if(mm3=="Apr")
			 {
			 	mm3="04";
			 }

			 else if(mm3=="May")
			 {
			 	mm3="05";
			 }
			 else if(mm3=="Jun")
			 {
			 	mm3="06";
			 }
			 else if(mm3=="Jul")
			 {
			 	mm3="07";
			 }
			 else if(mm3=="Aug")
			 {
			 	mm3="08";
			 }
			 else if(mm3=="Sep")
			 {
			 	mm3="09";
			 }
			 else if(mm3=="Oct")
			 {
			 	mm3="10";
			 }else if(mm3=="Nov")
			 {
			 	mm3="11";
			 }
			 else if(mm3=="Dec")
			 {
			 	mm3="12";
			 }
			 //alert("mm3 is"+mm3);

			 yy33=dob.substring(7,11);


			 //alert("yy33 is"+yy33);




			 var mon1 = parseInt(mm3,10);
			 var dt1 = parseInt(dd11,10);
			 var yr1 = parseInt(yy33,10);

			 //  alert("mon1 is"+mon1);
			 // alert("dt1 is"+dt1);
			 // alert("yr1 is"+yr1);





			 var calday = parseInt(dd11,10);
			 var calmon = parseInt(mm3,10);
			 var calyear = parseInt(yy33,10);

			 //  alert("calday is"+calday);
			 //  alert("calmon is"+calmon);
			 //  alert("calyear is"+calyear);


			 console.log(calday);
			 console.log(calmon);
			 console.log(calyear);
			  var now = new Date();
			  var dob123=calday+"/"+calmon+"/"+calyear;
			   //// var birthdate = dob123.split("/");
			   if(isdate(dob123))
			 	  {
			 	  var age=calculateage(parsedate(dob123),new Date());
			 	  if(age<18)
			 		  
			 		  {
			 		 document.getElementById("doblabel").style.display="";
			 		 return false;
			 		  }
			 		 // alert("Age should be greter than 18"+age);
			 	  
			 	  }

			     
			 }

			 function parsedate(datestr)
			 {
			 var dateparts=datestr.split("/");
			 return new Date(dateparts[2],(dateparts[1]-1),dateparts[0]);

			 }
			 function calculateage(dateofbirth,datetocalculate)
			 {
			 	var calculateyear=datetocalculate.getFullYear();
			 	var calculatemonth=datetocalculate.getMonth();
			 	var calculateday=datetocalculate.getDate();
			 	
			 	var birthyear=dateofbirth.getFullYear();
			 	var birthmonth=dateofbirth.getMonth();
			 	var birthday=dateofbirth.getDate();
			 	var age=calculateyear-birthyear;
			 	var agemonth=calculatemonth-birthmonth;
			 	var ageday=calculateday-birthday;
			 	if(agemonth<0||(agemonth==0&&ageday<0))
			 		{
			 		age=parseInt(age)-1;
			 		}
			 	return age;
			 	
			 }

			 function isdate(txtDate)
			 {
			 var currval=txtDate;

			 var rxdatepattern=/^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
			 var dtarray=currval.match(rxdatepattern);
			 var dtday=dtarray[1];
			 var dtmonth=dtarray[3];
			 var dtyear=dtarray[5];
			 if(dtmonth<1 || dtmonth>12)
			 	return false;
			 else if(dtday<1 || dtday >31)
			 	return false;
			 else if((dtmonth==4 || dtmonth==6 || dtmonth==9 || dtmonth==11) && dtday==31)
			 	
			      return false;
			 else if(dtmonth==2)
			 	{
			 	var isleap=(dtyear % 4==0 && (dtyear % 100!=0 ||dtyear % 400==0));
			 	if(dtday >29 ||(dtday==29 && !isleap))
			 		return false;
			 	}
			 return true;
			 }
			
			
		
			
		
		
		
function address()
{//document.getElementById("add1").style.display="none";
 //document.forms
 document.getElementById("add1").style.display="none";
	var addr=document.getElementById("address2").value;	
	
	
	if(addr.trim()=="" || addr==null)
		{
		document.getElementById("add1").style.display="";
		return false;
		}
}




function permanentaddress()
{
	 document.getElementById("add12").style.display="none";
		var addr1=document.getElementById("address1").value;	
		
		
		if(addr1.trim()=="" || addr1==null)
			{
			document.getElementById("add12").style.display="";
			return false;
			}
	
	}
		

	
	
	



function licno()
{
var licno=document.getElementById("licenceno").value;	
	
	//var oth1=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	if(licno.trim()==""||licno==null)
		{
		document.getElementById("lic").style.display="";
		return false;
		}
}
function mobfunc()
{
	document.getElementById("mob1").style.display="none";//please enter numeric value
	   document.getElementById("mob12").style.display="none";//please enter valid number
	   document.getElementById("mob123").style.display="none";//please enter contact number
	   document.getElementById("mob1234").style.display="none";//please enter valid contact number
	   var invalid=/^[0-9]+$/;
	   var mob=document.getElementById("mobno").value;
	   if(mob.trim()==""||mob==null)
		{
		document.getElementById("mob123").style.display="";
		return false;
		}
	  
		   
	   if(!invalid.test(mob)){
			 document.getElementById("mob1234").style.display="";
				     return false;
				 }	
		   
	   if(!(mob ==0))
			{
				 if(isNaN(mob))
					{
						document.getElementById("mob1").style.display="";
						return false;
					}	
					 if((mob.trim().length < 10)  || (mob.trim().length >15))
						 {
						 document.getElementById("mob12").style.display=""; 
			        return false;
			    }
			}
			
	 
	
}

function upload(num)
{
	if(num==1)
	{
	  var name1= document.getElementById("Filename1").value;
	  var objRE = new RegExp(/([^\/\\]+)$/);
	    var strName = objRE.exec(name1);
	  //alert(strName[0]);
	  var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  { 
	  document.getElementById("Filename1").style.display="none";
	  document.getElementById("f1").innerHTML=strName[0];
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=strName[0];
	  document.getElementById("remove1").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp format file");
			document.getElementById("Filename1").value="";
			  
	  }
	}//ifnum1
	
	if(num==3)
	{
	  var name1= document.getElementById("Filename3").value;
	  var objRE = new RegExp(/([^\/\\]+)$/);
	    var strName = objRE.exec(name1);
	  //alert(strName[0]);
	  var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  { 
	  document.getElementById("Filename3").style.display="none";
	  document.getElementById("f3").innerHTML=strName[0];
	  document.getElementById("f3").style.display="";
	  document.getElementById("f8").value=strName[0];
	  document.getElementById("remove3").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp format file");
			document.getElementById("Filename3").value="";
			  
	  }
	}//ifnum1
	
	
	
	else
	{

		if(num==2)
		{
		  var name1= document.getElementById("Filename2").value;
			 //alert(name1);
			  var objRE = new RegExp(/([^\/\\]+)$/);
	    var strName = objRE.exec(name1);
	  //alert(strName[0]);
		var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  {
		  document.getElementById("Filename2").style.display="none";
		  document.getElementById("f2").innerHTML=strName[0];
		  document.getElementById("f2").style.display="";
		  document.getElementById("f7").value=strName[0];
		  document.getElementById("remove2").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp format file");
			document.getElementById("Filename2").value="";
			  
	  }
		  
		}
	}
		
}

function removess1()

{try{
			document.getElementById("f3").innerHTML="";
			document.getElementById("f3").style.display="none";
			document.getElementById("remove3").style.display="none";
			document.getElementById("Filename3").value="";
			document.getElementById("f8").value="";
			document.getElementById("Filename3").style.display="";
		}catch(e){alert(e);}}

function removess()

{try{
			document.getElementById("f2").innerHTML="";
			document.getElementById("f2").style.display="none";
			document.getElementById("remove2").style.display="none";
			document.getElementById("Filename2").value="";
			document.getElementById("f7").value="";
			document.getElementById("Filename2").style.display="";
		}catch(e){alert(e);}}

function rr()
{
//alert("hi");
try{
document.getElementById("f1").innerHTML="";
document.getElementById("f1").style.display="none";
document.getElementById("remove1").style.display="none";
document.getElementById("Filename1").value="";
document.getElementById("f6").value="";
document.getElementById("Filename1").style.display="";
}catch(e){alert(e);}
	}
	
function rr1()
{
//alert("hi");
try{
document.getElementById("f3").innerHTML="";
document.getElementById("f3").style.display="none";
document.getElementById("remove3").style.display="none";
document.getElementById("Filename3").value="";
document.getElementById("f8").value="";
document.getElementById("Filename3").style.display="";
}catch(e){alert(e);}
	}


function checkdriverid()
{
	
	var id=document.drivermgt.driverid.value;
	document.getElementById("dirid1").style.display="none";
	document.getElementById("dirid2").style.display="none";
	

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
	{ //document.getElementById("dirid2").style.display="none";
		if(ajaxRequest.readyState == 4)
		{
			   var reslt=ajaxRequest.responseText;
			   document.getElementById("err").innerHTML=reslt;  
			   /* var ajaxDisplay = document.getElementById('ajaxDiv1');
			      ajaxDisplay.innerHTML = ajaxRequest.responseText;
			      return false; */
			
			   /* var finalres=reslt.trim();	
				//	alert("After trim      "+reselt);
					  if(finalres=="Yes")
				  {
						  
					alert("Driver Id Already Exist ");
					
					
				  }   */
	             
			
			

		} 
	}
	var queryString = "?driverid="+id;
	ajaxRequest.open("GET", "Ajax_Driveridnew.jsp" + queryString, true);
	ajaxRequest.send(null); 
	//document.getElementById("dirid2").style.display="none";
	  
}

function licnofunc()
{
	document.getElementById("licnolabel").style.display="none";
    var x=document.getElementById("licenceno").value;


if(x.trim()=="" || x==null)
	{
	//document.getElementById("err1").style.display='none';
	 document.getElementById("licnolabel").style.display="";
		return false;
	}
	
var id=document.drivermgt.licenceno.value;
//alert("Licence No:-"+id);
var did=document.drivermgt.driverid.value;
//alert("id:-"+id);
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
{ //document.getElementById("dirid2").style.display="none";
	if(ajaxRequest.readyState == 4)
	{
		  var reslt=ajaxRequest.responseText;
		  var abc=reslt;
		  
		  if(abc.trim()=="")
			  {
			  
			  }
		  else{
			  alert(abc.trim());
			  document.getElementById("licenceno").value="";
		     //document.getElementById("err1").innerHTML=reslt;
		  }
		   //document.getElementById("err1").innerHTML=reslt;
		 

	} 
}
var queryString = "?liceno1="+id;
queryString +=  "&drid="+did;
ajaxRequest.open("GET", "Ajax_Licnoeditnew.jsp" + queryString, true);
ajaxRequest.send(null); 
//document.getElementById("dirid2").style.display="none";

	
}

function getReason()
{

	//alert("hi ");
	
	var status=document.getElementById("status").value;
	//alert("hi  1");
	if(status=="Active")
	{
		document.getElementById("reasonD").value="";
		document.getElementById("reasonD").style.display="none";
		document.getElementById("rename").style.display="none";
		
		
		
	}
	else
		{
		document.getElementById("reasonD").style.display="";
		document.getElementById("rename").style.display="";
		
		
	}
	
}


function add(num)
{
	if(num==1){
	document.getElementById("olddobfnm").style.display="none";
	document.getElementById("add").style.display="none";
	document.getElementById("back").style.display="";
	
	document.getElementById("Filename1").style.display="";
	}

	
		//alert("hi>>else");

		if(num==2){
			//alert("hi>>num2");
			//alert(document.getElementById("oldaddfnm123").value);
			document.getElementById("oldaddfnm123").style.display="none";
			document.getElementById("add2").style.display="none";
			document.getElementById("back2").style.display="";
			
			document.getElementById("Filename2").style.display="";
			}

	
		if(num==3)
			{
			//alert(document.getElementById("oldaddfnm123").value);
			document.getElementById("oldaddfnm1234").style.display="none";
			document.getElementById("add3").style.display="none";
			document.getElementById("back3").style.display="";
			
			document.getElementById("Filename3").style.display="";
			
			}

	
	
}
function back(num)
{
	if(num==1){
		document.getElementById("olddobfnm").style.display="";
		document.getElementById("Filename1").style.display="none";
		document.getElementById("back").style.display="none";
		document.getElementById("add").style.display="";
		
		
		}
	

		if(num==2){
			document.getElementById("oldaddfnm123").style.display="";
			document.getElementById("Filename2").style.display="none";
			document.getElementById("back2").style.display="none";
			document.getElementById("add2").style.display="";
			
			
			}

		if(num==3){
			document.getElementById("oldaddfnm1234").style.display="";
			document.getElementById("Filename3").style.display="none";
			document.getElementById("back3").style.display="none";
			document.getElementById("add3").style.display="";
			
			
			}      


	
} 


function permanentaddressvalidation()
{
	document.getElementById("add12").style.display="none";
	document.getElementById("add13").style.display="none";	
	var peraddr=document.getElementById("address1").value;
	var invalid=/^[A-Za-z0-9 -.,&/]+$/m;
	var invalid1=/^[#!@$(*)%+]+$/m;
	if(peraddr.trim()=="" || peraddr==null){
	document.getElementById("add12").style.display="";
		return false;
	}
	 if(!invalid.test(peraddr) || invalid1.test(peraddr))
	 {
	document.getElementById("add13").style.display="";
	     return false;
	 } 	
	 	
		}
		
function curraddrvalid()
{
	
	document.getElementById("add14").style.display="none";
	document.getElementById("add15").style.display="none";	
	var curraddr=document.getElementById("address2").value;
	var invalid=/^[A-Za-z0-9 -.,&/]+$/m;
	var invalid1=/^[#!@$(*)%+]+$/m;
	if(curraddr.trim()=="" || curraddr==null){
	document.getElementById("add14").style.display="";
		return false;
	}
	 if(!invalid.test(curraddr) || invalid1.test(curraddr))
	 {
	document.getElementById("add15").style.display="";
	     return false;
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
//String username=(String)session.getAttribute("usertypevalue");
String ck;

%>

<%!
Connection conn;
Statement st,st1;
String group="";
%>
<%
Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
Statement stquery=conn.createStatement();


%>

<%
try{
	 //request.setCharacterEncoding("UTF-8");
String 	username="",driveid="",marrid="",drivename="",ownernm="",gpnm="",status="",entyby="",address="",Gender="",dob="",mobno="",fathernm="",dactreason="",licno1="",licexp1="";
String Add2="",DOIn="";
username=(String)session.getAttribute("usertypevalue");
String clean=request.getParameter("clean");
System.out.println("Clean"+clean);
String Save=request.getParameter("save");
String cktrip=request.getParameter("cktrip");
driveid=request.getParameter("id");
drivename=request.getParameter("name");
//request.setCharacterEncoding("UTF-8");
address=request.getParameter("add");
Gender=request.getParameter("Gender");
dob=request.getParameter("dob");
mobno=request.getParameter("mobno");
fathernm=request.getParameter("fathernm");

marrid=request.getParameter("marrid");
dactreason=request.getParameter("dreason");
licno1=request.getParameter("licno1");
ownernm=request.getParameter("owner");
gpnm=request.getParameter("gpname");
status=request.getParameter("status");
entyby=request.getParameter("entryby");
 licexp1=request.getParameter("licexp");
 //newlicfile
 datenew1=licexp1;
//request.setCharacterEncoding("UTF-8");
Add2=request.getParameter("Address2");
DOIn=request.getParameter("DOiN");
String DProof="",AProof="",LProof="";

LProof=request.getParameter("LProof");
DProof=request.getParameter("DProof");
AProof=request.getParameter("Aproof");
System.out.println("DProof is " +DProof);
System.out.println("AProof is " +AProof);





String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy")
.format(new java.util.Date());

if(Save!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Save Successfully");
	</script>
	<%
}
if(cktrip!=null)
{
	%>
	<script type="text/javascript">
	alert("Cleaner ID Already Exist");
	</script>
	<%
}

%>
 
<%!String yy="",mm="",dd="",mm1="",date4=""; %>
<%/* String lixexp[]=licexp1.split("-");

System.out.println("year"+lixexp[0]);
yy=lixexp[0];
System.out.println("month"+lixexp[1]);
mm=lixexp[1];
System.out.println("date"+lixexp[2]);
dd=lixexp[2];
if(mm=="01")
{
	mm1="Jan";
}
 if(mm=="02")
{//alert("in feb");
mm1="Feb";
} if(mm=="03")
{
	mm1="Mar";
}
 if(mm=="04")
{
	mm1="Apr";
}

 if(mm=="05")
{
	mm1="May";
}
 if(mm=="06")
{
	mm1="Jun";
}
 if(mm=="07")
{
	mm1="Jul";
}
 if(mm=="08")
{
	mm1="Aug";
}
 if(mm=="09")
{
	mm1="Sep";
}
if(mm=="10")
{
	mm1="Oct";
} if(mm=="11")
{
	mm1="Nov";
}
else
{
	mm1="Dec";
} */
//date4=dd+"-"+mm1+"-"+yy;
date4=licexp1;
System.out.println("date driver edit licexpdate"+date4);

%>

<%-- <%!String drivername1=""; String driverid1="";
String fathername1=""; String paddr1=""; String caddr2="";String mob123="";String licno12="";  %>

<% 
Cookie cookie=null;
Cookie[] cookies = null;
 cookies =request.getCookies();
if( cookies != null )
{
	
	
	for (int i = 0; i < cookies.length; i++)
	{
		   cookie = cookies[i];
		   {
			   if((cookie.getName( )).compareTo("dname1") == 0 )
			   {
				   drivername1=cookie.getValue( );
				   cookie.setMaxAge(60);
				 				   
				   
			   }
			   
			   if((cookie.getName( )).compareTo("fname1") == 0 )
			   {
				   fathername1=cookie.getValue( );
				  cookie.setMaxAge(60);
				  
			   }
			  			   
		   if((cookie.getName( )).compareTo("padd1") == 0 )
		   {
				
			   paddr1=cookie.getValue( );
			   cookie.setMaxAge(60);
			   
		   }
		   
		   if((cookie.getName( )).compareTo("dirid12") == 0 )
		   {
				
			   driverid1=cookie.getValue( );
			   cookie.setMaxAge(60);
			   
		   }
		  		   
		   if((cookie.getName( )).compareTo("cadd2") == 0 )
		   {
				
			   caddr2=cookie.getValue( );
			   cookie.setMaxAge(60);
			   
		   }
		 
		   if((cookie.getName( )).compareTo("mobno12") == 0 )
		 
		   {	
			   mob123=cookie.getValue( );
			   cookie.setMaxAge(60);
			   
		   }
		 
		   if((cookie.getName( )).compareTo("licno12") == 0 )
				 
		   {	
			   licno12=cookie.getValue( );
			   cookie.setMaxAge(60);
			   
		   }  
		   		 
			   
		   }
		  
		
	}
	
	
}
if( cookies == null )
{
	drivername1="";
	fathername1="";
	   paddr1="";
	   driverid1="";
	   caddr2="";
	   mob123="";
	   licno12="";
	   
}


%> --%>


<%@ include file="headernew.jsp"%> 
<form name="drivermgt" action="editdriver.jsp" method="post"  enctype="multipart/form-data" onsubmit="return validation()" >
<br>
<br>
<div align="center" class="headerlay"><table style="color:#fff;"><tbody><tr><td><label id="element_1" name="element_1"  class="description" for="element_1"><font size="3px" color="black"><b>Edit Driver</b></font> </label></td></tr></tbody></table></div>
<table border="0" width="400" align="center" class="sortable_entry_new">
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Driver Id :</b> </label><input id="driverid" name="driverid"  style="width: 200px;"  class="element text medium" type="hidden"  value="<%= driveid %>"/> <%= driveid %></textarea><br><br><!--1,1-->
                  <div>
				<label id="dirid1" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Driver Id</font></label> 
				<label id="dirid2" style="display: none;"><font face="Arial" size="1" color="red">Driver Id Already Exist!</font></label> 
				<label id="dirid3" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Valid Characters</font></label> 							
				</div>
				<!-- <font face="Arial" size="2" color="red">
				<div id='ajaxDiv1'></div>
				</font>  -->
				<font face="Arial" size="2" color="red">
				<span id="err"> </span>
				</font> 
				

</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Driver Name:</b> </label><input id="drivername" name="drivername"  class="element text medium" type="text"  value="<%=drivename %>"  onblur="func()"/></textarea><br><br><!--2,1-->
 <div>
				<label id="name1" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Name</font></label> 
				<label id="name2" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Character Value</font></label> 
				</div>
</td>


<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Father's Name:</b> </label><input id="fathername" name="fathername"  class="element text medium" type="text"  value="<%=fathernm%>" onblur="fathernamefunction()"/></textarea><br><br><!--2,1-->
<div> 
<label id="fatherlabel" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Character Value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>     
</div>
</td>
<td><!--2,2--></td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font> <b>Permanent Address:</b> </label><textarea id="address1" name="address1"  class="element textarea medium"  onblur="permanentaddressvalidation()"><%=address %></textarea><br><br><!--3,1-->
<div> 
<label id="add12" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Permanent Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>     
<label id="add13" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Valid Characters only&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>       
</div>

</td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font><b>Current Address:</b> </label><textarea id="address2" name="address2"  class="element textarea medium"  onblur="curraddrvalid()" ><%=Add2%></textarea><br><br><!--3,2-->
<div> 
<label id="add14" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Current Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label> 
<label id="add15" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Valid Characters only&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>          
</div>

</td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Gender:</b> </label><select id="gender" style="width: 200px;"  name="gender"  class="element select medium" > 
<option value="<%=Gender%>"><%=Gender%></option>
<%
           if(Gender.equals("-"))
           {

         	  %>
         	            <option value="Male">Male</option>
         	           <option value="Female">Female</option>
         	            
         	  
         	  <%  
        	   
           }else
        	   
        	   
          if(Gender.equals("Select"))
          {
        	  %>
        	            <option value="Male">Male</option>
        	           <option value="Female">Female</option>
        	            
        	  
        	  <%
          }else
          if(Gender.equals("Female"))
          {
        	  %>
        	            <option value="Male">Male</option>
        	           
        	  
        	  <%
          }
          else{
          %>
              
                    <option value="Female">Female</option>
          
          <%
          }
          %>
         

</select></textarea><br><!--4,1-->
<div>
				<label id="genderstatus" style="display: none;"><font face="Arial" size="1" color="red">Please Select Gender</font></label> 
				
				</div>

</td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Marital Status:</b> </label><select id="maridstatus" name="maridstatus"  class="element select medium"> 
 <option value="<%=marrid%>"><%=marrid%></option>
        	  
        	<%
        	
        	if(marrid.equals("-"))
            {
          	  %>
          	            <option value="Married">Married</option>
          	  
          	
                      <option value="Unmarried">Unmarried</option>
          	            
          	  
          	  <%
            }else
        	
          if(marrid.equals("Select"))
          {
        	  %>
        	            <option value="Married">Married</option>
        	  
        	
                    <option value="Unmarried">Unmarried</option>
        	            
        	  
        	  <%
          }else
          if(marrid.equals("Married"))
          {
        	  %>
        	   
               <option value="Unmarried">Unmarried</option>
        	  
        	  <%
          }
          else
          {
          %>
        	            <option value="Married">Married</option>
        	          
          
          <%
          }
          %>
                  </select></textarea><br><!--3,2-->
              </tr><tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font> <b>DOB:</b> </label><input id="dob" name="dob"  class="element text medium" type="text" style="width: 200px" value="<%=dob%>" size="15" onblur="mydateofbirt()" readonly/>
<script type="text/javascript">
  Calendar.setup({
      inputField  : "dob",         
      ifFormat    : "%d-%b-%Y",     
      button      : "dob"       
    });</script> </textarea><br><!--5,1-->
    <div>
				<label id="doblabel" style="display: none;"><font face="Arial" size="1" color="red">Age should be greater than 18 years</font></label> 
				
				</div></td>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font> <b>Mobile No:</b> </label><input id="mobno" name="mobno"  class="element text medium" type="text"  value="<%=mobno %>" onblur="mobfunc()"/></textarea><br><!--4,2-->
<div>
				<label id="mob1"  style="display: none;"><font face="Arial" size="1" color="red">Please Enter Numeric Value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
				<label id="mob12" style="display: none;"><font face="Arial" size="1" color="red"> Please Enter Valid Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
		        <label id="mob123"  style="display: none;"><font face="Arial" size="1" color="red">Please Enter Contact Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
		        <label id="mob1234" style="display: none;"><font face="Arial" size="1" color="red">Please Enter Numbers Only&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></label>
		     </div>

</td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Date Of Induction:</b> </label><input id="induction" name="induction"  class="element text medium" type="text" value="<%=DOIn%>" size="15" readonly/>
<script type="text/javascript">
  Calendar.setup({
      inputField  : "induction",         
      ifFormat    : "%d-%b-%Y",     
      button      : "induction"       
    });</script> </textarea><br><br><!--6,1--></td>
    
   
                    
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Transporter:</b> </label>

 <%    
     String usertypevalue=session.getAttribute("usertypevalue").toString();
 	String SrchTrans="";

 	String typeofuser=session.getAttribute("TypeofUser").toString();

     
 	if(typeofuser.equalsIgnoreCase("Group"))

     
 	{
         %>
         <select name="transporter" id="transporter" class="element select medium" >
         <% 
		String sqltransck="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
		System.out.println("*****8     "+sqltransck);
		ResultSet rstGrp=st.executeQuery(sqltransck);
		
		 group=session.getAttribute("usertypevalue").toString(); 
		
		int k = 0;
		while(rstGrp.next())
		{
			
		%>
		
		
		<option value="<%=rstGrp.getString("VehRegno")%>"><%=rstGrp.getString("VehRegno")%>
						</option>
		<%
			
			
			
			

			k++;
		}
		
%>
</select>
<%
	}
 	else{
 		%>
 		                     <input type="hidden"  class="element text medium" name="transporter" id="transporter" value="<%=username%>" readonly="readonly"  />
 		                      <%=username%>
 		<%
 	}
	 %>        
           
          
<%-- <input id="transporter" name="transporter"  class="element text medium" type="text"  value="<%=username%>" readonly/></textarea><br><br><!--6,2--> --%>
</td>
</tr>
<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><font color="red" size="2">*</font>  <b>License No:</b> </label><input id="licenceno" name="licensceno"  class="element text medium" type="text" value="<%=licno1%>" onblur="licnofunc()"><br><br><!--7,1-->
    <div>
				<label id="licnolabel" style="display: none;"><font face="Arial" size="1" color="red">Please Enter License no</font></label> 
				
				</div>
				<!-- <font face="Arial" size="2" color="red">
				<div id='ajaxDiv'> </div>
				</font>  -->
				<font face="Arial" size="1" color="red">
				<span id="err1"> </span> 
				</font> 
				  

</td>

<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>License Expiry:</b> </label><input id="licenseexpiry" name="licenseexpiry"  class="element text medium" type="text" value="<%=date4%>" size="15" readonly/>
<script type="text/javascript">
  Calendar.setup({
      inputField  : "licenseexpiry",         
      ifFormat    : "%d-%b-%Y",     
      button      : "licenseexpiry"       
    });</script> </textarea><br><!--7,2--></td>
</tr>

 <tr>
                          <td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Status :</b></label>
           
           
           
<select class="element select medium"  name="status" id="status" value="" onchange="getReason();"   >
         <option value="<%=status%>"><%=status%></option>
          <%
          if(status.equals("Active"))
          {
        	  %>
        	            <option value="Deactive">Deactive</option>
        	  
        	  <%
          }
          else{
          %>
                    <option value="Active">Active</option>
          
          <%
          }
          %>
         
          </select>           
            
               
           </td>
      
          
           <%
          if(status.equals("Active"))
          {
        	  %>
        <td>  <label id="rename" style="display: none" class="description"><b>Reason:</b></label><textarea id="reasonD" name="reasonD"  class="element textarea medium"  style="display:none;" ></textarea><br><br></td>
        	  
        	  
        	  <%
          }
          else
          {
          %>
          <td><label id="rename" style=""  class="description" for="rename"><b>Reason:</b></label><textarea  id="reasonD" name="reasonD" class="element textarea medium"  ><%=dactreason %></textarea><br><br></td>
          
          
          <%
          }
          %>
           
           </td>
                      
           </tr>


<td>

</td>
<td><!--7,2--></td>
</tr>

<tr>
<td >

      <label id="element_1" name="element_1"  class="description" for="element_1"><b>DOB Proof :</b> </label>
      <%
  	if(DProof=="" || DProof.equals(""))
  	{
  		%>
  		  	<lable><font face="Arial" id="olddobfnm" size="2">NA</font></lable>
  		
  		<%
  	}
  	else{
  		%>
  		  		  	<lable><font face="Arial" id="olddobfnm" size="2"><%=DProof%></font></lable>
  		
  		<%
  		
  	}
  	
  	%>
  	
  	
  	
  	
  	&nbsp;
  	
  	
  	
  <!-- 	<a href="#" onclick="add(1);" id="add" style=""><font size="2" face="Arial">Attach New</font></a>	 -->
<!--   	<a href="#" onclick="back(1);" id="back" style="display: none;"><font size="2" face="Arial">Back</font></a>	 &nbsp;  -->
  	  
      <input type="file" cols="40" name="Filename1" id="Filename1" value="" onchange="upload(1);" style="width: 250px"/>
<font size="2" face="Arial" color="black" id="f1" style="display: none;" name = "f1"></font>

<a href="#" onclick="rr();" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> <br><br>
    

</td>
<td></td>
</tr>
<tr>
<td ><label id="element_1" name="element_1"  class="description" for="element_1"><b> Permanent Address Proof :</b> </label>
	
		         	<%
  	if(AProof=="" || AProof.equals(""))
  	{
  		%>
		         	<lable><font face="Arial" id="oldaddfnm123" size="2">NA</font></lable>&nbsp;
  		
  		<%
  	}
  	else{
  		%>
		         	<lable><font face="Arial" id="oldaddfnm123" size="2"><%=AProof%></font></lable>&nbsp;
  		
  		<%
  		
  	}
  	
  	%>
		         	
		       	
		         <!-- 	
		         	<a href="#" onclick="add(2);" id="add2" style=""><font size="2" face="Arial">Attach New</font></a>	   -->
		     <!-- <a href="#" onclick="back(2);" id="back2" style="display: none;"><font size="2" face="Arial">Back</font></a>	
		     &nbsp;
		      -->
<input type="file" cols="40" name="Filename2" id="Filename2" value="" onchange="upload(2);" style="width: 250px"/>
<font size="2" face="Arial" color="black" id="f2" style="display: none;" name = "f2"></font>

<a href="#" onclick="removess();" id="remove2" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f7" name=f7 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> <br><br>
    

</td>
<td></td>
</tr>



<tr>
<td><label id="element_1" name="element_1"  class="description" for="element_1"><b>Driver License:</b> </label>

		         	<%
  	if(LProof=="" || LProof.equals(""))
  	{
  		%>
		         	<lable><font face="Arial" id="oldaddfnm1234" size="2">NA</font></lable>&nbsp;
  		
  		<%
  	}
  	else{
  		%>
		         	<lable><font face="Arial" id="oldaddfnm1234" size="2"><%=LProof%></font></lable>&nbsp;
  		
  		<%
  		
  	}
  	
  	%>
		         	
		       	
		         	<!-- 
		         	<a href="#" onclick="add(3);" id="add3" style=""><font size="2" face="Arial">Attach New</font></a>	   -->
		     <!-- <a href="#" onclick="back(3);" id="back3" style="display: none;"><font size="2" face="Arial">Back</font></a>	
		     &nbsp;
 -->
<input type="file" cols="40" name="Filename3" id="Filename3" value="" onchange="upload(3);" style="width: 250px"/>
<font size="2" face="Arial" color="black" id="f3" style="display: none;" name = "f3"></font>

<a href="#" onclick="removess1();" id="remove3" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f8" name=f8 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> <br><br>
    

</td>
<td></td>
</tr>
 
    <%--  <%@ include file="insertnewdriver.jsp"%> --%>


</table>
<div align="center">
<input type="submit" name="submit"  style="border-style: outset; border-color: black" value="submit">
</div>
 <input type="hidden" style="width: 180px;" name="GPName" id="GPName" value="<%=group%>" readonly  />
</form>
<%
}catch(Exception e)
{
	
}
finally{
	try{
	conn.close();
	}catch(Exception e)
	{
		
	}
}
%>



<%-- </jsp:useBean> --%>
<%@ include file="footernew.jsp" %>