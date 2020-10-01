 <%@ include file="headernew.jsp" %>
  	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
  
 <jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
%>
<html>
	<head>
		<script LANGUAGE="JavaScript">
		
		// Nannette Thacker http://www.shiningstar.net
		
		
		
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

function datevalidate()
{


	
	var date1=document.getElementById("fueldate").value;
	//var date2=document.getElementById("current1").value;
	
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;



	
	dd11=date1.substring(0,2);
	//dd22=date2.substring(0,2);
	
	
	mm1=date1.substring(3,6);
	//mm2=date2.substring(3,6);
	
	
	mm11=dateformat(mm1);
	//mm22=dateformat(mm2);
	
	

	yy11=date1.substring(7,11);
	//yy22=date2.substring(7,11);
	
	
	
	var date=new Date();
	var month=date.getMonth()+1;
	//alert(month);
	var day=date.getDate();
	//alert(day);
	
	var year=date.getFullYear();
	//alert(year);

	
	if(yy11>year)
	{
		alert("Selected date should not be greater than todays date");
		
		return false;
	}
	else if(year==yy11)
	{
			if(mm11>month)
		{
			alert("Selected date should not be greater than todays date");
			
			return false;
		}
	}
	if(mm11==month)
	{
		if(dd11>day)
		{
			alert("Selected date should not be greater than todays date");
			
			return false;
		}
	}

	return confirmSubmit();	

}




		function confirmSubmit()
		{
			//var veh=document.fuelform.vehs.value;
		    var driv=document.fuelform.drivers.value;
		    var petpump=document.fuelform.petpump.value;
		    var varValue = document.fuelform.odometer.value;
		    var amount = document.fuelform.amount.value;
		    var lits=document.fuelform.lits.value;
		    var veh=document.fuelform.vehs.value;
		    
		    var split = veh.split(",");


		    
           

		    
			var agree=confirm("Vehicle: "+split[0]+"\nOdometer : "+varValue+"\nLiters: "+lits+"\n\nAre you sure you want to continue with these values?");
			if (agree)
				return true ;
			else
				return false ;
			
			}
		
		
	
		 function validate()
		 {
			 
		     var driv=document.fuelform.drivers.value;
		     //alert("DRIVER"+driv);
		     var petpump=document.fuelform.petpump.value;
		     var varValue = document.fuelform.odometer.value;
		     var amount=document.fuelform.amount.value;
		     var lits=document.fuelform.lits.value;
		     //alert("LITER"+lits);
			 var veh=document.fuelform.vehs.value;
			     
			 
			

		     if(veh=="Select")
			    {
			        alert("Please Select Vehicle No");
			        return false;
			    }
		     
		     
			 if(driv=="Select")
			    {
			        alert("Please Select Driver");
			        return false;
			    }
		    
		      if(lits==null || lits=="")
		    	  {
		    	  alert("Please Enter Litres");
			        return false;
		    	  }
		      var invalid = /^[0-9.]+$/;
			 if(!invalid.test(lits))
				 {
				 alert("Please Enter Numeric or Float Value For Litres");
			        return false;
				 }
			 
			
			 if(amount==null || amount=="")
	    	  {
	    	  alert("Please Enter Amount");
		        return false;
	    	  }
	      var invalid = /^[0-9.]+$/;
		 if(!invalid.test(amount))
			 {
			 alert("Please Enter Numeric or Float Value For Amount");
		        return false;
			 }
				
		     
		    
// 	     	if(isNaN(varValue))
// 	  	     {
// 	  		   alert("Odometer reading should be numeric");
// 	  		   return false;
// 	  	     }
		     
	        
// 	     if(isNaN(lits))
// 	     {
// 	         alert("Please enter valid amount of fuel filled");
// 	         return false;
// 	     }    
// 	     if (String(varValue).indexOf(".") >7) {
// 	    	 alert("Odometer reading should be 7 digit no.");
// 	         return false;
// 	 }
// 			if(varValue.length>7)
// 			{
// 				alert("Odometer reading should be 7 digit no.");
// 		          return false;
// 			}


// 			if (!(lits.match(/^\d+$|^\d+\.\d{2}$/ )) && lits.length!=0)
// 	    	 {
// 	    	 alert("Liters precision should not be greater than 0.2\n\nEg: 40.23");
// 	    	 document.fuelform.lits.value="";
// 	    	  return false;
// 	    	 }
		     //java.util.Date drivexpdate1 = new SimpleDateFormat("dd-MMM-yyyy").parse(PExp1);

		  //alert(flag);
		  //alert(flag1);
		  
		  
// 		     if(varValue=="")
// 		      {
// 		          alert("Please Enter Odometer Reading");
// 		          return false;
// 		      }
		  

		        
		        
		        
		    
		     
		     return datevalidate(); 

		     
		     
		     
		     
		     
		     
		     
		     
		     
		     
		  }    

		
		             

		   
		     
		     
		 
				 
	</script>
	</head>
<%!Connection con1;%>
<body>
<form name="fuelform" method="get" action="fuelentryinsrt.jsp" onSubmit="return validate();" >
<%
	try {
			Class.forName(MM_dbConn_DRIVER);
			con1 = fleetview.ReturnConnection();
			Statement stmt1 = con1.createStatement();
			ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
			String sql2 = "", sql3 = "", sql4 = "", sql5 = "";
			String user = session.getValue("usertypevalue").toString();
			String usertype = session.getValue("TypeofUser").toString();
			java.util.Date d = new java.util.Date();
			int hours = (d.getHours());
			int minutes = (d.getMinutes());
			String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new java.util.Date());
			DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");

			Calendar now123=Calendar.getInstance();
			
			String sysdate22 = dateFormat.format(now123.getTime());
			System.out.println(">>>>>>>>>>>>>>>n "+sysdate22);
			
			
			
			
			
			
%>
 <div style="text-align:center;">
    <table>
      
  




			<input type="hidden" name="transporter" id="transporter" value="<%=user %>"></input>
			<table border="3" style="width: 200px" class="sortable_entry" align="center" >
  		      <tr>
		         <td> <div align="center"> <font face="Arial" size="3"> <b> Fuel Information </b> </font>   </div> </td>
		         </tr>
		         <tr>
		         <td>(<font color="red"> *</font> indicates mandatory fields)</td></tr>
		     
<%
		     	String inserted = request.getParameter("inserted");
		     	String lastOdometerReading=request.getParameter("lastOdometerReading"); 
		     		if (!(inserted == null)) {
		     				
		     			if("yes".equalsIgnoreCase(inserted))
		     			{
%>
     		<tr>
     		<br></br>
   				<td colspan="2" align="center"> Successfully Inserted! Click <a href="currentposition.jsp">Here </a> to go to main page.</td>
     		</tr>			     		
<%
			     		}
		     			else if("no".equalsIgnoreCase(inserted))
		     		   {
		     				
%>
			<tr>
				<td colspan="2" align="center">Last Odometer Reading entered was <%=lastOdometerReading %><br>Please enter higher value than this.</br>  </td>
		    </tr>			     		
<%
		     				
		     			}
		     		}
		     			
%>
			<tr>
				<td colspan="">
				<br></br>
				<table border="0" style="width: 550px" align="center">
  	  			<tr>
	      			<td> 
	      	 			<div align="left"><font color="red">* </font><font face="Arial" size="2"><b> Vehicle No :</b></font> </td></div>
					<td> 
				        <select class="element select medium" name="vehs" style="width: 130px">
						<option value="Select">Select</option>
<%
		try {
			String sql= "select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber ";
			ResultSet rst = stmt1.executeQuery(sql);
			String regNo="",vehCode="";
			while (rst.next()) {
			regNo = rst.getString("VehicleRegNumber");
			vehCode=rst.getString("vehicleCode");
%>
						<option value="<%=regNo%>,<%=vehCode%>"><%=regNo%></option>
<%
			}
	} catch (Exception e) {
	System.out.print("Exception" + e);
	}
	%>
						
						</select>				
				
					</td>
	 			</tr>
	 			<tr>
	 			
	      			<td>
	      			<input type="hidden" id="current1" name="current1" value="<%=sysdate22 %>"></input>
	      	 			<div align="left"><font face="Arial" size="2"> <b>Date-Time :</b> </font></div>
	      	 		 </td>
	      	 		 
					<td> 
						<input type="text" id="fueldate" name="fueldate" size="13" class="element text medium" style="width: 125px; height: 16px;"  value="<%=nwfrmtdte%>" readonly  />
             			<script type="text/javascript">
				             Calendar.setup(
				             {
				                 inputField  : "fueldate",         // ID of the input field
				                 ifFormat    : "%d-%b-%Y",     // the date format
				                 button      : "fueldate"       // ID of the button
				             }
				                           );
             			</script> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             			<font >
	            			HH : </font> 
	            						<select  class="element select medium"  style="width: 50px" name="fueltime1" >
						                   <option value="Select">Select</option>
						                   <option value="00" <%if ("00".equals("hours")) {%> Selected <%}%> >00</option>
						                   <option value="01" <%if (01 == hours) {%> Selected <%}%>>01</option>
						                   <option value="02" <%if (02 == hours) {%> Selected <%}%>>02</option>
						                   <option value="03" <%if (03 == hours) {%> Selected <%}%>>03</option>
						                   <option value="04" <%if (04 == hours) {%> Selected <%}%>>04</option>
						                   <option value="05" <%if (05 == hours) {%> Selected <%}%>>05</option>
						                   <option value="06" <%if (06 == hours) {%> Selected <%}%>>06</option>
						                   <option value="07" <%if (07 == hours) {%> Selected <%}%>>07</option>
						                   <option value="08" <%if (8 == hours) {%> Selected <%}%>>08</option>
						                   <option value="09" <%if (9 == hours) {%> Selected <%}%>>09</option>
						                   <option value="10" <%if (10 == hours) {%> Selected <%}%>>10</option>
						                   <option value="11" <%if (11 == hours) {%> Selected <%}%> >11</option> 
						                   <option value="12" <%if (12 == hours) {%> Selected <%}%> >12</option>
						                   <option value="13" <%if (13 == hours) {%> Selected <%}%>>13</option>
						                   <option value="14" <%if (14 == hours) {%> Selected <%}%>>14</option>
						                   <option value="15" <%if (15 == hours) {%> Selected <%}%>>15</option>
						                   <option value="16" <%if (16 == hours) {%> Selected <%}%>>16</option>
						                   <option value="17" <%if (17 == hours) {%> Selected <%}%>>17</option>
						                   <option value="18" <%if (18 == hours) {%> Selected <%}%>>18</option>
						                   <option value="19" <%if (19 == hours) {%> Selected <%}%>>19</option>
						                   <option value="20" <%if (20 == hours) {%> Selected <%}%>>20</option>
						                   <option value="21" <%if (21 == hours) {%> Selected <%}%>>21</option> 
						                   <option value="22" <%if (22 == hours) {%> Selected <%}%>>22</option>
						                   <option value="23" <%if (23 == hours) {%> Selected <%}%>>23</option>
            	 						</select>  
            	 				<font>
        							MM :
        						</font> <select class="element select medium" style="width: 50px" name="fueltime2" >
						                  <option value="00" <%if (minutes > 00 & minutes < 05) {%> Selected <%}%>>00</option>
					        	          <option value="10" <%if (minutes > 05 & minutes < 15) {%> Selected <%}%>>10</option>
					        	          <option value="20" <%if (minutes > 15 & minutes < 25) {%> Selected <%}%>>20</option>
					        	          <option value="30" <%if (minutes > 25 & minutes < 35) {%> Selected <%}%>>30</option>
					        	          <option value="40" <%if (minutes > 35 & minutes < 45) {%> Selected <%}%>>40</option> 
					        	          <option value="50" <%if (minutes > 45) {%> Selected <%}%>>50</option>
					        	    </select>				
				
							</td>
						 </tr>
<%
	 	String sql7 = "select * from t_drivers where Owner='"+ user + "' order by DriverName asc";
		ResultSet rs7 = stmt1.executeQuery(sql7);
%>
						<tr>
							<td> &nbsp;&nbsp; <font color="red">* </font> <font face="Arial" size="2"><b> Driver :</b> </font></td>
							<td><select class="element select medium" name="drivers" id="drivers" style="width: 130px">
						<option value="Select">Select</option>
<%
		while (rs7.next()) {
			String drivers = rs7.getString("DriverName");
			System.out.println("drivers-->>"+drivers);
%>
									<option ><%=drivers%></option>
<%
							}
%>
								</select>
							<a href="AddNewDriver.jsp?transporter=<%=user%>"><font color="Blue" size="2">Click to Add New Driver</font></a></td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;
<%
						if (session.getAttribute("fuelformat").toString()
										.equalsIgnoreCase("Gal")) {
%> 
							<font face="Arial" size="2"><b> Gal : </b></font> 
<%
	 					} else {
%> 
 					<font color="red">* </font>	<font face="Arial" size="2"><b> Litres : </b></font> 
<%
					 	}
%>
						</td>
						<td>
							<input type="text" class="element text medium" style="width: 100px" name="lits" size="10"> 
							<label>
								<font color="Black" size="2"><b>Full Tank :</b></font>
								<input type="checkbox" name="fulltank" id="fulltank" value="Yes">
							</label>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;	<font color="red">* </font><font face="Arial" size="2"><b> Amount : </b> </font> <font color="red"></font></td>
					 	<td><input type="text" class="element text medium" style="width: 100px" name="amount" size="10"></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;<font face="Arial" size="2"><b> Odometer : </b> </font> <font color="red"></font></td>
					 	<td><input type="text" class="element text medium" style="width: 100px" name="odometer" size="10">
					 	
					 	<label>
								<font color="Black" size="2"><b>Odometer Reset :</b></font>
								<input type="checkbox" name="Reset" id="Reset" value="OdometerReset">
							</label>
					 	
					 	</td>
					
					</tr>
					<tr>
	      				<td> &nbsp;&nbsp;
<%
		 	       	if (session.getAttribute("fuelformat").toString()
 	       					.equalsIgnoreCase("Gal")) {
%>
					 		<font face="Arial" size="2"><b> Gas Station :</b> <font color="red"> </font></font> 
<%
 					} else {
%>
					 		<font face="Arial" size="2"><b> Petrol Pump :</b> <font color="red"> </font></font> 
<%
 					}
%>		
	      				</td>
						<td> 
							<input type="text" class="element text medium" style="width: 150px" name="petpump" > 		
						</td>
	 				</tr>
	 				<tr>
	 					<td>&nbsp;&nbsp;
	      					<font face="Arial" size="2"><b> Remark :</b> <font color="red"> </font></font>
	  					</td>
	  					<td > 
							<textarea id="cmntreason"   name="remark" rows="5" cols="50" class="element text medium"/> </textarea> 				
						</td>
	 				</tr>
					<tr>
      					<td colspan="2" align="center"> 
      						<div align="center"> 
      							<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" class="formElement"/> 
      						</div> 
      					</td>
  					</tr>
  					<tr>
  						<td colspan="2" align="center">
  							<font size="2">
  								<center>We recommend that you top up your tank at least once a week</center> 
  							</font>
  						</td>
  					</tr>
     		 </table>
			</td>
		</tr>
	</table>
	</table></div>
	
<%
	} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try{
				con1.close();
			}
			catch(Exception e)
			{
				
			}	
		
			try{
				fleetview.closeConnection();
			}
			catch(Exception e)
			{
				
			}
		}
%>
	<%
		//fleetview.closeConnection();
	%>
			
			</form>
		
</body>		

<br>
<br>
<br>
<br>
<br>
<br>
<br>
 <table border="0" width="100%" align="center" style="padding-bottom: 56px" >
<tr><td  bgcolor="#0B2161" >
<ui><li><center><font color="white" >Copyright &copy; 2008-2016 by Transworld Technologies Ltd. All Rights Reserved.</font></center></li></ui>
</td></tr>
</table>

