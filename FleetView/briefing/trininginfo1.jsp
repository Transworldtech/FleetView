
<!-- code to show driver details present for IRTE login -->
<!--Date-14/09/2010 by sujata -->

<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

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
	function showwarcom(ind)
	{ 
		if(ind==0)
		{ 
			document.getElementById("warcomment").style.display="";
			warcommentt="Yes";
		}
		else
		{ 
			document.getElementById("warcomment").style.display='none';
			document.repunitform.newdamageoption.style.visibility='hidden';
			warcommentt="No";
		}
	}
	
	var state = 'none';

	function showwarcom(layer_ref) {

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

function editopen(driverid,drivname,PassportID,fatherName,DOB,LicenseNo,trans)
{
alert("Hi");
	try{
	window.open('updatetrininginfo1.jsp?driverid='+driverid+'&driverFatherName='+fatherName+'&DOB='+DOB+'&LicenseNo='+LicenseNo+'&driverName='+drivname+'&transporter='+trans,'Win','width=730,height=400,top=200,left=200,scrollbars=yes');	 
	}catch(e)
	{
		alert(e);
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
</script>

<!-- <body bgcolor="#E3E9FF"> -->
<body bgcolor="#E3E9FF">

	<%!
	Connection conn;
	Statement st,st1,st2;
	%>
<%

String sql=null, driverid="",Basic="",Module1="",Module2="",Module3="",Module4="",Module5="-",Capsule1="",Capsule2="",Capsule3="",BTD="",ORA="";
;
driverid=request.getParameter("passportid");
System.out.println("Driver id " +driverid);
String driverName=request.getParameter("driverName");
String driverFatherName=request.getParameter("driverFatherName");
String DOB=request.getParameter("DOB");
System.out.println("DOB id " +DOB);

String LicenseNo=request.getParameter("LicenseNo");
String transporter=request.getParameter("transporter");

String insert=request.getParameter("insert");
System.out.println("insert id " +insert);

System.out.println("transporter id " +transporter);




try{
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
		/**code to display drivers details fron t_drivertraining***/	
		
	String PageName=this.getClass().getName();
String reportno = "";

PageName=PageName.substring(PageName.lastIndexOf(".")+1,PageName.length());
System.out.println(PageName);
PageName=PageName.replace("_",".");
PageName=PageName.replace(".005f","_");
System.out.println(PageName);	
		
String sql1 = "select ReportNo from db_gps.t_reportnumber where PageName = '"+PageName+"'";
ResultSet rs = st.executeQuery(sql1);
if(rs.next())
{
	reportno = rs.getString("ReportNo");
}
System.out.println(reportno+"  "+sql1);	
		
		
	
		
			sql="select * from t_drivertraining where Dcode = '"+driverid+"'";
			
		ResultSet rst=st.executeQuery(sql);
		System.out.println("IF driver information already exits  "+sql);	
			if(rst.next())
			{
				
				
			System.out.println("IF driver information already exits");	
				
%>

<form name="trininginfo1" method="post" action="updatetrininginfo1.jsp?driverid=<%=driverid%>&father=<%=driverFatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&drivname=<%=driverName%>&transporter=<%=transporter%>"  onSubmit="" >

<table border="0" align="center" width="100%"> 
<tr>
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
		<td align="left"><font color="brown" size="3"><input type="submit" name="edit1" value="Edit" class="formElement" /></font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<font face="Arial" size="3" color="black">Driver Training Details</font>
		</td>
		</tr>
		<%if(insert!=null && insert.equals("true"))
{

// out.println("@@@@@@@@02/10/1988@@@@@@@@@ "+insert);
%>

<!-- 	<script type="text/javascript"> -->
<!--  	alert("Record saved successfully"); -->
<!-- 	window.location="trininginfo1.jsp?passportid=+"driverid; -->
	
<!-- 	</script> -->

<tr><td><font color="blue" size="5">Data Successfully saved.</font></td></tr>
	<%}%>

</table>
</form>
<form action="updatetrininginfo1.jsp" style="overflow:scroll" > 
<div class="form_container" style="text-align: center;" align="center">
<div class="ScrollTable" style="height: 410px;">
   

<%System.out.println("transporter id ");
 %>


<div id="form11" align="right">

 <table border="0" width="50%" align="center" class="stats">
     
     
        <tr>
		<td align="left" width="30%">
		<input type="hidden" id="driverid" name="driverid" class="element text medium"  value="<%=driverid%>"></input>
		<div align="left" ><font size="2" face="Arial" >Driver Name  </font></div></td>
        <td width="80%"><div align="left">
		<input  id="drivername" name="drivername" type="text" class="element text medium" value="<%= rst.getString("DriverName") %>" readonly/></div>
		</td>
		</tr>
		
		<tr>
		<td align="left" valign="top"><div align="left" ><font size="2" face="Arial" >Personal Details</font></div> </td>
		
		<td> <div  align="left">
       <a href="#" onClick="showwarcom('div1');"><font size="2" color="blue">Details</font></a>	</div>
       <div id="div1" style="display:none"> 

	<table border="0" >
	<tr>
		<td align="center" ><div align="left"><font size="2" face="Arial" >Father Name</font></div> </td>
        <td ><div align="left" >&nbsp;<input id="driverfather" name="driverfather" type="text"  value="<%= rst.getString("DriverFatherName")%>"readonly /></div></td>
		</tr>
	       <tr>
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
		<td align="left"><div  align="left"><font size="2" face="Arial">DOB </font></div> </td>
        <td align="left"><div align="left">&nbsp;<input type="text" id="DOB" name="DOB"  value="<%=Doobdate%>" readonly/>
		<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
  		
		</div></td>
		</tr>
		<tr>
        <td><div align="left"><font size="2" face="Arial">Education</font></div></td>
        <td><div  align="left">&nbsp;<input id="Education" name="Education" type="text" value="<%= rst.getString("Education") %>" readonly/> </div> </td>
       	</tr>
       	
	</table>
		</div>
		</td>
		
        </tr>               
        <tr>
			<td align="center" width="30%"><div align="left"><font size="2" face="Arial" >Transporter </font></div></td>
			<td><div  align="left"><input id="transporter" name="transporter" type="text" value="<%=rst.getString("Transporter")%>" readonly/></div></td>
        </tr> 
        
        <tr>
	        <td><div align="left"><font size="2" face="Arial">Vendor</font></div></td>
	        <td><div  align="left"> <input id="vendor" name="vendor" type="text" class="element text medium" value="<%= rst.getString("vendor") %>"readonly/> </div> </td>
       	</tr>
	
        <tr>
        <td width="30%" valign="top"><div align="left"><font size="2" face="Arial">LicenseDetails</font></div></td>
        <td><div  align="left">
        		<a href="#" onClick="showwarcom('div2');"><font size="2" color="blue">Details</font></a></div>
				<div id="div2" style="display:none"> 

				<table border="0">
		        	<tr>
						<td align="center"><div  align="left" face="Arial"><font size="2" >License No </font></div></td>
	       			    <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=rst.getString("licenceno")%>" readonly/> </div> </td>
					</tr>
					<%String Ldate="";
			
	      Ldate=rst.getString("ExpiryDate");  
	      System.out.println("Expiry date is " +Ldate);
	      
					//if(Ldate.equals("-") || Ldate.equalsIgnoreCase("null") || Ldate==null || Ldate.equals(""))
		        	//{
		        	//}
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
						<td align="center"><div  align="left"><font size="2" face="Arial">ExpiryDate </font> </div></td>
						<td><div  align="left"><input type="text" id="licnExpiryDate" name="licnExpiryDate"  value="<%=Ldate%>"  readonly/></div></td>
	        		</tr>
		
					<tr>
	       				<td><div align="left"><font size="2" face="Arial">Type</font></div></td>
	      				<td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value="<%= rst.getString("LicenseType") %>"readonly /> </div> </td>
	       			</tr> 
	       			
	       			<tr>
						<td align="center"><div align="left"><font size="2" face="Arial" >Place of issue </font> </div>  </td>
	        			<td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="<%= rst.getString("LicensePlace") %>" readonly/>  </div></td>
	        		</tr>
			   </table>
			</div>
		</td>
        </tr>
        
       	 
		<tr>
		<td align="center" width="30%" valign="top"><div align="left"><font size="2" face="Arial">MedicalExam </font></div> </td>
		<td><div  align="left"><a href="#" onClick="showwarcom('div3');"><font size="2" color="blue">Details</font></a>
			</div>
				   <br> 
			<div id="div3" style="display:none"> 
			<table border="0">
					<tr>
					<td align="center"><div align="left"><font size="2" face="Arial" >Exam </font></div> </td>
			        <td><div  align="left">&nbsp;&nbsp;<input id="MedicalExam" name="MedicalExam" type="text" value="<%= rst.getString("MedicalExam") %>" readonly/></div>  </td>
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
					<td align="center"><div align="left"><font size="2" face="Arial" >Date</font></div> </td>
			        <td><div  align="left">&nbsp;&nbsp;<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value="<%=Mdate%>"  readonly/></div></td>
					</tr>
					
					<tr>
						<td align="center"><div align="left"><font size="2" > ExpiryDate</font></div> </td>
			        	<td><div  align="left">&nbsp;&nbsp;<input type="text" id="MediclExpDate" name="MediclExpDate"  value="<%=MEdate%>"  readonly/></div></td>
					</tr>
			</table>
			</div>
		</td>
		</tr>
       
		<tr>
		       <td align="center" width="30%" valign="top"><div align="left"><font size="2" >Training Details</font></div> </td>
		       <td><div  align="left">   
		       <a href="#" onClick="showwarcom('div4');"><font size="2" color="blue">Details</font></a></div>
				<br> 
				
			<div id="div4" style="display:none"> 
		        <table border="0">
		        <%
		      //  System.out.println("From yraining details"+driverid);
		        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'";
		       System.out.println(" in already exits sql---->"+sql5);
		        ResultSet rst5=st1.executeQuery(sql5);
		     
		        if(rst5.next())
		        {  Basic=rst5.getString("Basic");
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

		        
		        
		      //  System.out.println(Module5);
		        if(Basic.equals("-")||Basic.equals("NULL"))
		        {
		        	%>
		        		<tr>
		       <td align="center" valign="top"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		       <a href="#" name="warcom" onClick="showwarcom('divt2');"><font size="2" color="blue">Details</font></a></div>
				<br> 
				<div id="divt2" style="display:none"> 

				<table border="0">
				<tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="" readonly/>
					
				  </div></td>
		          </tr> 
				
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		          <td><div  align="left"><input id="Basic" name="Basic" type="text" value=""readonly /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="" readonly /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
			          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="" readonly /></div>  </td>
			          </tr>
			          <tr>
					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
			          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="" readonly /></div>  </td>
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
		           		 <a href="#" name="warcom" onClick="showwarcom('divb5');"><font size="2" color="blue">Details</font></a></div>
		     		<br> 
		     		<div id="divb5" style="display:none"> 
		
		     	<table border="0" >
		     	<tr>
		     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		               <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=basedateck%>"  readonly/>
		     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		       		 
		     		  </div></td>
		               </tr> 
		               <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		          <td><div  align="left"><input id="Basic" name="Basic" type="text" value="<%=rst.getString("Basic")%>"readonly /></div>  </td>
		          
		           </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="<%=rst.getString("BasicTrainerName")%>" readonly/></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="<%=rst.getString("BasicTrainingCompany")%>"readonly /></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="<%=rst.getString("BasicComments")%>" readonly/></div>  </td>
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
							<a href="#" name="warcom" onClick="showwarcom('divt4');"><font size="2" color="blue">Details</font></a></div>
					<br> 
					<div id="divt4" style="display:none"> 
					
						<table border="0">
							<tr>
							  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					          <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value=""  readonly/>
					  		  
							  </div></td>
					          </tr> 
					          
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
							  		          <td><div  align="left"><input id="Module1TrainingLocation" name="Module1TrainingLocation" type="text" value=""readonly /></div>  </td>
							  
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="" readonly /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
					          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="" readonly /></div>  </td>
					          </tr>
					          <tr>
							  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
					          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="" readonly /></div>  </td>
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
		     		<a href="#" name="warcom" onClick="showwarcom('divb6');"><font size="2" color="blue">Details</font></a></div>
		     <br> 
		     <div id="divb6" style="display:none"> 
		
		     	<table border="0" >
		     		<tr>
		     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		               <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=m1dateck%>"  readonly/>
		     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		       		 
		     		  </div></td>
		               </tr> 
		               
		        
				
		 		  
				
				       
		          
		         <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		          <td><div  align="left"><input id="Module1TrainingLocation" name="Module1TrainingLocation" type="text" value="<%=rst.getString("Module1")%>"readonly /></div>  </td>
		       
		          </tr>
		          
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="<%=rst.getString("Module1TrainerName")%>" readonly/></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="<%=rst.getString("Module1TrainingCompany")%>" readonly/></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="<%=rst.getString("Module1Comments")%>" readonly/></div>  </td>
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
           				   <a href="#" name="warcom" onClick="showwarcom('divt6');"><font size="2" color="blue">Details</font></a></div>
 					    <br> 
  						   <div id="divt6" style="display:none"> 

     	<table border="0" >
     	 <tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="" readonly />
     			</div></td>
               </tr> 
     		
               <tr>
							  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		          <td><div  align="left"><input id="Module2TrainingLocation" name="Module2TrainingLocation" type="text" value="" readonly /></div>  </td>
					          
					          </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
               <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="" readonly /></div>  </td>
               </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
               <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="" readonly /></div>  </td>
               </tr>
               <tr>
     		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
               <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="" readonly /></div>  </td>
               </tr>
               </table>
     		</div>
     		</td>
     		</tr>        
		        	<%
		        }
		        else
		        {
		        	
		        	String m2dateck=rst.getString("Module2date");
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

		        	}
		        	
		        	%>
		        	<tr>
		       <td align="center" valign="top"><div align="left"><font size="2" >Module2</font></div> </td>
		       <td> <div  align="left">
		         <a href="#" onClick="showwarcom('divb7');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		<div id="divb7" style="display:none"> 
		
			<table border="0" >
			 <tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=m2dateck%>" readonly />
					<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		  		  
				  </div></td>
		          </tr> 
				
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		          <td><div  align="left"><input id="Module2TrainingLocation" name="Module2TrainingLocation" type="text" value="<%=rst.getString("Module2")%>"readonly /></div>  </td>
		         
		          </tr>
		          
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		          <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="<%=rst.getString("Module2TrainerName")%>" readonly/></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		          <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="<%=rst.getString("Module2TrainingCompany")%>" readonly/></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		          <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="<%=rst.getString("Module2Comments")%>" readonly/></div>  </td>
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

		<table border="0" >
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="" readonly  />
			
		  </div></td>
          </tr> 
		
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		        	          <td><div  align="left"><input id="Module3TrainingLocation" name="Module3TrainingLocation" type="text" value="" readonly /></div> 
	 		 </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="" readonly /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value=""  readonly/></div>  </td>
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

			        	}
			        	
		        	%><tr>
		        	        <td align="center" valign="top"><div align="left"><font size="2" >Module3</font></div> </td>
		        	        <td> <div  align="left">
		        			<a href="#" name="warcom" onClick="showwarcom('divb8');"><font size="2" color="blue">Details</font></a></div>
		        			<br> 
		        			<div id="divb8" style="display:none"> 
		
		        			<table border="0" >
		        			 <tr>
		        			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		        	          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=m3dateck%>" readonly />
		        				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		        	  		 
		        			  </div></td>
		        	          </tr> 
		        			
		        	         <tr>
		        			  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		        	          <td><div  align="left"><input id="Module3TrainingLocation" name="Module3TrainingLocation" type="text" value="<%=rst.getString("Module3")%>"readonly /></div> 
		        	            </td></tr>
		        	          <tr>
		        			  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		        	          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="<%=rst.getString("Module3TrainerName")%>" readonly/></div>  </td>
		        	          </tr>
		        	          <tr>
		        			  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		        	          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="<%=rst.getString("Module3TrainingCompany")%>" readonly/></div>  </td>
		        	          </tr>
		        	          <tr>
		        			  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		        	          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value="<%=rst.getString("Module3Comments")%>"readonly /></div>  </td>
		        	          </tr>
		        	          </table>
		        			</div>
		        			</td>
		        			</tr>
		        	       <% } 
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
							
					  </div></td>
       				   </tr> 
          
        				  <tr>
		 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		        	              			  <td><div  align="left"><input id="Module4TrainingLocation" name="Module4TrainingLocation" type="text" value="" readonly /></div>  </td>
	 					 </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="" readonly /></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
          <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="" readonly/></div>  </td>
          </tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
          <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="" readonly/></div>  </td>
          </tr>
		</table>
		</div>
		</td>
		</tr>
		        	    	   <%
		        	       }else
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
		        	          
		        	          
		        	          
		        	          %>   <tr>
		        	             <td align="center" valign="top"><div align="left"><font size="2" >Module4</font></div> </td>
		        	               <td> <div  align="left">
		        	      		<a href="#" name="warcom" onClick="showwarcom('divb9');"><font size="2" color="blue">Details</font></a></div>
		        	      		<br> 
		        	      		<div id="divb9" style="display:none"> 
		        	      		<table border="0" width="100%">             
		        	                <tr>
		        	      		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		        	                <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=m4dateck%>" readonly />
		        	      			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		        	        		 
		        	      		  </div></td>
		        	                </tr> 
		        	                
		        	              	  <tr>
		        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		        	              			  <td><div  align="left"><input id="Module4TrainingLocation" name="Module4TrainingLocation" type="text" value="<%=rst.getString("Module4")%>"readonly /></div>  </td>
		        	                	 </tr>
		        	               	 <tr>
		        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		        	               			 <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="<%=rst.getString("Module4TrainerName")%>"readonly /></div>  </td>
		        	              	  </tr>
		        	               	 <tr>
		        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		        	               			 <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="<%=rst.getString("Module4TrainingCompany")%>"readonly /></div>  </td>
		        	              	  </tr>
		        	              	  <tr>
		        	      					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		        	               			 <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="<%=rst.getString("Module4Comments")%>"readonly /></div>  </td>
		        	             		   </tr>
		        	      		</table>
		        	      		</div>
		        	      		</td>
		        	      		</tr>
		        	      		<%
		        	       }
		        	      		if(Module5.equalsIgnoreCase("-")||"null".equalsIgnoreCase(Module5)||null==Module5){
		        	      			//System.out.println("module5 is null");
		        	      			
		        	      			%>
		        	      			<tr>
					 <td align="center" valign="top"><div align="left"><font size="2" >Module5</font></div> </td>
				 <td> <div  align="left">
				<a href="#" name="warcom" onClick="showwarcom('divt12');"><font size="2" color="blue">Details</font></a></div>
				<br> 
				<div id="divt12" style="display:none"> 
				<table border="0" >             
				    <tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value=""  readonly/>
					
			  </div></td>
				   </tr> 
				  <tr>
				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
				 	  			  		<td><div  align="left"><input id="Module5TrainingLocation" name="Module5TrainingLocation" type="text" value="" readonly /></div>  </td>
  </tr>
 <tr>
 <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
 <td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="" readonly /></div>  </td>
 </tr>
 <tr>
 <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
 <td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="" readonly /></div>  </td>
 </tr>
 <tr>
 <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
 <td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="" readonly /></div>  </td>
 </tr>
</table>
</div>
</td>
</tr>
		        	      			<%
		        	      		}else{
		        	      		  //System.out.println("module5");
		        	      		  
		        	      		  
		        	      		  
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
			        	      				<a href="#" name="warcom" onClick="showwarcom('divb22');"><font size="2" color="blue">Details</font></a></div>
			        	      				<br> 
			        	      				<div id="divb22" style="display:none"> 
			        	      					<table border="0" >             
			        	                			<tr>
			        	      		  					<td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
			        	                				<td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=m5dateck%>" readonly />
			        	      								<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
									        	      		  </div>
									        	      	</td>
			        	                			</tr> 
		  			        	              	    <tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			        	              			  		<td><div  align="left"><input id="Module5TrainingLocation" name="Module5TrainingLocation" type="text" value="<%=rst.getString("Module5")%>"readonly /></div>  </td>
			        	                	 		</tr>
			        	               	 			<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
			        	               			 		<td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="<%=rst.getString("Module5TrainerName")%>"readonly /></div>  </td>
			        	              	  			</tr>
			        	               	 			<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
			        	               			 		<td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="<%=rst.getString("Module5TrainingCompany")%>"readonly /></div>  </td>
			        	              	  			</tr>
			        	              	  			<tr>
			        	      					  		<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
			        	               			 		<td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="<%=rst.getString("Module5Comments")%>"readonly /></div>  </td>
			        	             		   		</tr>
			        	      					</table>
			        	      				</div>
			        	      			</td>
			        	      		</tr>
			        	      		<%
		        	      		}
		        
		        	 		   if(Capsule1.equals("-")||Capsule1.equals("NULL")){

		        	 			   %>
		        	 			   <tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 1</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt14');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt14" style="display:none"> 
       								<table border="0" >             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule1date" name="Capsule1date"  value=""  readonly/>
       									
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 			        	              			  		<td><div  align="left"><input id="Capsule1TrainingLocation" name="Capsule1TrainingLocation" type="text" value="" readonly /></div>  </td>
       		         				 
       		         				 </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainerName" name="Capsule1TrainerName" type="text" value="" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainingCompany" name="Capsule1TrainingCompany" type="text" value="" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1Comments" name="Capsule1Comments" type="text" value="" readonly /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
		        	 			   <%
		        	 		   }else{
		        	      		
		        	      		

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
       								<a href="#" name="warcom" onClick="showwarcom('divsb18');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divsb18" style="display:none"> 
       								<table border="0" >             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule1date" name="Capsule1date"  value="<%=c1dateck%>"  readonly/>
       		  						  
       							  </div></td>
       		       				   </tr> 
       		          
       		        				<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			        	              			  		<td><div  align="left"><input id="Capsule1TrainingLocation" name="Capsule1TrainingLocation" type="text" value="<%=rst.getString("Capsule1")%>"readonly /></div>  </td>
			        	                	 		</tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainerName" name="Capsule1TrainerName" type="text" value="<%=rst.getString("Capsule1TrainerName")%>" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1TrainingCompany" name="Capsule1TrainingCompany" type="text" value="<%=rst.getString("Capsule1TrainingCompany")%>" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule1Comments" name="Capsule1Comments" type="text" value="<%=rst.getString("Capsule1Comments")%>" readonly /></div>  </td>
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
       								<table border="0" >             
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule2date" name="Capsule2date"  value=""  readonly/>
       									
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         		<td><div  align="left"><input id="Capsule2TrainingLocation" name="Capsule2TrainingLocation" type="text" value="" readonly /></div>  </td>
</tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule2TrainerName" name="Capsule2TrainerName" type="text" value="" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule2TrainingCompany" name="Capsule2TrainingCompany" type="text" value=""  readonly/></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule2Comments" name="Capsule2Comments" type="text" value="" readonly/></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
		   <%
		   
		   }
		   else{
				
			
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
					<a href="#" name="warcom" onClick="showwarcom('divsb20');"><font size="2" color="blue">Details</font></a></div>
					<br> 
					<div id="divsb20" style="display:none"> 
					<table border="0" >             
				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule2date" name="Capsule2date"  value="<%=c2dateck%>"  readonly/>
       		  						  
       							  </div></td>
       		       				   </tr> 
       		          
       		        				<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			        	              			  		<td><div  align="left"><input id="Capsule2TrainingLocation" name="Capsule2TrainingLocation" type="text" value="<%=rst.getString("Capsule2")%>"readonly /></div>  </td>
			        	                	 		</tr>
    <tr>
	  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
    <td> <div  align="left"><input id="Capsule2TrainerName" name="Capsule2TrainerName" type="text" value="<%=rst.getString("Capsule2TrainerName")%>" readonly /></div>  </td>
    </tr>
    <tr>
	  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
    <td> <div  align="left"><input id="Capsule2TrainingCompany" name="Capsule2TrainingCompany" type="text" value="<%=rst.getString("Capsule2TrainingCompany")%>" readonly/></div>  </td>
    </tr>
    <tr>
	  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
    <td> <div  align="left"><input id="Capsule2Comments" name="Capsule2Comments" type="text" value="<%=rst.getString("Capsule2Comments")%>" readonly/></div>  </td>
    </tr>
	</table>
	</div>
	</td>
	</tr>		      		
		        	      		
		    <%}
				
				
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
       									
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         				 			        	              			  		<td><div  align="left"><input id="Capsule3TrainingLocation" name="Capsule3TrainingLocation" type="text" value="<%=rst.getString("Capsule3")%>"readonly /></div>  </td>
</tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="Capsule3TrainerName" name="Capsule3TrainerName" type="text" value="" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="Capsule3TrainingCompany" name="Capsule3TrainingCompany" type="text" value=""  readonly/></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="Capsule3Comments" name="Capsule3Comments" type="text" value="" readonly/></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
		   <%
		   }else{
				
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
			<a href="#" name="warcom" onClick="showwarcom('divsb22');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divsb22" style="display:none"> 
			<table border="0" >             
		    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="Capsule3date" name="Capsule3date"  value="<%=c3dateck%>"  readonly/>
       		  						  
       							  </div></td>
       		       				   </tr> 
       		          
       		        				<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			        	              			  		<td><div  align="left"><input id="Capsule3TrainingLocation" name="Capsule3TrainingLocation" type="text" value="<%=rst.getString("Capsule3")%>"readonly /></div>  </td>
			        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="Capsule3TrainerName" name="Capsule3TrainerName" type="text" value="<%=rst.getString("Capsule3TrainerName")%>" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="Capsule3TrainingCompany" name="Capsule3TrainingCompany" type="text" value="<%=rst.getString("Capsule3TrainingCompany")%>" readonly /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="Capsule3Comments" name="Capsule3Comments" type="text" value="<%=rst.getString("Capsule3Comments")%>" readonly readonly/></div>  </td>
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
       									
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         			<td><div  align="left"><input id="BTDTrainingLocation" name="BTDTrainingLocation" type="text" value="" readonly /></div>  </td>
       		         				 
       		         				 </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="BTDTrainerName" name="BTDTrainerName" type="text" value="" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="BTDTrainingCompany" name="BTDTrainingCompany" type="text" value="" readonly /></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="BTDComments" name="BTDComments" type="text" value="" readonly /></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			
			<%	        	      		
		   
		   }else{	      		
		    
		    
		    
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
			<a href="#" name="warcom" onClick="showwarcom('divsb24');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divsb24" style="display:none"> 
			<table border="0" >             
		    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="BTDdate" name="BTDdate"  value="<%=btddateck%>"  readonly/>
       		  						  
       							  </div></td>
       		       				   </tr> 
       		          
       		        				<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			        	              			  		<td><div  align="left"><input id="BTDTrainingLocation" name="BTDTrainingLocation" type="text" value="<%=rst.getString("BTD")%>"readonly /></div>  </td>
			        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="BTDTrainerName" name="BTDTrainerName" type="text" value="<%=rst.getString("BTDTrainerName")%>" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="BTDTrainingCompany" name="BTDTrainingCompany" type="text" value="<%=rst.getString("BTDTrainingCompany")%>" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="BTDComments" name="BTDComments" type="text" value="<%=rst.getString("BTDComments")%>" readonly/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	  
		        	  
	<%}
				
		  
		   if(ORA.equals("-")||ORA.equals("NULL")){
			%>
			<tr>
       		      					 <td align="center" valign="top"><div align="left"><font size="2" >On road assessment details</font></div> </td>
       		        				 <td> <div  align="left">
       								<a href="#" name="warcom" onClick="showwarcom('divt22');"><font size="2" color="blue">Details</font></a></div>
       								<br> 
       								<div id="divt22" style="display:none"> 
       								<table border="0" > .
       								
       								
       								 <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >Vehicle Type</font></div></td>
       		         				 			        	              			  		<td><div  align="left"><input id="ORAVehicleType" name="ORAVehicleType" type="text" value="<%=rst.getString("ORAVehType")%>"readonly /></div>  </td>
</tr>
       								
       								
       								     
       		      				    <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="ORAdate" name="ORAdate"  value=""  readonly/>
       									
       							  </div></td>
       		       				   </tr> 
       		          
       		        				  <tr>
       				 				 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
       		         			             			  		<td><div  align="left"><input id="ORATrainingLocation" name="ORATrainingLocation" type="text" value="" readonly /></div>  </td>
       		         				
       		         				</tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
       		          <td> <div  align="left"><input id="ORATrainerName" name="ORATrainerName" type="text" value="" readonly/></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
       		          <td> <div  align="left"><input id="ORATrainingCompany" name="ORATrainingCompany" type="text" value="" readonly/></div>  </td>
       		          </tr>
       		          <tr>
       				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
       		          <td> <div  align="left"><input id="ORAComments" name="ORAComments" type="text" value="" readonly/></div>  </td>
       		          </tr>
       				</table>
       				</div>
       				</td>
       				</tr>	
			<%   
		   
		   }else{

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
			<a href="#" name="warcom" onClick="showwarcom('divsb26');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divsb26" style="display:none"> 
			<table border="0" >
			
			
			<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >Vehicle Type</font></div></td>
			        	              			  		<td><div  align="left"><input id="ORAVehicleType" name="ORAVehicleType" type="text" value="<%=rst.getString("ORAVehType")%>"readonly /></div>  </td>
			        	                	 		</tr>
			
			
			
			
			
			             
		     <tr>
       								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
       		      					    <td> <div  align="left"><input type="text" id="ORAdate" name="ORAdate"  value="<%=oradateck%>"  readonly/>
       		  						  
       							  </div></td>
       		       				   </tr> 
       		          
       		        				<tr>
			        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
			        	              			  		<td><div  align="left"><input id="ORATrainingLocation" name="ORATrainingLocation" type="text" value="<%=rst.getString("ORA")%>"readonly /></div>  </td>
			        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="ORATrainerName" name="ORATrainerName" type="text" value="<%=rst.getString("ORATrainerName")%>" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="ORATrainingCompany" name="ORATrainingCompany" type="text" value="<%=rst.getString("ORATrainingCompany")%>" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="ORAComments" name="ORAComments" type="text" value="<%=rst.getString("ORAComments")%>" readonly/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	
	
	     	  
		        	  
		        	      		
		        	      		
		        	      		
		        <%	      		
		        	      		
		   }     		
		        	      		
		        }
		        %>
				</table>
				</div>
				</td>
		        </tr>    
		                 
          <tr>
		  		<td align="center"><div  align="left"><font size="2" >Remark</font></div></td>
          		<td> <div  align="left"><input id="remark" name="remark" type="text" value="<%= rst.getString("remark") %>" readonly/></div>  </td>
          </tr> 
          
          <tr>
          <td align="center" valign="top"><div align="left"><font size="2" >FT Training </font></div> </td>
		  <td><div  align="left"><a href="#" name="warcom" onClick="showwarcom('div10');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div10" style="display:none"> 

	<table border="0" >
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
          <td><div  align="left">&nbsp;<input id="FTTraining" name="FTTraining" type="text" value="<%= rst.getString("FTTraining") %>" readonly/> </div> </td>
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
		&nbsp;<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value="<%=FTTdate%>"  readonly/>
		<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
  		
		</div></td>
		</tr>
		
	</table>
		</div>
		</td>
	</tr>
          
          <tr><td align="center" valign="top"><div align="left"><font size="2" >Last Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div11');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div11" style="display:none"> 

	<table border="0" >
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >LastTraining</font> </div> </td>
          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="<%= rst.getString("LastTraining") %>" readonly/></div>  </td>
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
          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="<%=LTdate%>" readonly />
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		 
		  </div></td>
          </tr> 
		
	</table>
		</div>
		</td>
	</tr>
            <tr>
        	<td><div align="left"><font size="2">PreTest 40 MM.</font></div></td>
            <td><div  align="left"> <input id="PreTest40MM" name="PreTest40MM" type="text" value="<%= rst.getString("PreTest40MM") %>" readonly/> </div> </td>
       		</tr>
       		
       		<tr>
       		<td><div align="left"><font size="2">PreTest %</font></div></td>
       		<td><div  align="left"> <input id="PreTest%" name="PreTest%" type="text" value="<%= rst.getString("PreTestper") %>" readonly/> </div> </td>
      		</tr>
        	<tr>
        	<td><div align="left"><font size="2">PostTest 40 MM.</font></div></td>
        	<td><div  align="left"> <input id="PostTest40MM" name="PostTest40MM" type="text" value="<%= rst.getString("PostTest40MM") %>" readonly/> </div> </td>
        	</tr>
     	    <tr>
        	<td><div align="left"><font size="2">PostTest%.</font></div></td>
        	<td><div  align="left"> <input id="PostTest%" name="PostTest%" type="text" value="<%= rst.getString("PostTestper") %>"readonly /> </div> </td>
       		</tr>
    	    <tr>
        	<td><div align="left"><font size="2">Type of vehicle used for on road coaching and for assessment</font></div></td>
        	<td><div  align="left"> <input id="Typeofvehicle" name="Typeofvehicle" type="text" value="<%= rst.getString("Typeofvehicle") %>" readonly/> </div> </td>
       		</tr>
     		<tr>
			<td><div align="left"><font size="2">EducationGrade</font></div></td>
			<td><div align="left"><input id="Drivingschooleducationgrade" name="Drivingschooleducationgrade" type="text" value="<%= rst.getString("educationgrade") %>"readonly /> </div> </td>
			</tr>   
                          
                        
 		</table>
 		</div>
        



</div>
</div>
</form>
<%
}else
{

	
	
	System.out.println("IF driver information already exits");	
		
%>
<form name="trininginfo1" method="post" action="updatetrininginfo1.jsp?driverid=<%=driverid%>&father=<%=driverFatherName%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&drivname=<%=driverName%>&transporter=<%=transporter%>"  onSubmit="" >

<table border="0" align="center" width="100%"> 
<tr>
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
<td align="left"><font color="brown" size="3"><input type="submit" name="edit1" value="Edit" class="formElement" /></font>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font face="Arial" size="3" color="black">Driver Training Details</font>
</td>
</tr>
<%if(insert!=null && insert.equals("true"))
{%>

<script type="text/javascript">
alert("Record saved successfully");
window.location="trininginfo1.jsp?passportid=+"driverid;

</script>
<%}%>

</table>
</form>
<form action="updatetrininginfo1.jsp" style="overflow:scroll" > 
<div class="form_container" style="text-align: center;" align="center">
<div class="ScrollTable" style="height: 410px;">


<%System.out.println("transporter id ");
%>




<table border="0" width="100%" align="right" class="stats">


<tr>
<td align="right" width="30%">
<input type="hidden" id="driverid" name="driverid" class="element text medium"  value="<%=driverid%>"></input>
<div align="right" ><font size="2" face="Arial" >Driver Name  ffgffgfgghfgfhf</font></div></td>
<td width="80%"><div align="right">
<input  id="drivername" name="drivername" type="text" class="element text medium" value="<%=driverName%>" readonly/></div>
</td>
</tr>

<tr>
<td align="left" valign="top"><div align="left" ><font size="2" face="Arial" >Personal Details</font></div> </td>

<td> <div  align="left">
<a href="#" onClick="showwarcom('div1');"><font size="2" color="blue">Details</font></a>	</div>
<div id="div1" style="display:none"> 

<table border="0" >
<tr>
<td align="center" ><div align="left"><font size="2" face="Arial" >Father Name</font></div> </td>
<td ><div align="left" >&nbsp;<input id="driverfather" name="driverfather" type="text"  value="<%=driverFatherName%>"readonly /></div></td>
</tr>
   <tr>
   
<td align="left"><div  align="left"><font size="2" face="Arial">DOB </font></div> </td>
<td align="left"><div align="left">&nbsp;<input type="text" id="DOB" name="DOB"  value="<%=DOB%>" readonly/>
<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
	
</div></td>
</tr>
<tr>
<td><div align="left"><font size="2" face="Arial">Education</font></div></td>
<td><div  align="left">&nbsp;<input id="Education" name="Education" type="text" value="" readonly/> </div> </td>
	</tr>
	
</table>
</div>
</td>

</tr>               
<tr>
	<td align="center" width="30%"><div align="left"><font size="2" face="Arial" >Transporter </font></div></td>
	<td><div  align="left"><input id="transporter" name="transporter" type="text" value="<%=transporter%>" readonly/></div></td>
</tr> 

<tr>
    <td><div align="left"><font size="2" face="Arial">Vendor</font></div></td>
    <td><div  align="left"> <input id="vendor" name="vendor" type="text" class="element text medium" value="" readonly/> </div> </td>
	</tr>

<tr>
<td width="30%" valign="top"><div align="left"><font size="2" face="Arial">LicenseDetails</font></div></td>
<td><div  align="left">
		<a href="#" onClick="showwarcom('div2');"><font size="2" color="blue">Details</font></a></div>
		<div id="div2" style="display:none"> 

		<table border="0">
        	<tr>
				<td align="center"><div  align="left" face="Arial"><font size="2" >License No </font></div></td>
   			    <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=LicenseNo%>" readonly/> </div> </td>
			</tr>
			
			<tr>
				<td align="center"><div  align="left"><font size="2" face="Arial">ExpiryDate </font> </div></td>
				<td><div  align="left"><input type="text" id="licnExpiryDate" name="licnExpiryDate"  value=""  readonly/></div></td>
    		</tr>

			<tr>
   				<td><div align="left"><font size="2" face="Arial">Type</font></div></td>
  				<td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value=""readonly /> </div> </td>
   			</tr> 
   			
   			<tr>
				<td align="center"><div align="left"><font size="2" face="Arial" >Place of issue </font> </div>  </td>
    			<td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="" readonly/>  </div></td>
    		</tr>
	   </table>
	</div>
</td>
</tr>

	 
<tr>
<td align="center" width="30%" valign="top"><div align="left"><font size="2" face="Arial">MedicalExam </font></div> </td>
<td><div  align="left"><a href="#" onClick="showwarcom('div3');"><font size="2" color="blue">Details</font></a>
	</div>
		   <br> 
	<div id="div3" style="display:none"> 
	<table border="0">
			<tr>
			<td align="center"><div align="left"><font size="2" face="Arial" >Exam </font></div> </td>
	        <td><div  align="left">&nbsp;&nbsp;<input id="MedicalExam" name="MedicalExam" type="text" value="" readonly/></div>  </td>
			</tr>
						<tr>
			<td align="center"><div align="left"><font size="2" face="Arial" >Date</font></div> </td>
	        <td><div  align="left">&nbsp;&nbsp;<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value=""  readonly/></div></td>
			</tr>
			
			<tr>
				<td align="center"><div align="left"><font size="2" > ExpiryDate</font></div> </td>
	        	<td><div  align="left">&nbsp;&nbsp;<input type="text" id="MediclExpDate" name="MediclExpDate"  value=""  readonly/></div></td>
			</tr>
	</table>
	</div>
</td>
</tr>

<tr>
       <td align="center" width="30%" valign="top"><div align="left"><font size="2" >Training Details</font></div> </td>
       <td><div  align="left">   
       <a href="#" onClick="showwarcom('div4');"><font size="2" color="blue">Details</font></a></div>
		<br> 
		
	<div id="div4" style="display:none"> 
        <table border="0">
        <%
      //  System.out.println("From yraining details"+driverid);
        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'";
       System.out.println(" in already exits sql---->"+sql5);
        ResultSet rst5=st1.executeQuery(sql5);
     
        if(rst5.next())
        {  Basic=rst5.getString("Basic");
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

        
        
      //  System.out.println(Module5);
        if(Basic.equals("-")||Basic.equals("NULL"))
        {
        	
           	 out.print("<center> <table border='1' width='50%'><tr> <th> Details does not exist. </th> </tr>");
        }else{
        	%>
        		
        	
        		<tr>
            	<td align="center" valign="top"><div align="left"><font size="2" >Basic</font></div> </td>
           		 <td><div  align="left">   
           		 <a href="#" name="warcom" onClick="showwarcom('divb5');"><font size="2" color="blue">Details</font></a></div>
     		<br> 
     		<div id="divb5" style="display:none"> 

     	<table border="0" >
     	<tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value=""  readonly/>
     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		 
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
          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value=""readonly /></div>  </td>
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
            	   
              
               }else{
            	   %>
            	   
        	
        	<tr>
            <td align="center" valign="top"><div align="left"><font size="2" >Module1</font></div> </td>
            <td><div  align="left">
     		<a href="#" name="warcom" onClick="showwarcom('divb6');"><font size="2" color="blue">Details</font></a></div>
     <br> 
     <div id="divb6" style="display:none"> 

     	<table border="0" >
     		<tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value=""  readonly/>
     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
       		 
     		  </div></td>
               </tr> 
               
        
		
 		  
		
		       
          
         <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
          <td><div  align="left"><input id="Module1TrainingLocation" name="Module1TrainingLocation" type="text" value=""readonly /></div>  </td>
       
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
        	
        }else{
        	%>
        	
        	        	<tr>
       <td align="center" valign="top"><div align="left"><font size="2" >Module2</font></div> </td>
       <td> <div  align="left">
         <a href="#" onClick="showwarcom('divb7');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="divb7" style="display:none"> 

	<table border="0" >
	 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="" readonly />
			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
  		  
		  </div></td>
          </tr> 
		
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
          <td><div  align="left"><input id="Module2TrainingLocation" name="Module2TrainingLocation" type="text" value=""readonly /></div>  </td>
         
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
        		
        	}else{
        		%>

        	<tr>
        	        <td align="center" valign="top"><div align="left"><font size="2" >Module3</font></div> </td>
        	        <td> <div  align="left">
        			<a href="#" name="warcom" onClick="showwarcom('divb8');"><font size="2" color="blue">Details</font></a></div>
        			<br> 
        			<div id="divb8" style="display:none"> 

        			<table border="0" >
        			 <tr>
        			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
        	          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="" readonly />
        				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
        	  		 
        			  </div></td>
        	          </tr> 
        			
        	         <tr>
        			  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
        	          <td><div  align="left"><input id="Module3TrainingLocation" name="Module3TrainingLocation" type="text" value=""readonly /></div> 
        	            </td></tr>
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
        	          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value=""readonly /></div>  </td>
        	          </tr>
        	          </table>
        			</div>
        			</td>
        			</tr>
        	       <%
        	       if(Module4.equals("-")||Module4.equals("NULL"))
        	       {
        	    	   
        	       }else{
        	    	   
        	       
        	    	   %>
        	    	  
        	          
        	            <tr>
        	             <td align="center" valign="top"><div align="left"><font size="2" >Module4</font></div> </td>
        	               <td> <div  align="left">
        	      		<a href="#" name="warcom" onClick="showwarcom('divb9');"><font size="2" color="blue">Details</font></a></div>
        	      		<br> 
        	      		<div id="divb9" style="display:none"> 
        	      		<table border="0" width="100%">             
        	                <tr>
        	      		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
        	                <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="" readonly />
        	      			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
        	        		 
        	      		  </div></td>
        	                </tr> 
        	                
        	              	  <tr>
        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
        	              			  <td><div  align="left"><input id="Module4TrainingLocation" name="Module4TrainingLocation" type="text" value=""readonly /></div>  </td>
        	                	 </tr>
        	               	 <tr>
        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
        	               			 <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value=""readonly /></div>  </td>
        	              	  </tr>
        	               	 <tr>
        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
        	               			 <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value=""readonly /></div>  </td>
        	              	  </tr>
        	              	  <tr>
        	      					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
        	               			 <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value=""readonly /></div>  </td>
        	             		   </tr>
        	      		</table>
        	      		</div>
        	      		</td>
        	      		</tr>
        	      		<%
        	       
        	      		if(Module5.equalsIgnoreCase("-")||"null".equalsIgnoreCase(Module5)||null==Module5){
        	      			
        	      		}else{
        	      			//System.out.println("module5 is null");
        	      			
        	      			%>
        	      			
        	      			        	      		  <tr>
	        	             <td align="center" valign="top"><div align="left"><font size="2" >Module5</font></div> </td>
	        	             <td> <div  align="left">
	        	      				<a href="#" name="warcom" onClick="showwarcom('divb22');"><font size="2" color="blue">Details</font></a></div>
	        	      				<br> 
	        	      				<div id="divb22" style="display:none"> 
	        	      					<table border="0" >             
	        	                			<tr>
	        	      		  					<td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
	        	                				<td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="" readonly />
	        	      								<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
							        	      		  </div>
							        	      	</td>
	        	                			</tr> 
  			        	              	    <tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  		<td><div  align="left"><input id="Module5TrainingLocation" name="Module5TrainingLocation" type="text" value=""readonly /></div>  </td>
	        	                	 		</tr>
	        	               	 			<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
	        	               			 		<td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value=""readonly /></div>  </td>
	        	              	  			</tr>
	        	               	 			<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
	        	               			 		<td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value=""readonly /></div>  </td>
	        	              	  			</tr>
	        	              	  			<tr>
	        	      					  		<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
	        	               			 		<td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value=""readonly /></div>  </td>
	        	             		   		</tr>
	        	      					</table>
	        	      				</div>
	        	      			</td>
	        	      		</tr>
	        	      		<%
        	      		
        
        	 		   if(Capsule1.equals("-")||Capsule1.equals("NULL")){
        	 			   
        	 		   }else{

        	 			   %>
        	 			  
        	 			   
        	      		
		<tr>
		      					 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 1</font></div> </td>
		        				 <td> <div  align="left">
								<a href="#" name="warcom" onClick="showwarcom('divsb18');"><font size="2" color="blue">Details</font></a></div>
								<br> 
								<div id="divsb18" style="display:none"> 
								<table border="0" >             
		      				    <tr>
								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		      					    <td> <div  align="left"><input type="text" id="Capsule1date" name="Capsule1date"  value=""  readonly/>
		  						  
							  </div></td>
		       				   </tr> 
		          
		        				<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  		<td><div  align="left"><input id="Capsule1TrainingLocation" name="Capsule1TrainingLocation" type="text" value=""readonly /></div>  </td>
	        	                	 		</tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		          <td> <div  align="left"><input id="Capsule1TrainerName" name="Capsule1TrainerName" type="text" value="" readonly /></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		          <td> <div  align="left"><input id="Capsule1TrainingCompany" name="Capsule1TrainingCompany" type="text" value="" readonly /></div>  </td>
		          </tr>
		          <tr>
				  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		          <td> <div  align="left"><input id="Capsule1Comments" name="Capsule1Comments" type="text" value="" readonly /></div>  </td>
		          </tr>
				</table>
				</div>
				</td>
				</tr>	
		
		
		
		
		<% 

   
   if(Capsule2.equals("-")||Capsule2.equals("NULL")){
	   
   }else{
   
   %>
   
        	      		
        <tr>
			 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 2</font></div> </td>
			 <td> <div  align="left">
			<a href="#" name="warcom" onClick="showwarcom('divsb20');"><font size="2" color="blue">Details</font></a></div>
			<br> 
			<div id="divsb20" style="display:none"> 
			<table border="0" >             
		    <tr>
								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		      					    <td> <div  align="left"><input type="text" id="Capsule2date" name="Capsule2date"  value=""  readonly/>
		  						  
							  </div></td>
		       				   </tr> 
		          
		        				<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  		<td><div  align="left"><input id="Capsule2TrainingLocation" name="Capsule2TrainingLocation" type="text" value=""readonly /></div>  </td>
	        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="Capsule2TrainerName" name="Capsule2TrainerName" type="text" value="" readonly /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="Capsule2TrainingCompany" name="Capsule2TrainingCompany" type="text" value="" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="Capsule2Comments" name="Capsule2Comments" type="text" value="" readonly/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>		      		
        	      		
    <%
		
		
   if(Capsule3.equals("-")||Capsule3.equals("NULL")){
	   
   }else{
   %>
  
   
        	      		
        <tr>
	 <td align="center" valign="top"><div align="left"><font size="2" >Capsule 3</font></div> </td>
	 <td> <div  align="left">
	<a href="#" name="warcom" onClick="showwarcom('divsb22');"><font size="2" color="blue">Details</font></a></div>
	<br> 
	<div id="divsb22" style="display:none"> 
	<table border="0" >             
    <tr>
								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		      					    <td> <div  align="left"><input type="text" id="Capsule3date" name="Capsule3date"  value=""  readonly/>
		  						  
							  </div></td>
		       				   </tr> 
		          
		        				<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  		<td><div  align="left"><input id="Capsule3TrainingLocation" name="Capsule3TrainingLocation" type="text" value=""readonly /></div>  </td>
	        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="Capsule3TrainerName" name="Capsule3TrainerName" type="text" value="" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="Capsule3TrainingCompany" name="Capsule3TrainingCompany" type="text" value="" readonly /></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="Capsule3Comments" name="Capsule3Comments" type="text" value="" readonly readonly/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>		      		
<%	        	      		

	
   if(BTD.equals("-")||BTD.equals("NULL")){
	   
   }else{
	   
   
	%>
	
	        	<tr>
	 <td align="center" valign="top"><div align="left"><font size="2" >Bulk Tanker Driver details</font></div> </td>
	 <td> <div  align="left">
	<a href="#" name="warcom" onClick="showwarcom('divsb24');"><font size="2" color="blue">Details</font></a></div>
	<br> 
	<div id="divsb24" style="display:none"> 
	<table border="0" >             
    <tr>
								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		      					    <td> <div  align="left"><input type="text" id="BTDdate" name="BTDdate"  value=""  readonly/>
		  						  
							  </div></td>
		       				   </tr> 
		          
		        				<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  		<td><div  align="left"><input id="BTDTrainingLocation" name="BTDTrainingLocation" type="text" value=""readonly /></div>  </td>
	        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="BTDTrainerName" name="BTDTrainerName" type="text" value="" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="BTDTrainingCompany" name="BTDTrainingCompany" type="text" value="" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="BTDComments" name="BTDComments" type="text" value="" readonly/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	  
        	  
<%
		
  
   if(ORA.equals("-")||ORA.equals("NULL")){
	   
   }else{
	%>
	
	        	  
   <tr>
	 <td align="center" valign="top"><div align="left"><font size="2" >On road assessment details</font></div> </td>
	 <td> <div  align="left">
	<a href="#" name="warcom" onClick="showwarcom('divsb26');"><font size="2" color="blue">Details</font></a></div>
	<br> 
	<div id="divsb26" style="display:none"> 
	<table border="0" >
	
	
	<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >Vehicle Type</font></div></td>
	        	              			  		<td><div  align="left"><input id="ORAVehicleType" name="ORAVehicleType" type="text" value="<%=rst.getString("ORAVehType")%>"readonly /></div>  </td>
	        	                	 		</tr>
	
	
	
	
	
	             
     <tr>
								  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		      					    <td> <div  align="left"><input type="text" id="ORAdate" name="ORAdate"  value=""  readonly/>
		  						  
							  </div></td>
		       				   </tr> 
		          
		        				<tr>
	        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  		<td><div  align="left"><input id="ORATrainingLocation" name="ORATrainingLocation" type="text" value=""readonly /></div>  </td>
	        	                	 		</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
<td> <div  align="left"><input id="ORATrainerName" name="ORATrainerName" type="text" value="" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
<td> <div  align="left"><input id="ORATrainingCompany" name="ORATrainingCompany" type="text" value="" readonly/></div>  </td>
</tr>
<tr>
<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
<td> <div  align="left"><input id="ORAComments" name="ORAComments" type="text" value="" readonly/></div>  </td>
</tr>
</table>
</div>
</td>
</tr>	

 	  
        	  
        	      		
        	      		
        	      		
        <%	      		}
   }
   }
       }
   		}
   	        	      		}
           	      		}
           	       }
           	}
           }
                  }
           }else
   // }
           {
           	
           	out.print("<center> <table border='1' width='50%'><tr> <th> Details does not exist. </th> </tr>");
           }
        	      		
        		
        	      		
        
        %>
		</table>
		</div>
		</td>
        </tr>    
                 
  <tr>
  		<td align="center"><div  align="left"><font size="2" >Remark</font></div></td>
  		<td> <div  align="left"><input id="remark" name="remark" type="text" value="" readonly/></div>  </td>
  </tr> 
  
  <tr>
  <td align="center" valign="top"><div align="left"><font size="2" >FT Training </font></div> </td>
  <td><div  align="left"><a href="#" name="warcom" onClick="showwarcom('div10');"><font size="2" color="blue">Details</font></a></div>
<br> 
<div id="div10" style="display:none"> 

<table border="0" >

<tr>
  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
  <td><div  align="left">&nbsp;<input id="FTTraining" name="FTTraining" type="text" value="" readonly/> </div> </td>
  </tr> 
 
  <tr>
<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
<td> <div  align="left">
&nbsp;<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value=""  readonly/>
<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
	
</div></td>
</tr>

</table>
</div>
</td>
</tr>
  
  <tr><td align="center" valign="top"><div align="left"><font size="2" >Last Training </font></div> </td>
<td><div  align="left">
<a href="#" name="warcom" onClick="showwarcom('div11');"><font size="2" >Details</font></a></div>
<br> 
<div id="div11" style="display:none"> 

<table border="0" >

<tr>
  <td align="center"><div align="left"><font size="2" >LastTraining</font> </div> </td>
  <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="" readonly/></div>  </td>
  </tr> 
            
  <tr>
  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
  <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="" readonly />
	<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
	 
  </div></td>
  </tr> 

</table>
</div>
</td>
</tr>
    <tr>
	<td><div align="left"><font size="2">PreTest 40 MM.</font></div></td>
    <td><div  align="left"> <input id="PreTest40MM" name="PreTest40MM" type="text" value="" readonly/> </div> </td>
		</tr>
		
		<tr>
		<td><div align="left"><font size="2">PreTest %</font></div></td>
		<td><div  align="left"> <input id="PreTest%" name="PreTest%" type="text" value="" readonly/> </div> </td>
		</tr>
	<tr>
	<td><div align="left"><font size="2">PostTest 40 MM.</font></div></td>
	<td><div  align="left"> <input id="PostTest40MM" name="PostTest40MM" type="text" value="" readonly/> </div> </td>
	</tr>
	    <tr>
	<td><div align="left"><font size="2">PostTest%.</font></div></td>
	<td><div  align="left"> <input id="PostTest%" name="PostTest%" type="text" value=""readonly /> </div> </td>
		</tr>
    <tr>
	<td><div align="left"><font size="2">Type of vehicle used for on road coaching and for assessment</font></div></td>
	<td><div  align="left"> <input id="Typeofvehicle" name="Typeofvehicle" type="text" value="" readonly/> </div> </td>
		</tr>
		<tr>
	<td><div align="left"><font size="2">EducationGrade</font></div></td>
	<td><div align="left"><input id="Drivingschooleducationgrade" name="Drivingschooleducationgrade" type="text" value=""readonly /> </div> </td>
	</tr>   
                  
                
	</table>




</div>
</div>
</form>
<%

       

}}catch(Exception e)
{
	e.printStackTrace();
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


