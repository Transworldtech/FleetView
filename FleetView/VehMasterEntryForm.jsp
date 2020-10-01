<%@ include file="headernew.jsp"%>               
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
<link rel="stylesheet" type="text/css" href="css/view.css" media="all">

<script type="text/javascript">

function removecity(num)
{

	if(num=="6")
	{

		 document.getElementById("tr15").style.display="none";

    }


	else 	
	if(num=="1")
	{
		  document.getElementById("tr9").style.display="none";
	      document.getElementById("element_14").style.display="none";
	      document.getElementById("img1").style.display="none";
		if(document.getElementById("tr10").style.display=="")
		{
			document.getElementById("tr3").style.display="";
		}
		else
		{
			document.getElementById("tr3").style.display="none";
		}
	}
	else
		if(num=="2")
		{
			  document.getElementById("tr10").style.display="none";
		      document.getElementById("element_15").style.display="none";
		      document.getElementById("img2").style.display="none";
			if(document.getElementById("tr9").style.display=="")
			{
				document.getElementById("tr3").style.display="";
			}
			else
			{
				document.getElementById("tr3").style.display="none";
			}
		}
		else
			if(num=="3")
			{
				 document.getElementById("tr8").style.display="none";
			}
			else
				if(num=="4")
				{
					document.getElementById("tr11").style.display="none";
               	   document.getElementById("img4").style.display="none";
               	   document.getElementById("element_23").style.display="none";
					if(document.getElementById("tr12").style.display=="")
					{
						document.getElementById("tr6").style.display="";
					}
					else
					{
						document.getElementById("tr6").style.display="none";
					}
				}
				else
					if(num=="5")
					{
						document.getElementById("tr12").style.display="none";
	               	   document.getElementById("img5").style.display="none";
	               	   document.getElementById("element_24").style.display="none";
						if(document.getElementById("tr11").style.display=="")
						{
							document.getElementById("tr6").style.display="";
						}
						else
						{
							document.getElementById("tr6").style.display="none";
						}
					}
}

function showbox1(num)
{
	//alert("JJJJJ");
	
	if(num=="6")
	{

		 document.getElementById("tr15").style.display="";

    }
	else
		 if(num == "1")
     {
         document.getElementById("tr3").style.display="";
         document.getElementById("tr9").style.display="";
         document.getElementById("element_14").style.display="";
         document.getElementById("img1").style.display="";
     }  
     else
         if(num=="2")
         {
        	 document.getElementById("tr3").style.display="";
        	 document.getElementById("tr10").style.display="";
        	 document.getElementById("img2").style.display="";
        	 document.getElementById("element_15").style.display="";
         }   
         else
             if(num=="3")
             {
            	 document.getElementById("tr8").style.display="";
            	 
             }   
             else
                 if(num=="4")
                 {
                	 document.getElementById("tr6").style.display="";
                	 document.getElementById("tr11").style.display="";
                	 document.getElementById("img4").style.display="";
                	 document.getElementById("element_23").style.display="";
                 }   
                 else
                     if(num=="5")
                     {
                    	 document.getElementById("tr6").style.display="";
                    	 document.getElementById("tr12").style.display="";
                    	 document.getElementById("img5").style.display="";
                    	 document.getElementById("element_24").style.display="";
                     }   
}




function showbox()
{

	
	var state = document.getElementById("element_11").value; 
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			//alert(reslt);
			document.getElementById("element_12").innerHTML=reslt;
		
		} 
	};
	
	var queryString = "?state="+state;
	ajaxRequest.open("GET", "AjaxGetCity.jsp" + queryString, true);
	ajaxRequest.send(null); 
	
	
}

function getVehicleDetails(vehicle)
{
	try
	{
	//alert("in vehicle detail");
	document.getElementById("vehiclelist").style.visibility="hidden";
	document.getElementById("element_1").value=vehicle;	
	}
	catch(e)
	{
		alert(e);
	}
}

function getVehicles(num)
{
	try{
		//alert("Hii");
		var b=0;
		var vehicle=document.getElementById("element_1").value;
		 if(vehicle.length>0)
		    {
			document.getElementById("vehiclelist").style.visibility="visible";

			if(num==1)
			{
				counter=20;
			}
			else if(num==2)
			{
				counter=0;
			}
			
			var ajaxRequest;  // The variable that makes Ajax possible!
			try{
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
			ajaxRequest.onreadystatechange = function()
			{
				if(ajaxRequest.readyState == 4)
				{
					var reslt=ajaxRequest.responseText;
					//alert(reslt);
					document.getElementById("vehiclelist").innerHTML=reslt;
				//	var b=document.getElementById("element").value;
					//alert("b "+b);
				//	document.userform.counter.value=b;
					//alert("counter "+document.userform.counter.value);
				//	document.userform.counter.value=b*document.userform.counter.value;
					//counter=document.userform.counter.value;
					//alert("counter "+counter);
				} 
			};
			
			var queryString = "?Vehicle="+vehicle+"&limitcount="+counter+"";
			ajaxRequest.open("GET", "AjaxGetVehicles.jsp" + queryString, true);
			ajaxRequest.send(null); 
		    }
		    else
		    {
		    	document.getElementById("vehiclelist").style.visibility="hidden";
		    }
	}
	catch(e)
	{
		alert(e);
	}
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
	var date1=document.getElementById("element_18").value;
	var date2=document.getElementById("element_21").value;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	mm1=date1.substring(3,6);
	mm11=dateformat(mm1);
	yy11=date1.substring(7,11);
	dd12=date2.substring(0,2);
	mm2=date2.substring(3,6);
	mm12=dateformat(mm2);
	yy12=date1.substring(7,11);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	if(yy11>year || yy12>year)
	{
		return 0;
	}
	else if(year==yy11 && year==yy12)
	{
			if(mm11>month || mm12>month)
		{
			return 0;
		}
	}
	if(mm11==month && mm12==month)
	{
		if(dd11>day || dd12>day)
		{
			return 0;
		}
	}
	return 1;
}


function validate()
{
	try
	{
	var vehregno = document.getElementById("element_1").value;
	var owner = document.getElementById("element_5").value;
	var osrno = document.getElementById("element_6").value;
	var RTO = document.getElementById("element_23").value;
	var RCBook = document.getElementById("element_22").value;
	//var body = document.getElementById("element_33").value;
	var secap = document.getElementById("element_37").value;
	var sacap = document.getElementById("element_38").value;
	 var tyres = document.getElementById("element_39").value;
	 var vin = document.getElementById("element_28").value;
	 var gear = document.getElementById("element_27").value;
	 var chassis = document.getElementById("element_26").value;
	var engine = document.getElementById("element_25").value;	 
	var unladewt = document.getElementById("element_29").value;
	 var RLW = document.getElementById("element_30").value;
	   var GVW = document.getElementById("element_31").value;
     var length1 = document.getElementById("element_34").value;
     var breadth = document.getElementById("element_35").value;
     var width = document.getElementById("element_36").value;
	   var pin=document.getElementById("element_13").value;
	   
    var splitted =  vehregno.match("[!@#$%^&*()_,.<>;:]");
     var splitted1 = owner.match("[!@#$%^&*()_,<>;:]");
    
    var flag = "true";

    var err="";
    var err1="";
    var err2="";
    var err3="";
    var error="";
    var err11=" Please enter";
    var err12=" should not contain any special characters";
    var err13=" Length of";
    var err14=" should be greater than 5 characters.";
    var err15 =" should be numeric";
	if(vehregno == "Select")
	{
		err += ", Vehicle Registration No";
		//alert("Please select the Vehicle Registeration No");
		//return false;
			flag = "false";
	}

    if(splitted!=null)
    {
    	err1 += "& Vehicle Registration No ";
    	//alert("Invalid Registration No.");
		//return false;
		flag = "false";
    }
	
	//if(body == "Select")
	//{
	//	err = err+", type of body";
		//alert("Please select Type of body");
//		flag = "false";
//	}
	
	 if(owner == "")
	{
		 err = err+", Owner Name";
		//alert("Please select the Owner Name");
		 flag = "false";
	}
	 if(splitted1!=null)
	    {
		 err1 = err1+"& Owner Name ";
	    	///alert("Invalid Owner Name");
			 flag = "false";
	    }
		
	 if(chassis == "")
	{
		 err = err+", Chassis No";
			//alert("Please select the Chassis No");
		 flag = "false";
	}
	// alert(chassis.length);
	 if(engine == "")
	{
		 err = err+", Engine No";
		//alert("Please select the Engine No");
		 flag = "false";
	}
		
	 if(chassis.length< "5" && chassis.length>0)
	 {
		 err2 = err2+"& Chassis No ";
		 //alert("Invalid Chassis No");
		 flag = "false";
	 }

	 if(engine.length< "5" && engine.length>0)
	 {
		 err2 = err2+"& Engine No";
		 //alert("Invalid Engine No");
		 flag = "false";
	 }
	 
	 if(isNaN(osrno) &&  osrno.length>0)
	 {
		 err3 = err3+", Owner No";
		 //alert("Invalid Owner No");
		 flag = "false";
	 }
	 if(isNaN(length1) &&  length1.length>0)
	 {
		 err3 = err3+", Length";
		 //alert("Invalid Owner No");
		 flag = "false";
	 }
	 if(isNaN(breadth) &&  breadth.length>0)
	 {
		 err3 = err3+", Breadth";
		 //alert("Invalid Owner No");
		 flag = "false";
	 }
	 if(isNaN(width) &&  width.length>0)
	 {
		 err3 = err3+", Width should be numeric";
		 //alert("Invalid Owner No");
		 flag = "false";
	 }
	 if(isNaN(secap) &&  secap.length>0)
	 {
		 err3 = err3+", Seating Capacity should be numeric";
		// alert("Seating Capacity should be numeric");
		 flag = "false";
	 }
	 if(isNaN(sacap) &&  sacap.length>0)
	 {
		 err3 = err3+", Standing Capacity should be numeric";
		// alert("Standing Capacity should be numeric");
		 flag = "false";
	 }

	 if(isNaN(pin) &&  pin.length>0)
	 {
		 err3 = err3+", Pincode";
		 //alert("No of tyres should be numeric");
		 flag = "false";
	 }
		
	 if(isNaN(tyres) &&  tyres.length>0)
	 {
		 err3 = err3+", No of tyres";
		 //alert("No of tyres should be numeric");
		 flag = "false";
	 }
	 if(isNaN(unladewt) &&  unladewt.length>0)
	 {
		 err3 = err3+", Unladen WT";
		// alert("Unladen WT should be Numeric");
		 flag = "false";
	 }
	 
	 if(isNaN(gear) && gear.length>0)
	 {
		 err3 = err3+", Gear No";
		// alert("Invalid Gear No");
		 flag = "false";
	 }
	 
	 if(isNaN(RLW) && RLW.length>0)
	 {
		 err3 = err3+", RLW No";
		 //alert("Invalid RLW No");
		 flag = "false";
	 }
	 if(isNaN(GVW) && GVW.length>0)
	 {
		 err3 = err3+", GVW No";
		// alert("Invalid GVW No");
		 flag = "false";
	 }

	 if(isNaN(vin) && vin.length>0)
	 {
		 err3 = err3+", VIN No";
		// alert("Invalid GVW No");
		 flag = "false";
	 }
		
	 if(isNaN(RCBook) && RCBook.length>0)
	 {
		 err3 = err3+", RCBook No";
		// alert("Invalid RCBook No");
		 flag = "false";
	 }

	   if(err.length>0)
       {
           error = error+""+err11+" "+err.substring('1',err.length)+"\n";
       }
       
       if(err1.length>0)
       {
           error = error+""+err1.substring('1',err1.length)+""+err12+"\n";
       }

       if(err2.length>0)
       {
           error = error+""+err13+""+err2.substring('1',err2.length)+""+err14+"\n";
       }

       if(err3.length>0)
       {
           error = error+""+err3.substring('1',err3.length)+""+err15+"\n";
       }
       
       var datevalidate1 =  datevalidate();
       
       if(datevalidate1 == 0)
       {
           
    	   error = error+" Selected Date should not be greater than todays date";
           flag = "false";
       }
       
     //  alert(error);
	 if(flag=="false")
	 {
		 alert(error);
		 return false;
	 }
	 else
		 if(flag=="true")
		 {
			 return true;
		 }
	
	
	/*if(owner.length == 0)
	{
		alert("Please select the Owner Name");
		return false;
	}*/
	}
	catch(e)
	{
		alert(e);
	}
}

function attach()
{
	 document.getElementById("element_46").style.display="";
	 document.getElementById("f5").style.display="none";
	 document.getElementById("remove3").style.display="";
	 document.getElementById("f3").style.display="none";
}

function upload(num)
{
	if(num==1)
	{
	  var name1= document.getElementById("element_43").value;
	 // alert(name1);
	  document.getElementById("element_43").style.display="none";
	  document.getElementById("f1").innerHTML=name1;
	  document.getElementById("f1").style.display="";
	  document.getElementById("f6").value=name1;
	  document.getElementById("remove1").style.display="";
	}
	else
		if(num==2)
		{
		  var name1= document.getElementById("element_44").value;
		  document.getElementById("element_44").style.display="none";
		  document.getElementById("f2").innerHTML=name1;
		  document.getElementById("f2").style.display="";
		  document.getElementById("f7").value=name1;
		  document.getElementById("remove2").style.display="";
		  
		}
		else
			if(num==3)
			{
                // alert(num);
				try
				{
				var name1= document.getElementById("element_46").value;
				document.getElementById("element_46").style.display="none";
				document.getElementById("f5").innerHTML=name1;
				document.getElementById("f8").value=name1;
				document.getElementById("f5").style.display="";
				document.getElementById("remove3").style.display="";
				}
				catch(e)
				{
					alert(e);
				}
			}
}

function remove(num)
{
	if(num==1)
	{
		document.getElementById("f1").innerHTML="";
		document.getElementById("f1").style.display="none";
		document.getElementById("remove1").style.display="none";
		document.getElementById("element_43").value="";
		document.getElementById("f6").value="";
		document.getElementById("element_43").style.display="";
	}
	else
		if(num==2)
		{
			document.getElementById("f2").innerHTML="";
			document.getElementById("f2").style.display="none";
			document.getElementById("remove2").style.display="none";
			document.getElementById("element_44").value="";
			document.getElementById("f7").value="";
			document.getElementById("element_44").style.display="";
		}
		else
			if(num==3)
			{
				document.getElementById("element_46").value = "";
				document.getElementById("element_46").style.display="none";
				document.getElementById("f5").innerHTML = "";
				document.getElementById("f8").value="";
				document.getElementById("f5").style.display="none";
				document.getElementById("f3").style.display = "";
				document.getElementById("remove3").style.display="none";
			}
}
</script>
</head>
<body id="main_body" >
	<%
	String Msg = request.getParameter("Msg");
	if(Msg!=null && Msg.equalsIgnoreCase("5"))
	{
	%>
	<script>
			alert("Added Successfully.....");
	</script>
	<%
	}
	else
	if(Msg!=null && Msg.equalsIgnoreCase("1"))
	{
		%>
		<script>
		   alert("Vehicle already exist!!!");
		</script>
		<%
	}
	else
		if(Msg!=null && Msg.equalsIgnoreCase("6"))
		{
			%>
			<script>
			   alert("Error occured while storing data!!\nPlease Re-enter the data!!");
			</script>
			<%
		}
		else
			if(Msg!=null && Msg.equalsIgnoreCase("2"))
			{
				%>
				<script>
				   alert("Engine No. already exist!!!");
				</script>
				<%
			}
			else
				if(Msg!=null && Msg.equalsIgnoreCase("3"))
				{
					%>
					<script>
					alert("Chassis No. already exist!!!");
					</script>
					<%
				}
				else
					if(Msg!=null && Msg.equalsIgnoreCase("4"))
					{
						%>
						<script>
						alert("VIN No. already exist!!!");
						</script>
						<%
					}
	%>
	<img id="top" src="newimages/top.png" alt="">
	
	<div id="form_container">
	
		<h1 align="center"><a>Vehicle Master Entry</a></h1>
		<br>
		<form id="form_370051" class="appnitro" enctype="multipart/form-data" method="post" action="VehMasterInsert.jsp" onsubmit="return validate();">
					<div class="form_container">
			<%
		try {
				//System.out.println("$$$$$$$$$   ");
				Class.forName(MM_dbConn_DRIVER);
				con1 = fleetview.ReturnConnection();
				Statement st = con1.createStatement();
				String vehlist = session.getAttribute("VehList").toString();
				String nwfrmtdte = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
				//String FileUploadPath =getServletContext().getInitParameter("configuredUploadDir"); 
				//out.println("FileUploadPath   "+FileUploadPath);
				//File uploadDir = new File(FileUploadPath);
				//out.println("IIIIIII  "+uploadDir.toString());
				%>
			<p></p>
		</div>						
			<ul >
			<font size="3" style="margin-left: 0.4em;">Vehicle Details</font>
			<div width="100%" align="center"  style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
			<table border="0" width="100%" align="center">
			
			
			
			
			<tr>
			<td colspan="1" style="width: 30%;">
			<div>		
		 <li id="li_1">
		<label class="description" for="element_1" style="width: 170px;"><font size="2">Vehicle Registration No *</font></label>
		<div><font color="#00000">
	<!-- 	<input id="element_1" name="element_1" autocomplete="off" class="element text medium" type="text" maxlength="255" value=""
			style="width: 150px; height: 16px;" onkeyup="getVehicles(1)" /> </font> -->
		
		
		 <select class="element select medium" id="element_1" name="element_1" style="width: 150px; height: 20px;"> 
		<option value="Select" selected="selected">Select</option>
		<%
		String sqlregno = "select VehicleRegNumber from db_gps.t_vehicledetails where vehiclecode in "+vehlist+" order by VehicleRegNumber";
	//	String sqlregno="select VehicleRegNumber  from db_gps.t_vehicledetails where Replace(Replace( Replace( Replace( VehicleRegNumber ,'.', '') ,' ','') ,'-','') ,'_','') vehiclecode in "+vehlist+" order by VehicleRegNumber";
		
		ResultSet rsregno = st.executeQuery(sqlregno);
		while(rsregno.next())
		{
			System.out.println("*******");
			%>
			<option value="<%=rsregno.getString("VehicleRegNumber") %>" ><%=rsregno.getString("VehicleRegNumber") %></option>
			<%
      }
		%>
		 </select>
		</div> 
		</li>
		</div>	
		</td>
		<td align="left"  rowspan="1" style="width: 10%;"> 
		
		<div style='height:63px;width:100px;overflow:auto; align:left; margin-left: -66px; position: absolute;' id="vehiclelist"><table style='display: block;'>
		</table></div>
		<br></br><br></br><br></br>
		</td>
		
		
		
		<td colspan="1" style="width: 15em;">
		<div style="width: 15%; margin-left: -2em" id="li_2">
		<label class="description" for="element_2" style="width: 150px;"><font size="2">Vehicle type</font></label>
		<div>
		     <select class="element select medium" id="element_2" name="element_2" style="width: 150px; height: 20px;">
		      <option value="Select" selected="selected">Select</option>
		     
			<%
			String sql1 = "select distinct(VehType) from db_gps.t_VehType";
			ResultSet rs1 = st.executeQuery(sql1);
			
			while(rs1.next())
			{
				%>
				<option value="<%=rs1.getString("VehType") %>" ><%=rs1.getString("VehType") %></option>
				<%
			}
			%>
			</select>
                      <a href="javascript: showbox1(6);">Add Vehicle type</a>
		</div>
		</td>
		
		
		
		
		<td style="width: 15em">
		<div style="width: 15%; margin-left: 1em" id="li_3">
		<label class="description" for="element_3" style="width: 150px;"><font size="2">Usage</font></label>
		<div>
		     <select class="element select medium" id="element_3" name="element_3" style="width: 150px; height: 20px;">
		      <option value="Select" selected="selected">Select</option>
		      <option value="Private" >Private</option>
		      <option value="Commercial">Commercial</option>
		      </select>
		</div>
		</td>
		</tr>
		
		
		
	<tr style="display: none;" id="tr15" align="center">
		<td  id="tr16" colspan="3">
		<div style="width: 10em; margin-left:-13em">		
		<li id="" style="width: 190px;">
		  <label class="description" for="element_50"  style="width: 170px;" ><font size="2">Add Vehicle Type </font></label>
		
		
			<input id="element_50" name="element_50" class="element text medium" type="text" maxlength="255" value="" style="width: 130px; height: 16px;"/> 
		<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity(6);" id="img3" align="top">
		</li>
		<br></br><br>
		</div>
		</td>
		</tr>	
		
		
		
		<tr>
	  <td align="left" colspan="4" style="width: 30%;">	
	 <div id="li_4" style="width: 800px;margin-left: 0.9em">
		<label class="description" for="element_4" style="width: 150px;"><font size="2">Registered Owner *</font></label>
		<div>
		     <select class="element select medium" id="element_4" name="element_4" style="width: 45px; height: 20px;">
		      <option value="Mr." selected="selected">Mr.</option>
		      <option value="Mrs." >Mrs.</option>
		      <option value="Ms.">Ms.</option>
		      <option value="Dr.">Dr.</option>
		      <option value="M/s.">M/s.</option>
		      </select>
		     &nbsp;&nbsp;
			<input id="element_5" name="element_5" class="element text medium" type="text" maxlength="255" value=""
			style="width: 400px; height: 16px;" /> 
		</div> 
		</div>
		
		</td>
		</tr>
		<tr>
		<td colspan="1" >
		 <li id="li_5" style="width: 100px;"  style="width: 30%;">
		<label class="description" for="element_6" style="width: 150px;"><font size="2">Owner SrNo </font></label>
		<div>
			<input id="element_6" name="element_6" class="element text medium" type="text" maxlength="255" value=""
			style="width: 120px; height: 16px;"  /> 
		</div> 
		</li>	</td>
		<td colspan="3">
		<li id="li_6" style="width: 170px;margin-left: -2.8em;">
		<label class="description" for="element_7" style="width: 150px;"><font size="2">Company/Group </font></label>
		<div>
			<input id="element_7" name="element_7" class="element text medium" type="text" maxlength="255" value="" style="width: 400px; height: 18px;"/> 
		</div> 
		</li></td>
		</tr>
		<tr>
		<td colspan="1"  style="width: 30%;">
		<div  style="width: 10em;">
		<li id="li_7">
		<label class="description" for="element_8" style="width: 170px;"><font size="2">Address1 </font></label>
		<div>
			<input id="element_8" name="element_8" class="element text medium" type="text" maxlength="255" value="" style="width: 200px; height: 16px;"></input> 
		</div> 
		</li></div></td>
		<td  style="width: 10%;"></td>
		<td colspan="1" style="width: 5em;">
		<div style="width: 15%;margin-left: -5em;">
		<li id="li_8" >
		<label class="description" for="element_9" style="width: 150px;"><font size="2">Address2 </font></label>
		<div>
			<input id="element_9" name="element_9" class="element text medium" type="text" maxlength="255" value="" style="width: 200px; height: 16px;"></input> 
		</div> 
		</li></div></td>
		<td colspan="1" style="width: 15em;">
		<div  style="width: 15%">
		<li id="li_9">
		<label class="description" for="element_10" style="width: 150px"><font size="2">Address3 </font></label>
		<div>
			<input id="element_10" name="element_10" class="element text medium" type="text" maxlength="255" value="" style="width: 200px; height: 16px;"></input> 
		</div> 
		</li></div></td>
		</tr>
		
		
		
		<tr>
		<td colspan="1" style="width: 5em;">
		<div style="width: 15%;">
		<li id="li_10"   style="width: 150px;">
		<label class="description" for="element_11" style="width: 170px;"><font size="2">State </font></label>
		<div>
		<select class="element select medium" id="element_11" name="element_11" style="width: 150px; height: 20px;" onchange="showbox();"> 
			<option value="Select" selected="selected"></option>
			<%
			try{
			String sql = "Select distinct(State) as state from db_gps.t_citystctryinfo  where country = 'India' order by state";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				%>
				<option value="<%=rs.getString("state") %>" ><%=rs.getString("state") %></option>
				<%
			}
			}
			catch(Exception e)
			{
				System.out.println("^^^^^^^6    Exception    "+e);
			}
			%>
			
		</select>
		
		<a href="javascript: showbox1(1);">Add State</a>
		</div> 
		</li>
		</div>	
		</td>
	
	
	
		<td colspan="1" style="width: 10%;">
		<div style="width: 10em;margin-left: -3em;">
		<li id="li_11" style="margin-left: 7.4em;">
		<label class="description" for="element_12" style="width: 150px;"><font size="2">City </font></label>
		<div>
		<select class="element select medium" id="element_12" name="element_12" style="width: 150px; height: 20px;"> 
			<option value="Select" selected="selected"></option>
			
		</select>
		<a href="javascript: showbox1(2);">Add City</a>
		</div> 
		</li>
		</div>	
		</td>
		<td></td>
		
		<td style="width: 15em;">
		<div style="width: 15%;margin-left: 1em"  id="li_12">
		
		<label class="description" for="element_13" style="width: 150px;"><font size="2">PinCode </font></label>
		<div>
			<input id="element_13" name="element_13" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 14px;"></input> 
		</div>
		<br>
	
		</div>
		</td>
		</tr>
		
		
		<tr style="display: none;" id="tr3">
		<td  id="tr1" colspan="1">
		<div style="width: 10em;">		
		<li id="li_13" style="width: 190px;">
		<label class="description" for="element_14" id="tr9" style="width: 150px;display: none"><font size="2">Add State </font></label>
		
			<input id="element_14" name="element_14" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 16px;display: none"/> 
		<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity(1);" id="img1" align="top" style="display: none">
		</li>
		<br></br><br>
		</div>
		</td>
		
		
		<td style="width: 10%;"></td>
		
		<td id="tr2" colspan="1">
		<li id="li_14" style="width: 190px; margin-left: -3em;">
		<label class="description" for="element_15" id="tr10" style="width: 150px;display: none"><font size="2">Add City </font></label>
		<div>
			<input id="element_15" name="element_15" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 16px;display: none"/> 
		<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity(2);" id="img2" align="top" style="display: none">
		
		</div> 
		<br>
		</li>
		
		
		
		
		
		
		
		</td>
		<td  style="width: 15em;"></td>
		</tr>
		
		</table>
		</div>
		<br></br>
		<font size="3" style="margin-left: 0.4em;">Manufacturing Details</font>
		<br>
		<div width="100%" align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		<table border="0" width="100%" align="center">
		<tr>
		<td align="left" style="width: 42%">	
	    <div id="li_15" style="width: 120px;margin-left: 0.9em;">
		<label class="description" for="element_16" style="width: 170px;"><font size="2">Manufacturer Name/Make</font></label>
		<div> 
		<select class="element select medium" id="element_16" name="element_16" style="width: 150px; height: 20px;"> 
			<option value="Select" selected="selected">Select</option>
			<%
			String sql = "select distinct(Manufacturer) from db_gps.t_VehMnf";
			ResultSet rs = st.executeQuery(sql);
			
			while(rs.next())
			{
				%>
				<option value="<%=rs.getString("Manufacturer") %>" ><%=rs.getString("Manufacturer") %></option>
				<%
			}
			%>
			</select>
		</div> 
		<a href="javascript: showbox1(3);">Add Manufacturer Name</a>
		</div>
		
		
		
		
		
		
		
		</td>
		<td colspan="1" style="width: 30%">
		<li id="li_16" style="width: 20px;margin-left: -1.2em;">
		<label class="description" for="element_17" style="width: 150px;"><font size="2">Model </font></label>
		<div>
			<input id="element_17" name="element_17" class="element text medium" type="text" maxlength="255" value=""
			style="width: 150px; height: 16px;"/> 
		</div> 
		</li>
		</td>
		<td colspan="1" style="width: 15em">
		<div style="width: 10%; margin-left: 6em;">
		<li id="li_17">
		
		<label class="description" for="element_18" style="width: 150px;"><font size="2">Date Of Manufacture </font></label>
		<input type="text" id="element_18" name="element_18"  size="13" value="<%=nwfrmtdte %>" class="element text medium" 
		 style="width: 150px; height: 16px;"   readonly />
		<script type="text/javascript">
		  Calendar.setup(
		             {
		                 inputField  : "element_18",         // ID of the input field
		                 ifFormat    : "%d-%b-%Y",     // the date format
		                 button      : "element_18"       // ID of the button
		             }
		                           );
		</script>
		</li>	
		</div>
		</td>
		</tr>
		
		<tr style="display: none;" id="tr8">
		<td  id="tr7" colspan="1">
		<div style="width: 10em;">		
		<li id="li_44" style="width: 190px;">
		<label class="description" for="element_45"  style="width: 170px;"><font size="2">Add Manufacturer Name </font></label>
		
			<input id="element_45" name="element_45" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 16px;"/> 
		<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity(3);" id="img3" align="top">
		</li>
		<br></br><br>
		</div>
		</td>
		</tr>
		
		</table>
		</div>
		
		<br>
		<font size="3" style="margin-left: 0.4em;">RTO Details</font>
		<br>
		<div width="100%" align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		<table border="0" width="100%" align="center">
		<tr>
		<td style="width: 20%">
		<div>
		<li id="li_18" style="width: 170px;">
		<label class="description" for="element_19" style="width: 150px;"><font size="2">RTO Name </font></label>
		<div>
			
			<select class="element select medium" id="element_19" name="element_19" style="width: 150px; height: 20px;"> 
			<option value="Select" selected="selected">Select</option>
			<%
			sql = "select distinct(City) from db_gps.t_citystctryinfo order by City";
			rs = st.executeQuery(sql);
			while(rs.next())
			{
				%>
				<option value="<%=rs.getString("City") %>"><%=rs.getString("City") %></option>
				<%
			}
			
			sql = "select distinct(RTOName) from db_gps.t_RTONames order by RTOName";
			rs = st.executeQuery(sql);
			while(rs.next())
			{
				%>
				<option value="<%=rs.getString("RTOName") %>"><%=rs.getString("RTOName") %></option>
				<%
			}
			%>
			</select>
		<a href="javascript: showbox1(4);">Add RTO</a>
		</div> 
		</li>
		</div>
		</td>
		<td style="width: 20%">
		<div>
		<li id="li_19" style="width: 170px;">
		<label class="description" for="element_20" style="width: 150px;"><font size="2">RTO State </font></label>
		<div>
			
		<select class="element select medium" id="element_20" name="element_20" style="width: 150px; height: 20px;"> 
			<option value="Select" selected="selected">Select</option>
		<%
		sql = "Select distinct(State) as state from db_gps.t_citystctryinfo  where country = 'India' order by state";
		rs = st.executeQuery(sql);
		while(rs.next())
		{
			%>
			<option value="<%=rs.getString("State") %>"><%=rs.getString("State") %></option>
			<%
		}
		%>
		</select>
		<a href="javascript: showbox1(5);">Add RTO State</a>
		</div> 
		</li>
		</div>
		</td>
		<td>
		<div>
		<li id="li_20" style="width: 120px">
		<label class="description" for="element_21" style="width: 150px;"><font size="2">Date Of Registration </font></label>
		<input type="text" id="element_21" name="element_21"  size="13" value="<%=nwfrmtdte %>" class="element text medium" 
		 style="width: 150px; height: 16px;"   readonly />
		<script type="text/javascript">
		  Calendar.setup(
		             {
		                 inputField  : "element_21",         // ID of the input fishowbox1(3);eld
		                 ifFormat    : "%d-%b-%Y",     // the date format
		                 button      : "element_21"       // ID of the button
		             }
		                           );
		</script>
		</li>	
		<br>
		<br>
		</div>
		</td>
		<td colspan="1" style="width: 20%">
		<div>
		<li id="li_21" style="width: 170px;">
		<label class="description" for="element_22" style="width: 150px;"><font size="2">RC Book No/Card</font></label>
		<div>
			<input id="element_22" name="element_22" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 16px;"/> 
		</div> 
		</li>
		<br>
		<br>
		</div>
		</td>
		</tr>
		<tr>
		<tr style="display: none;" id="tr6">
		<td  id="tr4" colspan="1">
		<div style="width: 10em;">		
		<li id="li_22" style="width: 190px;">
		<label class="description" for="element_23"  id="tr11" style="width: 150px;display: none"><font size="2">Add RTO Name </font></label>
		
			<input id="element_23" name="element_23" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 16px;display: none"/> 
		<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity(4);" id="img4" align="top" style="display: none">
		</li>
		<br></br><br>
		</div>
		</td>
		<td style="width: 10%;"></td>
		
		<td id="tr5" colspan="3">
		<li id="li_23" style="width: 190px; margin-left: -17em;">
		<label class="description" for="element_24" id="tr12" style="width: 150px;display: none"><font size="2">Add RTO State </font></label>
		<div>
			<input id="element_24" name="element_24" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 16px;display: none"/> 
		
		
		<img alt="Delete" src="newimages/Delete-Icon.png" onclick="removecity(5);" id="img5" align="top" style="display: none">
		
		</div> 
		<br>
		</li>
		
		</td>
		</tr>
		</table>
		</div>
		<br>
		<font size="3" style="margin-left: 0.4em;">Engine Details</font>
		<br>
		<div width="100%" align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		<table border="0" width="100%" align="center">
		<tr>	
		<td colspan="1">
		<li id="li_24" style="width: 170px;" >
		<label class="description" for="element_25" style="width: 150px;"><font size="2">Engine No *</font></label>
		<div>
			<input id="element_25" name="element_25" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 18px;"/> 
		</div> 
		</li></td>
		<td colspan="1">
		<li id="li_25" style="width: 170px;">
		<label class="description" for="element_26" style="width: 150px;"><font size="2">Chassis No *</font></label>
		<div>
			<input id="element_26" name="element_26" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li></td>
		<td colspan="1">
		<li id="li_26" style="width: 170px;margin-left: 1.3em">
		<label class="description" for="element_27" style="width: 150px;"><font size="2">Gear Box No  </font></label>
		<div>
			<input id="element_27" name="element_27" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li></td>
		<td>
		<li id="li_27" style="width: 170px;">
		<label class="description" for="element_28" style="width: 150px;"><font size="2">VIN No </font></label>
		<div>
			<input id="element_28" name="element_28" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li></td>
		</tr>
		<tr>
		<td colspan="1">
		<li id="li_28" style="width: 170px;">
		<label class="description" for="element_29" style="width: 150px;"><font size="2">Unladen WT (KG)</font></label>
		<div>
			<input id="element_29" name="element_29" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li></td>
		<td>
		<li id="li_29" style="width: 170px;">
		<label class="description" for="element_30" style="width: 150px;"><font size="2">RLW (KG)</font></label>
		<div>
			<input id="element_30" name="element_30" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li></td>
		
		<td colspan="1">
		<li id="li_30" style="width: 170px;margin-left: 1.2em;">
		<label class="description" for="element_31" style="width: 150px;"><font size="2">GVS </font></label>
		<div>
			<input id="element_31" name="element_31" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li></td>
		
		<td>
		<li id="li_31"    style="width: 170px;">
		<label class="description" for="element_32" style="width: 150px;"><font size="2">Class </font></label>
		<div>
		<select class="element select medium" id="element_32" name="element_32" style="width: 150px; height: 22px;"> 
			<option value="Select" selected="selected">Select</option>
			<%
			try
			{
				 sql ="Select VClass from db_gps.t_VehicleClass order by VClass";
				 rs = st.executeQuery(sql);
				 while(rs.next())
				 {
					 %>
					 <option value="<%=rs.getString("VClass") %>" ><%=rs.getString("VClass") %></option>
					 <%
				 }
				
			}
			catch(Exception e)
			{
				System.out.println("Exception---------->   class    "+e);
				e.printStackTrace();
			}
			%>
		</select>
		</div> 
		</li>	
		</td>
		</tr>
		<tr>
		<td colspan="1">
		<li id="li_32"  style="width: 170px;">
		<label class="description" for="element_33" style="width: 150px;"><font size="2">Type Of Body </font></label>
		<div>
		<select class="element select medium" id="element_33" name="element_33" style="width: 150px; height: 20px;"> 
			<option value="Select" selected="selected">Select</option>
			<option value="Open">Open</option>
			<option value="Enclosed">Enclosed</option>
			<option value="Enclosed and Lockable">Enclosed and Lockable</option>
			<option value="Trailer-High Bed">Trailer-High Bed</option>
			<option value="Trailer-Low Bed">Trailer-Low Bed</option>
			<option value="Trailer-Semi-Low Bed">Trailer-Semi-Low Bed</option>
			<option value="Gas Tanker">Gas Tanker</option>
			<option value="Oil Tanker">Oil Tanker</option>
			<option value="Chemical Tanker">Chemical Tanker</option>
		</select>
		</div>
		</li>
		</td>
		<td colspan="1" width="20%">
		<div id="li_33"  style="width: 20px; margin-left: 0.9em;">
		<label class="description" for="element_34" style="width: 150px;"><font size="2">Length(meters) </font></label>
		<div>
			<input id="element_34" name="element_34" class="element text medium" type="text" maxlength="255" value=""
			style="width: 100px; height: 16px;"/> 
		</div> 
		</div>
		</td>
		<td>
		<div id="li_34"  style="width: 170px;margin-left: 2em;">
		<label class="description" for="element_35" style="width: 150px;"><font size="2">Breadth(meters) </font></label>
		<div>
			<input id="element_35" name="element_35" class="element text medium" type="text" maxlength="255" value=""
			style="width: 100px; height: 16px;"/> 
		</div> 
		</div>
		</td>
		<td colspan="1">
		<div id="li_35"  style="width: 170px;margin-left: 0.8em;">
		<label class="description" for="element_36" style="width: 150px;"><font size="2">Width(meters) </font></label>
		<div>
			<input id="element_36" name="element_36" class="element text medium" type="text" maxlength="255" value=""
			style="width: 100px; height: 16px;"/> 
		</div> 
		</div>
		</td>
		</tr>
				<tr>
		<td>
		<li id="li_36" style="width: 170px;">
		 <label class="description" for="element_37" style="width: 150px;"><font size="2">Seating Capacity </font></label>
		<div>
			<input id="element_37" name="element_37" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li>	
		</td>
		<td colspan="1">
		<li id="li_37" style="width: 170px;">
		<label class="description" for="element_38" style="width: 150px;"><font size="2">Standing Capacity</font> </label>
		<div>
			<input id="element_38" name="element_38" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li>	
		</td>
		<td>
			<li id="li_38" style="width: 170px;margin-left: 1.2em;">
		<label class="description" for="element_39" style="width: 150px;"><font size="2">No of Tyres </font></label>
		<div>
			<input id="element_39" name="element_39" class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;"/> 
		</div> 
		</li>
		</td>
		<td colspan="1">
		<li id="li_39"  style="width: 170px;">
		<label class="description" for="element_40" style="width: 150px;"><font size="2">No of Cylinder </font></label>
		<div>
			
		    <select class="element select medium" id="element_40" name="element_40" style="width: 150px; height: 20px;"> 
			<%
			for(int i=1;i<=12;i++)
			{
				if(i==4)
				{
					
				%>
				<option value="<%=i %>" selected><%=i %></option>
				<%
				}
				else
				{
					%>
					<option value="<%=i %>"><%=i %></option>
					<%
				}
			}
			%>
		</select>
		</div>
		</li></td>
		</tr>
		
		
		</tr>
		<tr>
		<td>
		 <li id="li_40" style="width: 170px;">
		<label class="description" for="element_41" style="width: 150px;"><font size="2">Color </font></label>
		<div>
			<select class="element select medium" id="element_41" name="element_41" style="width: 150px; height: 22px;"> 
			<option value="Select" selected="selected">Select</option>
			<%
			 sql ="select color from db_gps.t_colors";
			 rs = st.executeQuery(sql);
			while(rs.next())
			{
				%>
				<option value="<%=rs.getString("Color") %>"><%=rs.getString("Color") %></option>
				<%
			}
			%>
		</select>
		</div> 
		</li>	
		</td>
		<td colspan="3">
		<li id="li_41"  style="width: 170px;">
		<label class="description" for="element_42" style="width: 150px;"><font size="2">Fuel </font></label>
		<div>
		<select class="element select medium" id="element_42" name="element_42" style="width: 150px; height: 22px;"> 
			<option value="Select" selected="selected">Select</option>
			<option value="Diesel">Diesel</option>
			<option value="Petrol">Petrol</option>
			<option value="LPG">LPG</option>
			<option value="CNG">CNG</option>
			<option value="Electric">Electric</option>
			
		</select>
		</div> 
		</li></td>
		</tr>
		</table>
		</div>
		<br></br>
		<font size="3" style="margin-left: 0.4em;">Upload Documents</font>
		<br>
		<div width="100%" align="center" style="background: url(newimages/main_col_bg1.png) no-repeat top left #f8fcff">
		<table border="0" width="100%" align="center">
		<tr style="display:">
		<td colspan="2" valign="middle">
		<li id="li_42" style="width: 170px;">
		<label class="description" for="element_43" style="width: 150px;"><font size="2">Upload RC Book </font></label>
		<br>
		<div>
		<input type="file" cols="20" name="element_43" id="element_43" value="" onchange="upload(1);" style="background-image: newimages/browse.jpg"/>
		<font size="2" face="Arial" color="black" id="f1" style="display:none;" name = "f1"></font>
		&nbsp;&nbsp;<a href="#" onclick="remove(1)" id="remove1" style="display: none;"><font size="2" face="Arial">Remove</font></a>
		<br><a href="#" onclick="attach();" style="display: " id="f3"><font size="2" face="Arial">AttachMoreFiles </font></a>
		<input id="f6" name=f6 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		<input type="file" cols="20" name="element_46" id="element_46" value="" onchange="upload(3);" style="background-image: newimages/browse.jpg;display: none;"/>
		<font size="2" face="Arial" color="black" id="f5" style="display:none;" name = "f5"></font>
		&nbsp;&nbsp;<a href="#" onclick="remove(3)" id="remove3" style="display: none;"><font size="2" face="Arial">Remove</font></a>
		<input id="f8" name=f8 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		</div>
		</li>
		</td>
		<td colspan="2" valign="top">
		<li id="li_43" style="width: 170px;margin-left: 3.3em;">
		<label class="description" for="element_44" style="width: 150px;"><font size="2">Upload Photo </font></label>
		<br>
		<div>
		<input type="file" cols="20" name="element_44" id="element_44" value="" onchange="upload(2);"  style="display: "/>
		<font size="2" face="Arial" color="black" id="f2" style="display:none;" name = "f2"></font>
		&nbsp;&nbsp;<a href="#" onclick="remove(2)" id="remove2" style="display: none;"><font size="2" face="Arial">Remove</font></a>
		<input id="f7" name=f7 class="element text medium" type="text" maxlength="255" value="" style="width: 150px; height: 20px;display: none;"/> 
		</div>
		</li>
		</td>
		</tr>
		</table>
		</div>
		
		<br>
		
		<div>
		<table border="0" width="100%" align="center">
		<tr>
		<td colspan="4" align="center">
			
					<li class="buttons">
			    <input type="hidden" name="form_id" value="370051" />
			    
				<input id="saveForm" class="button_text" type="submit" name="submit" value="Submit" style="border-style: outset; border-color: black" />
		</li></td></tr></table></div>
			</ul>
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
	<img id="bottom" src="newimages/bottom.png" alt="">
	</body>
</html>
</jsp:useBean>