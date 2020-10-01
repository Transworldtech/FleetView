
<!-- Displayed Header -->
<%@ include file="headernew.jsp"%>
<%@page import="java.util.Date"%>

<!-- Database Connection -->
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,	MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
 	%>

<!-- JavaScript for export to excel and export to PDF -->
	<script language="javascript">
	function validateForm() {
	    var x = document.forms["labelform"]["label"].value;
	    var y = document.forms["labelform"]["vehno"].value;
	    var z = document.forms["labelform"]["sensor"].value;
	    
	    if (x == null || x == "") {
	        alert("Please Enter The Label ");
	        return false;
	    }
	    if(y=="Select" || y== "" || y==null){
		    alert("Please Select The Vehicle");
		    return false;
	    }
	    if(z=="Select" || z== "" || z==null){
			alert("Please Select The Sensor");
			return false; 
		    }
	    
	}
	
	function gotoPrint(divName)  
	{  
		  var printContents = document.getElementById(divName).innerHTML; 
		  var originalContents = document.body.innerHTML; 
		  document.body.innerHTML = printContents;  
		  window.print();
		  document.body.innerHTML = originalContents;  
	}

	 function gotoExcel(elemId, frmFldId)
	 {  
	 		
	           var obj = document.getElementById(elemId); 
	           var oFld = document.getElementById(frmFldId);  
	           oFld.value = obj.innerHTML;  
	           document.sensorrep.action ="excel.jsp";
	           document.forms["sensorrep"].submit();
	            
	  } 
	 function popUp()
	 { 
		 
		 window.open('labelUpdate.jsp','jav','width=830,height=400,top=150,left=250,resizable=no,scrollbars=yes');
	 }
	 function popUp(webadd,owner,vehicle)
	 { 
		 window.open(webadd+'?owner='+owner+'&vehicle='+vehicle,'jav','width=830,height=400,top=150,left=250,resizable=no,scrollbars=yes');
	
	  }

	 function DeleteRow(id)
	 {
	 	 //alert(id);
	 	 var SrNo=id;
	 	 var agree=confirm("Do You Want to Continue Delete Record?");
	 	 //alert(agree);
	 	 if(agree)
	 	 {
		 	 
	 	 var ajaxRequest;  // The variable that makes Ajax possible!
	 	    try
	 	    {
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

	 		// Create a function that will receive data sent from the server
	 		ajaxRequest.onreadystatechange = function()
	 		{
	 			if(ajaxRequest.readyState == 4)
	 			{
	 				var reslt=ajaxRequest.responseText;
	 				//alert(">>>    "+reslt);
	 				var data=reslt.split("#");
	 				//alert("<*****  "+data);
	 				if(data[1].indexOf('Yes')!=-1)
	 				{alert("Deleted successfully.....");					
	 			    	window.location.reload();
	 			    	
	 				}
	 			
	 			} 
	 		}
	 		
	 		var queryString = "?action=delete&srno="+SrNo;
	 		
	 		
	 		ajaxRequest.open("GET", "labeldelete.jsp" + queryString, true);
	 		ajaxRequest.send(null); 

	 	 }
	 	 else
		 	 {
		 	 
		 	  return false;
	 	 }
	 	 
	 	
	 }  
	 
	
	      
	
  </script>
<!-- JavaScript for export to excel and export to PDF -->  
  
	<%!
		String datex1, datex2, data1, data2;
	%>
	<%
	//String user=session.getValue("user").toString();
	String user = session.getAttribute("usertypevalue").toString();
	String ddx = request.getQueryString();
			
			if (ddx == null) {
				datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
						.format(new java.util.Date());
				data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new java.util.Date());
			} else {
				data1 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("dd-MMM-yyyy")
								.parse(request.getParameter("data")));
				data2 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new SimpleDateFormat("dd-MMM-yyyy")
								.parse(request.getParameter("data1")));

				datex1 = request.getParameter("data");
				datex2 = request.getParameter("data1");
			}

	System.out.println(" datex1 "+datex1+" datex2 "+datex2);
	%>
	
			
			
<div class="div1" align="Center"><h2 style= "font:normal 16px Arial,Helvtica,sans-serif;"><b>Add Sensor Label</b></h2>
</div>

<div align="center">
<form id="labelform" name="" action="sensorentryinsert.jsp" onsubmit="return validateForm()" method="post" >
<table  style="width: 100%;">

<br></br>
   				
     			<tr>
				
	      			<td> 
	      			
	      	 			<font color="red"> </font><font face="Arial" size="2"><b> Vehicle No: </b></font> </td>
					<td> 
				        <select  name="vehno" id="vehno">
						<option value="Select" selected>Select</option>
						<%
		
			
			Class.forName(MM_dbConn_DRIVER);
			Connection con1;
			con1 = fleetview.ReturnConnection();
			Statement stmt1=con1.createStatement();
			Statement st1=con1.createStatement();
			String sql= "select * from t_vehicledetails where vehicleCode in"+session.getValue("VehList").toString()+" order by VehicleRegNumber ";
			System.out.println("sql query"+sql);
			ResultSet rst = stmt1.executeQuery(sql);
			String regNo="",vehCode="";
			
			while (rst.next()) {
			regNo = rst.getString("VehicleRegNumber");
			vehCode=rst.getString("vehicleCode");   
%>
	<option value="<%=regNo%>"><%=regNo%></option>			
<% } %>
			
						
						
						</select>				
				
					</td>
	 					<td> &nbsp;&nbsp;  <font face="Arial" size="2"><b> Sensor: </b> </font></td>
							<td><select name="sensor" id="sensor"  style="width: 150px">
							 <option selected>Select</option>
							<option value="Sensor 1" >Sensor 1</option>
                            <option value="Sensor 2" >Sensor 2</option>
                  	        <option value="Sensor 3" >Sensor 3</option>
                  	        <option value="Sensor 4" >Sensor 4</option>
                  	       
							</select>
									
						<td><font color="red">* </font><font face="Arial" size="2"><b> Label :  </b> </font> <font color="red"></font></td>
					 	<td><input type="text" class="element text medium" style="width: 100px" name="label" id="label" size="10"></td>
					 	</td>
					 	</td>
					 	
					 	
					 	<td>	<div align="center"> 
      							<input type="submit" name="Submit" value="Submit" style="border-style: outset; border-color: black" class="formElement"/> </td> 
      						</div> 
      					
  					
  					</tr>
  					
     		 </table><br><br>
     		 </form>
			
		<%
		 String  exportFileName="Sensor_Label_report.xls";
		%>
		
<form name="sensorrep" method="post">
<div id="table1" align="center">
<table   width="50%" align ="center">
	
	<tr>
		<td align="right">	
							<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							 
                          <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('table1');"> 
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
                          <a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a>&nbsp;<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new Date()) %></div>
                           
		</td>
	</tr>
	</table>
	
	<tr>
		<td>
			<table border="1" class="sortable"  style= "font:normal 13px Arial,Helvtica,sans-serif; width : 50%; ">
			<tr>
			<th>Delete</th>
			<th>Edit</th>
			<th>Sr No</th>
			<th>Owner Name</th>
			<th>Vehicle No.</th>
			<th>Sensor</th>
			<th>Label</th>
			
			
			</tr>
			
		<%
				String ownername="", vehno="",sen="",label="";
		String sql1="select * from db_gps.t_sensorlabels where ownername like '%"+user+"%'";
		ResultSet rs=st1.executeQuery(sql1);
		int count=0;
		while(rs.next())
		{
			ownername=rs.getString("ownername");
			vehno=rs.getString("vehregno");
			sen=rs.getString("Sensor");
			label=rs.getString("tray");
			
			
			%>	
			<tr>
			
			<td style="width: 2%"><a href="#"  style="font-weight: bold; color: black; "  onclick="DeleteRow('<%= rs.getInt("srno")%>') "><img src="images/delete.jpeg"  width="20px" height="18px"  style="border-style: none"  ></img></a></td> 
	
    		<td style="width: 2%"><a href="#"   style="font-weight: bold; color: black; " onclick="popUp('labelUpdate.jsp','<%=ownername%>','<%=vehno %>')"><img src="images/edit1.jpg"  width="20px" height="18px"  style="border-style: none"  ></img></a></td>
     
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= ++count %></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%= ownername%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=vehno%></td>
			<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%= sen%></td>
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%= label%></td>
			
		</tr>
			
	<% 	}
		%>	
	
	</table>
	</td>
	</tr>
	
	</div>
	
	</form>
	
	
	
	

	

</jsp:useBean>
<!-- footer -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<%@ include file="footernew.jsp"%>
