
<!-- Displayed Header -->
<%@ include file="headernew.jsp"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">

<!-- Database Connection -->
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"
	scope="page">
	<%
		fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,	MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
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
			//alert(userid);
			// var sort=document.getElementById("sort").value;
			var date1= document.getElementById("data").value;
			var date2= document.getElementById("data1").value;
			//var date2= document.getElementById("date4").value;
			//var date2= document.getElementById("data1").value;
			
				
			//vehicle="2811,3300,6251";
			
			//date1=date1+" 00:00:00";
			//date2=date2+" 23:59:59";
			
//			alert(vehicle);
			//alert(date1);
			//alert(date2);
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
			
			//alert(userid);
			//alert(formattedDate1);
			//alert(formattedDate2);
			document.getElementById("myIframe").src="http://myfleetview.com:8080/birttest/frameset?__report=VehicleOffline_report.rptdesign&userid="+userid+"&Date1="+formattedDate1+"&Date2="+formattedDate2+"&dt="+date1+"&dt1="+date2+"&__showtitle=false";
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
	
	<% 
	String UserID=session.getAttribute("usertypevalue").toString();
	System.out.println("UserID=====>"+UserID);
	%>
	
	<input type="hidden" id="user" name="user" value="<%=UserID%>" />
	
	
	<table border="0" width=600 align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><div align="left"><font size="3"></font></div>
			<font face="Arial" color="blue" size="3"><b style= "font:normal 16px Arial,Helvtica,sans-serif;"><b> Route Profile Master </b></font></td>
		</tr>
	</table>
	
	
	

	<!-- Select date and time from calendar -->

	<div style="margin-left: 25%;">
	<%-- <table border="0" width=600 align="center">
		<!-- <form action="" method="get" onsubmit="return validate();"> -->
		<input	type="hidden" id="PageName" name="PageName" value="<%=PageName%>" />
		<br></br>
		<tr>
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
			<td>&nbsp;&nbsp;<input type="submit" name="submit" id="submit" onclick="birt()" value="submit"></td>
		</tr>
		<!-- </form> -->
	</table> --%>
	<br>
	</div>
	<div align="right">
	<td  bgcolor="#FFFFFF" align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
	</div>
	<div>
	<table>
	<tr>
<td align="left" ><font face="Arial" size="2"><a href="RouteProfilemstr.jsp" style="font-weight: bold; color: blue; " >Add Route</a></font></td>


	
	
	</tr>
	</table>
	</div>
	<%
	
	
	String dt = new SimpleDateFormat("yyyy-MM-dd")
    .format(new SimpleDateFormat("dd-MMM-yyyy").parse(datex1));

dt=dt+" 00:00:00";

String dt1 = new SimpleDateFormat("yyyy-MM-dd")
   .format(new SimpleDateFormat("dd-MMM-yyyy")
      .parse(datex2));

dt1=dt1+" 23:59:59";
	
		
	%>
	
	<div id="reportData">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=RouteProfileMaster.rptdesign&Owner=<%=UserID%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 

 </div>
	
	<%-- <%
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
%>
	
	
	<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=JRM_report.rptdesign&userid=<%=UserID%>&__showtitle=false"> 
<iframe id="myIframe" width="100%" height="850px" src=""> 
</iframe> 

 </div>
 
 <%
		}
%> --%>

<script>


window.onload=birt;
</script>



	

</jsp:useBean>
