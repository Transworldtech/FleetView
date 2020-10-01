
<%@ include file="headernew.jsp"%>
  	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	
//	String buffer=request.getParameter("buffer");
//	System.out.println("buffer--------------------->"  +buffer);
	%>
	<script language="javascript">
var showothstartloc="No";
var showothdestloc="No";
var showothdrivid="No";
var tripgen="No";
var showothvendorr="No";
var showothLoadreasonn="No";
var othTripCategoryy="No";
var othGoodsContentt="No";
var strtend="";

function newcontainer(){
	//alert("in job order");
	var newempid123=document.tripform.containerno.value;
	
	document.getElementById("newcontainerno").style.display="none";
	if(newempid123==null || newempid123=="" || newempid123.length==0){
		//document.getElementById("abc").style.display="none";
	   document.getElementById("newcontainerno").style.display="";
	}
}

function cancelbutton()

{
	//alert("in cancel 1");

                document.getElementById("mytable").style.visibility="hidden";
      //          alert("in cancel 2");
                document.tripform.action ="currentposition.jsp";
        //        alert("in cancel 3");
    document.forms["tripform"].submit();
    //alert("in cancel 4");
}


function validate()
{
	try{
	var v6=document.tripform.calender.value;
        var v7=document.tripform.sttime1.value;
       // var v77=document.tripform.sttime2.value;
      //alert("jhgsd--->"+document.tripform.dest1.value);  
        var v8=document.tripform.dest.value;
        var v9=document.tripform.driverid.value;
	var v10=document.tripform.tripid.value; 
	var v19=document.tripform.joborderno.value;
	/* var v20=document.tripform.containerno.value;
	v20=v20.trim();
	 *///alert("v20"+v20);
	var etadate=document.tripform.etadate.value;
    var etatime1=document.tripform.etatime1.value;
    var numericExpressionn = /^[.0-9]+$/;
    
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
	{
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

  		/*if(stloc==dest)
  		{
  			alert("Start Location and Destination cannot be same");
	         return false;
  		}*/		
	}
	 

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
	    if(showothstartloc=="Yes")
      { 
         var v10=document.tripform.othstrtloc.value;
         
         if(v10.length==0)
         { 
            alert("Please enter new start location");
            return false;
         } 
 
         
      }

      if(showothdestloc=="Yes")
      { 
          var v11=document.tripform.othdest.value;
          
         if(v11.length==0)
         { 
            alert("Please enter new destination");
            return false;
         }
      }
      if(showothvendorr=="Yes")
      { 
          var v111=document.tripform.othvendor.value;
          
         if(v111.length==0)
         { 
            alert("Please enter new destination");
            return false;
         }
      }
      if(othTripCategoryy=="Yes")
      { 
          var vt111=document.tripform.othTripCategory.value;
          
         if(vt111.length==0)
         { 
            alert("Please enter new Category");
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
 	 var revenue=document.tripform.revenue.value;
 	/* var joborderno=document.tripform.joborderno.value; */

 	  var letter = /^[A-Za-z]+$/;  
 	       if(!(lrissue.match(letter)) && lrissue.length!=0)  
 	       {  
 	          alert('Please enter characters value for LR Issue');  
 	       return false;  
 	       }  


      if(document.tripform.route[0].checked==true)
  		{
    	  	
  		}
      	else
      	{
      
     // alert("for non fixed route");
     
 	/*if(fkms.length==0)
	{
		alert("Please enter Fixed Km");
        return false;
	}*/
	/*  if(!(fkms.match(numericExpressionn))&& fkms.length!=0)
 	{
 		alert("Please enter Numeric value for Fixed Km");
        return false;
 	 } */
	/*if(ftime.length==0)
	{
		alert("Please enter Fixed Time");
        return false;
	}*/
	/*  if(!(ftime.match(numericExpressionn))&& ftime.length!=0)
 	{
 		alert("Please enter Numeric value for Fixed Time");
        return false;
 	} */

 }


    /* if(weit.length==0)
  	{
  		alert("Please enter Weight");
          return false;
  	}*/
   	 if(!(weit.match(numericExpressionn))&& weit.length!=0)
   	{
   		alert("Please enter Numeric value for Weight");
          return false;
   	}
  	if(!(revenue.match(numericExpressionn))&& revenue.length!=0)
   	{
   		alert("Please enter Numeric value for Revenue");
          return false;
   	}
  	/* if(!(joborderno.match(numericExpressionn))&& joborderno.length!=0)
   	{
   		alert("Please enter Numeric value for Job Order No");
          return false;
   	} */
	/* if(adva.length==0)
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
 		alert("Please enter Numeric value for Freight");
        return false;
 	 }
	
     //if(showothTripCategory=="Yes")
      //{ 
          var v1111=document.tripform.othTripCategory.value;
          
      /*   if(v1111.length==0)
         { 
            alert("Please enter other Category");
            return false;
         }
*/    //}
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

	/* if(v19=="")  
    {
        alert("Please Job order No");
        return false;   
    } */
	/* if(v20=="" || v20.length==0)  
    {
        alert("Please enter Container No");
        return false;   
    } */
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
	
	if(yy33==yy11 && mm33==mm11 && dd33==dd11 && timehr3==timehr2 && timemin3==timemin2)
	
	{
		alert("ETA Date and time should not be same as Start Date and time");
		
		return false;
	}



	if(yy22==yy11 && mm11==mm22 && dd11==dd22 && timehr2==timehr1 && timemin2==timemin1)
	{
            alert("Start Date and time should not be same as Report Date and time");
		
		return false;
	}

return true;
}

function showothloc(dropdown)
{
	//alert("hii")
  var vv1=dropdown.selectedIndex;
    //  alert(vv1);
  var SelValue1 = dropdown.options[vv1].value;
 // alert(SelValue1);
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
 // alert(vv1); 
  var SelValue1 = dropdown.options[vv1].value; 
 // alert(SelValue1);
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

        var a = document.tripform.stloc.value;
        var b=document.tripform.dest.value;
        if((a!="Other") && (b!="Other"))
        		{
              getvalues(a,b);
              
        		}
        
}
function getvalues(p,q)
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
                         
                         //alert(reslt);
		                    var resnew=reslt.split("#");

		                    
		                    //document.getElementById("side_bar").innerHTML=resnew[4];
		                    var km=resnew[1];
		                    var time=resnew[2];
		                   
		                    
		                  document.tripform.fxdkm.value=km;
		                  document.tripform.ftme.value=time;
                        //document.tripform.drivername.value=reslt;
                        
                         
		            } 
         	  }
         	
         	  
             var queryString = "?StartPlace="+p+"&EndPlace="+q;

              
            
	     ajaxRequest.open("GET", "AjaxGetkmtime.jsp" + queryString, true);
	     ajaxRequest.send(null);


	

	
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
function showothcategry(dropdown)
{
  var vvt1=dropdown.selectedIndex;
  
  var SelValuet1 = dropdown.options[vvt1].value; 
 
        if(SelValuet1=="Other")//TripCategory
        {//othTripCategory
        	
            document.tripform.othTripCategory.style.visibility="visible";
            othTripCategoryy="Yes";
        }
        else 
       {
        	
            document.tripform.othTripCategory.style.visibility="hidden";
            document.tripform.othTripCategory.value="";
            othTripCategoryy="No";
       }
}

function showothcontent(dropdown)
{
  var vvt1=dropdown.selectedIndex;
  
  var SelValuet1 = dropdown.options[vvt1].value; 
 
        if(SelValuet1=="Other")//TripCategory
        {//othTripCategory
            document.tripform.othGoodsContent.style.visibility="visible";
            othGoodsContentt="Yes";
        }
        else 
       {
            document.tripform.othGoodsContent.style.visibility="hidden";
            document.tripform.othGoodsContent.value="";
            othGoodsContentt="No";
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
function showothrdriverid(dropdown)
{
	
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
   
        if(SelValue1=="Other")
        {
           document.tripform.othdriverid.style.visibility="visible";
           document.getElementById("newid").style.visibility="visible";
            
            
            document.tripform.newdrvname.style.visibility="visible";
            document.getElementById("newdrvname").style.visibility="visible";
           
           //document.getElementById("tabid").style.visibility="visible";
            
            
            showothdrivid="Yes"; 
             document.tripform.drivername.readOnly=false;
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
		//alert("In tripgen yes");
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
		document.tripform.fxdkm.style.visibility="visible";
		document.tripform.ftme.style.visibility="visible";
		//document.tripform.fxdkm.style.visibility="hidden";
		//document.tripform.ftme.style.visibility="hidden";
		document.tripform.fxdkm.style.d="";
		document.tripform.ftme.style.visibility="";
		//tdp=document.getElementById("fx01");
		document.getElementById("fx01").style.display="";
		//document.getElementById("ft01").style.display='none';
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
                       //  alert(reslt);
                        document.getElementById("routediv").innerHTML=reslt;
                         
		     } 
         	  }
             
             //alert("hi");
	     ajaxRequest.open("GET", "AjaxGetTripInfo.jsp", true);
	     ajaxRequest.send(null); 
	    // alert("out tripgen yes");
	}
	else
	{
		//alert("In tripgen No");
		tripgen="No";
		
		//document.tripform.stloc.disabled=false;
		document.tripform.stloc.style.visibility="visible";
		
		document.tripform.dest.style.visibility="visible";
		//document.tripform.dest.disabled=false; 	
		document.tripform.fxdkm.style.visibility="visible";
		document.tripform.ftme.style.visibility="visible";
		document.getElementById("fx01").style.display='';
		//document.getElementById("ft01").style.display='';
		
		document.getElementById("routediv").innerHTML="";

		
		document.tripform.tripid.value="";
		
		document.getElementById("routediv1").innerHTML="";
		document.getElementById("mydiv2").innerHTML="";
		document.getElementById("destdiv1").innerHTML="";
		//document.tripform.stloc1.value="";
		//alert("out tripgen No");
		//document.tripform.dest1.value="";
			
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
		//alert(val1);
	//var val2=val1.subString(0,indexof("\)")+1);
		//alert(val2);
		
		var v2=val1.split("/");
		//alert(v2[0]);
	  //  alert(v2[1]);
	  //  alert(v2[2]);
	   var v3=v2[2].split("-");
	  // alert(v3);
	  // alert(v3[0]);
	 //  alert(v3[1]);
	 //  alert(v3);
	   
		strtend=bb.value;
		//alert(strtend);
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
                         var res=reslt.split("#");
                       //  alert("result after split"+res);
                       //  alert("result length"+res.length);
                         
                         var result="<b>Route Points <BR></b>";
                         for(i=0;i<res.length-2 ;i++)
                         {
                         	result=result+res[i]+"<br>";
                         }
                   
                        
						//alert("---"+res[i-1])
						// alert(v3[0]);
						  document.getElementById("castrolroutecode").value=v3[0];
						//  alert(document.getElementById("castrolroutecode").value);
						//  alert(v3[1]);
						  document.getElementById("castrolroutecode1").value=v3[1];
						//  alert(document.getElementById("castrolroutecode1").value);
                      //  document.getElementById("routediv1").innerHTML=result;
                     //   document.getElementById("mydiv3").innerHTML=" <label for='stfixlox' name='stfixlox' ><font color='maroon' size='2'> <b></b></font> </label> <input type='hidden'  name='stlocnew' id='stlocnew' value='"+v3[0]+"' />";
                       // document.getElementById("mydiv4").innerHTML=" <label for='stfixlox' name='stfixlox' ><font color='maroon' size='2'> <b></b></font> </label> <input type='hidden'  name='stlocnew1' id='stlocnew1' value='"+v3[1]+"' />";
                       document.getElementById("mydiv2").innerHTML=" <label for='stfixlox' name='stfixlox' > Start Fixed Location: <font color='maroon' size='2'> <b> "+v2[0]+" </b></font> </label> <input type='hidden'  name='stloc1' id='stloc1' value='"+v2[0]+"' readonly />";
                       document.getElementById("destdiv1").innerHTML="<label for='stfixlox' name='stfixlox' > <font color='maroon' size='2'> <b> "+v2[1]+" </b> </font> </label> <input type='hidden' name='dest1' id='dest1' value='"+v2[1]+"' readonly/>";
                       var resltt=ajaxRequest.responseText;
                      // alert(resltt);
                       var ress=resltt.split("#");
                       for(i=0;i<res.length ;i++)
                       {
                       	result=result+res[i]+"<br>";
                       }
                       
                       document.getElementById("fixeddiv").innerHTML="<label name='fixeddst' id='fixeddst'> <font color='maroon' size='2'> <b></b></font> </label><br><label name='fixedtme' id='fixedtme'><font color='maroon' size='2'> <b></b></font> </label><input type='hidden' name='fixeddst1' id='fixeddst1' value='"+ress[i-1]+"' readonly/><input type='hidden' name='fixedtme1' id='fixedtme1' value='"+ress[i-2]+"' readonly/>";
                      // document.tripform.fxdkm.style.value="hidden";
               		   //document.tripform.ftme.style.value="hidden";
                       document.tripform.fxdkm.value=ress[i-1];
		                  document.tripform.ftme.value=ress[i-2];
                       
             	} 
         	  }
             
             //alert("hi");
             var queryString = "?tripid="+v2[0]+"&tripid1="+v2[1]+"";
	     ajaxRequest.open("GET", "AjaxGetTripInfoDetails.jsp"+queryString, true);
	     ajaxRequest.send(null); 
		
	}
	
	
}

function funETA()
{
	try
	{
  // alert(">><<<");
	var stdte=document.tripform.calender.value;
	var dy1=stdte.substring(0,2);
	var dy2=stdte.substring(3,6);
	var dy3=stdte.substring(7,11);
	var dd1=dy3.substring(2,4);
	//alert(dd1);

	if(dy2=='Jan')
		dy2="0"+01;
	else
		if(dy2=='Feb')
			dy2="0"+02;
		else
			if(dy2=='Mar')
				dy2="0"+03;
			else
				if(dy2=='Apr')
					dy2="0"+04;
				else
					if(dy2=='May')
						dy2="0"+05;
					else
						if(dy2=='Jun')
							dy2="0"+06;
						else
							if(dy2=='Jul')
								dy2="0"+07;
							else
								if(dy2=='Aug')
									dy2="0"+08;
								else
									if(dy2=='Sep')
										dy2="0"+09;
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
  	var x,y;
  	     
  	  	     
  	     
  	   var vehno=document.tripform.vehno.value;
  	   var vehno1=vehno.replace(/ /g,"").replace(/_/g,"");
    // alert(">>>>"+vehno1);
  	  	var lt=vehno1.length;
  	  //alert(">>>>"+lt);
  	if(lt==10)
    {
  		//alert(">>>>");
  		if(isNaN(vehno1[0]))
  		{
        x=vehno1.substr(0,2);
        y=vehno1.substr(6,4);		
  		}
  		else{
  			//alert(">>"+x+"<<y"+y);
  		   x=vehno1.substr(8,2);
  		 y=vehno1.substr(0,4);
  		//alert(">>"+x+"<<y"+y);
  	  		
  		}
  		}
  		else if(lt==9)
  		{
 				
  			if(isNaN(vehno1[0])){

  				
  				var x=vehno1.substr(0,2);
  		       var y=vehno1.substr(5,4);

 	  			}else{
 	 	  			//alert(">>1");

 	  				if(isNaN(vehno1[2])){

 	  	  				var x=vehno1.substr(8,2);
 	  	  		       var y=vehno1.substr(0,2);

 	  	 	  			}else{

 	  	  	  			var x=vehno1.substr(8,2);
 	  	  	  	       var y=vehno1.substr(0,3);
 	  	  	  			}
 	  				//alert(">>2");

 	  				if(isNaN(vehno1[3])){
 	  					//alert(">>3");

 	  	  				var x=vehno1.substr(7,2);
 	  	  		       var y=vehno1.substr(0,3);

 	  	 	  			}else{

 	  	  	  			var x=vehno1.substr(8,2);
 	  	  	  	       var y=vehno1.substr(0,4);
 	  	  	  			}

  	  		//	var x=vehno1.substr(7,2);
  	  	      // var y=vehno1.substr(0,4);
  	  			}
  		}
  			else if(lt==8)
  	  		{
  	  			if(isNaN(vehno1[0])){
  	  				var x=vehno1.substr(0,2);
  	  		       var y=vehno1.substr(4,4);
  	  	  			}else{

  	  	  			var x=vehno1.substr(6,2);
  	  	  	       var y=vehno1.substr(0,4);
  	  	  			}
  	  		}
  	  		else if(lt<=7)
  	  		{
  	  			if(isNaN(vehno1[0])){
  	  				var x=vehno1.substr(0,1);
  	  		       var y=vehno1.substr(3,4);
  	  	  			}else{

  	  	  			var x=vehno1.substr(6,1);
  	  	  	       var y=vehno1.substr(0,4);
  	  	  			}
  			
  		}
  	  		
  	  		
   		//alert(">>>>>"+x);
   		//alert(">>>>>"+y);
    
  	
  	//alert(mar);
  //	var len=vehnoo.length;
  	//alert(len)
  	var tripid;
  	
 tripid=dd1+""+dy2+""+dy1+""+y+""+x;
	//alert(">>"+tripid);
  	
  	document.tripform.tripid.value=tripid;

	//alert("tripid-->"+tripid)
	
	  


	
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
		
	}catch(e)
	{
		alert(e);
	}
}
function upload()
{
	var name1= document.getElementById("Filename1").value;
	 //alert(name1);
	 	var valid_extensions = /(.jpg|.jpeg|.png|.bmp)$/i;
	  if(valid_extensions.test(name1))
	  {
	  document.getElementById("Filename1").style.display="none";
	  document.getElementById("f1").innerHTML=name1;
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=name1;
	  document.getElementById("remove1").style.display="";
	  }
	  else{
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("Filename1").value="";
			  
	  }
}
function remove()
{
		document.getElementById("f1").innerHTML="";
		document.getElementById("f1").style.display="none";
		document.getElementById("remove1").style.display="none";
		document.getElementById("Filename1").value="";
		document.getElementById("f6").value="";
		document.getElementById("Filename1").style.display="";
	}

function computrtriptime()
{
	
	
	//if(bb.value=="Yes")
	//{ 
	
	//alert("hi");
	var numericExpressionn = /^[.0-9]+$/;
	var fixedkm=document.getElementById("fxdkm").value;
	//alert(fixedkm);
	var tripexpence=document.getElementById("tripexp").value;
	//alert(tripexpence);
	var ratekm=document.getElementById("ratekm").value;
	//alert(ratekm);
	var ratehr=document.getElementById("ratehr").value;
	//alert(ratehr);
	var startdate=document.getElementById("calender").value;
	
	//alert(cal);
	var sttime1=document.getElementById("sttime1").value;
	var sttime2=document.getElementById("sttime2").value;
	var sum=parseInt(fixedkm)*parseInt(ratekm);
	
	//alert(tripexpence);
	
	if(ratekm=="0"){
		alert("Rate/Km should be > 0");
		return false;
		
	}
	
	if(ratehr=="0"){
		alert("Rate/hr should be > 0");
		return false;
	}
	
	if(parseInt(tripexpence)<parseInt(sum)){
		alert("Trip Expense Should Not Be Less Than (Fixed Km * Rate/Km) ");
		return false;
	}
	
	
	if(ratekm==null || ratekm==""){
		alert("Please Enter Rate/Km")
		return false;
	}
	if(!(ratekm.match(numericExpressionn))&& ratekm.length!=0)
   	{
   		alert("Please enter Numeric value for rate/km");
          return false;
   	}

	if(ratehr==null || ratehr==""){
		alert("Please Enter Rate/Hour")
		return false;
	}
	if(!(ratehr.match(numericExpressionn))&& ratehr.length!=0)
   	{
   		alert("Please enter Numeric value for rate/hr");
          return false;
   	}
	
	if(fixedkm==null || fixedkm==""){
		alert("Please Enter Fixed Km")
		return false;
	}
	if(!(fixedkm.match(numericExpressionn))&& fixedkm.length!=0)
   	{
   		alert("Please enter Numeric value for fixed km");
          return false;
   	}
	
	if(tripexpence==null || tripexpence==""){
		alert("Please Enter Trip Expense")
		return false;
	}
	if(!(tripexpence.match(numericExpressionn))&& tripexpence.length!=0)
   	{
   		alert("Please enter Numeric value for trip expense");
          return false;
   	}
	
	//alert(sttime1);
	
	
		//tripgen="Yes";
		 //document.tripform.stloc.style.visibility="hidden";
		 //document.tripform.dest.style.visibility="hidden";
		//document.tripform.dest.disabled="true"; 
		//document.tripform.tripid.value="";
		//document.tripform.driverid.selectedIndex = 0;
		//document.tripform.drivername.value ="";
		//document.getElementById("mydiv2").style.display="";
		//document.getElementById("fixeddiv").style.display="";
		//document.getElementById("destdiv1").style.display="";
		document.getElementById("etatime2").style.display="none";
		document.getElementById("etatime3").style.display="";
		
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
                         var reslt=ajaxRequest.responseText.split("#");
                         
                       // alert(reslt);
                        //document.getElementById("testdemodiv").innerHTML=reslt;
                       var v=reslt[0];
                       if(parseInt(v)<0){
                    	   alert("Wrong inputs");
                    	  // document.getElementById("fxdkm").value="";
                    	   document.getElementById("tripexp").value="";
                    	   document.getElementById("ratekm").value="";
                    	   document.getElementById("ratehr").value="";
                    	   document.getElementById("ftme").value="";
                    	   //document.getElementById("etatime2").style.display="true";
                    	  // document.getElementById("fxdkm").readOnly = true;
                    	   return false;
                       }
                        document.getElementById("ftme").value=reslt[0];
                        document.getElementById("etadate").value=reslt[1];
                        //document.getElementById("etatime1").value=reslt[2];
                        //document.getElementById("etatime2").value=reslt[3];
                        document.tripform.etatime1.value=reslt[2];
                        document.tripform.etatime2.value=reslt[3];
                        document.tripform.etatime3.value=reslt[3];
                     //   document.tripform.etatime3.innerHTML=reslt[3];
                     
                      //  document.getElementById("fxdkm").setAttribute("readonly", "readonly"); 
		     } 
         	  }
             
             //alert("hi");
             var querystring= "?fixedkm="+fixedkm+"&tripexpence="+tripexpence+"&ratekm="+ratekm+"&ratehr="+ratehr+"&startdate="+startdate+"&sttime1="+sttime1+"&sttime2="+sttime2+"";
	     ajaxRequest.open("GET", "Ajaxtripenddate.jsp" + querystring, true);
	     ajaxRequest.send(null); 
	    // alert("out tripgen yes");
	//}

	
	
}


function computetripexpence123()
{
	
	
	//if(bb.value=="Yes")
	//{ 
	
    //alert("hi");
	var numericExpressionn = /^[.0-9]+$/;
	var fixedtime=document.getElementById("ftme").value;
	
	var fixedkm=document.getElementById("fxdkm").value;
	//alert(fixedkm);
	//var tripexpence=document.getElementById("tripexp").value;
	//alert(tripexpence);
	var ratekm=document.getElementById("ratekm").value;
	//alert(ratekm);
	var ratehr=document.getElementById("ratehr").value;
	//alert(ratehr);
	//var startdate=document.getElementById("calender").value;
	
	//alert(cal);
	//var sttime1=document.getElementById("sttime1").value;
	//var sttime2=document.getElementById("sttime2").value;
	
	//alert(tripexpence);
	if(ratekm==null || ratekm==""){
		alert("Please Enter Rate/Km")
		return false;
	}
	if(!(ratekm.match(numericExpressionn))&& ratekm.length!=0)
   	{
   		alert("Please enter Numeric value for rate/km");
          return false;
   	}
	if(ratehr==null || ratehr==""){
		alert("Please Enter Rate/Hour")
		return false;
	}
	if(!(ratehr.match(numericExpressionn))&& ratehr.length!=0)
   	{
   		alert("Please enter Numeric value for rate/hr");
          return false;
   	}
	
	if(fixedkm==null || fixedkm==""){
		alert("Please Enter Fixed Km")
		return false;
	}
	if(!(fixedkm.match(numericExpressionn))&& fixedkm.length!=0)
   	{
   		alert("Please enter Numeric value for fixed km");
          return false;
   	}
	
	if(fixedtime==null || fixedtime==""){
		alert("Please Enter Fixed Time")
		return false;
	}
	//alert(sttime1);
	
	
		//tripgen="Yes";
		 //document.tripform.stloc.style.visibility="hidden";
		 //document.tripform.dest.style.visibility="hidden";
		//document.tripform.dest.disabled="true"; 
		//document.tripform.tripid.value="";
		//document.tripform.driverid.selectedIndex = 0;
		//document.tripform.drivername.value ="";
		//document.getElementById("mydiv2").style.display="";
		//document.getElementById("fixeddiv").style.display="";
		//document.getElementById("destdiv1").style.display="";
		//document.getElementById("etatime2").style.display="none";
		//document.getElementById("etatime3").style.display="";
		
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
                       //alert(reslt);
                       //reslt.trim();
                      //document.getElementById("tripexp").value=ajaxRequest.responseText;
                      document.tripform.tripexp.value=reslt.trim();
                      document.getElementById("tripexp").innerHTML=reslt.trim();
                        //document.getElementById("testdemodiv").innerHTML=reslt;
                        /* document.getElementById("ftme").value=reslt[0];
                        document.getElementById("etadate").value=reslt[1];
                        //document.getElementById("etatime1").value=reslt[2];
                        //document.getElementById("etatime2").value=reslt[3];
                        document.tripform.etatime1.value=reslt[2];
                        document.tripform.etatime2.value=reslt[3];
                        document.tripform.etatime3.value=reslt[3];
                     //   document.tripform.etatime3.innerHTML=reslt[3]; */
		     } 
         	  }
             
             //alert("hi");
             var querystring= "?fixedkm="+fixedkm+"&ratekm="+ratekm+"&ratehr="+ratehr+"&fixedtm="+fixedtime+"";
	     ajaxRequest.open("GET", "Ajaxtripexpence.jsp" + querystring, true);
	     ajaxRequest.send(null); 
	    // alert("out tripgen yes");
	//}

	
	
}


</script>


	<%!Connection con1;%>

	<form name="tripform" action="tripstartentry.jsp" method="post" onSubmit="return validate();" enctype="multipart/form-data">
<input type="hidden" name="castrolroutecode" id="castrolroutecode" value=""></input>
<input type="hidden" name="castrolroutecode1" id="castrolroutecode1" value=""></input>
		
		<div id="mytable">
	<%
		try {
				Class.forName(MM_dbConn_DRIVER);
				con1 = fleetview.ReturnConnection();
				Statement stmt1 = con1.createStatement();
				Statement stmt9 = con1.createStatement();
				Statement stmt355 = con1.createStatement();
				
				ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs33 = null;
				String sql2 = "", sql3 = "", sql4 = "", sql5 = "", sql33 = "";
				String vehno = "", prvdid = "", lastdriverid = "", lastdrivername = "";

				vehno = request.getParameter("vehno");

				String user = session.getValue("usertypevalue").toString();
				System.out.println("ooh"+user);

				String typeofuser=session.getAttribute("TypeofUser").toString();
				System.out.println(" User Suyog " +typeofuser);

				java.util.Date d = new java.util.Date();
				//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
				int hours = (d.getHours());
				int minutes = (d.getMinutes());
				try{
					minutes=Integer.parseInt(session.getAttribute("Minute").toString());
				}catch(Exception e){
					e.printStackTrace();
					 minutes = (d.getMinutes());
				}

				//java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
				// Format formatter=new SimpleDateFormat("yyyy-MM-dd");
				String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy")
						.format(new java.util.Date());

				String duplicatetripid = request
						.getParameter("duplicatetripid");
				if (duplicatetripid == null) {
				} else {
	%>
	<table border="0" width="100%" class="stats">
		<tr>
			<td>
			<div align="center"><font color="maroon"> <B> This
			Trip Id is already been allocated. Please enter new one. </B> </font></div>
			</td>
		</tr>
	</table>
	<%
		}

				String driveriddup = request.getParameter("duplicate");
				if (driveriddup == null) {
				} else {
	%>
	<table border="0" width="100%" bgcolor="white" class="stats">
		<tr>
			<td>
			<div align="center"><font color="maroon"> <b>This
			Driver Id has already been allocated. Please enter another Id </b> </font></div>
			</td>
		</tr>
	</table>

	<%
		}
	%> <input type="hidden" name="vehno" value="<%=vehno%>" />

	<table border="0" style="height: 400px; width: 1000px" class="stats" >
		<tr>
			<td>
			<div align="left"><a href="javascript:history.go(-1)"> <img
				src="images/arrow.bmp" width="20px" height="20px" border="">
			</img> </a></div>
			</td>
			<td>
			<div align="center"><font size="3"> <b>
			Trip Information of <%=vehno%></b> </font></div>
			</td>
			
		</tr>
		

		<tr>
			<td colspan="2">
			
			<table border="0" height="100px" style="width: 650px" align="center" class="sortable_entry">
			<tr>
			<td></td>
		<td><div style=""><font size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(<font color="red"> *</font> indicates mandatory fields)</font></div></td>
		
		
		</tr>
				<tr>
					<td><font size="2"><div align="right"><font color="red"> *</font><b>Fixed Route :</b></div></font></td>
					<td><input type="radio" name="route" id="route" value="Yes" onclick="getTripInfo(this);"><font size="2"> Yes</font>
					&nbsp;&nbsp;&nbsp; <input type="radio" name="route" id="route" value="No" checked onclick="getTripInfo(this);">
					<font size="2">No</font></td>
				</tr>
		
				<%
					sql2 = "select distinct warehouse from t_warehousedata where Owner='" + user
									+ "'  order by WareHouse asc ";
							System.out.println("\n\n ssqqll-->>"+sql2);
							rs2 = stmt1.executeQuery(sql2);
				%>
				<tr >
				
					<td ><font size="2"> <div  align="right"><font color="red"> *</font><b>Start Location :</b></div>
					&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
					<td>
					<table border="0">
						<tr>
							<td>
							<div id="routediv"><!--In this Fixed ROute Codes  --></div>
							</td>
							<td>
							<div id="routediv1"><!-- In this Fixed Route desc is given  -->
							</div>
							</td>
					</tr>
						<tr>
							<td>
							<div id="mydiv2"></div>
							</td>
					
						</tr>
<!--						<tr>-->
<!--							<td>-->
<!--							<div id="mydiv3"></div>-->
<!--							</td>-->
<!--					-->
<!--						</tr>-->
<!--						<tr>-->
<!--							<td>-->
<!--							<div id="mydiv4"></div>-->
<!--							</td>-->
<!--					-->
<!--						</tr>-->
						<tr>
							<td>
							<div id="fixeddiv"></div>
							</td>
						</tr>
					</table>



					<div id="mydiv02">
					<select name="stloc" class="element select medium"  style="width: 200px" id="stloc" onChange="showothloc(this);">
							
							<option value="Select">Select</option>
						

<%
						String startLocation="Select";
							String sql9 = "select StartPlace from t_completedjourney where VehRegNo='"
											+ vehno + "' order by StartDate desc limit 1";
									System.out.println(sql9);
									ResultSet rs9 = stmt9.executeQuery(sql9);
									if (rs9.next()) {
										startLocation = rs9.getString("StartPlace");
						%>
						<option value="<%=startLocation%>" selected="selected"><%=startLocation%>
						</option>
						<%
													}	
									
						while (rs2.next()) {
						%>
						<option value="<%=rs2.getString("WareHouse")%>"><%=rs2.getString("WareHouse")%>
						</option>
						<%
							}
						%>
						<option value="Other">Other</option>
					</select></div>
					&nbsp;&nbsp;&nbsp; <input type="text" class="element text medium" name="othstrtloc" style="visibility: hidden;width: 150px" /></td>
				</tr>
				<tr >
					<td><font size="2"> <div align="right"><font color="red"> *</font><b>Report Date Time :</b> </font>
					</td>
					<td><input type="text" id="calender1" name="calender1" class="element text medium" style="width: 125px; height: 16px;" size="13" value="<%=nwfrmtdte%>" readonly />

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
					<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
					<script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender1"       // ID of the button
             }
                           );
             </script> <font> HH : </font> <select class="element select medium" id="rpttime1" style="width: 50px" name="rpttime1">
						<option value="Select">Select</option>
						<option value="00" <%if ("00".equals("hours")) {%> Selected
							<%}%>>00</option>
						<option value="01" <%if (01 == hours) {%> Selected <%}%>>01</option>
						<option value="02" <%if (02 == hours) {%> Selected <%}%>>02</option>
						<option value="03" <%if (03 == hours) {%> Selected <%}%>>03</option>
						<option value="04" <%if (04 == hours) {%> Selected <%}%>>04</option>
						<option value="05" <%if (05 == hours) {%> Selected <%}%>>05</option>
						<option value="06" <%if (06 == hours) {%> Selected <%}%>>06</option>
						<option value="07" <%if (07 == hours) {%> Selected <%}%>>07</option>
						<option value="08" <%if (8 == hours) {%> Selected <%}%>>08</option>
						<option value="09" <%if (9 == hours) {%> Selected <%}%>>09</option>
						<option value="10" <%if (10 == hours) {%> Selected <%}%>>10</option>
						<option value="11" <%if (11 == hours) {%> Selected <%}%>>11</option>
						<option value="12" <%if (12 == hours) {%> Selected <%}%>>12</option>
						<option value="13" <%if (13 == hours) {%> Selected <%}%>>13</option>
						<option value="14" <%if (14 == hours) {%> Selected <%}%>>14</option>
						<option value="15" <%if (15 == hours) {%> Selected <%}%>>15</option>
						<option value="16" <%if (16 == hours) {%> Selected <%}%>>16</option>
						<option value="17" <%if (17 == hours) {%> Selected <%}%>>17</option>
						<option value="18" <%if (18 == hours) {%> Selected <%}%>>18</option>
						<option value="19" <%if (19 == hours) {%> Selected <%}%>>19</option>
						<option value="20" <%if (20 == hours) {%> Selected <%}%>>20</option>
						<option value="21" <%if (21 == hours) {%> Selected <%}%>>21</option>
						<option value="22" <%if (22 == hours) {%> Selected <%}%>>22</option>
						<option value="23" <%if (23 == hours) {%> Selected <%}%>>23</option>
					</select> <font> MM :</font> <select class="element select medium" id="rpttime2"  style="width: 50px" name="rpttime2">

						<option value="00" <%if (minutes > 00 & minutes < 05) {%>
							Selected <%}%>>00</option>
						<option value="10" <%if (minutes > 05 & minutes < 15) {%>
							Selected <%}%>>10</option>
						<option value="20" <%if (minutes > 15 & minutes < 25) {%>
							Selected <%}%>>20</option>
						<option value="30" <%if (minutes > 25 & minutes < 35) {%>
							Selected <%}%>>30</option>
						<option value="40" <%if (minutes > 35 & minutes < 45) {%>
							Selected <%}%>>40</option>
						<option value="50" <%if (minutes > 45) {%> Selected <%}%>>50</option>

					</select> &nbsp;&nbsp;&nbsp;</td>

				</tr>
				<tr >
					<td><br></br><font size="2"><div align="right"> <font color="red"> *</font><b>Start Date Time :</b></div></font></td>
					<td><br></br><input type="text" id="calender" name="calender" class="element text medium" style="width: 125px; height: 16px;" size="13" value="<%=nwfrmtdte%>" onblur="javascript:funETA();" readonly />

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
					<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
					<script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender"       // ID of the button
             }
                           );
             </script> <font> HH : </font> 
             <select name="sttime1" id="sttime1" class="element select medium"  style="width: 50px" onblur="javascript:funETA();">
						<option value="Select">Select</option>
						<option value="00" <%if ("00".equals("hours")) {%> Selected
							<%}%>>00</option>
						<option value="01" <%if (01 == hours) {%> Selected <%}%>>01</option>
						<option value="02" <%if (02 == hours) {%> Selected <%}%>>02</option>
						<option value="03" <%if (03 == hours) {%> Selected <%}%>>03</option>
						<option value="04" <%if (04 == hours) {%> Selected <%}%>>04</option>
						<option value="05" <%if (05 == hours) {%> Selected <%}%>>05</option>
						<option value="06" <%if (06 == hours) {%> Selected <%}%>>06</option>
						<option value="07" <%if (07 == hours) {%> Selected <%}%>>07</option>
						<option value="08" <%if (8 == hours) {%> Selected <%}%>>08</option>
						<option value="09" <%if (9 == hours) {%> Selected <%}%>>09</option>
						<option value="10" <%if (10 == hours) {%> Selected <%}%>>10</option>
						<option value="11" <%if (11 == hours) {%> Selected <%}%>>11</option>
						<option value="12" <%if (12 == hours) {%> Selected <%}%>>12</option>
						<option value="13" <%if (13 == hours) {%> Selected <%}%>>13</option>
						<option value="14" <%if (14 == hours) {%> Selected <%}%>>14</option>
						<option value="15" <%if (15 == hours) {%> Selected <%}%>>15</option>
						<option value="16" <%if (16 == hours) {%> Selected <%}%>>16</option>
						<option value="17" <%if (17 == hours) {%> Selected <%}%>>17</option>
						<option value="18" <%if (18 == hours) {%> Selected <%}%>>18</option>
						<option value="19" <%if (19 == hours) {%> Selected <%}%>>19</option>
						<option value="20" <%if (20 == hours) {%> Selected <%}%>>20</option>
						<option value="21" <%if (21 == hours) {%> Selected <%}%>>21</option>
						<option value="22" <%if (22 == hours) {%> Selected <%}%>>22</option>
						<option value="23" <%if (23 == hours) {%> Selected <%}%>>23</option>
					</select> <font> MM :</font> <select name="sttime2" id="sttime2" class="element select medium"  style="width: 50px" onblur="javascript:funETA();">

						<option value="00" <%if (minutes > 00 & minutes < 05) {%>
							Selected <%}%>>00</option>
						<option value="10" <%if (minutes > 05 & minutes < 15) {%>
							Selected <%}%>>10</option>
						<option value="20" <%if (minutes > 15 & minutes < 25) {%>
							Selected <%}%>>20</option>
						<option value="30" <%if (minutes > 25 & minutes < 35) {%>
							Selected <%}%>>30</option>
						<option value="40" <%if (minutes > 35 & minutes < 45) {%>
							Selected <%}%>>40</option>
						<option value="50" <%if (minutes > 45) {%> Selected <%}%>>50</option>

					</select> &nbsp;&nbsp;&nbsp;</td>

				</tr>
				
				<tr  id="fx01">
					<td><br></br><font size="2"> <div align="right"><b>Fixed KM :</b></div></font></td>
					<td><br></br><input type="text" name="fxdkm" class="element text medium" style="width: 50px" size="6" value="" id="fxdkm" /><font size="2">Kms.
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--   </tr>
	    <tr  id="ft01">-->  </td>
				
				</tr>
				
			
			
			<tr  id="fx10">
					<td><br></br><font size="2"> <div align="right"> <b>Rate /Km :</b></div></font></td>
					<td><br></br><input type="text" name="ratekm" onblur="validateRatekm()" class="element text medium" style="width: 50px" size="6" value="" id="ratekm" /><font size="2">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font size="2"><b>
					Rate /Hr. :</b></font> <input type="text" name="ratehr" size="6" class="element text medium" style="width: 50px" value="" id="ratehr" /><font size="2"> 
					</td>
				</tr>
				
				
				
				<tr id="fx12">
				<td><br></br><font size="2">
					<div align="right"> <b>Fixed Time :</b></div></font></td><td><br></br> <input type="text" name="ftme" size="6" class="element text medium" style="width: 50px" value="" id="ftme" /><font size="2">Hrs. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <input type="button" name="Computetripexpence" value="Compute Trip Expense" style="border-style: outset; border-color: black" onClick="return computetripexpence123()" class="formElement" /></td>  
				</tr>
				<tr id="fx9">
					<td><br></br><font size="2"><div align="right"><b>Trip Expense :</b></div> </font></td>
					<td><br></br><input type="text" class="element text medium" style="width: 150px" name="tripexp" id="tripexp" value=""/>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" name="Compute ETA" value="Compute ETA" style="border-style: outset; border-color: black" onClick="return computrtriptime()" class="formElement" />
					</td>
					  
					
				</tr>
				
				<tr>
					<td><br></br><font size="2">  <div align="right"><font color="red"> *</font><b>ETA :</b><div align="center"></font></td>
					<td><br></br><font size="2">Date <input
						type="text" class="element text medium" style="width: 125px; height: 16px;" id="etadate" name="etadate" size="13"
						value="<%=nwfrmtdte%>" readonly /> <!--        ///********Visible for fixed route for ETA Calculation*******************************       -->
					<!--<input type="text" name="etadatecal"  style="visibility:hidden" readonly/>-->
					<!--        ///***************************************       -->

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
					<!--              <input type="button" name="etatrigger" id="etatrigger" value="Date" class="formElement"> -->
					<script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "etadate",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "etadate"       // ID of the button
             }
                           );
             </script>  <font>
					HH : </font> <!--<input type="text" name="etatime1cal"  style="visibility:hidden" readonly/>-->
					<select name="etatime1" id="etatime1" class="element select medium"  style="width: 50px">
						<option value="Select">Select</option>
						<option value="00" <%if ("00".equals("hours")) {%> Selected
							<%}%>>00</option>
						<option value="01" <%if (01 == hours) {%> Selected <%}%>>01</option>
						<option value="02" <%if (02 == hours) {%> Selected <%}%>>02</option>
						<option value="03" <%if (03 == hours) {%> Selected <%}%>>03</option>
						<option value="04" <%if (04 == hours) {%> Selected <%}%>>04</option>
						<option value="05" <%if (05 == hours) {%> Selected <%}%>>05</option>
						<option value="06" <%if (06 == hours) {%> Selected <%}%>>06</option>
						<option value="07" <%if (07 == hours) {%> Selected <%}%>>07</option>
						<option value="08" <%if (8 == hours) {%> Selected <%}%>>08</option>
						<option value="09" <%if (9 == hours) {%> Selected <%}%>>09</option>
						<option value="10" <%if (10 == hours) {%> Selected <%}%>>10</option>
						<option value="11" <%if (11 == hours) {%> Selected <%}%>>11</option>
						<option value="12" <%if (12 == hours) {%> Selected <%}%>>12</option>
						<option value="13" <%if (13 == hours) {%> Selected <%}%>>13</option>
						<option value="14" <%if (14 == hours) {%> Selected <%}%>>14</option>
						<option value="15" <%if (15 == hours) {%> Selected <%}%>>15</option>
						<option value="16" <%if (16 == hours) {%> Selected <%}%>>16</option>
						<option value="17" <%if (17 == hours) {%> Selected <%}%>>17</option>
						<option value="18" <%if (18 == hours) {%> Selected <%}%>>18</option>
						<option value="19" <%if (19 == hours) {%> Selected <%}%>>19</option>
						<option value="20" <%if (20 == hours) {%> Selected <%}%>>20</option>
						<option value="21" <%if (21 == hours) {%> Selected <%}%>>21</option>
						<option value="22" <%if (22 == hours) {%> Selected <%}%>>22</option>
						<option value="23" <%if (23 == hours) {%> Selected <%}%>>23</option>
					</select> <font> MM :</font> <!--<input type="text" name="etatime2cal"  style="visibility:hidden" readonly/>-->
					<select class="element select medium"  style="width: 50px;" id="etatime2" name="etatime2">

						<option value="00" <%if (minutes > 00 & minutes < 05) {%>
							Selected <%}%>>00</option>
						<option value="10" <%if (minutes > 05 & minutes < 15) {%>
							Selected <%}%>>10</option>
						<option value="20" <%if (minutes > 15 & minutes < 25) {%>
							Selected <%}%>>20</option>
						<option value="30" <%if (minutes > 25 & minutes < 35) {%>
							Selected <%}%>>30</option>
						<option value="40" <%if (minutes > 35 & minutes < 45) {%>
							Selected <%}%>>40</option>
						<option value="50" <%if (minutes > 45) {%> Selected <%}%>>50</option>

					</select> <!--<td> 	<div id="routediv"> In this Fixed ROute Codes    </div> 	</td>-->
					
					 <input type=text name="etatime2" id="etatime3" class="element select medium"  style="width: 30px ;display: none; readonly">
					
					</td>
				</tr>
				
				<%
					sql33 = "select Distinct(Loadreason) from t_startedjourney where OwnerName='"
									+ user + "'  OR GPName='"+user+"'  order By Vendor Asc";
							// out.print(sql3); 
							rs33 = stmt1.executeQuery(sql33);
				%>
				<tr >
					<td><br></br><div align="right"><font size="2"> <b> Load Delay Reason :</b></font></div></td>
					<td><br></br>
					<div id="Loadreasondiv">
					<select name="Loadreason" id="Loadreason" class="element select medium"  style="width: 150px" onChange="showothLoadreason(this);">
						<option value="Select">Select</option>

						<%
							while (rs33.next()) {
						%>
						<option value="<%=rs33.getString("Loadreason")%>"><%=rs33.getString("Loadreason")%>
						</option>
						<%
							}
						%>
						<option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" class="element text medium"  name="othLoadreason" id="othLoadreason" style="visibility: hidden; width: 150px" /></div>
					<div id="Loadreasondiv1"></div>
					</td>
				</tr>
				<tr >
					<td><br></br><font size="2"> <div align="right"><b> Comment :</b></div></font></td>
					<td><br></br><textarea class="element text medium" name="loadcmnt" rows="4" cols="35"></textarea>
					&nbsp;</td>
				</tr>




				<%
					sql3 = "select distinct warehouse from t_warehousedata where Owner='" + user
									+ "'  order by WareHouse asc ";
							// out.print(sql3); 
							rs3 = stmt1.executeQuery(sql3);
				%>
				<tr >
					<td><br></br><font size="2">  <div align="right"><font color="red"> *</font><b>Destination :</b> </div></font></td>
					<td><br></br>
					<div id="destdiv">
					<select name="dest" id="dest" class="element select medium"  style="width: 200px" onChange="showothdest(this);">
						<option value="Select">Select</option>

						<%
							while (rs3.next())
							{
						%>
						<option value="<%=rs3.getString("WareHouse")%>"><%=rs3.getString("WareHouse")%>
						</option>
						<%
							}
						%>
						<option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" class="element text medium" name="othdest" id="thedest"
						style="visibility: hidden;width: 150px" /></div>
					<div id="destdiv1"></div>
					</td>
				</tr>


				<!-- <tr  id="fx01">
					<td><br></br><font size="2"> <div align="right"> <b>Fixed KM :</b></div></font></td>
					<td><br></br><input type="text" name="fxdkm" class="element text medium" style="width: 50px" size="6" value="" id="fxdkm" /><font size="2">Kms.
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   </tr>
	    <tr  id="ft01"> <font size="2">
					Fixed Time:</font> <input type="text" name="ftme" size="6" class="element text medium" style="width: 50px" value="" id="ftme" /><font size="2">Hrs. &nbsp; </td>
				</tr> -->
				<tr>
					<td><br></br><font size="2"><div align="right"><font color="red"> *</font> <b>Trip Id :</b></div> </font></td>
					<td><br></br><input type="text" class="element text medium" style="width: 150px"  name="tripid" value="" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<font size="2"> CN : </font>
					<input type="text" class="element text medium" style="width: 100px" name="cnnumber" id="cnnumber" value="" /></td>
					
				</tr>
				<tr>
				
					<td>				<br></br>
					 <div align="right"><font size="2"><b> Weight Load :</b></font></div></td>
					<td><br></br><input type="text" class="element text medium" style="width: 75px" name="weight" size="7" value="" id="weight" /><font size="2"> Kg. </font>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<font size="2"> Freight </font> 
					<input type="text" class="element text medium" style="width: 75px" name="frie" size="7" value="" id="frie" />
					<font size="2">Rs.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<font size="2"> Advance </font>
					 <input type="text" class="element text medium" style="width: 75px" name="adv" size="7" value="" id="adv" />
					 <font size="2">Rs. &nbsp;&nbsp;&nbsp; </td>
				</tr>
				<tr>
				
					<td>				<br></br>
					<div align="right"><font size="2"> <b>Branch Office Code :</b></font></div></td>
					<td>				<br></br>
					<input type="text" class="element text medium" style="width: 150px" name="bcode" size="7" value="" id="bcode" /></td>
				</tr>
					<tr>
					<td>				<br></br>
					<div align="right"><font size="2"> <b>LR Issued By :</b></font></div></td>
					<td>				<br></br>
					<input type="text" class="element text medium" style="width: 200px" name="lrissue" size="7" value="" id="lrissue" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<font size="2">LR Contact : </font> 
					<input type="text"  class="element text medium" style="width: 150px" name="lrcontact" size="7" value="" id="lrcontact" />
				
				</td>
				</tr>
				

				<%
				String sql34="";
				if(typeofuser.equals("GROUP") || typeofuser.equalsIgnoreCase("GROUP"))
				{
				//String sql355="select GPname from db_gps.t_group where gpname='Castrol'";
				//ResultSet rs355=stmt355.executeQuery(sql355);
				//String Who=rs355.getString(1);
 					
					
					
					 sql34 = "select Distinct(TripCategory) from t_startedjourney where GPName='"
									+ user + "' order By TripCategory Asc";
					 
					 System.out.print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhqueryyyyyy");
				}
				
				else{
					sql34 = "select Distinct(TripCategory) from t_startedjourney where OwnerName='"
						+ user + "'  OR GPName='"+user+"' order By TripCategory Asc";
					
				}
					
				// out.print(sql3);
				if(user.equals("Castrol"))
 					{
					sql34 = "select TripCategory from db_gps.t_startedjourney where TripCategory='Tanker' limit 1";
					ResultSet rs34 = stmt1.executeQuery(sql34);
					System.out.print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"+user);
					%>
						<tr >
					<td><br></br><font size="2"> <div align="right"> <b>Trip Category :</b> </div></font></td>
					<td><br></br>
					<div id="categorydiv">
					<select name="TripCategory" class="element select medium"  style="width: 100px" id="TripCategory" onChange='showothcategry(this)'>
						
	                           			<%
							while (rs34.next()) {
						%>
						<option value="<%=rs34.getString("TripCategory")%>"><%=rs34.getString("TripCategory")%>
						</option>


						<%
							}
						%>
							
							 <option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" class="element text medium" name="othTripCategory"
						id="othTripCategory" style="visibility: hidden;width: 150px" /></div>
					<div id="categorydiv1"></div>
					</td>
				</tr> 
				
				
			
				<% }
				
				
				else 
				{
					ResultSet rs34 = stmt1.executeQuery(sql34);
					System.out.println("Trip cat query is " +sql34 );
				
				%>
				<tr >
					<td><br></br><font size="2"> <div align="right"> <b>Trip Category :</b> </div></font></td>
					<td><br></br>
					<div id="categorydiv">
					<select name="TripCategory" class="element select medium"  style="width: 100px" id="TripCategory" onChange='showothcategry(this)'>
						<option value="Select">Select</option>

						<%
							while (rs34.next()) {
						%>
						<option value="<%=rs34.getString("TripCategory")%>"><%=rs34.getString("TripCategory")%>
						</option>


						<%
							}
						%>
						 <option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" class="element text medium" name="othTripCategory"
						id="othTripCategory" style="visibility: hidden;width: 150px" /></div>
					<div id="categorydiv1"></div>
					</td>
				</tr> 
				
				
			
				<%} %>
				<%
					String sql45 = "select Distinct(GoodsContent) from t_startedjourney where OwnerName='"
									+ user + "' OR GPName='"+user+"' order By GoodsContent Asc";
							// out.print(sql3); 
							ResultSet rs45 = stmt1.executeQuery(sql45);
				%>
				<tr >
					<td><br></br><font size="2"> <div align="right"> <b>Product Name :</b> </div></font></td>
					<td><br></br>
					<div id="contentdiv">
					<select name="GoodsContent" id="GoodsContent" class="element select medium"  style="width: 150px" onChange='showothcontent(this)'>
						<option value="Select">Select</option>

						<%
							while (rs45.next()) {
						%>
						<option value="<%=rs45.getString("GoodsContent")%>"><%=rs45.getString("GoodsContent")%>
						</option>


						<%
							}
						%>
						<option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" class="element text medium" name="othGoodsContent"
						id="othGoodsContent" style="visibility: hidden;width: 150px" /></div>
					<div id="contentdiv1"></div>
					</td>
				</tr>
				
				
				
				
				<!-- /********************************************-->
				<%
					sql33 = "select Distinct(Vendor) from t_startedjourney where OwnerName='"
									+ user + "' OR GPName='"+user+"' order By Vendor Asc";
							// out.print(sql3); 
							rs33 = stmt1.executeQuery(sql33);
				%>
				<tr>
				
					<td><br></br><font size="2"> <div align="right"> <b>Customer :</b></div></font></td>
					<td><br></br>
					<div id="vendordiv">
					<select name="vendor" id="vendor" class="element select medium"  style="width: 150px" onChange="showothvendor(this);">
						<option value="Select">Select</option>

						<%
							while (rs33.next()) {
						%>
						<option value="<%=rs33.getString("Vendor")%>"><%=rs33.getString("Vendor")%>
						</option>
						<%
							}
						%>
						<option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp; <input type="text" class="element text medium" name="othvendor"
						id="thevendor" style="visibility: hidden;width: 150px" /></div>
					<div id="vendordiv1"></div>
					</td>
				</tr>
				<%
					/* sql5="select * from t_completedjourney where VehRegNo='"+vehno+"' order by StartDate desc limit 1";	
									 rs5=stmt1.executeQuery(sql5);	
									 if(rs5.next())
									 {
									 lastdriverid=rs5.getString("DriverId");
									 lastdrivername=rs5.getString("DriverName");
									
									 }
							 */
				%>
				<tr>
					<td><font size="2"> <div align="right"><font color="red"> *</font><b>Driver Name(Id) :</b> </div></font>
					</td>
					<td><br></br><select name="driverid" class="element select medium"  style="width: 250px" onChange="showothrdriverid(this);">
						<%
							sql4 = "select * from t_completedjourney where VehRegNo='"
											+ vehno + "' order by StartDate desc limit 1";
									System.out.println(sql4);
									rs5 = stmt1.executeQuery(sql4);
									if (rs5.next()) {
										lastdriverid = rs5.getString("DriverId");
										lastdrivername = rs5.getString("DriverName");
						%>
						<option value="<%=rs5.getString("DriverID")%>"><%=rs5.getString("DriverName") + "( "
								+ rs5.getString("DriverID") + " )"%>
						</option>
						<%
							} else {
						%>
						<option value="Select">Select</option>
						<%
							}
									sql4 = "select * from t_drivers where Owner='" + user
											+ "' and DriverID<>'" + lastdriverid
											+ "' order by DriverName asc ";
									rs4 = stmt1.executeQuery(sql4);
						%>
						<%
							while (rs4.next()) {
										//System.out.println("IN while");
						%>
						<option value="<%=rs4.getString("DriverID")%>"><%=rs4.getString("DriverName") + "( "
								+ rs4.getString("DriverID") + " )"%>
						</option>
						<%
							}//
						%>
						<option value="Other">Other</option>
					</select> &nbsp;&nbsp;&nbsp;
					<table border="0" id="tabid">
						<tr>
							<td><label name="newid" id="newid" style="visibility: hidden">Driv. Id :</label> 
								<input type="text" class="element text medium" name="othdriverid" style="visibility: hidden;width: 100px" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <label name="newdrvname" id="newdrvname" style="visibility: hidden"> Driv. Name</label> 
							<input type="text" class="element text medium" name="newdrvname" style="visibility: hidden;width: 200px" /></td>
						</tr>
					</table>
					</td>
				</tr>
				<input type="hidden" name="drivername" value="<%=lastdrivername%>" readonly />


				<!--<input type="hidden" name="eta" id="eta" value=""></input>-->
				<tr>
				<td><font size="2"> <div align="right"><font color="red"> </font><b>Job Order No:</b> </div></font>
					</td>
					<td>			
					<input type="text" class="element text medium" style="width: 200px" name="joborderno" size="7" value="" id="joborderno"  />
					
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<font size="2">Revenue : </font> 
					<input type="text"  class="element text medium" style="width: 150px" name="revenue" size="7" value="" id="revenue" />
				
				</td>
				<br><br>
				</tr>
			   <tr><td><br>  </td></tr>  
				
				<tr>
				<br><br>
			<td><font size="2"> <div align="right"><font color="red"> </font><b> Container No:</b> </div></font>
			</td>
			<td>				
			<input type="text" class="element text medium" style="width: 200px" name="containerno" size="7" value="" id="containerno"  />
			<!-- <input type="text" class="element text medium" style="width: 200px" name="containerno" size="7" value="" id="containerno" onblur="newcontainer()" /> -->
			<!-- <label name="newcontainerno" id="newcontainerno" style="display: none;"><font color="red">Please Enter Container No</font></label> -->		
				</tr>
				
				  <tr>
         <td> <br></br><div align="right">
  	<font  size="2"><b>CN File Upload :</b></font> </td>
  	<td><br></br>
  	
<input type="file" cols="40" name="Filename1" id="Filename1" value="" onchange="upload();" style="background-image: newimages/browse.jpg"/>
<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
&nbsp;&nbsp;<a href="#" onclick="remove();" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		      </td>
		      </tr>  	
  	
		
				<tr>
				<td colspan="2">
				<br></br>
					<div align="center">
					<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" onClick="return validate()" class="formElement" />
					
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" name="Cancel" style="border-style: outset; border-color: black" value="Cancel" onclick="cancelbutton();"  class="formElement" />
					</div>
					</td>
					</tr>

			</table>

			</td>
		</tr>
	</table>
	<%
		} catch (Exception e) {
				out.println("Exception----->" + e);
			} finally {
				try {
					con1.close();
				} catch (Exception e) {
				}
				try {
					fleetview.closeConnection();
				} catch (Exception e) {
				}
			}
	%> <%
 	//fleetview.closeConnection();
 %>
	</div>

</form>

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