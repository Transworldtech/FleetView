<%@ include file="headerpopup.jsp"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	%>
	<%!Connection con1;%>
<html>
<head>
<title>Edit User</title>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
</head>
<body>
<script type="text/javascript">
function validateuser()
{

	try
	{
		//alert("*******");
		var fname = document.getElementById("fname").value;
		var lname = document.getElementById("lname").value;
		var phno = document.getElementById("phno").value;
		var dest =  document.edituser.assigned;
		var dest1 = document.edituser.assigned1;
		//alert("*******"+dest);
		
		if(phno == "")
		{
			//alert("Please enter the Phone No!!");
			
			//return false;
		}
		else
		{
			if(isNaN(phno))
			{
				alert("Contact No should be numeric!!");
				
				return false;
			}
		}

		
		if(dest.length == 0)
		{
			alert("Please Allocate the vehicles to the user!!");
			
			return false;
		}

		return datevalidate();

		 
		
		 alert("&&&&");
	}
	catch(e)
	{
		alert(e);
	}
}

function datevalidate()
{
	try
	{
	//alert("***");
	var date1=document.getElementById("allocdate").value;
	var date2 = document.getElementById("expdate").value;
	//alert("*******    "+date1+"  ******    "+date2);
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm11,dd12,yy12,mm2,mm12;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	dd22=date2.substring(0,2);
	mm1=date1.substring(3,6);
	mm2=date2.substring(3,6);
	mm11=dateformat(mm1);
	mm22=dateformat(mm2);
	yy11=date1.substring(7,11);
	yy22=date2.substring(7,11);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
   // alert("yy11  "+yy11+"  year   "+year);
  //  alert("mm11  "+mm11+"  month   "+month);
   // alert("dd11  "+dd11+"  day   "+day);
if(date1 == "" | date2 == "")
{
	alert("Please enter the Allocation Date and Expiry Date");
	return false;
}
else
{
	if(yy22< year)
	{
		alert("selected date should not be Less than todays date");
		//alert("year");
		//document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("expdate").focus;
		
		return false;
	} 
	else if(year==yy22)
	{
		if(mm22<month)
		{
			alert("selected date should not be Less than todays date");
			//alert("month");
			//document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("expdate").focus;
			return false;
		}
	}
	if(mm22==month)
	{
		if(dd22<day)
		{
			alert("selected date should not be Less than todays date");
			//alert("day");
			//document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("expdate").focus;
			return false;
		}
	}
	//  alert("yy11  "+yy11+"  year   "+year);
	 //  alert("mm11  "+mm11+"  month   "+month);
	  //  alert("dd11  "+dd11+"  day   "+day);

	   // alert("yy22  "+yy11+"  year   "+year);
		 //  alert("mm22  "+mm11+"  month   "+month);
		 //   alert("dd22  "+dd11+"  day   "+day);

		  //  alert("yy22  "+yy22+"  yy11   "+yy11);
			//   alert("mm22  "+yy22+"  mm11   "+mm11);
			  //  alert("dd22  "+yy22+"  dd11   "+dd11);
	if(yy11 > yy22)
	{
		alert("Allocation date year should not be greater than Expiry date year");
		//document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("expdate").focus;
		return false;
	}
	else if(year==yy11 & year==yy22)
	{
		 if(mm11>mm22)
	{
		alert("Allocation date year should not be greater than Expiry date year");
	//	document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("expdate").focus;
		return false;
	}
	}
	if(mm11==month & mm22==month) 
	{
		if(yy11==yy22)
		{
		if(dd11 > dd22)
		{
			alert("Allocation date year should not be greater than Expiry date year");
			//document.getElementById("allocdate").value="";
			document.getElementById("expdate").value="";
			document.getElementById("expdate").focus;
			return false;
		}
		}
	}
	else
		if(yy11<yy22)
		{
			return true;
		}
	else
		if(dd11 > dd22)
	{
			if(mm11<mm22)
			{
				return true;
			}
			
		alert("Allocation date year should not be greater than Expiry  date year");
		//document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("expdate").focus;
		return false;
	}
}
var dest =  document.edituser.assigned;
var dest1 = document.edituser.assigned1;
//alert(dest.options.length);
for(var count=0; count < dest.options.length; count++) 
{		
	try
	{   
var option = dest.options[count];

var newOption = document.createElement("option");
newOption.value = option.value;
newOption.text = option.text;
newOption.selected = true;
try {
         dest1.add(newOption, null); //Standard
         dest.remove(count, null);
 }catch(error) {
         dest1.add(newOption); // IE only
         dest.remove(count);
 }

count--;
	}
	catch(e)
	{
		alert(e);
		return false;
	}
}

	}
	catch(e)
	{
		alert(e);
	}

	
	return true;
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
					if(days=='May') //timeformat: "%M:%S"
						
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

function addUser() {
	try
	{
	//alert("HIiiii");
    var src = document.edituser.resources;
    var dest = document.edituser.assigned;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                 }
                count--;
        }
    }
	}
	catch(e)
	{
		alert(e);
	}
}

function removeUser() {
    var src =document.edituser.assigned;
    var dest =  document.edituser.resources;
 
    for(var count=0; count < src.options.length; count++) {
 
        if(src.options[count].selected == true) {
                var option = src.options[count];
 
                var newOption = document.createElement("option");
                newOption.value = option.value;
                newOption.text = option.text;
                newOption.selected = false;
                try {
                         dest.add(newOption, null); //Standard
                         src.remove(count, null);
                        
                 }catch(error) {
                         dest.add(newOption); // IE only
                         src.remove(count);
                        
                 }
                count--;
        }
    }
}
</script>

<%
String Msg = request.getParameter("Msg");
if(Msg!=null && Msg.equalsIgnoreCase("1"))
{
	%>
	<script>
	alert("Updated Successfully.....");
	opener.Reload();
	window.close();	
	</script>
	<%
}
else
	if(Msg!=null && Msg.equalsIgnoreCase("2"))
	{
		%>
		<script>
		alert("Please do some changes to update !!!");
		</script>
		<%
	}

try {
				//System.out.println("$$$$$$$$$   ");
				Class.forName(MM_dbConn_DRIVER);
				con1 = fleetview.ReturnConnection();
				Statement st = con1.createStatement();
				Statement st1 = con1.createStatement();
				Statement st2 = con1.createStatement();
				String ownername = session.getAttribute("usertypevalue").toString();
				//String vehlist = session.getAttribute("VehList").toString();
				String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			    java.util.Date date = new SimpleDateFormat("dd-MMM-yyyy").parse(nwfrmtdte);
			   
			   String vehlist = session.getAttribute("VehList").toString();
			    
			    
			    System.out.println("******    "+vehlist);
			    Calendar cal=Calendar.getInstance();
			    cal.add(Calendar.WEEK_OF_MONTH,1);
			    String date1 = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
			    String username = request.getParameter("username");
			    String typevalue = request.getParameter("typevalue");
			    String status = request.getParameter("activestatus");
			    String sql = "select * from db_gps.t_security where username = '"+username+"' and typevalue= '"+typevalue+"' and activestatus = '"+status+"' ";
			    ResultSet rs = st.executeQuery(sql);
			    if(rs.next())
			    {
			    	String sql1 = "select * from db_gps.t_userdetails where username = '"+username+"' ";
			    	ResultSet rs1 = st1.executeQuery(sql1);
			    	if(rs1.next())
			    	{
			    		String mobno = rs1.getString("MobNo");
			    		
			    	
			    %>	    
<img id="top" src="newimages/top.png" alt="" style="width: 550px;">
	<div id="form_container" style="width: 550px;">
	<h2 align="center">Edit User</h2>
<div align="center" style="width: 100%;text-align: center;">
		<form id="edituser" class="appnitro" enctype="multipart/form-data" method="get" action="updateuser.jsp" onsubmit="return validateuser();" name = "edituser">
			<div  align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff;width: 100%;">
			<center>
			<div style="width: 60%;">
					<table border="0" width="100%" >
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">User Name   </font> </td>
					<td colspan="2" valign="top" ><br><font  face="Arial" color="black" style="font-size: 1.2em;"><%=username %></font>
					<input type="hidden" name = "username" value = "<%=username %>"></input>
					<input type="hidden" name = "status" value = "<%=status %>"></input>
					</td>
					</tr>
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">FirstName   </font> </td>
					<td colspan="2" valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;"><%=rs1.getString("FirstName") %></font>
					<input type="hidden" name = "fname" id="fname"  value = "<%=rs1.getString("FirstName") %>"></input></td>
					
					</tr>
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">LastName   </font> </td>
					<td colspan="2" valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;"><%=rs1.getString("LastName") %></font>
					<input type="hidden" name = "lname" id="lname"  value = "<%=rs1.getString("LastName") %>"></input></td>
					</tr>
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">Contact No   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="phno" name="phno" value="<%=mobno %>" class="element text medium" maxlength="255" style="width: 180px; height: 20px;">
					<input type="hidden" name = "phnoold" value = "<%=rs1.getString("MobNo") %>"></input></td>
					</tr>
					
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">Location   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="loc" name="loc" value="<%=rs1.getString("Location") %>" class="element text medium" maxlength="255" style="width: 180px; height: 20px;">
					<input type="hidden" name = "locold" value = "<%=rs1.getString("Location") %>"></input></td>
					</tr>
					
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">Designation   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="desg" name="desg" value="<%=rs1.getString("Designation") %>" class="element text medium" maxlength="255" style="width: 180px; height: 20px;">
					<input type="hidden" name = "desgold" value = "<%=rs1.getString("Designation") %>"></input></td>
					</tr>
					
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">Allocation Date  </font> </td>
					<td colspan="2" valign="top"><br><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("CreationDate"))) %>
					<input type="hidden" name = "allocdate" value = "<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("CreationDate"))) %>" id = "allocdate"></input>
					<input type="hidden" name = "allocdate1" value = "<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("CreationDate"))) %>" id = "allocdate1"></input></td>
					</tr>
					
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">* Expiry Date:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="expdate" name="expdate" value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("ExpiryDate"))) %>" 
					class="element text medium" maxlength="255" style="width: 180px; height: 20px;background-color:#E6E6E6">
					<script type="text/javascript">
		 				 Calendar.setup(
		             {
		                 inputField  : "expdate",         // ID of the input field
		                 ifFormat    : "%d-%b-%Y",     // the date format
		                 button      : "expdate"       // ID of the button
		             }
		                           );
		</script>
		<input type="hidden" name = "expcdateold"  value = "<%=rs.getString("ExpiryDate") %>"></input>
					</td>
					</tr>
					<tr>
					<td colspan="3" valign="top">
					<br><font  face="Arial" color="black" style="font-size: 1.2em;">* Allocate Vehicles:   </font> </td>
					</td>
					</tr>
					
					<tr>
					<td valign="top"><br>
					<select name="resources" style="width:160px" size="7" id="resources" multiple="multiple">
					<%
					String	sql2 = "select VehicleRegNumber from db_gps.t_vehicledetails where Status = '-'  and vehiclecode in "+vehlist+"  and vehiclecode not in (select Vehcode from db_gps.t_group where GPName = '"+typevalue+"' and VehRegno = '"+ownername+"' and Active = 'Yes' and SepReport = 'Yes')  order by VehicleRegNumber";
					ResultSet rs2 = st2.executeQuery(sql2);
					while(rs2.next())
					{
						//System.out.println("*******");
						%>
			 			<option value="<%=rs2.getString("VehicleRegNumber") %>" ><%=rs2.getString("VehicleRegNumber") %></option>
						<%
					}
	%>
					</select>
					</td>
					<td valign="top">
					<br>
					<div><input type="button" class="button" value="&gt;" onClick="addUser();" /></div>
					<div><input type="button" class="button" value="&lt;" onClick="removeUser()" /></div>
					</td>
					<td align="center" valign="top">
					<br>
					<select name="assigned" style="width:160px" size="7" multiple="multiple">
					<%
					sql2 = "select transporter from db_gps.t_group where GPName = '"+typevalue+"' and VehRegno = '"+ownername+"' and Active = 'Yes' and SepReport = 'Yes'";
					rs2 = st2.executeQuery(sql2);
					while(rs2.next())
					{
						%>
			 			<option value="<%=rs2.getString("transporter") %>" ><%=rs2.getString("transporter") %></option>
						<%
					}
					%>
					</select>

					<select name="assigned1" style="width:160px;display: none" size="7" multiple="multiple">
	
					</select>
</td>
					</tr>
					
					<tr>
						
						<td align="center" colspan="3"><br><input type="submit" class="submit" value="submit"  /></td>				
							
					</tr>
					</table>
					
					</div>
					</center>
					</div>
		</form>
		</div>
	</div>
	
<%
			    	}
			    }
} catch (Exception e) {
	out.println("Please Select The Transporter");
} finally {
	try {
		con1.close();
	} catch (Exception e) {
	}
	try {
		fleetview.closeConnection();
	} catch (Exception e) {
	}
}

%>	
</body>
</html>
</jsp:useBean>