
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
	
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
%>

<!-- Database Connection -->

	

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


	 function confirmDelete()
	  {
		  //alert("a");
		  var  agree=confirm("Are you sure you want to delete this Record?");
		  //alert("B") ;
		  if(agree)
		  {
			 //alert("C") ;	
			 return true ;
		  }	  	   
		  else
		  {
			 //alert("D") ; 
		     return false ;
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
				
				
				
				alert("From date should not be greater than to date");
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
			//alert("GetValidate------->"+a);
			if(a==true)
				{
				
				
			var userid=document.getElementById("user").value;
			//alert( userid);
			// var sort=document.getElementById("sort").value;
			var date1= document.getElementById("data").value;
			var date2= document.getElementById("data1").value;
			//var date2= document.getElementById("date4").value;
			//var date2= document.getElementById("data1").value;
			
				
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
			formattedDate1=formattedDate1+" 00:00:00";
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
			formattedDate2=formattedDate2+" 23:59:59";
			
//			alert(vehicle);
		//alert(date1);
		//alert(formattedDate2);
		//alert(formattedDate1);
			//alert(date2);
			
			document.getElementById("myIframe").src="http://myfleetview.com/birttest/frameset?__report=VehicleIdleIntimation_report.rptdesign&userid="+userid+"&date="+formattedDate1+"&date1="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&__showtitle=false";
//			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
			document.getElementById("reportData").style.display="";
			//document.getElementById("footer").style.display="none";
			return true;
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
	String dt = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(datex1));
	
	String dt1 = new SimpleDateFormat("yyyy-MM-dd")
	.format(new SimpleDateFormat("dd-MMM-yyyy")
			.parse(datex2));
	 	
	%>
	 <table border="0" width="600" align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><div align="left"><font size="3"></font></div>
			<font face="Arial" color="black" size="4"><b> Vehicle Idle Intimation	</b></font></td>
		</tr>
	</table> 

	<!-- Select date and time from calendar -->
	
	<div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<!-- <form action="" method="get" onsubmit="return validate();"> -->
		<input	type="hidden" id="PageName" name="PageName" value="<%=PageName%>" />
		<br></br>
		<tr>
			<td align="right"><font face="Arial" color="black" size="2"><b>From
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
			<td align="right"><font face="Arial" color="black" size="2"><b>To
			: </b></font>&nbsp;&nbsp; <input type="text" id="data1" name="data1" value="<%=datex2%>" size="15" readonly   class="element text medium" style="width: 125px; height: 16px;"  /> 
			<script	type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data1",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "data1"       // ID of the button
			    }
			  );
			</script></td>
			<td>&nbsp;&nbsp;<input type="submit" name="button" value="Submit" onclick="birt()"></td>
			
				
		</tr>
		<!-- </form> -->
	</table>
	</div>
	
	<!-- Assign report name to excel sheet -->
	<%-- <%
		String exportFileName = session.getAttribute("mainuser").toString()+ "_reportName.xls";
	%> --%>
	
<!-- Table for  Export to Excel and PDF -->
	
<%-- <form name="custreport" id="custreport" method="post">
	<table border="0" width="100%">
		<tr>
			<td align="right"><input type="hidden" id="tableHTML" name="tableHTML" value="" />
			<input type="hidden" id="fileName" 	name="fileName" value="<%=exportFileName%>" />
		    <a href="#"	style="font-weight: bold; color: black;" onclick="gotoPrint('mytable');"> 
			<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img> </a> 
			<a	href="#" onclick="gotoExcel('mytable','tableHTML')" 	title="Export to Excel">
			<img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp; <%=fleetview.PrintDate()%></td>
		</tr>
	</table>

	<p></p> --%>

	<% 
	String UserID=session.getAttribute("UserID").toString();
	String usr=request.getParameter("user");
	/* String dt=request.getParameter("data");
	String dt1=request.getParameter("data1"); */
	%>
	
	<input type="hidden" id="user" name="user" value="<%=UserID%>" />
	<div>
<table width ="100%" border="0">
	<!-- <tr> -->
	
	        <tr align="left">
		<!-- 	<td colspan="9" font-size:13px style="text-align: left"> -->
		<td>
		<font size="2" face="Arial">
		<a href="VehicleIdleEntry.jsp" style="font-weight: bold; color: blue; ">Add New</a>
			<!-- <a href="VehicleIdleEntry.jsp">Add New</a> -->
			</font>
			</td>
		</tr>
	
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		</tr></div>
		</table>
	
<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=VehicleIdleIntimation_report.rptdesign&userid=<%=UserID%>&date=<%=dt%>&date1=<%=dt1%>&dt=<%=datex1%>&dt1=<%=datex2%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 

 </div>
 
 <%
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
%>
 	<div id="reportData">
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=JRM_report.rptdesign&userid=<%=UserID%>&__showtitle=false"> --%> 
<iframe id="myIframe" width="100%" height="850px" src=""> 
</iframe> 

 </div>
 <%
		}
%>
 
 <script>


window.onload=birt;
</script>
 
	<%-- <div id="mytable">   <!-- Dont change this div -->
	<table border="1" width="100%" class="sortable">
		<!-- Get The Data From the Database and show it -->
		
		<tr>
			<td colspan="9" style="text-align: left">
			<a href="VehicleIdleEntry.jsp"><h4>Add New</h4></a>
			</td>
		</tr>
		
	
	
		
		<tr>
			<th>Sr.</th>
			<th>Vehicle No</th>
			<th>From Date</th>
			<th>To Date</th>
			<th>Comment</th>
			<th>Other Comment</th>
			<th>Entered By</th>
			<th>Updated Date Time</th>
			<th>Delete</th>
		</tr>
		
	<%
		String  date1="",date2="",fromDate="",toDate="", VehComment="", VehCode="", VehicleRegNumber="", otherComment="";
		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));
		date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex2));
		int i=1, SrNo;
			
		String vehList=session.getAttribute("VehList").toString();
		System.out.println(" veh list "+vehList);
			
		try {
				
				String sql= "select SrNo, VehCode,fromDate,toDate, VehComment, entryBy, updatedDateTime, otherComment  from db_gps.t_VehicleIdleEntry where  fromDate between '"+date1+"' and '"+date2+"' and VehCode in "+vehList+" and ActiveStatus='-'";
				System.out.println(" sql "+sql);
				ResultSet rst = stmt1.executeQuery(sql);
				String regNo="",vehCode="", entryBy="", updatedDateTime="";
				while (rst.next())
				{
						SrNo = rst.getInt("SrNo");
						fromDate = rst.getString("fromDate");
						toDate = rst.getString("toDate");
						VehComment = rst.getString("VehComment");
						VehCode = rst.getString("VehCode");
						entryBy = rst.getString("entryBy");
						updatedDateTime = rst.getString("updatedDateTime");
						otherComment = rst.getString("otherComment");
						
						
						String sql2= " select VehicleRegNumber from db_gps.t_vehicledetails  where VehicleCode="+VehCode;
						System.out.println("sql 2"+sql2);
						ResultSet rst2 = stmt2.executeQuery(sql2);	
						while (rst2.next())
						{			
							VehicleRegNumber = rst2.getString("VehicleRegNumber");	
	%>
		
<tr>				
		<td>	<input type="hidden" name="SrNo" id="SrNo"  value="<%=SrNo%>" />
				<%=i++ %>	
		</td>
		<td style="text-align: left">		
			<a href="editVehIdleEntry.jsp?VehCode=<%=VehCode%>&SrNo=<%=SrNo%>&VehComment=<%=VehComment%>"><%= VehicleRegNumber%>	</a>
		</td>	
		<td style="text-align: left">
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromDate)) %>
		</td>		
		<td style="text-align: left">
			<%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>
		</td>	
		<td style="text-align: left">
				<%= VehComment%>
		</td>
		<td style="text-align: left">
				<%= otherComment%>
		</td>
		<td style="text-align: left">
				<%= entryBy%>
		</td>
		<td style="text-align: left">
			<%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedDateTime))%>
				
		</td>
		<td style="text-align: centre">
			<a href="deleteVehIdleEntry.jsp?fromDate=<%=fromDate%>&VehCode=<%=VehCode%>&SrNo=<%=SrNo %>&status=delete" onClick="return confirmDelete();"> <img src="images/delete.jpeg" width="15px" height="15px" style="border-style: none" ></img></a>
		</td>
</tr>				
	<%	}
	}				
	}catch(Exception e)
	{
		System.out.println("exception "+e.getMessage());
	}
				
		%>
</tr>
		
	</table>
	</div> --%>
	</form>


<!-- footer -->
<%-- <%@ include file="footernew.jsp"%> --%>