<%@ include file="headernew.jsp"%>               

	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cleaner Management</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript">
function validate() 
{

	
var cleanerid=document.cleanermgt.cleanerid.value;
//var tbLen = cleanerid.value.trim().length;
var cleanename=document.cleanermgt.cleanername.value;
var address=document.cleanermgt.address2.value;
var dob=document.cleanermgt.dob.value;
//alert(dob);
var currentdate=document.cleanermgt.currentdate.value;
//alert(currentdate);
var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
var cleanidlength=cleanerid.length;
cleanerid=cleanerid.replace(/\s/g, "");
var newlegth=cleanerid.length;

var DOBfile=document.cleanermgt.Filename1.value;
var Addresfile=document.cleanermgt.Filename2.value;
var phno=document.cleanermgt.mobno.value;


if(cleanerid.trim()=="")
{
alert("Please enter cleanerId");

return false;
}
for (var i = 0; i < document.cleanermgt.cleanerid.value.length; i++) { 
if(iChars.indexOf(document.cleanermgt.cleanerid.value.charAt(i)) != -1)
{
	alert("Please enter valid cleanerId");
	
	return false;
}
}

if(cleanename.trim()=="")
{
	alert("Please enter cleaner Name");

	return false;
}
var invalid=/[^A-Za-z\s]/;

if(invalid.test(cleanename)){
    alert('Please enter characters value for cleaner Name');  
    return false;
}



if(cleanidlength != newlegth)
{
	alert('Please enter valid cleaner Id');  
    return false;
}

if(address.trim()=="")
{
	alert("Please enter address");

	return false;
}

if(dob=="")
{
	alert("Please enter DOB");

	return false;
}




var dat = new Date();
var curday = dat.getDate();
var curmon = dat.getMonth()+1;
var curyear = dat.getFullYear();


// alert(curday);
// alert(curmon);
// alert(curyear);


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
  alert("Age should be greater than 18 years");
  return false;
}

if(!(phno ==0))
{
	
	 if(isNaN(phno))
		{
			alert("Please enter numeric value for mobile number");
			return false;
		}
	
		 if((phno.length < 10)  || (phno.length >10))
			 {
        alert("Mobile no should be 10 digits"); 
        return false;
    }
}
else
{
	phno="";
	
	alert("Please enter cleaner mobile number");
    return false;	
}

var driver_license = document.getElementById('driver_license'); 
var driver_license1 = driver_license.options[driver_license.selectedIndex].value;

var Education = document.getElementById('Education'); 
var Education1 = Education.options[Education.selectedIndex].value;

var how_long = document.getElementById('how_long').value; 

if(driver_license1=='Select')
{
	alert("Please select holding driver license");
	return false;
}

if(driver_license1=='Yes')
{	var license_type=document.getElementById("license_type").value;
	
	

	if(license_type=='Select')
	{
	alert("Please select  license type");
	return false;
	}

	if((how_long.trim()==""))
	{
		alert("Please enter  value for how long ");
		return false;	
	}

 if(isNaN(how_long))
	{
	 alert("Please enter numeric value for how long ");
		return false;
	}
	
	
	if(Education1=='Select')
	{
		alert("Please Select Education");
		return false;
	}
	
}




return confirmSubmit();	
}
function datediff(date1, date2)
{
    var y1 = date1.getFullYear(), m1 = date1.getMonth(), d1 = date1.getDate(),
    y2 = date2.getFullYear(), m2 = date2.getMonth(), d2 = date2.getDate();
     return [y1 - y2];
}


function confirmSubmit()
{
	var cleanerid=document.cleanermgt.cleanerid.value;
	var cleanename=document.cleanermgt.cleanername.value;
	var mobno=document.cleanermgt.mobno.value;
	var dob=document.cleanermgt.dob.value;
   // alert("hi>>");
   

    
	var agree=confirm("CleanerID: "+cleanerid+"\nCleanerName : "+cleanename+"\nDOB: "+dob+"\nMobile No.: "+mobno+"\n\nAre you sure you want to continue with these values?");
	if (agree)
		return true ;
	else
		return false ;
	
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
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("Filename1").value="";
			  
	  }
	}
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
		  alert("Please upload only jpg,png,jpeg and bmp formatted file");
			document.getElementById("Filename2").value="";
			  
	  }
		  
		}
	}
		
}


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



</script>

<script type="text/javascript">
function validateLicense() 
{
	var driver_license = document.getElementById('driver_license'); 
	var driver_license1 = driver_license.options[driver_license.selectedIndex].value;
	//alert(driver_license1);
	if(driver_license1=='No')
	{
		document.getElementById("license_type").disabled=true;
		document.getElementById("how_long").disabled=true;
		document.getElementById("how_long").value="";
		document.getElementById("Education").disabled=true;

		document.getElementById("license_type").selectedIndex = 0;
		document.getElementById("Education").selectedIndex = 0;
		
	}
	if(driver_license1=='Yes')
	{
		document.getElementById("license_type").disabled=false;
		document.getElementById("how_long").disabled=false;
		document.getElementById("Education").disabled=false;

		
		
				
	}

	
}
</script>

</head>
<%!
Connection conn;
Statement st,st1;
%>
<%
try{
Class.forName(MM_dbConn_DRIVER); 
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
Statement stquery=conn.createStatement();
}catch(Exception e)
{
	e.printStackTrace();
}

%>

<%
try{
	int Newidget=0;
	int finalage=0,newclenidd=0;
String 	username="";
DecimalFormat twoDForm = new DecimalFormat("0000");
Calendar now = Calendar.getInstance();
int year=now.get(Calendar.YEAR);
System.out.println("current year  "+year);
String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
username=(String)session.getAttribute("usertypevalue");
String Save=request.getParameter("save");
String Save1=request.getParameter("save1"); 


if(Save!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Saved Successfully");
	window.location="cleanerentry.jsp";
	
	</script>
	<%
}


if(Save1!=null)
{
	%>
	<script type="text/javascript">
	alert("Age should be greater than 18");
	window.location="cleanerentry.jsp";
	
	</script>
	<%
}

%>




<body>
<form id="cleanermgt" name="cleanermgt" method="post" action="insertnewcleaners.jsp" enctype="multipart/form-data"  >
<img id="top" src="newimages/top.png" alt="" style="width: 550px;">
	<div id="form_container" style="width: 850px;">
	
		<h1 align="center">Add Cleaner</h1>
		<br>
		<table border="0" width="90%" align="center">
					 <tr><td>					 <div align="left">  <a href="javascript:history.go(-1)"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a> </div> </td>
					 
					<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" >(<font color="red"> *</font> indicates mandatory fields)</font></td>
					 </tr>
							
					 
					 <input type="hidden" id="currentdate" name="currentdate" value="<%=nwfrmtdte%>"></input>
					 </table>
		
			<font size="3" style="margin-left: 90px;">Personal Details</font>
		<br>
<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
				<br>
			<table cellspacing="4" border="0" align="center">
					 <tr>
					 
				<%
				String Newid="";
				String sqlset="select MAX(Cleanerid) as cleanid from db_gps.t_cleaners";
				System.out.println("count query is" +sqlset);
				ResultSet rsset=st1.executeQuery(sqlset);
				if(rsset.next())
				{
					newclenidd=rsset.getInt("cleanid");
					
					//System.out.println("count query is" +newclenidd);
					//System.out.println("count query is" +Integer.toString(newclenidd).substring(0,4));


				}
				Newid=Integer.toString(newclenidd);
				if(Newid.length()>=3)
				{
					Newid=Newid.substring(4,Newid.length());
					System.out.println("Newid is >> " +Newid);
					Newidget=Integer.parseInt(Newid);
					Newidget++;
				}
				else{
					Newidget=Integer.parseInt(Newid);
					Newidget++;
					
				}
				
				System.out.println("Afetr" +Newidget);

				
				%>	 
					 
					 
					 
					 
					 
					 
					 
           <td>
           <font color="red" size="2">*</font><font face="Arial" size="2"> <b>Cleaner Id :</b></font></td>
           <td>
           
          <font face="Arial" size="2">
           <lable style="width: 100px;" ><%=year+""+twoDForm.format(Newidget)%></lable></font>
           
           		 <input type="hidden" name="cleanerid" id="cleanerid" value="<%=year+""+twoDForm.format(Newidget)%>" ></input>
           
          
           </tr><tr><td></td></tr>
           
					 <tr>
					 
           <td><font color="red" size="2">*</font><font face="Arial" size="2"> <b>Cleaner Name :</b></font></td>
           <td> 
               <input type="text" class="element text medium" style="width: 200px;" name="cleanername" id="cleanername" />
               </td>
               
               <td><font face="Arial" size="2">&nbsp; <b>Father Name :</b></font></td>
           <td> 
               <input type="text" class="element text medium" style="width: 200px;" name="fathername" id="fathername" />
               </td>
               
               
           </tr>
	       <tr><td></td></tr>
	       <tr>
           <td>&nbsp;&nbsp;<font face="Arial" size="2"> <b>Permanent Address :</b></font></td>
           <td> 
<textarea rows="3" cols="25" id="address1" name="address1"></textarea>               </td>
           
              
           <td><font color="red" size="2">*</font><font face="Arial" size="2"> <b>Current Address :</b></font></td>
           <td> 
<textarea rows="3" cols="25" id="address2" name="address2"></textarea>                </td>
           </tr>
	       <tr><td></td></tr>
	             <tr>
           <td><font face="Arial" size="2">&nbsp; <b>Gender :</b></font></td>
           <td>
          <select class="element select medium" style="width: 100px;" name="gender" id="gender" value=""  >
                	      <option value="Select">Select</option>
        
        	            <option value="Male">Male</option>
        	  
        	
                    <option value="Female">Female</option>
                  
          </select></td>
             <td><font face="Arial" size="2">&nbsp; <b>Marital Status :</b></font></td>
           <td>
          <select class="element select medium" style="width: 100px;" name="maridstatus" id="maridstatus" value=""  >
                            <option value="Select">Select</option>
        
        	            <option value="Married">Married</option>
        	  
        	
                    <option value="Unmarried">Unmarried</option>
                  
          </select></td>
           </tr><tr><td></td></tr>
           			 <tr>
					 
           <td><font color="red" size="2">*</font><font face="Arial" size="2"> <b>DOB :</b></font></td>
           <td>
           
                     <input type="text" name="dob" id="dob" class="element text medium" style="width: 125px; height: 16px;" value="<%=nwfrmtdte%>" readonly="readonly"/>
           <div>	<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "dob",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",     // the date format
      				button      : "dob"        // ID of the button
    				}
  					);
					</script>        </div> 
           
           </td>        
               
               <td><font color="red" size="2">*</font><font face="Arial" size="2"> <b>Mobile No :</b></font></td>
           <td> 
               <input type="text" class="element text medium" style="width: 180px;" name="mobno" id="mobno" />
               </td>
               
               
           </tr>
           <tr><td></td></tr>
           
           <tr>
               <td><font face="Arial" size="2">&nbsp; <b>Date Of Induction :</b></font></td>
           
           <td>
           
                     <input type="text" name="induction" id="induction" class="element text medium" style="width: 125px; height: 16px;" value="<%=nwfrmtdte%>" readonly="readonly"/>
           <div>	<script type="text/javascript">
  					Calendar.setup(
    				{
      				inputField  : "induction",         // ID of the input field
      				ifFormat    : "%d-%b-%Y",     // the date format
      				button      : "induction"        // ID of the button
    				}
  					);
					</script>        </div> 
           
           </td>        
           
           
           
                     <input type="hidden" style="width: 180px;" name="GPName" id="GPName" value="Castrol" readonly="readonly"  />
                    <td><font face="Arial" size="2">&nbsp; <b>Transporter :</b></font></td>
                    <td>
           
     <%    
     String usertypevalue=session.getAttribute("usertypevalue").toString();
 	String SrchTrans="";

 	String typeofuser=session.getAttribute("TypeofUser").toString();
	String loginusr=session.getAttribute("mainuser").toString();
	String usrrole="";
String sqlsub="select TypeofUser from db_gps.t_security where Username='"+loginusr+"'";
System.out.println("usr role query     " +sqlsub);

ResultSet rssub=st.executeQuery(sqlsub);
if(rssub.next())
{
	usrrole=rssub.getString("TypeofUser");	
}
System.out.println("usr role is     " +usrrole);

    // out.print("Type of user " +typeofuser);
 	if(typeofuser.equalsIgnoreCase("Group"))

     
 	{
         %>
         <select name="transporter" id="transporter" class="element select medium"  style="width: 200px">
         <% 
		String sqltransck="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
		System.out.println("*****8     "+sqltransck);
		ResultSet rstGrp=st.executeQuery(sqltransck);
		

		
		int k = 0;
		while(rstGrp.next())
		{
			
		%>
		
		
		<option value="<%=rstGrp.getString("VehRegno")%>"><%=rstGrp.getString("VehRegno")%>
						</option>
		<%
	
			k++;
		}
		//SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";
%>
</select>
<%
	}
 	if(!(typeofuser.equalsIgnoreCase("Group")))

 	     
 	{
 	if(usrrole.equalsIgnoreCase("SUBUSER"))
 	{
 		 
 	 	
 	         %>
 	         <select name="transporter" id="transporter" class="element select medium"  style="width: 200px">
         <% 
		String sqltransck="SELECT VehRegno FROM db_gps.t_group WHERE GPName='Castrol' group by VehRegno";
		System.out.println("*****8     "+sqltransck);
		ResultSet rstGrp=st.executeQuery(sqltransck);
		

		
		int k = 0;
		while(rstGrp.next())
		{
			
		%>
		
		
		<option value="<%=rstGrp.getString("VehRegno")%>"><%=rstGrp.getString("VehRegno")%>
						</option>
		<%
			
		
			k++;
		}
		//SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";
%>
</select>

 	<%
 		
 	}}
 	
 	if(!(typeofuser.equalsIgnoreCase("Group")) && !(usrrole.equalsIgnoreCase("SUBUSER")))
 	{
 		System.out.println("In Transporter ");
 		%>
 		                     <input type="text" style="width: 180px;" name="transporter" id="transporter" value="<%=username%>" readonly="readonly"  />
 		
 		<%
 	}
	 %>        
           
       
           </td>
       </tr>
       <tr>
       		<td><font color="red" size="2">*</font><font face="Arial" size="2"> <b>Holding driver's license :</b></font></td>
           <td>
          <select class="element select medium" style="width: 100px;" name="driver_license" id="driver_license" value=""  onchange="validateLicense();" >
                	    <option value="Select">Select</option>
        				<option value="Yes">Yes</option>
        	            <option value="No">No</option>
          </select></td>
       		<td><font color="red" size="2">*</font>
       			<font face="Arial" size="2"> <b>License Type :</b></font>
       		</td>
       		<td>
       			<select class="element select medium" style="width: 100px;" name="license_type" id="license_type" value=""  >
                	    <option value="Select">Select</option>
        				<option value="Light Motor Vehicle (LMV)">Light Motor Vehicle (LMV)</option>
        	            <option value="Medium Goods Vehicle (MGV)">Medium Goods Vehicle (MGV)</option>
        	            <option value="Light Transport Vehicle (LTV)">Light Transport Vehicle (LTV)</option>
        	            <option value="Heavy Goods Vehicle (HGV)">Heavy Goods Vehicle (HGV)</option>
          </select>
       		</td>
       </tr> 
        
       
       
       <tr>
       <td><font color="red" size="2">*</font>
       		<font face="Arial" size="2"><b>Duration since getting <br> &nbsp; License :  (in months)</b></font>
       		</td>
       		<td>
       			<input type="text" class="element text medium" style="width: 200px;" name="how_long" id="how_long" />
       		</td>
       
       		<td><font color="red" size="2">*</font>
       		<font face="Arial" size="2"> <b>Education :</b></font></td>
           <td>
          <select class="element select medium" style="width: 100px;" name="Education" id="Education" value=""  >
                	    <option value="Select">Select</option>
        				<option value="std 10 or above">Std 10 or above</option>
        	            <option value="Std 9 or below">Std 9 or below</option>
          </select></td>
       		
       </tr> 
        
        
          
           	   </table>
</div>
           	  
      
           	  
        <br></br><br></br>
         			<font size="3" style="margin-left: 90px;">Upload Documents</font>
         
                  	<div id="form_container" style="width: 850px;">
         
         
         <div width="100%" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
         
         
         
         
           	  <table>
          <tr>	<br></br>  
         <td> 
         
         	<div style="margin-left: 220px">
 
  	<font face="Arial" size="2"><b> DOB Proof :</b></font></div></td>
  	<td>
<input type="file" cols="40" name="Filename1" id="Filename1" value="" onchange="upload(1);" style="width: 250px"/>
<font size="2" face="Arial" color="black" id="f1" style="display: none;" name = "f1"></font>

<a href="#" onclick="rr();" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		</td>
		    
	    </tr>
		 
		 
		    <tr>
		    <td><br></br>
		       	<div style="margin-left: 200px">
		       
		        <font face="Arial" size="2"><b>Permanent Address Proof :</b></font></div></td>
		    <td>   <br></br>
		       <input type="file" name="Filename2" id="Filename2" value="" onchange="upload(2);" style="width: 250px"/>
		<font size="2" face="Arial" color="black" id="f2" style="display:none;" name = "f2"></font>
		<a href="#" onclick="removess();" id="remove2" style="display: none;"><font size="2" face="Arial">Remove</font></a>
		<input id="f7" name=f7 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/>
  	</td>
	        
		       </tr> 
		      
		      
		     
	<tr align="center">
	
	<td  colspan="5" ><br></br><div  align="center">
	<div style="margin-left: 200px">
	<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" onClick="return validate();" class="formElement"></div></td>
	</tr>
    
    
          
</table>
	</div>	  	
</div>

	</div>	
		
	
	

</form>

<%}catch(Exception e)

{
	e.printStackTrace();
}
finally{
	try{
	conn.close();
	}catch(Exception e){}
}
%>

</body>
</html>
<%@ include file="footernew.jsp"%>
