<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

<%@ include file="../Connections/conn.jsp" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
   
 <style type="text/css">@import url(../jscalendar-1.0/calendar-blue.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
</head>
<script type="text/javascript">
function closewindow()
{
	window.close();
}
</script>
<script type="text/javascript">
function showwarcom(ind)
{ 
//alert("MAin VAlue" +ind);
	if(ind==0)
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="visible";
		document.getElementById("warcomment").style.display="";
		warcommentt="Yes";
	}
	else
	{ 
		//document.getElementById("unitdamagedopt").style.visibility="hidden";
		document.getElementById("warcomment").style.display='none';
		document.repunitform.newdamageoption.style.visibility='hidden';
		warcommentt="No";
	}
}
var state = 'none';

function showwarcom(layer_ref) {
	//alert("MAin VAlue" +layer_ref);

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
function regcomplaint(PageName)
{
	try{
		 //alert(e);
		// var PageName = document.getElementById("PageName").value;
		// PageName = "bcndsjh";
	window.open('../RegisterComplaint.jsp?PageName='+PageName,'Win','width=730,height=400,top=200,left=200,scrollbars=yes');	 
	 }catch(e)
	 {
		 alert(e);
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
function ckdate(dob)
{


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
				alert("DOB date should not be greater than or equal to Todays date");
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

function ckdateM(dob)
{
	 
	//alert("DOB is >>" +dob);
	var date1=document.getElementById("MedicalExamdate").value;
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

		if(yy11<yy22)
		{
			alert("Medical Expiry should be greater than Medical Exam date");
			document.getElementById("MediclExpDate").value="";
			return false;
		}
		else if(yy11==yy22)
		{
				if(mm11<mm22)
			{
					alert("Medical Expiry should be greater than Medical Exam date");
					document.getElementById("MediclExpDate").value="";
					
				return false;
			}
				else if(mm11==mm22)
				{
					if(dd11<dd22)
					{
						alert("Medical Expiry should be greater than Medical Exam date");
						document.getElementById("MediclExpDate").value="";
						
						return false;
					}
				}
		}
}


function validate()
{
	var name=document.getElementById("drivername").value;
	  var letter = /^[A-Za-z]+$/;
	  
		var fname=document.getElementById("driverfather").value;
		  var letter1 = /^[A-Za-z-0-9]+$/;

		    var numericExpressionn = /^[.0-9]+$/;
			var othname=name.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
		    var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";

			var Education=document.getElementById("Education").value;
			var vendor=document.getElementById("vendor").value;
			var licenceno=document.getElementById("licenceno").value;
			var LicenseType=document.getElementById("LicenseType").value;
			var LicensePlace=document.getElementById("LicensePlace").value;
			var MedicalExam=document.getElementById("MedicalExam").value;
			var BasicTrainingCompany=document.getElementById("BasicTrainingCompany").value;
			var BasicTrainerName=document.getElementById("BasicTrainerName").value;
			var BasicComments=document.getElementById("BasicComments").value;
			var Module1TrainerName=document.getElementById("Module1TrainerName").value;
			var Module1TrainingCompany=document.getElementById("Module1TrainingCompany").value;
			var Module1Comments=document.getElementById("Module1Comments").value;
			var Module2TrainerName=document.getElementById("Module2TrainerName").value;
			var Module2TrainingCompany=document.getElementById("Module2TrainingCompany").value;
			var Module2Comments=document.getElementById("Module2Comments").value;

			var Module3TrainerName=document.getElementById("Module3TrainerName").value;
			var Module3TrainingCompany=document.getElementById("Module3TrainingCompany").value;
			var Module3Comments=document.getElementById("Module3Comments").value;

			var Module4TrainerName=document.getElementById("Module4TrainerName").value;
			var Module4TrainingCompany=document.getElementById("Module4TrainingCompany").value;
			var Module4Comments=document.getElementById("Module4Comments").value;

			var Module5TrainerName=document.getElementById("Module5TrainerName").value;
			var Module5TrainingCompany=document.getElementById("Module5TrainingCompany").value;
			var Module5Comments=document.getElementById("Module5Comments").value;

			var Capsule1TrainerName=document.getElementById("Capsule1TrainerName").value;
			var Capsule1TrainingCompany=document.getElementById("Capsule1TrainingCompany").value;
			var Capsule1Comments=document.getElementById("Capsule1Comments").value;

			var Capsule2TrainerName=document.getElementById("Capsule2TrainerName").value;
			var Capsule2TrainingCompany=document.getElementById("Capsule2TrainingCompany").value;
			var Capsule2Comments=document.getElementById("Capsule2Comments").value;

			var Capsule3TrainerName=document.getElementById("Capsule3TrainerName").value;
			var Capsule3TrainingCompany=document.getElementById("Capsule3TrainingCompany").value;
			var Capsule3Comments=document.getElementById("Capsule3Comments").value;

			var BTDTrainerName=document.getElementById("BTDTrainerName").value;
			var BTDTrainingCompany=document.getElementById("BTDTrainingCompany").value;
			var BTDComments=document.getElementById("BTDComments").value;

			var ORATrainerName=document.getElementById("ORATrainerName").value;
			var ORATrainingCompany=document.getElementById("ORATrainingCompany").value;
			var ORAComments=document.getElementById("ORAComments").value;
			

			
			var fname=document.getElementById("driverfather").value;
			var fname=document.getElementById("driverfather").value;



			var PreTest40MM=document.getElementById("PreTest40MM").value;
			var PostTest40MM=document.getElementById("PostTest40MM").value;
			var Typeofvehicle=document.getElementById("Typeofvehicle").value;
			
//alert("hi " +PostTest);
//alert("hi1 " +spPostTest[1]);
//alert("length " +spPostTest[1].length);

//alert("value is " +spPreTest[1]);
	
//alert(" lengthh is"+spPreTest[1].length);

			
			var Drivingschooleducationgrade=document.getElementById("Drivingschooleducationgrade").value;
			var LastTraining=document.getElementById("LastTraining").value;
			var FTTraining=document.getElementById("FTTraining").value;
			
			  if(name=="" || othname=="")
				{
					alert("Please enter driver name.");
					return false;
				}
			  for (var i = 0; i < name.length; i++) {
				     if(iChars.indexOf(name.charAt(i)) != -1) {
				    		alert("Please enter character value for driver name.");
				       return false;
				     }
				     }

			  if(name.match(numericExpressionn) && name.length!=0)  
		       {  
		          alert('Please enter only characters value for driver name.');  
		       return false;  
		       }
			
			
			 if(!(fname.match(letter)) && fname.length!=0)  
		     {  
		        alert('Please enter only characters value for Father name.');  
		     return false;  
		     } 

		     
		  if(!(Education.match(letter1)) && Education.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for Education.');  
		     return false;  
		     } 

		  if(!(vendor.match(letter1)) && vendor.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for vendor.');  
		     return false;  
		     } 

		  if(!(licenceno.match(letter1)) && licenceno.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for Licence no.');  
		     return false;  
		     } 

		  if(!(LicenseType.match(letter1)) && LicenseType.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for Licence type.');  
		     return false;  
		     } 



		  if(!(LicensePlace.match(letter1)) && LicensePlace.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for Licence place.');  
		     return false;  
		     } 

		  if(!(MedicalExam.match(letter1)) && MedicalExam.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for medical exam.');  
		     return false;  
		     } 

		  if(!(BasicTrainerName.match(letter1)) && BasicTrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for basic trainer name.');  
		     return false;  
		     } 

		  if(!(BasicTrainingCompany.match(letter1)) && BasicTrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for basic trainer company name.');  
		     return false;  
		     } 

		  if(!(Module1TrainerName.match(letter1)) && Module1TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module1 trainer name.');  
		     return false;  
		     } 

		  if(!(Module1TrainingCompany.match(letter1)) && Module1TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module1 trainer company name.');  
		     return false;  
		     } 

		  if(!(Module1Comments.match(letter1)) && Module1Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module1 comments.');  
		     return false;  
		     } 







		  if(!(Module2TrainerName.match(letter1)) && Module2TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module2 trainer name.');  
		     return false;  
		     } 

		  if(!(Module2TrainingCompany.match(letter1)) && Module2TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module2 trainer company name.');  
		     return false;  
		     } 

		  if(!(Module2Comments.match(letter1)) && Module2Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module2 comments.');  
		     return false;  
		     } 

		  if(!(BasicComments.match(letter1)) && BasicComments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for basic comments.');  
		     return false;  
		     } 



		  if(!(Module3TrainerName.match(letter1)) && Module3TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module3 trainer name.');  
		     return false;  
		     } 

		  if(!(Module3TrainingCompany.match(letter1)) && Module3TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module3 trainer company name.');  
		     return false;  
		     } 

		  if(!(Module3Comments.match(letter1)) && Module3Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module3 comments.');  
		     return false;  
		     } 


		  if(!(Module4TrainerName.match(letter1)) && Module4TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module4 trainer name.');  
		     return false;  
		     } 

		  if(!(Module4TrainingCompany.match(letter1)) && Module4TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module4 trainer company name.');  
		     return false;  
		     } 

		  if(!(Module4Comments.match(letter1)) && Module4Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module4 comments.');  
		     return false;  
		     } 




		  
		  if(!(Module5TrainerName.match(letter1)) && Module5TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module5 trainer name.');  
		     return false;  
		     } 

		  if(!(Module5TrainingCompany.match(letter1)) && Module5TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module5 trainer company name.');  
		     return false;  
		     } 

		  if(!(Module5Comments.match(letter1)) && Module5Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for module5 comments.');  
		     return false;  
		     } 



		  if(!(Capsule1TrainerName.match(letter1)) && Capsule1TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule1 trainer name.');  
		     return false;  
		     } 

		  if(!(Capsule1TrainingCompany.match(letter1)) && Capsule1TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule1 trainer company name.');  
		     return false;  
		     } 

		  if(!(Capsule1Comments.match(letter1)) && Capsule1Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule1 comments.');  
		     return false;  
		     } 



		  if(!(Capsule2TrainerName.match(letter1)) && Capsule2TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule2 trainer name.');  
		     return false;  
		     } 

		  if(!(Capsule2TrainingCompany.match(letter1)) && Capsule2TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule2 trainer company name.');  
		     return false;  
		     } 

		  if(!(Capsule2Comments.match(letter1)) && Capsule2Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule2 comments.');  
		     return false;  
		     } 




		  if(!(Capsule3TrainerName.match(letter1)) && Capsule3TrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule3 trainer name.');  
		     return false;  
		     } 

		  if(!(Capsule3TrainingCompany.match(letter1)) && Capsule3TrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule3 trainer company name.');  
		     return false;  
		     } 

		  if(!(Capsule3Comments.match(letter1)) && Capsule3Comments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for capsule3 comments.');  
		     return false;  
		     } 




		  
		


		  if(!(BTDTrainerName.match(letter1)) && BTDTrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for BTD trainer name.');  
		     return false;  
		     } 

		  if(!(BTDTrainingCompany.match(letter1)) && BTDTrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for BTD trainer company name.');  
		     return false;  
		     } 

		  if(!(BTDComments.match(letter1)) && BTDComments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for BTD comments.');  
		     return false;  
		     } 





		  if(!(ORATrainerName.match(letter1)) && ORATrainerName.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for ORA trainer name.');  
		     return false;  
		     } 

		  if(!(ORATrainingCompany.match(letter1)) && ORATrainingCompany.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for ORA trainer company name.');  
		     return false;  
		     } 

		  if(!(ORAComments.match(letter1)) && ORAComments.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for ORA comments.');  
		     return false;  
		     } 

		  if(!(FTTraining.match(letter1)) && FTTraining.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for FTTraining.');  
		     return false;  
		     }
		  if(!(LastTraining.match(letter1)) && LastTraining.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for Last Training.');  
		     return false;  
		     } 



		  if(!(PreTest40MM.match(numericExpressionn))&& PreTest40MM.length!=0)
		 	{
		 		alert("Please enter Numeric value for PreTest40MM");
		        return false;
		 	 }
			var PreTest=document.getElementById("PreTest%").value;
            //alert("Pretest " +PreTest);
		  try{
					
        var spPreTest=PreTest.split(".");
      //  alert(spPreTest.length());
        if(spPreTest[1].length!=2)
	 	{
	 		alert("Please enter only two digit pretest");
	        return false;
	 	 }
				
		  }catch(e)
			{
				//alert(e);
			}
				
		  
		  


		  
		  if(!(PostTest40MM.match(numericExpressionn))&& PostTest40MM.length!=0)
		 	{
		 		alert("Please enter Numeric value for PostTest40MM");
		        return false;
		 	 }
			var PostTest=document.getElementById("PostTest%").value;
			 	 
try{
		  
			
  var spPostTest=PostTest.split(".");
 
  if(spPostTest[1].length!=2)
	{
		alert("Please enter only two digit posttest");
    return false;
	 }
			
}catch(e)
{
}
	 
		 
		  
		  if(!(Typeofvehicle.match(letter1)) && Typeofvehicle.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value for vehicle type.');  
		     return false;  
		     } 


		  if(!(Drivingschooleducationgrade.match(letter1)) && Drivingschooleducationgrade.length!=0)  
		     {  
		        alert('Please enter only characters or numeric value educational training.');  
		     return false;  
		     } 

		  
		  
		    

	
}







</script>

<%!
Connection conn;
Statement st,st1,st2,st3;

%>

<body bgcolor="#E3E9FF">
<%

String sql=null, driverid="",Transporter="",Basic="",Module1="",Module2="",Module3="",Module4="",Module5="",Capsule1="",Capsule2="",Capsule3="",BTD="",ORA="";


driverid=request.getParameter("driverid");
String driverName=request.getParameter("drivname");
String driverFatherName=request.getParameter("father");
String DOB=request.getParameter("DOB");
String LicenseNo=request.getParameter("LicenseNo");
String transporter=request.getParameter("transporter");
try{
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			st3=conn.createStatement();
			
			String PageName=this.getClass().getName();
			String reportno = "";

			PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
			System.out.println(PageName);
			PageName=PageName.replace("_",".");
			PageName=PageName.replace(".005f","_");
			System.out.println("Final report no which we have used in query "+PageName);	
					
			String sqlcr1 = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName+"'";
			ResultSet rscr = st.executeQuery(sqlcr1);
			if(rscr.next())
			{
				reportno = rscr.getString("ReportNo");
			}
			System.out.println(reportno);	
					
			
			java.util.Date NewDate =new java.util.Date();

			String DateTime=new SimpleDateFormat("dd-MMM-yyyy").format(NewDate);	
			
			
			
			sql="select * from t_drivertraining where Dcode = '"+driverid+"'";
			System.out.println("Update 1 query is " +sql);
			ResultSet rst=st.executeQuery(sql);
			if(rst.next())
			{
%>

<form name="trininginfo1" method="post" action="trininginfo1.jsp?driverid=<%=driverid%>&passportid=<%=driverid %>&driverFatherName=<%=driverFatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&driverName=<%=driverName%>&transporter=<%=transporter%>" onSubmit="" >
<table border="0" align="center" width="100%"> 
<tr><input type="hidden" id="calender" name="calender" value="<%=DateTime %>"></input>

<td align="left">	
					<a href="http://www.mobile-eye.in" target="_blank"><img src="../images/TW-MobileEyeLogo1.PNG" style="height: 50px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
</td>
</tr>
<tr>
<td><input type="hidden" name="PageName" id="PageName" value="<%=PageName %>"/>
		 <a href="#" onclick="regcomplaint('<%=PageName %>')" title="Register Complaint"><font face="Arial" size="2" color="blue">Register Complaint</font></a>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font face="Arial" size="2" color="black"> Report No.: <%=reportno %></font></td></tr>

<tr>
		<td align="left"><input type="submit" name="back" value="BACK" class="formelement" />&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font face="Arial" size="3" color="black">Driver Training Details</font>
		</td>
			</tr></table></form>
<form method="post" action="edittrininginfo1.jsp"  > 

<div class="form_container" style="text-align: center;" align="center">
<div class="ScrollTable" style="height: 440px; overflow:scroll;">
   
<table border="0" width="100%" align="center">
<tr><td>
<table class="stats">
<tr></tr>
<tr><td>
 <table border="0" width="50%" align="center" class="stats">
     
     
        <tr>
		<td align="left" width="30%">
		<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
		<div align="left"><font size="2" >Driver Name  </font></div></td>
        <td width="70%"><div align="left">
		<input id="drivername" name="drivername" type="text" class="element text medium" value="<%=driverName%>" /></div>
		</td>
		</tr>
		
		<tr>
		<td align="center" valign="top"><div align="left"><font size="2" >Personal Details</font></div> </td>
		<td><div  align="left">   
     <a href="#" onClick="showwarcom('div1');"><font size="2" color="blue" >Details</font></a>	</div>
       <div id="div1" style="display:none"> 

	<table border="0" >
	<tr>
		<td align="center"><div align="left"><font size="2" >Father Name</font></div> </td>
        <td><div align="left"><input id="driverfather" name="driverfather" type="text" value="<%=driverFatherName%>" /></div></td>
		</tr>
		<%
	     String Doobdate=rst.getString("DOB");  
	       if(Doobdate.equals("-") || Doobdate.equals("") || Doobdate.equalsIgnoreCase("null"))
	       {
	    	   Doobdate="-";
	       }
	       else{
	       Doobdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Doobdate));
	       }
	       
	       %>
	       <tr>
		<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=Doobdate%>" onchange="ckdate(this.value);" readonly/>
		<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "DOB",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "DOB"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
		<tr>
        <td><div align="left"><font size="2">Education</font></div></td>
        <td><div  align="left"> <input id="Education" name="Education" type="text" value="<%= rst.getString("Education") %>" /> </div> </td>
       	</tr>
       	
	</table>
		</div>
		</td>
		
          </tr>               
        <tr>
		<td align="center"><div align="left"><font size="2" >Transporter </font></div> </td>
		<td> <div  align="left">
						<select name="transporter">
						<option value="<%= rst.getString("Transporter") %>"><%=transporter%></option>
							
							<%
							try{
								String sql1="select Distinct(VehRegno) from t_group where GPName='castrol' order by VehRegno Asc";
								ResultSet rst1=st1.executeQuery(sql1);
							//	System.out.println("i am in transporterr");
								while(rst1.next())
								{
									Transporter=rst1.getString("VehRegno");
							%>
									<option value="<%=Transporter%>"><%=Transporter %></option>
							<% 
							}
							
						}catch (Exception e) 
								{
									System.out.print("Exception"+e);
								} 
	%>
						
						</select>				
				</div>
				</td>
        </tr> 
        
 
           
        
       		
        <tr>
        <td><div align="left"><font size="2">Vendor</font></div></td>
        <%
        if(rst.getString("vendor").equals("-"))
        {
        	%>
            <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="" /> </div> </td>
<%
        }
        else{
        	%>
        	        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="<%= rst.getString("vendor") %>" /> </div> </td>
        	
        	<%
        }
        %>
       	</tr>
       		             
		
		
	
        <tr><td valign="top"><div align="left"><font size="2">LicenseDetails</font></div></td>
         <td><div  align="left">   
      <a href="#" name="warcom" onClick="showwarcom('div2');"><font size="2" color="blue" >Details</font></a></div>
		<br> 
		<div id="div2" style="display:none"> 

	<table border="0">
	        <tr>
		<td align="center"><div  align="left"><font size="2" >License No </font></div></td>
        <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=LicenseNo%>" /> </div> </td>
		</tr>
		<%
	     String Ldate=rst.getString("ExpiryDate");  
		if(Ldate!=null)
    	{
    		try{
			Ldate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Ldate));
    		}catch(Exception e)
    		{
				Ldate="-";

    		}

    	}
    	else{
			Ldate="-";

    	}
	       %>
			<tr>
		<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
		<td><div  align="left">
		    <input type="text" id="licnExpiryDate" name="licnExpiryDate"  value="<%=Ldate%>"  readonly/>
<!--			<img src="../images/calendar.png" id="trigger" border="0">-->
  			<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "licnExpiryDate",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "licnExpiryDate"       // ID of the button
    			}
  				);	
				</script>
		</div></td>
        </tr>
	<tr>
        <td><div align="left"><font size="2">Type</font></div></td>
        <td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value="<%= rst.getString("LicenseType") %>" /> </div> </td>
       	</tr> 
       	 <tr>
		<td align="center"><div align="left"><font size="2" >Place of issue </font> </div>  </td>
        <td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="<%= rst.getString("LicensePlace") %>" />  </div></td>
        </tr>
        

	</table>
		</div>
		</td>
        </tr>
        
       	 
	<tr><td align="center" valign="top"><div align="left"><font size="2" >MedicalExam </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div3');"><font size="2" color="blue" >Details</font></a></div>
<br> 
<div id="div3" style="display:none"> 

	<table border="0">
	 <tr>
		<td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="<%= rst.getString("MedicalExam") %>" /></div>  </td>
		</tr>
		<%
	     String Mdate=rst.getString("MedicalExamdate");  
				     String MEdate=rst.getString("ExpiryDate2");  
		
				     if(Mdate!=null)
			        	{
							try{
			        		Mdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(Mdate));
							}catch(Exception e)
							{
								Mdate="-";

							}

			        	}
			        	else{
							Mdate="-";

			        	}
						if(MEdate!=null)
			        	{
							try{
			        		MEdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(MEdate));
							}catch(Exception e)
							{
								MEdate="-";

							}

			        	}
			        	else{
							MEdate="-";

			        	}
	       %>
	       
	
		<tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value="<%=Mdate%>"  readonly/>
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "MedicalExamdate",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "MedicalExamdate"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
		<tr>
		<td align="center"><div align="left"><font size="2" >ExpiryDate</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="MediclExpDate" name="MediclExpDate"  value="<%=MEdate%>" onchange="ckdateM(this.value);" readonly/>
		<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "MediclExpDate",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "MediclExpDate"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
	</table>
		</div>
		</td>
	</tr>
       
		<tr>
       <td align="center" valign="top"><div align="left"><font size="2" >Training Details</font></div> </td>
       <td><div  align="left">   
       <a href="#" name="warcom" onClick="showwarcom('divt1');"><font size="2" color="blue" >Details</font></a></div>
		<br> 
		<div id="divt1" style="display:none"> 
        <table border="0">
        <%
       // System.out.println(driverid);
        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'";
      System.out.println("Update i First query" +sql5 );
        ResultSet rst5=st1.executeQuery(sql5);
     
        if(rst5.next())
        {  
        	
       	Basic=rst5.getString("Basic");
        Module1=rst5.getString("Module1");
        Module2=rst5.getString("Module2");
        Module3=rst5.getString("Module3");
        Module4=rst5.getString("Module4");
        Module5=rst5.getString("Module5");
        
        
        Capsule1=rst5.getString("Capsule1");
        Capsule2=rst5.getString("Capsule2");
        Capsule3=rst5.getString("Capsule3");
        BTD=rst5.getString("BTD");
        ORA=rst5.getString("ORA");

        
        
        
        
        
        
        
        		if(Basic.equals("-")||Basic.equals("NULL"))
        		{//System.out.println("hfskdjhfskdjhfsdihfsadoipfha");
        %>	<tr>
		       <td align="center" valign="top"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		       <a href="#" name="warcom" onClick="showwarcom('divt2');"><font size="2" color="blue" >Details</font></a></div>
				<br> 
				<div id="divt2" style="display:none"> 

				<table border="0">
				<tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="" readonly/>
					<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		  		  <script type="text/javascript">
		  				Calendar.setup(
		    			{
		      			inputField  : "basicdate",         // ID of the input field
		      			ifFormat    : "%d-%b-%Y",     // the date format
		      			button      : "basicdate"       // ID of the butto n
		    			}
		  				);	
				  </script>
				  </div></td>
		          </tr> 
				
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
				  <td><div  align="left" ><select name="Basic"  class="formElement" >
				<option value="<%=rst.getString("Basic")%>"><%=rst.getString("Basic")%></option>
					<%
					  sql="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst2=st3.executeQuery(sql);
					  while(rst2.next())
					  { %>
					     <option value="<%=rst2.getString("LName") %>"> <%=rst2.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="" /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="" /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
			          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="" /></div>  </td>
			          </tr>
			          </table>
					</div>
					</td>
					</tr>
					<%
        }else{
        	
        	String basedateck=rst.getString("basicdate");
        	System.out.println("Basic Date is " +basedateck);
        	if(basedateck!=null)
        	{
        		try{
        		basedateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(basedateck));
        		}catch(Exception e)
        		{
	        		basedateck="-";

        		}

        	}
        	else{
        		basedateck="-";

	        	System.out.println("Basic Date is Final  " +basedateck);

        	}
        	%>
       				 <tr>
				       <td align="center" valign="top"><div align="left"><font size="2" >Basic</font></div> </td>
				       <td><div  align="left">   
				       <a href="#" name="warcom" onClick="showwarcom('divt3');"><font size="2" color="blue" >Details</font></a></div>
						<br> 
						<div id="divt3" style="display:none"> 

						<table border="0">
						<tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=basedateck%>"  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
				  		   <script type="text/javascript">
		  				Calendar.setup(
		    			{
		      			inputField  : "basicdate",         // ID of the input field
		      			ifFormat    : "%d-%b-%Y",     // the date format
		      			button      : "basicdate"       // ID of the butto n
		    			}
		  				);	
				  </script>
						  </div></td></tr>
				         
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
				  <td><div  align="left"><select name="Basic"  class="formElement">
				<option value="<%=rst.getString("Basic")%>"><%=rst.getString("Basic")%></option>
					<%
					  sql="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst2=st3.executeQuery(sql);
					  while(rst2.next())
					  { %>
					     <option value="<%=rst2.getString("LName") %>"> <%=rst2.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td>
			          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="<%=rst.getString("BasicTrainerName")%>" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="<%=rst.getString("BasicTrainingCompany")%>" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="<%=rst.getString("BasicComments")%>" /></div>  </td>
					          </tr>
					          </table>
							</div>
							</td>
							</tr>
                             
		 					<%
		 					
        }
              				 if(Module1.equals("-")||Module1.equals("NULL"))
              				 {
              					 %>
              					 <tr>
					       <td align="center" valign="top"><div align="left"><font size="2" >Module1</font></div> </td>
					       <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('divt4');"><font size="2" color="blue" >Details</font></a></div>
					<br> 
					<div id="divt4" style="display:none"> 
					
						<table border="0">
							<tr>
							  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					          <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value=""  readonly/>
					  		  <script type="text/javascript">
					  				Calendar.setup(
					    			{
					      			inputField  : "Module1date",         // ID of the input field
					      			ifFormat    : "%d-%b-%Y",     // the date format
					      			button      : "Module1date"       // ID of the button
					    			}
					  				);	
							  </script>
							  </div></td>
					          </tr> 
					          
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
					          <td><div  align="left"><select name="Module1"  class="formElement">
						 		<option value="Select">Select</option>
					<%
					  String sql1="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst6=st3.executeQuery(sql1);
					  while(rst6.next())
					  { %>
					     <option value="<%=rst6.getString("LName") %>"> <%=rst6.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td></tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="" /></div>  </td>
					          </tr>
					          </table>
							</div>
							</td>
							</tr>
               				<%
              				 }
        					else
        					{
        					
        						String m1dateck=rst.getString("Module1date");
        			        	System.out.println("Basic Date is " +m1dateck);
        			        	if(m1dateck!=null)
        			        	{
        			        		try{
        			        		m1dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(m1dateck));
        			        		}catch(Exception e)
        			        		{
        				        		m1dateck="-";

        			        		}
        			        	}
        			        	else{
        			        		m1dateck="-";

        				        	System.out.println("Basic Date is Final  " +m1dateck);

        			        	}
        					
        					
        					
        					%>
		    			    <tr>
       						<td align="center" valign="top"><div align="left"><font size="2" >Module1</font></div> </td>
      						 <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('divt5');"><font size="2" color="blue" >Details</font></a></div>
							<br> 
							<div id="divt5" style="display:none"> 

							<table border="0">
							<tr>
						   <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
         					 <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=m1dateck%>"  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  					<script type="text/javascript">
					  				Calendar.setup(
					    			{
					      			inputField  : "Module1date",         // ID of the input field
					      			ifFormat    : "%d-%b-%Y",     // the date format
					      			button      : "Module1date"       // ID of the button
					    			}
					  				);	
							  </script>
							  </div></td>
					          </tr> 
							 <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
					          <td><div  align="left"><select name="Module1"  class="formElement">
						 		<option value="<%=rst.getString("Module1")%>"><%=rst.getString("Module1")%></option>
					<%
					  String sql1="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst6=st3.executeQuery(sql1);
					  while(rst6.next())
					  { %>
					     <option value="<%=rst6.getString("LName") %>"> <%=rst6.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td></tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="<%=rst.getString("Module1TrainerName")%>" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="<%=rst.getString("Module1TrainingCompany")%>" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="<%=rst.getString("Module1Comments")%>" /></div>  </td>
					          </tr>
			          </table>
					</div>
					</td>
					</tr>
        			  <%
        					}
        			if(Module2.equals("-")||Module2.equals("NULL"))
        				{
        				%>
        				
        				<tr>
          				  <td align="center" valign="top"><div align="left"><font size="2" >Module2</font></div> </td>
          				  <td> <div  align="left">
           				   <a href="#" name="warcom" onClick="showwarcom('divt6');"><font size="2" color="blue" >Details</font></a></div>
 					    <br> 
  						   <div id="divt6" style="display:none"> 

     	<table border="0">
     	 <tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="" readonly />
     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  <script type="text/javascript">
       				Calendar.setup(
         			{
           			inputField  : "Module2date",         // ID of the input field
           			ifFormat    : "%d-%b-%Y",     // the date format
           			button      : "Module2date"       // ID of the button
         			}
       				);	
     		  </script>
     		  </div></td>
               </tr> 
     		
               <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
					          <td><div  align="left"><select name="Module2"  class="formElement">
						 		<option value="Select">Select</option>
					<%
					  String sql23="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst23=st3.executeQuery(sql23);
					  while(rst23.next())
					  { %>
					     <option value="<%=rst23.getString("LName") %>"> <%=rst23.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td></tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
               <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="" /></div>  </td>
               </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
               <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="" /></div>  </td>
               </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
               <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="" /></div>  </td>
               </tr>
               </table>
     		</div>
     		</td>
     		</tr>        
     		<% 
        }
        else
        {String m2dateck=rst.getString("Module2date");
    	System.out.println("Basic Date is " +m2dateck);
    	if(m2dateck!=null)
    	{
    		try{
    		m2dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(m2dateck));
    		}catch(Exception e)
    		{
        		m2dateck="-";

    		}
    	}
    	else{
    		m2dateck="-";

        	System.out.println("Basic Date is Final  " +m2dateck);

    	}%>       
			<tr>
       <td align="center" valign="top"><div align="left"><font size="2" >Module2</font></div> </td>
       <td> <div  align="left">
        <a href="#" name="warcom" onClick="showwarcom('divt7');"><font size="2" color="blue" >Details</font></a></div>
<br> 
<div id="divt7" style="display:none"> 

	<table border="0" >
	 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=m2dateck%>"  readonly/>
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
       				Calendar.setup(
         			{
           			inputField  : "Module2date",         // ID of the input field
           			ifFormat    : "%d-%b-%Y",     // the date format
           			button      : "Module2date"       // ID of the button
         			}
       				);	
     		  </script>
		  </div></td>
          </tr> 
		
          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
					          <td><div  align="left"><select name="Module2"  class="formElement">
						 		<option value="<%=rst.getString("Module2")%>"><%=rst.getString("Module2")%></option>
					<%
					  String sql24="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst24=st3.executeQuery(sql24);
					  while(rst24.next())
					  { %>
					     <option value="<%=rst24.getString("LName") %>"> <%=rst24.getString("LName") %> </option>
					<% } %>
					    
					   </select></div>  </td></tr>
          
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="<%=rst.getString("Module2TrainerName")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="<%=rst.getString("Module2TrainingCompany")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="<%=rst.getString("Module2Comments")%>" /></div>  </td>
          </tr>
          </table>
		</div>
		</td>
		</tr>              
        <%}
        	if(Module3.equals("-")||Module3.equals("NULL"))
        	{
        		%>
        		
        		 <tr>
        <td align="center" valign="top"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('divt8');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="divt8" style="display:none"> 

		<table border="0">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="" readonly  />
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "Module3date",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "Module3date"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
          <td><div  align="left"><select name="Module3"  class="formElement">
	 		<option value="Select">Select</option>
<%
  String sql3="select LName from  db_CustomerComplaints.t_location order by LName";
  ResultSet rst3=st3.executeQuery(sql3);
  while(rst3.next())
  { %>
     <option value="<%=rst3.getString("LName") %>"> <%=rst3.getString("LName") %> </option>
<% } %>
     <option value="Other"> Other </option>
   </select></div>  </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value="" /></div>  </td>
          </tr>
          </table>
		</div>
		</td>
		</tr>
        		<%
        	}else
        	{
        		 String m3dateck=rst.getString("Module3date");
			        	System.out.println("Basic Date is " +m3dateck);
			        	if(m3dateck!=null)
			        	{
			        		try{
			        		m3dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(m3dateck));
			        		}catch(Exception e)
			        		{
				        		m3dateck="-";

			        		}
			        	}
			        	else{
			        		m3dateck="-";

				        	System.out.println("Basic Date is Final  " +m3dateck);

			        	}%>		 <tr>
        <td align="center" valign="top"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('divt9');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="divt9" style="display:none"> 

		<table border="0">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=m3dateck%>" readonly/>
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		   <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "Module3date",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "Module3date"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
         	
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
          <td><div  align="left"><select name="Module3"  class="formElement">
	 		<option value="<%=rst.getString("Module3")%>"><%=rst.getString("Module3")%></option>
<%
  String sql3="select LName from  db_CustomerComplaints.t_location order by LName";
  ResultSet rst3=st3.executeQuery(sql3);
  while(rst3.next())
  { %>
     <option value="<%=rst3.getString("LName") %>"> <%=rst3.getString("LName") %> </option>
<% } %>
     
   </select></div>  </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="<%=rst.getString("Module3TrainerName")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="<%=rst.getString("Module3TrainingCompany")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value="<%=rst.getString("Module3Comments")%>" /></div>  </td>
          </tr>
          </table>
		</div>
		</td>
		</tr>
		 <%}
        	if(Module4.equals("-")||Module4.equals("NULL"))
        	{
        		%>
       					<tr>
      					 <td align="center" valign="top"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('divt10');"><font size="2" color="blue">Details</font></a></div>
						<br> 
						<div id="divt10" style="display:none"> 
						<table border="0">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value=""  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  						  <script type="text/javascript">
  							Calendar.setup(
    						{
      						inputField  : "Module4date",         // ID of the input field
      						ifFormat    : "%d-%b-%Y",     // the date format
      						button      : "Module4date"       // ID of the button
    						}
  							);	
		 			 </script>
					  </div></td>
       				   </tr> 
          
        				  <tr>
		 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
         				 <td><div  align="left"><select name="Module4"  class="formElement">
	 					<option value="Select">Select</option>
						<%
 						 String sql4="select LName from  db_CustomerComplaints.t_location order by LName";
 						 ResultSet rst4=st3.executeQuery(sql4);
 						 while(rst4.next())
						  { %>
  						   <option value="<%=rst4.getString("LName") %>"> <%=rst4.getString("LName") %> </option>
						<% } %>
 					    <option value="Other"> Other </option>
  						 </select></div>  </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="" /></div>  </td>
          </tr>
		</table>
		</div>
		</td>
		</tr>
		   <%
        	}
		   else
		   {
		  
			   String m4dateck=rst.getString("Module4date");
	        	System.out.println("Basic Date is " +m4dateck);
	        	if(m4dateck!=null)
	        	{
	        		try{
	        		m4dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(m4dateck));
	        		}catch(Exception e)
	        		{
		        		m4dateck="-";

	        		}
	        	}
	        	else{
	        		m4dateck="-";

		        	System.out.println("Basic Date is Final  " +m4dateck);

	        	}
			   
			   
			   
			   %>
		    					<tr>
      					 <td align="center" valign="top"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						 <a href="#" name="warcom" onClick="showwarcom('divt11');"><font size="2" color="blue">Details</font></a></div>
						<br> 
						<div id="divt11" style="display:none"> 
						<table border="0">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=m4dateck%>" readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  						  <script type="text/javascript">
  							Calendar.setup(
    						{
      						inputField  : "Module4date",         // ID of the input field
      						ifFormat    : "%d-%b-%Y",     // the date format
      						button      : "Module4date"       // ID of the button
    						}
  							);	
		 			 </script>
					  </div></td>
       				   </tr> 
          
        				<tr>
		 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
         				 <td><div  align="left"><select name="Module4"  class="formElement">
	 					<option value="<%=rst.getString("Module4")%>"><%=rst.getString("Module4")%></option>
						<%
 						 String sql4="select LName from  db_CustomerComplaints.t_location order by LName";
 						 ResultSet rst4=st3.executeQuery(sql4);
 						 while(rst4.next())
						  { %>
  						   <option value="<%=rst4.getString("LName") %>"> <%=rst4.getString("LName") %> </option>
						<% } %>
 					   
  						 </select></div>  </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="<%=rst.getString("Module4TrainerName")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="<%=rst.getString("Module4TrainingCompany")%>"/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="<%=rst.getString("Module4Comments")%>"/></div>  </td>
          </tr>
		</table>
		</div>
		</td>
		</tr>
		   <%}
		   if(Module5.equals("-")||Module5.equals("NULL")){
			   %>
					<tr>
					 <td align="center" valign="top"><div align="left"><font size="2" >Module5</font></div> </td>
				 <td> <div  align="left">
				<a href="#" name="warcom" onClick="showwarcom('divt12');"><font size="2" color="blue">Details</font></a></div>
				<br> 
				<div id="divt12" style="display:none"> 
				<table border="0">             
				    <tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value=""  readonly/>
					<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
					  <script type="text/javascript">
						Calendar.setup(
					{
						inputField  : "Module5date",         // ID of the input field
						ifFormat    : "%d-%b-%Y",     // the date format
						button      : "Module5date"       // ID of the button
					}
						);	
			 </script>
			  </div></td>
				   </tr> 
				  <tr>
				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
				 <td><div  align="left"><select name="Module5"  class="formElement">
				<option value="Select">Select</option>
				<%
				 String sql44="select LName from  db_CustomerComplaints.t_location order by LName";
				 ResultSet rst44=st3.executeQuery(sql44);
				 while(rst44.next())
				  { %>
					   <option value="<%=rst44.getString("LName") %>"> <%=rst44.getString("LName") %> </option>
				<% } %>
			    <option value="Other"> Other </option>
					 </select></div>  </td></tr>
 <tr>
 <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
 <td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="" /></div>  </td>
 </tr>
 <tr>
 <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
 <td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="" /></div>  </td>
 </tr>
 <tr>
 <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
 <td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="" /></div>  </td>
 </tr>
</table>
</div>
</td>
</tr>
  <%
		   }else{
			   String m5dateck=rst.getString("Module5date");
	        	System.out.println("Basic Date is " +m5dateck);
	        	if(m5dateck!=null)
	        	{
	        		try{
	        		m5dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(m5dateck));
	        		}catch(Exception e)
	        		{
		        		m5dateck="-";

	        		}
	        	}
	        	else{
	        		m5dateck="-";

		        	System.out.println("Basic Date is Final  " +m5dateck);

	        	}
			   
			   
			   %>
				<tr>
			 <td align="center" valign="top"><div align="left"><font size="2" >Module5</font></div> </td>
		 <td> <div  align="left">
		 <a href="#" name="warcom" onClick="showwarcom('divt13');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="divt13" style="display:none"> 
		<table border="0">             
		    <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
			    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=m5dateck%>" readonly/>
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
			  <script type="text/javascript">
				Calendar.setup(
			{
				inputField  : "Module5date",         // ID of the input field
				ifFormat    : "%d-%b-%Y",     // the date format
				button      : "Module5date"       // ID of the button
			}
				);	
	 </script>
	  </div></td>
		   </tr> 

		<tr>
		 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		 <td><div  align="left"><select name="Module5"  class="formElement">
		<option value="<%=rst.getString("Module5")%>"><%=rst.getString("Module5")%></option>
		<%
		 String sql44="select LName from  db_CustomerComplaints.t_location order by LName";
		 ResultSet rst44=st3.executeQuery(sql44);
		 while(rst44.next())
		  { %>
			   <option value="<%=rst44.getString("LName") %>"> <%=rst44.getString("LName") %> </option>
		<% } %>
	   
			 </select></div>  </td></tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="<%=rst.getString("Module5TrainerName")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="<%=rst.getString("Module5TrainingCompany")%>"/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="<%=rst.getString("Module5Comments")%>"/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>

<%} 

 
		   if(Capsule1.equals("-")||Capsule1.equals("NULL")){
			   %>

			
		<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 1</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt14');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt14" style="display:none"> 
       								<table border="0">             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule1date" name="Capsule1date"  value=""  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "Capsule1date",         // ID of the input field
       		      						ifFormat    : "%d-%b-%Y",     // the date format
       		      						button      : "Capsule1date"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left">
       		         				 <select name="Capsule1"  class="formElement">
       			 					<option value="Select">Select</option>
       								<%
       		 						 String sqlC1="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rstc1=st3.executeQuery(sqlC1);
       		 						 while(rstc1.next())
       								  { %>
       		  						   <option value="<%=rstc1.getString("LName") %>"> <%=rstc1.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainerName" name="Capsule1TrainerName" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainingCompany" name="Capsule1TrainingCompany" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1Comments" name="Capsule1Comments" type="text" value="" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
				
				
	<%}else{ 
	
		String c1dateck=rst.getString("Capsule1date");
    	System.out.println("Basic Date is " +c1dateck);
    	if(c1dateck!=null)
    	{
    		try{
    		c1dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(c1dateck));
    		}catch(Exception e)
    		{
        		c1dateck="-";

    		}
    	}
    	else{
    		c1dateck="-";

        	System.out.println("Basic Date is Final  " +c1dateck);

    	}
	
	
	%>			
				
				<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 1</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt15');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt15" style="display:none"> 
       								<table border="0">             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule1date" name="Capsule1date"  value="<%=c1dateck%>"  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "Capsule1date",         // ID of the input field
       		      						ifFormat    : "%d-%b-%Y",     // the date format
       		      						button      : "Capsule1date"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left">
       		         				 <select name="Capsule1"  class="formElement">
       			 					<option value="<%=rst.getString("Capsule1")%>"><%=rst.getString("Capsule1")%></option>
       								<%
       		 						 String sqlC1="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rstc1=st3.executeQuery(sqlC1);
       		 						 while(rstc1.next())
       								  { %>
       		  						   <option value="<%=rstc1.getString("LName") %>"> <%=rstc1.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainerName" name="Capsule1TrainerName" type="text" value="<%=rst.getString("Capsule1TrainerName")%>" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainingCompany" name="Capsule1TrainingCompany" type="text" value="<%=rst.getString("Capsule1TrainingCompany")%>" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1Comments" name="Capsule1Comments" type="text" value="<%=rst.getString("Capsule1Comments")%>" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
				
				
				
				
				<%} 

		   
		   if(Capsule2.equals("-")||Capsule2.equals("NULL")){
			  
				
				
				
				%>
			
			
			
			<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 2</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt16');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt16" style="display:none"> 
       								<table border="0">             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule2date" name="Capsule2date"  value=""  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "Capsule2date",         // ID of the input field
       		      						ifFormat    : "%d-%b-%Y",     // the date format
       		      						button      : "Capsule2date"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left"><select name="Capsule2"  class="formElement">
       			 					<option value="Select">Select</option>
       								<%
       		 						 String sqlc2="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rstc2=st3.executeQuery(sqlc2);
       		 						 while(rstc2.next())
       								  { %>
       		  						   <option value="<%=rstc2.getString("LName") %>"> <%=rstc2.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule2TrainerName" name="Capsule2TrainerName" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule2TrainingCompany" name="Capsule2TrainingCompany" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule2Comments" name="Capsule2Comments" type="text" value="" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
			<%}else{
				
				String c2dateck=rst.getString("Capsule2date");
	        	System.out.println("Basic Date is " +c2dateck);
	        	if(c2dateck!=null)
	        	{
	        		try{
	        		c2dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(c2dateck));
	        		}catch(Exception e)
	        		{
		        		c2dateck="-";

	        		}
	        	}
	        	else{
	        		c2dateck="-";

		        	System.out.println("Basic Date is Final  " +c2dateck);

	        	}
	      		  
				
				
				
				%>
				<tr>
					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 2</font></div> </td>
  				 <td> <div  align="left">
					<a href="#" name="warcom" onClick="showwarcom('divt17');"><font size="2" color="blue">Details</font></a></div>
					<br> 
					<div id="divt17" style="display:none"> 
					<table border="0">             
				    <tr>
					  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					    <td> <div  align="left"><input type="text" id="Capsule2date" name="Capsule2date"  value="<%=c2dateck%>"  readonly/>
						<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
					  <script type="text/javascript">
						Calendar.setup(
						{
						inputField  : "Capsule2date",         // ID of the input field
						ifFormat    : "%d-%b-%Y",     // the date format
						button      : "Capsule2date"       // ID of the button
						}
						);	
	 			 </script>
				  </div></td>
 				   </tr> 
    
  				  <tr>
	 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
   				 <td><div  align="left">
   				 <select name="Capsule2"  class="formElement">
					<option value="<%=rst.getString("Capsule2")%>"><%=rst.getString("Capsule2")%></option>
					<%
					 String sqlC1="select LName from  db_CustomerComplaints.t_location order by LName";
					 ResultSet rstc1=st3.executeQuery(sqlC1);
					 while(rstc1.next())
					  { %>
					   <option value="<%=rstc1.getString("LName") %>"> <%=rstc1.getString("LName") %> </option>
					<% } %>
				    <option value="Other"> Other </option>
					 </select></div>  </td></tr>
    <tr>
	  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
    <td> <div  align="left"><input id="Capsule2TrainerName" name="Capsule2TrainerName" type="text" value="<%=rst.getString("Capsule2TrainerName")%>" /></div>  </td>
    </tr>
    <tr>
	  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
    <td> <div  align="left"><input id="Capsule2TrainingCompany" name="Capsule2TrainingCompany" type="text" value="<%=rst.getString("Capsule2TrainingCompany")%>" /></div>  </td>
    </tr>
    <tr>
	  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
    <td> <div  align="left"><input id="Capsule2Comments" name="Capsule2Comments" type="text" value="<%=rst.getString("Capsule2Comments")%>" /></div>  </td>
    </tr>
	</table>
	</div>
	</td>
	</tr>	

			<%
				
				
				}
				
				
		   if(Capsule3.equals("-")||Capsule3.equals("NULL")){
				
				%>
	
			
		
			
			
			<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 3</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt18');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt18" style="display:none"> 
       								<table border="0" >             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule3date" name="Capsule3date"  value=""  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "Capsule3date",         // ID of the input field
       		      						ifFormat    : "%d-%b-%Y",     // the date format
       		      						button      : "Capsule3date"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left"><select name="Capsule3"  class="formElement">
       			 					<option value="Select">Select</option>
       								<%
       		 						 String sqlc3="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rstc3=st3.executeQuery(sqlc3);
       		 						 while(rstc3.next())
       								  { %>
       		  						   <option value="<%=rstc3.getString("LName") %>"> <%=rstc3.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule3TrainerName" name="Capsule3TrainerName" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule3TrainingCompany" name="Capsule3TrainingCompany" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule3Comments" name="Capsule3Comments" type="text" value="" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
		<%}else{
			
			
			String c3dateck=rst.getString("Capsule3date");
        	System.out.println("Basic Date is " +c3dateck);
        	if(c3dateck!=null)
        	{
        		try{
        		c3dateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(c3dateck));
        		}catch(Exception e)
        		{
	        		c3dateck="-";

        		}
        	}
        	else{
        		c3dateck="-";

	        	System.out.println("Basic Date is Final  " +c3dateck);

        	}
			
			
			
			
			
			
			%>
			<tr>
			 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 3</font></div> </td>
			 <td> <div  align="left">
			<a href="#" name="warcom" onClick="showwarcom('divt19');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divt19" style="display:none"> 
			<table border="0">             
		    <tr>
			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
			    <td> <div  align="left"><input type="text" id="Capsule3date" name="Capsule3date"  value="<%=c3dateck%>"  readonly/>
				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
			  <script type="text/javascript">
				Calendar.setup(
				{
				inputField  : "Capsule3date",         // ID of the input field
				ifFormat    : "%d-%b-%Y",     // the date format
				button      : "Capsule3date"       // ID of the button
				}
				);	
		 </script>
		  </div></td>
		   </tr> 

			  <tr>
			 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			 <td><div  align="left">
			 <select name="Capsule3"  class="formElement">
			<option value="<%=rst.getString("Capsule3")%>"><%=rst.getString("Capsule3")%></option>
			<%
			 String sqlC1="select LName from  db_CustomerComplaints.t_location order by LName";
			 ResultSet rstc1=st3.executeQuery(sqlC1);
			 while(rstc1.next())
			  { %>
			   <option value="<%=rstc1.getString("LName") %>"> <%=rstc1.getString("LName") %> </option>
			<% } %>
		    <option value="Other"> Other </option>
			 </select></div>  </td></tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="Capsule3TrainerName" name="Capsule3TrainerName" type="text" value="<%=rst.getString("Capsule3TrainerName")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="Capsule3TrainingCompany" name="Capsule3TrainingCompany" type="text" value="<%=rst.getString("Capsule3TrainingCompany")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="Capsule3Comments" name="Capsule3Comments" type="text" value="<%=rst.getString("Capsule3Comments")%>" /></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	
<%
			
			
			}
			
		   if(BTD.equals("-")||BTD.equals("NULL")){
			
			%>	
			
			
			<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >Bulk Tanker Driver details</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt20');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt20" style="display:none"> 
       								<table border="0" >             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="BTDdate" name="BTDdate"  value=""  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "BTDdate",         // ID of the input field
       		      						ifFormat    : "%d-%b-%Y",     // the date format
       		      						button      : "BTDdate"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left"><select name="BTD"  class="formElement">
       			 					<option value="Select">Select</option>
       								<%
       		 						 String sqlBTD="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rstbtd=st3.executeQuery(sqlBTD);
       		 						 while(rstbtd.next())
       								  { %>
       		  						   <option value="<%=rstbtd.getString("LName") %>"> <%=rstbtd.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="BTDTrainerName" name="BTDTrainerName" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="BTDTrainingCompany" name="BTDTrainingCompany" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="BTDComments" name="BTDComments" type="text" value="" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
			<%}else{
				
				 String btddateck=rst.getString("BTDdate");
		        	System.out.println("Basic Date is " +btddateck);
		        	if(btddateck!=null)
		        	{
		        		try{
		        		btddateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(btddateck));
		        		}catch(Exception e)
		        		{
			        		btddateck="-";
		        		}
		        	}
		        	else{
		        		btddateck="-";

			        	System.out.println("Basic Date is Final  " +btddateck);

		        	}
			    
				
				
				
				
				%>
				<tr>
			 <td align="center" valign="top"><div align="left"><font size="2" >Bulk Tanker Driver details</font></div> </td>
			 <td> <div  align="left">
			<a href="#" name="warcom" onClick="showwarcom('divt21');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divt21" style="display:none"> 
			<table border="0" >             
		    <tr>
			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
			    <td> <div  align="left"><input type="text" id="BTDdate" name="BTDdate"  value="<%=btddateck%>"  readonly/>
				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
			  <script type="text/javascript">
				Calendar.setup(
				{
				inputField  : "BTDdate",         // ID of the input field
				ifFormat    : "%d-%b-%Y",     // the date format
				button      : "BTDdate"       // ID of the button
				}
				);	
		 </script>
		  </div></td>
		   </tr> 

			  <tr>
			 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			 <td><div  align="left">
			 <select name="BTD"  class="formElement">
			<option value="<%=rst.getString("BTD")%>"><%=rst.getString("BTD")%></option>
			<%
			 String sqlC1="select LName from  db_CustomerComplaints.t_location order by LName";
			 ResultSet rstc1=st3.executeQuery(sqlC1);
			 while(rstc1.next())
			  { %>
			   <option value="<%=rstc1.getString("LName") %>"> <%=rstc1.getString("LName") %> </option>
			<% } %>
		    <option value="Other"> Other </option>
			 </select></div>  </td></tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="BTDTrainerName" name="BTDTrainerName" type="text" value="<%=rst.getString("BTDTrainerName")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="BTDTrainingCompany" name="BTDTrainingCompany" type="text" value="<%=rst.getString("BTDTrainingCompany")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="BTDComments" name="BTDComments" type="text" value="<%=rst.getString("BTDComments")%>" /></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	
				<%
				
				
				}
				
		  
		   if(ORA.equals("-")||ORA.equals("NULL")){

				%>
			
			
			
			<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >On road assessment details</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt22');"><font size="2"color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt22" style="display:none"> 
       								<table border="0" > .
       								
       								
       								 <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >Vehicle Type</font></div></td>
       		         				 <td><div  align="left"><select name="ORAvehType"  class="formElement">
       			 					<option value="Select">Select</option>
       								
       		 					    <option value="Truk"> Truk </option>
       		  						 </select></div>  </td></tr>
       								
       								
       								     
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="ORAdate" name="ORAdate"  value=""  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "ORAdate",         // ID of the input field
       		      						ifFormat    : "%d-%b-%Y",     // the date format
       		      						button      : "ORAdate"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left"><select name="ORA"  class="formElement">
       			 					<option value="Select">Select</option>
       								<%
       		 						 String sqlORA="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rstora=st3.executeQuery(sqlORA);
       		 						 while(rstora.next())
       								  { %>
       		  						   <option value="<%=rstora.getString("LName") %>"> <%=rstora.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="ORATrainerName" name="ORATrainerName" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="ORATrainingCompany" name="ORATrainingCompany" type="text" value="" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="ORAComments" name="ORAComments" type="text" value="" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
<%}else{
	
	
	String oradateck=rst.getString("ORAdate");
	System.out.println("Basic Date is " +oradateck);
	if(oradateck!=null)
	{
		try{
		oradateck=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(oradateck));
		}catch(Exception e)
		{
    		oradateck="-";

		}
	}
	else{
		oradateck="-";

    	System.out.println("Basic Date is Final  " +oradateck);

	}
	
	
	
	%>
	
	
	<tr>
			 <td align="center" valign="top"><div align="left"><font size="2" >On road assessment details</font></div> </td>
			 <td> <div  align="left">
			<a href="#" name="warcom" onClick="showwarcom('divt23');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divt23" style="display:none"> 
			<table border="0">      
			
			<tr>
			 <td align="center"><div  align="left"><font size="2" >Vehicle Type</font></div></td>
			 <td><div  align="left">
			 <select name="ORAvehType"  class="formElement">
			<option value="<%=rst.getString("ORAVehType")%>"><%=rst.getString("ORAVehType")%></option>
					    <option value="Truk"> Truk </option>
			
		    <option value="Other"> Other </option>
			 </select></div>  </td></tr>
			
			
			
			      
		    <tr>
			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
			    <td> <div  align="left"><input type="text" id="ORAdate" name="ORAdate"  value="<%=oradateck%>"  readonly/>
				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
			  <script type="text/javascript">
				Calendar.setup(
				{
				inputField  : "ORAdate",         // ID of the input field
				ifFormat    : "%d-%b-%Y",     // the date format
				button      : "ORAdate"       // ID of the button
				}
				);	
		 </script>
		  </div></td>
		   </tr> 

			  <tr>
			 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			 <td><div  align="left">
			 <select name="ORA"  class="formElement">
			<option value="<%=rst.getString("ORA")%>"><%=rst.getString("ORA")%></option>
			<%
			 String sqlC1="select LName from  db_CustomerComplaints.t_location order by LName";
			 ResultSet rstc1=st3.executeQuery(sqlC1);
			 while(rstc1.next())
			  { %>
			   <option value="<%=rstc1.getString("LName") %>"> <%=rstc1.getString("LName") %> </option>
			<% } %>
		    <option value="Other"> Other </option>
			 </select></div>  </td></tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="ORATrainerName" name="ORATrainerName" type="text" value="<%=rst.getString("ORATrainerName")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="ORATrainingCompany" name="ORATrainingCompany" type="text" value="<%=rst.getString("ORATrainingCompany")%>" /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="ORAComments" name="ORAComments" type="text" value="<%=rst.getString("ORAComments")%>" /></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	
	
	
	
	
	
	
	
	
	<%
} }
	%>





       
      
           </table>
		</div>
		</td>
		</tr>         
          <tr>
		  <td align="center"><div  align="left"><font size="2" >Remark</font></div></td>
          <td> <div  align="left"><input id="remark" name="remark" type="text" value="<%= rst.getString("remark") %>" /></div>  </td>
          </tr> 
          
          <tr><td align="center" valign="top"><div align="left"><font size="2" >FT Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div15');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div15" style="display:none"> 

	<table border="0">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
          <td><div  align="left">&nbsp;&nbsp;<input id="FTTraining" name="FTTraining" type="text" value="<%= rst.getString("FTTraining") %>" /> </div> </td>
          </tr> 
          <%
          String FTTdate=rst.getString("FTTrainingdate");  
          if(FTTdate!=null)
      	{
				try{
				FTTdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(FTTdate));
				}catch(Exception e)
				{
					FTTdate="-";

				}
      	}
			else{
				FTTdate="-";

	        	System.out.println("FTTdate Date is Final  " +FTTdate);

      	}
					 %>
          <tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		&nbsp;&nbsp;<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value="<%=FTTdate%>"  readonly/>
		<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "FTTrainingdate",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "FTTrainingdate"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
		
	</table>
		</div>
		</td>
	</tr>
          
          <tr><td align="center" valign="top"><div align="left"><font size="2" >Last Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div16');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div16" style="display:none"> 

	<table border="0">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >Last Training</font> </div> </td>
          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="<%= rst.getString("LastTraining") %>" /></div>  </td>
          </tr> 
                <%
          String LTdate=rst.getString("LastTrainingDate");  
		
                if(LTdate!=null)
	        	{
					try{
					LTdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(LTdate));
					}catch(Exception e)
					{
						LTdate="-";

					}
	        	}
				else{
					LTdate="-";

		        	System.out.println("LTdate Date is Final  " +LTdate);

	        	}
					 %>          
          <tr>
		  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="<%=LTdate%>"  readonly/>
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "LastTrainingDate",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "LastTrainingDate"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
	</table>
		</div>
		</td>
	</tr>
          
		
          
                             
            <tr>
        	<td><div align="left"><font size="2">PreTest 40 MM.</font></div></td>
            <td><div  align="left"> <input id="PreTest40MM" name="PreTest40MM" type="text" value="<%= rst.getString("PreTest40MM") %>" /> </div> </td>
       		</tr>
       		
       		<tr>
       		<td><div align="left"><font size="2">PreTest %</font></div></td>
       		<td><div  align="left"> <input id="PreTest%" name="PreTest%" type="text" value="<%= rst.getString("PreTestper") %>" /> </div> </td>
      		</tr>
        	<tr>
        	<td><div align="left"><font size="2">PostTest 40 MM.</font></div></td>
        	<td><div  align="left"> <input id="PostTest40MM" name="PostTest40MM" type="text" value="<%= rst.getString("PostTest40MM") %>" /> </div> </td>
        	</tr>
     	    <tr>
        	<td><div align="left"><font size="2">PostTest%.</font></div></td>
        	<td><div  align="left"> <input id="PostTest%" name="PostTest%" type="text" value="<%= rst.getString("PostTestper") %>" /> </div> </td>
       		</tr>
    	    <tr>
        	<td><div align="left"><font size="2">Type of vehicle used for on road coaching and for assessment</font></div></td>
        	<td><div  align="left"> <input id="Typeofvehicle" name="Typeofvehicle" type="text" value="<%= rst.getString("Typeofvehicle") %>" /> </div> </td>
       		</tr>
     		<tr>
			<td><div align="left"><font size="2">EducationGrade</font></div></td>
			<td><div align="left"><input id="Drivingschooleducationgrade" name="Drivingschooleducationgrade" type="text" value="<%= rst.getString("educationgrade") %>" /> </div> </td>
			</tr>   
                          
                        
 		</table>
        

</td></tr>
<tr>
<td><div align="center"><input  type="submit" value="Submit" onclick="return validate()" ></div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
</div>
</form>
<%
}

else
{

	%>
<form name="trininginfo1" method="post" action="trininginfo1.jsp?driverid=<%=driverid%>&passportid=<%=driverid %>&driverFatherName=<%=driverFatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&driverName=<%=driverName%>&transporter=<%=transporter%>" onSubmit="" >
<table border="0" align="center" width="100%"> 
<tr><input type="hidden" id="calender" name="calender" value="<%=DateTime %>"></input>

<td align="left">	
					<a href="http://www.mobile-eye.in" target="_blank"><img src="../images/TW-MobileEyeLogo1.PNG" style="height: 50px; width: 100px;" title="Mobile-eye" id="logo" alt="Logo" /></a>
</td>
</tr>

<tr>
		<td align="left"><input type="submit" name="back" value="BACK" class="formelement" />&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font face="Arial" size="3" color="black">Driver Training Details</font>
		</td>
			</tr></table></form>
<form method="post" action="edittrininginfo1.jsp"  > 

<div class="form_container" style="text-align: center;" align="center">
<div class="ScrollTable" style="height: 440px; overflow:scroll;">
   
<table border="0" width="100%" align="center"   >
<tr><td>
<table class="stats">
<tr></tr>
<tr><td>
 <table border="0" width="100%" align="center" class="stats">
     
     
     
        <tr>
		<td align="left" width="30%">
		<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
		<div align="left"><font size="2" >Driver Name  </font></div></td>
        <td width><div align="left">
		<input id="drivername" name="drivername" type="text" value="<%=driverName %>" /></div>
		</td>
		</tr>
		
		<tr>
		<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
		<td><div  align="left">   
       <a href="#" name="warcom" onClick="showwarcom('div17');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="div17" style="display:none"> 

	<table border="0" width="100%">
	<tr>
		<td align="center"><div align="left"><font size="2" >Father Name</font></div> </td>
        <td><div align="left"><input id="driverfather" name="driverfather" type="text" value="<%=driverFatherName %>" /></div></td>
		</tr>
	       <tr>
		<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=DOB %>" readonly/>
		<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "DOB",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "DOB"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
		<tr>
        <td><div align="left"><font size="2">Education</font></div></td>
        <td><div  align="left"> <input id="Education" name="Education" type="text" value="" /> </div> </td>
       	</tr>
       	
	</table>
		</div>
		</td>
		
          </tr>               
        <tr>
		<td align="center"><div align="left"><font size="2" >Transporter </font></div> </td>
		<td> <div  align="left">
						<select name="transporter">
						<option value="<%=transporter %>"><%=transporter %></option>
							
							<%
							try{
								String sql1="select Distinct(VehRegno) from t_group where GPName='castrol' order by VehRegno Asc";
								ResultSet rst1=st1.executeQuery(sql1);
								//System.out.println("i am in transporterr");
								while(rst1.next())
								{
									Transporter=rst1.getString("VehRegno");
							%>
									<option value="<%=Transporter%>"><%=Transporter %></option>
							<% 	}
							
						}catch (Exception e) 
								{
									System.out.print("Exception"+e);
								} 
	%>
						
						</select>				
				</div>
				</td>
        </tr> 
        
 
           
        
       		
        <tr>
        <td><div align="left"><font size="2">vendor</font></div></td>
        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="" /> </div> </td>
       	</tr>
       		             
		
		
	
        <tr><td><div align="left"><font size="2">LicenseDetails</font></div></td>
         <td><div  align="left">   
       <a href="#" name="warcom" onClick="showwarcom('div18');"><font size="2" color="blue" >Details</font></a></div>
		<br> 
		<div id="div18" style="display:none"> 

	<table border="0" width="100%">
	        <tr>
		<td align="center"><div  align="left"><font size="2" >No </font></div></td>
        <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=LicenseNo %>" /> </div> </td>
		</tr>
			<tr>
		<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
		<td><div  align="left">
		    <input type="text" id="licnExpiryDate" name="licnExpiryDate"  value=""  readonly/>
<!--			<img src="../images/calendar.png" id="trigger" border="0">-->
  			<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "licnExpiryDate",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "licnExpiryDate"       // ID of the button
    			}
  				);	
				</script>
		</div></td>
        </tr>
	<tr>
        <td><div align="left"><font size="2">Type</font></div></td>
        <td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value="" /> </div> </td>
       	</tr> 
       	 <tr>
		<td align="center"><div align="left"><font size="2" >Place of issue </font> </div>  </td>
        <td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="" />  </div></td>
        </tr>
        

	</table>
		</div>
		</td>
        </tr>
        
       	 
	<tr><td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div19');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div19" style="display:none"> 

	<table border="0" width="100%">
	 <tr>
		<td align="center"><div align="left"><font size="2" >Exam </font></div> </td>
        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="" /></div>  </td>
		</tr>
		<tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value=""  readonly/>
		<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "MedicalExamdate",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "MedicalExamdate"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
		<tr>
		<td align="center"><div align="left"><font size="2" >ExpiryDate</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="MediclExpDate" name="MediclExpDate"  value=""  readonly/>
		<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "MediclExpDate",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "MediclExpDate"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
	</table>
		</div>
		</td>
	</tr>
       
		<tr>
       <td align="center"><div align="left"><font size="2" >Training Details</font></div> </td>
       <td><div  align="left">   
       <a href="#" name="warcom" onClick="showwarcom('div20');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="div20" style="display:none"> 
        <table border="0" width="100%">
        <%
       // System.out.println("dgdsxbdxfh"+driverid);
        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'";
        //System.out.println(sql5);
        ResultSet rst55=st2.executeQuery(sql5);
     
        if(rst55.next())
        { 
        	//System.out.println("awrfffffffffffa");
        		Basic=rst55.getString("Basic");
        		Module1=rst55.getString("Module1");
        		Module2=rst55.getString("Module2");
        		Module3=rst55.getString("Module3");
        		Module4=rst55.getString("Module4");
        		Module5=rst55.getString("Module5");
        		if(Basic.equals("-")||Basic.equals("NULL"))
        {
        %>	<tr>
		       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		       <a href="#" name="warcom" onClick="showwarcom('div21');"><font size="2" color="blue">Details</font></a></div>
				<br> 
				<div id="div22" style="display:none"> 

				<table border="0" width="100%">
				<tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="" readonly/>
					<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		  		  <script type="text/javascript">
		  				Calendar.setup(
		    			{
		      			inputField  : "basicdate",         // ID of the input field
		      			ifFormat    : "%Y-%m-%d",     // the date format
		      			button      : "basicdate"       // ID of the butto n
		    			}
		  				);	
				  </script>
				  </div></td>
		          </tr> 
				
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
				  <td><div  align="left"><select name="Basic"  class="formElement">
				<option value="select">select</option>
					<%
					  sql="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst2=st3.executeQuery(sql);
					  while(rst2.next())
					  { %>
					     <option value="<%=rst2.getString("LName") %>"> <%=rst2.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="" /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="" /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
			          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="" /></div>  </td>
			          </tr>
			          </table>
					</div>
					</td>
					</tr>
					<%
        }else{
        	%>
       				 <tr>
				       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
				       <td><div  align="left">   
				       <a href="#" name="warcom" onClick="showwarcom('div21');"><font size="2" color="blue">Details</font></a></div>
						<br> 
						<div id="div21" style="display:none"> 

						<table border="0" width="100%">
						<tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value=""  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
				  		  <script type="text/javascript">
				  				Calendar.setup(
				    			{
				      			inputField  : "basicdate",         // ID of the input field
				      			ifFormat    : "%Y-%m-%d",     // the date format
				      			button      : "basicdate"       // ID of the butto n
				    			}
				  				);	
						  </script>
						  </div></td>
				          </tr> 
						<tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
               <td><div  align="left"><input id="Basic" name="Basic" type="text" value=""readonly /></div>  </td>
              
               </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="" readonly/></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="" readonly/></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="" readonly/></div>  </td>
					          </tr>
					          </table>
							</div>
							</td>
							</tr>
                             
		 					<%
              				 if(Module1.equals("-")||Module1.equals("NULL"))
              				 {
              					 %>
              					 <tr>
					       <td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
					       <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('div22');"><font size="2" color="blue">Details</font></a></div>
					<br> 
					<div id="div22" style="display:none"> 
					
						<table border="0" width="100%">
							<tr>
							  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					          <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value=""  readonly/>
								<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
					  		  <script type="text/javascript">
					  				Calendar.setup(
					    			{
					      			inputField  : "Module1date",         // ID of the input field
					      			ifFormat    : "%Y-%m-%d",     // the date format
					      			button      : "Module1date"       // ID of the button
					    			}
					  				);	
							  </script>
							  </div></td>
					          </tr> 
					          
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
					          <td><div  align="left"><select name="Module1"  class="formElement">
						 		<option value="select">selet</option>
					<%
					  String sql1="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst6=st3.executeQuery(sql1);
					  while(rst6.next())
					  { %>
					     <option value="<%=rst6.getString("LName") %>"> <%=rst6.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td></tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="" /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="" /></div>  </td>
					          </tr>
					          </table>
							</div>
							</td>
							</tr>
               				<%
              				 }
        					else
        					{
        					%>
		    			    <tr>
       						<td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
      						 <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('div23');"><font size="2" color="blue">Details</font></a></div>
							<br> 
							<div id="div23" style="display:none"> 

							<table border="0" width="100%">
							<tr>
						   <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
         					 <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value=""  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  					<script type="text/javascript">
				  				Calendar.setup(
				    			{
				      			inputField  : "Module1date",         // ID of the input field
				      			ifFormat    : "%Y-%m-%d",     // the date format
				      			button      : "Module1date"       // ID of the button
				    			}
				  				);	
							  </script>
							  </div></td>
					          </tr> 
										          
					          <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
               <td><div  align="left"><input id="Module1" name="Module1" type="text" value=""readonly /></div>  </td>
              
               </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="" readonly/></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="" readonly/></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="" readonly/></div>  </td>
					          </tr>
			          </table>
					</div>
					</td>
					</tr>
        			  <%	
        			if(Module2.equals("-")||Module2.equals("NULL"))
        				{
        				%>
        				<tr>
          				  <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
          				  <td> <div  align="left">
           				  <a href="#" name="warcom" onClick="showwarcom(div24);"><font size="2" color="blue">Details</font></a></div>
 					    <br> 
  						   <div id="div24" style="display:none"> 

     	<table border="0" width="100%">
     	 <tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="" readonly />
     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  <script type="text/javascript">
       				Calendar.setup(
         			{
           			inputField  : "Module2date",         // ID of the input field
           			ifFormat    : "%Y-%m-%d",     // the date format
           			button      : "Module2date"       // ID of the button
         			}
       				);	
     		  </script>
     		  </div></td>
               </tr> 
     		
               <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
					          <td><div  align="left"><select name="Module2"  class="formElement">
						 		<option value="select">select</option>
					<%
					  String sql1="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst6=st3.executeQuery(sql1);
					  while(rst6.next())
					  { %>
					     <option value="<%=rst6.getString("LName") %>"> <%=rst6.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td></tr>
               
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
               <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="" /></div>  </td>
               </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
               <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="" /></div>  </td>
               </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
               <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="" /></div>  </td>
               </tr>
               </table>
     		</div>
     		</td>
     		</tr>        
     		<% 
        }
        else
        {
        	%>       
			<tr>
       <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
       <td> <div  align="left">
         <a href="#" name="warcom" onClick="showwarcom('div25');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div25" style="display:none"> 

	<table border="0" width="100%">
	 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="" readonly />
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "Module2date",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "Module2date"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
          <td><div  align="left"><input id="Module2" name="Module2" type="text" value=""readonly /></div>  </td>
         
          </tr>
          
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="" readonly/></div>  </td>
          </tr>
          </table>
		</div>
		</td>
		</tr>              
        <%
        	if(Module3.equals("-")||Module3.equals("NULL"))
        	{
        		%>
        		 <tr>
        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom(div26);"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="div26" style="display:none"> 

		<table border="0" width="100%">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value=""  />
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "Module3date",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "Module3date"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
          <td><div  align="left"><select name="Module3"  class="formElement">
	 		<option value="select">select</option>
<%
  String sql3="select LName from  db_CustomerComplaints.t_location order by LName";
  ResultSet rst3=st3.executeQuery(sql3);
  while(rst3.next())
  { %>
     <option value="<%=rst3.getString("LName") %>"> <%=rst3.getString("LName") %> </option>
<% } %>
     <option value="Other"> Other </option>
   </select></div>  </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value="" /></div>  </td>
          </tr>
          </table>
		</div>
		</td>
		</tr>
        		<%
        	}else
        	{
        		 %>		 <tr>
        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		 <a href="#" name="warcom" onClick="showwarcom('div27');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="div27" style="display:none"> 

		<table border="0" width="100%">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value=""  readonly/>
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "Module3date",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "Module3date"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
          <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
               <td><div  align="left"><input id="Module3" name="Module3" type="text" value=""readonly /></div>  </td>
              
               </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value="" readonly/></div>  </td>
          </tr>
          </table>
		</div>
		</td>
		</tr>
       					<%
        	if(Module4.equals("-")||Module4.equals("NULL"))
        	{
        		%>
       					<tr>
      					 <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('div28');"><font size="2" color="blue">Details</font></a></div>
						<br> 
						<div id="div28" style="display:none"> 
						<table border="0" width="100%">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=rst.getString("Module4date")%>"  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  						  <script type="text/javascript">
  							Calendar.setup(
    						{
      						inputField  : "Module4date",         // ID of the input field
      						ifFormat    : "%Y-%m-%d",     // the date format
      						button      : "Module4date"       // ID of the button
    						}
  							);	
		 			 </script>
					  </div></td>
       				   </tr> 
          
        				  <tr>
		 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
         				 <td><div  align="left"><select name="Module4"  class="formElement">
	 					<option value="<%=rst.getString("Module4")%>"><%=rst.getString("Module4")%></option>
						<%
 						 String sql4="select LName from  db_CustomerComplaints.t_location order by LName";
 						 ResultSet rst4=st3.executeQuery(sql4);
 						 while(rst4.next())
						  { %>
  						   <option value="<%=rst4.getString("LName") %>"> <%=rst4.getString("LName") %> </option>
						<% } %>
 					    <option value="Other"> Other </option>
  						 </select></div>  </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="<%=rst.getString("Module4TrainerName")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="<%=rst.getString("Module4TrainingCompany")%>" /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="<%=rst.getString("Module4Comments")%>" /></div>  </td>
          </tr>
		</table>
		</div>
		</td>
		</tr>
		   <%
        	}
		   else
		   {
		   %>
		    					<tr>
      					 <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						 <a href="#" name="warcom" onClick="showwarcom('div29');"><font size="2" color="blue">Details</font></a></div>
						<br> 
						<div id="div29" style="display:none"> 
						<table border="0" width="100%">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=rst.getString("Module4date")%>"  readonly/>
							<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  						  <script type="text/javascript">
  							Calendar.setup(
    						{
      						inputField  : "Module4date",         // ID of the input field
      						ifFormat    : "%Y-%m-%d",     // the date format
      						button      : "Module4date"       // ID of the button
    						}
  							);	
		 			 </script>
					  </div></td>
       				   </tr> 
          
        				  <tr>
		 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
         				 <td><div  align="left"></div> <input id="Module4" name="Module4" type="text" value="<%=rst.getString("Module4")%>" readonly/> </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="<%=rst.getString("Module4TrainerName")%>" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="<%=rst.getString("Module4TrainingCompany")%>" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="<%=rst.getString("Module4Comments")%>" readonly/></div>  </td>
          </tr>
		</table>
		</div>
		</td>
		</tr>
		   <%
			   }
       		        	if(Module5.equals("-")||Module5.equals("NULL"))
       		        	{
       		        		%>
       		       					<tr>
       		      					 <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('div528');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="div528" style="display:none"> 
       								<table border="0" width="100%">             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=rst.getString("Module5date")%>"  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "Module5date",         // ID of the input field
       		      						ifFormat    : "%Y-%m-%d",     // the date format
       		      						button      : "Module5date"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left"><select name="Module5"  class="formElement">
       			 					<option value="<%=rst.getString("Module5")%>"><%=rst.getString("Module5")%></option>
       								<%
       		 						 String sql4="select LName from  db_CustomerComplaints.t_location order by LName";
       		 						 ResultSet rst4=st3.executeQuery(sql4);
       		 						 while(rst4.next())
       								  { %>
       		  						   <option value="<%=rst4.getString("LName") %>"> <%=rst4.getString("LName") %> </option>
       								<% } %>
       		 					    <option value="Other"> Other </option>
       		  						 </select></div>  </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="<%=rst.getString("Module5TrainerName")%>" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="<%=rst.getString("Module5TrainingCompany")%>" /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="<%=rst.getString("Module5Comments")%>" /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>
       				   <%
       		        	}
       				   else
       				   {
       				   %>
       				    					<tr>
       		      					 <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
       		        				 <td> <div  align="left">
       								 <a href="#" name="warcom" onClick="showwarcom('div529');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="div529" style="display:none"> 
       								<table border="0" width="100%">             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=rst.getString("Module5date")%>"  readonly/>
       									<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		  						  <script type="text/javascript">
       		  							Calendar.setup(
       		    						{
       		      						inputField  : "Module5date",         // ID of the input field
       		      						ifFormat    : "%Y-%m-%d",     // the date format
       		      						button      : "Module5date"       // ID of the button
       		    						}
       		  							);	
       				 			 </script>
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 <td><div  align="left"></div> <input id="Module5" name="Module5" type="text" value="<%=rst.getString("Module5")%>" readonly/> </td></tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="<%=rst.getString("Module5TrainerName")%>" readonly/></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="<%=rst.getString("Module5TrainingCompany")%>" readonly/></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="<%=rst.getString("Module5Comments")%>" readonly/></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>
       				   <%
       					   }
        	}
        }
        }
        }
        }else{
        %>
        <tr>
		       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		      <a href="#" name="warcom" onClick="showwarcom('div30');"><font size="2" color="blue">Details</font></a></div>
				<br> 
				<div id="div30" style="display:none"> 

				<table border="0" width="100%">
				<tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="" readonly/>
					<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		  		  <script type="text/javascript">
		  				Calendar.setup(
		    			{
		      			inputField  : "basicdate",         // ID of the input field
		      			ifFormat    : "%Y-%m-%d",     // the date format
		      			button      : "basicdate"       // ID of the butto n
		    			}
		  				);	
				  </script>
				  </div></td>
		          </tr> 
				
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
				  <td><div  align="left"><select name="Basic"  class="formElement">
				<option value="select">select</option>
					<%
					  sql="select LName from  db_CustomerComplaints.t_location order by LName";
					  ResultSet rst2=st3.executeQuery(sql);
					  while(rst2.next())
					  { %>
					     <option value="<%=rst2.getString("LName") %>"> <%=rst2.getString("LName") %> </option>
					<% } %>
					     <option value="Other"> Other </option>
					   </select></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="" /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="" /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
			          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="" /></div>  </td>
			          </tr>
			          </table>
					</div>
					</td>
					</tr>
        <%
        }
        %>
           </table>
		</div>
		</td>
		</tr>     
                         
          <tr>
		  <td align="center"><div  align="left"><font size="2" >Remark</font></div></td>
          <td> <div  align="left"><input id="remark" name="remark" type="text" value="" /></div>  </td>
          </tr> 
          
          <tr><td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div31');"><font size="2" color="blue" >Details</font></a></div>
<br> 
<div id="div31" style="display:none"> 

	<table border="0" width="100%">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
          <td><div  align="left"> <input id="FTTraining" name="FTTraining" type="text" value="" /> </div> </td>
          </tr> 
          <tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value=""  readonly/>
		<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
  		<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "FTTrainingdate",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "FTTrainingdate"       // ID of the button
    			}
  				);	
		</script>
		</div></td>
		</tr>
		
	</table>
		</div>
		</td>
	</tr>
          
          <tr><td align="center"><div align="left"><font size="2" >Last Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div32');"><font size="2" >Details</font></a></div>
<br> 
<div id="div32" style="display:none"> 

	<table border="0" width="100%">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >Last Training</font> </div> </td>
          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="" /></div>  </td>
          </tr> 
                        
          <tr>
		  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value=""  readonly/>
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "LastTrainingDate",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "LastTrainingDate"       // ID of the button
    			}
  				);	
		  </script>
		  </div></td>
          </tr> 
		
	</table>
		</div>
		</td>
	</tr>
          
		
          
                             
            <tr>
        	<td><div align="left"><font size="2">PreTest 40 MM.</font></div></td>
            <td><div  align="left"> <input id="PreTest40MM" name="PreTest40MM" type="text" value="" /> </div> </td>
       		</tr>
       		
       		<tr>
       		<td><div align="left"><font size="2">PreTest %</font></div></td>
       		<td><div  align="left"> <input id="PreTest%" name="PreTest%" type="text" value="" /> </div> </td>
      		</tr>
        	<tr>
        	<td><div align="left"><font size="2">PostTest 40 MM.</font></div></td>
        	<td><div  align="left"> <input id="PostTest40MM" name="PostTest40MM" type="text" value="" /> </div> </td>
        	</tr>
     	    <tr>
        	<td><div align="left"><font size="2">PostTest%.</font></div></td>
        	<td><div  align="left"> <input id="PostTest%" name="PostTest%" type="text" value="" /> </div> </td>
       		</tr>
    	    <tr>
        	<td><div align="left"><font size="2">Type of vehicle used for on road coaching and for assessment</font></div></td>
        	<td><div  align="left"> <input id="Typeofvehicle" name="Typeofvehicle" type="text" value="" /> </div> </td>
       		</tr>
     		<tr>
			<td><div align="left"><font size="2">EducationGrade</font></div></td>
			<td><div align="left"><input id="Drivingschooleducationgrade" name="Drivingschooleducationgrade" type="text" value="" /> </div> </td>
			</tr>   
                          
                        
 		</table>
        

</td></tr>
<tr>
<td><input type="submit" value="Submit" >
</td>
</tr>



</table>
</td>
</tr>
</table>
</div>
</form>
<%		



}
	
}catch(Exception e)
{
	out.print("Exception--->"+e);
}
finally
{
conn.close();
}
%>


<!-- <table border="0" width="100%" align="center" style="padding-bottom: 16px;height:20px " > -->
<div class="footer" style="width: 100%;float:left;margin-top:40px;background-color:#0B2161;">


<font color: white;"><center>Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</center></font>


</div>

<!-- <tr><td  bgcolor="#0B2161" > -->
<!-- <ui><li><center><font color="white" >Copyright &copy; 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.</font></center></li></ui> -->
<!-- </td></tr> -->

</body>
</html>




