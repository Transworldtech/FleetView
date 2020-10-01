<!-- Displayed Header -->
<%@ include file="headernew.jsp"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"	scope="page"></jsp:useBean>

<%! public static Connection con1; %>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(MM_dbConn_DRIVER);
	
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	Statement stmt3 = con1.createStatement();
	
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
%>

<!-- JavaScript for export to excel and export to PDF -->
	<script language="javascript">
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
	           document.custreport.action ="excel.jsp";
	           document.forms["custreport"].submit();
	            
	  } 
	 function allSelected(allVal)
	 {
	 	if(document.ndreport.extAll.checked) 
	 	{
	 		document.getElementById("fromdt").style.display='none';
	     	document.getElementById("todt").style.display='none';
	     }
	 	else 
	 	{
	 		document.getElementById("fromdt").style.display="";
	     	document.getElementById("todt").style.display="";
	 	}
	 }

	  
	 function popUp(webadd,VehicleRegNumber,VehCode,fromtime,totime)
	 { 
		 window.open(webadd+'?vehicle='+VehicleRegNumber+'&vehcode='+VehCode+'&fromtime='+fromtime+'&totime='+totime,'jav','width=830,height=400,top=150,left=250,resizable=no,scrollbars=yes');
	
	  }

	 function DeleteRow(id)
	 {
	 	 //alert(id);
	 	 var vehcode=id;
	 	 var agree=confirm("Do You Want to Cancel This Night Driving?");
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
	 				{alert("Cancel successfully.....");					
	 			    	window.location.reload();
	 			    	
	 				}
	 			
	 			} 
	 		}
	 		
	 		var queryString = "?action=delete&vehcode="+vehcode;
	 		
	 		
	 		ajaxRequest.open("GET", "ndCancel.jsp" + queryString, true);
	 		ajaxRequest.send(null); 

	 	 }
	 	 else
		 	 {
		 	 
		 	  return false;
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
	 
	 function datavalidate() 
		{
		
			var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2,dm11,dm22;
			dy1=date1.substring(0,2);
			dy2=date2.substring(0,2);
			dm1=date1.substring(3,6);
			dm2=date2.substring(3,6);

			dm11=dateformat(dm1);
			dm22=dateformat(dm2);	
			dd1=date1.substring(7,11);
			dd2=date2.substring(7,11);
			var date=new Date();
			var month=date.getMonth()+1;
			//var month1=date2.getMonth();
			var day=date.getDate();
			var year=date.getFullYear();
			
			
			
			
			if(dd1>dd2)
			{  
				
				
				
				alert("From Date Year Is Should Not Be Greater Than To Date Year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
				
			}
			
			else if(year==dd1 && year==dd2) if(dm11>dm22)
			{
				
				alert("From Date Month Is Should Not Be Greater Than To Date Month ");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			 if(dm1==dm2 && dd1==dd2) {
			if(dy1 > dy2)
			{
				alert("From Date Should Not Be Greater Than To Date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			return true;
		
		}
	 function validate()
		{
			//alert("IN AVL:OIDATE   ");

			if(document.getElementById("data").value=="")
	  				{
	  			  		alert("Please Select The From Date");
	  					return false;
	  				}
	  				if(document.getElementById("data1").value=="")
	  				{
				  		alert("Please Select The To Date");
	  					return false;
	  				}
		}
	 

	  
	   </script>
	   
	   <%!
		String datex1, datex2, data1, data2,VehRegNo="";
	%>
	
	<%
		String ddx = request.getQueryString();
			
			if (ddx == null) {
				datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
						.format(new java.util.Date());
				data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
						.format(new java.util.Date());
			
				Calendar c = Calendar.getInstance();   // this takes current date
			    c.set(Calendar.DAY_OF_MONTH, 1);
			    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
			    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
			
			
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
	
	<table border="0" width="600" align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><!-- <div align="left"><font size="3">Report No:7.0</font></div>-->
			<font face="Arial" color="black" size="3"><b> Vehicle Night Driving Intimation	</b></font></td>
		</tr>
	</table>
	
	<div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<form action="" method="get" name="ndreport" onsubmit="return validate();">
		<tr>
		
		<label id="element_1" name="element_1"  class="description" for="element_1"><b>Enter Vehicle Number :</b> </label>
        <select name="vehicle" id="vehicle" style="width: 135px; height:23px; border: 1px solid black; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
        <option value="Select">Select</option>
            <%
        String vehiclecode="";
       	String sqlregno = "select VehicleRegNumber,vehiclecode from db_gps.t_vehicledetails where vehiclecode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
		System.out.println("*******"+sqlregno);
		PreparedStatement ps=con1.prepareStatement(sqlregno);
        ResultSet rsregno = ps.executeQuery();
		while(rsregno.next())
		{
			 vehiclecode= rsregno.getString("vehiclecode");
			 VehRegNo=rsregno.getString("VehicleRegNumber");
			 
			 System.out.println("VehicleRegNo-->"+VehRegNo);
			
	         
			//String vehicles="";
			//vehicles=vehicles.replace("(","");
			//vehicles=vehicles.replace(")","");
			
			
		//	System.out.println("*******");
			//System.out.println("*vehicles******"+vehicles);
			//System.out.println("*VehRegNo******"+VehRegNo);
			//System.out.println("-anil veh-------"+vehicles.equalsIgnoreCase(rsregno.getString("VehicleRegNumber")));
			
			
			%>
		    <option value="<%=rsregno.getString("VehicleRegNumber")%>" ><%=rsregno.getString("VehicleRegNumber")%></option>			
			<%
			
      }
		%>
           </select>
     </td>
      <td><br><input id="saveForm" name="submit"  class="button_text" type="submit"  value="Search" /></td> 
	</tr>
		</form>
	</table>
	</div>
	
	<!-- Assign report name to excel sheet -->
	<%
		String exportFileName ="NDIntimationReport.xls";
	%>
	<div>
<table width ="100%" border="0">
	<tr align="left"><td><a href="NdIntimationEntry.jsp"><b>Add New</b></a></td>
	
	<td align="right">
		    <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> 
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
			<a	href="#" onclick="gotoExcel('mytable','tableHTML')" 	title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp; <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
	</tr>
	</table>
	</div>
	<form name="custreport" id="custreport" method="post">
	<div id="mytable">   <!-- Dont change this div -->
	<input type="hidden" id="tableHTML" name="tableHTML" value="" />
			<input type="hidden" id="fileName" 	name="fileName" value="<%=exportFileName%>" />
  	<table border="1" width="100%" class="sortable" style= "font:normal 13px Arial,Helvtica,sans-serif;">
		<!-- Get The Data From the Database and show it -->
			
		<tr>
				<th>Sr.</th>
				<th> TripId </th>
				<th> VehicleRegNo </th>
				<th> Owner</th>
				<th> Vendor</th>
				<th> FuelIssueCategory</th>
				<th> Distance </th>
				<th> Day </th>
				<th> Geofence </th>
				<th> FuelQuantity </th>
				<th> Rate </th>
				<th> Amount </th>
				<th> Status </th>
				<th> DriverId </th>
				<th> DriverName </th>
								
			</tr>	
		<%
		String  date1="",date2="",fromDate="",toDate="", distance="", VehCode="",  reason="",VehicleRegNumber="",entrydatetime="",fromtime="",totime="";
		String chbxAll=request.getParameter("extAll");
		System.out.println("--check box is  ------>>>"+chbxAll);
		String EndPlace="",JRMRouteID="",StartPlace="",startend="",Owner="",vehregno="";
		String Tripid="",drivername="",driver_id="",Vendor="",FuelIssueCategory="",Distance="",Day="",Geofence="",FuelQuantity="",Rate="",Amount="",Status="";

		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
		int i=1, SrNo;
			
		String vehList=session.getAttribute("VehList").toString();
		System.out.println(" veh list "+vehList);
		
		
		try {
			
			String record="select * from db_gps.t_fuelissuemaster where vehregno='MH 04 EY 7006' and Status='Unprocessed' order by rid asc limit 1";
			PreparedStatement ps1=con1.prepareStatement(record);
		    ResultSet rsrecord = ps1.executeQuery();
			while (rsrecord.next())
			{
				Tripid=rsrecord.getString("Tripid");
				vehregno=rsrecord.getString("vehregno");
				Owner=rsrecord.getString("Owner");
				Vendor=rsrecord.getString("Vendor");
				FuelIssueCategory=rsrecord.getString("FuelIssueCategory");
				Distance=rsrecord.getString("Distance");
				Day=rsrecord.getString("Day");
				Geofence=rsrecord.getString("Geofence");
				FuelQuantity=rsrecord.getString("FuelQuantity");
				Rate=rsrecord.getString("Rate");
				Amount=rsrecord.getString("Amount");
				Status=rsrecord.getString("Status");
				driver_id=rsrecord.getString("driver_id");
				drivername=rsrecord.getString("drivername");
				
									
						
		%>
		
		<tr>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=i%></td>
		
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=Tripid%></td>
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=vehregno%></td>
		
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=Owner%></td>
		<%-- <td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=location%> </a></td> --%>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Vendor%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=FuelIssueCategory%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Distance%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;width: 190px;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Day))%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Geofence%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=FuelQuantity%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Rate%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Amount%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=Status%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=driver_id%></td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=drivername%></td>
		
		
		
	</tr>			
	<%	
	}				
	}catch(Exception e)
	{
		System.out.println("exception "+e.getMessage());
	}
				
		%>

		
	</table>
	</div>
	</form>


<!-- footer -->
<%@ include file="footernew.jsp"%>
		
	