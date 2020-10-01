<%@ include file="headernew.jsp"%>
<%@page import="javax.swing.text.NumberFormatter"%>
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"
		import="com.transworld.fleetview.framework.TotalDistanceTraveled"
		import="com.transworld.fleetview.framework.FuelInfoVehicleList"
		import="com.transworld.fleetview.framework.Utilities" %>

<jsp:useBean id="vehicleDao"
	type="com.transworld.fleetview.framework.VehicleDao"
	scope="application"></jsp:useBean>
<%@page import="javax.swing.text.NumberFormatter"%>
<html>			
<head>
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
	          document.Total_os.action ="excel.jsp";
	          document.forms["Total_os"].submit();
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
	    }
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dd1=date1.substring(0,4);
			dd2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dy1=date1.substring(8,10);
			dy2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dy1>dy2)
			{
				alert("From date year is should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2) if(dm1>dm2)
			{
				alert("From date month is should not be greater than to date month 5");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dm1==dm2) 
			{
				if(dd1 > dd2)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			return true;
		}
  	</script>
</head>
<body>
	<table width="100%" align="center" class="sortable">
		<tr>
			<td align="center" class="sorttable_nosort">
				<!-- <div align="left"><font color="block" size="3" >Report No: 5.4</font></div>-->
				<font color="block" size="3" ><b>Fuel Report</b></font>
			</td>
		</tr>
		<tr>
			<td>
<%
String exportFileName="FuelReport.xls";
String date1,date2,datenew1,datenew2="", tbname,km;
final String dateformat=session.getAttribute("dateformat").toString();
final String startDate=request.getParameter("data");
final String endDate=request.getParameter("data1");
 String vehicleRegistrationNumber="";
final String owner=session.getAttribute("usertypevalue").toString();
String vehicleCode="";
boolean showTableDate=false;
datenew1=request.getParameter("data");
datenew2=request.getParameter("data1");
if(!(null==request.getParameter("vehicleRegistrationNumber")))
{
vehicleRegistrationNumber=request.getParameter("vehicleRegistrationNumber");
}
if(!(null == request.getQueryString()))
{
	showTableDate=true;
	vehicleRegistrationNumber=request.getParameter("vehicleRegistrationNumber");
//	System.out.println("xxxxxxxxVehRegNo Selected xxxxxxxxx-> "+vehicleRegistrationNumber);
}
if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
}
else
{
	date1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
	date2=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));
}
date1=date1+" 00:00:00";
date2=date2+" 23:59:59";
List<VehicleRegistrationNumberList> vehicleList = null;
%>
	<form action="" method="get" onsubmit="return validate();">
		<table border="0" width="100%">
			<tr bgcolor="#87CEFA">
			  <td></td><td>
	      	   <font size="2"><b>Vehicle No:</b></font>
					<select name="vehicleRegistrationNumber" id="vehicleRegistrationNumber">
					<option value="Select">Select</option>
<%
						String vehicleRegistrationNumberOfSelectedVehicle = "";
						try{
							
							int numRecords = 0;
							try {
								vehicleList = vehicleDao.getVehicleRegistrationNumberList("fuel"+session.getAttribute("VehList").toString());
								numRecords = vehicleList.size();
								//System.out.println("*** veh list count==>"+numRecords);
							} catch (Exception e) {
								e.printStackTrace();
							}
							for (int counter = 0; counter < numRecords; counter++)
							{
								final VehicleRegistrationNumberList currentRecord = vehicleList.get(counter);
								
								final String displayValue = currentRecord.getVehicleRegistrationNumber();
								String isSelected = "";
								
								if (vehicleRegistrationNumber.equals(vehicleRegistrationNumberOfSelectedVehicle))
								{
									isSelected = "Selected";
									vehicleRegistrationNumberOfSelectedVehicle = displayValue;
								}
%>
								<option value="<%=displayValue%>" <%=isSelected%>><%=displayValue%></option>
<%
							}
						}catch (Exception e) {
						} 
%>
						</select>				
				</td>
			<td align="right"><b>From&nbsp;&nbsp;</b>
			  <input type="text" id="data" name="data" value="<%=datenew1 %>" size="15" readonly/>
			  <script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",      // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
			<td align="right"><b>To&nbsp;&nbsp;</b>
			  	<input type="text" id="data1" name="data1" value="<%=datenew2 %>"  size="15" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "data1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
			<td>
				<input type="submit" name="submit" id="submit" value="submit" >
			</td>
		</tr>
		</table>
		</form>
		
		</td></tr></table>
		<form id="Total_os" name="Total_os" action="" method="post">

<table border="0" bgcolor="white" width="100%">
	<tr>
		<td>
		<table width=100%>
			<tr>
				<td align="right"><input type="hidden" id="tableHTML"
					name="tableHTML" value="" /> <input type="hidden" id="fileName"
					name="fileName" value="<%= exportFileName%>" /> <a href="#"
					style="font-weight: bold; color: black;"
					onclick="gotoPrint('mytable');"> <img src="images/print.jpg"
					width="15px" height="15px" style="border-style: none"></img> </a> <a
					href="#" style="font-weight: bold; color: black;"
					onclick="gotoExcel('mytable', 'tableHTML');"> <img
					src="images/excel.jpg" width="15px" height="15px"
					style="border-style: none"></img> </a></td>
			</tr>
		</table>

		<div id="mytable">
		
<%
			if(showTableDate)
			{
			
%>
          <table border="0" width="100%">
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding" align="center"><font size="3">The Fuel Report for Vehicle <%=vehicleRegistrationNumber %> from <%=datenew1 %> to <%=datenew2 %></font></div>
						</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
				<th> <b> Sr. </b></th>
				<th> <b>VehID.</b></th>
				
				<th> <b>Date-Time</b></th>
				<th> <b>Driver</b></th>
				 <th> 
<%			
	      			if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{
%>
						 <b> Gallons: </b>
<%					}
					else
					{
%>
					<b> Liters: </b>
<%
					}
%>
	      	</th>
	      	<th> <b>Odometer</b></th>
				 <th> 
	       <%
	      if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
		  {
%>				<b> Gas Station:</b> 
<%	   	  }
		  else
		  {%>
				<b> Petrol Pump:</b> 
<%
		   }%>
	      	</th>
				<th> <b>Ent By</b></th>
			</tr>
			<%
			String trans="";
			double Avg=0.00;

				int i=1;
				int totdist=0;
				double fueladded=0,totfuel=0;
				String tabname="";
				List<FuelInfoVehicleList> list=null;
				try{
					int numRecords = 0;
					try {
						list = vehicleDao.getFuelInfoVehicleDetails(vehicleRegistrationNumber
								,date1,date2);
						numRecords = list.size();
					} catch (Exception e) {
						e.printStackTrace();
					}
					if(numRecords>0)
					for (int counter = 0; counter < numRecords; counter++)
					{
					final FuelInfoVehicleList currentRecord = list.get(counter);
				//	System.out.println(currentRecord.getVehicleCode());
				//	System.out.println("##################Driver");
				//	System.out.println(currentRecord.getDriver());
					if(!(null==currentRecord.getVehicleCode()))
						vehicleCode=currentRecord.getVehicleCode();
					if(!("-").equalsIgnoreCase(currentRecord.getLiters()))
					{
						fueladded=Double.parseDouble(currentRecord.getLiters());
						totfuel+=fueladded;
					
					
%>		
			<tr>
				<td style="text-align: right"> <%=i++ %></td>
				<td style="text-align: left"> <%=vehicleRegistrationNumber %></td>
<%
					String datef=new SimpleDateFormat(dateformat+" HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(currentRecord.getTheDateTime()));
%>
				<td style="text-align: right"> <%=datef %></td>
				<td style="text-align: left"> <%=currentRecord.getDriver() %></td>
				<td ><div align="right">
<%
					if(session.getAttribute("fuelformat").toString().equalsIgnoreCase("Gal"))
					{ 
%>
				 			<%=(int) (Double.parseDouble(currentRecord.getLiters())/3.78541178)%>
<%
					}else{ 
%>
				 			<%=currentRecord.getLiters()%>
<% 
					}
%>
				 </div></td>
				<td style="text-align: right"> <%=currentRecord.getOdodmeterReading()%></td>
				<td style="text-align: left"> <%=currentRecord.getPetrolPump() %></td>
				<td style="text-align: left"> <%=currentRecord.getEnteredBy()%></td>
			</tr>	
			
<%}
				}
%>
			<tr>
				<td colspan="4" align="center"><font size="2"><b>Total</b></font></td>	
				<td ><div align="right"><font size="2"><b><%=totfuel %></b></font></div></td>
				<td align="right"><font size="2"><b>-</b></font></td>
				<td align="right"><font size="2"><b>-</b></font></td>
				<td align="right"><font size="2"><b>-</b></font></td>
			</tr>
			</table>

			
<%
	}
	catch(Exception e)
	{
	}
}
%>
</div></td></tr></table></form>
</body>
</html>
        <%@ include file="footernew.jsp" %>