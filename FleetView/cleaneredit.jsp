-<%@ include file="headernew.jsp"%>               

	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Cleaner Management</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript">

function validate() 
{
//alert("yes");
var cleanerid=document.cleanermgt.cleanerid.value;

var cleanename=document.cleanermgt.cleanername.value;
var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
var cleanidlength=cleanerid.length;
cleanerid=cleanerid.replace(/\s/g, "");
var newlegth=cleanerid.length;
var address=document.cleanermgt.address2.value;
var phno=document.cleanermgt.mobno.value;
var dob=document.cleanermgt.dob.value;
var currentdate=document.cleanermgt.currentdate.value;



if(cleanerid.trim()=="" || cleanerid==null)
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



function confirmSubmit()
{
	var cleanerid=document.cleanermgt.cleanerid.value;
	var cleanename=document.cleanermgt.cleanername.value;
	var mobno=document.cleanermgt.mobno.value;
	var dob=document.cleanermgt.dob.value;
	
    
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
		  //alert(name1);
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

	function rr()
	{try{
			document.getElementById("f1").innerHTML="";
			document.getElementById("f1").style.display="none";
			document.getElementById("remove1").style.display="none";
			document.getElementById("Filename1").value="";
			document.getElementById("f6").value="";
			document.getElementById("Filename1").style.display="";
	}catch(e){}
		}
		
	function removess(){
		try{	
				document.getElementById("f2").innerHTML="";
				document.getElementById("f2").style.display="none";
				document.getElementById("remove2").style.display="none";
				document.getElementById("Filename2").value="";
				document.getElementById("f7").value="";
				document.getElementById("Filename2").style.display="";
			}catch(e){}
	}
	
function add(num)
{
	if(num==1){
	document.getElementById("olddobfnm").style.display="none";
	document.getElementById("add").style.display="none";
	document.getElementById("back").style.display="";
	
	document.getElementById("Filename1").style.display="";
	}

	else{
		//alert("hi>>else");

		if(num==2){
			//alert("hi>>num2");
			//alert(document.getElementById("oldaddfnm123").value);
			document.getElementById("oldaddfnm123").style.display="none";
			document.getElementById("add2").style.display="none";
			document.getElementById("back2").style.display="";
			
			document.getElementById("Filename2").style.display="";
			}

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
	else{

		if(num==2){
			document.getElementById("oldaddfnm123").style.display="";
			document.getElementById("Filename2").style.display="none";
			document.getElementById("back2").style.display="none";
			document.getElementById("add2").style.display="";
			
			
			}

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
String 	username="",cleanid="",marrid="",clname="",ownernm="",gpnm="",status="",entyby="",address="",Gender="",dob="",mobno="",fathernm="", driver_license="", license_type="", how_long="", Education="";
String Add2="",DOIn="";
username=(String)session.getAttribute("usertypevalue");
String clean=request.getParameter("clean");
System.out.println("Clean"+clean);
String Save=request.getParameter("save");
String cktrip=request.getParameter("cktrip");
cleanid=request.getParameter("id");
clname=request.getParameter("name");

address=request.getParameter("add");
Gender=request.getParameter("Gender");
dob=request.getParameter("dob");
mobno=request.getParameter("mobno");
fathernm=request.getParameter("fathernm");

marrid=request.getParameter("marrid");


ownernm=request.getParameter("owner");
gpnm=request.getParameter("gpname");
status=request.getParameter("status");
entyby=request.getParameter("entryby");
 
Add2=request.getParameter("Address2");
DOIn=request.getParameter("DOiN");
String DProof="",AProof="";


DProof=request.getParameter("DProof");
AProof=request.getParameter("Aproof");

driver_license=request.getParameter("driver_license");
license_type=request.getParameter("license_type");
how_long=request.getParameter("how_long");
Education=request.getParameter("Education");



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





<body>
<form id="cleanermgt" name="cleanermgt" method="post" action="editcleaners.jsp" enctype="multipart/form-data">
<img id="top" src="newimages/top.png" alt="" style="width: 550px;">
	<div id="form_container" style="width: 850px;">
	
		<h1 align="center">Edit Cleaner </h1>
		<br>
		<table border="0" width="90%" align="center">
					 <tr>
					<td>
					<input type="hidden" id="oldcleanid" name="oldcleanid" value="<%=cleanid%>">
										 <input type="hidden" id="currentdate" name="currentdate" value="<%=nwfrmtdte%>"></input>
					
					
					 <div align="left">  <a href="javascript:history.go(-1)"> <img src="images/arrow.bmp" width="20px" height="20px" border="0" > </img> </a> </div> </td>
					<td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" size="2" >(<font color="red"> *</font> indicates mandatory fields)</font></td>
					 </tr></table>
		 <input type="hidden" style="width: 50px;" name="clean" id="clean" value="<%=clean %>" ></input>
		 
		 
		 
			<font size="3" style="margin-left: 90px;">Personal Details</font>
		<br>
<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
				<br>
			<table cellspacing="4" border="0" align="center">
					 <tr>
					 
					
           <td><font color="red" size="2">*</font>
           <font face="Arial" size="2"> <b>Cleaner Id :</b></font></td>
           <td><font face="Arial" size="2">
           <lable style="width: 100px;" ><%=cleanid%></lable></font>
           
           		 <input type="hidden" name="cleanerid" id="cleanerid" value="<%=cleanid%>" ></input>
           
           </td>
           </tr><tr><td></td></tr>
           
					 <tr>
					 
           <td><font face="Arial" size="2">&nbsp; <b>Cleaner Name :</b></font></td>
           <td> 
               <input type="text" class="element text medium" style="width: 200px;" name="cleanername" id="cleanername" value="<%=clname %>" />
               </td>
               
               <td><font face="Arial" size="2">&nbsp; <b>Father Name :</b></font></td>
           <td> 
               <input type="text" class="element text medium" style="width: 200px;" name="fathername" id="fathername" value="<%=fathernm %>" />
               </td>
               
               
           </tr>
	       <tr><td></td></tr>
	       <tr>
           <td><font face="Arial" size="2">&nbsp; <b>Permanent Address :</b></font></td>
           <td> 
<textarea rows="3" cols="25" id="address1" name="address1"><%=address%></textarea>               </td>
           
               
           <td><font color="red" size="2">*</font><font face="Arial" size="2"><b> Current Address :</b></font></td>
           <td> 
<textarea rows="3" cols="25" id="address2" name="address2"><%=Add2%></textarea>                </td>
      
             </tr>
             <tr><td></td></tr>
             <tr>
             
             <td><font face="Arial" size="2">&nbsp; <b>Gender :</b></font></td>
           
                <td>
          <select class="element select medium" style="width: 100px;" name="gender" id="gender" value="">
        <option value="<%=Gender%>"><%=Gender%></option>
          <%
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
         
        	  
        	
                  
          </select></td>
          <td>&nbsp;<font face="Arial" size="2">&nbsp; <b>Marital Status :</b></font></td>
           <td>
          <select class="element select medium" style="width: 100px;" name="maridstatus" id="maridstatus" value=""  >
        
        	            <option value="<%=marrid%>"><%=marrid%></option>
        	  
        	<%
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
          else{
          %>
        	            <option value="Married">Married</option>
          
          <%
          }
          %>
         
                  
          </select></td>
             
          
             </tr>
             
             <tr><td></td></tr>
           			 <tr>
					 
           <td><font color="red" size="2">*</font><font face="Arial" size="2"> <b>DOB :</b></font></td>
           <td> <font face="Arial" size="2">
           <lable style="width: 100px;" ><%=dob%></font></lable>
                      		 <input type="hidden" name="dob" id="dob" value="<%=dob%>" ></input>
           
      </td>
			
			 <td><font color="red" size="2">*</font><font face="Arial" size="2">&nbsp; <b>Mobile No :</b></font></td>
           <td> 
               <input type="text" class="element text medium" style="width: 180px;" name="mobno" id="mobno" value="<%=mobno %>" />
               </td>
               
             
               
               
           </tr>
           <tr><td></td></tr>
           
           
           
           
           <tr>
           
           <td><font face="Arial" size="2">&nbsp; <b>Date Of Induction :</b></font></td>
           
           <td><font face="Arial" size="2">
            <lable style="width: 100px;" ><%=DOIn%></font></lable>
                      		 <input type="hidden" name="induction" id="induction" value="<%=DOIn%>" ></input>
                     
          </td> 
					
	        
           <td>&nbsp;<font face="Arial" size="2">&nbsp; <b>Transporter :</b></font></td>
           
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
     
 	if(typeofuser.equalsIgnoreCase("Group"))

     
 	{
         %>
         <select name="transporter" id="transporter" class="element select medium"  style="width: 200px">
         
         	<option value="<%=ownernm%>"><%=ownernm%>
						</option>
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
		//SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";
%>
</select>

 	<%
 		
 	
	if(!(typeofuser.equalsIgnoreCase("Group")) && !(usrrole.equalsIgnoreCase("SUBUSER")))
 	{
 		System.out.println("In Transporter ");
 		%>
                     <input type="text" style="width: 180px;" name="transporter" id="transporter" value="<%=ownernm %>" readonly="readonly"  />
 		
 		<%
 	}
	 %>        
           
    </td>
           </tr><tr><td></td></tr>
           <tr>
                          <td><font face="Arial" size="2">&nbsp; <b>Status :</b></font></td>
           
           <td>
           
<select class="element select medium" style="width: 100px;" name="status" id="status" value=""  >
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
                      
           </tr>
		 
		 <tr>
       		<td><font color="red" size="2">*</font><font face="Arial" size="2"><b>Holding driver's license :</b></font></td>
           <td>
          			
          			<select class="element select medium" style="width: 100px;" name="driver_license" id="driver_license" value=""  >
         <option value="<%= driver_license %>"><%= driver_license %></option>
          <%
          if(driver_license.equals(""))
          {
        	  %>
        	  <option value="Yes">Yes</option>
          <option value="No">No</option>
          <%
          }else if(driver_license.equals("Yes"))
          {
        	  %>
        	            
        	  	 <option value="No">No</option>
        	  <%
          }
          else{
          %>		<option value="Yes">Yes</option>
                   
          
          <%
          }
          %>
         
          </select>           
          </td>
       		<td><font color="red" size="2">*</font>
       			<font face="Arial" size="2"> <b>License Type :</b></font>
       		</td>
       		<td>
       				
       		<select class="element select medium" style="width: 100px;" name="license_type" id="license_type" value=""  >
                <option value="<%= license_type %>"><%= license_type %></option>  	
        				
   				
   				<%if(license_type.equals(""))
   				{
     			%>	<option value="Light Motor Vehicle (LMV)">Light Motor Vehicle (LMV)</option>
   					<option value="Medium Goods Vehicle (MGV)">Medium Goods Vehicle (MGV)</option>
   	            <option value="Light Transport Vehicle (LTV)">Light Transport Vehicle (LTV)</option>
   	            <option value="Heavy Goods Vehicle (HGV)">Heavy Goods Vehicle (HGV)</option>
     				<%} 
   				 else  if(license_type.equals("Light Motor Vehicle (LMV)"))
   					{%>
   				<option value="Medium Goods Vehicle (MGV)">Medium Goods Vehicle (MGV)</option>
   	            <option value="Light Transport Vehicle (LTV)">Light Transport Vehicle (LTV)</option>
   	            <option value="Heavy Goods Vehicle (HGV)">Heavy Goods Vehicle (HGV)</option>
     				<%} 
   				else if(license_type.equals("Medium Goods Vehicle (MGV)"))
   				{
     				%>
     			<option value="Light Motor Vehicle (LMV)">Light Motor Vehicle (LMV)</option>
   	            <option value="Light Transport Vehicle (LTV)">Light Transport Vehicle (LTV)</option>
   	            <option value="Heavy Goods Vehicle (HGV)">Heavy Goods Vehicle (HGV)</option>
     				<%
   				}
   				
				else if(license_type.equals("Light Transport Vehicle (LTV)"))
				{
					%>
				<option value="Light Motor Vehicle (LMV)">Light Motor Vehicle (LMV)</option>
			   <option value="Light Transport Vehicle (LTV)">Light Transport Vehicle (LTV)</option>
			   <option value="Heavy Goods Vehicle (HGV)">Heavy Goods Vehicle (HGV)</option>
					<%
				}
   				else 
   					{%>
   					<option value="Light Motor Vehicle (LMV)">Light Motor Vehicle (LMV)</option>
   					  <option value="Light Transport Vehicle (LTV)">Light Transport Vehicle (LTV)</option>
   					<option value="Medium Goods Vehicle (MGV)">Medium Goods Vehicle (MGV)</option>
   	                
   	            <%} %>
   	            
          </select>		
       		</td>
       </tr> 
        
       
       
       <tr>
       <td><font color="red" size="2">*</font>
       		<font face="Arial" size="2"><b>Duration since getting <br> &nbsp; License :  (in months)</b></font>
       		</td>
       		<td>
       			
       			<input type="text" class="element text medium" style="width: 200px;" name="how_long" id="how_long" value="<%= how_long %>" />
       		</td>
       
       		<td><font color="red" size="2">*</font>
       		<font face="Arial" size="2"> <b>Education :</b></font></td>
           <td>
          			
           
            <select class="element select medium" style="width: 100px;" name="Education" id="Education" value=""  >
                	    <option value="<%= Education %>"><%= Education %></option>
        				
        					<%
				          if(Education.equals(""))
				          {
				        	  %>
        					<option value="Std 10 or above">Std 10 or above</option>
        					<option value="Std 9 or below">Std 9 or below</option>   
        				<%
				          } else if(status.equals("std 10 or above"))
				          {
				        	  %>
				        	  			<option value="Std 10 or above">Std 10 or above</option>
				        	           
				        	  
				        	  <%
				          }
				          else{
				          %>
				                  <option value="Std 9 or below">Std 9 or below</option>   
				          
				          <%
				          }
				          %>
           </select>
           </td>
       		
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
         
         
         
         <div style="margin-left: 200px">
  	&nbsp;<font face="Arial" size="2"><b> DOB Proof :</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
  	
  	
  	
  	<a href="#" onclick="add(1);" id="add" style=""><font size="2" face="Arial">Attach New</font></a>	
  	<a href="#" onclick="back(1);" id="back" style="display: none;"><font size="2" face="Arial">Back</font></a>	 &nbsp; 
  	  
<input type="file" cols="40" name="Filename1" id="Filename1" value="" onchange="upload(1);" style="background-image: newimages/browse.jpg;width: 250px;display: none;"/>

<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
&nbsp;&nbsp;<a href="#" onclick="rr();" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>	  
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		    </div></td>
		    </tr>
		 		         	  <input id="oldaddfnm" name="oldaddfnm" type="hidden" value="<%=AProof%>"/> 
		   <input id="olddobfnm" name="olddobfnm" type="hidden" value="<%=DProof%>"/> 
		 
		    
		    <td><br></br>
		                <div style="margin-left: 200px">
		       
		         	&nbsp;&nbsp;<font face="Arial" size="2"><b>Permanent Address Proof :</b></font>
		         	
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
		         	
		       	
		         	
		         	<a href="#" onclick="add(2);" id="add2" style=""><font size="2" face="Arial">Attach New</font></a>	  
		     <a href="#" onclick="back(2);" id="back2" style="display: none;"><font size="2" face="Arial">Back</font></a>	
		     &nbsp;
		     
		       <input type="file" name="Filename2" id="Filename2" value="" onchange="upload(2);" style="width: 250px;display: none;"/> 


		<font size="2" face="Arial" color="black" id="f2" style="display:none;" name = "f2"></font>
		&nbsp;&nbsp;<a href="#" onclick="removess();" id="remove2" style="display: none;"><font size="2" face="Arial">Remove</font></a>
		<input id="f7" name=f7 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/>
		</div> 
  	</td>
	        
		       </tr> 
		      
		      
		     
	<tr align="center">
	
	<td  colspan="5" ><br></br><div  align="center">
	<div style="margin-left: 100px">
	<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" onClick="return validate();" class="formElement"></div></td>
	</tr>
          
</table>
	</div>	  	
</div>

	</div>	
		
	
		
		
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

</body>
</html>

<%@ include file="footernew.jsp"%>
