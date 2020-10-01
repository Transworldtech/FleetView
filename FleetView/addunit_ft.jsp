<%@ include file="headernew.jsp" %>


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

function showwarcom(layer_ref) {
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
function validate()
{ 
	//alert("in validate function");
	
	 var own= document.unitaddform.owner.value;  
		//alert(own);

		//alert("1111>>>");

		var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";
		var vehmdl=document.getElementById("vehmodel").options[document.getElementById("vehmodel").selectedIndex].innerHTML;
		var vehtype=document.getElementById("vehtype").options[document.getElementById("vehtype").selectedIndex].innerHTML;

		var vehtypenew=document.getElementById("vehtypenew").options[document.getElementById("vehtypenew").selectedIndex].innerHTML;

		var drivermob=document.getElementById("drivermob").value;
		var drivercode=document.getElementById("drivercode").value;
		var drivername=document.getElementById("drivername").value;
		var vehdesc=document.getElementById("vehdesc").value;
   		 var vehreg =document.getElementById("vehreg").value;
   		var toid =document.getElementById("toid").value;
   		var ccid =document.getElementById("ccid").value;
		
	//alert("toid==>"+toid);
	//alert("ccid==>"+ccid);
	//alert("vehtypenew==>"+vehtypenew);
	//alert("drivermob==>"+drivermob);
	//alert("drivercode==>"+drivercode);
	//alert("drivername==>"+drivername);
	//alert("vehdesc==>"+vehdesc);
	
 if(vehreg.length==0)
	     {
	       alert("Please enter vehicle Registration Number");
	       return false;
	     }
 
 
 
 
 vehreg=vehreg.replace(/\s/g, "");

 if(vehreg.length==0)
 {
   alert("Space can not be entered as a value for vehicle Registration Number");
   return false;
 }



	
	if(vehreg.length==0)
	     {
	       alert("Please enter vehicle Registration Number");
	       return false;
	     }




if(vehmdl=="Select")
	     {
	       alert("Please select  Vehicle Model");
	       return false;
	     }
	  if(vehtype=="Select")
	     {
	       alert("Please select  Vehicle Type");
	       return false;
	     }
	  vehdesc=vehdesc.replace(/\s/g, "");
	  if(vehdesc.length==0)
	     {
	       alert("Please enter vehicle Description");
	       return false;
	     }



		  if(vehtypenew.trim()=="Select")
	     {
	       alert("Please select  Vehicle Category");
	       return false;
	     }
	  drivermob=drivermob.replace(/\s/g, "");
	  drivername=drivername.replace(/\s/g, "");
	     


	 
	  

	  if(drivername.length==0)
	     {
	       alert("Please enter Driver name");
	       return false;
	     }

	  if(!(isNaN(drivername)))
	     {
		  alert ("Numbers are  not allowed for Driver Name field");
	       return false;
	     }
	  
//alert(">>>dcode>>"+(isNaN(drivercode)))
	  if((isNaN(drivercode))) 
	     {
	       alert("Please enter Numeric value for  Driver code");
	       return false;
	     }




	  if(drivermob.length==0)
	     {
	       alert("Please enter mobile no ");
	       return false;
	     }

	  if(drivermob.length>13)
	     {
	       alert(" Limit for  mobile no field exceeded ");
	       return false;
	     }

	  for (var i = 0; i < drivermob.length; i++) 
	  {
	  		if (iChars.indexOf(drivermob.charAt(i)) != -1) 
	  	{
	  	  	alert ("Special Characters are not allowed");
	  	  	return false;
	  		}
	  	}

	  if((isNaN(drivermob))) 
	     {
	       alert("Please enter Numeric value for  Driver Mobile no");
	       return false;
	     }



if(toid.length >0)
{
	toid=toid.replace(/\s/g, "");

	 if(toid.length==0)
	 {
	   alert("Space can not be entered as a value for To Id field");
	   return false;
	 }



}
if(ccid.length >0)
{
	ccid=ccid.replace(/\s/g, "");

	 if(ccid.length==0)
	 {
	   alert("Space can not be entered as a value for CC Id field");
	   return false;
	 }



}  
//alert("drivermob>>>toid"+drivermob.length)
	  if(drivermob.length==0)
	     {
	       alert("Please enter mobile no ");
	       return false;
	     }


     // alert("length>>>toid"+toid.length)
     //alert("length>>>ccid"+ccid.length)
	  if(toid.length==0 && ccid.length==0)
	     {
	     //  alert("Please enter mobile no ");
	       return true;
	     } 
	    else
	    {

//alert("inside else superb");


       if(toid.length>0)
       {
    	   //alert("###")
     	   var sss=validateEmailId(toid);

    	   if(!sss)
           {
               alert("Please enter valid Email Id");
               return false;
           } 
     	   
       }
         

       if(ccid.length>0)
       {

    	   //alert("!!")
    	   var sss1=validateEmailId(ccid);
    	   if(!sss1)
           {
               alert("Please enter valid Email Id");
               return false;
           }


    	   
       }


     //  var sss1=validateEmailId(ccid);

	        
	       


	        

	        
            
	    } 

	

		  

 	 
  return true;
 }

function validateEmailId(HODemailAdd)
{
    
//alert("inside validateEmailId>>")
	var splitted = HODemailAdd.match("^(.+)@(.+)$");
    if(splitted == null) return false;
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
        var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
        if(splitted[2].match(regexp_ip) == null) return false;
      }// if
      return true;
    }
return false;
}

function OnChangeOs1(dropdwn)
{
	 var vv1=dropdwn.selectedIndex;
	 
}
function OnChangeFunc1(dropdown)
  {
	  
 var vv1=dropdown.selectedIndex;
 var SelValue1 = dropdown.options[vv1].value;
 
        if(SelValue1=="Other")
        {                           
            window.location = 'newcustadd.jsp';
        }
        else {
           
        
             }
 }      
        

function OnChangeFunc2(dropdown)
  {
 var vv1=dropdown.selectedIndex;
  var SelValue1 = dropdown.options[vv1].value;
 //alert(SelValue1);
 
        if(SelValue1=="Other")
        {
             document.getElementById("othinstloc").style.visibility="visible";
        }      
        else { 
         document.getElementById("othinstloc").style.visibility="hidden";   
         document.unitaddform.othinst.value="";
             }
 }    


function OnChangeChkBx()
{
  
  if(document.unitaddform.instin.checked == false)
  {
   
   document.unitaddform.tme.disabled=true;
   document.unitaddform.tme.value="";
   document.getElementById("nwtme").style.visibility="visible";

   }
  else
  {
    document.unitaddform.tme.disabled=false;
   document.unitaddform.tme.value="5.30";
   document.unitaddform.newtme.value="";
   document.getElementById("nwtme").style.visibility="hidden";
  }
}

function OnChangeFunc3(dropdown)
{


	//alert("i m here");
 var vv1=dropdown.selectedIndex;
 //var SelValue1 = dropdown.options[vv1].value;
 
var trans=document.getElementById("owner").value;

//alert("transpo>>>>>"+trans);
 
 

			
        	 var v2=dropdown.value;
            // alert("drpdwn>>>>"+v2);
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

                               reslt=ajaxRequest.responseText;
                               
                               reslt = reslt.replace(/^\s+|\s+$/g,"");//trim
								//alert(reslt);
                                var mySplitResult = reslt.split("#");

try{
                                 mySplitResult[0] = mySplitResult[0].replace(/^\s+|\s+$/g,"");//trim
                          // alert("******222***>>>"+mySplitResult[0]);
                            // alert("******33333***"+mySplitResult[3]);
                            // alert("****44444*****"+mySplitResult[4]);
                             //alert("******5555555***"+mySplitResult[5]);

        						mySplitResult[1] = mySplitResult[1].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[2] = mySplitResult[2].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[3] = mySplitResult[3].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[4] = mySplitResult[4].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[5] = mySplitResult[5].replace(/^\s+|\s+$/g,"");//trim
                            // document.unitaddform.limit.value=mySplitResult[0];

                              // document.getElementById("ST").value=mySplitResult[1];
                              // document.getElementById("TX").value=mySplitResult[2];
                               //document.getElementById("RA").value=mySplitResult[3];
                              // document.getElementById("RD").value=mySplitResult[4];
                              // document.getElementById("OS").value=mySplitResult[5];
                              // document.getElementById("limit").value=reslt;
     
          		
          		 // alert("22222>>>111111>>"+mySplitResult[0]);

}catch(e)
{

//alert("444>>>>>>e>>"+e);
}

          	          		  
          		   if(mySplitResult[0]=="No")
          		   {
              		   alert("Installations are completed for "+trans +" as per limit");

              		 document.getElementById("vehdesc").value="";
                		   return false;
          		   }
          		  if(mySplitResult[0]=="Yes1")
         		   {
             		   alert("Installations are more than allowed limit for "+trans);
             		  document.getElementById("vehdesc").value="";
               		  return false;
         		   }
          	       } 
                     }
                     
           //alert("END>>>>>of function>");
                    var queryString = "?transporter=" +trans;
          	   ajaxRequest.open("GET", "gettransporterlmt_ft.jsp" + queryString, true);
          	   ajaxRequest.send(null); 

           

}

function AJAXFunc()
{
 // alert("in ajax function");
  var v1=document.unitaddform.uid.value;
 // alert(v1);
  var v2=document.unitaddform.owner.value;
//  alert(v2);
  var v3=document.unitaddform.hiddentransp.value;
 
  //alert(v3);
  
  if(v3!=""||v3!=null)
  {
	owner=v2;
	  }else{
		owner=v3;
		  }
  //alert(owner);

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
                      var mySplitResult = reslt.split("#");
                      var mySplitResult1=  mySplitResult[0]; 
                      var mySplitResult2=  mySplitResult[1];

						// Results from Ajaxunitadd.jsp are put into fields
						mySplitResult[0] = mySplitResult[0].replace(/^\s+|\s+$/g,"");//trim   Mobile No
						mySplitResult[1] = mySplitResult[1].replace(/^\s+|\s+$/g,"");//trim   Sim No
						mySplitResult[2] = mySplitResult[2].replace(/^\s+|\s+$/g,"");//trim   Unit TYpe
						mySplitResult[3] = mySplitResult[3].replace(/^\s+|\s+$/g,"");//trim  Received Status
						mySplitResult[4] = mySplitResult[4].replace(/^\s+|\s+$/g,"");//trim  hold By
						mySplitResult[5] = mySplitResult[5].replace(/^\s+|\s+$/g,"");//trim  software version
						mySplitResult[6] = mySplitResult[6].replace(/^\s+|\s+$/g,"");//trim  FTP Invalide software version
						mySplitResult[7] = mySplitResult[7].replace(/^\s+|\s+$/g,"");//trim   unitid already exists in other vehicle
						mySplitResult[8] = mySplitResult[8].replace(/^\s+|\s+$/g,"");//JRM
						mySplitResult[9] = mySplitResult[9].replace(/^\s+|\s+$/g,"");//trim   Device xxxx can not be installed in a vehicle because it has wrong firmware.
 		      		  document.unitaddform.mobno.value = mySplitResult[0];
                      document.unitaddform.simno.value = mySplitResult[1];
                      document.unitaddform.recby.value = mySplitResult[3];
                      document.unitaddform.holdby.value = mySplitResult[4];
                      document.unitaddform.InstType.value = mySplitResult[2];
                      var swver=mySplitResult[5];
                      var invalide=mySplitResult[6];
                       var available=mySplitResult[7];
                       var isCodeVerValid=mySplitResult[9];
                      //   alert("isCodeVerValid-------------->"+isCodeVerValid);
                     // alert(swver);
						if(
							(((swver.indexOf("AVL_LITE")!=-1)||(swver.indexOf("SIMARM")!=-1))&&(owner.indexOf("Castrol")!=-1))
							||(((swver.indexOf("AVL_LITE")!=-1)||(swver.indexOf("SIMARM")!=-1))&&(owner.indexOf("Praxair")!=-1))
							)
							{
							 	alert("AVL_LITE unit is not allowed in "+owner);
									return false;
                       		}
						if(isCodeVerValid=="No"){
                     		 alert("Device "+v1+" can not be installed in a vehicle because it has wrong firmware.");
                            return false;
                           }
						if(invalide=="Yes"){
							alert("Invalide software version in "+v1);
							return false;
                  		}
                  		 if(available=="Yes"){
                  		 alert("unitid already exists in other vehicle");
                         return false;
                        }
                  		 
 	       } 
            }
            
  
           var queryString = "?unid=" +v1;
 	   ajaxRequest.open("GET", "Ajaxunitadd.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
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


function getVHregNo()
{

//alert("inside ajax vhregno")


var vehreg =document.getElementById("vehreg").value;


//alert("vehreg>>>"+vehreg);


//alert(owner);

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

                               reslt=ajaxRequest.responseText;
                               
                               reslt = reslt.replace(/^\s+|\s+$/g,"");//trim
								//alert(reslt);
                                var mySplitResult = reslt.split("#");

try{
                                 mySplitResult[0] = mySplitResult[0].replace(/^\s+|\s+$/g,"");//trim
                          // alert("******222***>>>"+mySplitResult[0]);
                            // alert("******33333***"+mySplitResult[3]);
                            // alert("****44444*****"+mySplitResult[4]);
                             //alert("******5555555***"+mySplitResult[5]);

        						mySplitResult[1] = mySplitResult[1].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[2] = mySplitResult[2].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[3] = mySplitResult[3].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[4] = mySplitResult[4].replace(/^\s+|\s+$/g,"");//trim
      						mySplitResult[5] = mySplitResult[5].replace(/^\s+|\s+$/g,"");//trim
                            // document.unitaddform.limit.value=mySplitResult[0];

                              // document.getElementById("ST").value=mySplitResult[1];
                              // document.getElementById("TX").value=mySplitResult[2];
                               //document.getElementById("RA").value=mySplitResult[3];
                              // document.getElementById("RD").value=mySplitResult[4];
                              // document.getElementById("OS").value=mySplitResult[5];
                              // document.getElementById("limit").value=reslt;
     
          		
          		 // alert("22222>>>111111>>"+mySplitResult[0]);

}catch(e)
{

//alert("444>>>>>>e>>"+e);
}

          	          		  
//alert("22222>>>111111>>"+mySplitResult[0]);




if(mySplitResult[0]=="Yes")
{
	  alert("VehReg Number already exist");
	  document.getElementById("vehreg").value="";
return false;
}
          	       } 
                     }
                     
           //alert("END>>>>>of function>");
                    var queryString = "?vehregno=" +vehreg;
          	   ajaxRequest.open("GET", "Ajaxgetvhregno.jsp" + queryString, true);
          	   ajaxRequest.send(null); 

           






}





	</script>
</head>

<body id="main_body">
<div id="form_container" style="width: 800px;">

<form name="unitaddform" method="get" action="addutinsrt_ft.jsp"
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
	 
	
	//System.out.println("Creating Connection");
	Class.forName(MM_dbConn_DRIVER);
   // conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
   // System.out.println(">>>2222aaaaa ");
   conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
   
   // System.out.println(">>>2222bbbb ");
    st=conn1.createStatement();
   // System.out.println(">>>2222cccc ");
	st1=conn1.createStatement();
	
	 //  System.out.println(">>>2222ddd ");
    st2=conn1.createStatement();
    st3=conn1.createStatement();
    st4=conn1.createStatement();
    Statement stmt2 = conn1.createStatement();
    Statement stmt7 = conn1.createStatement();
    Statement stmt8 = conn1.createStatement();
   // System.out.println(">>>2222 ");
    String transporter = (String)session.getAttribute("usertypevalue");
		
		
//    System.out.println(">>>2222 transporter==>"+transporter);
		

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
		
String duplicate="";
duplicate=request.getParameter("duplicate");

System.out.println(">>>2222  duplicate==>"+duplicate);


if(duplicate!=null)
{
	
	%>
	<script language="javascript">
	//alert("VehReg No already exist");
   // window.location="addunit_ft.jsp";
	
	   
	</script>
	
<%	
	
}

		
		
		
		
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
	Vehicle Successfuly Added  </B></font></div>
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
	 </b></font></div>
	</td>
</tr>
</table>

<%
}
%>			




<br></br>


<table border="0" width="770px" bgcolor="" align="center">
	<tr bgcolor=""><td align="center"><font color="#2A0A12" size="3"><h1 align="center">Unit Addition</h1></font></td></tr>
</table>
<table border="0" width="770px" bgcolor="" align="center"  cellspacing="10">
	<tr bgcolor="">
		<td ><b>Transporter:</b></td>
		<td >
			<input type="text" class="element text medium" name="owner" id="owner" value='<%=transporter%>'
			class="formElement" readonly />
			<input type="hidden" name="instruction" class="formElement" value="<%=Instruction%>"/>
		</td>
		<td><b>* Vehicle Reg. No.:</b></td>
		<td><input type="text" class="element text medium" name="vehreg"    id="vehreg" class="formElement" onchange="return getVHregNo();" > </td>
	</tr>
	<tr bgcolor="">
			<td><font color="" ><b>* Vehicle Model</b></font></td>
			<td>
				<select class="element select medium" name="vehmodel" id="vehmodel"  class="formElement" >
        			 <option value="Select">Select</option>
       				 <option value="TATA" >TATA</option>
        			 <option value="ASHOK LEYLAND" >ASHOK LEYLAND</option>
       				 <option value="EICHER" >EICHER</option>
					 <option value="VOLVO" >VOLVO</option>
  	   			 </select>
			</td>	
			<td><font color="" ><b>* Vehicle Type</b></font></td>
			<td>
				<select  class="element select medium" name="vehtype"  id="vehtype" class="formElement" >
         			<option value="Select">Select</option>
       				<option value="AC" >AC</option>
       				<option value="NONAC" >NON AC</option>
  	           </select>
			</td>
		</tr>
		<tr bgcolor="">
			<td><b>* Vehicle Desc</b></td>
 			<td> <input type="text"   class="element select medium" onchange="OnChangeFunc3(this);"  style="width:8em; "  name="vehdesc" id="vehdesc" /></td>
 			
 		
 			<td><font color="" ><b>* Vehicle Category: </b></font></td>
			<td><select  class="element select medium" name="vehtypenew"  id="vehtypenew" class="formElement">
 				<option value="Select"> Select </option>
<% 
				sql="select distinct(VehType) as vehtype from db_gps.t_vehtypmaster  order by VehType asc" ;
   				
              System.out.println("sql in veh BEFORE type>>>>"+sql);
           ResultSet rst33=st.executeQuery(sql);
   				System.out.println("sql in veh type>>>>"+sql);
   				
   				
   			    while(rst33.next())
			    { 
%>
     			<option value="<%=rst33.getString("vehtype") %>"> <%=rst33.getString("vehtype") %> </option>
<%  } %>
     			
        		</select> 
			</td>
 			
 			
 			
		</tr>

		
	
	<!-- When Voice Call will be selected, two text boxes will get appeared to enter two Mobile No's which is mandatory-->
	
	
	
		
	
<tr bgcolor="">
		<td><b>* Driver Name:</b></td>
		<td><input type="text" class="element select medium" name="drivername" id="drivername" class="formElement" /></td>
		<td><b>* Driver Code:</b></td>
		<td><input type="text" class="element select medium" name="drivercode"  id="drivercode" class="formElement" /></td>
	</tr>
	<tr bgcolor="">
		<td colspan="4" align="center"><b>* Driver Mob. No.:</b>&nbsp;&nbsp; <input
			type="text" class="element select medium" name="drivermob" id="drivermob" style="width:190px " /></td>
	</tr>
	
	<tr bgcolor="">
		  <td colspan="4" align="center" class="element select medium" > <font color="" > <b> To(enter comma seperated mail id):</b> </font> &nbsp;&nbsp;
				<textarea rows="1" cols="70" name="to"  id="toid" class="formElement"></textarea> </td>
		</tr>
		<tr bgcolor="">
		  <td colspan="4" align="center" class="element select medium" > <font color="" > <b> CC(enter comma seperated mail id):</b> </font> &nbsp;&nbsp;
				<textarea rows="1" cols="70" name="cc" id="ccid"  class="formElement"></textarea> </td>
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

<%@ include file="footer.jsp" %>


</body>
</html>
