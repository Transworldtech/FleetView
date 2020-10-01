<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@page import="com.transworld.fleetview.framework.VehicleDao"
		import="com.transworld.fleetview.framework.VehiclewiseTrips"
		import="com.transworld.fleetview.framework.VehicleRegistrationNumberList"  %>
		
		
<jsp:useBean id="vehicleDao" 
			 type="com.transworld.fleetview.framework.VehicleDao"
			 scope="application"></jsp:useBean>
		

<html>
<head>
<title>Vehicle Tracking System</title>
</head>
<body bgcolor="lightyellow">
<table border="0" cellspacing="0" cellpadding="0" width="100%">
       
			<%@ include file="headernew.jsp" %> 
			
			<!-- body part come here -->
			<%
			String data="",data1="",vehicleCode="",vehicleRegistrationNumber="";		
			%>
			<%
			
			NumberFormat nf = DecimalFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2); 
				
			%>
			<table width="100%" align="center" class="stats">
			<tr>
			<td align="center" class="sorttable_nosort"><font color="block" size="2" >Vehicle Wise Trip Report</font></td>
			</tr>
			<tr><td>
			<script language="javascript">
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
			dy1=date1.substring(0,4);
			dy2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
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
  	<form action="" method="get" onsubmit="return validate();">
			<table border="0" width="100%" class="sortable_entry">
			
			<tr bgcolor="#87CEFA">
			<td><b>Vehicle :</b> 
				<select name="vehicle" id="vehicle">
				<%
				List<VehicleRegistrationNumberList> list=null;
				int numRecords = 0;
				try{
				
					list = vehicleDao.getVehicleRegistrationNumberList(session.getAttribute("VehList").toString());
					 numRecords = list.size();
					 
				} catch(Exception e){
					e.printStackTrace();
				}
				
				
				
				try{
						String dd=request.getQueryString();
						if(!(null==dd))
						{
							data=request.getParameter("data");
							data1=request.getParameter("data1");
							
						}
						else
						{
							data=data1=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
						}
						for(int counter=0;counter<numRecords;counter++)
						{
							VehicleRegistrationNumberList vehicleRecord=list.get(counter);
						%>
						<option value="<%=vehicleRecord.getVehicleCode()%>,<%=vehicleRecord.getVehicleRegistrationNumber()%>"><%=vehicleRecord.getVehicleRegistrationNumber()%></option>						
						<%
						}		
					}catch(Exception e)
					{
						out.print("Exception---->"+e);
					}				
				%>			
				</select>
			</td>
			<td align="right"><b>From&nbsp;&nbsp;</b>
			  <input type="text" id="data" name="data"  value="<%=data%>" size="20" readonly/>
  			<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",     // the date format
      			button      : "data"       // ID of the button
    			}
  				);	
				</script>
  			</td>
			<td align="right"><b>To&nbsp;&nbsp;</b>
			  	<input type="text" id="data1" name="data1"  value="<%=data1%>" size="20" readonly/>
			  	<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%Y-%m-%d",    // the date format
      			button      : "data1"       // ID of the button
    			}
  				);
				</script>
			  	</td>
			<td>
				<input type="submit" name="Submit" id="submit" value="Submit">
			</td>
		</tr>
		
		</table>
		</form>
		
		</td></tr>
		<%
		
		try
			{
			if(!(null==request.getQueryString()))
			{	
				String ss=request.getParameter("vehicle");
				System.out.println("ss"+ss);
				StringTokenizer stk = new StringTokenizer(ss,",");
				vehicleCode=stk.nextToken();
				vehicleRegistrationNumber=stk.nextToken();	
				
				List<VehiclewiseTrips> vehicleList=null;
				int recordCount = 0;
				try{
				
					vehicleList = vehicleDao.getVehiclewiseTrips(vehicleCode,data,data1);
					recordCount = list.size();
					 
				} catch(Exception e){
					System.out.println("++++++*********+++++++");
					e.printStackTrace();
				}
		%>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font size="3">The Trip Report for Vehicle <%=vehicleRegistrationNumber%> from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(data1))%></font></div>
				<div align="right">
				<a href="#" onclick="javascript:window.open('printvehiclewisetrips.jsp?data=<%=data%>&data1=<%=data1%>&vehicle=<%=ss%>');" title="Print Report"><img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; 
				<a href="excelvehiclewisetrips.jsp?data=<%=data%>&data1=<%=data1%>&vehicle=<%=ss%>"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
				<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
				</div>
			</td>
			</tr>
			</table>
			<table width="100%" border="1" align="center" class="sortable">
			<tr>
			<th class="hed"> Sr.</th>
			<th class="hed"> Trip Id</th>
			<th class="hed"> Start Date</th>
			<th class="hed"> Origin</th>
			<th class="hed"> End Date</th>
			<th class="hed"> Destination</th>
			<th class="hed"> OS</th>
			<th class="hed"> RA</th>
			<th class="hed"> RD</th>
			<th class="hed"> CD</th>
			<th class="hed"> DT</th>
			<th class="hed"> Run. Hrs</th>
			<th class="hed"> ND</th>
			<th class="hed"> Rating</th>
			</tr>		
			<%
			int i=0;
			if(recordCount>0){
			for(int count=0;count<recordCount;count++)
			{
				System.out.println("++++++*IN FOR*+++++++");
				final VehiclewiseTrips currentRecord=vehicleList.get(count);
				i=count+1;
				%>
			<tr>
			<td style="text-align: right"><%=i%></td>
			<td style="text-align: center"><%=currentRecord.getTripId()%></td>
			<td style="text-align: left"><%=currentRecord.getTripStartDate()%></td>
			<td style="text-align: left"><%=currentRecord.getTripOrigin()%></td>
			<td style="text-align: left"><%=currentRecord.getTripEndDate()%>			</td>
			<td ><%=currentRecord.getTripDestination()%></td>
			<td ><div align="right"><%=currentRecord.getOverspeedDuration()%></div></td>
			<td><div align="right"><%=currentRecord.getRapidAccelerationCount()%></div></td>
			<td><div align="right"><%=currentRecord.getRapidDeccelerationCount()%></div></td>
			<td><div align="right"><%=currentRecord.getContinuousDrivingCount()%></div></td>
			<td><div align="right"><%=currentRecord.getDistanceTravelled()%></div></td>
			<td><div align="right"><%=currentRecord.getRunHours()%></div></td>
			<td><div align="right"><%=currentRecord.getNightDrivingCount()%></div></td>
			<td><div align="right"><%=currentRecord.getRating()%></div></td>
			</tr>				
				<%
			}//for end
			}
			}			
			%>
			</table>
			<%
			}catch(Exception e)
			{	
				e.printStackTrace();
			}			
			%>
			</td>
    
    </tr>
    <!--<tr>
       <td width="1%"><img src="images/fboxbottomleft.gif" width="20" height="20" alt="bk" /></td>
       <td width="98%" class="fboxbottom"><img src="images/spacer.gif" width="2" height="2" alt=" " /></td>
       <td width="1%"><img src="images/fboxbottomright.gif" width="20" height="20" alt="bk" /></td>
    </tr>-->
    </table>
        <%@ include file="footernew.jsp" %>
    </body>
</html>