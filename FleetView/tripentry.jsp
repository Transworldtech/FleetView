<script language="javascript">

var showothstartloc="No";
var showothdestloc="No";
var showothdrivid="No";
var tripgen="No";

function validate()
{ 

   if(document.tripform.ArrDep[0].checked==true)
   {
      var v1=document.tripform.veh.value;
      var v4=document.tripform.calender1.value;
      var v5=document.tripform.arrivatime1.value;
        

      if(v1=="Select")
      {
         alert("Please select the Vehicle to get its departure information");
         return false;   
      }
      
      if(v4.length==0)
      {
         alert("Please select the Vehicle arrival date");
         return false;   
      } 

      if(v5=="Select")
      {
         alert("Please select the Vehicle arrival time");
         return false;
      } 
         return datevalidate();
   }
   
   else
   {
      var v2=document.tripform.veh.value;
      var v3=document.tripform.stloc.value;
      var v6=document.tripform.calender.value;
      var v7=document.tripform.sttime1.value;
      var v8=document.tripform.dest.value;
      var v9=document.tripform.driverid.value;
	var v10=document.tripform.tripid.value;
      

      if(v2=="Select")
      {
         alert("Please select the Vehicle from the list");
         return false;   
      }

     /* if(v3=="Select")
      {
         alert("Please select the starting location / Fixed route from the list");
         return false;   
      }*/

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

      /*if(v8=="Select")
      {
         alert("Please select the destination");
         return false;   
      }*/
      
      /*if(v3==v8)
      {
         if(v3=="Other" && v8=="Other")
         {              
             var othrstloc=document.tripform.othstrtloc.value;
             var othdest=document.tripform.othdest.value;
             if(othrstloc==othdest)
             {
                 alert("Start Location and Destination cannot be same");
                 return false;  
             } 
            
         }
         else
         { 
             alert("Start Location and Destination cannot be same");
             return false;   
         }
      }*/
      
      if(v3=="Other")
      { 
         var othrstloc=document.tripform.othstrtloc.value;
         if(othrstloc==v8)
         {
            alert("Start Location and Destination cannot be same");
            return false; 
         }
         
      }     
      if(v8=="Other")
      {
         var othdest=document.tripform.othdest.value;
         if(othdest==v3)
         {
            alert("Start Location and Destination cannot be same");
            return false; 
         }
      }

      if(v9=="Select")
      {
         alert("Please select the driver Id");
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
          var v10=document.tripform.othstrtloc.value;
          
         if(v11.length==0)
         { 
            alert("Please enter new destination");
            return false;
         }
     
         // if(v10==v11)
         //{
          //  alert("Start Location and Destination cannot be same");
          //  return false;
         ///} 
      }

      if(showothdrivid=="Yes")
      {
         var v12=document.tripform.othdriverid.value;
         var v13=document.tripform.drivername.value;
   
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

         if(v13.length==0)
         { 
            alert("Please enter new Driver name");
            return false;
         }
      }

	if(v10=="")
 	{
		alert("Please enter Trip Id");
		return false;
	}

       return datevalidate();
      
   }
   return datevalidate();
}

function datevalidate()
{
   if(document.tripform.ArrDep[0].checked==true)
   {
      //var date1=document.tripform.tdydte.value;
      var date1=document.tripform.calender.value;
      var enddte=document.tripform.calender1.value;
      //alert(enddte);   

      var dm1,dd1,dy1,dy2,dm2,dd2;
   
      dy1=date1.substring(0,4);
      dy2=enddte.substring(0,4);

      dm1=date1.substring(5,7);
      dm2=enddte.substring(5,7); 

      dd1=date1.substring(8,10);
      dd2=enddte.substring(8,10);

       if(dy2<dy1)
	{
		alert("Please select proper Date (Year)");
		document.tripform.calender1.value="";
				
		return false;
	}

	if(dy2==dy1)
	{
         	if(dm2<dm1)
		{
			alert("Please select proper Date (Month)");
			document.tripform.calender1.value="";
	
			return false;
	
		}
	}

        if(dm2==dm1)
        {
		if(dd2<dd1)
		{
		alert("Please select proper date");
		document.tripform.calender1.value="";

		return false;
	
		}
        }
      
   }
   else
   {
     /* var date1=document.tripform.tdydte.value;
      var stdte=document.tripform.calender.value;
      //alert(stdte);

      var dm1,dd1,dy1,dy2,dm2,dd2;
   
      dy1=date1.substring(0,4);
      dy2=stdte.substring(0,4);

      dm1=date1.substring(5,7);
      dm2=stdte.substring(5,7); 

      dd1=date1.substring(8,10);
      dd2=stdte.substring(8,10);

       if(dy2>dy1)
	{
		alert("Please select proper Date");
		document.tripform.calender.value="";
				
		return false;
	}

         if(dm2>dm1)
	{
		alert("Please select proper Date");
		document.tripform.calender.value="";

		return false;
	
	}

        if(dm2==dm1)
        {
		if(dd2>dd1)
		{
		alert("Please select proper date");
		document.tripform.calender.value="";

		return false;
	
		}
        } */
      
          
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

function showothrdriverid(dropdown)
{

  if(tripgen=="Yes")
  {  
	var fixroute=document.tripform.routename.value;
	var stdte=document.tripform.calender.value;

  	
	var tripid=fixroute+"-"+stdte;
	document.tripform.tripid.value=tripid;

	if(fixroute=="Select")
	{
		alert("Please select Fixed route first");
		document.tripform.driverid.selectedIndex = 0;
	}
	if(stdte=="")
	{
		alert("Please select start date first");
		document.tripform.driverid.selectedIndex = 0;
	}	
  }
  else 
  {  
	//var tripidauto=document.tripform.tripiddup.value;
        document.tripform.tripid.value="";
  }	

   
  var vv1=dropdown.selectedIndex;
       
  var SelValue1 = dropdown.options[vv1].value;
   
        if(SelValue1=="Other")
        {
            document.tripform.othdriverid.style.visibility="visible";
            showothdrivid="Yes"; 
             document.tripform.drivername.readOnly=false;
        }
        else 
       {
            document.tripform.othdriverid.style.visibility="hidden";
            document.tripform.othdriverid.value="";
            document.tripform.drivername.readOnly=true;
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
             var vv=document.tripform.tripiddup.value;
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
		document.tripform.stloc.disabled="true"; 
		document.tripform.dest.disabled="true"; 
		document.tripform.tripid.value="";

		document.tripform.driverid.selectedIndex = 0;
		document.tripform.drivername.value ="";

		document.getElementById("mydiv2").style.display="";
		document.getElementById("destdiv1").style.display="";

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
		
		document.tripform.stloc.disabled=false;  
		document.tripform.dest.disabled=false; 	

		document.getElementById("routediv").innerHTML="";

		
		document.tripform.tripid.value="";
		document.getElementById("routediv1").innerHTML="";

		document.tripform.stloc1.value="";
		document.tripform.dest1.value="";


		document.getElementById("mydiv2").style.display='none';
		document.getElementById("destdiv1").style.display='none';
		
			

	}
}
function fun2(bb)
{
	if(!(bb.value=="Select"))
	{
		var val1=bb.value;
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
                        
                         var res=reslt.split("#");
                         var result="<b>Route Points <BR></b>";
                         for(i=0;i<res.length;i++)
                         {
                         	result=result+res[i]+"<br>";
                         }
                       document.getElementById("routediv1").innerHTML=result;
                       document.getElementById("mydiv2").innerHTML="<input type='text' class='formElement' name='stloc1' id='stloc1' value='"+res[0]+"' readonly />";
                       document.getElementById("destdiv1").innerHTML="<input type='text' class='formElement' name='dest1' id='dest1' value='"+res[i-1]+"' readonly/>";
       
		     } 
         	  }
             
             //alert("hi");
             var queryString = "?tripid=" +val1;
	     ajaxRequest.open("GET", "AjaxGetTripInfoDetails.jsp"+queryString, true);
	     ajaxRequest.send(null); 
		
	}
	
	
}


</script>

<%@ include file="header.jsp" %>

<%!
Connection con1;
%>

<form name="tripform" method="get" action="tripentryinsert.jsp" onSubmit="return validate();" >

<% 
try {

Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement();
ResultSet rs1=null,rs2=null, rs3=null, rs4=null, rs5=null, rs6=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="";
String usrcode="", lasttripid="", nexttripid="", idint="", typuser="";
int len=0;
int maxtripidint=0;

String user=session.getValue("usertypevalue").toString();

%>

<%
  java.util.Date d=new java.util.Date();
String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();

 java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
   Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   String nwfrmtdte=formatter.format(datefrmdb);
%>
<input type="hidden" name="tdydte" value="<%=nwfrmtdte %>" > </input>

<center>

<table border="0" width="100%">
  <tr>
      <td> <font color="red"> <B> <I> Note: </I> </B> Trip Id won't be generated automatically. Please enter unique Trip Id.</font> </td>
  </tr>
</table>

<table border="1" width="100%" bgcolor="white">
  <tr>
      <td> <center>
<table border="0" width="40%">
  <tr>
      <td> <div align="center"> <font color="maroon" size="3"> <b> Trip Information</b> </font> </div> </td>
  </tr>
</table>

<% 
  String duplicatetripid=request.getParameter("duplicatetripid");
  if(duplicatetripid==null)
  {
  }
  else
  { %>
       <table border="0" width="40%">
  <tr>
       <td> <div align="center"> <font color="maroon"> <B> This Trip Id is already been allocated. Please enter new one. </B> </font> </div> </td>
  </tr>
</table>
<%
  }

  String duplicatetrip=request.getParameter("duplicatetrip");
  if(duplicatetrip==null)
  {
  }
  else
  { %>
       <table border="0" width="40%">
  <tr>
       <td> <div align="center"> <font color="maroon"> <B> This Vehicle is already in Trip. Please end its Trip to enter new one. </B> </font> </div> </td>
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
       <table border="0" width="40%">
  <tr>
       <td> <div align="center"> <font color="maroon">  This Id has already been allocated. Please enter another Id  </font> </div> </td>
  </tr>
</table>
    
<%}

  String inserted=request.getParameter("inserted");
  if(inserted==null)
  {
  }
  else
  { %>
       <table border="0" width="40%">
  <tr>
       <td> <div align="center"> <font color="maroon">  Successfuly inserted  </font> </div> </td>
  </tr>
</table>
   
  
<%}

  sql6="select TypeofUser from t_security where TypeValue='"+user+"' ";
  rs6=stmt1.executeQuery(sql6);
   if(rs6.next())
   {
      typuser=rs6.getString("TypeofUser");
   } 

  if(typuser.equals("Transporter")) 
  { 
     sql1="select VehicleRegNumber as vehreg from t_vehicledetails where OwnerName='"+user+"'  ";
     rs1=stmt1.executeQuery(sql1);
  }
  else
  { 
     sql1="select transporter as vehreg from t_group where GPName='"+user+"' order by transporter asc ";
     //out.print(sql1); 
     rs1=stmt1.executeQuery(sql1);
  }
%>

<table border="1" width="40%">
  <tr>
     <td colspan="2"> <div align="center">
       <input type="radio" name="ArrDep" value="Arrived" class="formElement" onClick="RadChange(0)"> <font color="maroon" > Arrived </font> &nbsp;&nbsp;&nbsp;
       <input type="radio" name="ArrDep" value="Departed" class="formElement" CHECKED onClick="RadChange(1)"> <font color="maroon"> Departed </font> </div>
     </td>
  </tr>
  <tr>
      <td> <font color="maroon" > Vehicles </font> </td>
 
      <td>  <div id="mydiv">
           <select name="veh" class="formElement" > <option value="Select" >Select</option> 
       
           <%
               while(rs1.next())
               { %>

                   <option value="<%=rs1.getString("vehreg") %>" > <%=rs1.getString("vehreg") %> </option>   
           <%  } 
           %>
           </select>  </div>
      </td>
  </tr> 
<tr><td><font color="maroon" > Fixed Route </font> </td><td><input type="radio" name="route" id="route" value="Yes" onclick="getTripInfo(this);"> Yes &nbsp;&nbsp;&nbsp;<input type="radio" name="route" id="route" value="No" checked  onclick="getTripInfo(this);"> No
<div id="routediv"></div>
<div id="routediv1"></div>
</td></tr>


<% sql2="select * from t_warehousedata where Owner='"+user+"' order by WareHouse asc ";
  // out.print(sql2); 
   rs2=stmt1.executeQuery(sql2);
%>
  <tr>
      <td> <font color="maroon" > Start Location </font> </td>
      <td>  <div id="mydiv1">
            <select name="stloc" id="stloc" onChange="showothloc(this);" class="formElement" > <option value="Select">Select</option> 

 <%     while(rs2.next())
        { %>
             <option value="<%=rs2.getString("WareHouse") %>" > <%=rs2.getString("WareHouse") %> </option>
 <%     }
 %>
            <option value="Other">Other </option>
           </select> &nbsp;&nbsp;&nbsp;
             <input type="text" name="othstrtloc" class="formElement" style="visibility:hidden" /> </div>
	<div id="mydiv2">
	</div>
     </td>
  </tr> 
  
  <tr>
      <td> <font color="maroon"> Start Date </font> </td>
      <td> <input type="text" id="calender" name="calender" size="13" class="formElement" value="" readonly  />
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="button" name="trigger" id="trigger" value="Date" class="formElement">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger"       // ID of the button
             }
                           );
             </script>
    </td>
  </tr>
  <tr> 
      <td> <font color="maroon" > Start Time </font> </td>
      <td> <font color="maroon">
            HH : </font> <select name="sttime1" class="formElement">
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
             </select>  <font color="maroon">
         MM :</font> <select name="sttime2" class="formElement">
            
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
               <%
                   for(int i=10;i<=59;i++)
                   {
               %>
                     <option value='<%=i%>'><%=i%></option>
               <%
                   }
               %>
            </select> &nbsp;&nbsp;&nbsp;
                 <input type="text" name="sttime" style="visibility:hidden" class="formElement" size="12" />
       </td>
  </tr>

<%   sql3="select * from t_warehousedata where Owner='"+user+"' order by WareHouse asc ";
     // out.print(sql3); 
     rs3=stmt1.executeQuery(sql3);
%>
   <tr>
      <td> <font color="maroon" > Destination </font> </td>
      <td><div id="destdiv"> <select name="dest" id="dest" onChange="showothdest(this);" class="formElement"> <option value="Select">Select</option>

    <%  while(rs3.next())  
        { %>
             <option value="<%=rs3.getString("WareHouse") %>" > <%=rs3.getString("WareHouse") %> </option>
    <%  }
     %>     
             <option value="Other">Other </option>
           </select>  &nbsp;&nbsp;&nbsp;
             <input type="text" name="othdest" class="formElement" style="visibility:hidden"/>
             </div>
		<div id="destdiv1">
		</div>
</td>
  </tr>

<% sql4="select * from t_drivers where Owner='"+user+"' order by DriverID asc ";
   rs4=stmt1.executeQuery(sql4);
%> 
   <tr>
      <td> <font color="maroon" > Driver Id </font> </td>
      <td> <select name="driverid" onChange="showothrdriverid(this);" class="formElement"> <option value="Select">Select</option>

  <%  while(rs4.next())
      { %>
          <option value="<%=rs4.getString("DriverID") %>"> <%=rs4.getString("DriverID") %> </option>
  <%  }
  %>
    <option value="Other">Other </option>
 </select> 
          &nbsp;&nbsp;&nbsp;
          <input type="text" name="othdriverid" class="formElement" style="visibility:hidden" />
    </td>
  </tr>
   <tr>
      <td> <font color="maroon" > Driver Name </font> </td>
      <td> <input type="text" name="drivername" class="formElement" readonly/> </td>
  </tr>

<% 
   usrcode=user.substring(0,2);
   
   /*sql5="select TripId from t_startedjourney where Ownername='"+user+"'  order by TripID desc limit 1 ";
   rs5=stmt1.executeQuery(sql5);
   if(rs5.next())
   {
     lasttripid=rs5.getString("TripId");
   } 
   else	
   {
	lasttripid="001000";

   }
     
    len=lasttripid.length();
     
    idint=lasttripid.substring(2,len); 
    
    maxtripidint=Integer.parseInt(idint)+1;
    nexttripid=usrcode+maxtripidint; */
    
%>
<input type="hidden" name="tripiddup" value="<%=nexttripid %>" />
  <tr>
      <td> <font color="maroon" > Trip Id </font> </td>
      <td> <input type="text" name="tripid" class="formElement" value="" /> </td>
  </tr>
  <tr>
      <td> <font color="maroon" > Arrival Date </font> </td>
      <td> <input type="text" id="calender1" name="calender1" size="13" class="formElement" value="" disabled="true" readonly/>
  
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="button" name="trigger1" id="trigger1" value="Date" class="formElement" disabled="true">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger1"       // ID of the button
             }
                           );
             </script>
    </td>
  </tr>
  <tr> 
      <td> <font color="maroon" > Arrival Time </font> </td>
      <td> <font color="maroon">
            HH :</font> <select name="arrivatime1" class="formElement" disabled="true">
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
             </select> <font color="maroon">
         MM :</font> <select name="arrivatime2" class="formElement" disabled="true">
          
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
               <%
                   for(int i=10;i<=59;i++)
                   {
               %>
                     <option value='<%=i%>'><%=i%></option>
               <%
                   }
               %>
            </select>
       </td>
  </tr>

</table>

<table border="1" width="40%">
  <tr>
      <td> <div align="center"> <input type="submit" name="Submit" value="Submit" class="formElement" /> </div> </td>
  </tr>
</table>
</center> 
   </td> </tr> </table>

<% } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
con1.close();
}
%>


<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>


</form>
</body>
</html>
