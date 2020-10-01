<%@ include file="headernew.jsp"%>               

	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cleaner Management</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript">
function validate() 
{try
{
	var fuelkm=document.getElementById("fuelkm").value;
	var invalid=/^[0-9]+$/; 
	if(!invalid.test(fuelkm))
	{
		alert("Please Enter Numeric Value For FuelApprovedKm");
		return false;
	}
	
	
	var tdays=document.getElementById("tdays").value;
	var invalid=/^[0-9]+$/; 
	if(!invalid.test(tdays))
	{
		alert("Please Enter Numeric Value For Transit Days");
		return false;
	}
	
	
	
	//alert("-----111111---------------------------->");
	var StartCode=document.getElementById("StartCode1").value;
	if(StartCode=="" || StartCode==null)
	{
		alert("You cant left Origincode empty,So please fill the Origincode field");
		return false;
	}
	
	var EndCode=document.getElementById("EndCode1").value;
	//alert(StartCode);
	var startlen=StartCode.length;
	var endlen=EndCode.length;
	StartCode=StartCode.replace(/\s/g, "");
	EndCode=EndCode.replace(/\s/g, "");
	var newstartlen=StartCode.length;
	var newendlen=EndCode.length;

	if(startlen.length==0)
	{
		alert("Please enter valid Origin code");
		return false;
	}

	if(endlen.length==0)
	{
		alert("please enter valid Destination code");
		return false;
	}
	
	//var cleanename=document.cleanermgt.cleanername.value;
	var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";
	StartCode=StartCode.replace(/\s/g, "");
	
	if(StartCode.length > 50)
	{
		alert ("Limit exceeded for field ");
	  	return false;

	}

	if(StartCode.length==0)
	{

		alert ("Space can not be entered as a value");
	  	return false;

	}

	for (var i = 0; i < StartCode.length; i++) 
	{
			if (iChars.indexOf(StartCode.charAt(i)) != -1) 
		{
		  	alert ("Special Characters are not allowed");
		  	return false;
			}
		}
	
	if(StartCode==EndCode)
	{
		alert("Origin code and destination code should be different");
		return false;
	} 	
	
//alert("------------------------>");
	var startplace=document.getElementById("StartPlace1").value;
	var invalid=/[^A-Za-z\s]/;

/*	if(invalid.test(startplace)){
	    alert('Please enter characters value for Origin ');  
	    return false;
	}*/
  //  alert(startplace);
	if(startplace=="" || startplace==null)
	{
		alert("You cant left origin place empty,So please fill the origin field");
		return false;
	}

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

	
	
	
	if(EndCode=="" || EndCode==null)
	{
		alert("You cant left DestinationCode  empty,So please fill the DestinationCode field");
		return false;
	}

	if(EndCode.length > 50)
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


	var originzone=document.getElementById("originzone").value;
	var destizone=document.getElementById("Destizone").value;
    // alert(originzone);
   //  alert(destizone);
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
var endplace=document.getElementById("EndPlace1").value;
var invalid=/[^A-Za-z\s]/;

/*if(invalid.test(endplace)){
    alert('Please enter characters value for Destination ');  
    return false;
}*/
if(endplace=="" || endplace==null)
{
	alert("You cant left destination place empty,So please fill the destination field");
	return false;
}

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

var TTime=document.getElementById("TTime1").value;
if(TTime=="" || TTime==null)
{
	alert("You cant left Standardtime field  empty,So please fill the Standardtime field");
	return false;
}
var TTimelen=TTime.length;
//alert(startplacelen);
TTime=TTime.replace(/\s/g, "");
var newTTimelen=TTime.length;
//alert(newTTimelen);
if(newTTimelen==0)
{
	alert("Space can't be allowed as a value for Standardtime Field");
	return false;
}

var Km=document.getElementById("Km1").value;
if(Km=="" || Km==null)
{
	alert("You cant left Standardkm field  empty,So please fill the Standardkm field");
	return false;
}
var Kmlen=Km.length;
//alert(startplacelen);
Km=Km.replace(/\s/g, "");
var newKmlen=Km.length;
//alert(newKmlen)

if(newKmlen==0)
{
	alert("Space can't be allowed as value for Standardkm");
	return false;
}

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
//alert("end of vld");

//cktripid1();
}
function upload()
{
	var name1= document.getElementById("Filename11").value;
///	 alert(name1);
	 	var valid_extensions = /(.kml)$/i;
	  if(valid_extensions.test(name1))
	  {
	  document.getElementById("Filename11").style.display="none";
	  document.getElementById("f1").innerHTML=name1;
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=name1;
	  document.getElementById("remove1").style.display="";
	  }
	  else{
		  alert("Please upload only kml formatted file");
			document.getElementById("Filename11").value="";
			  
	  }
}
function remove()
{
		document.getElementById("f1").innerHTML="";
		document.getElementById("f1").style.display="none";
		document.getElementById("remove1").style.display="none";
		document.getElementById("Filename11").value="";
		document.getElementById("f6").value="";
		document.getElementById("Filename11").style.display="";
	}

function combination()
{
//  alert("*********************************");
  var StartCode=document.getElementById("StartCode1").value;
//	   alert(StartCode);
	var EndCode=document.getElementById("EndCode1").value;
//	alert(EndCode);
	   var addboth= StartCode+"-"+EndCode;
//	  alert(addboth);
  var routecode=document.getElementById("oldroutecode").value=addboth;

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
//String Save=request.getParameter("Parameter");
System.out.println(username);
    String  StartCodeold=request.getParameter("StartCode");
	System.out.println(StartCodeold);
	String StartPlace=request.getParameter("StartPlace");
	System.out.println(StartPlace);
	String EndCodeold=request.getParameter("EndCode");
	System.out.println(EndCodeold);
	String EndPlace=request.getParameter("EndPlace");
	System.out.println(EndPlace);
	String Km=request.getParameter("Km");
	System.out.println(Km);
	String TTime=request.getParameter("TTime");
	System.out.println(TTime);
	
	String kmlfile=request.getParameter("kmlfile");
	System.out.println(kmlfile);
	String routecode=request.getParameter("routecode");
	System.out.println(routecode);
	String StartLocationZone=request.getParameter("StartLocationZone");
	String EndLocationZone=request.getParameter("EndLocationZone");
	
	String fuelKm=request.getParameter("fuelKm");
	System.out.println(fuelKm);
	
	
	String Tdays=request.getParameter("Tdays");
	System.out.println(Tdays);
	
	
	String rid=request.getParameter("rid");
	System.out.println(rid);
	
	
	
	
	
	
%>





<body>
<form id="cleanermgt" name="cleanermgt" action="updatenewroute.jsp" method="post" enctype="multipart/form-data"  onsubmit="return validate();">
<input type="hidden" name="castrolroute" id="castrolroute" value="<%=StartCodeold %>"></input>
<input type="hidden" name="castrolroute1" id="castrolroute1" value="<%=EndCodeold %>"></input>
<input type="hidden" name="castrolroute2" id="castrolroute2" value="<%=kmlfile %>"></input>
<input type="hidden" name="castrolroute3" id="castrolroute3" value="<%=routecode %>"></input>
<input type="hidden" name="rid" id="rid" value="<%=rid %>"></input>
<input type="hidden" name="fuelKm" id="fuelKm" value="<%=fuelKm %>"></input>
<input type="hidden" name="Tdays" id="Tdays" value="<%=Tdays %>"></input>

<img id="top" src="newimages/top.png" alt="" style="width: 550px;">
	<div id="form_container" style="width: 550px;">
	
		<h1 align="center">Edit Route Entry Form</h1>
		<br>
		
	<td align="right"><div align="right" ><font color="red" size="2">*</font>Indicates Mandatory fields&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td>							
				
<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
				<br>
			<table border="0" align="center">
					 <tr>
           <td align="left"><div align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"> <b>Origin Code:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <input type="text" class="element text medium" style="width: 180px;" name="StartCode1" id="StartCode1" value="<%= StartCodeold%>" onchange="combination();"/>&nbsp;</div></td>
           </tr>
					 <tr>
           <td align="left"><div align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"> <b>Origin Place:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium" style="width: 180px;" name="StartPlace1" id="StartPlace1" value="<%=StartPlace %>"/>&nbsp;</div></td>
           </tr>
	       
	       <tr>
           <td align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Destination Code:-</b></font>&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="EndCode1" id="EndCode1" value="<%=EndCodeold%>" onchange="combination();"  />&nbsp;</td>
           </tr>
           <tr>
           <td align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Routecode:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"   style="width: 180px;" name="oldroutecode" id="oldroutecode" value="<%=routecode %>" />&nbsp;</td>
           </tr>
         <tr>
           <td align="left"><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Destination Place:-</b></font>&nbsp;
          <input type="text" class="element text medium"   style="width: 180px;" name="EndPlace1" id="EndPlace1" value="<%=EndPlace %>" />&nbsp;</td>
           </tr>
           <tr>
           <td id="tdvh" style="display: "><br></br>
	       <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">Origin zone/branch:-<select name="originzone" id="originzone" class="element select medium"  style="width: 185px">
			<option value="<%=StartLocationZone %>"><%=StartLocationZone%></option>
			<%
			String sqlnew="select * from db_gps.t_routezones where owner='"+username+"'";
			ResultSet rsnew=st.executeQuery(sqlnew);
			System.out.println("zone querry-------->"  +sqlnew);
			while(rsnew.next())
			{
				out.println(rsnew.getString("Zone"));
				if(StartLocationZone.equalsIgnoreCase(rsnew.getString("Zone")))
				{
					
				}
				else
				{
				%>
				<option value="<%=rsnew.getString("Zone")%>"><%=rsnew.getString("Zone")%></option>
				<% 
				}
			}
	            		
			%>	
         	</select></font></b></td>
           </tr>
           <tr>
           <td id="tdvh" style="display: "><br></br>
	       <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="2">Dest zone/branch:-&nbsp;&nbsp;<select name="Destizone" id="Destizone" class="element select medium" style="width: 185px">
			<option value="<%=EndLocationZone %>"><%=EndLocationZone %></option>
			<%
			
			String sqlnew1="select * from db_gps.t_routezones where owner='"+username+"'";
			ResultSet rsnew1=st1.executeQuery(sqlnew1);
			System.out.println("zone querry-------->"  +sqlnew1);
			while(rsnew1.next())
			{
				out.println(rsnew1.getString("Zone"));
				if(EndLocationZone.equalsIgnoreCase(rsnew1.getString("Zone")))
				{
					
				}
				else
				{
				%>
				
				<option value="<%=rsnew1.getString("Zone")%>"><%=rsnew1.getString("Zone")%></option>
				<% 
				}
			}
	            		
			%>	
         	</select></font></b></td>
           </tr>
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Standard KM:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="Km1" id="Km1" value="<%=Km%>"  />&nbsp;</td>
           </tr>
           
           
           
           
              <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>FuelApproved KM:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="fuelkm1" id="fuelkm1" value="<%=fuelKm%>"  />&nbsp;</td>
           </tr>
           
           
              <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Transit Days:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium"  style="width: 180px;" name="tdays1" id="tdays1" value="<%=Tdays%>"  />&nbsp;</td>
           </tr>
           
           
           
           
           
           
           
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2">*</font><font  size="2"><b>Standard Time:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" class="element text medium" style="width: 180px;" name="TTime1" id="TTime1" value="<%=TTime %>"   />&nbsp;</td>
           </tr>
            <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" size="2"></font><font  size="2"><b>Old Kml File:-</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text"  style="width: 180px;" name="kmlfile" id="kmlfile" readonly="readonly"  value="<%=kmlfile %>" />&nbsp;</td>
           </tr>
           
           
           <tr>
           <td><br></br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font  size="2"> <b>NewRoute Kml File:-</b></font>
<!--          <input type="text" class="element text medium"  style="width: 180px;" name="File" id="File" value=""  />&nbsp;</td>-->

        
<input type="file" cols="30" name="Filename11" id="Filename11"  onchange="upload();" style="background-image: newimages/browse.jpg"/>
<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
&nbsp;&nbsp;<a href="#" onclick="remove();" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		      </td>
           </tr>
          
           
           
	<tr align="center">
	<td  colspan="2" ><br></br><div  align="center">
	<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black"  class="formElement" ></div></td>
	</tr>
	      
</table>
</div>
</div>

</form>

</body>
</html>
<%@ include file="footernew.jsp"%>