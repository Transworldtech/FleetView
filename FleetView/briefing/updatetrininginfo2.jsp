<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

<%@ include file="../Connections/conn.jsp" %>
<html>
<head>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
    
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

</script>

<%!
Connection conn;
Statement st,st1,st2,st3,st4;

%>

<body bgcolor="	#98AFC7">
<%

String sql=null,sql11=null, driverid="",Transporter="",passportid="",father="",DOB1="",Basic="",LicenseNo="",Module1="",drivname="",Module2="",Module3="",Module4="",Module5="";
driverid=request.getParameter("driverid");
father=request.getParameter("father");
DOB1=request.getParameter("DOB");
LicenseNo=request.getParameter("LicenseNo");
drivname=request.getParameter("drivname");
passportid=request.getParameter("passportid");
Transporter=request.getParameter("transporter");
//out.println(passportid);
try{
			Class.forName(MM_dbConn_DRIVER);
			conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
			st=conn.createStatement();
			st1=conn.createStatement();
			st2=conn.createStatement();
			st3=conn.createStatement();
			st4=conn.createStatement();
	//if passport id is present in t_drivers data will b displayed from t_drivertraining using passportid
			String sql111="select * from t_drivers where DriverID= '"+passportid+"' and GPNAME='Castrol'";
			//out.println(sql111);
			ResultSet rst11=st4.executeQuery(sql111);
			if(rst11.next())
			{
				//
				//out.println("now in t_drivers");
				sql="select * from t_drivertraining where Dcode = '"+passportid+"' order by Sr desc limit 1";
				ResultSet rst=st.executeQuery(sql);
				if(rst.next())
				{
				//	out.println("now in t_drivertraining");
%>

<form name="trininginfo1" method="post" action="trininginfo2.jsp?driverid=<%=driverid%>&passportid=<%=passportid%>&driverName=<%=drivname%>&driverFatherName=<%=father%>&DOB=<%=DOB1%>&LicenseNo=<%=LicenseNo%>&transporter=<%=Transporter%>" onSubmit="" >
<table border="0" align="center" width="100%"> 
<tr>
		<td align="left"><input type="submit" name="Submit1" value="BACK" class="formElement" /></td>
		<td><font color="brown" size="3">Driver Training Details</font></td>

			</tr></table></form>
<form method="post" action="edittrininginfo2.jsp"  style="overflow:scroll"> 


<div class="ScrollTable" style="height: 530px;">
   
<table border="1" width="100%" align="center"   >
<tr><td>
<table class="stats">
<tr></tr>
<tr><td>
 <table border="2" width="100%" align="center" class="stats">
     
     
        <tr>
		<td align="left" width="30%">
		<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
		<div align="left"><font size="2" >Driver Name  </font></div></td>
        <td width="70%"><div align="left">
		<input id="drivername" name="drivername" type="text" value="<%= rst.getString("DriverName") %>" /></div>
		</td>
		</tr>
		
		<tr>
		<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
		<td><div  align="left">   
     <a href="#" onClick="showwarcom('div1');"><font size="2" >Details</font></a>	</div>
       <div id="div1" style="display:none"> 

	<table border="0" width="100%">
	<tr>
		<td align="center"><div align="left"><font size="2" >Father Name</font></div> </td>
        <td><div align="left"><input id="driverfather" name="driverfather" type="text" value="<%= rst.getString("DriverFatherName") %>" /></div></td>
		</tr>
	       <tr>
		<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=rst.getString("DOB")%>" readonly/>
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
						<option value="<%= rst.getString("Transporter") %>"><%= rst.getString("Transporter") %></option>
							
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
        <td><div align="left"><font size="2">vendor</font></div></td>
        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="<%= rst.getString("vendor") %>" /> </div> </td>
       	</tr>
       		             
		
		
	
        <tr><td><div align="left"><font size="2">LicenseDetails</font></div></td>
         <td><div  align="left">   
      <a href="#" name="warcom" onClick="showwarcom('div2');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div2" style="display:none"> 

	<table border="0" width="100%">
	        <tr>
		<td align="center"><div  align="left"><font size="2" >No </font></div></td>
        <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=rst.getString("licenceno") %>" /> </div> </td>
		</tr>
			<tr>
		<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
		<td><div  align="left">
		    <input type="text" id="licnExpiryDate" name="licnExpiryDate"  value="<%=rst.getString("ExpiryDate")%>"  readonly/>
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
        
       	 
	<tr><td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div3');"><font size="2" >Details</font></a></div>
<br> 
<div id="div3" style="display:none"> 

	<table border="0" width="100%">
	 <tr>
		<td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="<%= rst.getString("MedicalExam") %>" /></div>  </td>
		</tr>
		<tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value="<%=rst.getString("MedicalExamdate")%>"  readonly/>
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
		<input type="text" id="MediclExpDate" name="MediclExpDate"  value="<%=rst.getString("ExpiryDate2")%>"  readonly/>
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
       <a href="#" name="warcom" onClick="showwarcom('div4');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div4" style="display:none"> 
        <table border="0" width="100%">
        <%
      //  System.out.println(driverid);
        String sql5="Select * from t_drivertraining where dcode ='"+passportid+"' order by Sr desc limit 1";
      //  System.out.println(sql5);
        ResultSet rst5=st1.executeQuery(sql5);
     
        if(rst5.next())
        {  
        	
       	Basic=rst5.getString("Basic");
        Module1=rst5.getString("Module1");
        Module2=rst5.getString("Module2");
        Module3=rst5.getString("Module3");
        Module4=rst5.getString("Module4");
        Module5=rst5.getString("Module5");
        		if(Basic.equals("-")||Basic.equals("NULL"))
        		{//System.out.println("hfskdjhfskdjhfsdihfsadoipfha");
        %>	<tr>
		       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		       <a href="#" name="warcom" onClick="showwarcom('div5');"><font size="2" >Details</font></a></div>
				<br> 
				<div id="div5" style="display:none"> 

				<table border="0" width="100%">
				<tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=rst.getString("basicdate")%>" readonly/>
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
        }else{
        	%>
       				 <tr>
				       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
				       <td><div  align="left">   
				       <a href="#" name="warcom" onClick="showwarcom('div6');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div6" style="display:none"> 

						<table border="0" width="100%">
						<tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=rst.getString("basicdate")%>"  readonly/>
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
              				 if(Module1.equals("-")||Module1.equals("NULL"))
              				 {
              					 %>
              					 <tr>
					       <td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
					       <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('div7');"><font size="2" >Details</font></a></div>
					<br> 
					<div id="div7" style="display:none"> 
					
						<table border="0" width="100%">
							<tr>
							  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					          <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=rst.getString("Module1date")%>"  readonly/>
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
        					else
        					{
        					%>
		    			    <tr>
       						<td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
      						 <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('div8');"><font size="2" >Details</font></a></div>
							<br> 
							<div id="div8" style="display:none"> 

							<table border="0" width="100%">
							<tr>
						   <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
         					 <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=rst.getString("Module1date")%>"  readonly/>
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
        			if(Module2.equals("-")||Module2.equals("NULL"))
        				{
        				%>
        				<tr>
          				  <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
          				  <td> <div  align="left">
           				   <a href="#" name="warcom" onClick="showwarcom('div9');"><font size="2" >Details</font></a></div>
 					    <br> 
  						   <div id="div9" style="display:none"> 

     	<table border="0" width="100%">
     	 <tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=rst.getString("Module2date")%>" />
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
						 		<option value="<%=rst.getString("Module2")%>"><%=rst.getString("Module2")%></option>
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
     		<% 
        }
        else
        {
        	%>       
			<tr>
       <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
       <td> <div  align="left">
        <a href="#" name="warcom" onClick="showwarcom('div10');"><font size="2" >Details</font></a></div>
<br> 
<div id="div10" style="display:none"> 

	<table border="0" width="100%">
	 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=rst.getString("Module2date")%>"  readonly/>
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
        <%
        	if(Module3.equals("-")||Module3.equals("NULL"))
        	{
        		%>
        		 <tr>
        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div11');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div11" style="display:none"> 

		<table border="0" width="100%">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=rst.getString("Module3date")%>"  />
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
	 		<option value="<%=rst.getString("Module3")%>"><%=rst.getString("Module3")%></option>
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
        		<%
        	}else
        	{
        		 %>		 <tr>
        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div12');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div12" style="display:none"> 

		<table border="0" width="100%">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=rst.getString("Module3date")%>" readonly/>
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
		 <%
        	if(Module4.equals("-")||Module4.equals("NULL"))
        	{
        		%>
       					<tr>
      					 <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('div13');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div13" style="display:none"> 
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
						 <a href="#" name="warcom" onClick="showwarcom('div14');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div14" style="display:none"> 
						<table border="0" width="100%">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=rst.getString("Module4date")%>" readonly/>
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
		   <%
		   if(Module5.equals("-")||Module5.equals("NULL"))
       		{
       		%>
      					<tr>
     					 <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
       				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('div13');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div13" style="display:none"> 
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
						 String sql84="select LName from  db_CustomerComplaints.t_location order by LName";
						 ResultSet rst84=st3.executeQuery(sql84);
						 while(rst84.next())
						  { %>
 						   <option value="<%=rst84.getString("LName") %>"> <%=rst84.getString("LName") %> </option>
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
						 <a href="#" name="warcom" onClick="showwarcom('div14');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div14" style="display:none"> 
						<table border="0" width="100%">             
     				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
     					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=rst.getString("Module5date")%>" readonly/>
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
						 String sql54="select LName from  db_CustomerComplaints.t_location order by LName";
						 ResultSet rst54=st3.executeQuery(sql54);
						 while(rst54.next())
						  { %>
 						   <option value="<%=rst54.getString("LName") %>"> <%=rst54.getString("LName") %> </option>
						<% } %>
					   
 						 </select></div>  </td></tr>
         <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
         <td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="<%=rst.getString("Module5TrainerName")%>" /></div>  </td>
         </tr>
         <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
         <td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="<%=rst.getString("                                                                                                                                                               TrainingCompany")%>"/></div>  </td>
         </tr>
         <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
         <td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="<%=rst.getString("Module5Comments")%>"/></div>  </td>
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
        }
        }
        
        %>
           </table>
		</div>
		</td>
		</tr>         
          <tr>
		  <td align="center"><div  align="left"><font size="2" >Remark</font></div></td>
          <td> <div  align="left"><input id="remark" name="remark" type="text" value="<%= rst.getString("remark") %>" /></div>  </td>
          </tr> 
          
          <tr><td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div15');"><font size="2" >Details</font></a></div>
<br> 
<div id="div15" style="display:none"> 

	<table border="0" width="100%">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
          <td><div  align="left"> <input id="FTTraining" name="FTTraining" type="text" value="<%= rst.getString("FTTraining") %>" /> </div> </td>
          </tr> 
          <tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value="<%=rst.getString("FTTrainingdate")%>"  readonly/>
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
		<a href="#" name="warcom" onClick="showwarcom('div16');"><font size="2" >Details</font></a></div>
<br> 
<div id="div16" style="display:none"> 

	<table border="0" width="100%">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >Last Training</font> </div> </td>
          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="<%= rst.getString("LastTraining") %>" /></div>  </td>
          </tr> 
                        
          <tr>
		  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="<%=rst.getString("LastTrainingDate")%>"  readonly/>
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
}}//if passportid is not present in t_driver, details will be displayed from t_drivertraining using reference driverid
else
{	//out.println("now in else");		
sql11="select * from t_drivertraining where Dcode = '"+driverid+"' order by Sr desc limit 1";
ResultSet rst=st.executeQuery(sql11);
if(rst.next())
{ //out.println("details are present in t_drivertraining using refence driverid");
	%>
<form name="trininginfo2" method="post" action="trininginfo2.jsp?driverid=<%=driverid%>&father=<%=father%>&DOB=<%=DOB1%>&LicenseNo=<%=LicenseNo%>&drivname=<%=drivname%>&passportdid=<%=passportid%>&transporter=<%=Transporter %>" onSubmit="" >
<table border="0" align="center" width="100%"> 
<tr>
		<td align="left"><input type="submit" name="Submit1" value="BACK" class="formElement" /></td>
		<td><font color="brown" size="3">Driver Training Details</font></td>

			</tr></table></form>
<form  method="post"  action="edittrininginfo2.jsp" style="overflow:scroll"> 

<div class="ScrollTable" style="height: 530px;">
   
<table border="1" width="100%" align="center"   >
<tr><td>
<table class="stats">

<tr><td>
 <table border="2" width="100%" align="center" class="stats">
     
     
        <tr>
		<td align="left" width="30%">
		<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
		<div align="left"><font size="2" >Driver Name  </font></div></td>
        <td width="70%"><div align="left">
		<input id="drivername" name="drivername" type="text" value="<%= rst.getString("DriverName") %>" /></div>
		</td>
		</tr>
		
		<%
		if(passportid.equals("")||passportid.equals("null"))
		{//out.println("now in if");
		%>
		<tr>
		<td align="center"><div align="left"><font size="2" >Password ID</font></div> </td>
        <td><div align="left"><input id="passid" name="passid" type="text" value="" /></div></td>
		</tr>
		<%}else
			{
			%>
			<tr>
			<td align="center"><div align="left"><font size="2" >Password ID</font></div> </td>
	        <td><div align="left"><input id="passid" name="passid" type="text" value="<%=passportid%>" readonly/></div></td>
			</tr>
		<%	
			}%>
			
		<tr>
		<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
		<td><div  align="left">   
     <a href="#" onClick="showwarcom('div1');"><font size="2" >Details</font></a>	</div>
       <div id="div1" style="display:none"> 

	<table border="0" width="100%">
	<tr>
		<td align="center"><div align="left"><font size="2" >Father Name</font></div> </td>
        <td><div align="left"><input id="driverfather" name="driverfather" type="text" value="<%= rst.getString("DriverFatherName") %>" /></div></td>
		</tr>
	       <tr>
		<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=rst.getString("DOB")%>" readonly/>
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
						<option value="<%= rst.getString("Transporter") %>"><%= rst.getString("Transporter") %></option>
							
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
        <td><div align="left"><font size="2">vendor</font></div></td>
        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="<%= rst.getString("vendor") %>" /> </div> </td>
       	</tr>
       		             
		
		
	
        <tr><td><div align="left"><font size="2">LicenseDetails</font></div></td>
         <td><div  align="left">   
      <a href="#" name="warcom" onClick="showwarcom('div2');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div2" style="display:none"> 

	<table border="0" width="100%">
	        <tr>
		<td align="center"><div  align="left"><font size="2" >No </font></div></td>
        <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=rst.getString("licenceno") %>" /> </div> </td>
		</tr>
			<tr>
		<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
		<td><div  align="left">
		    <input type="text" id="licnExpiryDate" name="licnExpiryDate"  value="<%=rst.getString("ExpiryDate")%>"  readonly/>
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
        
       	 
	<tr><td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div3');"><font size="2" >Details</font></a></div>
<br> 
<div id="div3" style="display:none"> 

	<table border="0" width="100%">
	 <tr>
		<td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="<%= rst.getString("MedicalExam") %>" /></div>  </td>
		</tr>
		<tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value="<%=rst.getString("MedicalExamdate")%>"  readonly/>
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
		<input type="text" id="MediclExpDate" name="MediclExpDate"  value="<%=rst.getString("ExpiryDate2")%>"  readonly/>
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
       <a href="#" name="warcom" onClick="showwarcom('div4');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div4" style="display:none"> 
        <table border="0" width="100%">
        <%
       // System.out.println(driverid);
        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"' order by Sr desc limit 1";
       // System.out.println(sql5);
        ResultSet rst5=st1.executeQuery(sql5);
     
        if(rst5.next())
        {  
        	
       	Basic=rst5.getString("Basic");
        Module1=rst5.getString("Module1");
        Module2=rst5.getString("Module2");
        Module3=rst5.getString("Module3");
        Module4=rst5.getString("Module4");
        Module5=rst5.getString("Module5");
        		if(Basic.equals("-")||Basic.equals("NULL"))
        		{//System.out.println("hfskdjhfskdjhfsdihfsadoipfha");
        %>	<tr>
		       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		       <a href="#" name="warcom" onClick="showwarcom('div5');"><font size="2" >Details</font></a></div>
				<br> 
				<div id="div5" style="display:none"> 

				<table border="0" width="100%">
				<tr>
				  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=rst.getString("basicdate")%>" readonly/>
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
        }else{
        	%>
       				 <tr>
				       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
				       <td><div  align="left">   
				       <a href="#" name="warcom" onClick="showwarcom('div6');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div6" style="display:none"> 

						<table border="0" width="100%">
						<tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				          <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=rst.getString("basicdate")%>"  readonly/>
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
              				 if(Module1.equals("-")||Module1.equals("NULL"))
              				 {
              					 %>
              					 <tr>
					       <td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
					       <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('div7');"><font size="2" >Details</font></a></div>
					<br> 
					<div id="div7" style="display:none"> 
					
						<table border="0" width="100%">
							<tr>
							  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
					          <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=rst.getString("Module1date")%>"  readonly/>
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
        					else
        					{
        					%>
		    			    <tr>
       						<td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
      						 <td><div  align="left">
							<a href="#" name="warcom" onClick="showwarcom('div8');"><font size="2" >Details</font></a></div>
							<br> 
							<div id="div8" style="display:none"> 

							<table border="0" width="100%">
							<tr>
						   <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
         					 <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=rst.getString("Module1date")%>"  readonly/>
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
        			if(Module2.equals("-")||Module2.equals("NULL"))
        				{
        				%>
        				<tr>
          				  <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
          				  <td> <div  align="left">
           				   <a href="#" name="warcom" onClick="showwarcom('div9');"><font size="2" >Details</font></a></div>
 					    <br> 
  						   <div id="div9" style="display:none"> 

     	<table border="0" width="100%">
     	 <tr>
     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
               <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=rst.getString("Module2date")%>" />
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
						 		<option value="<%=rst.getString("Module2")%>"><%=rst.getString("Module2")%></option>
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
     		<% 
        }
        else
        {
        	%>       
			<tr>
       <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
       <td> <div  align="left">
        <a href="#" name="warcom" onClick="showwarcom('div10');"><font size="2" >Details</font></a></div>
<br> 
<div id="div10" style="display:none"> 

	<table border="0" width="100%">
	 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=rst.getString("Module2date")%>"  readonly/>
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
        <%
        	if(Module3.equals("-")||Module3.equals("NULL"))
        	{
        		%>
        		 <tr>
        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div11');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div11" style="display:none"> 

		<table border="0" width="100%">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=rst.getString("Module3date")%>"  />
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
	 		<option value="<%=rst.getString("Module3")%>"><%=rst.getString("Module3")%></option>
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
        		<%
        	}else
        	{
        		 %>		 <tr>
        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
        <td> <div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div12');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div12" style="display:none"> 

		<table border="0" width="100%">
		 <tr>
		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=rst.getString("Module3date")%>" readonly/>
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
		 <%
        	if(Module4.equals("-")||Module4.equals("NULL"))
        	{
        		%>
       					<tr>
      					 <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('div13');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div13" style="display:none"> 
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
						 <a href="#" name="warcom" onClick="showwarcom('div14');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div14" style="display:none"> 
						<table border="0" width="100%">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=rst.getString("Module4date")%>" readonly/>
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
		   <%
		   if(Module5.equals("-")||Module5.equals("NULL"))
       	{
       		%>
      					<tr>
     					 <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
       				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('div93');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div93" style="display:none"> 
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
						 String sql84="select LName from  db_CustomerComplaints.t_location order by LName";
						 ResultSet rst84=st3.executeQuery(sql84);
						 while(rst84.next())
						  { %>
 						   <option value="<%=rst84.getString("LName") %>"> <%=rst84.getString("LName") %> </option>
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
						 <a href="#" name="warcom" onClick="showwarcom('div94');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div94" style="display:none"> 
						<table border="0" width="100%">             
     				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
     					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=rst.getString("Module5date")%>" readonly/>
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
						 String sql84="select LName from  db_CustomerComplaints.t_location order by LName";
						 ResultSet rst84=st3.executeQuery(sql84);
						 while(rst84.next())
						  { %>
 						   <option value="<%=rst84.getString("LName") %>"> <%=rst84.getString("LName") %> </option>
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
		   <%
			   }  
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
		      <a href="#" name="warcom" onClick="showwarcom('div30');"><font size="2" >Details</font></a></div>
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
     <%   }
        
        %>
           </table>
		</div>
		</td>
		</tr>         
          <tr>
		  <td align="center"><div  align="left"><font size="2" >Remark</font></div></td>
          <td> <div  align="left"><input id="remark" name="remark" type="text" value="<%= rst.getString("remark") %>" /></div>  </td>
          </tr> 
          
          <tr><td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
	<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div15');"><font size="2" >Details</font></a></div>
<br> 
<div id="div15" style="display:none"> 

	<table border="0" width="100%">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
          <td><div  align="left"> <input id="FTTraining" name="FTTraining" type="text" value="<%= rst.getString("FTTraining") %>" /> </div> </td>
          </tr> 
          <tr>
		<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
        <td> <div  align="left">
		<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value="<%=rst.getString("FTTrainingdate")%>"  readonly/>
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
		<a href="#" name="warcom" onClick="showwarcom('div16');"><font size="2" >Details</font></a></div>
<br> 
<div id="div16" style="display:none"> 

	<table border="0" width="100%">
	 
		<tr>
		  <td align="center"><div align="left"><font size="2" >Last Training</font> </div> </td>
          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="<%= rst.getString("LastTraining") %>" /></div>  </td>
          </tr> 
                        
          <tr>
		  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="<%=rst.getString("LastTrainingDate")%>"  readonly/>
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
<td><input type="submit" value="Submit" >
</td>
</tr>



</table>
</td>
</tr>
</table>
</div>
</form>
<%//if data is not present in t_drivertraining using driverid and passportid this else condition will be executed.
}else
{//out.println("when data is not present in t_drivertraining");
	%>
	<form name="trininginfo2" method="post" action="trininginfo2.jsp?driverid=<%=driverid%>&father=<%=father%>&DOB=<%=DOB1%>&LicenseNo=<%=LicenseNo%>&drivname=<%=drivname%>&passportdid=<%=passportid%>&transporter=<%=Transporter %>" onSubmit="" >
<table border="0" align="center" width="100%"> 
<tr>
		<td align="left"><input type="submit" name="Submit1" value="BACK" class="formElement" /></td>
		<td><font color="brown" size="3">Driver Training Details</font></td>

			</tr></table></form>
<form  method="post"  action="edittrininginfo2.jsp" style="overflow:scroll"> 

<div class="ScrollTable" style="height: 530px;">
   
<table border="1" width="100%" align="center"   >
<tr><td>
<table class="stats">

<tr><td>
 <table border="2" width="100%" align="center" class="stats">
     
     
        <tr>
		<td align="left" width="30%">
		<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
		<div align="left"><font size="2" >Driver Name  </font></div></td>
        <td width><div align="left">
		<input id="drivername" name="drivername" type="text" value="<%=drivname%>" /></div>
		</td>
		</tr>
		
		<%//out.println("passportid--->"+passportid);
		if(passportid.equals("")||passportid.equals("null"))
		{//out.println("now in if");
		%>
		<tr>
		<td align="center"><div align="left"><font size="2" >Password ID</font></div> </td>
        <td><div align="left"><input id="passid" name="passid" type="text" value="" /></div></td>
		</tr>
		<%}else
			{
			%>
			<tr>
			<td align="center"><div align="left"><font size="2" >Password ID</font></div> </td>
	        <td><div align="left"><input id="passid" name="passid" type="text" value="<%=passportid%>" readonly/></div></td>
			</tr>
		<%	
			}%>
		
		<tr>
		<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
		<td><div  align="left">   
       <a href="#" name="warcom" onClick="showwarcom('div17');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div17" style="display:none"> 

	<table border="0" width="100%">
	<tr>
		<td align="center"><div align="left"><font size="2" >Father Name</font></div> </td>
        <td><div align="left"><input id="driverfather" name="driverfather" type="text" value="<%=father %>" /></div></td>
		</tr>
	       <tr>
		<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=DOB1%>" readonly/>
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
						<option value="<%=Transporter %>"><%=Transporter %></option>
							
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
       <a href="#" name="warcom" onClick="showwarcom('div18');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div18" style="display:none"> 

	<table border="0" width="100%">
	        <tr>
		<td align="center"><div  align="left"><font size="2" >No </font></div></td>
        <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=LicenseNo%>" /> </div> </td>
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
		<a href="#" name="warcom" onClick="showwarcom('div19');"><font size="2" >Details</font></a></div>
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
       <a href="#" name="warcom" onClick="showwarcom('div20');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div20" style="display:none"> 
        <table border="0" width="100%">
        <%
       // System.out.println("dgdsxbdxfh"+driverid);
        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'order by Sr desc limit 1";
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
		       <a href="#" name="warcom" onClick="showwarcom('div21');"><font size="2" >Details</font></a></div>
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
				       <a href="#" name="warcom" onClick="showwarcom('div21');"><font size="2" >Details</font></a></div>
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
							<a href="#" name="warcom" onClick="showwarcom('div22');"><font size="2" >Details</font></a></div>
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
							<a href="#" name="warcom" onClick="showwarcom('div23');"><font size="2" >Details</font></a></div>
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
           				  <a href="#" name="warcom" onClick="showwarcom(div24);"><font size="2" >Details</font></a></div>
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
         <a href="#" name="warcom" onClick="showwarcom('div25');"><font size="2" >Details</font></a></div>
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
		<a href="#" name="warcom" onClick="showwarcom(div26);"><font size="2" >Details</font></a></div>
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
		 <a href="#" name="warcom" onClick="showwarcom('div27');"><font size="2" >Details</font></a></div>
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
						<a href="#" name="warcom" onClick="showwarcom('div28');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div28" style="display:none"> 
						<table border="0" width="100%">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value=""  readonly/>
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
	 					<option value=""></option>
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
		   %>
		    					<tr>
      					 <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
        				 <td> <div  align="left">
						 <a href="#" name="warcom" onClick="showwarcom('div29');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div29" style="display:none"> 
						<table border="0" width="100%">             
      				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
      					    <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value=""  readonly/>
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
         				 <td><div  align="left"></div> <input id="Module4" name="Module4" type="text" value="" readonly/> </td></tr>
          <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
          <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="" readonly/></div>  </td>
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
		   if(Module5.equals("-")||Module5.equals("NULL"))
       	{
       		%>
      					<tr>
     					 <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
       				 <td> <div  align="left">
						<a href="#" name="warcom" onClick="showwarcom('div82');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div82" style="display:none"> 
						<table border="0" width="100%">             
     				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
     					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value=""  readonly/>
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
	 					<option value=""></option>
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
       	}
		   else
		   {
		   %>
		    					<tr>
     					 <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
       				 <td> <div  align="left">
						 <a href="#" name="warcom" onClick="showwarcom('div92');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div92" style="display:none"> 
						<table border="0" width="100%">             
     				    <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
     					    <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value=""  readonly/>
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
        				 <td><div  align="left"></div> <input id="Module5" name="Module5" type="text" value="" readonly/> </td></tr>
         <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
         <td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="" readonly/></div>  </td>
         </tr>
         <tr>
		  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
         <td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="" readonly/></div>  </td>
         </tr>
         <tr>
		  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
         <td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="" readonly/></div>  </td>
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
        }
        }else{
        %>
        <tr>
		       <td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
		       <td><div  align="left">   
		      <a href="#" name="warcom" onClick="showwarcom('div30');"><font size="2" >Details</font></a></div>
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
		<a href="#" name="warcom" onClick="showwarcom('div31');"><font size="2" >Details</font></a></div>
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
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>

</body>
</html>




