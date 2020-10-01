
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
	
	String VehCode=request.getParameter("VehCode");
	System.out.println(" vehcode is  "+VehCode);
	int SrNo=Integer.parseInt(request.getParameter("SrNo"));
	System.out.println("SrNo "+SrNo);
	String SelectdComment=request.getParameter("VehComment");
	System.out.println(" SelectdComment "+SelectdComment);
	
%>
<%!Connection con1;%>
<html>
<head>

<script language="javascript">

 function checkvalue(val)
 {
 	 if(val==="Other")
 	       document.getElementById('otherComment').style.display='block';
 	    else
 	       document.getElementById('otherComment').style.display='none'; 
 }
 
</script>
</head>
			

<form method="post" name="VehIdleEntryUpdate" action="VehIdleEntryUpdate.jsp" onSubmit="return validate(); ">
			
	
<%
	String fromDate, toDate, VehComment, VehicleRegNumber="", otherComment="";

	try {
		String sql2= "select a.SrNo as SrNo, a.VehCode as VehCode, a.fromDate as fromDate,a.toDate as toDate,a.VehComment as VehComment, a.otherComment as otherComment, b.VehicleRegNumber as VehicleRegNumber     from db_gps.t_VehicleIdleEntry a,  db_gps.t_vehicledetails b where SrNo='"+SrNo+"' and a.VehCode='"+VehCode+"' and b.VehicleCode='"+VehCode+"' ";
		System.out.println(" sql2 "+sql2);
		ResultSet rst2 = stmt2.executeQuery(sql2);
		while (rst2.next()) {
			
			SrNo = rst2.getInt("SrNo");
			VehCode = rst2.getString("VehCode");
			VehicleRegNumber = rst2.getString("VehicleRegNumber");
			fromDate = rst2.getString("fromDate").trim();
			toDate = rst2.getString("toDate").trim();
			VehComment = rst2.getString("VehComment");
			otherComment = rst2.getString("otherComment");
			
		System.out.println(" VehComment "+VehComment+" otherComment "+otherComment);
			
	%>			
		<input type="hidden" name="VehCode" id="VehCode" value="<%=VehCode %>"></input>
		<input type="hidden" name="SrNo" id="SrNo" value="<%=SrNo %>"></input>
		
	<table border="3" style="width: 200px" class="sortable_entry" align="center" >
  		      <tr>
		         <td> <div align="center"> <font face="Arial" size="3"> <b> Update Vehicle Notification </b> </font>   </div> </td>
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
							<h3><%= VehicleRegNumber %></h3>				
				
					</td>
	 			</tr>
	 			<tr >
	 			
	      			<td> 
	      			<input type="hidden" id="current1" name="current1" value=""></input>
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>From Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td> 
						<input type="text" id="fromDate" name="fromDate" size="13" class="element text medium" style="width: 125px; height: 16px;"  value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate)) %>" readonly  />
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
	      			<input type="hidden" id="current1" name="current1" value=""></input>
	      	 			<font color="red">* </font><font face="Arial" size="2"> <b>To Date :</b> </font>
	      	 		 </td>
	      	 		 
					<td> 
						<input type="text" id="toDate" name="toDate" size="13" class="element text medium" style="width: 125px; height: 16px;"  value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate)) %>" readonly  class="element text medium" style="width: 125px; height: 16px;"  />
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
				<td><font size="2"><b> Special Comment: </b><font color="red">* </font> </font></td>
				<td>
					 <select class="element select medium" id="comment" name="comment" style="width: 130px" onchange='checkvalue(this.value)'>
						
							<%
								String comment="";
									try {
										String sql= "select * from db_gps.t_specialComment where comment<>'"+SelectdComment+"'";
										System.out.println(" sql  "+sql);
										ResultSet rst = stmt1.executeQuery(sql);
							%>
							<option value="<%=SelectdComment%>"  selected="selected"> <%=SelectdComment%> </option>			
							<%			
									while(rst.next()) 
									{
										comment = rst.getString("comment");
																	
									%>
												<option value="<%=comment%>"> <%=comment%> </option>
									<%
									}
											
									
									} catch (Exception e) {
										System.out.print("Exception" + e);
							}
							%>
						
						</select>				
				 	<textarea id="otherComment" name="otherComment" rows="3" cols="30" class="element text medium"  style='display:none;' /> <%=otherComment %> </textarea>
				</td>
			</tr>
			 
      					<td colspan="2" align="center"> 
      						<div align="center"> 
      							<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" class="formElement"/> 
      						</div> 
      					</td>
  					</tr>
  					
  					
     		 </table>
			</td>
		
	</table>
	
	<% }
	}catch(Exception e)
	{System.out.print("Exception" + e);}%>			

</form>

<br>
<%@ include file="footernew.jsp" %>
</html>
