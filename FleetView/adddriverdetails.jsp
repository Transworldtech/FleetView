<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<%@ include file="IRTEheader.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">

<script language="javascript">

function validate()
{
   
    
    var drvId = document.adddriver.drvId.value;
   /*  if(drvId.length=="")
	{
		alert("Please enter driver Id.");
		return false;
	} */
    var numericExpressionn = /^[.0-9]+$/;
    var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
    

	var passId=document.getElementById("passId").value;
	var oth=passId.replace(/^\s\s*/, '').replace(/\s\s*$/, '');

	if(passId==""  || oth=="")
	   {
		      alert("Please Enter Passport Id");

				return false;
				   
	   }



	
	var fatherName= document.adddriver.fatherName.value;  
      var name = document.adddriver.drvName.value;
	var othname=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
    
	  var letter = /^[A-Za-z]+$/;  
	  if(name=="" || othname=="")
		{
			alert("Please enter driver name.");
			return false;
		}
	  for (var i = 0; i < document.adddriver.drvName.value.length; i++) {
		     if(iChars.indexOf(document.adddriver.drvName.value.charAt(i)) != -1) {
		    		alert("Please enter character value for driver name.");
		       return false;
		     }
		     }

	  if(name.match(numericExpressionn) && name.length!=0)  
       {  
          alert('Please enter only characters value for driver name.');  
       return false;  
       }  

	  if(!(fatherName.match(letter)) && fatherName.length!=0)  
      {  
         alert('Please enter only characters value for father name.');  
      return false;  
      }  
var DOB=document.adddriver.DOB.value;
if(DOB=="")
{
	alert("Please enter DOB.");
	return false;
	
}


	  
	  var LicenseNo = document.adddriver.LicenseNo.value;
		var othLicenseNo=LicenseNo.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		  
		//alert("LicenseNo--->"+LicenseNo);
	    var LicenseNo1 = /^[0-9]+$/; 
	     if(LicenseNo=="" || othLicenseNo=="")
		{
			alert("Please enter LicenseNo.");
			return false;
		}

	     for (var i = 0; i < document.adddriver.LicenseNo.value.length; i++) {
	     if(iChars.indexOf(document.adddriver.LicenseNo.value.charAt(i)) != -1) {
	    		alert("Please enter character or numeric value for LicenseNo.");
	       return false;
	     }
	     }

			

			  
    var transName = document.adddriver.transpName.value;
    if(transName=="Select")
	{
		alert("Please select transporter name.");
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

function ckdate()
{
	//alert("hi");

	var dob=document.getElementById("DOB").value;

//alert("DOB is >>" +dob);
var date1=document.getElementById("calender").value;
//alert("Todayas date " +date1);

	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;


	dd11=dob.substring(0,2);
	dd22=date1.substring(0,2);
	
	mm1=dob.substring(3,6);
	mm2=date1.substring(3,6);
	
	
	mm11=dateformat(mm1);
	mm22=dateformat(mm2);
	
	

	yy11=dob.substring(7,11);
	yy22=date1.substring(7,11);

	if(yy11>yy22)
	{
		alert("DOB date should not be greater than or equal to than Todays date");
		document.getElementById("DOB").value="";
		return false;
	}
	else if(yy11==yy22)
	{
			if(mm11>mm22)
		{
				alert("DOB date should not be greater than or equal to than Todays date");
				document.getElementById("DOB").value="";
				
			return false;
		}
			else if(mm11==mm22)
			{
				if(dd11>=dd22)
				{
					alert("DOB date should not be greater than or equal to than Todays date");
					document.getElementById("DOB").value="";
					
					return false;
				}
			}
	}

	
}


function Ckpid()
{
	try{
		  

		
	//alert("Hi");
					var passId=document.getElementById("passId").value;
					//alert(driveid);
					var oth=passId.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
				    var numericExpressionn = /^[.0-9]+$/;

					 if(passId==""  || oth=="")
					   {
						      alert("Please Enter Passport Id");

						   
					   }
					 else if(!(passId.match(numericExpressionn))&& passId.length!=0)
					 	{
					 		alert("Please enter only Numeric value for Passport Id");

		                    document.getElementById("passId").value="";

					 		}
					else{

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

							reslt=reslt.replace(/^\s+|\s+$/g,'');
		//alert(reslt);					
		                    if(reslt=="Yes")
		                    {
			                    alert("Passport id already exits");
			                    document.getElementById("passId").value="";
			                    
		                    }
						
							}catch(e)
							{
							alert(e);
							}
						} 
					};

					

					
					var queryString ="?passId="+passId;
					ajaxRequest.open("GET", "Passport_Ajax.jsp" + queryString, true);
					ajaxRequest.send(null); 

				}
				}
				    catch(e)
					{
						alert(e);
					}

			


}













</script>

<%!
Connection con1, con2;
String driveridjsp="";

%>

 
<form name="adddriver" method="post" action="adddriverdetailsDB.jsp" onSubmit="return validate();" >
<div class="form_container" style="text-align: center;" align="center">
	<div width="100%" align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff ;text-align: center;">

<% 
try {

 Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=con1.createStatement(), stmt2=con2.createStatement();
ResultSet rs2=null;
String sql1="";int DriverID=0;
String msg = (String)request.getParameter("msg");
String drvnm = (String)request.getParameter("drvnm");
String transpName = "";
ArrayList alTransporterName = new ArrayList();
int i=0;
String fromPage = (String) request.getParameter("frPg");
        %>        <input type="hidden" id="fromPage" name="fromPage" value="<%=fromPage %>" />        <%
        String sql2="select rid from t_irtedriver order by rid desc limit 1";
        ResultSet rst2=stmt1.executeQuery(sql2);
        if(rst2.next())
        {
        	DriverID=rst2.getInt("rid");
        	DriverID=DriverID+1;
        	//System.out.println("DriverID"+DriverID);
        }      
sql1 = "select distinct vehregno from t_group where  gpname = 'Castrol' order by vehregno desc;  ";
rs2 = stmt1.executeQuery(sql1);
while(rs2.next()){
      
      alTransporterName.add(i, rs2.getString("vehregno"));
}
String Save=request.getParameter("msg");


if(Save!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Saved Successfully");
	window.location="adddriverdetails.jsp";
	
	</script>
	<%
}
java.util.Date NewDate =new java.util.Date();

String DateTime=new SimpleDateFormat("dd-MMM-yyyy").format(NewDate);



%>
<input type="hidden" id="calender" name="calender" value="<%=DateTime %>"></input>
<table border="0" align="center"  >
	   
                            <tr><td colspan="6">
                                    <div align="left">
                                            <a href="driver_briefing1.jsp"><font size="2">Back</font></a>
                                            
                                            
                                    </div>
                        </tr></table>
<div style="margin-left: 40%;">
	<table border="0"  align="center"  >
	   
                            
			<tr>
				<td colspan=""> <div  align="center"> <font face="Arial" color="black" size="2"> <B><font color="black" size="3"> Add New Driver</font> </B> </font> </div> </td>
			</tr>
			
			
			</table></div>
			<div style="margin-left: 50%;">
			<table>
			<tr>
			<td colspan=""><font face="Arial" color="black" size="2" >(<font color="red"> *</font> indicates mandatory fields)</font></td>
			</tr>
       </table>
			</div>
			<div style="margin-left: 35%;">
		<table border="0"   align="center"  >
	
       <tr>
       <br></br>
		<td align="left" width="25%">&nbsp;&nbsp;<font color="black" size="2">Driver Id :</font> </td>
       	<td width="75%">&nbsp;&nbsp;&nbsp;<input type="text"   id="drvId" name="drvId" value="<%=DriverID %>" class="element text medium" size="48" readonly/> </td>
		</tr>
       
        <tr>
		<td align="left" width="25%"><font color="red">*</font><font color="black" size="2">Passport Id :</font> </td>
       	<td width="75%">&nbsp;&nbsp;&nbsp;<input type="text" id="passId" name="passId" value="" class="element text medium" size="48" onchange="Ckpid();" /> </td>
		</tr>
		
		<tr>
		<td align="left"><font color="red">*</font><font color="black" size="2">Driver Name :</font></td>
        <td> &nbsp;&nbsp;&nbsp;<input type="text" id="drvName" name="drvName" value="" class="element text medium" size="48" /> </td>
		</tr>
		
		<tr>
		<td align="left">&nbsp;&nbsp;<font color="black" size="2">Father Name :</font></td>
        <td> &nbsp;&nbsp;&nbsp;<input type="text" id="fatherName" name="fatherName" value="" class="element text medium" size="48" /> </td>
		</tr>
                         
        <tr>
		<td align="left"><font color="red">*</font><font color="black" size="2">Date of Birth :</font></td>
        <td align="right"><div align="left">&nbsp;&nbsp;&nbsp;<input type="text" class="element text medium" id="DOB" name="DOB" size="48" value="" onchange="ckdate();" readonly/>
        <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "DOB",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "DOB"       // ID of the button
    			}
  				);	
		</script>
			</div></td></tr>
		
		 <tr>
		<td align="left"><font color="red">*</font><font color="black" size="2">License No :</font></td>
        <td> &nbsp;&nbsp;&nbsp;<input type="text"  id="LicenseNo" name="LicenseNo" value="" class="element text medium" size="48" /> </td>
		</tr>
		
		     <tr>
		<td align="left"><font color="red">*</font><font color="black" size="2">Transporter :</font> </td>
        <td>&nbsp;&nbsp; <select name="transpName" id="transpName" class="element select medium" >
             <option>Select</option>
             <%
                 for(i=0; i<alTransporterName.size(); i++){
             %>
              <option><%= alTransporterName.get(i) %></option>
             <%}%>
             </select>
        </td>
        </tr> 
        
		
    
 		</table>
 		</div>
 		<div style="margin-left: 500">
            <table border="0" width="25%" align="center" >
                <tr><br></br>
				<td align="center" colspan="1" > <input type="submit" value="Submit" name="submit"  style="border-style: outset; border-color: black" class="formElement" /> </td>
                               
			</tr>
                    </table>    
		</div>
<%

} catch(Exception e) { }
finally
{
con1.close();
}
%>
</div>
</div>
</form>

    
    </body>
</html>
<%@ include file="footernew.jsp" %>
