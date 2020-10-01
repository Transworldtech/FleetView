 <%@ include file="headernew.jsp" %>
   	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
 
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>

<script>
function showothcategry(dropdown)
{
	      //alert("welcome");
 if(dropdown=="Other")
 {
	//	alert("now in dropdown Other ");
		document.getElementById("othTripCategory").style.visibility="visible";
		 
 }
 else{
	// alert("now in dropdown primary ");
	 document.getElementById("othTripCategory").style.visibility="hidden";
 } 
		  var vv1=dropdown.selectedIndex;
		  
		  var SelValue1 = dropdown.options[vv1].value; 
		 //alert("SelValue1"+SelValue1);
		        if(SelValue1=="Other")
		        {
		            document.tripform.othTripCategory.style.visibility="visible";
		            showothTripCategory="Yes";
		        }
		        else 
		       {
		            document.tripform.othTripCategory.style.visibility="hidden";
		            document.tripform.othTripCategory.value="";
		            showothTripCategory="No";
		       }
		
}


</script>
 <script language="javascript">
var showothstartloc="No";
var showothdestloc="No";
var showothdrivid="No";
var tripgen="No";
var showothvendorr="No";
var showothcontentt="No";
var showothLoadreasonn="No";
var showothTripCategory="No";
var strtend="";

function validate()
{  
try{
	//alert("hi");
	//alert(showothdrivid);
	var v6=document.tripform.calender.value;
    var v7=document.tripform.sttime1.value;
    var v8=document.tripform.dest.value;
    var v9=document.tripform.driverid.value;
	var v10=document.tripform.tripid.value; 
	var etadate=document.tripform.etadate.value;
    var etatime1=document.tripform.etatime1.value;
/*
    alert("calender" +v6);
    alert("start time" +v7);
    alert("dest " +v8);
    alert("driver id"+v9);
    alert("trip id "+v10);
    alert("et date "+etadate);
    alert("Time "+etatime1);
    */
    
    var numericExpressionn = /^[.0-9]+$/;
   /* 
	if(document.tripform.route[0].checked==true)
	{
		var fixroute=document.tripform.routename.value;
		
		if(fixroute=="Select")
		{
			 alert("Please select the Fixed route");
		         return false;   
		}
	}
	else
	{*/
		var stloc=document.tripform.stloc.value;
		var dest=document.tripform.dest.value;
		
		if(stloc=="Select")
      		{
		         alert("Please select Start Location");
		         return false;   
      		}
		
		if(dest=="Select")
      		{
		         alert("Please select Destination");
		         return false;   
      		}
		if(showothstartloc=="Yes")
	      { 
	         var v10=document.tripform.othstrtloc.value;
	         
	         if(v10.length==0)
	         { 
	            alert("Please enter new start location");
	            return false;
	         } 
	 
	         
	      }


		 //alert(showothdestloc);
	      if(showothdestloc=="Yes")
	      { 
	          var v11=document.tripform.othdest.value;
	  	    //alert(v11);
	        
	         if(v11.length==0)
	         { 
	            alert("Please enter new destination");
	            return false;
	         }
	      }
  		//}
	 

      if(v6.length==0)
      {
         alert("Please select the departure date");
         return false;   
      }
          
      if(v7=="Select")
      {
         alert("Please select the departure time");
         return false;   
      }

      if(v9=="Select")  
      {
          alert("Please select Driver Id (Name) from the list");
          return false;   
      }
	    
      if(showothvendorr=="Yes")
      { 
          var v111=document.tripform.othvendor.value;
    	   // alert(v111);
            
         if(v111.length==0)
         { 
            alert("Please enter new vendor");
            return false;
         }
      }

      if(showothcontent=="Yes")
      { 
          var v111=document.tripform.othcontent.value;
          
         if(v111.length==0)
         { 
            alert("Please enter new product");
            return false;
         }
      }

      if(showothLoadreasonn=="Yes")
      { 
          var v1111=document.tripform.othLoadreason.value;
          
         if(v1111.length==0)
         { 
            alert("Please enter new Reason");
            return false;
         }
      }


      
     var fkms=document.tripform.fxdkm.value;//document.getElementById("fxdkm").value;
  	 var ftime=document.tripform.ftme.value;//document.getElementById("fxtme").value;
	var weit=document.tripform.weight.value;
	var friegh=document.tripform.frie.value;
	var adva=document.tripform.adv.value;
	var lrissue=document.tripform.lrissue.value;
	var lrcontact=document.tripform.lrcontact.value;
	// alert("lr issue" +lrissue);

	  //alert(lrcontact);
	  var letter = /^[A-Za-z]+$/; 
	   
	       if(!(lrissue.match(letter)) && lrissue.length!=0)  
	       {  
	          alert('Please enter characters value for LR Issue');  
	       return false;  
	       }  



 	/*if(fkms.length==0)
	{
		alert("Please enter Fixed Km");
        return false;
	}*/
 	 if(!(fkms.match(numericExpressionn))&& fkms.length!=0)
 	{
 		alert("Please enter Numeric value for Fixed Km");
        return false;
 	 }
	/*if(ftime.length==0)
	{
		alert("Please enter Fixed Time");
        return false;
	}*/
	if(!(ftime.match(numericExpressionn))&& ftime.length!=0)
 	{
 		alert("Please enter Numeric value for Fixed Time");
        return false;
 	 }
	/*if(adva.length==0)
	{
		alert("Please enter Advance value");
        return false;
	}*/
 	 if(!(adva.match(numericExpressionn))&& adva.length!=0)
 	{
 		alert("Please enter Numeric value for Advance");
        return false;
 	}
	if(!(lrcontact.match(numericExpressionn))&& lrcontact.length!=0)
 	{
 		alert("Please enter Numeric value for LR Contact");
        return false;
 	}
	/*if(friegh.length==0)
	{
		alert("Please enter Fright value");
        return false;
	}*/
 	 if(!(friegh.match(numericExpressionn))&& friegh.length!=0)
 	{
 		alert("Please enter Numeric value for Fright");
        return false;
 	 }
	/*if(weit.length==0)
	{
		alert("Please enter Weight");
        return false;
	}*/
 	if(!(weit.match(numericExpressionn))&& weit.length!=0)
 	{
 		alert("Please enter Numeric value for Weight");
        return false;
 	}
	 



     if(showothTripCategory=="Yes")
      { 
          var v1111=document.tripform.othTripCategory.value;
       /* if(v1111.length==0)
        { 
            alert("Please enter other Category");
            return false;
         }*/
      }

     //alert("new driver"+showothdrivid);
     
	if(showothdrivid=="Yes")
      {
         var v12=document.tripform.othdriverid.value;
         var v13=document.tripform.drivername.value;
         var v14=document.tripform.newdrvname.value;
   
         if(v12.length==0)
         { 
            alert("Please enter new Driver Id");
            return false;
         } 
  
         if(isNaN(v12))
         {
            alert("Please enter valid number for Driver Id");
            return false;
         }  

         if(v14.length==0)
         { 
            alert("Please enter new Driver Name");
            return false;
         }

         if(v13.length==0)
         { 
            alert("Please enter new Driver name");
            return false;
         }

         if(v10=="")  
         {
             alert("Please enter Trip Id");
             return false;   
         }	
      }

	if(etatime1=="Select")
	{
		alert("Please select ETA Time");
		return false;	
	}

	if(v10=="")  
     {
         alert("Please enter Trip Id");
         return false;   
     }	
	return datevalidate(); 
}
catch(e)
{
	alert(e);
	return false;
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
function datevalidate()
{
	var date1=document.getElementById("calender").value;
	var date2=document.getElementById("calender1").value;
	var date3=document.getElementById("etadate").value;
	var timehr1=document.getElementById("rpttime1").value;
	var timemin1=document.getElementById("rpttime2").value;
	var timehr2=document.getElementById("sttime1").value;
	var timemin2=document.getElementById("sttime2").value;
	var timehr3=document.getElementById("etatime1").value;
	var timemin3=document.getElementById("etatime2").value;
	
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22,dd33,mm3,mm33,yy33;


	dd11=date1.substring(0,2);
	dd22=date2.substring(0,2);
	dd33=date3.substring(0,2);
	
	mm1=date1.substring(3,6);
	mm2=date2.substring(3,6);
	mm3=date3.substring(3,6);
	
	
	mm11=dateformat(mm1);
	mm22=dateformat(mm2);
	mm33=dateformat(mm3);
	
	

	yy11=date1.substring(7,11);
	yy22=date2.substring(7,11);
	yy33=date3.substring(7,11);
	
	
	if(yy11<yy22)
	{
		alert("Start date should not be smaller than report date");
		
		return false;
	}
	else if(yy22==yy11)
	{
			if(mm11<mm22)
		{
				alert("Start date should not be smaller than report date");
			
			return false;
		}
			else if(mm11==mm22)
			{
				if(dd11<dd22)
				{
					alert("Start date should not be smaller than report date");
					
					return false;
				}
				else if(dd11==dd22)
				{


					if(timehr2<timehr1)
					{
						alert("Start time should not be smaller than report time");
						return false;
						}	

					else if(timehr2==timehr1)
					{
							if(timemin2<timemin1)
						{
								alert("Start time should not be smaller than report time");
							
							return false;
						}
					}




					}
			}
	}
	
	
	if(yy33<yy11)
	{
		alert("ETA date should not be smaller than Start date");
		
		return false;
	}
	else if(yy33==yy11)
	{
			if(mm33<mm11)
		{
				alert("ETA date should not be smaller than Start date");
			
			return false;
		}
			else if(mm33==mm11)
			{
				if(dd33<dd11)
				{
					alert("ETA date should not be smaller than Start date");
					
					return false;
				}
				else if(dd33==dd11)
				{
					if(timehr3<timehr2)
					{
						alert("ETA time should not be smaller than Start time");
						return false;
						}	
					
					else if(timehr3==timehr2)
					{
							if(timemin3<timemin2)
						{
								alert("ETA time should not be smaller than Start time");
							
							return false;
						}
					}
					}
				
			}
	}
	

	if(yy22==yy11 && mm11==mm22 && dd11==dd22 && timehr2==timehr1 && timemin2==timemin1)
	{
            alert("Start Date and time should not be same as Report Date and time");
		
		return false;
	}
	if(yy33==yy11 && mm33==mm11 && dd33==dd11 && timehr3==timehr2 && timemin3==timemin2)
		
	{
		alert("ETA Date and time should not be same as Start Date and time");
		
		return false;
	}
	
return true;
}


function showothloc(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
   
        if(SelValue1=="Other")
        {
            document.tripform.othstrtloc.style.visibility="visible";
            showothstartloc="Yes";
        }
        else 
       {
            document.tripform.othstrtloc.style.visibility="hidden";
            document.tripform.othstrtloc.value="";
            showothstartloc="No";
       }
}

function showothdest(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value; 
   
        if(SelValue1=="Other")
        {
            document.tripform.othdest.style.visibility="visible";
            showothdestloc="Yes";
        }
        else 
       {
            document.tripform.othdest.style.visibility="hidden";
            document.tripform.othdest.value="";
            showothdestloc="No";
       }
}

function showothvendor(dropdown)
{
  var vv1=dropdown.selectedIndex;
  
  var SelValue1 = dropdown.options[vv1].value; 
 
        if(SelValue1=="Other")
        {
            document.tripform.othvendor.style.visibility="visible";
            showothvendorr="Yes";
        }
        else 
       {
            document.tripform.othvendor.style.visibility="hidden";
            document.tripform.othvendor.value="";
            showothvendorr="No";
       }
}
function showothcontent(dropdown)
{
  var vv1=dropdown.selectedIndex;
  
  var SelValue1 = dropdown.options[vv1].value; 
 
        if(SelValue1=="Other")
        {
            document.tripform.othcontent.style.visibility="visible";
            showothcontentt="Yes";
        }
        else 
       {
            document.tripform.othcontent.style.visibility="hidden";
            document.tripform.othcontent.value="";
            showothcontentt="No";
       }
}
function showothLoadreason(dropdown)
{
  var vv11=dropdown.selectedIndex;
  
  var SelValue11 = dropdown.options[vv11].value; 
 
        if(SelValue11=="Other")
        {
            document.tripform.othLoadreason.style.visibility="visible";
            showothLoadreasonn="Yes";
        }
        else 
       {
            document.tripform.othLoadreason.style.visibility="hidden";
            document.tripform.othLoadreason.value="";
            showothLoadreasonn="No";
       }
}
function showothrdriverid()
{
	//alert("in abc");
	//alert("auto tripgen-->"+tripgen);
    // var vv1=document.getElementById("driverid").value;
    var vv1;
     vv1=document.tripform.driverid.value;
  		//alert("vv1"+vv1);
  //var SelValue1 = dropdown.options[vv1].value;
//  alert("SelValue1"+SelValue1);
        if(vv1=="Other")
        {
        	
           document.tripform.othdriverid.style.visibility="visible";
           document.getElementById("newid").style.visibility="visible";
            
            
            document.tripform.newdrvname.style.visibility="visible";
            document.getElementById("newdrvname").style.visibility="visible";
           
           //document.getElementById("tabid").style.visibility="visible";
            
            
             showothdrivid="Yes"; 
             document.tripform.drivername.readOnly=false;
             //alert(showothdrivid);
        }
        else 
       {
        	document.tripform.othdriverid.style.visibility="hidden";
            document.getElementById("newid").style.visibility="hidden";
             
             
             document.tripform.newdrvname.style.visibility="hidden";
             document.getElementById("newdrvname").style.visibility="hidden";
            
           
            document.tripform.othdriverid.value="";
            document.tripform.newdrvname.value="";
           // document.tripform.drivername.readOnly=true;
            showothdrivid="No";
           
       }
           

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
                        // alert(reslt);
                        document.tripform.drivername.value=reslt;
                         
		     } 
         	  }
             var queryString = "?drivid=" +SelValue1;
	     ajaxRequest.open("GET", "Ajaxgetdriver.jsp" + queryString, true);
	     ajaxRequest.send(null); 
}

function RadChange(ind)
{
  if(ind==0)
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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                                                
                        document.getElementById("mydiv").innerHTML=reslt;
		     } 
         	  }
 	     ajaxRequest.open("GET", "Ajaxgetstrtdtrips.jsp" , true);
	     ajaxRequest.send(null); 

             document.tripform.stloc.disabled="true";
 
             document.tripform.trigger.style.visibility="hidden";
 
             document.tripform.dest.disabled="true"; 

             document.tripform.driverid.disabled="true"; 

             document.tripform.tripid.value="";

             document.tripform.calender1.disabled=false; 
             document.tripform.trigger1.disabled=false; 
             document.tripform.arrivatime1.disabled=false;
             document.tripform.arrivatime2.disabled=false;

             document.tripform.sttime1.disabled=true; 
             document.tripform.sttime2.disabled=true;

	     document.tripform.route[0].disabled=true;
	     document.tripform.route[1].disabled=true;

		document.getElementById("routediv").innerHTML="";
		document.getElementById("routediv1").innerHTML="";

		document.getElementById("mydiv2").innerHTML="";	
		document.getElementById("destdiv1").innerHTML="";		

		                      
 }
   else
   { 
             document.tripform.stloc.disabled=false; 
             document.tripform.trigger.style.visibility="visible";
             document.tripform.othstrtloc.style.visibility="hidden";
             document.tripform.othstrtloc.readOnly=false;
             document.tripform.othstrtloc.value="";

             //document.tripform.calender.readOnly=false;
             document.tripform.calender.value="";

             document.tripform.dest.disabled=false; 
             document.tripform.othdest.value="";
             document.tripform.othdest.style.visibility="hidden"; 
             document.tripform.othdest.readOnly=false; 

             document.tripform.driverid.disabled=false; 
             document.tripform.othdriverid.value="";
             document.tripform.othdriverid.readOnly=false;
             document.tripform.othdriverid.style.visibility="hidden";

             document.tripform.drivername.disabled=false; 
             document.tripform.drivername.value="";

             document.tripform.tripid.disabled=false; 
             var vv=document.tripform.tripid.value;
             document.tripform.tripid.value=vv;
 
             document.tripform.calender1.disabled=true; 
             document.tripform.calender1.value="";
             document.tripform.trigger1.disabled=true; 
             document.tripform.arrivatime1.disabled=true;
             document.tripform.arrivatime2.disabled=true;

             document.tripform.sttime1.disabled=false; 
             document.tripform.sttime2.disabled=false;
             document.tripform.sttime.style.visibility="hidden";
             document.tripform.sttime.value="";

              document.tripform.drivername.readOnly=true;

		document.tripform.route[0].disabled=false;
	     document.tripform.route[1].disabled=false;
		                              
                
       
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
                         //alert(reslt);
                        document.getElementById("mydiv").innerHTML=reslt;
		     } 
         	  }
             //var queryString = "?drivid=" +SelValue1;
	     ajaxRequest.open("GET", "Ajaxgetvehs.jsp" , true);
	     ajaxRequest.send(null); 

   }
}


function showstloc(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
  //alert(SelValue1);

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
                                              
                      //document.getElementById("mydiv1").innerHTML="<input type='text' name='stloc' class='formElement' > ";
                         
                          document.tripform.othstrtloc.style.visibility="visible";
                          document.tripform.othstrtloc.readOnly=true;

 
                          document.tripform.othdest.style.visibility="visible";
                          document.tripform.othdest.readOnly=true;

                          document.tripform.othdriverid.style.visibility="visible";
                          document.tripform.othdriverid.readOnly=true; 

                          document.tripform.sttime.readOnly=true;
                          document.tripform.sttime.style.visibility="visible";

                         
                          
                         var reslt=ajaxRequest.responseText;
                         var mySplitResult = reslt.split("$#");
                        //var mySplitResult1=  mySplitResult[0]; 
                         //var mySplitResult2=  mySplitResult[1];
                         //alert(reslt);
                          document.tripform.othstrtloc.value=mySplitResult[0];
                          document.tripform.calender.value=mySplitResult[1];
                          document.tripform.othdest.value=mySplitResult[2];    
                          document.tripform.othdriverid.value=mySplitResult[3];  
                          document.tripform.drivername.value=mySplitResult[4];  
                          document.tripform.tripid.value=mySplitResult[5];  
                          document.tripform.sttime.value=mySplitResult[6]; 

                          document.tripform.calender.readOnly=true;
                         
                          
                                              
                          
		     } 
         	  }
             var queryString = "?veh=" +SelValue1;
	     ajaxRequest.open("GET", "Ajaxgetstrtinfo.jsp"+queryString , true);
	     ajaxRequest.send(null); 
   
}

function getTripInfo(aa)
{ 
  	if(aa.value=="Yes")
	{ 
		tripgen="Yes";
		//document.tripform.stloc.disabled="true";
		// document.getElementById("mydiv02").style.display="";
		 document.tripform.stloc.style.visibility="hidden";
		 document.tripform.dest.style.visibility="hidden";
		//document.tripform.dest.disabled="true"; 
		document.tripform.tripid.value="";
		document.tripform.driverid.selectedIndex = 0;
		document.tripform.drivername.value ="";
		document.getElementById("mydiv2").style.display="";
		document.getElementById("fixeddiv").style.display="";
		document.getElementById("destdiv1").style.display="";
		document.tripform.othstrtloc.value="";
		document.tripform.othstrtloc.style.visibility="hidden";
		document.tripform.othdest.value="";
		document.tripform.othdest.style.visibility="hidden";
		document.tripform.fxdkm.style.visibility="hidden";
		document.tripform.ftme.style.visibility="hidden";
		//tdp=document.getElementById("fx01");
		document.getElementById("fx01").style.display='none';
		document.getElementById("ft01").style.display='none';
		//document.tripform.eta.value="";
		
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
                           {drivername
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
                        // alert(reslt);
                        document.getElementById("routediv").innerHTML=reslt;
                         
		     } 
         	  }
             
             //alert("hi");
	     ajaxRequest.open("GET", "AjaxGetTripInfo.jsp", true);
	     ajaxRequest.send(null); 
		
	}
	else
	{
		 
		tripgen="No";
		
		//document.tripform.stloc.disabled=false;
		document.tripform.stloc.style.visibility="visible";

		document.tripform.dest.style.visibility="visible";
		//document.tripform.dest.disabled=false; 	
		document.tripform.fxdkm.style.visibility="visible";
		document.tripform.ftme.style.visibility="visible";
		document.getElementById("fx01").style.display='';
		document.getElementById("ft01").style.display='';
		
		document.getElementById("routediv").innerHTML="";

		
		document.tripform.tripid.value="";
		document.getElementById("routediv1").innerHTML="";

		document.tripform.stloc1.value="";
		document.tripform.dest1.value="";


		document.getElementById("mydiv2").style.display='none';
		document.getElementById("fixeddiv").style.display='none';
		document.getElementById("destdiv1").style.display='none';
		

	}
}
function fun2(bb)
{
	if(!(bb.value=="Select"))
	{
		var val1=bb.value;
		strtend=bb.value;
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
                      //  alert(reslt);
                         var res=reslt.split("#");
                       //  alert(res.length);
                         var result="<b>Route Points <BR></b>";
                         for(i=0;i<res.length-2 ;i++)
                         {
                         	result=result+res[i]+"<br>";
                         }
                       document.getElementById("routediv1").innerHTML=result;
                       document.getElementById("mydiv2").innerHTML=" <label for='stfixlox' name='stfixlox' > Start Fixed Location: <font color='maroon' size='2'> <b> "+res[0]+" </b></font> </label> <input type='hidden'  name='stloc1' id='stloc1' value='"+res[0]+"' readonly />";
                       document.getElementById("destdiv1").innerHTML="<label for='stfixlox' name='stfixlox' > <font color='maroon' size='2'> <b> "+res[i-1]+" </b> </font> </label> <input type='hidden' name='dest1' id='dest1' value='"+res[i-3]+"' readonly/>";
                       var resltt=ajaxRequest.responseText;
                      // alert(resltt);
                       var ress=resltt.split("#");
                       for(i=0;i<res.length ;i++)
                       {
                       	result=result+res[i]+"<br>";
                       }
                       
                       document.getElementById("fixeddiv").innerHTML="<label name='fixeddst' > Std Distance: <font color='maroon' size='2'> <b> "+ress[i-1]+" Kms </b></font> </label><br><label name='fixedtme' > Std Time: <font color='maroon' size='2'> <b> "+ress[i-2]+" Hrs </b></font> </label>";
                      // document.tripform.fxdkm.style.value="hidden";
               		   //document.tripform.ftme.style.value="hidden";
                       
             	} 
         	  }
             
             //alert("hi");
             var queryString = "?tripid=" +val1;
	     ajaxRequest.open("GET", "AjaxGetTripInfoDetails.jsp"+queryString, true);
	     ajaxRequest.send(null); 
		
	}
	
	
}

function funETA()
{
	var stdte=document.tripform.calender.value;
	var dy1=stdte.substring(0,2);
	var dy2=stdte.substring(3,6);
	var dy3=stdte.substring(7,11);
	var dd1=dy3.substring(2,4);
	//alert(dd1);

	if(dy2=='Jan')
		dy2=01;
	else
		if(dy2=='Feb')
			dy2=02;
		else
			if(dy2=='Mar')
				dy2=03;
			else
				if(dy2=='Apr')
					dy2=04;
				else
					if(dy2=='May')
						dy2=05;
					else
						if(dy2=='Jun')
							dy2=06;
						else
							if(dy2=='Jul')
								dy2=07;
							else
								if(dy2=='Aug')
									dy2=08;
								else
									if(dy2=='Sep')
										dy2=09;
									else
										if(dy2=='Oct')
											dy2=10;
										else
											if(dy2=='Nov')
												dy2=11;
											else
												if(dy2=='Dec')
													dy2=12;
	//var dd3=dy3.substring(8,10);
	//alert(dd1);
	//alert(dy2);
	//alert(dy1);
    
         
  	
  	//alert(styr);
  	var vehnoo=document.tripform.vehno.value;
  	var rsltt=vehnoo.split(" ");
  	var mar=rsltt[0];
  	var mar1=rsltt[3];
  	//alert(mar);
  //	var len=vehnoo.length;
  	//alert(len)
	var tripid=dd1+""+dy2+""+dy1+""+mar1+""+mar;
	//alert("tripid-->"+tripid)
	//document.tripform.tripid.value=tripid;
	  


	
		var vall1= strtend;
		//alert(vall1);
		if(vall1=="")
		{
		  //alert("First Select Location");
		}
		else
		{
		//	alert("ETA Calculated For Selected Location");
		var strtdte=document.tripform.calender.value;
		var strttmehrs=document.tripform.sttime1.value;
		var strttmemin=document.tripform.sttime2.value;
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
                         var resltt=ajaxRequest.responseText;
                       // alert(resltt);
                         var ress=resltt.split("#");
                         var etadate=ress[1];
                         var etahrs=ress[2];
                         var etamin=ress[3];

						
							
                         document.tripform.etadate.value=etadate;
                         document.tripform.etatime1.value=etahrs;
                         document.tripform.etatime2.value=etamin;
						     
		     } 
         	  }
             
             var queryString = "?Rcode="+strtend+"&strtdte="+strtdte+"&strttmehrs="+strttmehrs+"&strttmemin="+strttmemin;
//alert(queryString);
    	     ajaxRequest.open("GET", "AjaxGetETAcal.jsp"+queryString, true);
	     ajaxRequest.send(null); 
		} 
}



function upload(num)
{
	if(num==1)
	{
	  var name1= document.getElementById("element_43").value;
	  var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  { 
	  document.getElementById("element_43").style.display="none";
	  document.getElementById("f1").innerHTML=name1;
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=name1;
	  document.getElementById("remove1").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("element_43").value="";
			  
	  }
	}
	else
	{

		if(num==2)
		{
		  var name1= document.getElementById("element_44").value;
			 //alert(name1);
		var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  {
		  document.getElementById("element_44").style.display="none";
		  document.getElementById("f2").innerHTML=name1;
		  document.getElementById("f2").style.display="";
		  document.getElementById("f7").value=name1;
		  document.getElementById("remove2").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("element_44").value="";
			  
	  }
		  
		}
	}
		
}

function remove(num)
{
	if(num==1)
	{
		document.getElementById("f1").innerHTML="";
		document.getElementById("f1").style.display="none";
		document.getElementById("remove1").style.display="none";
		document.getElementById("element_43").value="";
		document.getElementById("f6").value="";
		document.getElementById("element_43").style.display="";
	}
	else
	{
		if(num==2)
		{
			document.getElementById("f2").innerHTML="";
			document.getElementById("f2").style.display="none";
			document.getElementById("remove2").style.display="none";
			document.getElementById("element_44").value="";
			document.getElementById("f7").value="";
			document.getElementById("element_44").style.display="";
		}
	}
}

</script>
<style>

#othTripCategory{visibility:hidden}

</style>


<%!
Connection con1;
String strloc,strdate,endp,driverid,drivern,triid;
%>
<body>
<form name="tripform" enctype="multipart/form-data" method="post" action="tripstartentryupdated.jsp">

<% 
try {
	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
Statement stmt1=con1.createStatement(),stpod=con1.createStatement();
ResultSet rs2=null, rs3=null, rs4=null, rs5=null,rs33=null;
String sql2="", sql3="", sql4="", sql5="";
String tripflag="false";
String vehno="", lastdriverid="", lastdrivername="",weight="",vendor="",TripCategory="",goodscontent="",loadrsn="",loadcmnt="",fxd="",fxtm="",frieg="",adv="",joborderno="",revenue="",containerno="";
String lrissue="",lrcontact="",boffice="",pod="",JStatus="",cnno="";

String ReportDate="", ReportTimehrs="",ReportDate1="",ETA1="",ReportTimemin="",strdate="", StartTimehrs="", StartTimemin="",ETA="", ETAhrs="", ETAmin="";
vehno=request.getParameter("vehno");
strloc=request.getParameter("strloc");
endp=request.getParameter("endp");
//strdate=request.getParameter("strdate");
 strdate = request.getParameter("strdate");
 strdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(strdate));
 StartTimehrs = request.getParameter("StartTime");
 StartTimehrs = new SimpleDateFormat("HH").format(new SimpleDateFormat("HH:mm:ss").parse(StartTimehrs));
 StartTimemin = request.getParameter("StartTime");
 StartTimemin = new SimpleDateFormat("mm").format(new SimpleDateFormat("HH:mm:ss").parse(StartTimemin));

//System.out.println("strdate1-->"+strdate);
///System.out.println("StartTimehrs--->"+StartTimehrs);
//System.out.println("StartTimemin--->"+StartTimemin);
 ReportDate1 = request.getParameter("ReportDateTime");

 ReportDate = request.getParameter("ReportDateTime");
 ReportTimehrs = request.getParameter("ReportDateTime");
 ReportTimemin = request.getParameter("ReportDateTime");
//System.out.println("ReportDate--->"+ReportDate);
//System.out.println("ReportTimehrs--->"+ReportTimehrs);
//System.out.println("ReportTimemin-->"+ReportTimemin);
 ETA1 = request.getParameter("ETA");

 ETA = request.getParameter("ETA");
 ETAhrs = request.getParameter("ETA");
 ETAmin = request.getParameter("ETA");
//System.out.println("ETA--->"+ETA);
//System.out.println("ETAhrs--->"+ETAhrs);
//System.out.println("ETAmin-->"+ETAmin);

if(request.getParameter("tripflag")!=null)
{
 tripflag=request.getParameter("tripflag");
} 
System.out.println("\n\n TRIP FLAG from edit--->>>"+tripflag);
  System.out.println("\n\n report date-->> "+ReportDate);
  String nullable="";
  nullable="null";
 
 if(ReportDate==null || ReportDate.equalsIgnoreCase(nullable))
 {
	 System.out.println("\n\n in null of report time ");
	 ReportDate = "-";
	 ReportTimehrs = "-";
	 ReportTimemin = "-";
 }else
 {
	 System.out.println("\n\n in not null of reporrt time");
	 ReportDate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ReportDate));
	 ReportTimehrs = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ReportTimehrs));
	 ReportTimemin = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ReportTimemin));
 }
 
/*
 System.out.println("ReportDate--->"+ReportDate);
 System.out.println("ReportTimehrs--->"+ReportTimehrs);
 System.out.println("ReportTimemin-->"+ReportTimemin);*/
 String nullableeta="";
 nullableeta="null";
 System.out.println("\nETA-->>"+ETA);
 if(ETA==null || ETA.equalsIgnoreCase(nullableeta))
 {
	 System.out.println("\n\n if loop");
	 ETA = "-";
	 ETAhrs = "-";
	 ETAmin = "-";
 }else
 {
	 System.out.println("\n\n else loop");
	 ETA=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETA));
	 ETAhrs = new SimpleDateFormat("HH").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETAhrs));
	 ETAmin = new SimpleDateFormat("mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ETAmin));
 }
 
//String strdate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(strdate));
Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy");
		//String strdate = formatter1.format(strdate1);
		//String rptdte = formatter1.format(ReportDate);

driverid=request.getParameter("driverid");
drivern=request.getParameter("drivern");
triid=request.getParameter("tripid");

String user=session.getValue("usertypevalue").toString();

//java.util.Date d=new java.util.Date();
//int hours=(d.getHours());
//int minutes=(d.getMinutes());

 //java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
  // Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

String duplicatetripid=request.getParameter("duplicatetripid");
  if(duplicatetripid==null)
  {
  }
  else
  { %>
       <table border="0" width="100%" class="stats">
  <tr>
       <td> <div align="center"> <font color="maroon"> <B> This Trip Id is already been allocated. Please enter new one. </B> </font> </div> </td>
  </tr>
</table>
<%
  } 

  String driveriddup=request.getParameter("duplicate");
  
  if(driveriddup==null)
  {
  }
  else
  { %>
       <table border="0" width="100%" class="stats">
  <tr>
       <td> <div align="center"> <font color="maroon">  This Id has already been allocated. Please enter another Id  </font> </div> </td>
  </tr>
</table>
    
<%}
%>


<input type="hidden" name="vehno" value="<%=vehno%>" />
	<%
  	String sql7="select TripCategory,Vendor,lrissuedby,lrcontact,branchoffice,cnnumber,Weight,GoodsContent,Frieght,Advance,Loadreason,Loadcomments,JStatus,joborderno,revenue,containerno from t_startedjourney where TripId='"+triid+"'";
	
  	 rs5=stmt1.executeQuery(sql7);
  	 if(rs5.next())
  	 {
  		weight=rs5.getString("Weight");
  		vendor=rs5.getString("Vendor");
  		TripCategory=rs5.getString("TripCategory");
  		frieg=rs5.getString("Frieght");
  		adv=rs5.getString("Advance");
  		loadrsn=rs5.getString("Loadreason");
  		loadcmnt=rs5.getString("Loadcomments");
  		goodscontent=rs5.getString("GoodsContent");
  		lrissue=rs5.getString("lrissuedby");                       
  		lrcontact=rs5.getString("lrcontact");                  
  		boffice=rs5.getString("branchoffice");                                      
  		cnno=rs5.getString("cnnumber");                                      
  		JStatus=rs5.getString("JStatus"); 
  		joborderno=rs5.getString("joborderno");                                      
  		revenue=rs5.getString("revenue"); 
  		containerno=rs5.getString("containerno");
  		
  		
  	 }

  	
  	%>

		<table border="0" style="height: 400px; width: 1000px" class="stats">
  		      <tr>
			<td> <div align="left">  <a href="javascript:history.go(-1)"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a> </div> </td>
		         <td> <div align="center"> <font size="3"> <b> Edit Trip Information of <%=vehno%> <%=strloc%></b> </font> </div> </td>
		     </tr>
		  
 <tr> <td colspan="2">
	<table border="0" height="100px" style="width: 650px" align="center" class="sortable_entry">
	
  	  <!-- <tr bgcolor="#CCCCCC">
	      <td> 
		   
	      	 <font color="maroon" size="2"> Fixed Route </font> </td>
				<td> <input type="radio" name="route" id="route" value="Yes" onclick="getTripInfo(this);"><font size="2"> Yes</font> &nbsp;&nbsp;&nbsp;
				    <input type="radio" name="route" id="route" value="No" 	checked  onclick="getTripInfo(this);"><font size="2">No</font>
				
				
				</td>
			 </tr> -->
<% sql2="select * from t_warehousedata where Owner='"+user+"'  order by WareHouse asc ";
//out.print(sql2);  
rs2=stmt1.executeQuery(sql2);
%>
			  <tr>
				<td> <font  size="2"><div align="right"><b>&nbsp;&nbsp;&nbsp;&nbsp; Start Location : </b></div></font> </td>
				<td><br></br>
				     <table border="0">
				     	<tr>
				     		<td> 	<div id="routediv"> <!--In this Fixed ROute Codes  -->  </div> 	</td>
				     		<td> 	<div id="routediv1"> <!-- In this Fixed Route desc is given  --> </div> </td>
				     	</tr>
				     		<tr>
				     			<td> <div id="mydiv2"> </div> </td>
				     		</tr>
				     </table>  
				
				
				
          			    <div id="mydiv02">
          			    
          			    	 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 200px" name="stloc" id="stloc" value="<%=strloc%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
          			    
          			      <select name="stloc" id="stloc" class="element select medium" style="width: 200px" onChange="showothloc(this);" > 
          			
          			    <option  value="<%=strloc%>"><%=strloc%></option>

				 <%     while(rs2.next())
        				{ %>
				             <option value="<%=rs2.getString("WareHouse") %>" > <%=rs2.getString("WareHouse") %> </option>
				 <%     }
 %>
				            <option value="Other">Other </option>
				           </select><%} %> </div> &nbsp;&nbsp;&nbsp;
			           <input type="text" class="element text medium" name="othstrtloc"  style="visibility:hidden;width: 150px" /> 
					
				
		</td>	 		
	  </tr>
	  
	    
	  <tr>
      		<td><br></br> <font  size="2"> <div align="right"><b>Report Date Time : </b></div></font> </td>
		<td><br></br>
				    	 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 200px" name="calender1" id="calender1" value="<%=ReportDate1%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
		 <input type="text" id="calender1" name="calender1" class="element text medium" style="width: 125px; height: 16px;" size="13" value="<%=ReportDate%>" readonly  />
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender1"       // ID of the button
             }
                           );
             </script>
    		
    			  

      		  <font >
	            HH : </font> 
	      
	            <select class="element select medium"  style="width: 50px" id="rpttime1" name="rpttime1" >
                   <option value="<%=ReportTimehrs %>"><%=ReportTimehrs %></option>
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
            	 </select>  <font >
        		MM :</font> 
        
        		<select class="element select medium"  style="width: 50px" id="rpttime2" name="rpttime2" >
            		  <option value="<%=ReportTimemin %>"><%=ReportTimemin %></option>
	                  <option value="00">00</option>
        	          <option value="10">10</option>
        	          <option value="20">20</option>
        	          <option value="30">30</option>
        	          <option value="40">40</option> 
        	          <option value="50">50</option>
        	          
        	    </select><%} %> &nbsp;&nbsp;&nbsp;
                 
       		</td>
	  
  	  </tr>
  	  <tr>
      		<td> <br></br><font  size="2"> <div align="right"><b>Start Date Time : </b></div></font> </td>
		<td> 
		
		<br></br>
				       		    	 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 100px" name="calender" id="calender" value="<%=strdate%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
		<input type="text" id="calender" name="calender" class="element text medium" style="width: 125px; height: 16px;" size="13" value="<%=strdate%>" onblur="funETA();" readonly  />
  <%} %>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender"       // ID of the button
             }
                           );
             </script>
    		

			<font >
      		 	   HH : </font>
      		 	   		       		    	 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 50px" name="sttime1" id="sttime1" value="<%=StartTimehrs%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %> 
      		 	   <select class="element select medium"  style="width: 50px" id="sttime1" name="sttime1" >
                   <option value="<%=StartTimehrs %>"><%=StartTimehrs %></option>
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
            	 </select> <%} %> <font >
        		MM :</font>
        		 	   		       		    	 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 50px" name="sttime2" id="sttime2" value="<%=StartTimemin%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %> 
        		<select class="element select medium"  style="width: 50px" id="sttime2" name="sttime2" >
           				<option value="<%=StartTimemin %>"><%=StartTimemin %></option>
	                  	<option value="00">00</option>
        	          	<option value="10">10</option>
        	          	<option value="20">20</option>
        	          	<option value="30">30</option>
        	         	<option value="40">40</option> 
        	         	<option value="50">50</option>
        	           
        	    </select><%} %> &nbsp;&nbsp;&nbsp;
                 
       		</td>
	  </tr>
  
  	<% String sql33="select Distinct(Loadreason) from t_startedjourney where OwnerName='"+user+"' order By Vendor Asc";
     // out.print(sql3); 
     rs33=stmt1.executeQuery(sql33);
%>
  	 <tr>
    		  <td> <br></br><font  size="2"> <div align="right"><b>Load Delay Reason : </b></div></font> </td>
     		 <td><br></br> <div id="Loadreasondiv"> 
     		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" name="Loadreason" id="Loadreason" value="<%=loadrsn%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  
		    	  %>
		    	  <select name="Loadreason" class="element select medium"  style="width: 175px" id="Loadreason" onChange="showothLoadreason(this);" > 
     		  <option value="<%=loadrsn%>"><%=loadrsn%></option>
		 <%  while(rs33.next())  
       		 { %>
           		  <option value="<%=rs33.getString("Loadreason") %>" > <%=rs33.getString("Loadreason") %> </option>
   	     <%  }
     	     %>     
             		<option value="Other">Other </option>
	           </select> 
		    	  <%
		    	  
		    	  
		      }
     			     			%>
		      
     		  &nbsp;&nbsp;&nbsp;
        <input type="text" class="element text medium"  name="othLoadreason" id="othLoadreason" style="visibility:hidden;width: 150px"/>
        	     </div>
			<div id="Loadreasondiv1">
	          	</div>
		</td>
		</tr>
        <tr>
      		<td><br></br> <font  size="2"> <div align="right"><b>Comment : </b></div></font> </td>
	        <td><br></br>
	           <%
		      if(JStatus.equals("Completed"))
		      {
		      %>
	        
	         <textarea name="loadcmnt" class="element text medium" rows="4" cols="35" readonly="readonly"><%=loadcmnt %></textarea> 
	         <%
		      }else{
		    	  %>
		     <textarea name="loadcmnt" class="element text medium" rows="4" cols="35" ><%=loadcmnt %></textarea> 
		    	  
		    	  <%
		      }
	         %>
	         
	         &nbsp;
	        </td>
	        </tr>  
  	  
<%   sql3="select * from t_warehousedata where Owner='"+user+"' order by WareHouse asc ";
     // out.print(sql3); 
     rs3=stmt1.executeQuery(sql3);
%>
  	 <tr>
    		  <td><br></br> <font  size="2"><div align="right"><b>Destination : </b></div></font> </td>
     		 <td><br></br> <div id="destdiv"> 
     			 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" name="dest" id="dest" value="<%=endp%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  
		    	  %> 
     		 
     		 
     		 <select name="dest" class="element select medium"  style="width: 200px" id="dest" onChange="showothdest(this);" >
     	
              <option value="<%=endp %>"><%=endp %></option>
		 <%  while(rs3.next())  
       		 { %>
           		  <option value="<%=rs3.getString("WareHouse") %>" > <%=rs3.getString("WareHouse") %> </option>
   	     <%  }
     	     %>     
             		<option value="Other">Other </option>
	           </select>
	           
	           <%
		      }
	           %>
	             &nbsp;&nbsp;&nbsp;
        	     <input type="text" class="element text medium" name="othdest"  style="visibility:hidden;width: 150px"/>
        	     </div>
			<div id="destdiv1">
	          	</div>
		</td>
	  </tr>
	<%   
	String sql17="select FIxedKm,FIxedTime from t_startedjourney where TripId='"+triid+"'";
  	ResultSet rs15=stmt1.executeQuery(sql17);	
  	 if(rs15.next())
  	 {
  		fxd =rs15.getString("FIxedKM");
  		fxtm =rs15.getString("FIxedTime");
  	
  	}
  	 %>
	  <tr id="fx01">
      		<td><br></br> <font  size="2"> <div align="right"><b>Fixed KM : </b></div></font> </td>
	        <td><br></br> 
	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 75px" name="fxdkm" id="fxdkm" value="<%=fxd%>" readonly="readonly"/><font  size="2">Kms.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     			
     			<%
		      }else{
		    	  
		    	  %> 
	        
	        
	        <input type="text" class="element text medium" style="width: 75px" name="fxdkm"  size="7" value="<%=fxd %>" id="fxdkm"  /><font  size="2">Kms.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <%} %>
	        <font  size="2">Fixed Time :</font> 
	        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 75px" name="ftme" id="ftme" value="<%=fxtm%>" readonly="readonly"/><font  size="2">Hrs </font>&nbsp;
     			
     			<%
		      }else{
		    	  %>
		      
	        <input type="text" name="ftme" class="element text medium" style="width: 75px" size="7" value="<%=fxtm %>"  id="ftme"  /><font  size="2">Hrs </font>&nbsp;
	        <%} %>
	        </td>
	     </tr>
	     <%  String sql34="select Distinct(TripCategory) from t_startedjourney where OwnerName='"+user+"' order By TripCategory Desc";
     // out.print(sql3); 
     ResultSet rs34=stmt1.executeQuery(sql34);
%>
  	 <tr>
    		  <td> <font  size="2"> <div align="right"><b>Trip Category : </b></div></font> </td>
     		 <td><br></br> <div id="categorydiv">
     		 
     		 	        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 80px" name="TripCategory" id="TripCategory" value="<%=TripCategory%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
     		 
     		 
     		  <select name="TripCategory" class="element select medium"  style="width: 100px" id="TripCategory" onChange='showothcategry(this.value)' > 
     		  <option value="<%=TripCategory%>"><%=TripCategory%></option>
	 	 <%  while(rs34.next())  
       		 { %>
           		  <option value="<%=rs34.getString("TripCategory") %>" > <%=rs34.getString("TripCategory") %> </option>
   	    
   	   
   	     <%  }
     	     %>    
             	 <option value="Other">Other </option>	
	           </select>
	           <%} %>
	           
	             &nbsp;&nbsp;&nbsp;
        	   <input type="text" class="element text medium" name="othTripCategory" id="othTripCategory" style="visibility:hidden;width: 150px"/>
        	     </div>
			<div id="categorydiv1">
	          	</div>
		</td>
		</tr>
		<tr>
      		<td><font  size="2"><div align="right"><b> Weight Load :</b></div></font> </td>
	         <td><br></br>
	         	        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 75px" name="weight" id="weight" value="<%=weight%>" readonly="readonly"/><font  size="2">KG</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     			
     			<%
		      }else{
		    	  %>
	         
	         
	          <input type="text" class="element text medium" style="width: 75px" name="weight" size="7"  value="<%=weight%>" id="weight" /><font  size="2">KG</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                <%} %>
				<font  size="2">Freight :</font> 
				
				
	         	        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 75px" name="frie" id="frie" value="<%=frieg%>" readonly="readonly"/><font  size="2">Rs.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     			
     			<%
		      }else{
		    	  %>
	           <input type="text" class="element text medium" style="width: 75px" name="frie" size="7"  value="<%=frieg%>" id="frie" /><font  size="2">Rs.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<%} %>
      		<font  size="2"> Advance : </font>
      			        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 75px" name="adv" id="adv" value="<%=adv%>" readonly="readonly"/><font  size="2">Rs.</font> &nbsp;&nbsp;&nbsp;&nbsp;
     			
     			<%
		      }else{
		    	  %> 
	        <input type="text" class="element text medium" style="width: 75px" name="adv" style="width: 50px"   size="7" value="<%=adv%>" id="adv" /><font  size="2">Rs.</font> &nbsp;&nbsp;&nbsp;&nbsp;
	        <%} %>
	        </td>
	        </tr>
	        
	        <tr>
				
					<td><br></br><div align="right"><font size="2"> <b>Branch Office Code :</b></font></div></td>
					<td><br></br>
							        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 100px" name="bcode" id="bcode" value="<%=boffice%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %> 
					<input type="text" class="element text medium" style="width: 100px" name="bcode" size="7" value="<%=boffice %>" id="bcode" />
					<%} %>
					</td>
				</tr>
					<tr>
				
					<td><br></br><div align="right"><font size="2"> <b>LR Issued By :</b></font></div></td>
					<td><br></br>
										        	        		 <%
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 150px" name="lrissue" id="lrissue" value="<%=lrissue%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
					<input type="text" class="element text medium" style="width: 150px" name="lrissue" size="7" value="<%=lrissue %>" />
					<%} %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<font size="2">LR Contact : </font> 
				 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 150px" name="lrcontact" id="lrcontact" value="<%=lrcontact%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
					<input type="text" class="element text medium" style="width: 150px" name="lrcontact" size="7" value="<%=lrcontact %>" id="lrcontact" />
				<%} %>
				</td>
				</tr>
	        
	        
	        
	    <% String sql45="select Distinct(GoodsContent) from t_startedjourney where OwnerName='"+user+"' order By GoodsContent Asc";
     // out.print(sql3); 
      ResultSet rs45=stmt1.executeQuery(sql45);
%>
  	 <tr>
    		  <td> <br></br><font  size="2"><div align="right"><b> Product Name :</b></div> </font> </td>
     		 <td><br></br><div id="contentdiv">
     		 
     		 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 150px" name="content" id="content" value="<%=goodscontent%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
     		 
     		 
     		  <select class="element select medium" style="width: 175px" name="content" id="content" onChange="showothcontent(this);" > 
     		 <option value="<%=goodscontent%>"><%=goodscontent%></option>

		 <%  while(rs45.next())  
       		 { %>
           		  <option value="<%=rs45.getString("GoodsContent") %>" > <%=rs45.getString("GoodsContent") %> </option>
   	     <%  }
     	     %>     
             		<option value="Other">Other </option>
	           </select> 
	           <%} %>
	           
	            &nbsp;&nbsp;&nbsp;
        	     <input class="element text medium" type="text" name="othcontent" id="thcontent" style="visibility:hidden;width: 150px"/>
        	     </div>
			<div id="contentdiv1">
	          	</div>
		</td>
		</tr>    
	        
	        
	        
	        
	
	        <!-- /********************************************-->
<%  sql33="select Distinct(Vendor) from t_startedjourney where OwnerName='"+user+"' order By Vendor Asc";
     // out.print(sql3); 
     rs33=stmt1.executeQuery(sql33);
%>
  	 <tr>
    		  <td><br></br> <font  size="2"><div align="right"><b>Customer :</b></div> </font> </td>
     		 <td><br></br> <div id="vendordiv">
     		 <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 150px" name="vendor" id="vendor" value="<%=vendor%>" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
     		  <select class="element select medium" style="width: 150px" name="vendor" id="vendor" onChange="showothvendor(this);" > 
     		 <option value="<%=vendor%>"><%=vendor%></option>

		 <%  while(rs33.next())  
       		 { %>
           		  <option value="<%=rs33.getString("Vendor") %>" > <%=rs33.getString("Vendor") %> </option>
   	     <%  }
     	     %>     
             		<option value="Other">Other </option>
	           </select><%} %>  &nbsp;&nbsp;&nbsp;
        	    <input class="element text medium" type="text" name="othvendor" id="thevendor" style="visibility:hidden;width: 150px"/>
        	     </div>
			<div id="vendordiv1">
	          	</div>
		</td>
		</tr>
		
		
	<%
 
  sql4="select * from t_drivers where Owner='"+user+"' order by DriverName asc ";
   rs4=stmt1.executeQuery(sql4);
%> 
	   <tr>
	      <td><font  size="2"><div align="right"><b> Driver Name(Id) :</b></div></font> </td>
	      <td> <br></br>
	       <%									        	        		
     		if(JStatus.equals("Completed"))
		      {     		
     			
     			%>
      <input type="text" style="width: 200px" name="driverid" id="driverid" value="<%=driverid %>(<%=drivern %>)" readonly="readonly"/>
     			
     			<%
		      }else{
		    	  %>
	      
	      <select class="element select medium" style="width: 200px" name="driverid" onChange="showothrdriverid();" > 
	       <option value="<%=driverid%>"><%=drivern %>(<%=driverid %>)</option>
		  <%  while(rs4.next())
	             { %>
		          <option value="<%=rs4.getString("DriverID") %>"><%=rs4.getString("DriverName") +"( "+rs4.getString("DriverID")+" )" %> </option>
		  <%  }
		  %>
			  	<option value="Other">Other</option>
					</select>
					<%} %> &nbsp;&nbsp;&nbsp;
					<table border="0" id="tabid">
						<tr>
							<td><label name="newid" id="newid"
								style="visibility: hidden"><b> Driv. Id :</b></label> 
								<input type="text" class="element text medium" name="othdriverid" style="visibility: hidden;width: 100px" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label name="newdrvname"
								id="newdrvname" style="visibility: hidden"><b> Driv. Name :</b></label> <input
								class="element text medium" type="text" name="newdrvname" style="visibility: hidden;width: 175px" /></td>
						</tr>
					</table>
					</td>
				</tr>
				<input class="element text medium" style="width: 75px" type="hidden" name="drivername" value="<%=drivern%>"
					readonly />
					
  	<tr> 
  		<td> <br></br><font  size="2"> <div align="right"><b>ETA : </b></div></font> </td>
  		<td><br></br><font  size="2">Date :</font>
  		       		
     			  <%
		      if(JStatus.equals("Completed"))
		      {
		      %>
	        	 <input type="text" class="" style="width: 75px" style="width: 100px" name="etadate" id="etadate" value="<%=ETA1 %>" readonly="readonly"/>
	        <%
		      }else{
		    	  %>
     			
  		 <input type="text" class="element text medium" style="width: 100px" id="etadate" name="etadate" size="13" value="<%=ETA%>" readonly  />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 			<!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
<!--              <input type="button" name="etatrigger" id="etatrigger" value="Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "etadate",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "etadate"       // ID of the button
             }
                           );
             </script> &nbsp;
             <font >
	            HH : </font> 
	      
	            <select class="element select medium" style="width: 50px" id="etatime1" name="etatime1" >
                   <option value="<%=ETAhrs %>"><%=ETAhrs %></option>
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
            	 </select>  <font >
        		MM :</font>
        
        		 <select  class="element select medium" style="width: 50px" id="etatime2" name="etatime2" >
            
	                  <option value="<%=ETAmin %>"><%=ETAmin %></option>
	                  	<option value="00">00</option>
        	          	<option value="10">10</option>
        	          	<option value="20">20</option>
        	          	<option value="30">30</option>
        	         	<option value="40">40</option> 
        	         	<option value="50">50</option>
        	          
        	    </select>
            <!-- <input type="text" name="eta"  /> </td> -->
            <%} %>
  	</tr>
	<tr>
      		<td> <br></br><font  size="2"> <div align="right"><b>Trip Id :</b></div> </font> </td>
	        <td><br></br> <input type="text" class="" style="width: 150px" name="tripid" id="tripid"  value="<%=triid %>" readonly="readonly"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <font size="2"> CN :</font>
	        <%
		      if(JStatus.equals("Completed"))
		      {
		      %>
	        	 <input type="text" class="" style="width: 75px" style="width: 100px" name="cnnumber" id="cnnumber" value="<%=cnno %>" readonly="readonly"/>
	        <%
		      }else{
		    	  %>
		    	  <input type="text" class="" style="width: 75px" style="width: 100px" name="cnnumber" id="cnnumber" value="<%=cnno %>"/>
		    	  
		    	  <%
		      }
	        
	        %>
	        <%
	        try{
	        String sqlpod="select * from db_gps.t_completedjourney where TripId='"+triid+"'";
	        ResultSet rspod=stpod.executeQuery(sqlpod);
	        if(rspod.next())
	        {
	      		pod=rspod.getString("pod");                                      

	        }
	        }catch(Exception e)
	        {
	        	e.printStackTrace();
	        }
	        
	        %>
	        
	        
								
	<%
		      if(JStatus.equals("Completed"))
		      {
		      %>
		      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2"> POD :</font>
		      
		      <input type="text" class="" style="width: 75px" style="width: 100px" name="podnumber" id="podnumber" value="<%=pod%>" />
		      </td>
		      <%} %>
		      
  	</tr>
  	<tr><td><br><br></td></tr>
  	<tr>
  	     			<td><font size="2"> <div align="right"><font color="red"> </font><b>Job Order No:</b> </div></font>
					</td>
					<td>			
					<input type="text" class="element text medium" style="width: 200px" name="joborderno" size="7" value="<%=joborderno%>" id="joborderno"  />
					
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<font size="2">Revenue : </font> 
					<input type="text"  class="element text medium" style="width: 150px" name="revenue" size="7" value="<%=revenue%>" id="revenue" />
				
				</td>
				<br><br>
				</tr>
			   <tr><td><br>  </td></tr>  
				
				<tr>
				<br><br>
			<td><font size="2"> <div align="right"><font color="red"> </font><b> Container No:</b> </div></font>
			</td>
			<td>				
			<input type="text" class="element text medium" style="width: 200px" name="containerno" size="7" value="<%=containerno%>" id="containerno"  />
			<!-- <input type="text" class="element text medium" style="width: 200px" name="containerno" size="7" value="" id="containerno" onblur="newcontainer()" /> -->
			<!-- <label name="newcontainerno" id="newcontainerno" style="display: none;"><font color="red">Please Enter Container No</font></label> -->		
				</tr>
  	
  	
  	
		      <%
		      if(JStatus.equals("Completed"))
		      {
		      %>
	        <tr>
  	
  	<td><br></br>
  	<font  size="2"><div align="right"><b>POD File Upload :</b></div> </font> </td>
  	<td><br></br>
  <input type="file" cols="20" name="element_44" id="element_44" value="" onchange="upload(2);"  style="display: "/>
		<font size="2" face="Arial" color="black" id="f2" style="display:none;" name = "f2"></font>
		&nbsp;&nbsp;<a href="#" onclick="remove(2);" id="remove2" style="display: none;"><font size="2" face="Arial">Remove</font></a>
		<input id="f7" name=f7 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
  	</td>
	        
  	</tr>
  	<%
       } else{
    	   
    	   %>
    	   
    	   <tr>
  	<td><br></br> <font  size="2"><div align="right"> <b>CN File Upload :</b></div> </font> </td>
	    <td><br></br>
<input type="file" cols="20" name="element_43" id="element_43" value="" onchange="upload(1);" style="background-image: newimages/browse.jpg"/>
		<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
&nbsp;&nbsp;<a href="#" onclick="remove(1);" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		      </td>
		      </tr>
    	   <%
       }
    %>
  	
  	
  	
<!--*************-->

	        <tr>
      		<td colspan="2" ailgn="center"><br></br> <div align="center"> <input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" onClick="return validate();"  class="formElement"/> </div> </td>
  	</tr><tr><td>
	<input type="hidden" id="tripflag" name="tripflag" value="<%=tripflag%>"></input>
      </td></tr></table>
  
</td></tr></table>
<% } catch(Exception e) {
	out.println("Exception----->" +e); 
}
finally
{
	try
	{
		con1.close();
	}catch(Exception e)
	{}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
}
%>


	<% //fleetview.closeConnection(); %>
			</jsp:useBean>
<br><br>
 <table border="0" width="100%" align="center" style="padding-bottom: 56px" > 
 <tr><td  bgcolor="#0B2161" > 
<ui><li><center><font color="white" > 
<p>Copyright &copy; 2008-2015 by Transworld Technologies Ltd. All Rights Reserved.</p> </font></center></li></ui> 

 </td></tr>
</table>
</body>

</html>
			
			
			
<%-- <%@ include file="footernew.jsp" %> --%>


