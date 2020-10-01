<%@ include file="headernew.jsp"%>
<%@page import="java.util.Date"%>
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
  				return datevalidate();
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
  		
  		function getTransporterDetails(transporter)
  		{
  			//alert("**********************************   ");
  			//alert(transporter);
  			//alert("**********66666666666 ************   ");
  			
  			document.getElementById("companyList").style.visibility="hidden";
  			document.getElementById("empid").value=transporter;
  			
  		}

  		
  		function timer()
  		{
  			
  			setTimeout("getCompanies(1)", 2000);
  		}
  			
  		function getCompanies(num)
  		{
  			//alert("compani"+num);
  			
  				document.getElementById("comlist").style.display="";
  			    
  			    
  	    	
  				var id=document.dateform.empid.value;
  				//alert(id);

  				if(id.length=="")
  				{
  					document.getElementById("companyList").style.visibility="hidden";
  					
  					document.getElementById("comlist").style.display="none";
  					
  					 	}
  				else
  				{
  					document.getElementById("companyList").style.visibility="visible";
  					
  				if(num==1)
  				{
  					counter=20;
  				}
  				else if(num==2)
  				{
  					counter=0;
  				}
  				
  				//var timer=setTimeout("getValue()",10000);
  		//		alert(timer);
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
  						document.getElementById("companyList").innerHTML=reslt;
  						var b=document.getElementById("element").value;
  						document.dateform.counter.value=b;
  						document.dateform.counter.value=b*document.dateform.counter.value;
  						counter=document.dateform.counter.value;
  						
  					} 
  				}
  				
  				var queryString = "?id=" +id+"&limitcount="+counter+"";
  				
  					
  				ajaxRequest.open("GET", "AjaxGetId.jsp" + queryString, true);
  				ajaxRequest.send(null); 
  				}//end of else
  				
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
Date d1=new Date();

Format df11= new SimpleDateFormat("dd-MMM-yyyy");
String today=df11.format(d1);
System.out.println("today-->"+today);
	
	String dd = request.getQueryString();
	if (dd == null) {
		
		System.out.println("In If");
		Date d=new Date();
		
		Format df1= new SimpleDateFormat("dd-MMM-yyyy");
		String dtoday=df1.format(d);
		System.out.println("Today date-->"+dtoday);
		System.out.println("after date");
	
	
		
	
	
		fromDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(dtoday));
		System.out.println(fromDate);

	} else {

		System.out.println("In else");
		data1 = request.getParameter("data");

		fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
	//	data2 = request.getParameter("data1");

	

	} //end of else


	
	
	String user = session.getAttribute("usertypevalue").toString();
	System.out.println("User-"+user);
%>
<div align="center">

<form name="dateform" action="" method="get" onsubmit="return validate();">
<table border="0" align="right">
	<tr>
<td align="right" colspan="4">
<a align="right" style="font-size:1.6em"></a></td>
	<tr>
	
	<td id="frmDT" align="left" style="display:'' "><b><font size="2">Date : </font></b>&nbsp;&nbsp; <input
			type="text" size="10" id="data" name="data"
			value="<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate))%>" size="15" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>
	
	
	 <td>
         <b>ID:</b>
           <input type="text" autocomplete="off" name="empid" id="empid" value="" style='width: 80px;' onkeyup="timer()" />
            <input type="submit" name="submit" id="submit"
			value="Go"></td>
	</tr>
	<tr id = "comlist"  style="display:none;" >
						<td></td>
						<td></td>
						
						<td valign="top"    style="align:right ;" >
					   	<div align="left" style="border: thin;margin-left: 20%;">   
						<div id='companyList' style="background-color: white; position:absolute; height: 70px; width: 80px; overflow: auto; border:solid inset;" align="right">
						
						</div>
							<input type="hidden" name="counter" id="counter" value="3" />
							</div>
						</td>
						
						</tr>
						
						
</table>
</form>
</div>



<%
	//if (!(null == request.getQueryString())) 
	{
		
		String data = "", data1 = "";
		
		if(request.getParameter("data") ==null )
			data1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate));
		else
			data1 = request.getParameter("data");
		
		
		System.out.println("data1-->"+data1);
		
		

	fromDate = new SimpleDateFormat("yyyy-MM-dd")
				.format(new SimpleDateFormat("dd-MMM-yyyy")
						.parse(data1));
	//	 data2 = request.getParameter("data1");

	
%>

<%
		String exportFileName ="RakshakReport.xls";
	%>
	<div style="font-size: 1.8em; text-align: center; margin-top: 0.5em; margin-bottom: 0.4em;margin-left: 0.6em" align="center"><font face="Arial" size="3">
	<B>Rakshak Report for <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate)) %></B></font></div>
	<form name="georep" id="georep" method="post">
	<table border="0" width="100%" >
		<tr>
			<td align="right"><input type="hidden" id="tableHTML" name="tableHTML" value="" />
			<input type="hidden" id="fileName" 	name="fileName" value="<%=exportFileName%>" />
		    <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> 
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
			<a	href="#" onclick="gotoExcel('mytable','tableHTML')" 	title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp; <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		</tr>
	</table>
		
			
			<div id="mytable"> 
			<table border="1" class="sortable" style="align:center; font:normal 13px Arial,Helvtica,sans-serif; width : 100%;" >
			
			<tr>
				<th>Sr.</th>
				<th>Id </th>
				<th>Name </th>
				<th>Contact</th>
				<th>Company </th>
				<th>Sex </th>
				<th>Updated  </th>
				<th>Location </th>
				<th>Home Location Marked </th>
				<th>Shift End </th>
				<th>Transit Time</th>
				<th>Reached Home</th>
				<th>Reaching Time </th>
				<th>Detection </th>
				<th>Arrival Location </th>
				
			</tr>
			<%
				String greencolor="#CCFFCC";
				String orrangecolor="#FFC475";
		
				String dt1 = "", dt2 = "", chdt1 = "", chdt2 = "";
					
					String currentdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
					System.out.println("Current Date->"+currentdate);
				//	String fromDateTime = fromDate + " " + "00:00:00";
				//	String toDateTime = toDate + " " + "23:59:59";
					String empname="",contact="",company="",gender="",date="",time="",currentloc="",homelocmark="",location="";
					String shiftend="",transittime="",reachhome="",homearrivetime="",arrivedetection="",unitid="",datetime="",empid="";
					
					String vehcode="",entrytime="",place="",entrystatus="";
					String unit="",unit1="''";
					String sql1="",sql2="",sql3="";
					String color="";
					String sessionsql="select * from db_gps.t_vehicledetails where VehicleCode in "+session.getAttribute("VehList").toString()+"";
					System.out.println("SessionSql->"+sessionsql);
					ResultSet rssession=st4.executeQuery(sessionsql);
					while(rssession.next()){
						unit=rssession.getString("unitid");
						unit="'"+unit+"'";
						unit1=unit1+","+unit;
					}
					String	employeeid="";
					System.out.println("Unit in Session-->"+unit1);
					if(request.getParameter("empid") ==null )
						employeeid="";
					else
					 employeeid=request.getParameter("empid");
				//	System.out.println("Employee ID"+employeeid);
					String sql="";
					if(employeeid=="" || employeeid==" " )
					 sql = "SELECT * FROM  db_gps.t_rakshakmaster where Unitid in ("+unit1+") order by RegDate desc ";
					else 
						 sql = "SELECT * FROM  db_gps.t_rakshakmaster where  empid='"+employeeid+"' order by RegDate desc ";
						
					System.out.println("sql=" + sql);
					ResultSet rs1 = st.executeQuery(sql);
					int i = 0;
					while (rs1.next()) {
						i = i + 1;
						entrystatus="";
						entrytime="";
						empname = rs1.getString("Name");
						empid = rs1.getString("empid");
						contact = rs1.getString("Mobilenumber");
						company = rs1.getString("Transpoter");
					//	datetime= rs1.getString("RegDate");
						shiftend= rs1.getString("ShiftEndTime");
						transittime= rs1.getString("TransitTime");
						unitid=rs1.getString("Unitid");
						homelocmark=rs1.getString("homelocationmarked");
						arrivedetection=rs1.getString("arrivaldetection");
						homearrivetime=rs1.getString("homelocationarrivedtime");
						gender=rs1.getString("Gender");
					//	currentloc=rs1.getString("currentlocation");
						//lat= rs1.getString("Lat");
						//lon= rs1.getString("Lon");
						System.out.println("empname="+empname);
						System.out.println("Contact="+contact);
						System.out.println("company="+company);
						
						System.out.println("Date time="+datetime);
						System.out.println("Shift End="+shiftend);
						System.out.println("Transit  time="+transittime);
						System.out.println("UNit="+unitid);
						System.out.println("Hoem loc mark="+homelocmark);
						System.out.println("Arrivel Detection="+arrivedetection);
						System.out.println("Home Arrive time="+homearrivetime);
						System.out.println("Gender="+gender);
						String lat="",lon="";
						sql1="select * from db_gps.t_onlinedata where UnitID='"+unitid+"' ";
						System.out.println("Sql1-->"+sql1);
						ResultSet rs2=st1.executeQuery(sql1);
						if(rs2.next()){
							date=rs2.getString("TheDate");	
							System.out.println("TheDate ->"+date);
							time=rs2.getString("TheTime");
							lat=rs2.getString("LatitudePosition");
							lon=rs2.getString("LongitudePosition");
							System.out.println("TheTime ->"+time);
							datetime=date+" "+time;
							System.out.println("Date&Time ->"+datetime);
							currentloc=rs2.getString("Location");
							
							
						}
						System.out.println("Lat-->"+lat);
						System.out.println("Lon-->"+lon);
						
						sql2="select * from db_gps.t_vehicledetails where unitid='"+unitid+"'";
						System.out.println("Sql2-->"+sql2);
						ResultSet rs3=st2.executeQuery(sql2);
						if(rs3.next()){
								vehcode=rs3.getString("VehicleCode");	
						}
						
						//String fromDateTime = fromDate + " " + "00:00:00";
							SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
						timeFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
						Date t1 = timeFormat.parse(shiftend);
						  Date t2 = timeFormat.parse(transittime);
						  
						  Long sumtime= t1.getTime()+t2.getTime();
						  
						  String shifttransit = timeFormat.format(new Date(sumtime));
						  System.out.println("Addition of Shif & Transit time->"+shifttransit);
						
						String fromDateTime =fromDate+" "+shifttransit; 
						String toDateTime = fromDate + " " + "23:59:59";
						System.out.println("From Date Time:-"+fromDateTime);
						System.out.println("To Date Time:-"+toDateTime);
						
						
						
					//	sql3="select * from db_gps.t_geofenceentryexit where vehcode='"+vehcode+"' and UpdatedDatetime>=curdate()   order by UpdatedDatetime desc limit 1 ";
				//	if(data1==today || data1.equals(today) )
				//		sql3="select * from db_gps.t_geofenceentryexit where vehcode='"+vehcode+"' and TheDateTime>=curdate() order by TheDatetime desc limit 1 ";
				//	else
					String geolat="",geolon="";
						sql3="select * from db_gps.t_geofenceentryexit where vehcode='"+vehcode+"' and TheDatetime between '"+fromDateTime+"' and '"+toDateTime+"' order by TheDatetime  limit 1 ";
					/*	{
							
							if status = entry and date is todays date, then only use the record to display.
									{
									display the record
									if system time is greater than shift end time, color will be green 
									}
							else
								if system time is greater than shift end + transit time, then red color
								else if system time is greater than shift end, then orange color
						} */
						
						System.out.println("Sql3-->"+sql3);
						ResultSet rs4=st3.executeQuery(sql3);
						if(rs4.next()){
							entrystatus=rs4.getString("EntryExitStatus");
							entrytime=rs4.getString("TheDatetime");
							place=rs4.getString("Place");
							geolat=rs4.getString("Lat");
							geolon=rs4.getString("Lon");
						}
						System.out.println("Entry time"+entrytime);
						System.out.println("Entry Status"+entrystatus);
						String status="";
						//String d1="2014-12-12 12:13:00";
					//	String d2="13:30:00";
					//	String d21=d2.substring(0,2);
					      // String d21=shiftend.substring(0,2);
					       String d21=shifttransit.substring(0,2);
					//	String d22=d2.substring(3,5);
			        	//	String d22=shiftend.substring(3,5);
			        	String d22=shifttransit.substring(3,5);
						int shift1=Integer.parseInt(d21);
						int shift2=Integer.parseInt(d22);
						System.out.println("Actual Reached Time1-->"+shift1);
						System.out.println("Actual Reached Time2-->"+shift2);
						
						//String date1=d1.substring(11,13);
						
						String systemtime=currentdate.substring(11,19);
						System.out.println("Systemtime"+systemtime);
						System.out.println("Entrytime"+entrytime);
						int time1=0,time2=0;
						int systime1=0,systime2=0;
						try{
						String date1=entrytime.substring(11,13);
						//String date2=d1.substring(14,16);
						
						String date2=entrytime.substring(14,16);
						 time1=Integer.parseInt(date1);
						 time2=Integer.parseInt(date2);
						System.out.println("Date1"+date1);
						System.out.println("Date2"+date2);
						
						}catch(Exception e){
							e.printStackTrace();
						}
						
						String sys1=systemtime.substring(0,2);
						String sys2=systemtime.substring(3,5);
						
						
						 systime1=Integer.parseInt(sys1);
						 systime2=Integer.parseInt(sys2);
						System.out.println("System Time---->"+systemtime);
						
						
						
						
						
					
						System.out.println("System Time1---->"+systime1);
						System.out.println("System Time2---->"+systime2);
						
						System.out.println("Time1-->"+time1);
						System.out.println("Time2-->"+time2);
						
						if(shift1==time1){
							if(time2>shift2){
								status="Yes";
								//color="#CCFFCC";
								
							}else{
								status="No";
							//color="#FFC475";
							}
						}else if(time1>shift1){
							status="Yes";
							//color="#CCFFCC";
						}else{
							status="No";
							//color="#FFC475";
						}
						
					
							Date entertime=timeFormat.parse(systemtime);
						//	Date shifttransit=timeFormat.parse(date3);
						//	System.out.println("Shifttransit"+shifttransit);
					/*	DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						Date date1=format.parse(datetime); */
						String status1="",homereachtime="",arrivaldetect="",geofenceloc="";
						if(data1==today || data1.equals(today) ){
						if(entrystatus.equals("Entry")){ 
							System.out.println("In ENtry if Condition");
							status1=status;
							homereachtime=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(entrytime));
							arrivaldetect=arrivedetection;
							geofenceloc=place;
							if(shift1==systime1){
								if(systime2>shift2){
						//			status="Yes";
									color="#FFC475";
									
								}else{
							//		status="No";
							//	color="#CCFFCC";
									color="";
								}
							}
							else if(systime1>shift1){
							//	status="Yes";
								color="#FFC475";
							}
							else{
							//	status="No";
							//	color="#CCFFCC";
								color="";
							}
								
					/*   else if(entertime.after(shifttransit)){
								status="No";
								color="#FF6347";
							}*/
							
							System.out.println("Color-->"+color);
						}else{
							System.out.println("In ENtry else Condition");
							status1="No";
							homereachtime="-";
							arrivaldetect="-";
							geofenceloc="-";
							//color="";
							if(shift1==systime1){
								if(systime2>shift2){
						//			status="Yes";
									color="#FFC475";
									
								}else{
							//		status="No";
								color="";
								}
							}
							else if(systime1>shift1){
							//	status="Yes";
								color="#FFC475";
							}
							else{
							//	status="No";
								color="";
							}
							
						}
						}else{
							
							System.out.println("In previous block date");
							if(entrystatus.equals("Entry")){ 
								System.out.println("In ENtry if Condition");
								status1=status;
								homereachtime=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(entrytime));
								arrivaldetect=arrivedetection;
								geofenceloc=place;
								if(shift1==time1){
									if(time2>shift2){
							//			status="Yes";
										color="#FFC475";
										
									}else{
								//		status="No";
									color="#CCFFCC";
									}
								}
								else if(time1>shift1){
								//	status="Yes";
									color="#FFC475";
								}
								else{
								//	status="No";
									color="#CCFFCC";
								}
									
						/*   else if(entertime.after(shifttransit)){
									status="No";
									color="#FF6347";
								}*/
								
								System.out.println("Color-->"+color);
							}else{
								System.out.println("In ENtry else Condition");
								status1="No";
								homereachtime="-";
								arrivaldetect="-";
								geofenceloc="-";
								//color="";
								if(shift1==time1){
									if(time2>shift2){
							//			status="Yes";
										color="#FFC475";
										
									}else{
								//		status="No";
									color="#CCFFCC";
									}
								}
								else if(time1>shift1){
								//	status="Yes";
									color="#FFC475";
								}
								else{
								//	status="No";
									color="#CCFFCC";
								}
								
							}
						}
						
						
%>			
			<tr bgcolor="<%=color%>">
			<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=i%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=empid%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=empname%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=contact%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=company%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=gender%></td>
				<%if(datetime=="" || datetime==" " || datetime==null ) {%>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;width: 190px;background-color:<%=color%>">-</td>
				<%}else{ %>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;width: 190px;background-color:<%=color%>"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime))%></td>
				<%} %>
				
				
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=lat%>&long=<%=lon%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=currentloc%> </a></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=homelocmark %></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=shiftend%></td>
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=transittime%></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%> "><%=status1%></td>
				<% if(status1.equals("Yes")){ %>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=homereachtime %></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><%=arrivaldetect %></td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>"><a href="javascript: flase;" onClick="window.open ('shownewmap.jsp?lat=<%=geolat%>&long=<%=geolon%>', 'win1', 'width=600, height=550, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0'); javascript:toggleDetails1(<%=i%>,false);"><%=geofenceloc%> </a></td>
				<%}else{ %>
				
				<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>">-</td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>">-</td>
				<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;background-color:<%=color%>">-</td>
			
			
			<%}%>
		
			</tr>
<%
				}
%>
		</table>
		</div>
		</form>
		
	
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

			