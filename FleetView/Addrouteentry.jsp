<%@ include file="headernew.jsp"%>               

	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Route Management</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript">
function validate() 
{try
{
	
//	alert("Validations for StartCode>");
	var StartCode=document.getElementById("StartCode").value;
	//alert(StartCode);	
	if(StartCode=="" || StartCode==null)
	{
		alert("You cant left Origincode empty,So please fill the Origincode field");
		return false;
	}
	
    var startlen=StartCode.length;
  //  alert(startlen);
	StartCode=StartCode.replace(/\s/g, "");
	var newstartlen=StartCode.length;
//	alert(newstartlen);
	if(newstartlen.length=0)
	{

		alert("Space can not be entered as a value");
	  	return false;

	}
	
	if(startlen!=newstartlen)
	{
		alert("Please enter valid Origin code");
		return false;
	}
	if(newstartlen > 30)
	{
		alert ("Limit exceeded for Origin field ");
	  	return false;

	}

	var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";
	StartCode=StartCode.replace(/\s/g, "");
	
	for (var i = 0; i < StartCode.length; i++) 
	{
			if (iChars.indexOf(StartCode.charAt(i)) != -1) 
		{
		  	alert ("Special Characters are not allowed");
		  	return false;
			}
		}
//**************Validations for Start place***************//	
var startplace=document.getElementById("StartPlace").value;
if(startplace=="" || startplace==null)
{
	alert("You cant left origin place empty,So please fill the origin field");
	return false;
}
//alert(startplace);
var startplacelen=startplace.length;
//alert(startplacelen);
startplace=startplace.replace(/\s/g, "");
var newstartplacelen=startplace.length;
//alert(newstartplacelen);
if(newstartplacelen==0)
{
	alert("Space can't be allowed as a value for origin place");
	return false;
}



//**************************validations for destination code****************//
var EndCode=document.getElementById("EndCode").value;
//alert(EndCode);
if(EndCode=="" || EndCode==null)
{
	alert("You cant left Destinationcode empty,So please fill the Destinationcode field");
	return false;
}
var endlen=EndCode.length;

EndCode=EndCode.replace(/\s/g, "");

var newendlen=EndCode.length;


if(endlen!=newendlen)
{
	alert("please enter valid Destination code");
	return false;
}
var invalid=/[^A-Za-z\s]/;

/*	if(invalid.test(startplace)){
    alert('Please enter characters value for Origin ');  
    return false;
}*/

if(StartCode==EndCode)
{
	alert("Origin code and destination code should be different");
	return false;
}


if(EndCode.length > 30)
{
	alert ("Limit exceeded for field ");
  	return false;

}

if(EndCode.length==0)
{

	alert ("Space can not be entered as a value");
  	return false;

}

for (var i = 0; i < EndCode.length; i++) 
{
		if (iChars.indexOf(EndCode.charAt(i)) != -1) 
	{
	  	alert ("Special Characters are not allowed");
	  	return false;
		}
	}

//*********************Validations for Destination place************//
var endplace=document.getElementById("EndPlace").value;
if(endplace=="" || endplace==null)
{
	alert("You cant left destination place empty,So please fill the destination field");
	return false;
}
var invalid=/[^A-Za-z\s]/;

/*if(invalid.test(endplace)){
    alert('Please enter characters value for Destination ');  
    return false;
}*/
var endplacelen=endplace.length;
//alert(startplacelen);
endplace=endplace.replace(/\s/g, "");
var newendplacelen=endplace.length;
//alert(newstartplacelen);
if(newendplacelen==0)
{
	alert("Space can't be allowed as a value for destination place");
	return false;
}

/////////////////////Valiadtions for zone//////////////////////
	var originzone=document.getElementById("originzone").value;
	var destizone=document.getElementById("Destizone").value;
  //   alert(originzone);
  //   alert(destizone);
       if(originzone=="Select")
       {
           alert("Please enter the Origin zone/branch");
           return false;
       }
   	
	if(destizone=="Select")
    {
        alert("Please enter the Dest zone/branch");
        return false;
    }
//*********************validation for time*******************8
//	alert("------------------->");
	var abc=document.cleanermgt.TTime.value;
	
//	alert(abc);
if(abc=="" || abc==null)
	{
		alert("You cant left Standardtime field  empty,So please fill the Standardtime field");
		return false;
	}

var abclen=abc.length;
//alert(startplacelen);
abc=abc.replace(/\s/g, "");
var newabclen=abc.length;
//alert(newabclen);
if(newabclen==0)
{
	alert("Space can't be allowed as a value for Standardtime Field");
	return false;
}
	
//*************8validations for standardkm******************//	
var Km=document.getElementById("Km").value;
var fuelKm=document.getElementById("fuelKm").value;
var Tdays=document.cleanermgt.Tdays.value;
//alert(Km);
if(Tdays=="" || Tdays==null)
{
	alert("You cant left Transit Days field  empty,So please fill the TransitDay field");
	return false;
}

if(fuelKm=="" || fuelKm==null)
{
	alert("You cant left FuelApprovedkm field  empty,So please fill the FuelApprovedkm field");
	return false;
}
if(Km=="" || Km==null)
{
	alert("You cant left Standardkm field  empty,So please fill the Standardkm field");
	return false;
}

var Kmlen=Km.length;
var fuelKmlen=fuelKm.length;
//alert(startplacelen);
Km=Km.replace(/\s/g, "");

var newKmlen=Km.length;
//alert(newKmlen)

if(newKmlen==0)
{
	alert("Space can't be allowed as value for Standardkm");
	return false;
}
//alert("33333333333333333333");
//alert("----------------->"+Km);
var kmnew=Km.split(".");
//alert(kmnew[0]);
//alert(kmnew[1]);
var kmnewlen=kmnew[1].length;
//alert(kmnewlen);
if(kmnewlen >2)
{
	alert("Only two digits are allowed after decimal");
	return false;
}


}
catch(e)
{
	//alert(e);
}

return true;
}

function upload()
{
	var name1= document.getElementById("Filename1").value;
	 //alert(name1);
	 	var valid_extensions = /(.kml)$/i;
	  if(valid_extensions.test(name1))
	  {
	  document.getElementById("Filename1").style.display="none";
	  document.getElementById("f1").innerHTML=name1;
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=name1;
	  document.getElementById("remove1").style.display="";
	  }
	  else{
		  alert("Please upload only kml formatted file");
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

function cktripid()
{

	combination();
	var StartCode=document.getElementById("StartCode").value;
	//alert(StartCode);
	var EndCode=document.getElementById("EndCode").value;
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
		
		var result1;
		result1=reslt;

		result1=result1.replace(/^\s+|\s+$/g,'');
        //alert(result1);
        if(result1=='Yes')
        {
            alert("Startcode and endcode Already Exist");
            document.getElementById("EndCode").value="";
            
        }
        
       
        
		}catch(e)
		{
		//alert(e);
		}
	} 
};
 
var queryString = "?StartCod="+StartCode+"&endcod="+EndCode+"";
ajaxRequest.open("post", "route_AjaxData.jsp" + queryString, true);
ajaxRequest.send(null); 



}
	function combination()
	{
     // alert("*********************************");
      var StartCode=document.getElementById("StartCode").value;
  	 //  alert(StartCode);
    	var EndCode=document.getElementById("EndCode").value;
    //	alert(EndCode);
  	   var addboth= StartCode+"-"+EndCode;
  	//  alert(addboth);
      var routecode=document.getElementById("Routecode").value=addboth;
   
	}
	
	 




</script>
</head>
<%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
Statement st,st1,st2;
%>

<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st1=conn1.createStatement();
st2=conn1.createStatement();
st=conn.createStatement();

String 	username="";
username=(String)session.getAttribute("usertypevalue");
String Save=request.getParameter("Parameter");
System.out.println("Parameter  "  +Save);
if(Save!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Added Successfully");
	window.location("Reportfornewroute.jsp");
	</script>
	<%
}

%>





<body>
<form id="cleanermgt" name="cleanermgt" action="entrynewroute.jsp" method="post" enctype="multipart/form-data" onsubmit="return validate();">
<img id="top" src="newimages/top.png" alt="" style="width: 550px;">
	<div id="form_container" style="width: 550px;"style=" margin-left: 100px;" >
	
		<h1 align="center">Route Entry Form</h1>
		<br>
<!--		<table border="0" width="90%" align="center">-->
<!--					 <tr><td><font face="Arial" size="2" ><a href="editroute.jsp?clean=true">Edit</a> </font>-->
<!--					 </td><td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
<!--					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>-->
<!--					 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" >(<font color="red"> *</font> indicates mandatory fields)</font></td>-->
<!--					 </tr>-->
<!--							-->
<!--					 -->
<!--					 -->
<!--					 </table>-->
<!--					-->
		<td align="right"><div align="right" ><font color="red" size="2">*</font>Indicates Mandatory fields&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td>			
<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">

				<br>

			<table border="0" align="center" cellpadding="0" cellspacing="0" style=" margin-left: 100px;" >
					 <tr>
           <td align="left"><div align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"> <b>Origin Code:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <input type="text" class="element text medium" style="width: 180px;" name="StartCode" id="StartCode" onchange="cktripid();" />&nbsp;</div></td>
           </tr>
					 <tr>
           <td align="left"><div align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"> <b>Origin:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium" style="width: 180px;" name="StartPlace" id="StartPlace" />&nbsp;</div></td>
           </tr>
	       
	       <tr>
           <td align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Destination Code:-</b></font>&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="EndCode" id="EndCode" value="" onchange="cktripid();"  />&nbsp;</td>
           </tr>
            <tr>
           <td align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Route Code:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="Routecode" id="Routecode" value=""  />&nbsp;</td>
           </tr>
         <tr>
           <td align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Destination:-</b></font>&nbsp;
          <input type="text" class="element text medium"   style="width: 180px;" name="EndPlace" id="EndPlace" value="" />&nbsp;</td>
           </tr>
            <tr>
           <td id="tdvh" align="left" style="display: "><br></br>
	       <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">Origin zone/branch:-<select name="originzone" id="originzone" class="element select medium" style="width: 185px">
			<option value="Select">--Select--</option>
			<%
			String sqlnew="select * from db_gps.t_routezones where owner='"+username+"'";
			ResultSet rsnew=st1.executeQuery(sqlnew);
			System.out.println("zone querry-------->"  +sqlnew);
			while(rsnew.next())
			{
				out.println(rsnew.getString("Zone"));
				%>
				<option value="<%=rsnew.getString("Zone")%>"><%=rsnew.getString("Zone")%></option>
				<% 
			}
	            		
			%>	
         	</select></font></b></td>
           </tr>
           <tr>
           <td id="tdvh" align="left" style="display: "><br></br>
	       <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">Dest zone/branch:-&nbsp;&nbsp;<select name="Destizone" id="Destizone" class="element select medium" style="width: 185px">
			<option value="Select">--Select--</option>
			<%
			String sqlnew1="select * from db_gps.t_routezones where owner='"+username+"'";
			ResultSet rsnew1=st1.executeQuery(sqlnew1);
			System.out.println("zone querry-------->"  +sqlnew1);
			while(rsnew1.next())
			{
				out.println(rsnew1.getString("Zone"));
				%>
				<option value="<%=rsnew1.getString("Zone")%>"><%=rsnew1.getString("Zone")%></option>
				<% 
			}
	            		
			%>	
         	</select></font></b></td>
           </tr>
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Standard KM:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="Km" id="Km" value=""  />&nbsp;</td>
           </tr>
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>FuelApproved KM:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="fuelKm" id="fuelKm" value=""  />&nbsp;</td>
           </tr>
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Transit Days:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium" style="width: 180px;" name="Tdays" id="Tdays" value=""   />&nbsp;</td>
           </tr>
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Standard Time:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium" style="width: 180px;" name="TTime" id="TTime" value=""   />&nbsp;In HH</td>
           </tr>
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font  size="2"> <b>Route Kml File:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!--          <input type="text" class="element text medium"  style="width: 180px;" name="File" id="File" value=""  />&nbsp;</td>-->

        
<input type="file" cols="40" name="Filename1" id="Filename1" value="" onchange="upload();" style="background-image: newimages/browse.jpg"/>
<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
&nbsp;&nbsp;<a href="#" onclick="remove();" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		      </td>	</td>
           </tr>
          
           <tr></tr>
	<tr align="center">
	<td  colspan="2" ><br></br><div  align="center">
	<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black"  class="formElement"></div></td>
	</tr>
	      
</table>

</div>
</div>

</form>






</body>
</html>
<%@ include file="footernew.jsp"%>