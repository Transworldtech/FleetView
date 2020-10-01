
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
	Statement st = con1.createStatement();
	
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
			
				document.getElementById("data").focus;
				return false;
				
			}
			
			else if(year==dd1 && year==dd2) if(dm11>dm22)
			{
				
				alert("From date should not be greater than to date");
			
				document.getElementById("data").focus;
				return false;
			}
			 if(dm1==dm2 && dd1==dd2) {
			if(dy1 > dy2)
			{
				alert("From date should not be greater than to date");
				
				document.getElementById("data").focus;
				return false;
			}
			}
			return true;
		}

	 
	 function birt(){
		
		 
		
		 
			var a=validate();
		
			if(a==true)
				{
				
				
			
		
			var date1= document.getElementById("data").value;
			var date2= document.getElementById("data1").value;
		
			
				
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
			
			
			
			
			var user=document.getElementById("user").value;
			user=user.replace(/\../g,' ');
			

			var e=document.getElementById("fuel");
			var category=e.options[e.selectedIndex].value;
		
			
			
			document.getElementById("myIframe").src="http://myfleetview.com/birttest/frameset?__report=fuelrequestreport.rptdesign&usertypevalue="+user+"&cate="+category+"&Date1="+formattedDate1+"&Date2="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&__showtitle=false";
//			document.getElementById('myIframe').src="http://103.8.126.138:8080/birt/frameset?__report=driverreport1.rptdesign&_title='My Viewer'&date1=2015-03-01&date2=2015-08-28&drivername="+driver+"";
			document.getElementById("reportData").style.display="";
			
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
			<font face="Arial" color="black" size="4"><b> Fuel Request Report </b></font></td>
		</tr>
	</table> 

	<!-- Select date and time from calendar -->
	
	<div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<!-- <form action="" method="get" onsubmit="return validate();"> -->
		<input	type="hidden" id="PageName" name="PageName" value="<%=PageName%>" />
	
<!-- 		<tr> -->
		
<!-- 				 <td align="right"><font face="Arial" color="black" size="2"><b>FuelIssueCat -->
<!-- 			: </b></font> -->
<!-- 		<select name="fuel" id="fuel"> -->
<!-- 		     <option value="All" >All</option> -->
<!-- 			<option value="Km" >Km</option> -->
<!-- 			<option value="Daywise" >Daywise</option> -->
<!-- 			<option value="Geofence" >Geofence</option> -->
<!-- 		 </select> -->
		
		
<!-- 			<td align="right"><font face="Arial" color="black" size="2"><b>From -->
<!-- 			: </b></font> -->
<%-- 			 <input type="text" id="data" name="data" value="<%=datex1%>" size="15" readonly  class="element text medium" style="width: 125px; height: 16px;"  /> <script --%>
<!-- 				type="text/javascript"> -->
<!-- // 			  Calendar.setup( -->
<!-- // 			    { -->
<!-- // 			      inputField  : "data",         // ID of the input field -->
<!-- // 			      ifFormat    : "%d-%b-%Y",     // the date format -->
<!-- // 			      button      : "data"       // ID of the button -->
<!-- // 			    } -->
<!-- // 			  ); -->
<!-- 			</script></td> -->
			
<!-- 			<td align="right"><font face="Arial" color="black" size="2"><b>To -->
<%-- 			: </b></font> <input type="text" id="data1" name="data1" value="<%=datex2%>" size="15" readonly   class="element text medium" style="width: 125px; height: 16px;"  />  --%>
<!-- 			<script	type="text/javascript"> -->
<!-- // 			  Calendar.setup( -->
<!-- // 			    { -->
<!-- // 			      inputField  : "data1",         // ID of the input field -->
<!-- // 			      ifFormat    : "%d-%b-%Y",    // the date format -->
<!-- // 			      button      : "data1"       // ID of the button -->
<!-- // 			    } -->
<!-- // 			  ); -->
<!-- 			</script></td> -->
<!-- 			<td>&nbsp;<input type="submit" name="button" value="Submit" onclick="birt()"></td> -->
			
		
<!-- 		</tr> -->
		<!-- </form> -->
	</table>
	</div>
	
	
	
	<table border="0" width="700" align="center" class="sortable_entry">
			<tr>
				<td><b>From :</b>&nbsp;&nbsp; <input type="text" id="data"
					name="data" value="<%=datex1%>" size="15" readonly /></td>
				<td align="left"><!--<input type="button" name="From Date" value="From Date" id="trigger" >-->
				<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script></td>

				<td><b>To :</b> &nbsp;&nbsp; <input type="text" id="data1"
					name="data1" value="<%=datex2%>" size="15" readonly /></td>
				<td align="left"><!--  <input type="button" name="To Date" value="To Date" id="trigger1">-->
				<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",    // the date format
      button      : "data2"       // ID of the button
    }
  );
</script></td>
&nbsp;&nbsp;&nbsp;&nbsp;
				<td><b>FuelIssueCategory :
		<select name="fuel" id="fuel"> 
 		    <option value="All">All</option>
 		   <% 
 		  	String sql = "select Distinct(fuelissuecategory) from db_gps.t_fuelissuemaster;";
			ResultSet rs = st.executeQuery(sql);
			while(rs.next())
			{
				%>
				<option value="<%=rs.getString("fuelissuecategory") %>" ><%=rs.getString("fuelissuecategory") %></option>
				<%
			}
			%>
 		     </select> 
		
</td>
				<td>&nbsp;<input type="submit" name="button" value="Submit" onclick="birt()"></td>
		</table>
	</tr>


	 
	
	<% 
	
	String User=session.getAttribute("usertypevalue").toString();
	System.out.println("User-----"+User);
	%>
	
	<input type="hidden" id="user" name="user" value="<%=User%>" />
	 
<table width ="100%" border="0">
	<!-- <tr> -->
	
	        <tr align="left">
				<td>
		<font size="2" face="Arial">
		
			<!-- <a href="VehicleIdleEntry.jsp">Add New</a> -->
			</font>
			</td>
		</tr>
	
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		
		
		</tr></div>
		</table>
	
<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=fuelrequestreport.rptdesign&usertypevalue=<%=User%>&cate=All&Date1=<%=dt%>&Date2=<%=dt1%>&dt=<%=datex1%>&dt1=<%=datex2%>&__showtitle=false"> 
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
 
	