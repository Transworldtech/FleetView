
<%@ include file="headernew.jsp"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
				MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
%>
	<script LANGUAGE="JavaScript">

	function OnChangeGetUsers(dropdown)
	{
		
		var vv1=dropdown.selectedIndex;
		var SelValue1 = dropdown.options[vv1].value;
		if(SelValue1=="Select")
		{
		   document.mainpageform.ccode.value = "";		          
		   document.mainpageform.cpname.value = "";
		}
		else if(SelValue1=="Other")
		{ } 
	 else
	 {
	  var ajaxRequest;
		     try{
					ajaxRequest = new XMLHttpRequest();
		        }  
	            catch (e)
	            {
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
				     				 alert("Your browser broke!");
				      				return false;
				   			 }
		        		}
	              }
	              var queryString = "?selopt=" +SelValue1;
	          	ajaxRequest.open("GET", "getConfigUsers.jsp" + queryString, true);
	          	ajaxRequest.send(null); 
	          	ajaxRequest.onreadystatechange = function()
	            {
	                   if(ajaxRequest.readyState == 4)
	                   {
	                           var reslt=ajaxRequest.responseText;
	                           var mySplitResult = reslt.split("#");
	                           document.getElementById("EDITusername").innerHTML=mySplitResult[0];
	                   }
	            }
	 }
	}


	function OnChangeGetDetails(dropdown,dropdown2)
	{
		
		var vv1=dropdown.selectedIndex;
		var vv2=dropdown2.selectedIndex;
		var SelValue1 = dropdown.options[vv1].value;
		var SelValue2 = dropdown2.options[vv2].value;
		if(SelValue1=="Select")
		{
		   document.mainpageform.ccode.value = "";		          
		   document.mainpageform.cpname.value = "";
		}
		else if(SelValue1=="Other")
		{ } 
	 else
	 {
	  var ajaxRequest;
		     try{
					ajaxRequest = new XMLHttpRequest();
		        }  
	            catch (e)
	            {
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
				     				 alert("Your browser broke!");
				      				return false;
				   			 }
		        		}
	              }
	              var queryString = "?selopt=" +SelValue1+" &category="+SelValue2;
	          	ajaxRequest.open("GET", "getConfigDetails.jsp" + queryString, true);
	          	ajaxRequest.send(null); 
	          	ajaxRequest.onreadystatechange = function()
	            {
	                   if(ajaxRequest.readyState == 4)
	                   {
	                           var reslt=ajaxRequest.responseText;
	                           var mySplitResult = reslt.split("#");
	                           document.getElementById("EDITemail").innerHTML=mySplitResult[0];
	                           document.getElementById("EDITmobilenumber").innerHTML=mySplitResult[1];
	                           document.getElementById("EditExtraEmails").innerHTML=mySplitResult[2];
	                         //  document.getElementById("EDITusername").innerHTML=document.getElementById("EDITusername").innerHTML;
	                         //  document.getElementById("EDITcategory").innerHTML=document.getElementById("EDITcategory").innerHTML;
	                   }
	            }
	 }
	}

	
	
function showMe(dividShow,divHide1,divHide2,divHide3) {
		document.getElementById(dividShow).style.visibility="visible";
		document.getElementById(divHide1).style.visibility="collapse";
		document.getElementById(divHide2).style.visibility="collapse";
		document.getElementById(divHide3).style.visibility="collapse";
 	}
	function edit(ed,ee,aa){
		alert(ed);
		alert(ee);
		alert(aa);
	}
 
function confirmSubmit()
{
	var veh=document.fuelform.vehs.value;
    var driv=document.fuelform.drivers.value;
    var petpump=document.fuelform.petpump.value;
    var varValue = document.fuelform.odometer.value;
    var lits=document.fuelform.lits.value;

    var split = veh.split(",");
    
	var agree=confirm("Vehicle: "+split[0]+"\nOdometer : "+varValue+"\nLiters: "+lits+"\n\nAre you sure you want to continue with these values?");
	if (agree)
		return true ;
	else
		return false ;
	}

</script>

	<script language="javascript">
 function validate()
 {
     var veh=document.fuelform.vehs.value;
     var driv=document.fuelform.drivers.value;
     var petpump=document.fuelform.petpump.value;
     var varValue = document.fuelform.odometer.value;
     var lits=document.fuelform.lits.value;
     
     if(veh=="Select")
     {
         alert("Please select Vehicle No");
         return false;
     }        
    	 if (!(lits.match(/^\d+$|^\d+\.\d{2}$/ )) && lits.length!=0)
    	 {
    	 alert("Liters precision should not be greater than 0.2\n\nEg: 40.23");
    	 document.fuelform.lits.value="";
    	  return false;
    	 }
      if(varValue=="" &&  lits=="")
      {
          alert("Please enter either Odometer or Litres  reading");
          return false;
      }

      var numericExpression = /^[0-9]+$/;
  	if(varValue.match(numericExpression)){
  		return true;
  	}else{
  		alert("Odometer reading should be numeric");
  		elem.focus();
  		return false;
  	}
        
     if(isNaN(lits))
     {
         alert("Please enter valid amount of fuel filled");
         return false;
     }    

		if(varValue.length>7)
		{
			alert("Odometer reading should be 7 digit no.");
	          return false;
		}
  	
     return true;
 }

</script>

	<%!Connection con1;%>

	<%
 String location="",locationCode="",transporter="";
	try {
			Class.forName(MM_dbConn_DRIVER);
			con1 = fleetview.ReturnConnection();
			Statement st1 = con1.createStatement();
			Statement st2 = con1.createStatement();

			String user = session.getAttribute("usertypevalue").toString();
			String usertype = session.getAttribute("TypeofUser").toString();

			if(usertype.equalsIgnoreCase("SUBUSER"))
			{
				location=session.getAttribute("Location").toString();
				locationCode=session.getAttribute("LocationCode").toString();
			}
%>
	<table border="0" width="100%" bgcolor="white">
		<tr>

			<td>
			<div align="center"><font color="maroon" size="3"> <b>
			Configuration </b> </font> (<font color="red"> *</font> indicates mandatory
			fields)</div>
			</td>
		</tr>
		<%
		     	String inserted = request.getParameter("inserted");
		     			if (!(inserted == null)) {
		     				
		     			if("yes".equalsIgnoreCase(inserted))
		     			{
		     %>
		<tr>
			<td colspan="2" align="center">Successfully Inserted! Click <a
				href="currentposition.jsp">Here </a> to go to main page.</td>
		</tr>
		<%
			     				     	}
		     			else if("no".equalsIgnoreCase(inserted)){
		     				
		     				%>
		<tr>
			<td colspan="2" align="center">Record Not Inserted. Please Try
			Again!!!</td>
		</tr>
		<%
		     			}
		     			}
		     			
			     				     %>
		<tr>
			<td align="center"><input type="radio" name="c1"
				onclick="showMe('insert','editConfiguration','activate_deactivate','showall')">Add
			New <input type="radio" name="c1"
				onclick="showMe('editConfiguration','insert','activate_deactivate','showall')">Edit
			<input type="radio" name="c1"
				onclick="showMe('activate_deactivate','editConfiguration','insert','showall')">Activate/De-activate
			<input type="radio" name="c1"
				onclick="showMe('showall','activate_deactivate','editConfiguration','insert')">Show
			All</td>
		</tr>
	</table>
	<div id="insert" style="visibility: hidden">
	<form name="configurationInsert" method="post"
		action="configurationinsert.jsp?action=1"
		onSubmit="return validate();">
	<table border="0" width="100%" bgcolor="white">

		<tr>
			<td colspan="2">
			<table border="0" width="30%" align="center">
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"><b> Name : </b><font
						color="red">* </font> </font></td>
					<td><input type="text" name="username"></input></td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>E-mail id :</b> <font
						color="red">* </font></font></td>
					<td><input type="text" name="email"></input></td>

				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Mobile no :</b> <font
						color="red">* </font></font></td>
					<td><input type="text" name="mobilenumber"></input></td>

				</tr>
 
<%if(usertype.equalsIgnoreCase("GROUP")){%>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Category :</b> <font
						color="red">* </font></font></td>
					<td><select name="category">
						<option value="Select">Select</option>
						<option value="Select">Category :</option>
					</select></td>
				</tr>
<% } %>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Extra E-mails
					:</b> <font color="red"><br>
					(Please Add comma separated Addresses) </font></font></td>
					<td><textarea wrap="virtual" rows="2" cols="30"
						name="extraemails" id="extraemails" style="width: 140">
					</textarea></td>
				</tr>


				<tr bgcolor="#CCCCCC">
					<td colspan="2" align="center"><input type="submit"
						name="Submit" value="Submit" onclick="return confirmSubmit()" />
					</td>
				</tr>

			</table>

			</td>
		</tr>

	</table>
	</form>
	</div>



	<div id="editConfiguration" style="visibility: hidden;">
	<form name="configurationEdit" method="get"
		action="configurationinsert.jsp?action=edit"
		onSubmit="return validate();">


			<table border="0" width="30%" align="center">
			
			<%if(usertype.equalsIgnoreCase("GROUP")) { %>
							<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"><b> Category</b><font color="red">* </font> </font></td>
					<td><select name="category" id="category" onChange="OnChangeGetUsers(this);">
					<option value="Select">Select</option>
						<option value="Transporter">Transporter</option>
						<option value="CFA">CFA</option>
						<option value="RM">RM</option>
					</select></td>
 
				</tr>

<%} %>
			
			
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"><b> Name
					EDIT******: </b><font color="red">* </font> </font></td>
					<td><div id="EDITusername"><select name="EDITusername" id="EDITusername" onChange="OnChangeGetDetails(this,category);">
						<option value="Select">Select</option>
					</select></div></td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>E-mail id :</b> <font
						color="red">* </font></font></td>
					<td><div id="EDITemail"><input type="text" name="EDITemail"></input></div></td>

				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Mobile no :</b> <font
						color="red">* </font></font></td>
					<td><div id="EDITmobilenumber"><input type="text" name="EDITmobilenumber"></input></div></td>

				</tr>
 

				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Category :</b> <font
						color="red">* </font></font></td>
					<td><select name="EDITcategory">
						<option value="Select">Select</option>
						<option value="Select">Category :</option>
					</select></td>
				</tr>

				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Extra E-mails
					:</b> <font color="red"><br>
					(Please Add comma separated Addresses) </font></font></td>
					<td><div id="EditExtraEmails"><textarea wrap="virtual" rows="2" cols="30"
						name="EditExtraEmails" id="EditExtraEmails" style="width: 140">
					</textarea></div></td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan="2" align="center"><input type="submit"
						name="Submit" value="Submit" onclick="return confirmSubmit()" />
					</td>
				</tr>


			</table>

 
	</form>
	</div>
	


	<div id="activate_deactivate" style="visibility: hidden;">
	<form name="configurationActivate" method="get"
		action="configurationinsert.jsp?action=activate"
		onSubmit="return validate();">
	<table border="0" width="100%" bgcolor="white">

		<tr>
			<td colspan="2">
			<table border="0" width="30%" align="center">
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"><b> Name ACT: </b><font
						color="red">* </font> </font></td>
					<td><input type="text" name="username"></input></td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>E-mail id :</b> <font
						color="red">* </font></font></td>
					<td><input type="text" name="email"></input></td>

				</tr>
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Mobile no :</b> <font
						color="red">* </font></font></td>
					<td><input type="text" name="mobilenumbers"></input></td>

				</tr>
 

				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Category :</b> <font
						color="red">* </font></font></td>
					<td><select name="Category :">
						<option value="Select">Select</option>
						<option value="Select">Category :</option>
					</select></td>
				</tr>

				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> <b>Extra E-mails
					:</b> <font color="red"><br>
					(Please Add comma separated Addresses) </font></font></td>
					<td><textarea wrap="virtual" rows="2" cols="30"
						name="comments" id="comments" style="width: 140">
					</textarea></td>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan="2" align="center"><input type="submit"
						name="Submit" value="Submit" onclick="return confirmSubmit()" />
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</form>
	</div>



	<div id="showall" style="visibility: hidden;">
	<table border="1" width="100%" bgcolor="white">
		<tr>
			<th>Sr No.</th>
			<th>Name</th>
			<th>Email-id</th>
			<th>Mobile no</th>
			<th>Group</th>
			<th>Category Type</th>
			<th>Category Name</th>
			<th>CFA Code</th>
			<th>Extra Email-Id's</th>
			<th>Active Status</th>
			<th>Last Updated Time</th>
			<th>Updated By</th>
			<th><a href="#" onClick="edit('<%=user %>','edit','<%=usertype %>'); return false">Edit</a></th>
			<th>Activat/Deactivate</th>
		</tr>
		<%
 	String sql="";
		try{
		if(usertype.equalsIgnoreCase("SUBUSER"))
				sql="SELECT * FROM t_alertconfiguration where CategoryName="+location+"";
		else if(usertype.equalsIgnoreCase("GROUP"))
			sql="SELECT * FROM t_alertconfiguration where EnteredBy ="+session.getAttribute("user").toString()+" ";
		else if(usertype.equalsIgnoreCase("Transporter"))
			sql="SELECT * FROM t_alertconfiguration where CategoryName="+user+"";
 
 ResultSet rs=st1.executeQuery(sql);
int i=1;
 if(rs.next()){
 
 %>
		<tr>
		<td><%=i %></td>
			<td><%=rs.getString("name") %></td>
			<td><%=rs.getString("email") %></td>
			<td><%=rs.getString("mobileno") %></td>
			<td><%=rs.getString("group") %></td>
			<td><%=rs.getString("CategoryType") %></td>
			<td><%=rs.getString("CategoryName") %></td>
			<td><%=rs.getString("CFAcode") %></td>
			<td><%=rs.getString("extraemails") %></td>
			<td><%=rs.getString("ActiveStatus") %></td>
			<td><%=rs.getString("UpdatedDateTime") %></td>
			<td><%=rs.getString("EnterdBy") %></td>
			<td> 
			<a href="configurationEDIT.jsp?action='edit'&editName='<%=rs.getString("name") %>'" title="Click To Edit">---Edit</a></td>
			<td><a href="configurationEdit.jsp?action=activate" title="Click To Activate/Deactivae">---Activate/Deactivate</a></td>
		</tr>
		<%i++; %>
		<%}else{
 %>
		<tr>
			<td>-------- NO DATA --------</td>
		</tr>
		<%} 
		}catch(Exception e){out.println("***");}
		%>
	</table>
	</div>

	<%
	} catch (Exception e) {
			e.printStackTrace();
		} finally {
			 con1.close();  
			 
			try{ fleetview.closeConnection(); }
			catch(Exception e)
			{ }
		}
		
%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>
</body>
</html>
