<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

%>
<%
	response.setHeader("Cache-Control","no-cache");
  	response.setHeader("Pragma","no-cache");
  	response.setDateHeader ("Expires", 0);
 %>
 <html>
 
 <head>
 	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Incident Contest</title>
<script type="text/javascript">
function getVehicles(num)
{
	try{
		//alert("Hii");
		var b=0;
		var vehicle=document.getElementById("element_1").value;
		var trans=document.getElementById("search-text").value;
		//alert("**********"+trans);
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
			
			var queryString = "?Vehicle="+vehicle+"&limitcount="+counter+"&trans="+trans+"";
			ajaxRequest.open("GET", "AjaxContestIncidentVeh.jsp" + queryString, true);
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
function getTransporterDetails(transporter)
{
	//alert("**********************************   ");
	//alert(transporter);
	//alert("**********66666666666 ************   ");
	
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("search-text").value=transporter;
	
}
function getTransporter(num)
{
	try{
	//alert("Hii");
	var b=0;
	var transporter=document.getElementById("search-text").value;
    if(transporter.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	//alert(transporter);
	//var user=document.getElementById("usertypevalue").value;
	//var counter=document.userform.counter.value;
	/*if(counter>100)
	{
		counter=0;
	}*/
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
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			//alert("b "+b);
			document.userform.counter.value=b;
			//alert("counter "+document.userform.counter.value);
			document.userform.counter.value=b*document.userform.counter.value;
			counter=document.userform.counter.value;
			//alert("counter "+counter);
		} 
	};
	var queryString = "?transporter="+transporter+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "AjaxContestIncident.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    }
	}catch(e)
	{
		alert(e);
	}
}
function validate() 
{
	var v1=document.getElementById("MyFile").value;
	var v2=document.getElementById("search-text").value;
	var v3=document.getElementById("element_1").value;

	//alert(v2+"===="+v3);
	if(v1=="" || v1==null)
	{
		alert("Please Select Video File For Upload");
		return false;
	}
	if(v2=="" || v2==null || v2==" ")
	{
		alert("Please Select The Transporter");
		return false;
	}
	if(v3=="" || v3==null || v3==" ")
	{
		alert("Please Select The Vehicle");
		return false;
	}

	return true;
} 
</script>

	
 </head>
 <div align="center">
 <table align="center">
 	<tr>
 		<td align="center">
 			<h1>Contest Incident Master Report</h1>
 		</td>
 	</tr>
 </table>
 </div>
 <body>
 <%
 	Connection con1;
 	Class.forName(MM_dbConn_DRIVER); 
	con1=fleetview.ReturnConnection();
	Statement stmt1=con1.createStatement();
 %>
 
 	<form action="contestIncidentMasterSubmit.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1" >
 	<div align="center">
 	<table border="0" width="60%" align="center">
				  <tr align="center">
					<td align="left"> <font  size="2"> Incident ID:-</font> </td>
					<td align="left">
						<%  
						String incidentid="";
						String sql2="select max(incidentId) as IncID from db_gps.t_contestIncidentMaster";
				 		ResultSet rs2=stmt1.executeQuery(sql2);
				 		while(rs2.next())
        				{
				 			incidentid=String.valueOf( rs2.getInt("IncID")+1 );
        				}
				 	%>
				 	<input type="hidden" name="incidentid" id="incidentid" value="<%=incidentid%>">
				 	<font  size="2"><%=incidentid%></font>
				 	<br></br><br></br>
					</td>
				 </tr>
				
				<tr align="center">
					<td align="left"><font  size="2"> Upload File:-</font></td>
					<td align="left"><input type="file" name="MyFile" id="MyFile"/></td>
				</tr>
				
				<tr align="center">
					<td align="left"><font  size="2"> Transporter:-</font></td>
					<td align="left"><input type="text" autocomplete="off" name="username" id="search-text" value="" style='width: 200px;' onkeyup="getTransporter(1)" /></td>
					<td align="left">
							<div id='transporterlist' align="left">
								<div style="height: 110px; width: 150px; overflow: auto;">
								<table style="display: none;">
								</table>
 								<!-- <input type="hidden" name="usertypevalue" id="usertypevalue" value="< %=session.getValue("usertypevaluemain").toString() %>"/>-->
								<input type="hidden" name="counter" id="counter" value="10"/>
								<input type="hidden" name="anothercounter" id="anothercounter" value="10"/>
								</div>
							</div>
					</td>
				</tr>
				
				<tr align="center">
					<td align="left"><label class="description" for="element_1" style="width: 170px;"><font size="2">Vehicle Registration No:-</font></label></td>
					
					<td align="left"><input id="element_1" name="element_1" autocomplete="off" class="element text medium" type="text" maxlength="255" value=""
						style="width: 150px; height: 16px;" onkeyup="getVehicles(1)" /> </td>
					<td align="left"  rowspan="1" style="width: 10%;"> 
						<div style='height:63px;width:100px;overflow:auto; align:left; margin-left: -66px; position: absolute;' id="vehiclelist">
						<table style='display: block;'></table></div>
								<br></br><br></br><br></br>
					</td>
			   </tr>
			   
			   
			   <tr align="center">
			   		<td></td>
				   	<td align="center"><input type="submit" name="submit" id="submit" value="Submit" onclick="return validate();" ></td>
			   </tr>
	</table>
	</div>
	</form>
 </body>
 
</html>
</jsp:useBean>
<%@ include file="footernew.jsp" %>