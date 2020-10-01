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

<style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse;background:}</style>
<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
<link rel="stylesheet" href="css/css.css" type="text/css"
	charset="utf-8" />
	
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">	
<script src="sorttable.js" type="text/javascript"></script>
<style type="text/css">


</style>


<script language="javascript">

function selected(j)
{
//alert("hi>11111>>>>"+j);

var a="",b="";
//var j=0;

try{
a= document.getElementById("gpnm"+j).innerHTML;

//alert(">>before>>"+document.getElementById("gpnm1"+j).value);
document.getElementById("gpnm1"+j).value=a;

//alert(">>after>>"+document.getElementById("gpnm1"+j).value);
//b=a;
//alert(">>!111>>>"+a+">>22..>>"+b);


//a.style.display="none";
//b.style.display="block";

//alert(">>%%>>"+document.getElementById("gpnm"+j).innerHTML);


}catch(e)
{
alert(e);
}

}

function addUser() {
	try
	{
	//alert("HIiiii>>>add");
    var src = document.addgrp.resources;
    var dest = document.addgrp.assigned;
 
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
	catch(e)
	{
		alert(e);
	}
}

function removeUser() {


 // alert("remove>>>");
    var src =document.addgrp.assigned;
    var dest =  document.addgrp.resources;
 
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

function AJAXFunc1(j)
{
	//alert(">>>inside>>>");
//alert(">>"+j);
/**
try{	
var check = document.getElementById('Section');

alert(">>>chk>>&&"+check);

if(check.style.display == 'none')
{
	alert("inside")
check.style.display='inline';
}
else
{
alert("else")
	check.style.display='none';
}	
	
}catch(e)
{
alert(e);
}
	
**/	
try{
	  var v1=document.getElementById("gpnm"+j).innerHTML;
  //alert(">>>v1>>>"+v1);
  v1=v1.replace("<b> ","").replace("</b> ","");
 // alert(">>v1>>"+v1);

}catch(e)
{
alert(e);
}
  //var owner=document.repunitform.owner.value;
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
                     
                     // alert(">>%%mySplitResult%>>"+mySplitResult);

                      //var mySplitResult1=  mySplitResult[0].replace(/^\s+|\s+$/g,"");//Mobile Number

                     // alert(">>%%%>>"+mySplitResult1);
                      
                      document.getElementById("tbvl").innerHTML=mySplitResult;
                     

					 //alert(">>222>>>")
					  
					  
					  // alert(">>%%%>>"+mySplitResult2+">>>33>>"+mySplitResult3);
 		            

                     // alert(">>>.HI>111>>"+document.repunitform.InstType.value);
                      document.repunitform.tbvl.value = mySplitResult9;
                     // document.repunitform.recby.value = mySplitResult5;
                   //   alert(">>"+mySplitResult1);
                      
                      //alert("software version is"+swver);
      				
      					
                  		

                  	 // alert("end-1-1>>")
                  		
 	       }
            }
           // alert("end>>")
  
           var queryString = "?gpnm=" +v1;
 	   ajaxRequest.open("GET", "Ajaxgpnm.jsp" + queryString, true);
 	   ajaxRequest.send(null); 
}
 
function validate()
{
	//alert("in validate function")
	
	
	//var jrm=document.repunitform.jrm.value;
	//alert(jrm);

try
{
//alert("HIiiii");


var dest =  document.addgrp.assigned;
var dest1 = document.addgrp.assigned1;


if(dest.length == 0)
{
	alert("Please select the vehicle to add into group  ");
	
	return false;
}


for(var count=0; count < dest.options.length; count++) {

   
            var option = dest.options[count];

            var newOption = document.createElement("option");
            newOption.value = option.value;
            newOption.text = option.text;
            newOption.selected = true;
            try {
                     dest1.add(newOption, null); //Standard
                     dest.remove(count, null);
             }catch(error) {
                     dest1.add(newOption); // IE only
                     dest.remove(count);
             }
            count--;

          //  alert(">>end>>");
}
}
catch(e)
{
	//alert(e);
}
	
	 
}

function reload()
{
alert("hi>>>>>>")
	try{
	var a="";
a=document.getElementById("grpname").value;

alert(">>grpr>>"+a)
var updt="ak";
	window.location ="addgrp.jsp?updt="+updt+"&grpname="+a;

	}catch(e){
alert(e);
	}
	}

	</script>
</head>

<body id="main_body">
<div id="form_container" style="width: 700px;height:325px ">

<form name="addgrp" method="get" action="insertgrp.jsp"
	onsubmit="return validate();">

<div class="form_container" style="text-align: center;">

<div width="100%" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;height:300px; ">
<table border="0" width="100%" align="center">
<tr align="center">
<td align="center">
<%
	try {
		
		
		System.out.println("=====1111=========");
		
		//vid = request.getParameter("vid");
		//System.out.println("=====vid========="+vid);
	
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
  
    
    String done = request.getParameter("updt");
	System.out.println(">>>2222 done1"+done);
    
    System.out.println(">>>2222 ");
		
		
		
		
		

		String userrole = (String)session.getAttribute("mainuser");

		String typeval = (String)session.getAttribute("TYPEVALUEUSER");
		
		 System.out.println(">>>2222   11");
		String email = "", unid = "", status = "", owner = "",Instruction="";

		java.util.Date dte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(dte);
		
		
		String  tid="";

		String cat="";
		


	String gpnm=""; 
	int  ak=0;

		
	String grpnm="";
	 grpnm = request.getParameter("grpname");
		
		

		System.out.println(">>>2222 FINAL grpnm 11"+grpnm);
		
		

 if(done!=null)	
 {
	 if(done.equalsIgnoreCase("yes")){
	 
%>
<script type="text/javascript">

//alert("Successfully Added");
//var updt="ak";
//window.location ="addgrp.jsp?updt="+updt;

//reload();
</script>



<%
//response.sendRedirect("addgrp.jsp?updt=ak&grpname="+grpnm);
	 }
	
 }
 
 
 //
 
 System.out.println(">>>2222  BELOW ALERT>>>");
%>			




<br></br>
<%
if(done!=null)
{
%>	
	
<table border="0" width="600px" bgcolor="" align="center">
	<tr bgcolor=""><td align="center"><font color="red" style="width:5px "  ><blink> Vehicle Added  Successfully</blink> </font></td></tr>
</table>	
	
<%}

%>
	


<table border="0" width="600px" bgcolor="" align="center">
	<tr bgcolor=""><td align="center"><font color="#2A0A12" size="3"><h3 align="center">Add Vehicles to Group <%=grpnm %></h3></font></td></tr>
</table>
<br></br>
<table border="0" width="550px"  align="center" cellpadding="10" cellspacing="5" style="font:13px arial,sans-serif;border-collapse: collapse;">
<tr style="height:30px">

<td align="center"><b><font size="2">Vehicle Available </font> </b> </td>

<td align="center"><b><font size="2"> </font> </b> </td>
<td align="center"><b><font size="2">  Selected Vehicle </font> </b></td>
</tr>
<tr>

<td valign="top" >
					<br>
					<select name="resources" style="width:200px" size="8" id="resources" multiple="multiple">


<%
 int j=0;
sql = "SELECT VehicleRegNumber 	FROM db_gps.`t_vehicledetails` 	WHERE VehicleRegNumber NOT 	IN (SELECT transporter 	FROM db_gps.t_group WHERE vehregno ='"+typeval+"' 	AND gpname = '"+grpnm+"') AND OwnerName ='"+typeval+"'  ";

ResultSet rst = st2.executeQuery(sql);
 System.out.println(">>>2222  sql 11"+sql);
while (rst.next()) {
	
	//gpnm =rst.getString("VehicleRegNumber");
	//ak=rst.getInt("ak");
	
%>


			 <option value="<%=rst.getString("VehicleRegNumber") %>" ><%=rst.getString("VehicleRegNumber") %></option>

<%
j++;

}

%>
</select>
</td>
<td   style="vertical-align:middle;margin-right:5em;width:20px   ">
<br>
<div><input type="button" class="button" value="&gt;" style="vertical-align: top" align="" onClick="addUser();" /></div>
<br></br>
<div><input type="button" class="button" value="&lt;" align="center" onClick="removeUser()" /></div>
</td>
<td align="center" valign="top">
<br>
<select name="assigned" style="width:200px" size="8" multiple="multiple">
	
</select>

<select name="assigned1" style="width:160px;display: none" size="8" multiple="multiple">
	
</select>
</td>
</tr>
<tr>
						
						<td align="center" colspan="3"><br><input type="submit" class="submit" value="submit"  />
						
						
						</td>				
							
					</tr>
</table>

<%
	
	

%>




<div style="width:43em;"   align="center" id=tbvl>


<input type="hidden" name="grpname" id="grpname" value="<%=grpnm%>" >

</div>

<table>
<tr>




</tr>


</table>
</td>
</tr>
</table>

<br></br>

</div>




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

</div>




</body>
</html>
