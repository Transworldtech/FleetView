
<!-- code to show driver details present for IRTE login -->
<!--Date-14/09/2010 by sujata -->

<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>

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

</script>

<body bgcolor="	#98AFC7">
	<%!
	Connection conn;
	Statement st,st1,st2,st3,st4;
	%>
<%

		String sql=null,sql1=null, driverid="",trans="",passportid="",DOB="",drivname="",Basic="",LicenseNo="",father="",Module1="",Module2="",Module3="",Module4="",Module5="";
		driverid=request.getParameter("driverid");
		//out.println(driverid);
		father=request.getParameter("father");
		DOB=request.getParameter("DOB");
		LicenseNo=request.getParameter("LicenseNo");
		drivname=request.getParameter("drivname");
		passportid=request.getParameter("passportid");
		trans=request.getParameter("transporter");
		String insert=request.getParameter("insert");
		try{
					Class.forName(MM_dbConn_DRIVER);
					conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
					st=conn.createStatement();
					st1=conn.createStatement();
					st2=conn.createStatement();
					st3=conn.createStatement();
					st4=conn.createStatement();
					/**code to display drivers details fron t_drivertraining***/			
					
					//System.out.println("fatherName from trining info==>"+fatherName);
%>
		<form name="trininginfo1"  method="post" action="updatetrininginfo2.jsp?driverid=<%=driverid%>&father=<%=father%>&DOB=<%=DOB%>&LicenseNo=<%=LicenseNo%>&drivname=<%=drivname%>&passportid=<%=passportid %>&transporter=<%=trans%>" onSubmit="" >
			<table border="0" align="center"  width="600px" width="100%"> 
			<tr>
				<td align="left"><font color="black" size="3"><b><input type="submit" name="Submit1" value="Edit" class="formElement" /></b></font></td>
				<td><font color="brown" size="3">Driver Training Details</font></td>
			</tr>
<%
			if(insert!=null && insert.equals("true"))
			{
%>
			<tr>
			<td><font color="brown" size="3">Data Successfully.......</font></td>
			</tr>
<%
			}
			String msg = (String)request.getParameter("msg");
			if(msg==null)
			{
			}	
			else
			{ 
%>
				<table border="0" width="100%">
			                <%
			     if(msg.equalsIgnoreCase("F"))
			     {
	%>
			       <tr><td align="center"> <font color="maroon"> Passport Id already exists. </font></td></tr>
			       <tr><td align="center"> <font color="maroon"> Data not saved. </font> </td></tr>
	<% 
			     }
			     else
			     { 
	%>
			       <tr><td align="center"> <font color="maroon"> Successfully Saved</font></td></tr>
	<%
			     }
	 %>
			     </table>
<%	        }               
		%>
		
					</table></form>
					<% 
					
					String sql111="select * from t_drivers where DriverID= '"+passportid+"' and GPNAME='Castrol'";
				//	out.println(sql111);
					ResultSet rst11=st4.executeQuery(sql111);
					if(rst11.next())
					{	
					
					sql="select * from t_drivertraining where Dcode = '"+passportid+"'";
				//	out.println(sql);
				ResultSet rst=st.executeQuery(sql);
					if(rst.next())
					{
						//out.println("in t_drivertraining");
		%>

		<form action="updatetrininginfo1.jsp" style="overflow:scroll" > 
		
		<div class="ScrollTable" style="height: 530px;">
		   
		<table border="1" width="100%" align="center"   >
		<tr><td>
		<table class="stats">
		
		<!--
		<div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('../print_driverdetails.jsp?driverid=< %=driverid%>');" title="Print driver details"><img src="../images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="../excel_driverdetails.jsp?driverid=< %=driverid%>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
		</div>
		 -->
		
		
		<tr><td>
		 <table border="2" width="100%" align="center" class="stats">
		     
		     
		        <tr>
				<td align="left" width="30%">
				<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
				<div align="left" ><font size="2" >Driver Name  </font></div></td>
		        <td width="80%"><div align="left">
				<input id="drivername" name="drivername" type="text" value="<%= rst.getString("DriverName") %>" readonly/></div>
				</td>
				</tr>
				
				<tr>
				<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
				<td> <div  align="left">
		       <a href="#" onClick="showwarcom('div1');"><font size="2" >Details</font></a>	</div>
		       <div id="div1" style="display:none"> 
		
			<table border="0" width="100%">
			<tr>
				<td align="center" size="20%"><div align="left"><font size="2" >Father Name</font></div> </td>
		        <td size="80%"><div align="left" ><input id="driverfather" name="driverfather" type="text" value="<%= rst.getString("DriverFatherName") %>"readonly /></div></td>
				</tr>
			       <tr>
				<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
		        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=rst.getString("DOB")%>" readonly/>
				<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
		  		
				</div></td>
				</tr>
				<tr>
		        <td><div align="left"><font size="2">Education</font></div></td>
		        <td><div  align="left"> <input id="Education" name="Education" type="text" value="<%= rst.getString("Education") %>" readonly/> </div> </td>
		       	</tr>
		       	
			</table>
				</div>
				</td>
				
		        </tr>               
		        <tr>
					<td align="center" width="30%"><div align="left"><font size="2" >Transporter </font></div></td>
					<td><div  align="left"><input id="transporter" name="transporter" type="text" value="<%= rst.getString("Transporter") %>" readonly/></div></td>
		        </tr> 
		        
		        <tr>
			        <td><div align="left"><font size="2">vendor</font></div></td>
			        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="<%= rst.getString("vendor") %>"readonly/> </div> </td>
		       	</tr>
			
		        <tr>
		        <td width="30%"><div align="left"><font size="2">LicenseDetails</font></div></td>
		        <td><div  align="left">
		        		<a href="#" onClick="showwarcom('div2');"><font size="2" >Details</font></a></div>
						<div id="div2" style="display:none"> 
		
						<table border="0" width="100%">
				        	<tr>
								<td align="center"><div  align="left"><font size="2" >No </font></div></td>
			       			    <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=rst.getString("licenceno") %>" readonly/> </div> </td>
							</tr>
							
							<tr>
								<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
								<td><div  align="left"><input type="text" id="licnExpiryDate" name="licnExpiryDate"  value="<%=rst.getString("ExpiryDate")%>"  readonly/></div></td>
			        		</tr>
				
							<tr>
			       				<td><div align="left"><font size="2">Type</font></div></td>
			      				<td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value="<%= rst.getString("LicenseType") %>"readonly /> </div> </td>
			       			</tr> 
			       			
			       			<tr>
								<td align="center"><div align="left"><font size="2" >Place of issue </font> </div>  </td>
			        			<td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="<%= rst.getString("LicensePlace") %>" readonly/>  </div></td>
			        		</tr>
					   </table>
					</div>
				</td>
		        </tr>
		        
		       	 
				<tr>
				<td align="center" width="30%"><div align="left"><font size="2" >MedicalExam </font></div> </td>
				<td><div  align="left"><a href="#" onClick="showwarcom('div3');"><font size="2" >Details</font></a>
					</div>
						   <br> 
					<div id="div3" style="display:none"> 
					<table border="0" width="100%">
							<tr>
							<td align="center"><div align="left"><font size="2" >Exam </font></div> </td>
					        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="<%= rst.getString("MedicalExam") %>" readonly/></div>  </td>
							</tr>
							
							<tr>
							<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
					        <td><div  align="left"><input type="text" id="MedicalExamdate" name="MedicalExamdate"  value="<%=rst.getString("MedicalExamdate")%>"  readonly/></div></td>
							</tr>
							
							<tr>
								<td align="center"><div align="left"><font size="2" > ExpiryDate</font></div> </td>
					        	<td><div  align="left"><input type="text" id="MediclExpDate" name="MediclExpDate"  value="<%=rst.getString("ExpiryDate2")%>"  readonly/></div></td>
							</tr>
					</table>
					</div>
				</td>
				</tr>
		       
				<tr>
				       <td align="center" width="30%"><div align="left"><font size="2" >Training Details</font></div> </td>
				       <td><div  align="left">   
				       <a href="#" onClick="showwarcom('div4');"><font size="2" >Details</font></a></div>
						<br> 
						<div id="div4" style="display:none"> 
				        <table border="0" width="100%">
				        <%
				     //   System.out.println("From yraining details"+driverid);
				        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'";
				   //     System.out.println("sql---->"+sql5);
				        ResultSet rst5=st1.executeQuery(sql5);
				     
				        if(rst5.next())
				        {  Basic=rst5.getString("Basic");
				        Module1=rst5.getString("Module1");
				        Module2=rst5.getString("Module2");
				        Module3=rst5.getString("Module3");
				        Module4=rst5.getString("Module4");
				        Module5=rst5.getString("Module5");
				        if(Basic.equals("-")||Basic.equals("NULL"))
				        {
				        	 out.print("<center> <table border='1' width='50%'><tr> <th> Details does not exist. </th> </tr>");
				        }else{
				        	%>
				        		<tr>
				            	<td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
				           		 <td><div  align="left">   
				           		 <a href="#" name="warcom" onClick="showwarcom('div5');"><font size="2" >Details</font></a></div>
				     		<br> 
				     		<div id="div5" style="display:none"> 
				
				     	<table border="0" width="100%">
				     	<tr>
				     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				               <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=rst.getString("basicdate")%>"  readonly/>
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
				               if(Module1.equals("-")||Module1.equals("NULL"))
				               {
				               	
				               }
				        	else
				        	{
				        	%>
				        	<tr>
				            <td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
				            <td><div  align="left">
				     		<a href="#" name="warcom" onClick="showwarcom('div6');"><font size="2" >Details</font></a></div>
				     <br> 
				     <div id="div6" style="display:none"> 
				
				     	<table border="0" width="100%">
				     		<tr>
				     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				               <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=rst.getString("Module1date")%>"  readonly/>
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
				        if(Module2.equals("-")||Module2.equals("NULL"))
				        {
				        	
				        }
				        else
				        {
				        	%>
				        	<tr>
				       <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
				       <td> <div  align="left">
				         <a href="#" onClick="showwarcom('div7');"><font size="2" >Details</font></a></div>
				<br> 
				<div id="div7" style="display:none"> 
				
					<table border="0" width="100%">
					 <tr>
						  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=rst.getString("Module2date")%>" readonly />
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
						
				        	<%
				        	if(Module3.equals("-")||Module3.equals("NULL"))
				        	{
				        		
				        	}else
				        	{
				        		 %><tr>
				        	        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
				        	        <td> <div  align="left">
				        			<a href="#" name="warcom" onClick="showwarcom('div8');"><font size="2" >Details</font></a></div>
				        			<br> 
				        			<div id="div8" style="display:none"> 
				
				        			<table border="0" width="100%">
				        			 <tr>
				        			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				        	          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=rst.getString("Module3date")%>" readonly />
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
				        	       <%  
				        	       if(Module4.equals("-")||Module4.equals("NULL"))
				        	       {
				        	    	   
				        	       }else
				        	       {
				        	          %>   <tr>
				        	             <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
				        	               <td> <div  align="left">
				        	      		<a href="#" name="warcom" onClick="showwarcom('div9');"><font size="2" >Details</font></a></div>
				        	      		<br> 
				        	      		<div id="div9" style="display:none"> 
				        	      		<table border="0" width="100%">             
				        	                <tr>
				        	      		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
				        	                <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=rst.getString("Module4date")%>" readonly />
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
				        	      		<%if(Module5.equals("-")||Module5.equals("NULL"))
						        	       {
						        	    	   
						        	       }else
						        	       {
						        	          %>   <tr>
						        	             <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
						        	               <td> <div  align="left">
						        	      		<a href="#" name="warcom" onClick="showwarcom('div89');"><font size="2" >Details</font></a></div>
						        	      		<br> 
						        	      		<div id="div89" style="display:none"> 
						        	      		<table border="0" width="100%">             
						        	                <tr>
						        	      		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
						        	                <td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=rst.getString("Module5date")%>" readonly />
						        	      			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
						        	        		 
						        	      		  </div></td>
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
		          		<td> <div  align="left"><input id="remark" name="remark" type="text" value="<%= rst.getString("remark") %>" readonly/></div>  </td>
		          </tr> 
		          
		          <tr>
		          <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
				  <td><div  align="left"><a href="#" name="warcom" onClick="showwarcom('div10');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div10" style="display:none"> 
		
			<table border="0" width="100%">
			 
				<tr>
				  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
		          <td><div  align="left"> <input id="FTTraining" name="FTTraining" type="text" value="<%= rst.getString("FTTraining") %>" readonly/> </div> </td>
		          </tr> 
		          <tr>
				<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
		        <td> <div  align="left">
				<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value="<%=rst.getString("FTTrainingdate")%>"  readonly/>
				<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
		  		
				</div></td>
				</tr>
				
			</table>
				</div>
				</td>
			</tr>
		          
		          <tr><td align="center"><div align="left"><font size="2" >Last Training </font></div> </td>
			<td><div  align="left">
				<a href="#" name="warcom" onClick="showwarcom('div11');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div11" style="display:none"> 
		
			<table border="0" width="100%">
			 
				<tr>
				  <td align="center"><div align="left"><font size="2" >LastTraining</font> </div> </td>
		          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="<%= rst.getString("LastTraining") %>" readonly/></div>  </td>
		          </tr> 
		                        
		          <tr>
				  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
		          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="<%=rst.getString("LastTrainingDate")%>" readonly />
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
		        
		
		</td></tr>
		
		</table>
		</td>
		</tr>
		</table>
		</div>
		</form>
		<%
		}}//end of if(rs.next())
		else
		{
		//out.println("DriverID--->"+driverid);
			String	sql11="select * from t_drivertraining where Dcode = '"+driverid+"' order by Sr desc limit 1";
		ResultSet rst12=st.executeQuery(sql11);
		//out.println(sql11);
		if(rst12.next())
		{// out.println("details are present in t_drivertraining using refence driverid");
		//	out.println("in t_drivertraining");
%>

<form action="updatetrininginfo1.jsp" style="overflow:scroll" > 

<div class="ScrollTable" style="height: 530px;">

<table border="1" width="100%" align="center"   >
<tr><td>
<table class="stats">

<!--
<div class="bodyText" align="right">
<a href="#" onclick="javascript:window.open('../print_driverdetails.jsp?driverid=<%=driverid%>');" title="Print driver details"><img src="../images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
<a href="../excel_driverdetails.jsp?driverid=<%=driverid%>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
</div>
-->


<tr><td>
<table border="2" width="100%" align="center" class="stats">
 
 
    <tr>
	<td align="left" width="30%">
	<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
	<div align="left" ><font size="2" >Driver Name  </font></div></td>
    <td width="80%"><div align="left">
	<input id="drivername" name="drivername" type="text" value="<%= rst12.getString("DriverName") %>" readonly/></div>
	</td>
	</tr>
	<tr>
				<td align="center"><div align="left"><font size="2" >Passport ID</font></div> </td>
		        <td><div align="left"><input id="passid" name="passid" type="text" value="" readonly/></div></td>
				</tr>
				
	<tr>
	<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
	<td> <div  align="left">
   <a href="#" onClick="showwarcom('div1');"><font size="2" >Details</font></a>	</div>
   <div id="div1" style="display:none"> 

<table border="0" width="100%">
<tr>
	<td align="center" size="20%"><div align="left"><font size="2" >Father Name</font></div> </td>
    <td size="80%"><div align="left" ><input id="driverfather" name="driverfather" type="text" value="<%= rst12.getString("DriverFatherName") %>"readonly /></div></td>
	</tr>
       <tr>
	<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
    <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=rst12.getString("DOB")%>" readonly/>
	<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
		
	</div></td>
	</tr>
	<tr>
    <td><div align="left"><font size="2">Education</font></div></td>
    <td><div  align="left"> <input id="Education" name="Education" type="text" value="<%= rst12.getString("Education") %>" readonly/> </div> </td>
   	</tr>
   	
</table>
	</div>
	</td>
	
    </tr>               
    <tr>
		<td align="center" width="30%"><div align="left"><font size="2" >Transporter </font></div></td>
		<td><div  align="left"><input id="transporter" name="transporter" type="text" value="<%= rst12.getString("Transporter") %>" readonly/></div></td>
    </tr> 
    
    <tr>
        <td><div align="left"><font size="2">vendor</font></div></td>
        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value="<%= rst12.getString("vendor") %>"readonly/> </div> </td>
   	</tr>

    <tr>
    <td width="30%"><div align="left"><font size="2">LicenseDetails</font></div></td>
    <td><div  align="left">
    		<a href="#" onClick="showwarcom('div2');"><font size="2" >Details</font></a></div>
			<div id="div2" style="display:none"> 

			<table border="0" width="100%">
	        	<tr>
					<td align="center"><div  align="left"><font size="2" >No </font></div></td>
       			    <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=rst12.getString("licenceno") %>" readonly/> </div> </td>
				</tr>
				
				<tr>
					<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
					<td><div  align="left"><input type="text" id="licnExpiryDate" name="licnExpiryDate"  value="<%=rst12.getString("ExpiryDate")%>"  readonly/></div></td>
        		</tr>
	
				<tr>
       				<td><div align="left"><font size="2">Type</font></div></td>
      				<td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value="<%= rst12.getString("LicenseType") %>"readonly /> </div> </td>
       			</tr> 
       			
       			<tr>
					<td align="center"><div align="left"><font size="2" >Place of issue </font> </div>  </td>
        			<td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="<%= rst12.getString("LicensePlace") %>" readonly/>  </div></td>
        		</tr>
		   </table>
		</div>
	</td>
    </tr>
    
   	 
	<tr>
	<td align="center" width="30%"><div align="left"><font size="2" >MedicalExam </font></div> </td>
	<td><div  align="left"><a href="#" onClick="showwarcom('div3');"><font size="2" >Details</font></a>
		</div>
			   <br> 
		<div id="div3" style="display:none"> 
		<table border="0" width="100%">
				<tr>
				<td align="center"><div align="left"><font size="2" >Exam </font></div> </td>
		        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="<%= rst12.getString("MedicalExam") %>" readonly/></div>  </td>
				</tr>
				
				<tr>
				<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
		        <td><div  align="left"><input type="text" id="MedicalExamdate" name="MedicalExamdate"  value="<%=rst12.getString("MedicalExamdate")%>"  readonly/></div></td>
				</tr>
				
				<tr>
					<td align="center"><div align="left"><font size="2" > ExpiryDate</font></div> </td>
		        	<td><div  align="left"><input type="text" id="MediclExpDate" name="MediclExpDate"  value="<%=rst12.getString("ExpiryDate2")%>"  readonly/></div></td>
				</tr>
		</table>
		</div>
	</td>
	</tr>
   
	<tr>
	       <td align="center" width="30%"><div align="left"><font size="2" >Training Details</font></div> </td>
	       <td><div  align="left">   
	       <a href="#" onClick="showwarcom('div4');"><font size="2" >Details</font></a></div>
			<br> 
			<div id="div4" style="display:none"> 
	        <table border="0" width="100%">
	        <%
	      //  System.out.println("From yraining details"+driverid);
	        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"'";
	      //  System.out.println("sql---->"+sql5);
	        ResultSet rst5=st1.executeQuery(sql5);
	     
	        if(rst5.next())
	        {  Basic=rst5.getString("Basic");
	        Module1=rst5.getString("Module1");
	        Module2=rst5.getString("Module2");
	        Module3=rst5.getString("Module3");
	        Module4=rst5.getString("Module4");
	        Module5=rst5.getString("Module5");
	        if(Basic.equals("-")||Basic.equals("NULL"))
	        {
	        	 out.print("<center> <table border='1' width='50%'><tr> <th> Details does not exist. </th> </tr>");
	        }else{
	        	%>
	        		<tr>
	            	<td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
	           		 <td><div  align="left">   
	           		 <a href="#" name="warcom" onClick="showwarcom('div5');"><font size="2" >Details</font></a></div>
	     		<br> 
	     		<div id="div5" style="display:none"> 
	
	     	<table border="0" width="100%">
	     	<tr>
	     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
	               <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value="<%=rst12.getString("basicdate")%>"  readonly/>
	     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
	       		 
	     		  </div></td>
	               </tr> 
	               <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	          <td><div  align="left"><input id="Basic" name="Basic" type="text" value="<%=rst12.getString("Basic")%>"readonly /></div>  </td>
	          
	           </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
	          <td> <div  align="left"><input id="BasicTrainerName" name="BasicTrainerName" type="text" value="<%=rst12.getString("BasicTrainerName")%>" readonly/></div>  </td>
	          </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
	          <td> <div  align="left"><input id="BasicTrainingCompany" name="BasicTrainingCompany" type="text" value="<%=rst12.getString("BasicTrainingCompany")%>"readonly /></div>  </td>
	          </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
	          <td> <div  align="left"><input id="BasicComments" name="BasicComments" type="text" value="<%=rst12.getString("BasicComments")%>" readonly/></div>  </td>
	          </tr>
	          </table>
			</div>
			</td>
			</tr>
	               <%
	               if(Module1.equals("-")||Module1.equals("NULL"))
	               {
	               	
	               }
	        	else
	        	{
	        	%>
	        	<tr>
	            <td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
	            <td><div  align="left">
	     		<a href="#" name="warcom" onClick="showwarcom('div6');"><font size="2" >Details</font></a></div>
	     <br> 
	     <div id="div6" style="display:none"> 
	
	     	<table border="0" width="100%">
	     		<tr>
	     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
	               <td> <div  align="left"><input type="text" id="Module1date" name="Module1date"  value="<%=rst12.getString("Module1date")%>"  readonly/>
	     			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
	       		 
	     		  </div></td>
	               </tr> 
	               
	        
			
	 		  
			
			       
	          
	         <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	          <td><div  align="left"><input id="Module1TrainingLocation" name="Module1TrainingLocation" type="text" value="<%=rst12.getString("Module1")%>"readonly /></div>  </td>
	       
	          </tr>
	          
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
	          <td> <div  align="left"><input id="Module1TrainerName" name="Module1TrainerName" type="text" value="<%=rst12.getString("Module1TrainerName")%>" readonly/></div>  </td>
	          </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
	          <td> <div  align="left"><input id="Module1TrainingCompany" name="Module1TrainingCompany" type="text" value="<%=rst12.getString("Module1TrainingCompany")%>" readonly/></div>  </td>
	          </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
	          <td> <div  align="left"><input id="Module1Comments" name="Module1Comments" type="text" value="<%=rst12.getString("Module1Comments")%>" readonly/></div>  </td>
	          </tr>
	          </table>
			</div>
			</td>
			</tr>
	        <%	
	        if(Module2.equals("-")||Module2.equals("NULL"))
	        {
	        	
	        }
	        else
	        {
	        	%>
	        	<tr>
	       <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
	       <td> <div  align="left">
	         <a href="#" onClick="showwarcom('div7');"><font size="2" >Details</font></a></div>
	<br> 
	<div id="div7" style="display:none"> 
	
		<table border="0" width="100%">
		 <tr>
			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
	          <td> <div  align="left"><input type="text" id="Module2date" name="Module2date"  value="<%=rst12.getString("Module2date")%>" readonly />
				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
	  		  
			  </div></td>
	          </tr> 
			
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	          <td><div  align="left"><input id="Module2TrainingLocation" name="Module2TrainingLocation" type="text" value="<%=rst12.getString("Module2")%>"readonly /></div>  </td>
	         
	          </tr>
	          
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
	          <td> <div  align="left"><input id="Module2TrainerName" name="Module2TrainerName" type="text" value="<%=rst12.getString("Module2TrainerName")%>" readonly/></div>  </td>
	          </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
	          <td> <div  align="left"><input id="Module2TrainingCompany" name="Module2TrainingCompany" type="text" value="<%=rst12.getString("Module2TrainingCompany")%>" readonly/></div>  </td>
	          </tr>
	          <tr>
			  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
	          <td> <div  align="left"><input id="Module2Comments" name="Module2Comments" type="text" value="<%=rst12.getString("Module2Comments")%>" readonly/></div>  </td>
	          </tr>
	          </table>
			</div>
			</td>
			</tr>        
			
	        	<%
	        	if(Module3.equals("-")||Module3.equals("NULL"))
	        	{
	        		
	        	}else
	        	{
	        		 %><tr>
	        	        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
	        	        <td> <div  align="left">
	        			<a href="#" name="warcom" onClick="showwarcom('div8');"><font size="2" >Details</font></a></div>
	        			<br> 
	        			<div id="div8" style="display:none"> 
	
	        			<table border="0" width="100%">
	        			 <tr>
	        			  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
	        	          <td> <div  align="left"><input type="text" id="Module3date" name="Module3date"  value="<%=rst12.getString("Module3date")%>" readonly />
	        				<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
	        	  		 
	        			  </div></td>
	        	          </tr> 
	        			
	        	         <tr>
	        			  <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	          <td><div  align="left"><input id="Module3TrainingLocation" name="Module3TrainingLocation" type="text" value="<%=rst12.getString("Module3")%>"readonly /></div> 
	        	            </td></tr>
	        	          <tr>
	        			  <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
	        	          <td> <div  align="left"><input id="Module3TrainerName" name="Module3TrainerName" type="text" value="<%=rst12.getString("Module3TrainerName")%>" readonly/></div>  </td>
	        	          </tr>
	        	          <tr>
	        			  <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
	        	          <td> <div  align="left"><input id="Module3TrainingCompany" name="Module3TrainingCompany" type="text" value="<%=rst12.getString("Module3TrainingCompany")%>" readonly/></div>  </td>
	        	          </tr>
	        	          <tr>
	        			  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
	        	          <td> <div  align="left"><input id="Module3Comments" name="Module3Comments" type="text" value="<%=rst12.getString("Module3Comments")%>"readonly /></div>  </td>
	        	          </tr>
	        	          </table>
	        			</div>
	        			</td>
	        			</tr>
	        	       <%  
	        	       if(Module4.equals("-")||Module4.equals("NULL"))
	        	       {
	        	    	   
	        	       }else
	        	       {
	        	          %>   <tr>
	        	             <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
	        	               <td> <div  align="left">
	        	      		<a href="#" name="warcom" onClick="showwarcom('div9');"><font size="2" >Details</font></a></div>
	        	      		<br> 
	        	      		<div id="div9" style="display:none"> 
	        	      		<table border="0" width="100%">             
	        	                <tr>
	        	      		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
	        	                <td> <div  align="left"><input type="text" id="Module4date" name="Module4date"  value="<%=rst12.getString("Module4date")%>" readonly />
	        	      			<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
	        	        		 
	        	      		  </div></td>
	        	                </tr> 
	        	                
	        	              	  <tr>
	        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
	        	              			  <td><div  align="left"><input id="Module4TrainingLocation" name="Module4TrainingLocation" type="text" value="<%=rst12.getString("Module4")%>"readonly /></div>  </td>
	        	                	 </tr>
	        	               	 <tr>
	        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
	        	               			 <td> <div  align="left"><input id="Module4TrainerName" name="Module4TrainerName" type="text" value="<%=rst12.getString("Module4TrainerName")%>"readonly /></div>  </td>
	        	              	  </tr>
	        	               	 <tr>
	        	      		 			 <td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
	        	               			 <td> <div  align="left"><input id="Module4TrainingCompany" name="Module4TrainingCompany" type="text" value="<%=rst12.getString("Module4TrainingCompany")%>"readonly /></div>  </td>
	        	              	  </tr>
	        	              	  <tr>
	        	      					  <td align="center"><div  align="left"><font size="2" >comments</font></div></td>
	        	               			 <td> <div  align="left"><input id="Module4Comments" name="Module4Comments" type="text" value="<%=rst12.getString("Module4Comments")%>"readonly /></div>  </td>
	        	             		   </tr>
	        	      		</table>
	        	      		</div>
	        	      		</td>
	        	      		</tr>
	        	      		<%
	        	      		if(Module5.equals("-")||Module5.equals("NULL")){
	        	      			
	        	      		}else{
	        	      		  %>   
	        	      		  <tr>
		        	             <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
		        	             <td> <div  align="left">
		        	      				<a href="#" name="warcom" onClick="showwarcom('div90');"><font size="2" >Details</font></a></div>
		        	      				<br> 
		        	      				<div id="div90" style="display:none"> 
		        	      					<table border="0" width="100%">             
		        	                			<tr>
		        	      		  					<td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		        	                				<td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="<%=rst12.getString("Module5date")%>" readonly />
		        	      								<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
								        	      		  </div>
								        	      	</td>
		        	                			</tr> 
	  			        	              	    <tr>
		        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingLocation</font></div></td>
		        	              			  		<td><div  align="left"><input id="Module5TrainingLocation" name="Module5TrainingLocation" type="text" value="<%=rst12.getString("Module5")%>"readonly /></div>  </td>
		        	                	 		</tr>
		        	               	 			<tr>
		        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainerName</font></div></td>
		        	               			 		<td> <div  align="left"><input id="Module5TrainerName" name="Module5TrainerName" type="text" value="<%=rst12.getString("Module5TrainerName")%>"readonly /></div>  </td>
		        	              	  			</tr>
		        	               	 			<tr>
		        	      		 			 		<td align="center"><div  align="left"><font size="2" >TrainingCompany</font></div></td>
		        	               			 		<td> <div  align="left"><input id="Module5TrainingCompany" name="Module5TrainingCompany" type="text" value="<%=rst12.getString("Module5TrainingCompany")%>"readonly /></div>  </td>
		        	              	  			</tr>
		        	              	  			<tr>
		        	      					  		<td align="center"><div  align="left"><font size="2" >comments</font></div></td>
		        	               			 		<td> <div  align="left"><input id="Module5Comments" name="Module5Comments" type="text" value="<%=rst12.getString("Module5Comments")%>"readonly /></div>  </td>
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
      		<td> <div  align="left"><input id="remark" name="remark" type="text" value="<%= rst12.getString("remark") %>" readonly/></div>  </td>
      </tr> 
      
      <tr>
      <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
	  <td><div  align="left"><a href="#" name="warcom" onClick="showwarcom('div10');"><font size="2" >Details</font></a></div>
<br> 
<div id="div10" style="display:none"> 

<table border="0" width="100%">
 
	<tr>
	  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
      <td><div  align="left"> <input id="FTTraining" name="FTTraining" type="text" value="<%= rst12.getString("FTTraining") %>" readonly/> </div> </td>
      </tr> 
      <tr>
	<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
    <td> <div  align="left">
	<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value="<%=rst12.getString("FTTrainingdate")%>"  readonly/>
	<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
		
	</div></td>
	</tr>
	
</table>
	</div>
	</td>
</tr>
      
      <tr><td align="center"><div align="left"><font size="2" >Last Training </font></div> </td>
<td><div  align="left">
	<a href="#" name="warcom" onClick="showwarcom('div11');"><font size="2" >Details</font></a></div>
<br> 
<div id="div11" style="display:none"> 

<table border="0" width="100%">
 
	<tr>
	  <td align="center"><div align="left"><font size="2" >LastTraining</font> </div> </td>
      <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="<%= rst12.getString("LastTraining") %>" readonly/></div>  </td>
      </tr> 
                    
      <tr>
	  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
      <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value="<%= rst12.getString("LastTrainingDate")%>" readonly />
		<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
		 
	  </div></td>
      </tr> 
	
</table>
	</div>
	</td>
</tr>
        <tr>
    	<td><div align="left"><font size="2">PreTest 40 MM.</font></div></td>
        <td><div  align="left"> <input id="PreTest40MM" name="PreTest40MM" type="text" value="<%= rst12.getString("PreTest40MM") %>" readonly/> </div> </td>
   		</tr>
   		
   		<tr>
   		<td><div align="left"><font size="2">PreTest %</font></div></td>
   		<td><div  align="left"> <input id="PreTest%" name="PreTest%" type="text" value="<%= rst12.getString("PreTestper") %>" readonly/> </div> </td>
  		</tr>
    	<tr>
    	<td><div align="left"><font size="2">PostTest 40 MM.</font></div></td>
    	<td><div  align="left"> <input id="PostTest40MM" name="PostTest40MM" type="text" value="<%= rst12.getString("PostTest40MM") %>" readonly/> </div> </td>
    	</tr>
 	    <tr>
    	<td><div align="left"><font size="2">PostTest%.</font></div></td>
    	<td><div  align="left"> <input id="PostTest%" name="PostTest%" type="text" value="<%= rst12.getString("PostTestper") %>"readonly /> </div> </td>
   		</tr>
	    <tr>
    	<td><div align="left"><font size="2">Type of vehicle used for on road coaching and for assessment</font></div></td>
    	<td><div  align="left"> <input id="Typeofvehicle" name="Typeofvehicle" type="text" value="<%= rst12.getString("Typeofvehicle") %>" readonly/> </div> </td>
   		</tr>
 		<tr>
		<td><div align="left"><font size="2">EducationGrade</font></div></td>
		<td><div align="left"><input id="Drivingschooleducationgrade" name="Drivingschooleducationgrade" type="text" value="<%= rst12.getString("educationgrade") %>"readonly /> </div> </td>
		</tr>   
                      
                    
		</table>
    

</td></tr>

</table>
</td>
</tr>
</table>
</div>
</form>
<%
		}else////changes
		{
			%>
		<form action="updatetrininginfo2.jsp" style="overflow:scroll" > 
		<div class="ScrollTable" style="height: 500px;">
		<table border="1" width="100%" align="center"   >
		<tr><td>
		<table class="stats">
		
		<!-- <div class="bodyText" align="right">
		<a href="#" onclick="javascript:window.open('../print_driverdetails.jsp?driverid=< %=driverid %>');" title="Print driverdetails"><img src="../images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
		<a href="../excel_driverdetails.jsp?driverid=< %=driverid %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
		</div> -->
		<tr><td>
		 <table border="2" width="100%" align="center" class="stats">
		     
		     
		        <tr>
				<td align="left" width="30%">
				<input type="hidden" id="driverid" name="driverid"  value="<%=driverid%>"></input>
				<div align="left"><font size="2" >Driver Name  </font></div></td>
		        <td width="70%"><div align="left">
				<input id="drivername" name="drivername" type="text" value="<%=drivname %>" readonly/></div>
				</td>
				</tr>
				
				<tr>
				<td align="center"><div align="left"><font size="2" >Passport ID</font></div> </td>
		        <td><div align="left"><input id="passid" name="passid" type="text" value="<%=passportid%>" readonly/></div></td>
				</tr>
				
				<tr>
				<td align="center"><div align="left"><font size="2" >Personal Details</font></div> </td>
				<td><div  align="left">   
		      <a href="#" name="warcom" onClick="showwarcom('div12');"><font size="2" >Details</font></a></div>
				<br> 
				<div id="div12" style="display:none"> 
		
			<table border="0" width="100%">
			<tr>
				<td align="center"><div align="left"><font size="2" >Father Name</font></div> </td>
		        <td><div align="left"><input id="driverfather" name="driverfather" type="text" value="<%=father%>" readonly/></div></td>
				</tr>
			       <tr>
				<td align="center"><div  align="left"><font size="2">DOB </font></div> </td>
		        <td align="right"><div align="left"><input type="text" id="DOB" name="DOB"  value="<%=DOB%>" readonly/>
				<!--	<img src="../images/calendar.png" id="trigger1" border="0">-->
		  		
				</div></td>
				</tr>
				<tr>
		        <td><div align="left"><font size="2">Education</font></div></td>
		        <td><div  align="left"> <input id="Education" name="Education" type="text" value="" readonly/> </div> </td>
		       	</tr>
		       	
			</table>
				</div>
				</td>
				
		          </tr>               
		         <tr>
				<td align="center"><div align="left"><font size="2" >Transporter </font></div> </td>
				<td> <div  align="left">
							<input id="transporter" name="transporter" type="text" value="<%=trans%>" readonly/>		
						</div>
						</td>
		        </tr> 
			
		        <tr>
		        <td><div align="left"><font size="2">vendor</font></div></td>
		        <td><div  align="left"> <input id="vendor" name="vendor" type="text" value=""readonly /> </div> </td>
		       	</tr>
		       		             
				
				
			
		        <tr><td><div align="left"><font size="2">LicenseDetails</font></div></td>
		         <td><div  align="left">   
		       <a href="#" name="warcom" onClick="showwarcom('div13');"><font size="2" >Details</font></a></div>
				<br> 
				<div id="div13" style="display:none"> 
		
			<table border="0" width="100%">
			        <tr>
				<td align="center"><div  align="left"><font size="2" >No </font></div></td>
		        <td><div align="left"> <input id="licenceno" name="licenceno" type="text" value="<%=LicenseNo%>" readonly/> </div> </td>
				</tr>
					<tr>
				<td align="center"><div  align="left"><font size="2">ExpiryDate </font> </div></td>
				<td><div  align="left">
				    <input type="text" id="licnExpiryDate" name="licnExpiryDate"  value=""  readonly/>
		<!--			<img src="../images/calendar.png" id="trigger" border="0">-->
		  			
				</div></td>
		        </tr>
			<tr>
		        <td><div align="left"><font size="2">Type</font></div></td>
		        <td><div align="left"><input id="LicenseType" name="LicenseType" type="text" value="" readonly/> </div> </td>
		       	</tr> 
		       	 <tr>
				<td align="center"><div align="left"><font size="2" >Place of issue </font> </div>  </td>
		        <td><div  align="left"> <input id="LicensePlace" name="LicensePlace" type="text" value="" readonly/>  </div></td>
		        </tr>
		        
		
			</table>
				</div>
				</td>
		        </tr>
		        
		       	 
			<tr><td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
			<td><div  align="left">
		<a href="#" name="warcom" onClick="showwarcom('div14');"><font size="2" >Details</font></a></div>
		      
		<br> 
		<div id="div14" style="display:none"> 
		
			<table border="0" width="100%">
			 <tr>
				<td align="center"><div align="left"><font size="2" >MedicalExam </font></div> </td>
		        <td><div  align="left"> <input id="MedicalExam" name="MedicalExam" type="text" value="" readonly/></div>  </td>
				</tr>
				<tr>
				<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
		        <td> <div  align="left">
				<input type="text" id="MedicalExamdate" name="MedicalExamdate"  value=""  readonly/>
				<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
		  		
				</div></td>
				</tr>
				<tr>
				<td align="center"><div align="left"><font size="2" >ExpiryDate</font></div> </td>
		        <td> <div  align="left">
				<input type="text" id="MediclExpDate" name="MediclExpDate"  value=""  readonly/>
				<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
		  		
				</div></td>
				</tr>
			</table>
				</div>
				</td>
			</tr>
		       
				       
				<%//System.out.println("driverid"+driverid);
				%>
		        <tr><td align="center"><div align="left"><font size="2" >Training Details</font></div> </td>
			<td><div  align="left">
				<a href="#" name="warcom" onClick="showwarcom('div15');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div15" style="display:none"> 
		
			<table border="0" width="100%">
		        <%
		 //       System.out.println(driverid);
		        String sql5="Select * from t_drivertraining where dcode ='"+driverid+"' order by Sr desc limit 1";
		 //       System.out.println("sql--->"+sql5);
		        ResultSet rst32=st2.executeQuery(sql5);
		      //  System.out.println("Now i am in resultset----");
		        if(rst32.next())
		        { 
		       // System.out.println("Now i am in resultset");
		        Basic=rst32.getString("Basic");
		        Module1=rst32.getString("Module1");
		        Module2=rst32.getString("Module2");
		        Module3=rst32.getString("Module3");
		        Module4=rst32.getString("Module4");
		        Module5=rst32.getString("Module5");
		    //    System.out.println("Basic");
		        if(Basic.equals("-")||Basic.equals("NULL"))
		        {
		        	 out.print("<center> <table border='1' width='50%'><tr> <th> Details does not exist. </th> </tr>");
		        }else{
		        	%>
		        		<tr>
		            	<td align="center"><div align="left"><font size="2" >Basic</font></div> </td>
		           		 <td><div  align="left">   
		           		 <a href="#" name="warcom" onClick="showwarcom('div16');"><font size="2" >Details</font></a></div>
		     		<br> 
		     		<div id="div16" style="display:none"> 
		
		     	<table border="0" width="100%">
		     	<tr>
		     		  <td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
		               <td> <div  align="left"><input type="text" id="basicdate" name="basicdate"  value=""  />
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
		               	
		               }
		        	else
		        	{
		        	%>
		        	<tr>
		            <td align="center"><div align="left"><font size="2" >Module1</font></div> </td>
		            <td><div  align="left">
		     		<a href="#" name="warcom" onClick="showwarcom('div17');"><font size="2" >Details</font></a></div>
		     <br> 
		     <div id="div17" style="display:none"> 
		
		     	<table border="0" width="100%">
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
		        	
		        }
		        else
		        {
		        	%>
		        	<tr>
		       <td align="center"><div align="left"><font size="2" >Module2</font></div> </td>
		       <td> <div  align="left">
		         <a href="#" name="warcom" onClick="showwarcom2('div18');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div18" style="display:none"> 
		
			<table border="0" width="100%">
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
		        		
		        	}else
		        	{
		        		 %><tr>
		        	        <td align="center"><div align="left"><font size="2" >Module3</font></div> </td>
		        	        <td> <div  align="left">
		        			 <a href="#" name="warcom" onClick="showwarcom('div19');"><font size="2" >Details</font></a></div>
		        			<br> 
		        			<div id="div19" style="display:none"> 
		
		        			<table border="0" width="100%">
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
		        	    	   
		        	       }else
		        	       {
		        	          %>   <tr>
		        	             <td align="center"><div align="left"><font size="2" >Module4</font></div> </td>
		        	               <td> <div  align="left">
		        	      		 <a href="#" name="warcom" onClick="showwarcom('div20');"><font size="2" >Details</font></a></div>
		        	      		<br> 
		        	      		<div id="div20" style="display:none"> 
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
		        	      		if(Module5.equals("-")||Module5.equals("NULL")){
		        	      			
		        	      		}else{
		        	      		  %>   
		        	      		  <tr>
			        	             <td align="center"><div align="left"><font size="2" >Module5</font></div> </td>
			        	             <td> <div  align="left">
			        	      				<a href="#" name="warcom" onClick="showwarcom('div87');"><font size="2" >Details</font></a></div>
			        	      				<br> 
			        	      				<div id="div87" style="display:none"> 
			        	      					<table border="0" width="100%">             
			        	                			<tr>
			        	      		  					<td align="center"><div align="left"><font size="2" >TrainingDate </font></div> </td>
			        	                				<td> <div  align="left"><input type="text" id="Module5date" name="Module5date"  value="" readonly />
			        	      								<!--<img src="../images/calendar.png" id="trigger3" border="0">-->
									        	      		  </div>
									        	      	</td>
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
			        	      		}
		        	       
		        	}
		        }
		        }
		        }
		        }}
		        else
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
		          
		          <tr><td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
			<td><div  align="left">
				<a href="#" name="warcom" onClick="showwarcom('div21');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div21" style="display:none"> 
		
			<table border="0" width="100%">
			 
				<tr>
				  <td align="center"><div align="left"><font size="2" >FT Training </font></div> </td>
		          <td><div  align="left"> <input id="FTTraining" name="FTTraining" type="text" value="" readonly/> </div> </td>
		          </tr> 
		          <tr>
				<td align="center"><div align="left"><font size="2" >Date</font></div> </td>
		        <td> <div  align="left">
				<input type="text" id="FTTrainingdate" name="FTTrainingdate"  value=""  readonly/>
				<!--<img src="../images/calendar.png" id="trigger2" border="0">-->
		  		
				</div></td>
				</tr>
				
			</table>
				</div>
				</td>
			</tr>
		          
		          <tr><td align="center"><div align="left"><font size="2" >Last Training </font></div> </td>
			<td><div  align="left">
				<a href="#" name="warcom" onClick="showwarcom('div22');"><font size="2" >Details</font></a></div>
		<br> 
		<div id="div22" style="display:none"> 
		
			<table border="0" width="100%">
			 
				<tr>
				  <td align="center"><div align="left"><font size="2" >LastTraining</font> </div> </td>
		          <td><div  align="left"> <input id="LastTraining" name="LastTraining" type="text" value="" readonly/></div>  </td>
		          </tr> 
		                        
		          <tr>
				  <td align="center"><div align="left"><font size="2" >Date </font></div> </td>
		          <td> <div  align="left"><input type="text" id="LastTrainingDate" name="LastTrainingDate"  value=""  readonly/>
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
		        	<td><div  align="left"> <input id="PostTest%" name="PostTest%" type="text" value="" readonly/> </div> </td>
		       		</tr>
		    	    <tr>
		        	<td><div align="left"><font size="2">Type of vehicle used for on road coaching and for assessment</font></div></td>
		        	<td><div  align="left"> <input id="Typeofvehicle" name="Typeofvehicle" type="text" value="" readonly/> </div> </td>
		       		</tr>
		     		<tr>
						<td><div align="left"><font size="2">EducationGrade</font></div></td>
					<td><div align="left"><input id="Drivingschooleducationgrade" name="Drivingschooleducationgrade" type="text" value="" readonly/> </div> </td>
					</tr>   
		                          
		                        
		 		</table>
		        
		
		</td></tr>
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
<tr ><td bgcolor="#98AFC7" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
</table>
</body>
</html>