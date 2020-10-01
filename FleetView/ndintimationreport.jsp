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
	 	//if(document.ndreport.extAll.checked) 
	 		if(document.getElementById("extAll").checked==true) 
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
	 function validate()
	 {
	 	if(document.getElementById("data").value=="")
	 	{
	 	
	 		alert("Please select the from date");
	 		return false;
	 	}
	 if(document.getElementById("data1").value=="")
	 	{
	 	
	 		alert("Please select the to date");
	 		return false;
	 	}
	 	
	 	return datevalidate();
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
	 			
	 			
	 			
	 			alert("From date should not be greater than to date ");
	 			//document.getElementById("data").value="";
	 			//document.getElementById("data1").value="";
	 			document.getElementById("data").focus;
	 			return false;
	 			
	 		}
	 		
	 		else if(year==dd1 && year==dd2) if(dm11>dm22)
	 		{
	 			
	 			alert("From date should not be greater than to date");
	 			//document.getElementById("data").value="";
	 			//document.getElementById("data1").value="";
	 			document.getElementById("data").focus;
	 			return false;
	 		}
	 		 if(dm1==dm2 && dd1==dd2) {
	 		if(dy1 > dy2)
	 		{
	 			alert("From date should not be greater than to date");
	 			//document.getElementById("data").value="";
	 			//document.getElementById("data1").value="";
	 			document.getElementById("data").focus;
	 			return false;
	 		}
	 		}
	 		return true;
	 	}
	 
	 function birt(){
			
			//alert("Hi");
			//var vehicle1=document.getElementById("vehlist").value;
			var a=validate();
			//alert("GetValid------>"+a);
			if(a==true)
				{
				
				
			var userid=document.getElementById("user").value;
			//alert(userid);
			// var sort=document.getElementById("sort").value;
			var date1= document.getElementById("data").value;
			var date2= document.getElementById("data1").value;
			
			//var chkb=document.getElementById("extAll").checked;
			//alert(chkb);
			/* if(chkb ==true)

				{
				chkb= "ALL";				
				}
			else
				{
				chkb="no";
				}
			 */
			var date = date1.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++)
			{
			    if(date[1]==months[j])
			    {
			         date[1]=months.indexOf(months[j])+1;
			    }                      
			} 
			if(date[1]<10)
			{
			    date[1]='0'+date[1];
			}                        
			var formattedDate1 = date[2]+'-'+date[1]+'-'+date[0];
			
			//alert(date[1]);
			//alert(date[0]);
			
			var dat = date2.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++){
			    if(dat[1]==months[j]){
			         dat[1]=months.indexOf(months[j])+1;
			     }                      
			} 
			if(dat[1]<10){
			    dat[1]='0'+dat[1];
			}                        
			var formattedDate2 = dat[2]+'-'+dat[1]+'-'+dat[0];
			
			//date1=date1+" 00:00:00";
			//date2=date2+" 23:59:59";
			
			//alert(chkb);
			//alert(formattedDate1);
		//	alert(formattedDate2);
			
			document.getElementById("myIframe").src="http://myfleetview.com:8080/birttest/frameset?__report=NdIntimation_report.rptdesign&userid="+userid+"&Date1="+formattedDate1+"&Date2="+formattedDate2+"&Chk=no&dt="+date1+"&dt1="+date2+"&__showtitle=false";
//			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
			document.getElementById("reportData").style.display="";
			document.getElementById("footer").style.display="none";
			return true;
				}
			else
				{
					return false;
				}
		}  
	  
	   </script>
	   
	   <%!
		String datex1, datex2, data1, data2;
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
			
			
			String dt = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(datex1));
			dt=dt+"00:00:00";
			
			String dt1 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(datex2));

			dt1=dt1+"23:00:00";
			
			System.out.println(" dt "+dt+" dt1 "+dt1);
	System.out.println(" datex1 "+datex1+" datex2 "+datex2);
	
		
	
	
	%>
	
	 <table border="0" width="600" align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><div align="left"><font size="3"></font></div>
			<font face="Arial" color="black" size="3"><b> Vehicle Night Driving Intimation	</b></font></td>
		</tr>
	</table> 
	
	<div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<!-- <form action="" method="get" name="ndreport" onsubmit="return validate();"> -->
		<%-- <input	type="hidden" id="PageName" name="PageName" value="<%=PageName%>" /> --%>
		<br></br>
		<tr>
		
		<!-- <td align="right"><font face="Arial" color="black" size="2">
			<b>All</b></font> <input type="checkbox" name="extAll" id="extAll"  onclick="allSelected(this.value);"></input>
				</td> -->
		
			<td align="right" id="fromdt"><font face="Arial" color="black" size="2" style="display:''"><b>From
			: </b></font>&nbsp;&nbsp;
			 <input type="text" id="data" name="data" value="<%=datex1%>" size="15" readonly  class="element text medium" style="width: 125px; height: 16px;"  /> <script
				type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "data"       // ID of the button
			    }
			  );
			</script></td>
			<td align="right" id="todt"><font face="Arial" color="black" size="2" style="display:'' "><b>To
			: </b></font>&nbsp;&nbsp; <input type="text" id="data1" name="data1" value="<%=datex2%>" onchange="datavalidate();" size="15" readonly   class="element text medium" style="width: 125px; height: 16px;"  /> 
			<script	type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data1",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "data1"       // ID of the button
			    }
			  );
			</script></td>
			
			
			
			<td>&nbsp;&nbsp;<input type="submit" name="submit" id="submit" onclick="birt()"
				value="submit"></td>
		</tr>
		<!-- </form> -->
	</table>
	</div>
	
	
	
	<!-- Assign report name to excel sheet -->
	<%
		String exportFileName ="NDIntimationReport.xls";
	%>
	
	<% 
	String UserID=session.getAttribute("UserID").toString();
	%>
	
	<input type="hidden" id="user" name="user" value="<%=UserID%>" />
	
	
	
	<%-- <td align="right">
		    <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> 
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
			<a	href="#" onclick="gotoExcel('mytable','tableHTML')" 	title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp; <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td> --%>
			
	</tr>
	</table>
	
	<div>
<table width ="100%" border="0">
	<tr align="left"><td><font size="2" face="Arial"><a href="NdIntimationEntry.jsp"><b>Add New</b></a></font></td>
	
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		</tr>
		</table>
	<div id="reportData1">		
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=NdIntimation_report.rptdesign&userid=<%=UserID%>&Date1=<%=dt%>&Date2=<%=dt1%>&Chk=no&dt=<%=datex1%>&dt1=<%=datex2%>&__showtitle=false">
	<!-- <iframe id="myIframe" width='100%' height='650px' src=""> -->
	</iframe> 
</div>

<%
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
%>
<div id="reportData">	

<%-- <iframe id="myIframe" width="100%" height="850px" src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")))%>&date2=<%= new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")))%>&drivername=<%= request.getParameter("trNm1")%>";> --%>
	<iframe id="myIframe" width='100%' height='650px' src="">
	</iframe> 
</div>
	<%
		}
%>
	
	
	<script>


window.onload=birt;
</script>
	<%-- <form name="custreport" id="custreport" method="post">
	<div id="mytable">   <!-- Dont change this div -->
	<input type="hidden" id="tableHTML" name="tableHTML" value="" />
			<input type="hidden" id="fileName" 	name="fileName" value="<%=exportFileName%>" />
  	<table border="1" width="100%" class="sortable" style= "font:normal 13px Arial,Helvtica,sans-serif;">
		<!-- Get The Data From the Database and show it -->
			
		<tr>
			<th>Cancel</th>
			<th>Edit</th>
			<th>Sr.</th>
			<th>Vehicle </th>
			<th>From Date</th>
			<th>To Date</th>
			<th>Distance</th>
			<th>Reason</th>
			<th>Entered By</th>
			<th>Entry Date Time</th>
			
	
		</tr> --%>
		
		<%-- <%
		String  date1="",date2="",fromDate="",toDate="", distance="", VehCode="",  reason="",VehicleRegNumber="",entrydatetime="",fromtime="",totime="";
		String chbxAll=request.getParameter("extAll");
		System.out.println("--check box is  ------>>>"+chbxAll);

		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
		int i=1, SrNo;
			
		String vehList=session.getAttribute("VehList").toString();
		System.out.println(" veh list "+vehList);
		
		
		try {
			String sql="";
			if( chbxAll==null||  chbxAll==""){
				sql= "select SrNo, vehcode,fromdate,todate, distance, reason, entryBy, entrydatetime from db_gps.t_ndintimation where  fromDate>='"+date1+" 00:00:00' and toDate<='"+date2+" 23:59:59' and VehCode in "+vehList+" and status='Yes' ";
			}else
			 sql= "select SrNo, vehcode,fromdate,todate, distance, reason, entryBy, entrydatetime from db_gps.t_ndintimation where status='Yes' and VehCode in "+vehList+" ";
			System.out.println(" sql "+sql);
			ResultSet rst = stmt1.executeQuery(sql);
			String regNo="",vehCode="", entryBy="", updatedDateTime="",owner="";
			while (rst.next())
			{
					SrNo = rst.getInt("SrNo");
					fromDate = rst.getString("fromdate");
					toDate = rst.getString("todate");
					distance=rst.getString("distance");
					VehCode = rst.getString("vehcode");
					entryBy = rst.getString("entryBy");
					entrydatetime = rst.getString("entrydatetime");
					reason = rst.getString("reason");
					

					String sql2= " select VehicleRegNumber, Ownername from db_gps.t_vehicledetails  where VehicleCode="+VehCode;
					System.out.println("sql 2"+sql2);
					ResultSet rst2 = stmt2.executeQuery(sql2);	
					if (rst2.next())
					{			
						VehicleRegNumber = rst2.getString("VehicleRegNumber");
						owner=rst2.getString("Ownername");	
						
						String sql1="select NightDrivingFromTime, NightDrivingToTime from t_defaultvals where Ownername='"+owner+"' ";
						rs2=stmt3.executeQuery(sql1);
						if(rs2.next()){
							fromtime=rs2.getString("NightDrivingFromTime");
							totime=rs2.getString("NightDrivingToTime");
						//	System.out.println("NightDrivingFromTime->"+fromtime);
						//	System.out.println("NightDrivingToTime->"+totime);
							
						}
		%> --%>
		
		<%-- <tr>
		<td style="width: 2%"><a href="#"  style="font-weight: bold; color: black; "  onclick="DeleteRow('<%= VehCode%>') "><img src="images/delete.jpeg"  width="20px" height="18px"  style="border-style: none"  ></img></a></td>	
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif; width: 2%"><a href="#"   style="font-weight: bold; color: black; " onclick="popUp('ndUpdate.jsp','<%=VehicleRegNumber%>','<%=VehCode %>','<%=fromtime %>','<%=totime %>')"><img src="images/edit1.jpg"  width="20px" height="18px"  style="border-style: none"  ></img></a></td>			
		<td>	<input type="hidden" name="SrNo" id="SrNo"  value="<%=SrNo%>" />
				<%=i++ %>	
		</td>
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">		
			<%= VehicleRegNumber%>	
		</td>	
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(fromDate)) %>
		</td>		
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">
			<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(toDate))%>
		</td>	
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">
				<%= distance%>
		</td>
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">
				<%= reason%>
		</td>
		<td style="text-align: left;font:normal 13px Arial,Helvtica,sans-serif;">
				<%= entryBy%>
		</td>
		<td style="text-align: right;font:normal 13px Arial,Helvtica,sans-serif;">
			<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(entrydatetime))%>
				
		
</tr>			 --%>	
	<%-- <%	}
	}				
	}catch(Exception e)
	{
		System.out.println("exception "+e.getMessage());
	}
				
		%>
 --%>
		
	</table>
	</div>
	<!-- </form> -->


<!-- footer -->
<%-- <%@ include file="footernew.jsp"%> --%>
		
	