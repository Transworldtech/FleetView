
<%@ include file="headernew.jsp"%>
	<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page"></jsp:useBean>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
	
	String VehCode=request.getParameter("vehcode");
	String vehregno=request.getParameter("vehregno");
	
	System.out.println(" vehcode is  "+VehCode+" vehregno "+vehregno);
%>
<%!Connection con1;%>
<html>
<head>

<script language="javascript">
 	
 function validate()
 {
	 if(document.getElementById('VehCode').selectedIndex == 0)
	 {
	 alert("Please select Vehicle No");
	 return false;
	 }
	 else
	 {
		
		 if(document.getElementById('comment').selectedIndex == 0)
		 {
		 alert("Please select special comment");
		 return false;
		 }
		 else
		 {
		  return true;
		 } 
	   
	}	
	 
 }

 function checkvalue(val)
 {
	 if(val==="Other")
	       document.getElementById('otherComment').style.display='block';
	    else
	       document.getElementById('otherComment').style.display='none'; 
 }
</script>

</head>



<form name="saveVehIdleEntry" method="post" action="saveVehIdleEntry.jsp" onSubmit="return validate();" >
<%
	try {
			Class.forName(MM_dbConn_DRIVER);
			con1 = fleetview.ReturnConnection();
			
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
			<input type="hidden" name="transporter" id="transporter" value="<%=user %>"></input>
			<table border="3" style="width: 200px" class="sortable_entry" align="center" >
  		      <tr>
		         <td> <div align="center"> <font face="Arial" size="3"> <b> Vehicle Intimation </b> </font>   </div> </td>
		         </tr>
		         <tr>
		         <td>(<font color="red"> *</font> indicates mandatory fields)</td>
		         </tr>
		     
		<td colspan="">
				<br>
				<table border="0" style="width: 400px" align="center">
  	  			<tr>
	      			<td> 
	      	 			<font color="red">* </font><font face="Arial" size="2"><b> Vehicle No :</b></font> </td>
					<td> 
		 <select class="element select medium" name="VehCode" id="VehCode" style="width: 130px">
		<option value="Select">Select</option>
<%
		try {
			String sql= "select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber ";
			System.out.println(" sql "+sql);
			ResultSet rst = stmt1.executeQuery(sql);
			String regNo="";
			while (rst.next()) {
			regNo = rst.getString("VehicleRegNumber");
			VehCode=rst.getString("vehicleCode");
%>
						<option value="<%=VehCode%>"><%=regNo%></option>
	<%
			}
	} catch (Exception e) {
	System.out.print("Exception" + e);
	}
	%>
						
						</select>				
				
					</td>
	 			</tr>
	 			<tr >
	 			
	      			<td> 
	      			<input type="hidden" id="current1" name="current1" value="<%=sysdate22 %>"></input>
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>From Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td >  
						<input type="text"   id="fromDate" name="fromDate" size="13"   value="<%=nwfrmtdte%>" readonly class="element text medium" style="width: 125px; height: 16px;" />
             			<script type="text/javascript">
				             Calendar.setup(
				             {
				                 inputField  : "fromDate",         // ID of the input field
				                 ifFormat    : "%d-%b-%Y",     // the date format
				                 button      : "fromDate"       // ID of the button
				             }
				                           );
             			</script> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             			
				
							</td>
						 </tr>
			
			
					<tr >
	 			
	      			<td> 
	      		
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>To Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td> 
						<input type="text" id="toDate" name="toDate" size="13"   value="<%=nwfrmtdte%>" readonly class="element text medium" style="width: 125px; height: 16px;"  />
             			<script type="text/javascript">
				             Calendar.setup(
				             {
				                 inputField  : "toDate",         // ID of the input field
				                 ifFormat    : "%d-%b-%Y",     // the date format
				                 button      : "toDate"       // ID of the button
				             }
				                           );
             			</script> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             			
				
							</td>
						 </tr>
			
					
					
  					<tr>
				<td> <font color="red">* </font><font size="2"><b> Special Comment: </b> </font></td>
				<td>
					 <select class="element select medium" id="comment" name="comment" style="width: 130px" onchange='checkvalue(this.value)' >
						<option value="Select">Select</option>
							<%
									try {
										String sql= "select * from db_gps.t_specialComment  ";
										ResultSet rst = stmt2.executeQuery(sql);
										String regNo="",vehCode="";
										while (rst.next()) {
										String	comment = rst.getString("comment");
										
							%>
								<option value="<%=comment%>"><%=comment%></option>
							<%
										}
								} catch (Exception e) {
								System.out.print("Exception" + e);
								}
								%>
						
						</select>				
				 		&nbsp;
				 		<!--<input type="text" name="otherComment" id="otherComment" style='display:none;'/>--> 		
				 		<textarea id="otherComment"   name="otherComment" rows="3" cols="30" class="element text medium"  style='display:none;' /> </textarea> 					 		
				</td>
		</tr>
				<tr>
      					<td colspan="2" align="center"> 
      						<div align="center"> 
      							<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" class="formElement"/> 
      						</div> 
      					</td>
  					</tr>
  					
  					
     		 </table>
			</td>
		
	</table>
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




<%@ include file="footernew.jsp" %>
</html>
