<%@ include file="headernew.jsp"%>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page"></jsp:useBean>

<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<script language="javascript">

function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}

function gotoExcel (elemId, frmFldId)  
{  
	
	var obj = document.getElementById(elemId);  

 	var oFld = document.getElementById(frmFldId); 

  	oFld.value = obj.innerHTML;  

  	document.georep.action ="excel.jsp";     // CHANGE FORM NAME HERE

  	document.forms["georep"].submit();       // CHANGE FORM NAME HERE

} 	
 			function validate()
  			{
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
  			//	return datevalidate();
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
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
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
			
			if(yy11>year || yy22>year)
			{
				alert("Selected Date Should Not Be Greater Than Today's Date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
	  			if(mm11>month || mm22>month)
				{
					alert("Selected Date Should Not Be Greater Than Today's Date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(mm11==month && mm22==month)
			{
				if(dd11>day || dd22>day)
				{
					alert("Selected Date Should Not Be Greater Than Today's Date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}

			
			if(yy11 > yy22)
			{
				alert("From date year should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
				 if(mm11>mm22)
			{
				alert("From date month should not be greater than to date month");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			}
			if(mm11==month && mm22==month) 
			{
				if(yy11==yy22)
				{
				if(dd11 > dd22)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
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
					
				alert("From date should not be greater than to date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			
			return true;
		}

  		function allSelected(allVal)
  		{
  	  		
  			if(document.dateform.extAll.checked) 
  			{
  				document.getElementById("frmDT").style.display='none';
  		    	document.getElementById("toDT").style.display='none';
  		    }
  			else 
  			{
  				document.getElementById("frmDT").style.display="";
  		    	document.getElementById("toDT").style.display="";
  			}
  		}
  		  
function birt(){
  			
  			//alert("Hi");
  			var vehicle= document.getElementById("vehicle").value;
  			//var date1= document.getElementById("date3").value;
  			var fromDateTime= document.getElementById("data").value;
  			//var date2= document.getElementById("date4").value;
  			var toDateTime= document.getElementById("data1").value;
  			
  			var owner=document.getElementById("owner").value;
  			var trans=document.getElementById("owner").value;
  			var routeid1=document.getElementById("routeid").value;
  			var location1=document.getElementById("location").value; 
  			
  			var status=document.getElementById("status").value;
  			var warehousecode1="All";
  			
  			var sort =document.getElementById("sort").value;
  			
  			fromDateTime=fromDateTime+" 00:00:00";
  			
  			toDateTime=toDateTime+" 23:59:59";
  			
  		//	alert(vehicle);
  		//	alert(fromDateTime);
  		//	alert(toDateTime);
  		//	alert(owner);
  		//	alert(location1);
  		//	alert(routeid1);
  		//	alert(status);
  		//	alert(warehousecode1);
  			
  		//	alert(vehicle);
  		//	alert(date1);
  		//	alert(date2);

  			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=SensorDetailReport.rptdesign&vehicle="+vehicle+"&date1="+date1+"&date2="+date2+"&__showtitle=false";
  			//document.getElementById("myIframe").src="http://103.8.126.138:8080/birt/frameset?__report=geofence_report.rptdesign&vehicle="+vehicle+"&fromDateTime="+fromDateTime+"&toDateTime="+toDateTime+"&owner="+owner+"&location1="+location1+"&status="+status+"&routeid1="+routeid1+"&warehousecode1="+warehousecode1+"&trans="+trans+"&sort="+sort+"&__showtitle=false";
//  			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
  			document.getElementById("myIframe").src="http://myfleetview.com:8080/birt/frameset?__report=geofence_report.rptdesign&vehicle="+vehicle+"&fromDateTime="+fromDateTime+"&toDateTime="+toDateTime+"&owner="+owner+"&location1="+location1+"&status="+status+"&routeid1="+routeid1+"&warehousecode1="+warehousecode1+"&trans="+trans+"&sort="+sort+"&__showtitle=false";
  			document.getElementById("reportData").style.display="";
  			document.getElementById("footer").style.display="none";
  		//	alert("after frame");
  		}
  		
 </script>
 
 <%!String data1, data2, showdate, showdate1;
 String chkbx="";
	String VehRegNo = "";%>
	
	<%
Connection conn1 = null;

Statement st = null,st1=null,st2=null,st3=null,st4=null;

try{
	
	String prevDayDate = null;
	String repDate = null;
	String ownerName = null;

	int distanceDifference = 0;

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();
	st1 = conn1.createStatement();
	st2 = conn1.createStatement();
	st3 = conn1.createStatement();
	st4 = conn1.createStatement();
	
%>

<%
	String fromDate = "", toDate = "";

	String dd = request.getQueryString();
	if (dd == null) {
		Calendar cal = Calendar.getInstance();
		String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data2 = today_dt;
		String temp = data2;
		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

		cal.add(Calendar.DATE, -1);
		String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
				.format(cal.getTime());
		data1 = yesterday_dt;
		temp = data1;

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	} else {

		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));

	} //end of else
	String user =session.getAttribute("usertypevalue").toString();
	%>
	<input type="hidden" id="owner" name="owner" value="<%=user%>"></input>
	<% 
	System.out.println("User-"+user);
%>
<div align="center">
<!-- <form name="dateform" action="" method="get" onsubmit="return validate();"> -->
<table border="0" align="center" style="width: 80%; ">
	
	<tr>
	
	<td id="frmDT" align="left" style="display:'' "><b><font size="2">From : </font></b>&nbsp;&nbsp; <input
			type="text" size="10" id="data" name="data"
			value="<%if(request.getParameter("data")!=null){%><%=request.getParameter("data")%><% }else%><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>" size="15" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>

		<td id="toDT" align="left" style="display:''"><b><font size="2">To : </font></b>&nbsp;&nbsp; <input
			type="text" size="10" id="data1" name="data1"
			value="<%if(request.getParameter("data1")!=null){%><%= request.getParameter("data1")%><% }else%><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>" size="15" readonly /></td>
		<td align="left"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data1",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",     // the date format
		      button      : "data1"       // ID of the button
		    }
		  );
		</script></td>
		
		<td>
         <b><font size="2">Route Id:</font></b>
           <select name="routeid" id="routeid" style="width: 125px; height:20px; border: 1px solid black; font: normal 13px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
             <%if(request.getParameter("routeid")!=null){ %>
                               <option><%=request.getParameter("routeid")%></option>
                               <%}%>
            <option value="All">All</option>
          
            <%
            String route="";
       	String sqlroute = "select distinct RouteId from db_gps.t_warehousedata where Owner like '%"+user+"%' and RouteId not in ('-')  order by RouteId";
		System.out.println("*******"+sqlroute);
        ResultSet rs2 = st1.executeQuery(sqlroute);
		while(rs2.next())
		{
			 route= rs2.getString("RouteID");
			 
			
			%>
		   		<option value="<%=route%>"><%=route%></option>	
			<%
			
      }
		%>
           </select>
           </td>
	
	<td>
         <b><font size="2">Vehicle:</font></b>
           <select name="vehicle" id="vehicle" style="width: 125px; height:20px; border: 1px solid black; font: normal 13px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
            <%if(request.getParameter("vehicle")!=null){ 
            String sql="select VehicleRegNumber from db_gps.t_vehicledetails where vehiclecode='"+request.getParameter("vehicle")+"' limit 1";
            ResultSet rsch=st.executeQuery(sql);
           if(rsch.next()){%>
                               <option><%=rsch.getString("VehicleRegNumber")%></option>
                               <%}}%>
           
            <option value="All">All</option>  
             
            <%
            String vehiclecode="";
       	String sqlregno = "select VehicleRegNumber,vehiclecode from db_gps.t_vehicledetails where vehiclecode in "+session.getAttribute("VehList").toString()+" order by VehicleRegNumber";
		System.out.println("*******"+sqlregno);
        ResultSet rsregno = st.executeQuery(sqlregno);
		while(rsregno.next())
		{
			 vehiclecode= rsregno.getString("vehiclecode");
			 VehRegNo=rsregno.getString("VehicleRegNumber");
			 
			 System.out.println("VehicleRegNo-->"+VehRegNo);
			
	         
			String vehicles="";
			vehicles=vehicles.replace("(","");
			vehicles=vehicles.replace(")","");
			
			
		//	System.out.println("*******");
			//System.out.println("*vehicles******"+vehicles);
			//System.out.println("*VehRegNo******"+VehRegNo);
			//System.out.println("-anil veh-------"+vehicles.equalsIgnoreCase(rsregno.getString("VehicleRegNumber")));
			
			if(vehicles==rsregno.getString("vehiclecode") || vehicles.equalsIgnoreCase(rsregno.getString("vehiclecode")))
			{
			%>
		    <option value="<%=rsregno.getString("vehiclecode")%>"selected="selected"><%=rsregno.getString("VehicleRegNumber")%></option>			
			<%
			}
			else
			{%>
				<option value="<%=rsregno.getString("vehiclecode")%>"><%=rsregno.getString("VehicleRegNumber")%></option>
				<%	
			}
      }
		%>
           </select>
           </td>
           
           <td>
         <b><font size="2">Location:</font></b>
           <select name="location" id="location" style="width: 125px; height:20px; border: 1px solid black; font: normal 13px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;">
             <%if(request.getParameter("location")!=null){ %>
                               <option><%=request.getParameter("location")%></option>
                               <%} %>
            <option value="All">All</option>
              
            <%
            String location="";
       	String sqlloc = "select distinct WareHouse from db_gps.t_warehousedata where Owner like '%"+user+"%'  order by WareHouse";
		System.out.println("*******"+sqlloc);
        ResultSet rs = st1.executeQuery(sqlloc);
		while(rs.next())
		{
			 location= rs.getString("WareHouse");
			
			
			%>
		   <option value="<%=location%>"><%=location%></option>			
			<%
			
      }
		%>
           </select>
           </td>
           
            
           
           
           <td>
           <b><font size="2">Status:</font></b>
           <select name="status" id="status" style="width: 87px; height:20px; border: 1px solid black; font: normal 13px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" >
                               <%if(request.getParameter("status")!=null){ %>
                               <option><%=request.getParameter("status")%></option>
                               <%}%>
                               <option value="All">All</option>
                               
                               <option value="Entry">Entry</option>
                  	            <option value="Exit">Exit</option>
         </select>  
         </td>
         
         <td>
           <b><font size="2">Sort By:</font></b>
           <select name="sort" id="sort" style="width: 90px; height:20px; border: 1px solid black; font: normal 13px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" >
                               <%if(request.getParameter("sort")!=null){ %>
                               <option><%=request.getParameter("sort")%></option>
                               <%}%>
                               <option value="Sr.No">Sr.No</option>
                              <option value="Vehicle">Vehicle</option>
                              <option value="Transporter">Transporter</option>
                  	            <option value="Location">Location</option>
                  	            <option value="Status">Status</option>
                  	            <option value="DateTime">DateTime</option>
                  	            <option value="Latitude">Latitude</option>
                  	            <option value="Longitude">Longitude</option>
         </select>  
           </td>

		
		<td align="left"><input type="submit" name="submit" id="submit" onclick="birt()"
			value="submit"></td>
	</tr>
</table>
<div id="reportData" style="display:none;">
<iframe id="myIframe" width="100%" height="850px" src=""> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> -->
</iframe> 

</div>

<!-- </form> -->
</div>

<%
	if (!(null == request.getQueryString())) {
		String data = "", data1 = "", vehicleCode = "", vehicleRegistrationNumber = "",sumOfDist="",intripCount="";
		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
		data2 = request.getParameter("data1");

		toDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data2));
%>

<%
		String exportFileName ="GeofenceEntryExitReport.xls";
	%>
	<%-- <div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center"><font face="Arial" size="3">
	<B>Geofence Entry Exit Report from <%=request.getParameter("data")%>
				to <%=request.getParameter("data1")%></B></font></div>
	<form name="georep" id="georep" method="post">
	<table border="0" width="100%">
		<tr>
			<td align="right"><input type="hidden" id="tableHTML" name="tableHTML" value="" />
			<input type="hidden" id="fileName" 	name="fileName" value="<%=exportFileName%>" />
		    <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> 
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
			<a	href="#" onclick="gotoExcel('mytable','tableHTML')" 	title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp; <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		</tr>
	</table> --%>
		
			
			<!-- <div id="mytable"> 
			<table border="1" class="sortable" style="align:center; font:normal 13px Arial,Helvtica,sans-serif; width : 100%;" >
			
			<tr>
				<th>Sr.</th>
				<th> Vehicle </th>
				<th> Transporter</th>
				<th> Location </th>
				<th> Route Id </th>
				<th> Latitude </th>
				<th> Longitude </th>
				<th> Status </th>
				<th> Date Time </th>
				
			</tr> -->
			<%
				
					String vehicle=request.getParameter("vehicle");
					System.out.println("Vehicle is->"+vehicle);	
					String status=request.getParameter("status");
					System.out.println("Status is->"+status);
					
					if(!vehicle.equals("All")){
						System.out.println("In vehicle");
						//vehicle="('"+vehicle+"')";
						vehicle=""+vehicle+"";
					}else{
						vehicle=session.getAttribute("VehList").toString();
						vehicle=vehicle.replace("(", "");
						vehicle=vehicle.replace(")", "");
					}
					 chkbx="No";
					if(request.getParameter("extAll")=="Yes"){
						chkbx=request.getParameter("extAll");
						
					}
					
					System.out.println("Checke box is->"+chkbx);
					String dt1 = "", dt2 = "", chdt1 = "", chdt2 = "";
					if(status=="All" || status.equals("All"))
					{
					    //status="('Entry','Exit','-')";
						status="'Entry','Exit','-'";
						
					}

						if(status=="Entry" || status.equals("Entry"))
						{
							
							//status="('Entry')";
							status="'Entry'";
						}

						if(status=="Exit" || status.equals("Exit"))
						{
							
							//status="('Exit')";
							status="'Exit'";
						}
						 location=request.getParameter("location");
						System.out.println("Location--"+location);
						String location1="''",loc="";
						String warehousecode1="''",warehousecode="";
						if(location.equals("All")){
							
							 
					       	String sql12 = "select distinct WareHouse,WareHouseCode from db_gps.t_warehousedata where Owner like '%"+user+"%' order by WareHouse ";
							//System.out.println("*******"+sql12);
					        ResultSet rsregno12 = st2.executeQuery(sql12);
							while(rsregno12.next())
							{
								 
								 loc=rsregno12.getString("WareHouse");
								 loc="'"+loc+"'";
								warehousecode=rsregno12.getString("WareHouseCode");
								warehousecode="'"+warehousecode+"'";
								 location1=location1+","+loc;
								 warehousecode1=warehousecode1+","+warehousecode;
								
					      }
					}else{
						location="'"+location+"'";
						//cust1=cust1+","+cust;
						location1=location;
						String sql12 = "select WareHouseCode from db_gps.t_warehousedata where WareHouse in ("+location1+") and Owner like '%"+user+"%' order by WareHouse ";
						System.out.println("*******"+sql12);
						ResultSet rsregno12 = st2.executeQuery(sql12);
						if(rsregno12.next()){
							warehousecode=rsregno12.getString("WareHouseCode");
							
						}
						warehousecode="'"+warehousecode+"'";
						warehousecode1=warehousecode;
					}
						
					route=request.getParameter("routeid");
					System.out.println("RouteID"+route);
					String routeid1="''",rute="";
					if(route.equals("All")){
						String sql3="select distinct routeid from db_gps.t_warehousedata where Owner like '%"+user+"%' order by RouteId ";
						System.out.println("routeid query-"+sql3);
						ResultSet rs3=st3.executeQuery(sql3);
						while(rs3.next()){
							rute=rs3.getString("RouteId");
							rute="'"+rute+"'";
							routeid1=routeid1+","+rute;
						}
					}else{
						route="'"+route+"'";
						routeid1=route;
					}
					System.out.println("RouteId->"+routeid1);
						
					String fromDateTime = fromDate + " " + "00:00:00";
					String toDateTime = toDate + " " + "23:59:59";
					System.out.println("user=" + user);
					String transporter="", warehouse="", entryexitstatus="", datetime="",lat="", lon="";
					String commaSeparatedVehicleList = session.getAttribute(
							"VehList").toString();
					
					out.println("");
					
					 String sql = "SELECT VehRegNO,Transporter,WareHouse, EntryExitStatus, TheDateTime, Lat, Lon FROM  db_gps.t_geofenceentryexit WHERE VehCode in "+vehicle+" and warehouse in ("+location1+") and TheDateTime>='"+fromDateTime+ "' and TheDateTime<='"+toDateTime+"' and EntryExitStatus in "+status+" and WareHouseCode in (select warehousecode from db_gps.t_warehousedata where warehousecode in ("+warehousecode1+") and routeid in ("+routeid1+") ) order by TheDateTime desc";
						
					System.out.println("sql=" + sql);
					/*
					ResultSet rs1 = st.executeQuery(sql);
					int i = 0;
					while (rs1.next()) {
						i = i + 1;
			
						vehicleRegistrationNumber = rs1.getString("VehRegNo");
						transporter = rs1.getString("Transporter");
						warehouse = rs1.getString("WareHouse");
						entryexitstatus= rs1.getString("EntryExitStatus");
						datetime= rs1.getString("TheDateTime");
						lat= rs1.getString("Lat");
						lon= rs1.getString("Lon");
						
						String sql4="select RouteId from db_gps.t_warehousedata where RouteId in ("+routeid1+")  and Owner like '%"+user+"%' and Warehouse='"+warehouse+"'  ";
						//System.out.println("Sql 4->"+sql4);
						String ruteid="";
						ResultSet rs4=st4.executeQuery(sql4);
						if(rs4.next()){
							ruteid=rs4.getString("RouteId");
						} */
%>
			<%-- <tr>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=i%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=vehicleRegistrationNumber%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=transporter%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=warehouse%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=ruteid%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=lat%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;"><%=lon%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;"><%=entryexitstatus%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;width: 190px;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime))%></td>
				
			</tr> --%>
<%
			//	}
%>
		</table>
		
		</div>
		
		
		
		<!-- </form> -->
		
		
	
<%
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	st.close();
	conn1.close();
	try
	{
	fleetview.closeConnection();
	}catch(Exception e)
	{
	}
}
%>
<%@ include file="footernew.jsp"%>

			