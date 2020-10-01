<%@ include file="headernew.jsp" %>               
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,
					MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	%>
	<%!Connection con1;%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vehicle Master Entry</title>
</head>
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">
<script type="text/javascript">
function  validateUsr()
{
	//alert("Please Enter Value for UserName/Email_Id");
	var usrname=document.getElementById("usrname").value;
	if(usrname=="" || usrname==" " || usrname==null)
		{
			document.getElementById("UnameLabel").style.display= "";
			return false;
		}
	
}

function  validateFnm()
{
	
	
	var fname=document.getElementById("fname").value;
	
	    if(fname=="" || fname==" " || fname==null) 
	    {
	    	//alert(1234);
	        document.getElementById("FnameLabel").style.display = "";
	        return false;
	    }
	}



function  validateLnm()
{
	//alert("Please Enter Value for LastName");
	var lname=document.getElementById("lname").value;
	if(lname=="" || lname==" " || lname==null)
		{
			document.getElementById("LnameLabel").style.display= "";
			return false;
		}
	
}
function  validatefrom()
{
	//alert("Allocate From Date  from Calender ");
	var allocdate=document.getElementById("allocdate").value;
	if(allocdate=="" || allocdate==" " || allocdate==null)
	{
		document.getElementById("Valdate").style.display= "";
		return false;
	}
	
}
/* function  validatetill()
{
	//alert("Allocate Till Date from Calender ");
	//return false;
	 
} 
 function  validateVehicle()
{
	//alert("Allocate Vehicle  ");
	var addVeh=document.getElementById("assigned").value;
	if(addVeh=="" || addVeh==" " || addVeh==null)
		{
		//alert("Allocate Vehicle  ");
			document.getElementById("AddVeh").style.display= "";
			return false;
		}
	 
} */

function dateformat1(days)
{
	 if(days==1)
		return('Jan');
	 else
		if(days==2)
			return('Feb');
		else
			if(days==3)
				return('Mar');
			else
				if(days==4)
					return('Apr');
				else
					if(days==5) //timeformat: "%M:%S"
						
						return('May');
					else
						if(days==6)
							return('Jun');
						else
							if(days==7)
								return('Jul');
							else
								if(days==8)
									return('Aug');
								else
									if(days==9)
										return('Sep');
									else
										if(days==10)
											return('Oct');
										else
											if(days==11)
												return('Nov');
											else
												if(days==12)
													return('Dec');
 }

function returnexpdt()
{
	try
	{
	var dt =document.getElementById("allocdate").value;
	var date,mon,year;
	date = dt.substring(0,2);
	mon = dt.substring(3,6);
	year = dt.substring(7,11);
	var mon1 = dateformat(mon);
  	 var dt2 = new Date(mon1+"/"+date+"/"+year);
	 dt2.setDate(dt2.getDate()+7);
	//alert("88888888888  "+dt2);
 	var date1 = ""+dt2.getDate(); 
 	var month = dt2.getMonth()+1;
 	month = dateformat1(month);
 	var year1 = dt2.getFullYear();
	//alert("88888888888  "+month);
	if(date1.length == 1)
	{
		date1 = "0"+date1;
	}
	document.getElementById("expdate").value = date1+"-"+month+"-"+year1;
   	
	}
	catch(e)
	{
		//alert(e);
	}
	
}

function validateuser()
{

	try
	{
		
var usr = document.getElementById("usrname").value;
//var pwd = document.getElementById("pwd").value;
//var cnfpwd = document.getElementById("cnfpwd").value;
var fname = document.getElementById("fname").value;
var lname = document.getElementById("lname").value;
var phno = document.getElementById("phno").value;
var loc = document.getElementById("loc").value;
var desg = document.getElementById("desg").value;
var desg = document.getElementById("desg").value;
var dest =  document.createuser.assigned;
var dest1 = document.createuser.assigned1;
//alert(dest.length);

var Val2 = document.getElementsByName("trk");
var flg2=0;
 for ( var i = 0; i < Val2.length; i++ ) 
	  {	
		if ( Val2[i].checked==true)
	 		{
			TChkAdhJ =Val2[i].value;
			if ( Val2[i].value=='IAL')
				{
				flg2=1;
				document.getElementById("UserType").value=Val2[i].value;
				}
		 }	
	  }



var desg = document.getElementById("desg").value;

if(usr == "")
{
	alert("Please enter the username!!");
	
	return false;
}
else if(flg2=="1")
{
	//alert("You Selected IAL User!!");

}
 else
{
   	var usrname = validateEmail(usr);
	if(!usrname)
	{
		alert("UserName should be an email_ID!!");
		
		return false;
	}
} 
/*if(pwd == "")
{
	alert("Please enter the password!!");
	return false;
}

//alert(cnfpwd);
//alert(pwd);
//alert(pwd != cnfpwd);
if(pwd != cnfpwd)
{
	alert("Confirm password doesn't match with password!!");
	return false;
}
*/

if(fname == "")
{
	alert("Please enter the FirstName!!");
	
	return false;
}

if(lname == "")
{
	alert("Please enter the LastName!!");
	
	return false;
}

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


//alert(dest.length);
if(dest.length == 0)
{
	alert("Please Allocate the vehicles to the user!!");
	
	return false;
}

//alert(dest.options.length);

try
{
//alert("HIiiii");


for(var count=0; count < dest.options.length; count++) {   
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
}
catch(e)
{
	//alert(e);
}

//return datevalidate();
	}
	catch(e)
	{
		alert(e);
		return false;
		
	}
	return true;
}

function datevalidate()
{
	try
	{
	//alert("***");
	var date1=document.getElementById("allocdate").value;
	var date2 = document.getElementById("expdate").value;
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
	if(yy11< year | yy22< year)
	{
		alert("selected date should not be Less than todays date");
		//alert("year");
		document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("allocdate").focus;
		
		return false;
	} 
	else if(year==yy11 & year==yy22)
	{
		if(mm11<month  | mm22<month)
		{
			alert("selected date should not be Less than todays date");
			//alert("month");
			document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("allocdate").focus;
			return false;
		}
	}
	if(mm11==month  & mm22==month)
	{
		if(dd11<day  | dd22<day)
		{
			alert("selected date should not be Less than todays date");
			//alert("day");
			document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("allocdate").focus;
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
		document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("allocdate").focus;
		return false;
	}
	else if(year==yy11 & year==yy22)
	{
		 if(mm11>mm22)
	{
		alert("Allocation date year should not be greater than Expiry date year");
		document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("allocdate").focus;
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
			document.getElementById("allocdate").value="";
			document.getElementById("expdate").value="";
			document.getElementById("allocdate").focus;
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
		document.getElementById("allocdate").value="";
		document.getElementById("expdate").value="";
		document.getElementById("allocdate").focus;
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

function validateEmail(usrname)
{
    var splitted = usrname.match("^(.+)@(.+)$");
    if(splitted == null) return false;
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
	    var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
	    if(splitted[2].match(regexp_ip) == null) return false;
      }// if
      return true;
    }
return false;

var flag = false;
var pattern=/^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+\.([a-zA-Z])+([a-zA-Z])+/;
var pattern1 = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;  

if(pattern1.test(email))
{
	flag = true;
}
else
{
	if(pattern.test(email))
	{
		flag = true;
	}
	else
	{
		flag = false;
	}
}
if(flag)
{
	return true;
}
else
{
	return false;
}

}

function addUser() {
	try
	{
	//alert("HIiiii");
    var src = document.createuser.resources;
    var dest = document.createuser.assigned;
 
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
    var src =document.createuser.assigned;
    var dest =  document.createuser.resources;
 
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

String usrname="";
String fname="";
String lname="";
String phno="";
String loc="";
String desg="";
String allocdate="";
String expdate="";
String Msg=request.getParameter("Msg");
System.out.println("******    "+Msg);
if(Msg!=null && Msg.equalsIgnoreCase("1"))
{
	%>
	<script>
	alert("Username already exist!!");
	</script>
	<%
	
}
else
	if(Msg!=null && Msg.equalsIgnoreCase("2"))
	{
		%>
		<script>
		alert("FirstName and LastName already exist!!");
		</script>
		<%
		
	}
	else
		if(Msg!=null && Msg.equalsIgnoreCase("3"))
		{
			%>
			<script>
			alert("User created Successfully.");
			</script>
			<%
			
		}

%>

	<img id="top" src="newimages/top.png" alt="" style="width: 550px;">
	<div id="form_container" style="width: 550px;">
	
		<h1 align="center"><a>Create New Login ID</a></h1>
		<br>
		<form id="createuser" class="appnitro" enctype="multipart/form-data" method="get" action="insertnewuser.jsp" onsubmit="return validateuser();" name = "createuser">
					<div class="form_container">
					<%
		try {
				//System.out.println("$$$$$$$$$   ");
				Class.forName(MM_dbConn_DRIVER);
				con1 = fleetview.ReturnConnection();
				Statement st = con1.createStatement();
				String vehlist = session.getAttribute("VehList").toString();
				String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
			    java.util.Date date = new SimpleDateFormat("dd-MMM-yyyy").parse(nwfrmtdte);
			    Calendar cal=Calendar.getInstance();
			    cal.add(Calendar.WEEK_OF_MONTH,1);
			    String date1 = new SimpleDateFormat("dd-MMM-yyyy").format(cal.getTime());
			    
				//String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir"); 
				//out.println("FileUploadPath   "+FileUploadPath);
				//File uploadDir = new File(FileUploadPath);
				//out.println("IIIIIII  "+uploadDir.toString());
				%>
				
				
					
		</div>						
			
				<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
				<br>
			<table border="0" width="80%" align="center">
					<tr>
					<td valign="top"><font color="red">*</font><font  face="Arial" color="black" style="font-size: 1.2em;"> User Name/Email ID:   </font> </td>
					<td colspan="2" valign="top"><input type="text" id="usrname" name="usrname" value="" onblur="return validateUsr();" class="element text medium" maxlength="255" style="width: 180px; height: 16px;">
					<div><font  size="1em">Password will be sent to this mail id.</font></div>
					<div><font  size="1em" color="red" ><label id="UnameLabel" style="display:none;">Please Enter Valid UserName</label></font></div>
					</td>
					</tr>
<!--					<tr>-->
<!--					<td><br><font  face="Arial" color="black" style="font-size: 1.2em;">* Password:   </font> </td>-->
<!--					<td colspan="2"><br><input type="password" id="pwd" name="pwd" value="" class="element text medium" maxlength="255" style="width: 180px; height: 16px;"></td>-->
<!--					</tr>-->
<!--					<tr>-->
<!--					<td><br><font  face="Arial" color="black" style="font-size: 1.2em;">* Confirm Password:   </font> </td>-->
<!--					<td colspan="2"><br><input type="password" id="cnfpwd" name="cnfpwd" value="" class="element text medium" maxlength="255" style="width: 180px; height: 16px;"></td>-->
<!--					</tr>-->
					<tr>
					<td valign="top"><br><font color="red">*</font><font  face="Arial" color="black" style="font-size: 1.2em;"> FirstName:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="fname" name="fname" value="" onblur="return validateFnm();" class="element text medium" maxlength="255" style="width: 180px; height: 16px;">
					<div><font  size="1em" color="red" ><label id="FnameLabel" style="display:none;">Please Enter First Name</label></font></div>
                        </td>
					</tr>
					<tr>
					<td valign="top"><br><font color="red">*</font><font  face="Arial" color="black" style="font-size: 1.2em;"> LastName:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="lname" name="lname" value=""  onblur="return validateLnm();" class="element text medium" maxlength="255" style="width: 180px; height: 16px;">
					<div><font  size="1em" color="red" ><label id="LnameLabel" style="display:none;">Please Enter Last Name</label></font></div>
					</td>
					</tr>
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">&nbsp;&nbsp;Contact No:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="phno" name="phno" value="" class="element text medium" maxlength="255" style="width: 180px; height: 16px;"></td>
					</tr>
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">&nbsp;&nbsp;Location:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="loc" name="loc" value="" class="element text medium" maxlength="255" style="width: 180px; height: 16px;"></td>
					</tr>
					<tr>
					<td valign="top"><br><font  face="Arial" color="black" style="font-size: 1.2em;">&nbsp;&nbsp;Designation:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="desg" name="desg" value="" class="element text medium" maxlength="255" style="width: 180px; height: 16px;"></td>
					</tr>
					
					
					
					<tr>
					<td valign="top"><br><font color="red">*</font><font  face="Arial" color="black" style="font-size: 1.2em;"> Allocate From:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="allocdate" name="allocdate" readonly="readonly" value="<%=nwfrmtdte %>" 
					onblur="return validatefrom();" class="element text medium" maxlength="255" style="width: 180px; height: 16px;background-color:#E6E6E6" onchange="returnexpdt();">
					<script type="text/javascript">
		 				 Calendar.setup(
		             {
		                 inputField  : "allocdate",         // ID of the input field
		                 ifFormat    : "%d-%b-%Y",     // the date format
		                 button      : "allocdate"       // ID of the button
		             }
		                           );
		</script>
					<div><font  size="1em" color="red" ><label id="Valdate" style="display:none;">Please Enter From Date</label></font></div>
					</td>
					</tr>
					
					
					
					<tr>
					<td valign="top"><br><font color="red">*</font><font  face="Arial" color="black" style="font-size: 1.2em;"> Allocate Till:   </font> </td>
					<td colspan="2" valign="top"><br><input type="text" id="expdate" name="expdate" value="<%=date1 %>" 
					onblur="return datevalidate();" class="element text medium" maxlength="255" style="width: 180px; height: 16px;background-color:#E6E6E6" readonly="readonly">
					<script type="text/javascript">
		 			/*	 Calendar.setup(
		             {
		                 inputField  : "expdate",         // ID of the input field
		                 ifFormat    : "%d-%b-%Y",     // the date format
		                 button      : "expdate"       // ID of the button
		             }
		                           );*/
		</script>
					</td>
					</tr>
					<tr>
					<td valign="top" colspan="1"><br><font  face="Arial" color="black" style="font-size: 1.2em;">
					<input type="radio" value="EndUser" id="trk" class="" name="trk" checked="checked">EndUser  </font></td>
					<td valign="top" colspan="2"><br>
					<font  face="Arial" color="black" style="font-size: 1.2em;">
					<input type="radio" value="Group" id="trk" class="" name="trk" >Group  
					</font></td>
					<%
					if(session.getAttribute("usertypevaluemain").toString().equalsIgnoreCase("IAL_INDIA") || (session.getAttribute("usertypevaluemain").toString().equalsIgnoreCase("ALL") && session.getAttribute("usertypevalue").toString().equalsIgnoreCase("IAL_INDIA")))
					{
					%>
					<td valign="top" colspan="3"><br><font  face="Arial" color="black" style="font-size: 1.2em;">
					<input type="radio" value="IAL" id="trk" class="" name="trk">IAL  </font></td>
				<%
					}
				%>
					
					</tr>
					<tr>
					<td colspan="3" valign="top">
					<br><font color="red">*</font><font  face="Arial" color="black" style="font-size: 1.2em;"> Allocate Vehicles:   </font>
					<input type="hidden" name="UserType" id="UserType" value=""></input>
					 </td>
					</td>
					</tr>
					<tr>
					<td valign="top">
					<br>
					<select name="resources" style="width:160px" size="7" id="resources" multiple="multiple">
					<%
		String sql = "select VehicleRegNumber from db_gps.t_vehicledetails where vehiclecode in "+vehlist+" order by VehicleRegNumber";
		ResultSet rs = st.executeQuery(sql);
		int i=0;
		
		while(rs.next())
		{
			//System.out.println("*******");
			%>
			 <option value="<%=rs.getString("VehicleRegNumber") %>" ><%=rs.getString("VehicleRegNumber") %></option>
					<%
	i++;
	}
	
	%>
</select>
</td>
<td valign="top">
<br>
<div><input type="button" id="add" name="add" class="button"; value="&gt;" onClick="addUser();" />

</div>
<div><input type="button" class="button" value="&lt;" onClick="removeUser()" /></div>
</td>
<td align="center" valign="top">
<br>
<select name="assigned" id="assigned" style="width:160px" size="7" multiple="multiple" onblur="return validateVehicle();" >
	
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
					</form>
					
					<%
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
					</div>
					
					<div id="footer" style="width:100%;">
						<%@ include file="footernew.jsp" %>
					</div>
					</html>
					
	
	
	</jsp:useBean>
	